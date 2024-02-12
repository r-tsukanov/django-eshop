from django import forms

class SearchForm(forms.Form):
    search_query = forms.CharField(widget=forms.TextInput(attrs={'type': 'text'}))

