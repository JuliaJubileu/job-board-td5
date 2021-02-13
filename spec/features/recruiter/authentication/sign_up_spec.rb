require 'rails_helper'

feature 'Recruiter signs up' do
    scenario 'from the home page' do
        visit root_url

        expect(page).to have_link 'Cadastre-se'
    end

    scenario 'successfully' do
        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: 'tr4b4lh0'
            fill_in 'Confirme a senha', with: 'tr4b4lh0'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('rh@treinadev.com.br')
        expect(page).to have_content('Painel do recrutador')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Cadastre-se')
    end

    scenario 'and password can not be blank' do
        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: ''
            fill_in 'Confirme a senha', with: ''
            click_on 'Cadastrar'
        end

        expect(page).to have_content('não pode ficar em branco')
        expect(page).to have_link('Cadastre-se')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_content('Painel do Recrutador')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and password must match confirmation' do
        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: 'tr4b4lh0'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('não é igual a senha')
        expect(page).to have_link('Cadastrar')
        expect(page).not_to have_content('rh@treinadev.com.br')
        expect(page).not_to have_content('Painel do Recrutador')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email must be valid' do
        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh'
            fill_in 'Senha', with: 'tr4b4lh0'
            fill_in 'Confirme a senha', with: 'tr4b4lh0'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('não é válido')
        expect(page).to have_link('Cadastrar')
        expect(page).not_to have_content('Painel do Recrutador')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and email can not be at use' do
        recruiter = Recruiter.create!(email: 'rh@treinadev.com.br', password: 'tr4b4lho')

        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'rh@treinadev.com.br'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('já está em uso')
        expect(page).to have_link('Cadastrar')
        expect(page).not_to have_content('Painel do Recrutador')
        expect(page).not_to have_link('Sair')
    end

    scenario 'and must be corporate email' do
        visit root_url
        click_on 'Cadastre-se'
        within('form') do
            fill_in 'E-mail', with: 'julia@gmail.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme a senha', with: '123456'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('não é e-mail corporativo')
        expect(page).to have_link('Cadastrar')
        expect(page).not_to have_content('Painel do Recrutador')
        expect(page).not_to have_link('Sair')
    end
end