/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entidades;

import java.io.Serializable;

/**
 *
 * @author Andre
 */
public class Produto implements Serializable
{
    private int id;
    private int tipoproduto_id;
    private String nome;
    private String descricao;
    private Double preco_unitario;
    private String unidade;
    private boolean registro_ativo;
    
}