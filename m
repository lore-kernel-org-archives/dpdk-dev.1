Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6633CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 974F54067D;
	Wed, 29 Apr 2026 20:47:46 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id D998D40666
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:44 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12c726f46baso101745c88.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488464;
 x=1778093264; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05mxr+H3pn3JgORYmUptX9sjpdjpmkvm3W0o5P53FHg=;
 b=fW5Ro+XfBOUUkCN3hCrqK+MMBVeFqvofjhy+CGC8up0OYAVtv2RVaTit9MIwC7v6dl
 hwwO/calDTr72wh6YdY0QfzP2C78U7a7uLyyv1Lk7C7iihGvMGQE5tPKPkdm8J7Abfh6
 18ZA1Q0ZvpFHHuy9s3mBX2sVtiRA7V/POzaz3f+ri6Q16cJSLKJ5iSzXSi5nztOKG6gd
 7HsOmjqtfMbYSv0SJ1QSYssjUA32q7mVgkLcAYX08Y6aFlFbt4fc8nVlhcLhEDnvIfTK
 18LOxnE+mNfoMcCl6giUXy56Wuoutz+QwO1dubjqHsbYwAafT/vl81qzqDbWLFtJTIUr
 08YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488464; x=1778093264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=05mxr+H3pn3JgORYmUptX9sjpdjpmkvm3W0o5P53FHg=;
 b=Fp+1t6lI2bxsljQKR3roTSxfm6VWPEHs3kxGz405OF6IBKQn4fcDKIqwjxkqU3h8yS
 10CJDVTW7aXA+mavrhHqFfjlk0+6VG/QDK0NYxy2HRk1+th/i1P2JbM01s1LF+ZUPy+W
 FqLr3aQOMLkayAthPhKToAw2eQvqOxxXtj3QaJ4x9zvLLL2hXPmUJtzFTFLGts1WwstL
 /5aLwkrTASb0lO7cWfd7AlS98UmLhwoU8B3T0TJxZaxapHcYDNt512hxtw5yEMgy97lq
 oTgusd/gDWN3KGsGcImksbaqrcHvMU5u9/4fud7SyrDeZI2iNC6P9O8yYWH897fEKDgu
 59aw==
X-Gm-Message-State: AOJu0YzWWU7bOAh+CAawURI1nYQwxRLMiks4UsboPjZhRaLFwaVOAtHG
 7M7rzxcxaS9gkx1l0eLp6zqjBe40WNgCeZTG4eSaeaums5Ahfr3XoKAgePPlMg6SlLt1q+Imrvf
 wf3Bw
X-Gm-Gg: AeBDieteY2pFmK/tHnPCztLxreo7b1A98btllv5Z1cjjoArn7bbzVkUCktgQms7FFpx
 A6pktEMp7oShiu4+iWYoCw3Byhprhx6dj3XOGu7G1yBk5AlCctUXf2Yv5IZd6L2gU7Gbf3M0FmZ
 /q+l+d97nAzlsXPm2d/g/Zlzah0CZ3AJJTnXfChJnnAGNAqMyJiVe3faxeVuir0E7SkJsY89oTP
 gjkiF5UgNS14DpRuarTNmr5UgyrxP0HrHXZI9zEJwaDsNPHMKGtijn2oP6TsbnqBSQf3kPeGXPb
 yTii0Rbk35nDEvXbdfA5j/EFO4OUZAVMy9gk9v8dvXyiRLJMkeoyZ6XHD8A3L/TUXqJOhd8eAAQ
 iR4hZMO1XIH6nBMhPW0UAOn0qsODftnHUOXEp0/G2M4/BSBSI/Zy8TWruGblc0wF6dAsvxx9rFa
 WQypMHdOsGavwg0E5LS4HNo10osS1dNXiD09dVpfQNRZCrv/+bWRMy+w==
X-Received: by 2002:a05:7300:a148:b0:2cf:28e8:d784 with SMTP id
 5a478bee46e88-2ed0a0a7a51mr3984564eec.19.1777488463692; 
 Wed, 29 Apr 2026 11:47:43 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v3 1/7] eal: add helper to initialize process-shared mutex
Date: Wed, 29 Apr 2026 11:46:38 -0700
Message-ID: <20260429184739.706250-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

Drivers and libraries that place a pthread_mutex_t in shared memory
to coordinate primary and secondary DPDK processes must initialize
the mutex with PTHREAD_PROCESS_SHARED, otherwise behaviour is
undefined. Add an internal helper so this is done in one place rather
than copied into every driver.

Errors from the attribute calls are ignored: on platforms that do not
support cross-process mutex sharing the mutex still works within a
single process.

Bugzilla ID: 662
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_thread.h | 15 +++++++++++++++
 lib/eal/unix/rte_thread.c    | 12 ++++++++++++
 lib/eal/windows/rte_thread.c | 10 ++++++++++
 3 files changed, 37 insertions(+)

diff --git a/lib/eal/include/rte_thread.h b/lib/eal/include/rte_thread.h
index 8da9d4d3fb..27d5b9c594 100644
--- a/lib/eal/include/rte_thread.h
+++ b/lib/eal/include/rte_thread.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2022 Microsoft Corporation
  */
 
+#include <pthread.h>
 #include <stdint.h>
 
 #include <rte_os.h>
@@ -463,6 +464,20 @@ int rte_thread_value_set(rte_thread_key key, const void *value);
  */
 void *rte_thread_value_get(rte_thread_key key);
 
+/**
+ * Initialize a pthread mutex for use in shared memory accessible by
+ * multiple DPDK processes.
+ *
+ * Sets PTHREAD_PROCESS_SHARED so the mutex can synchronize threads
+ * across DPDK primary and secondary processes when the mutex resides
+ * in shared memory (e.g. hugepage memory).
+ *
+ * @param mutex
+ *   The mutex to initialize.
+ */
+__rte_internal
+void rte_thread_mutex_init_shared(pthread_mutex_t *mutex);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/unix/rte_thread.c b/lib/eal/unix/rte_thread.c
index 950c0848ba..f3a6bd2ad3 100644
--- a/lib/eal/unix/rte_thread.c
+++ b/lib/eal/unix/rte_thread.c
@@ -419,3 +419,15 @@ rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 	return pthread_getaffinity_np((pthread_t)thread_id.opaque_id,
 		sizeof(*cpuset), cpuset);
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_mutex_init_shared)
+void
+rte_thread_mutex_init_shared(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
diff --git a/lib/eal/windows/rte_thread.c b/lib/eal/windows/rte_thread.c
index 85e5a57346..19bb9ed61d 100644
--- a/lib/eal/windows/rte_thread.c
+++ b/lib/eal/windows/rte_thread.c
@@ -621,3 +621,13 @@ rte_thread_get_affinity_by_id(rte_thread_t thread_id,
 	}
 	return ret;
 }
+
+/* Note: Windows does not have PTHREAD_PROCESS_SHARED
+ * and DPDK on Windows only supports single process model.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_thread_mutex_init_shared)
+void
+rte_thread_mutex_init_shared(pthread_mutex_t *mutex)
+{
+	pthread_mutex_init(mutex, NULL);
+}
-- 
2.53.0

