defmodule Tds.Utils do
  @moduledoc false
  require Logger

  def to_hex_list(x) when is_list(x) do
    Enum.map(x, &Base.encode16(<<&1>>))
  end

  def to_hex_list(x) when is_binary(x) do
    x
    |> :erlang.binary_to_list()
    |> to_hex_list()
  end

  def to_hex_string(x) when is_binary(x) do
    x
    |> to_hex_list()
    |> to_hex_string()
  end

  def to_hex_string(x) when is_list(x) do
    Enum.join(x, " ")
  end

  def to_little_ucs2(str) when is_list(str) do
    str
    |> IO.iodata_to_binary()
    |> to_little_ucs2()
  end

  def to_little_ucs2(str) do
    Tds.Encoding.encode(str, "utf-16le")
  end

  def ucs2_to_utf(s) do
    Tds.Encoding.decode(s, "utf-16le")
  end

  def to_boolean(<<1>>) do
    true
  end

  def to_boolean(<<0>>) do
    false
  end

  def error(error, _s) do
    {:error, error}
  end

  if Kernel.function_exported?(Decimal, :from_float, 1) do
    def to_decimal(float), do: Decimal.from_float(float)
  else
    def to_decimal(float), do: Decimal.new(float)
  end
end
