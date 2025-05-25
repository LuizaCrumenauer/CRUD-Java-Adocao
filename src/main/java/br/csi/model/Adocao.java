package br.csi.model;

public class Adocao {

    private int id;
    private int cachorroId;
    private int adotanteId;
    private String informacoes;


    public String getInformacoes () {
        return informacoes;
    }

    public void setInformacoes ( String informacoes ) {
        this.informacoes = informacoes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCachorroId() {
        return cachorroId;
    }

    public void setCachorroId(int cachorroId) {
        this.cachorroId = cachorroId;
    }

    public int getAdotanteId() {
        return adotanteId;
    }

    public void setAdotanteId(int adotanteId) {
        this.adotanteId = adotanteId;
    }


}
