Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C4606BA19
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cjDUq+Hg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0E7942F0B;
	Tue,  3 Nov 2026 16:17:33 +0100 (CET)
Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
 by mails.dpdk.org (Postfix) with ESMTPS id 0D25342EF1
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:32 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=eb1x0W8vf8dJMpcQnYOKCrNs2ry6eL/ajTG8IgDympU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719051; v=1; x=1794323851;
 b=cjDUq+HggmRnPdyMsqFeV5VH5effN7I9f0KKDNZ8CEckeTXpARz4jV49M7DsFLleewoi2bId
 cEX5zFYmug5Wob0yPOVj8PX8gzWdT3Oj/EU60b/1tHT7GxlpSb0cKsM9IpvMzqyKFicY3u2Rvuk
 2zM0tNcT90fDVy+WKIECPGjY=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 25722988471e73c7;
 Tue, 03 Nov 2026 15:17:31 +0000
X-Mizu-Trace-ID: 25722988471e73c7
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 157/227] raw/cnxk_bphy: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:55 +0800
Message-ID: <20261103145306.487255-158-chengwen.feng@linux.dev>
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
 drivers/raw/cnxk_bphy/cnxk_bphy.c     | 2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy.c b/drivers/raw/cnxk_bphy/cnxk_bphy.c
index ea30a7100c..3e5e3e0154 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy.c
@@ -343,7 +343,7 @@ bphy_rawdev_probe(struct rte_pci_driver *pci_drv,
 
 	bphy_rawdev_get_name(name, pci_dev);
 	bphy_rawdev = rte_rawdev_pmd_allocate(name, sizeof(*bphy_dev),
-					      rte_socket_id());
+					      rte_numa_id());
 	if (bphy_rawdev == NULL) {
 		CNXK_BPHY_LOG(ERR, "Failed to allocate rawdev");
 		return -ENOMEM;
diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
index e0c7257027..d4712ed4ca 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
@@ -313,7 +313,7 @@ cnxk_bphy_cgx_rawdev_probe(struct rte_pci_driver *pci_drv,
 		return ret;
 
 	cnxk_bphy_cgx_format_name(name, sizeof(name), pci_dev);
-	rawdev = rte_rawdev_pmd_allocate(name, sizeof(*cgx), rte_socket_id());
+	rawdev = rte_rawdev_pmd_allocate(name, sizeof(*cgx), rte_numa_id());
 	if (!rawdev)
 		return -ENOMEM;
 
-- 
2.55.0

