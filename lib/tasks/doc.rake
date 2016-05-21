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
    docname = 'doc/build/Installation.pdf'

    # pandoc
    #
    # --number-sections
    # --template=mytemplate.tex \
    # --variable mainfont="Palatino"  \
    # --variable sansfont="Century Gothic" \
    # --variable monofont="Consolas" \
    # --variable fontsize=12pt \
    # --variable version=1.15.2 \
    # README
    # --latex-engine=xelatex \
    # --toc \
    # --output #{docname}
    # --variable mainfont=\"Palatino\"  \
    #   --variable sansfont=\"Century Gothic\" \
    #   --variable monofont=\"Menlo\"


    #current_version = %x(git show -s --format="%h - %ci" 2>&1).chomp
    current_version = %x(git show -s --format="%h" 2>&1).chomp
    
    


    pandoc_command = "pandoc \
      --template=mytemplate2.tex \
      --number-sections \
      --variable fontsize=12pt \
      --variable monofont=Menlo \
      --variable version=#{current_version} \
      --self-contained \
      --standalone \
      --output #{docname} \
      --toc \
        #{filenames.join(" ")}"

    sh pandoc_command

    sh "open #{docname}"
  end
end


# pandoc --template=mytemplate.tex --number-sections --variable fontsize=12pt --self-contained --standalone --output doc/build/Installation.pdf --toc   doc/src/installation.md
