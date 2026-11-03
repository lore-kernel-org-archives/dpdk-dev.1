Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EA606A7AB
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CYsK+L7R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883E642F01;
	Tue,  3 Nov 2026 16:17:46 +0100 (CET)
Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E70A42F1B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=gp+rfrT+H/JtvrIFCfHm8b38+IZIUpJsg/xl35dRkww=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719064; v=1; x=1794323864;
 b=CYsK+L7RGrDHnrACmE93t3gHVGoshOH9rsGYIBq4Btg/yM+VsuJPDvAXXlpye9p4J7ffCJQq
 wjNWTM/evj3Fivo44QhyR1GwCwXHcPJ9dmzdCg/+fsQjqiYl2KVVTxO5jHd/tqPX8fcWplD5GF0
 jhGL9mrwZmpGUKDumwnqUNrE=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 7936e04a5fadf481;
 Tue, 03 Nov 2026 15:17:44 +0000
X-Mizu-Trace-ID: 7936e04a5fadf481
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 159/227] raw/cnxk_rvu_lf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:57 +0800
Message-ID: <20261103145306.487255-160-chengwen.feng@linux.dev>
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
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
index 57c7cc85f3..69c36103b3 100644
--- a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
+++ b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
@@ -202,7 +202,7 @@ rvu_lf_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 
 	rvu_lf_rawdev_get_name(name, pci_dev);
 	rvu_lf_rawdev = rte_rawdev_pmd_allocate(name, sizeof(*roc_rvu_lf),
-					      rte_socket_id());
+					      rte_numa_id());
 	if (rvu_lf_rawdev == NULL) {
 		CNXK_RVU_LF_LOG(ERR, "Failed to allocate rawdev");
 		return -ENOMEM;
-- 
2.55.0

