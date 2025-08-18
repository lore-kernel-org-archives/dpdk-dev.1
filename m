Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE054CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41D9F4064A;
	Tue, 19 Aug 2025 01:32:41 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 9DEC74060B
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:40 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso23944005e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559960;
 x=1756164760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QA4PiTQQnIgoKKcOURxs/3kETlrm1+00D9JfkDesGfk=;
 b=dyd3j0wY1ncQBtkc8SNTZ4ZZ55viZEvkczaHDM1P9i1LqlJgwTxfd+NrpS4WhcjU/f
 8W2Lyyf/uk+CRGfh0EVKOmMnA35OuVHNgKp+DXeb1iKVKi7NnhWzKpNxEsdw1F+ybhN5
 jfNacR+TdoQplDiM8zUIePbFR9aSyKHQGsXqXNZDTN1GXfyLZvwAVqb16B1WA1ZyUGun
 rCukHWDWdAkBwvhSFzDxQ0cUv0O4IMI52SjboHWTPe5ifw1O62PTP4em51Gqb5nEKuwB
 YKlFWCcsYzMWfXlBSS+/wYyD+sAh0YslunodEO0o9tX282HbbOJIR9Lgc/QnA4hSdvv8
 n9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559960; x=1756164760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QA4PiTQQnIgoKKcOURxs/3kETlrm1+00D9JfkDesGfk=;
 b=W5Y+AwtwHoWuaBVIyB7gsAEnihQMNiB23t0PtiwEHfOSvkSOog3GFZOueIK/7raMmA
 It7ZZW5EtYUDEHZB6oQa/YqMEEnHZZWDw3sXdxRI3m+a4/uPSpGzBEzHJASooduwNV4i
 gYGVcM+6A/rxqlF2WYhixo4FK98UsK4kPnCsLvsgeK6QNZc/Q8wIHDI/3+6DzQtJyylt
 MPtbjr25VwM1QSjcyyAm6K3o/ElN5VhtHTFzs+A2t+wCXkFcsQgoWBO921rzW4IWVQpG
 pI8PMP98AUh8jxXZKmP9WYqy8SCq6FytDydaX8GhZnkxEMirrkjCB78rzjZi2uSkrlTp
 aAdg==
X-Gm-Message-State: AOJu0Yz4WCXucIha3pWe9Kbkeh2dsDUkor89lEPxcDlAGIMIUjULhgCU
 xAOLeeKknn9RbGHoEjLrkBL5mkt7+FrTGpC1wFBqkVrg66UY2VrxJzyKUKM4Yt8QKXl3a+Fhw44
 bA9DT
X-Gm-Gg: ASbGncuUn+8P0WM9OkxHTlqm8IYWB/HvfXSySwj0kajbfY1OGuIhgWVpDQWUVRg0y3g
 AYFFGv1CBjTnT3Kl9AqRRDlQ3ljcY65YheYmNaxg32VS3H2zh26WtZVutGi4u036Mj3rGPlOS4U
 ObsmlbbfdkGiEsCODLsgIofSQjBiwOunCM4i094j31gfySsD3adgw/rJjAoEyrRO9R+wgBtwI3u
 UCGKLHg7Q1n2wOoCjFRgDLuetmOKjrlTffW1Hq2jn6vP1Fq7f7ZfdlKYPE8kYzKpN2BANZxGNq6
 /JupIb9R78kqRUZdupHPIRcweGS8Jv8jvfk8aIIdRQbeD8iGCNh1mhkDV6JzA+P9Xh6u8XaH4CD
 TGC/0A6I6Ln9TaNHfJO4pSle0Z+o0XVKtrpAJWGHkbz2P3kyk8vEhZtnLRvPdGnp7Ii+3b9oE
X-Google-Smtp-Source: AGHT+IFDiIbo8oBm4LgtsykTr4rs+FgAdSqUR/G+XnRWe0cu5iNOkLlimiOjIw6mCRscmP66HRyoig==
X-Received: by 2002:a05:6000:240e:b0:3b8:d1a4:bacb with SMTP id
 ffacd0b85a97d-3c0ed0fe541mr326083f8f.42.1755559959836; 
 Mon, 18 Aug 2025 16:32:39 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [RFC 03/47] eal: use bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:14 -0700
Message-ID: <20250818233102.180207-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of sys/queue.h with bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_bus.c    | 2 +-
 lib/eal/common/eal_common_class.c  | 2 +-
 lib/eal/common/eal_common_dev.c    | 2 +-
 lib/eal/common/eal_common_tailqs.c | 2 +-
 lib/eal/common/eal_common_trace.c  | 2 +-
 lib/eal/common/eal_private.h       | 2 +-
 lib/eal/common/malloc_elem.c       | 2 +-
 lib/eal/common/malloc_heap.c       | 2 +-
 lib/eal/common/malloc_heap.h       | 2 +-
 lib/eal/common/rte_malloc.c        | 2 +-
 lib/eal/freebsd/eal.c              | 2 +-
 lib/eal/freebsd/eal_interrupts.c   | 2 +-
 lib/eal/freebsd/eal_thread.c       | 2 +-
 lib/eal/freebsd/include/rte_os.h   | 6 ++++--
 lib/eal/linux/eal_alarm.c          | 2 +-
 lib/eal/linux/eal_interrupts.c     | 2 +-
 lib/eal/linux/include/rte_os.h     | 3 ++-
 lib/eal/windows/eal_alarm.c        | 2 +-
 18 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 0a2311a342..29b69a1bd8 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -4,8 +4,8 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <bus_driver.h>
 #include <rte_debug.h>
 #include <rte_string_fns.h>
