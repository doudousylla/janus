<%@ page import="janus.SubgrupoItems" %>


<form class="form-horizontal">

    <g:if test="${subgrupoItemsInstance?.descripcion}">
        <div class="control-group">
            <div>
                <span id="descripcion-label" class="control-label label label-inverse">
                    Descripción
                </span>
            </div>

            <div class="controls">

                <span aria-labelledby="descripcion-label">
                    <g:fieldValue bean="${subgrupoItemsInstance}" field="descripcion"/>
                </span>

            </div>
        </div>
    </g:if>

    <g:if test="${subgrupoItemsInstance?.codigo}">
        <div class="control-group">
            <div>
                <span id="codigo-label" class="control-label label label-inverse">
                    Código
                </span>
            </div>

            <div class="controls">

                <span aria-labelledby="codigo-label">
                    <g:fieldValue bean="${subgrupoItemsInstance}" field="codigo"/>
                </span>

            </div>
        </div>
    </g:if>

</form>
