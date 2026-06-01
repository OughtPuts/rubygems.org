# frozen_string_literal: true

class IncludeRequiredRubyVersionInVersionUniqueness < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    remove_index :versions,
      name: "index_versions_on_rubygem_id_and_number_and_platform",
      column: %i[rubygem_id number platform],
      algorithm: :concurrently

    remove_index :versions,
      name: "index_versions_on_canonical_number_and_rubygem_id_and_platform",
      column: %i[canonical_number rubygem_id platform],
      algorithm: :concurrently

    add_index :versions,
      %i[rubygem_id number platform required_ruby_version],
      unique: true,
      name: "index_versions_on_rubygem_number_platform_ruby",
      algorithm: :concurrently

    add_index :versions,
      %i[canonical_number rubygem_id platform required_ruby_version],
      unique: true,
      name: "index_versions_on_canonical_rubygem_platform_ruby",
      algorithm: :concurrently
  end
end
