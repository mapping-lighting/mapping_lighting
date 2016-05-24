# require 'pandoc-ruby'

require 'rake/clean'
CLEAN.include(Rake::FileList['doc/build/*'])

namespace :doc do
  desc 'Generate All Documentation Manuals'
  task :manuals => [
      :clean,
      "Installation Manual",
  ]

  task "Installation Manual"  do |t|

    filenames = ['doc/src/installation.md']
    docname = 'doc/build/Installation.docx'

    current_version = %x(git show -s --format="%h" 2>&1).chomp

    pandoc_command = "pandoc \
      --self-contained \
      --standalone \
      --output #{docname} \
      --toc \
        #{filenames.join(" ")}"

    sh pandoc_command

    sh "open #{docname}"
  end
end
