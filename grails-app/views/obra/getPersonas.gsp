<g:if test="${obra?.departamento?.id == persona?.departamento?.id || obra?.id == null}">

    <g:if test="${persona?.departamento?.id == obra?.inspector?.departamento?.id || obra?.id == null}">

        <div class="span1">Inspección</div>

        <div class="span3"><g:select name="inspector.id" class="inspector required" from="${personasRolInsp}" optionKey="id" optionValue="${{ it?.titulo + ' ' + it.nombre + " " + it.apellido }}" value="${obra?.inspector?.id}" title="Persona para Inspección de la Obra"/></div>

    </g:if>
    <g:else>
        <div class="span1">Inspección</div>
        <g:hiddenField name="inspector.id" id="hiddenInspector" value="${obra?.inspector?.id}"/>
        <div class="span3"><g:textField name="inspectorText" class="inspector required" value="${obra?.inspector?.nombre + " " + obra?.inspector?.apellido}" readonly="readonly" title="Persona1 para Inspección de la Obra"/></div>
    </g:else>

    <g:if test="${persona?.departamento?.id == obra?.revisor?.departamento?.id || obra?.id == null}">

        <div class="span1">Revisión</div>

        <div class="span3"><g:select name="revisor.id" class="revisor required" from="${personasRolRevi}" optionKey="id" optionValue="${{ it?.titulo + ' ' + it.nombre + ' ' + it.apellido }}"
                                     value="${obra?.revisor?.id}" title="Persona para la revisión de la Obra"/></div>
    </g:if>
    <g:else>
        <div class="span1" style="margin-left: -30px">Revisión</div>

        <g:hiddenField name="revisor.id" id="hiddenRevisor" value="${obra?.revisor?.id}"/>
        <div class="span3"><g:textField name="revisorText" class="revisor required" value="${obra?.revisor?.nombre + " " + obra?.revisor?.apellido}" readonly="readonly" title="Persona para la revisión de la Obra"/></div>

    </g:else>
    %{--<g:if test="${persona?.departamento?.id == obra?.responsableObra?.departamento?.id || obra?.id == null}">--}%

        %{--<div class="span1">Elaboró presupuesto</div>--}%

        %{--<div class="span1"><g:select name="responsableObra.id" class="responsableObra required" from="${personasRolResp}" optionKey="id" optionValue="${{ it?.titulo + ' ' + it.nombre + ' ' + it.apellido }}"--}%
                                     %{--value="${obra?.responsableObra?.id}" title="Persona responsable de la Obra"/></div>--}%

    %{--</g:if>--}%
    %{--<g:else>--}%

        <div class="span1" style="margin-left: -10px">Elaboró presupuesto</div>

        %{--<g:hiddenField name="responsableObra.id" id="hiddenResponsable" value="${obra?.responsableObra?.id}"/>--}%
        %{--<div class="span3"><g:textField name="responsableText" class="responsable required" value="${obra?.responsableObra?.nombre + " " + obra?.responsableObra?.apellido}" readonly="readonly" title="Persona responsable de la Obra"/></div>--}%


        <g:hiddenField name="responsableObra.id" id="hiddenResponsable" value="${persona?.id}"/>
        <div class="span3"><g:textField name="responsableText" class="responsable" value="${persona?.nombre + " " + persona?.apellido}" readonly="readonly" title="Persona quien Elaboró"/></div>

    %{--</g:else>--}%

</g:if>


<g:else>

    <div class="span1">Inspección</div>

    <g:hiddenField name="inspector.id" id="hiddenInspector" value="${obra?.inspector?.id}"/>
    <div class="span3"><g:textField name="inspector" class="inspector required" value="${obra?.inspector?.nombre + " " + obra?.inspector?.apellido}" readonly="readonly" title="Persona para Inspección de la Obra"/></div>

    <div class="span1" style="margin-left: -30px">Revisión</div>

    <g:hiddenField name="revisor.id" id="hiddenRevisor" value="${obra?.revisor?.id}"/>
    <div class="span3"><g:textField name="revisorText" class="revisor required" value="${obra?.revisor?.nombre + " " + obra?.revisor?.apellido}" readonly="readonly" title="Persona para la revisión de la Obra"/></div>

    %{--<div class="span1">Responsable</div>--}%
    <div class="span1">Elaboró Presupuesto</div>

    <g:hiddenField name="responsableObra.id" id="hiddenResponsable" value="${obra?.responsableObra?.id}"/>
    <div class="span3"><g:textField name="responsableText" class="responsable required" value="${obra?.responsableObra?.nombre + " " + obra?.responsableObra?.apellido}" readonly="readonly" title="Persona responsable de la Obra"/></div>

</g:else>

