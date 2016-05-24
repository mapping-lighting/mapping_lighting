require 'rake/clean'


MANUAL_FORMAT = 'docx'
# MANUAL_FORMAT = 'html'
CLEAN.include(Rake::FileList["doc/build/*.#{MANUAL_FORMAT}"])

# For each markdown file in the doc/src directory a corresponding word document will be generated.
namespace :doc do
  desc 'Generate All Documentation Manuals'
  task :manuals => [:clean, :generated_manuals]



  MANUAL_FILES = Rake::FileList.new('doc/src/*.md', 'doc/src/*.markdown')
  OUTPUT_FILES = MANUAL_FILES.pathmap("%{/src/,/build/}X.#{MANUAL_FORMAT}").zip(MANUAL_FILES).to_h

  task :generated_manuals => OUTPUT_FILES.keys

  def document_source_file(fname)
    OUTPUT_FILES.fetch(fname) { binding.pry }
  end

  rule ".#{MANUAL_FORMAT}" => ->(f) { document_source_file(f) } do |t|
    pandoc_command = "pandoc \
      --self-contained \
      --standalone \
      --output #{t.name} \
      --toc \
    #{t.source}"

    sh pandoc_command
  end
end
