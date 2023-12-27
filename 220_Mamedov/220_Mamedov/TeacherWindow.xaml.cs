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
    /// Логика взаимодействия для TeacherWindow.xaml
    /// </summary>
    public partial class TeacherWindow : Window
    {
        public TeacherWindow()
        {
            InitializeComponent();
            var context = ExamEntities.GetContext();
            var table = from rep in context.TestReports
                        join qr in context.TestQuestion on rep.Id equals qr.TestId
                        group rep by new { rep.Id, rep.StudentID } into grep
                        select new
                        {
                            StudentCard = grep.Key.StudentID,
                            Surname = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Surname,
                            Name = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Name,
                            Patronymic = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Patronymic,
                            Group = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().StudyGroup,
                            TestID = grep.Key.Id,
                            RightAnswers = context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count(),
                            QuestionsCount = grep.Count(),
                            Mark = (context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count()/(float)grep.Count()) * 100 + "%"
                        };
            Table.ItemsSource = table.ToList();
        }


        private void Export_Click(object sender, RoutedEventArgs e)
        {
            using (var file = new StreamWriter($"export-teacher.txt", false))
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
                        group rep by new { rep.Id, rep.StudentID } into grep
                        select new
                        {
                            StudentCard = grep.Key.StudentID,
                            Surname = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Surname,
                            Name = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Name,
                            Patronymic = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Patronymic,
                            Group = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().StudyGroup,
                            TestID = grep.Key.Id,
                            RightAnswers = context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count(),
                            QuestionsCount = grep.Count(),
                            Mark = (context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count() / (float)grep.Count()) * 100 + "%"
                        };
            if (!string.IsNullOrWhiteSpace(SearchBox.Text))
            {
                table = table.Where(x => x.Surname.ToString().StartsWith(SearchBox.Text));
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

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            var context = ExamEntities.GetContext();
            if (Table.SelectedValue != null)
            {
                var id = (int)Table.SelectedValue.GetType().GetProperty("TestID").GetValue(Table.SelectedValue, null);
                var entry = context.TestReports.Where(x => x.Id == id).First();
                context.TestReports.Remove(entry);
                context.SaveChanges();
            }
            var table = from rep in context.TestReports
                        join qr in context.TestQuestion on rep.Id equals qr.TestId
                        group rep by new { rep.Id, rep.StudentID } into grep
                        select new
                        {
                            StudentCard = grep.Key.StudentID,
                            Surname = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Surname,
                            Name = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Name,
                            Patronymic = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().Patronymic,
                            Group = context.Students.Where(x => x.Id == grep.Key.StudentID).FirstOrDefault().StudyGroup,
                            TestID = grep.Key.Id,
                            RightAnswers = context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count(),
                            QuestionsCount = grep.Count(),
                            Mark = (context.TestQuestion.Where(x => x.TestId == grep.Key.Id)
                                .Where(x => x.Answer == context.Questions.Where(q => q.Id == x.QuestionId).FirstOrDefault().CorrectVariant).Count() / (float)grep.Count()) * 100 + "%"
                        };
            Table.ItemsSource = table.ToList();
        }
    }
}
