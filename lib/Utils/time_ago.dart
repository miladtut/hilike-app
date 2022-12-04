class TimeAgo {
  static String chatTimeAgo(DateTime date, {String locale = 'en'}) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if (difference.inHours >= 1) {
      if (date.hour > 12) {
        return "${(24 - date.hour).toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${(locale == 'ar') ? "م" : "pm"}";
      } else {
        return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${(locale == 'ar') ? "ص" : "am"}";
      }
    } else if (difference.inMinutes >= 3) {
      return (locale == 'ar')
          ? 'منذ ${difference.inMinutes} دقائق'
          : '${difference.inMinutes} min. ago';
    } else if (difference.inMinutes >= 2) {
      return (locale == 'ar')
          ? 'منذ دقيقتان'
          : '${difference.inMinutes} min. ago';
    } else if (difference.inMinutes >= 1) {
      return (locale == 'ar') ? 'منذ دقيقة' : '1 min. ago';
    } else {
      return (locale == 'ar') ? 'الآن' : 'Just now';
    }
  }
}
