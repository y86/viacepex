defmodule ViacepexTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "simple cep request" do
    use_cassette "praca_da_se" do
      address = Viacepex.get!("01001000")
      assert "Praça da Sé" == address.logradouro
    end
  end

  test "cep has an 8 digit format" do
    result = Viacepex.get("123")
    assert {:error, [cep: :incorrect_format]} == result
  end

  test "cep accept integer input" do
    use_cassette "olave_dutra" do
      address = Viacepex.get!(91410490)
      assert "Rua Olavo Dutra" == address.logradouro
    end
  end
end

