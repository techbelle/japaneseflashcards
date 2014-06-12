## form.html
<%inherit file="base.mako"/>

<%!
  title = 'Japanese Flashcards'
%>

## Start body.
<h2>Create Flashcard</h2>
${self.create_form()}
<h2>Flashcards</h2>
${self.flashcards_table()}
${self.footer()}
## End body.

<%def name="create_form()">
  <form action="/create" method="POST" enctype="multipart/form-data">
    <table>
      <tr>
        <td>English Word:</td>
        <td><input type="text" name="english"></td>
      </tr>
      <tr>
        <td>Category:</td>
        <td><input type="text" name="category"></td>
      </tr>
      <tr>
        <td>Chapter:</td>
        <td><input type="text" name="chapter"></td>
      </tr>
      <tr>
        <td>Kana:</td>
        <td><input type="text" name="kana"></td>
      </tr>
      <tr>
        <td>Kanji:</td>
        <td><input type="text" name="kanji"></td>
      </tr>
      <tr>
        <td>Romanji:</td>
        <td><input type="text" name="romanji"></td>
      </tr>
      <tr>
        <td></td>
        <td>
          <input type="submit" value="Insert Flashcard" onclick="toggle('spinner');">
          <img src="/static/images/spinner.gif" id="spinner" style="display: none;">
        </td>
      </tr>
    </table>
  </form>
</%def>

<%def name="flashcards_table()">
  <table id="cards">
    <tr>
        <th>English</th>
        <th>Category</th>
        <th>Chapter</th>
        <th>Kana</th>
        <th>Kanji</th>
        <th>Romanji</th>
    </tr>
  %for card in cards:
    <tr>
      <td class="">
        ${card['english']}
      </td>
      <td class="">
        ${card['category']}
      </td>
      <td class="">
        ${int(card['chapter'])}
      </td>
      <td class="">
        ${card['kana']}
      </td>
      <td class="">
        ${card['kanji']}
      </td>
      <td class="">
        ${card['romanji']}
      </td>
    </tr>
  %endfor
  </table>
</%def>

<%def name="footer()">
  <div id="navigation">
    %if prev_page is not None:
    <a href="/list/${prev_page}">&lt; Prev</a>
    %endif
    %if next_page is not None:
    <a href="/list/${next_page}">Next &gt;</a>
    %endif
  </div>
</%def>
