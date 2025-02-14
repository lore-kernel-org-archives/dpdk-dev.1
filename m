Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C9EC02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53B5240672;
	Fri, 14 Feb 2025 18:21:47 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id C328A4066E
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:46 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220e6028214so33815345ad.0
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553706;
 x=1740158506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRVkWanDu++5rr6M2yo7H/RqGliIDt0WcYsW++/MGH8=;
 b=17K9vLPNqFWaNWRF8E1dkzzIWVn8boICLAK7JeeYCZfXwiHRdQEO5HBky6khQLjlwD
 wh+rqPstqrrjnYiIP6APopT2JBnNxUsXPALXLbZ4mkBTuhPm74yfvDXzKlvq7S278wy9
 RXMaDdSAft0hCjOADYdh0tVu16+qBUWuLAzYUrANmlx/Wvelyxw/xl8W9/jXDF9zTcgN
 DPVFHJMYkNMJ6MlLivpcqkM8vILXgRD17k8XIjnndCKwn52mS6RYk87AgjzCmh9eVleL
 8JigMYh7kg9Gg3E4lxqsxhH089sTQXrFqFqlpzb1wDNhIQXby+GgYBD1NHOelUCornEi
 lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553706; x=1740158506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRVkWanDu++5rr6M2yo7H/RqGliIDt0WcYsW++/MGH8=;
 b=DV5dUdM+rN+YBAcOt+O2HOQXbOkJZsWbW4zn+twnFcdARUQA9EGbuCN2Um36rVOf0t
 U78bjwvk4cA2S0gOnWb6abwvWaJoVoJUwPdP+BmgZQPCXlHltclo8klDtcJB4zMg9pv8
 a3mJt+rhgIs30OuNTw/jtf/osFo1aweJdsDFaROBDO7AnricJ7EMiwhvS4y9KTfxBzY/
 L3E1llhpOVhRazpfIj1j/cOQG234Bfn72ZUU8CVCN5X8GbWwgZh1gWnCgXR6j7ZTftmv
 vjqGpCEaHwqN3J0jGbrbGffbDOQe5U1jdsybP1g8HH4mJkLmn3eUVwJB3OP3XFa+YZIg
 PP3w==
X-Gm-Message-State: AOJu0Yy4ZM/OFPl+ZF0JOmvzxH+X3tSL/3EUMu4YQ/bSmy5552Zum1yv
 uyUHY0sDeHyL++2vXCWsi/Q8d58R7ryQwijak2KMc/5DHd7oMOKLS3eGrkl5XEmvn6psATAcQt0
 T/x4=
X-Gm-Gg: ASbGncv2QJOZ6GUAsUiypEbHu90fBg+3FzV9dXhdsmvS2PxKRroCCgQp3vPpLvpujw/
 7IAevTPjoqKS1Fdi2gZ9uOiNwUE8MiR8xrpuCGtud2P8lRN+mZynXkq/65Q0hqhAVRelrrjwTFN
 UY+hBpt1mLG0MQD5rwxiE5iDhhjXBmadDaS0P9kVjPthgU1e/smNCoVQAzpR2nmEZh5IHagtvCt
 18ttyl1yRcXa62hxR7HRnstARwkrkh4q6ErB83itLYeGBDMwjnxrtxKisYs3SaCYIBMQu6SD4rJ
 erUorRe/Viuiqo6JI5pyyf+b/X7m2+00g9l63IJXIWti5LbG5v0b89j26Vd/0OYYqSrn
X-Google-Smtp-Source: AGHT+IEzP5YaxkWeWiEB/iOJp6kBv+KN3K9DyhQ6zQ1Jh5FESRTefrvGoWLQGZnBiXcyJCf2Mmo3+g==
X-Received: by 2002:a05:6a00:1816:b0:730:7970:1f8f with SMTP id
 d2e1a72fcca58-732617bfaa2mr222520b3a.12.1739553705861; 
 Fri, 14 Feb 2025 09:21:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Date: Fri, 14 Feb 2025 09:20:09 -0800
Message-ID: <20250214172134.73908-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

