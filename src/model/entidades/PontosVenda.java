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
public class PontosVenda implements Serializable
{

    private int id;
    private String nome;
    private String endereco;
    private int numero;
    private String bairro;
    private int cidade_id;
    private boolean registro_ativo;
    
    
}