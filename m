Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A838606B240
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K77F6SS0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BFB042F25;
	Tue,  3 Nov 2026 16:18:31 +0100 (CET)
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
 by mails.dpdk.org (Postfix) with ESMTPS id 727604060F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:18:29 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=i7CqcLZwOxWuKnpJMnuN6kLY6TkUa3grPi7g3p/yXGg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719109; v=1; x=1794323909;
 b=K77F6SS0AHw80GdxH1FLBKTzTm3s97V5otcSQpKsFjzhcjywOZG9vOddgI9PqTF1Dp9tprPf
 Uc/fuWBZgGJ+jv/v8vnB3QOZWkc4Dn6Dm7IBi0NghDEv1kxklRxsz5kEl+ayiBERxoTDwkucsWe
 LRAYwjlMue88RviQ9WJwlC14=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id ef3497769b289744;
 Tue, 03 Nov 2026 15:18:28 +0000
X-Mizu-Trace-ID: ef3497769b289744
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 161/227] raw/gdtc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:59 +0800
Message-ID: <20261103145306.487255-162-chengwen.feng@linux.dev>
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
 drivers/raw/gdtc/gdtc_rawdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/gdtc/gdtc_rawdev.c b/drivers/raw/gdtc/gdtc_rawdev.c
index ee83a67bad..83ffa024ae 100644
--- a/drivers/raw/gdtc/gdtc_rawdev.c
+++ b/drivers/raw/gdtc/gdtc_rawdev.c
@@ -697,7 +697,7 @@ zxdh_gdma_queue_init(struct rte_rawdev *dev, uint16_t queue_id)
 	/* Init ring */
 	snprintf(name, RTE_MEMZONE_NAMESIZE, "gdma_vq%d_ring", queue_id);
 	size = ZXDH_GDMA_RING_SIZE * sizeof(struct zxdh_gdma_buff_desc);
-	mz = rte_memzone_reserve_aligned(name, size, rte_socket_id(),
+	mz = rte_memzone_reserve_aligned(name, size, rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, size);
 	if (mz == NULL) {
 		if (rte_errno == EEXIST)
@@ -843,13 +843,13 @@ zxdh_gdma_rawdev_probe(struct rte_pci_driver *pci_drv __rte_unused,
 			pci_dev->name, pci_dev->mem_resource[0].phys_addr,
 			pci_dev->mem_resource[0].addr);
 
-	dev = rte_rawdev_pmd_allocate(dev_name, sizeof(struct zxdh_gdma_rawdev), rte_socket_id());
+	dev = rte_rawdev_pmd_allocate(dev_name, sizeof(struct zxdh_gdma_rawdev), rte_numa_id());
 	if (dev == NULL) {
 		ZXDH_PMD_LOG(ERR, "Unable to allocate gdma rawdev");
 		goto err_out;
 	}
 	ZXDH_PMD_LOG(INFO, "Init %s on NUMA node %d, dev_id is %d",
-			dev_name, rte_socket_id(), dev->dev_id);
+			dev_name, rte_numa_id(), dev->dev_id);
 
 	dev->dev_ops = &zxdh_gdma_rawdev_ops;
 	dev->device = &pci_dev->device;
-- 
2.55.0

