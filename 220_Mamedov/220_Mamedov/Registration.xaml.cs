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
    /// Логика взаимодействия для Registration.xaml
    /// </summary>
    public partial class Registration : Window
    {
        public Registration()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            var ctx = ExamEntities.GetContext();
            if (string.IsNullOrWhiteSpace(LoginInput.Text))
            {
                MessageBox.Show("Логин должен быть заполнен");
                return;
            }
            if (string.IsNullOrWhiteSpace(PasswordInput.Password))
            {
                MessageBox.Show("Пароль должен быть заполнен");
                return;
            }
            if (ctx.Accounts.Any(x => x.Login == LoginInput.Text))
            {
                MessageBox.Show("Логин занят");
                return;
            }

            if (!AccChecker.IsChecked.Value)
            {
                if (string.IsNullOrWhiteSpace(GroupInput.Text))
                {
                    MessageBox.Show("Группа должна быть заполнена");
                    return;
                }
                if (string.IsNullOrWhiteSpace(SurnameInput.Text))
                {
                    MessageBox.Show("Фамилия должна быть заполнена");
                    return;
                }
                if (string.IsNullOrWhiteSpace(NameInput.Text))
                {
                    MessageBox.Show("Имя должно быть заполнено");
                    return;
                }
            }

            var account = new Accounts();
            account.Login = LoginInput.Text;
            account.Password = PasswordInput.Password;
            account.IsTeacher = AccChecker.IsChecked.Value;
            ctx.Accounts.Add(account);
            ctx.SaveChanges();

            if (!AccChecker.IsChecked.Value)
            {
                var student = new Students();
                student.Name = NameInput.Text;
                student.Surname = SurnameInput.Text;
                student.Patronymic = PatronymicInput.Text;
                student.StudyGroup = GroupInput.Text;
                ctx.Students.Add(student);
                ctx.SaveChanges();

                ctx.Accounts.ToList().Last().StudentId = ctx.Students.ToList().Last().Id;
                ctx.SaveChanges();
            }
            MessageBox.Show("Регистрация успешна!");
            this.Close();
        }

        private void AccChecker_Clicked(object sender, RoutedEventArgs e)
        {
            if (AccChecker.IsChecked.Value)
            {
                PatronymicLabel.Visibility = Visibility.Hidden;
                PatronymicInput.Visibility = Visibility.Hidden;
                SurnameInput.Visibility = Visibility.Hidden;
                SurnameLabel.Visibility = Visibility.Hidden;
                NameLabel.Visibility = Visibility.Hidden;
                NameInput.Visibility = Visibility.Hidden;
                GroupInput.Visibility = Visibility.Hidden;
                GroupLabel.Visibility = Visibility.Hidden;
            }
            else
            {
                PatronymicLabel.Visibility = Visibility.Visible;
                PatronymicInput.Visibility = Visibility.Visible;
                SurnameInput.Visibility = Visibility.Visible;
                SurnameLabel.Visibility = Visibility.Visible;
                NameLabel.Visibility = Visibility.Visible;
                NameInput.Visibility = Visibility.Visible;
                GroupInput.Visibility = Visibility.Visible;
                GroupLabel.Visibility = Visibility.Visible;
            }
        }
    }
}
