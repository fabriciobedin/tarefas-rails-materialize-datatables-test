class TarefasDatatable < ApplicationDatatable
  delegate :edit_tarefa_path, to: :@view

  private

  def data
    tarefas.map do |tarefa|
      [].tap do |column|
        column << tarefa.titulo
        column << tarefa.descricao
        column << tarefa.status

        links = []
        links << link_to('Show', tarefa)
        links << link_to('Edit', edit_tarefa_path(tarefa))
        links << link_to('Destroy', tarefa, method: :delete, data: { confirm: 'Are you sure?' })
        column << links.join(' | ')
      end
    end
  end

  def count
    Tarefa.count
  end

  def total_entries
    tarefas.total_count
    # will_paginate
    # tarefas.total_entries
  end

  def tarefas
    @tarefas ||= fetch_tarefas
  end

  def fetch_tarefas
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    # will_paginate
    # tarefas = Tarefa.page(page).per_page(per_page)
    tarefas = Tarefa.order("#{sort_column} #{sort_direction}")
    tarefas = tarefas.page(page).per(per_page)
    tarefas = tarefas.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(titulo descricao status)
  end

end
