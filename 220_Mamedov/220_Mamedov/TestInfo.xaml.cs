using System;
using System.Collections.Generic;
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
    /// Логика взаимодействия для TestInfo.xaml
    /// </summary>
    public partial class TestInfo : Window
    {
        private int _id;
        public TestInfo(int id)
        {
            _id = id;
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            var context = ExamEntities.GetContext();
            var table = from rep in context.TestReports
                        where rep.Id == _id
                        join qr in context.TestQuestion on rep.Id equals qr.TestId
                        join q in context.Questions on qr.QuestionId equals q.Id
                        select new
                        {
                            rep.Id,
                            q.Text,
                            GivenAnswer = qr.Answer,
                            CorrectAnswer = q.CorrectVariant,
                            Variant1 = q.Var1,
                            Variant2 = q.Var2,
                            Variant3 = q.Var3,
                            Variant4 = q.Var4
                        };
            QuestionsGrid.ItemsSource = table.ToList();
        }
    }
}
