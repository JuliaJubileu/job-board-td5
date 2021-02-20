require 'rails_helper'

feature 'Recruiter log out of platform' do
    scenario 'successfully' do
        company = Company.create!(name: 'Treina Dev', address: 'Alameda Santos, 1293',
                                  cnpj: '11.222.333/0000-44', website: 'www.treinadev.com.br', 
                                  domain: 'treinadev.com.br')
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lh0', company: company)
        
        visit root_path
        click_on 'Acesso recrutadores'
        within('form') do
            fill_in 'E-mail', with: recruiter.email
            fill_in 'Senha', with: recruiter.password
            click_on 'Entrar'
        end
        click_on 'Sair'

        expect(page).to have_link 'Acesso recrutadores'
        expect(page).not_to have_content recruiter.email
        expect(page).not_to have_link 'Sair'
    end
end