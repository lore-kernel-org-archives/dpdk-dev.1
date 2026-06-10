Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B1CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F3E4065A;
	Wed, 10 Jun 2026 11:12:12 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1F54B40657
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:12:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gb0QW3mrSzJ46bg
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:11:47 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id BD87B40572
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:12:00 +0800 (CST)
Received: from localhost (10.220.239.45) by frapema500004.china.huawei.com
 (7.182.19.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Jun
 2026 11:12:00 +0200
From: Eimear Morrissey <eimear.morrissey@huawei.com>
To: <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 1/2] eal/pflock: add API to downgrade from wr to rd lock
Date: Wed, 10 Jun 2026 10:11:46 +0100
Message-ID: <20260610091147.88412-2-eimear.morrissey@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260610091147.88412-1-eimear.morrissey@huawei.com>
References: <20260610091147.88412-1-eimear.morrissey@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500004.china.huawei.com (7.182.19.21)
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Add a new API that allows for the caller to downgrade from wrlock
to rdlock. Note that caller is expected to obtain wrlock before calling
that function.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/eal/include/rte_pflock.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/eal/include/rte_pflock.h b/lib/eal/include/rte_pflock.h
index 6797ce5920..ed5255b3b5 100644
--- a/lib/eal/include/rte_pflock.h
+++ b/lib/eal/include/rte_pflock.h
@@ -179,6 +179,27 @@ rte_pflock_write_unlock(rte_pflock_t *pf)
 	rte_atomic_fetch_add_explicit(&pf->wr.out, 1, rte_memory_order_release);
 }
 
+/**
+ * Release a pflock held for writing, while keeping lock for reading.
+ *
+ * @param pf
+ *   A pointer to a pflock structure.
+ */
+static inline void
+rte_pflock_write_downgrade(rte_pflock_t *pf)
+{
+	/* Migrate from write phase to read phase. */
+	rte_atomic_fetch_add_explicit(&pf->rd.in, RTE_PFLOCK_RINC,
+		rte_memory_order_acq_rel);
+	rte_atomic_fetch_and_explicit(&pf->rd.in, RTE_PFLOCK_LSB,
+			rte_memory_order_release);
+
+	/* Allow other writers to continue. */
+	rte_atomic_fetch_add_explicit(&pf->wr.out, 1,
+			rte_memory_order_release);
+}
+
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.51.0