diff --git a/lib/eal/common/eal_common_class.c b/lib/eal/common/eal_common_class.c
index 0f10c6894b..1f10eca5b5 100644
--- a/lib/eal/common/eal_common_class.c
+++ b/lib/eal/common/eal_common_class.c
@@ -4,8 +4,8 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_class.h>
 #include <rte_debug.h>
 
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 7185de0cb9..9bd7d5082d 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -6,8 +6,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <bus_driver.h>
 #include <rte_class.h>
 #include <dev_driver.h>
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..1d4eda8517 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -2,10 +2,10 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <string.h>
 
+#include <bsd_queue.h>
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
 #include <rte_log.h>
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be1f78a68d..2ec2a6532d 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -5,9 +5,9 @@
 #include <stdlib.h>
 #include <fnmatch.h>
 #include <pthread.h>
-#include <sys/queue.h>
 #include <regex.h>
 
+#include <bsd_queue.h>
 #include <rte_common.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 5846917cc5..d7557ea4a8 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -8,8 +8,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <dev_driver.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
diff --git a/lib/eal/common/malloc_elem.c b/lib/eal/common/malloc_elem.c
index 452b119c20..cf78395eba 100644
--- a/lib/eal/common/malloc_elem.c
+++ b/lib/eal/common/malloc_elem.c
@@ -6,8 +6,8 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_memory.h>
 #include <rte_eal.h>
 #include <rte_common.h>
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 13a56e490e..9f319cc040 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -6,8 +6,8 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_memory.h>
 #include <rte_errno.h>
 #include <rte_eal.h>
diff --git a/lib/eal/common/malloc_heap.h b/lib/eal/common/malloc_heap.h
index dfc56d4ae3..5c7e6cfad8 100644
--- a/lib/eal/common/malloc_heap.h
+++ b/lib/eal/common/malloc_heap.h
@@ -6,8 +6,8 @@
 #define MALLOC_HEAP_H_
 
 #include <stdbool.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_malloc.h>
 #include <rte_spinlock.h>
 
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3a86c19490..f30b66fc10 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -6,8 +6,8 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <rte_errno.h>
 #include <rte_memcpy.h>
 #include <rte_memory.h>
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index c1ab8d86d2..64e9922775 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -17,9 +17,9 @@
 #include <errno.h>
 #include <limits.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <sys/stat.h>
 
+#include <bsd_queue.h>
 #include <rte_common.h>
 #include <rte_debug.h>
 #include <rte_memory.h>
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index 5c3ab6699e..0e3069af8a 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -5,9 +5,9 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/event.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_errno.h>
diff --git a/lib/eal/freebsd/eal_thread.c b/lib/eal/freebsd/eal_thread.c
index 7ed76ed796..28335282e7 100644
--- a/lib/eal/freebsd/eal_thread.c
+++ b/lib/eal/freebsd/eal_thread.c
@@ -9,9 +9,9 @@
 #include <unistd.h>
 #include <sched.h>
 #include <pthread_np.h>
-#include <sys/queue.h>
 #include <sys/thr.h>
 
+#include <bsd_queue.h>
 #include <rte_debug.h>
 #include <rte_atomic.h>
 #include <rte_launch.h>
diff --git a/lib/eal/freebsd/include/rte_os.h b/lib/eal/freebsd/include/rte_os.h
index 94b9275beb..874fdd7f03 100644
--- a/lib/eal/freebsd/include/rte_os.h
+++ b/lib/eal/freebsd/include/rte_os.h
@@ -12,9 +12,11 @@
 
 #include <pthread_np.h>
 #include <stdlib.h>            /* Declares alloca() */
-#include <sys/queue.h>
 
-/* These macros are compatible with system's sys/queue.h. */
+/* Alternative to system's sys/queue.h which is missing some macros. */
+#include <bsd_queue.h>
+
+/* These macros are compatible with bsd_queue.h. */
 #define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
 #define RTE_TAILQ_ENTRY(type) TAILQ_ENTRY(type)
 #define RTE_TAILQ_FOREACH(var, head, field) TAILQ_FOREACH(var, head, field)
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index eb6a21d4f0..150e502437 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -6,10 +6,10 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <pthread.h>
-#include <sys/queue.h>
 #include <sys/time.h>
 #include <sys/timerfd.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_interrupts.h>
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4ec78de82c..0d26cd9ce0 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
-#include <sys/queue.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
@@ -15,6 +14,7 @@
 #include <assert.h>
 #include <stdbool.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <eal_trace_internal.h>
 #include <rte_common.h>
diff --git a/lib/eal/linux/include/rte_os.h b/lib/eal/linux/include/rte_os.h
index 20eff0409a..bfb9447586 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -12,7 +12,8 @@
 
 #include <alloca.h>
 #include <sched.h>
-#include <sys/queue.h>
+
+#include <bsd_queue.h>
 
 /* These macros are compatible with system's sys/queue.h. */
 #define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
diff --git a/lib/eal/windows/eal_alarm.c b/lib/eal/windows/eal_alarm.c
index 0b11d331dc..757d4efc4f 100644
--- a/lib/eal/windows/eal_alarm.c
+++ b/lib/eal/windows/eal_alarm.c
@@ -4,8 +4,8 @@
 
 #include <stdatomic.h>
 #include <stdbool.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <rte_alarm.h>
 #include <rte_spinlock.h>
-- 
2.47.2

