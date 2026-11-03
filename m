Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E741606A329
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dkfG+qfs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 511C8427D0;
	Tue,  3 Nov 2026 16:00:54 +0100 (CET)
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 65C81427C1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:00:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=e8FW0qJx7P5oBdq7ovpBSVD+EuGxX9o5zJ00MJ4tyBk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718051; v=1; x=1794322851;
 b=dkfG+qfsk1OPSW+05kXlkV3BtnZHg4/vMnecmlERGaVwWSWJNCgfDDs0lXJ7PztGsdA7h/2y
 s2XL3x5Fuou5IrJ+b9Osv0NFzy6PUQrYzn0eQ63mR4MnRpZ8ZkmdcDbs8tcAdQICCC6ZfPureVX
 RXL9AQVqR1YcY2iyjIm4o2YE=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 64454f343b8f0899;
 Tue, 03 Nov 2026 15:00:51 +0000
X-Mizu-Trace-ID: 64454f343b8f0899
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 046/227] bus/fslmc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:04 +0800
Message-ID: <20261103145306.487255-47-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index e40fe59c7c..ac41993796 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -251,7 +251,7 @@ scan_one_fslmc_device(char *dev_name)
 		return -ENOMEM;
 	}
 
-	dev->device.numa_node = SOCKET_ID_ANY;
+	dev->device.numa_node = RTE_NUMA_ID_ANY;
 	dev->dev_type = dev_type;
 
 	if (sscanf(dev_id, "%hu", &dev->object_id) != 1) {
-- 
2.55.0

