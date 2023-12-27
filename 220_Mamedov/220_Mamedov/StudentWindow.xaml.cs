using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace _220_Mamedov
{
    /// <summary>
    /// Логика взаимодействия для StudentWindow.xaml
    /// </summary>
    public partial class StudentWindow : Window
    {
        private int _id;
        public StudentWindow()
        {
            InitializeComponent();
            var context = ExamEntities.GetContext();
            var account_id = ((int)Application.Current.Properties["account_id"]);
            _id = context.Accounts.Where(x => x.Id == account_id).First().StudentId.Value;
            var table = from rep in context.TestReports
                        join qr in context.TestQuestion on rep.Id equals qr.TestId
                        where _id == rep.StudentID
                        group rep by new { rep.Id, rep.StudentID } into grep
                        select new
                        {
                            TestID = grep.Key.Id,
                            TestDate = context.TestReports.Where(x => x.Id == grep.Key.Id).FirstOrDefault().TestDate,
                            RightAnswers = context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count(),
                            QuestionsCount = grep.Count(),
                            Mark = (context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count() / (float)grep.Count()) * 100 + "%"
                        };
            Table.ItemsSource = table.ToList();
        }
        private void Export_Click(object sender, RoutedEventArgs e)
        {
            using (var file = new StreamWriter($"export-student.txt", false))
            {
                StringBuilder sb = new StringBuilder();
                foreach (var item in Table.Items)
                {
                    sb.AppendLine(item.ToString());
                }
                file.Write(sb.ToString());
            }
            MessageBox.Show("Экспорт завершён");
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var context = ExamEntities.GetContext();
            var table = from rep in context.TestReports
                        join qr in context.TestQuestion on rep.Id equals qr.TestId
                        where _id == rep.StudentID
                        group rep by new { rep.Id, rep.StudentID } into grep
                        select new
                        {
                            TestID = grep.Key.Id,
                            TestDate = context.TestReports.Where(x => x.Id == grep.Key.Id).FirstOrDefault().TestDate,
                            RightAnswers = context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count(),
                            QuestionsCount = grep.Count(),
                            Mark = (context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count() / (float)grep.Count()) * 100 + "%"
                        };
            if (!string.IsNullOrWhiteSpace(SearchBox.Text))
            {
                table = table.Where(x => x.TestID.ToString().StartsWith(SearchBox.Text));
            }
            Table.ItemsSource = table.ToList();
        }
        private void View_Click(object sender, RoutedEventArgs e)
        {
            if (Table.SelectedValue != null)
            {
                var id = (int)Table.SelectedValue.GetType().GetProperty("TestID").GetValue(Table.SelectedValue, null);
                new TestInfo(id).Show();
            }
        }
    }
}
