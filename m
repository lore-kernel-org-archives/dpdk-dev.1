Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C8EC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 15:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D586E40278;
	Sun, 28 Jun 2026 17:27:50 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 95DC6400D7
 for <dev@dpdk.org>; Sun, 28 Jun 2026 17:27:49 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e9784666b3so1850254a34.1
 for <dev@dpdk.org>; Sun, 28 Jun 2026 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782660469; x=1783265269; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wxsa1ilpK4hJidKV/W3syf/q++AddPdH8ThIupsJ6Wo=;
 b=GAqG6eJkPZH2e4d5JYHzaCLOOsn5viCjrK85U+ibsA2wRq40xTP11xoXlVkza/+jK9
 OLm7jKS+YAFM1N8rjsf+3aG2QmX3ammt1foKH4lXgDswac3W2YMn+PvtlYMGIRAUzRQS
 6saBvXxmZMTxs/kku1VeA8uTybcZLyYzeVGDN7mGMTYAkzzKptZ2xJjUCkkCPHAq9n2y
 bK9FKGIEQ76ceBNUOO82FoCBomwkGVZcfHNAekMpppvVjUTw6zgc/yPG+4D4AFCyWicW
 gzSsaAorQ37XiW8nDZ21rg1+ZGV4lo3IaqJLkHomlA3f8pVgI3YT6rQ1uC38mDpBQf8h
 mpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782660469; x=1783265269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wxsa1ilpK4hJidKV/W3syf/q++AddPdH8ThIupsJ6Wo=;
 b=DMfVPidyBlzqpU9tBwcAa7asn+GlxztcEpN9Qca7S6CCXzSP9QUxtC7aVrvZcDeZuv
 1ITnlza9LYrb5CBFNEICo85eP4E6uOSg7XiorVctstx+0FyeRLjnH4bN4QmBymkfGM+9
 yPVLDtlEZaDdbMt7yRnfXqwt8BRjKk9QcDrFapXZdoYK4YZj8qAhXLH5ht8Ius0eYHOJ
 O6sZDWS5wEr0gF48dWJHheVyL31VOiADWlJFgWMpZbVKmi9OAp8nnQkJkJ9s20hqxl7X
 ULh7b89+d5L9psBDgQ4fKg+SH1ef//eXVNPvSD3e3hbMp/8NthgfXmmhTAJ3NsITZHbF
 R+Qw==
X-Gm-Message-State: AOJu0YzYFMx7CTAQxCpUBZ8osg05PWZRWQVrXkAFA75cGxgX0kaLtZdH
 yKcEywixBBoKx65q6dU6wtlR6uIlb8tdHOWU6Jxg/7KymzaKe/PfWd7xuRe6Y3Z5
X-Gm-Gg: AfdE7clmVyjgT8bNOMJe37xQFUiGjpEczk+1NRTluwIFoTRFeMtMP/GRo8juX7ooINI
 UzOwkMl6lvlYKKLvfkZzi3mGMOaePQfCPcF+eaAiZFmcBF+PdlEtfRnQsQGv1j31+/sT7kf19Ci
 4scU/sL+/ruH6CTMdrOojq+uVMs1WAHWaaHYiZ5nAL6/LeNejwsUHaAXjhWzGl5Xsa0xByoTwyE
 91Lfv4De4IDFcbA1tpTPf612yG/N3gjlLzOGRBbamamsj+ClAuG2JrlUWvdho4McWRkAQpM2dnY
 oraB7D9kVqN7r6UAQzLRrQOvQWPFzPcakmxT4nP4oito4AkHigR2NMSoDkS447UqpA2J6E/SLjt
 sgGBD/+w/cgxjz7mV1mUIpCB8quvg/kZv3mM2QYTyaWy2zOQBAnyAAmnU6bQhWj9FRepzzOu02D
 KaATH/pQ==
X-Received: by 2002:a05:6830:6aee:b0:7e6:ee6d:cb1f with SMTP id
 46e09a7af769-7e9b4bf274dmr5971296a34.0.1782660468722; 
 Sun, 28 Jun 2026 08:27:48 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9bf499043sm3883076a34.9.2026.06.28.08.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 08:27:48 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, jun.yang@nxp.com,
 stable@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 david.marchand@redhat.com, Weijun Pan <wpan36@wisc.edu>
Subject: [PATCH v2] bus/fslmc: convert queue storage macros to inline functions
Date: Sun, 28 Jun 2026 10:25:53 -0500
Message-Id: <20260628152553.46342-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407141928.9426-1-wpan36@wisc.edu>
References: <20260407141928.9426-1-wpan36@wisc.edu>
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

From: Weijun Pan <wpan36@wisc.edu>

The queue storage allocation and free helpers are implemented as macros
which declare local variables in the caller scope. This can cause shadow
warnings when -Wshadow is enabled.

Convert them to static inline functions to avoid macro-local variable
scope issues without changing behavior.

Bugzilla ID: 1744
Fixes: 12d98eceb8ac ("bus/fslmc: enhance QBMAN DQ storage logic")
Cc: jun.yang@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Weijun Pan <wpan36@wisc.edu>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 75 ++++++++++++++-----------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index e625a5c035..d09dd5d1f9 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -202,39 +202,48 @@ struct swp_active_dqs {
 	uint64_t reserved[7];
 };
 
-#define dpaa2_queue_storage_alloc(q, num) \
-({ \
-	int ret = 0, i; \
-	\
-	for (i = 0; i < (num); i++) { \
-		(q)->q_storage[i] = rte_zmalloc(NULL, \
-			sizeof(struct queue_storage_info_t), \
-			RTE_CACHE_LINE_SIZE); \
-		if (!(q)->q_storage[i]) { \
-			ret = -ENOBUFS; \
-			break; \
-		} \
-		ret = dpaa2_alloc_dq_storage((q)->q_storage[i]); \
-		if (ret) \
-			break; \
-	} \
-	ret; \
-})
-
-#define dpaa2_queue_storage_free(q, num) \
-({ \
-	if (q) { \
-		int i; \
-		\
-		for (i = 0; i < (num); i++) { \
-			if ((q)->q_storage[i]) { \
-				dpaa2_free_dq_storage((q)->q_storage[i]); \
-				rte_free((q)->q_storage[i]); \
-				(q)->q_storage[i] = NULL; \
-			} \
-		} \
-	} \
-})
+int dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage);
+void dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage);
+
+static inline int
+dpaa2_queue_storage_alloc(struct dpaa2_queue *q, int num)
+{
+	int ret = 0, i;
+
+	for (i = 0; i < num; i++) {
+		q->q_storage[i] = rte_zmalloc(NULL,
+			sizeof(struct queue_storage_info_t),
+			RTE_CACHE_LINE_SIZE);
+		if (!q->q_storage[i]) {
+			ret = -ENOBUFS;
+			break;
+		}
+
+		ret = dpaa2_alloc_dq_storage(q->q_storage[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static inline void
+dpaa2_queue_storage_free(struct dpaa2_queue *q, int num)
+{
+	int i;
+
+	if (!q)
+		return;
+
+	for (i = 0; i < num; i++) {
+		if (q->q_storage[i]) {
+			dpaa2_free_dq_storage(q->q_storage[i]);
+			rte_free(q->q_storage[i]);
+			q->q_storage[i] = NULL;
+		}
+	}
+}
+
 
 #define NUM_MAX_SWP 64
 
-- 
2.34.1

