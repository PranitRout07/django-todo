from django.db import models

class Todo(models.Model):
    id = models.BigAutoField(primary_key=True) #automatically increment the integer value and keeps it unique
    title = models.CharField(max_length=100)
    created_at = models.DateTimeField('Created', auto_now_add=True)
    update_at = models.DateTimeField('Updated', auto_now=True)
    isCompleted = models.BooleanField(default=False)

    def __str__(self):
        return self.title
