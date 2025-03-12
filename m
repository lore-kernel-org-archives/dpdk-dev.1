Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43BEC28B30
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 992FD40E0F;
	Thu, 13 Mar 2025 00:17:28 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 703C84025D
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:27 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2239aa5da08so6625935ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821446;
 x=1742426246; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRVkWanDu++5rr6M2yo7H/RqGliIDt0WcYsW++/MGH8=;
 b=mw6/hHlAlirEChoRbBRmP8ISvSyYyv3QS5izi99yCs8aPm99Ih5Um1140zlOCq8As9
 qDcwCtIFZ91XoIAvSMkwgmCRv+6manC3DdRLQ6WGcL49Da9+l6efw3IHuDG5mj9W6nDj
 sqyj8H3i3aI8McHN17UKgPks8bXSkt3q5jYpUDqPj9LsL7JUfSG+w3wJU48SIccUbd5C
 rXMYNKkDN09bYGLR5STsbHTGo6NA4ZE/xA6ltxv2re3qM9RjXVVV4BUvOq0HCZe60FcH
 LSC9ovZWOwXznTFHlIUso2klCe2qNzlgITfb1aRBhlYRPeZttdg63kfcCzjg5f1jyhvE
 zxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821446; x=1742426246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRVkWanDu++5rr6M2yo7H/RqGliIDt0WcYsW++/MGH8=;
 b=YFpKSb/pCohj83szujLEUpBtiAf6Hk/bJkqs7enPfAZ3ssGttxECTVVqSmwGaycwYr
 c7bCFhIzxNOR3hWxkw8MZict1Cz3QKsMJrIvHjtddmtO1GE4GvsARlxA38uqrZGRy3WJ
 J8Vu5O+uL67MLzuXT6pwOo47UOuudEXS+qNrvxIMaAAhQEY3QehFPhnSFSpdKFXn7l19
 2Ej+WvlBT1FZlIHWsmbradRRKmHVNGbDwJYT4R+tKHNtaAn7V/b6d+/dEwpy0kjvbhWb
 +x0u0gEDUrgbk+FNeI8v4rmaVY4i7gWEoUI+sGJl/PqKivlcboh748Bm2hApxd9ecgNw
 mi7Q==
X-Gm-Message-State: AOJu0YwWZXvkRHxcIyMlDbeGJ2UtyjXBbgqMdYvANIvsvK6ZqIlB5kNz
 ZNT9dLqqDv5QSijfVoaexbgtx7IezSq5Y8ZU37f3NbNkZFNe+7bvGAglPS/H66Gd20oiuj8NH1/
 T
X-Gm-Gg: ASbGncuQLzVkk/t4GEDwuk4VpTVZAC79lcEOjnXORGrfXu9KLaG1JqqqZra6HsniiZP
 D5nFrAhJtjUiVPQDU1ny9u+E3F58AVGfvOSI8DK6HyW/NOVXawDqw61mvWcOqI9ffiUsvxlajlK
 FL+s1Dz/2FB4T4u3baWrXnvjwgXDcRFqWElPLQ6l3J4hCDHf8pp8yUcmQgXWkqrgwaWgl8tIzY3
 /3qyRYtXRop0AcW9m9V5RUASDK8cr9A4DFIjy7OwNhpKCaT65Hgvmic1hyYFW93F/6ok2PLCFf0
 TeOvbcotoFNfuYtx+W/hCFqmpDhYfR9vdzfcwK+CXQH0iNe2ZPJ2aiinU2Hugddkt+47MIwflfC
 hzn5GD8Rkv27BRd/tjoJsrA==
X-Google-Smtp-Source: AGHT+IFW1ZORj4UbKfa3yyr2nNYJEYkCcjGyEPS7uzdcjEuxFNO4JY4oPB3tYaTja+M+ELoKumUUIg==
X-Received: by 2002:a17:902:ce0a:b0:221:85:f384 with SMTP id
 d9443c01a7336-2242889b34emr357606495ad.16.1741821446377; 
 Wed, 12 Mar 2025 16:17:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 1/9] eal: add queue macro extensions from FreeBSD
