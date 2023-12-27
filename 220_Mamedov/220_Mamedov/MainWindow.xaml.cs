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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace _220_Mamedov
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            new Registration().Show();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            var ctx = ExamEntities.GetContext();
            if(!ctx.Accounts.Any(x => x.Login == LoginInput.Text && x.Password == PasswordInput.Password))
            {
                MessageBox.Show("Неправильный логин или пароль");
                return;
            }
            var account = ctx.Accounts.Where(x => x.Login == LoginInput.Text && x.Password == PasswordInput.Password).First();
            Application.Current.Properties["account_id"] = account.Id;
            if (account.IsTeacher)
            {
                new TeacherWindow().Show();
            }
            else
            {
                new StudentWindow().Show();
            }
            this.Close();
        }
    }
}
