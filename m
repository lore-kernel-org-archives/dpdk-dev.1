Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B023F9D0D6
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A4D40611;
	Tue, 14 Apr 2026 16:42:52 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 95862402E1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:51 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d64c756111so6289761eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177771;
 x=1776782571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpeKWLWK6HxEJ354jedbaVf4BGRv+9H1aBi8AiceNQ8=;
 b=c66KTXzKk1yFpDXBr1R/Z5qMSy6vHJ/Ukc38qF+zAJkn4Fy9tqebnZPOUWb9wraA4S
 E42rnfgswVhXfu7T06vB0ch0v2mje3sQARTcBOPn9Twqh3+hIaLlMKx/1nYu9Dymnsjf
 U6j42uPT5y7OQsRvoQ2WnVUq0nIXnpdbLj7DwVjNLX7ukPh/gTvHls2Oip7en/R0TMSM
 jTLYjBVo3QsWuamL6uf3VkI3J49b51y2tvQanhH4MOrlRHD/C3oKi+68KddjkKPU0rn5
 3fRSYFQkkBsymn4+erSoSar436OWrBxzqfc2P0VUDwa9GxyRN02QxKXhXdhHhNv5SMw+
 MhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177771; x=1776782571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpeKWLWK6HxEJ354jedbaVf4BGRv+9H1aBi8AiceNQ8=;
 b=mOicNu431RQLp1/3fHZJ0q+E/j9etbfbXFQYdtA/y4nQrLHIVPsfvSI0AZFu1qE6PO
 DTdw3vMXo9xVwzciT7TzDttPBCXgqWYuVGf3+RVmitsHWEanN9nA3YLxcMA9tDR46UU0
 b+HKQ3fmpXdFlWudWZCfPKPIAfNGkn+wscnA+zACU1SzomnitmjV4adsJAJ0oOvBy5WO
 9M4yGFFFBCBfHmSHug3j9xfllj6f6wVNIp0q3yWpLTwgj5vdExp8S6/JHIttT8ShKtDR
 eGMouLSh2OBAoXjqbK5NJnqys4ldYzJB5yALOLiO3DkukCYNBsw3KF4cIRldsZcOuqYa
 /Aeg==
X-Gm-Message-State: AOJu0Ywq1E9TzZhxI9ZE8ORiVZgh4WDOHnRLvPTljOEFKDiD3WZayn/0
 WhP429eXYENZim78+bdcNQcvLRw5WHkwC/TtcXX1VUVERIMSLGfZ1vyPj9mFsYXaqOQ38pTa3YU
 Ewstr
X-Gm-Gg: AeBDies2Zz8c844n39Ubf4fugK6SiPelFQYu1J+VksPjhH764d0BDwkUbz13nOTGRSd
 b2yghIUd8O6guVz/iK3VUjNX+ocfudvL34S1iK2uMQks/iIR8fQt8JHymANb3zPkiZWEDpDxDl6
 uybRrsv68LlTL3pTFlprSz2ctt24xVCde7xsUjOlyEAH0P9FdYPgUIlRYTuXGyooMwltTgH+Juj
 vBGoTfZOt6OvrKXojTdZNA9y6vCHz1RVAW1McFu180810SY1hJVEOt9B1vVBFYxwGksmnb1ziV0
 OuX91FJY9X5dY8PbeyrlSk3Yug2QEHD5vau7Woy6WdrZyLmAKHdJX2i6ZXI02e5XqrxKdWZHnXf
 j7LBcIYZXFt0VJzwq2Dol2mXTDtC89e7eylDWezi8JbBxMD28IjKSuIRcoMLFj/dDFtxqL6vPuQ
 Dz0syDvWc2Ta6Il/lbgYPtaSsIVyxhRjHJlrTFc6higy0=
X-Received: by 2002:a05:693c:3116:b0:2c7:3a7:c7af with SMTP id
 5a478bee46e88-2d5869913b1mr10061436eec.7.1776177770580; 
 Tue, 14 Apr 2026 07:42:50 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Matan Azrad <matan@nvidia.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Suanming Mou <suanmingm@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 1/6] ethdev: fix flow_ops_mutex for multi-process
Date: Tue, 14 Apr 2026 07:39:53 -0700
Message-ID: <20260414144246.110681-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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

The flow_ops_mutex in rte_eth_dev_data is located in shared memory
that is accessed by both primary and secondary processes. However,
the mutex is initialized without PTHREAD_PROCESS_SHARED attribute,
which means synchronization between processes is undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

This bug has existed since the flow_ops_mutex was added and affects
any multi-process DPDK application using rte_flow APIs.

Bugzilla ID: 662
Fixes: 80d1a9aff7f6 ("ethdev: make flow API thread safe")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 2ec665be0f..60d0246226 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -89,6 +89,26 @@ eth_dev_set_dummy_fops(struct rte_eth_dev *eth_dev)
 	eth_dev->recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy;
 }
 
+/*
+ * Initialize mutex for process-shared access.
+ * The rte_eth_dev_data structure is in shared memory, so any mutex
+ * protecting it must use PTHREAD_PROCESS_SHARED.
+ */
+static void
+eth_dev_flow_ops_mutex_init(pthread_mutex_t *mutex)
+{
+#ifndef RTE_EXEC_ENV_WINDOWS
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+#else
+	pthread_mutex_init(mutex, NULL);
+#endif
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
 struct rte_eth_dev *
 rte_eth_dev_allocate(const char *name)
@@ -135,7 +155,7 @@ rte_eth_dev_allocate(const char *name)
 	eth_dev->data->port_id = port_id;
 	eth_dev->data->backer_port_id = RTE_MAX_ETHPORTS;
 	eth_dev->data->mtu = RTE_ETHER_MTU;
-	pthread_mutex_init(&eth_dev->data->flow_ops_mutex, NULL);
+	eth_dev_flow_ops_mutex_init(&eth_dev->data->flow_ops_mutex);
 	RTE_ASSERT(rte_eal_process_type() == RTE_PROC_PRIMARY);
 	eth_dev_shared_data->allocated_ports++;
 
-- 
2.53.0