Date: Wed, 12 Mar 2025 16:15:30 -0700
Message-ID: <20250312231715.222149-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The Linux version of sys/queue.h is frozen at an older version
and is missing the _SAFE macro variants. Several drivers started
introducing the own workarounds for this. Should be handled in EAL.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/meson.build |   3 +-
 lib/eal/include/rte_queue.h | 174 ++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 lib/eal/include/rte_queue.h

diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index d903577caa..75bf09381f 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -19,8 +19,8 @@ headers += files(
         'rte_eal.h',
         'rte_eal_memconfig.h',
         'rte_eal_trace.h',
-        'rte_errno.h',
         'rte_epoll.h',
+        'rte_errno.h',
         'rte_fbarray.h',
         'rte_hexdump.h',
         'rte_hypervisor.h',
@@ -38,6 +38,7 @@ headers += files(
         'rte_pci_dev_features.h',
         'rte_per_lcore.h',
         'rte_pflock.h',
+        'rte_queue.h',
         'rte_random.h',
         'rte_reciprocal.h',
         'rte_seqcount.h',
diff --git a/lib/eal/include/rte_queue.h b/lib/eal/include/rte_queue.h
new file mode 100644
index 0000000000..7ec807b15d
--- /dev/null
+++ b/lib/eal/include/rte_queue.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Original Copyright (c) 1991, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ */
+
+#ifndef _RTE_QUEUE_H_
+#define _RTE_QUEUE_H_
+
+/**
+ * @file
+ *  Defines macro's that exist in the FreeBSD version of queue.h
+ *  which are missing in other versions.
+ */
+
+#include <sys/queue.h>
+
+/*
+ * This file defines four types of data structures: singly-linked lists,
+ * singly-linked tail queues, lists and tail queues.
+ *
+ * Below is a summary of implemented functions where:
+ *  o  means the macro exists in original version
+ *  +  means the macro is added here
+ *  -  means the macro is not available
+ *  s  means the macro is available but is slow (runs in O(n) time)
+ *
+ *				SLIST	LIST	STAILQ	TAILQ
+ * _HEAD			o	o	o	o
+ * _HEAD_INITIALIZER		o	o	o	o
+ * _ENTRY			o	o	o	o
+ * _INIT			o	o	o	o
+ * _EMPTY			o	o	o	o
+ * _FIRST			o	o	o	o
+ * _NEXT			o	o	o	o
+ * _FOREACH			o	o	o	o
+ * _FOREACH_FROM		+	+	+	+
+ * _FOREACH_SAFE		+	+	+	+
+ * _FOREACH_FROM_SAFE		+	+	+	+
+ * _FOREACH_REVERSE		-	-	-	o
+ * _FOREACH_REVERSE_FROM	-	-	-	+
+ * _FOREACH_REVERSE_SAFE	-	-	-       +
+ * _FOREACH_REVERSE_FROM_SAFE	-	-	-	+
+ * _INSERT_HEAD			o	o	o	o
+ * _INSERT_BEFORE		-	o	-	o
+ * _INSERT_AFTER		o	o	o	o
+ * _INSERT_TAIL			-	-	o	o
+ * _CONCAT			s	s	o	o
+ * _REMOVE_AFTER		o	-	o	-
+ * _REMOVE_HEAD			o	o	o	o
+ * _REMOVE			s	o	s	o
+ *
+ */
+
+
+/*
+ * Singly-linked List declarations.
+ */
+#ifndef SLIST_FOREACH_FROM
+#define	SLIST_FOREACH_FROM(var, head, field)				\
+	for ((var) = ((var) ? (var) : SLIST_FIRST((head)));		\
+	    (var);							\
+	    (var) = SLIST_NEXT((var), field))
+#endif
+
+#ifndef SLIST_FOREACH_SAFE
+#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = SLIST_FIRST((head));				\
+	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+#ifndef SLIST_FOREACH_FROM_SAFE
+#define	SLIST_FOREACH_FROM_SAFE(var, head, field, tvar)			\
+	for ((var) = ((var) ? (var) : SLIST_FIRST((head)));		\
+	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+
+/*
+ * Singly-linked Tail queue declarations.
+ */
+#ifndef STAILQ_FOREACH_FROM
+#define	STAILQ_FOREACH_FROM(var, head, field)				\
+	for ((var) = ((var) ? (var) : STAILQ_FIRST((head)));		\
+	   (var);							\
+	   (var) = STAILQ_NEXT((var), field))
+#endif
+
+#ifndef STAILQ_FOREACH_SAFE
+#define	STAILQ_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = STAILQ_FIRST((head));				\
+	    (var) && ((tvar) = STAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+#ifndef STAILQ_FOREACH_FROM_SAFE
+#define	STAILQ_FOREACH_FROM_SAFE(var, head, field, tvar)		\
+	for ((var) = ((var) ? (var) : STAILQ_FIRST((head)));		\
+	    (var) && ((tvar) = STAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+/*
+ * List declarations.
+ */
+#ifndef LIST_FOREACH_FROM
+#define	LIST_FOREACH_FROM(var, head, field)				\
+	for ((var) = ((var) ? (var) : LIST_FIRST((head)));		\
+	    (var);							\
+	    (var) = LIST_NEXT((var), field))
+#endif
+
+#ifndef LIST_FOREACH_SAFE
+#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+#ifndef LIST_FOREACH_FROM_SAFE
+#define	LIST_FOREACH_FROM_SAFE(var, head, field, tvar)			\
+	for ((var) = ((var) ? (var) : LIST_FIRST((head)));		\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+/*
+ * Tail queue declarations.
+ */
+#ifndef TAILQ_FOREACH_FROM
+#define TAILQ_FOREACH_FROM(var, head, field)				\
+	for ((var) = ((var) ? (var) : TAILQ_FIRST((head)));		\
+	    (var);							\
+	    (var) = TAILQ_NEXT((var), field))
+#endif
+
+#ifndef TAILQ_FOREACH_SAFE
+#define TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = TAILQ_FIRST((head));				\
+	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+#ifndef TAILQ_FOREACH_FROM_SAFE
+#define TAILQ_FOREACH_FROM_SAFE(var, head, field, tvar)			\
+	for ((var) = ((var) ? (var) : TAILQ_FIRST((head)));		\
+	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
+#ifndef TAILQ_FOREACH_REVERSE_FROM
+#define TAILQ_FOREACH_REVERSE_FROM(var, head, headname, field)		\
+	for ((var) = ((var) ? (var) : TAILQ_LAST((head), headname));	\
+	    (var);							\
+	    (var) = TAILQ_PREV((var), headname, field))
+#endif
+
+#ifndef TAILQ_FOREACH_REVERSE_SAFE
+#define TAILQ_FOREACH_REVERSE_SAFE(var, head, headname, field, tvar)	\
+	for ((var) = TAILQ_LAST((head), headname);			\
+	    (var) && ((tvar) = TAILQ_PREV((var), headname, field), 1);	\
+	    (var) = (tvar))
+#endif
+
+#ifndef TAILQ_FOREACH_REVERSE_FROM_SAFE
+#define TAILQ_FOREACH_REVERSE_FROM_SAFE(var, head, headname, field, tvar)\
+	for ((var) = ((var) ? (var) : TAILQ_LAST((head), headname));	\
+	    (var) && ((tvar) = TAILQ_PREV((var), headname, field), 1);	\
+	    (var) = (tvar))
+#endif
+
+#endif /* !_RTE_QUEUE_H_ */
-- 
2.47.2

