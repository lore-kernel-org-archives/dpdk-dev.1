Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34253606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=CRHMjcTy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C253427BA;
	Fri, 13 Nov 2026 04:10:46 +0100 (CET)
Received: from lf-2-35.ptr.blmpb.com (lf-2-35.ptr.blmpb.com [101.36.218.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 86259427B4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 04:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794539438; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/of1EkkZHi0ImrVAfabhE5Stf+X2QRJR5nSd57hD0cw=;
 b=CRHMjcTyFVAD9bPLv52AhGH6hWGE4ClH0+vQY60LMT0bYl3N/0FvLiEbCK2GMsOYzPa/Iq
 6zKhU3p+pJkX9nGps8li0HNHtNqCQPOBtMKWR4MY/dG2BpPE3DmvuqccyEDWlyKLMGJlIj
 XOP5cP/Cgvgaw4XB2fOmvKbnVKnm81EnnAWFS3UswAl0Hmkcx/FPIDOq0yWu3kqfe1jGiM
 wQPwvyGGKybEDc+kuMRwKB330iFU+rkLXY5GEIAYhDgosT0QNqiDYc4+7lLXBGgekXNKML
 racYjSEq19nE+uFGVrEegyNd5faZU/gXujmMdrC9hFaQ4o73Nyx7zJHxr11IrQ==
Message-Id: <179453942561.1554.9421372918540120682@yunsilicon.com>
References: <179453942560.1554.11439899391590171416@yunsilicon.com>
 <179453942560.1554.5221755720671808072@yunsilicon.com>
Cc: <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
In-Reply-To: <179453942560.1554.5221755720671808072@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 2/2] net/xsc: fix leak and missing NULL check
Date: Fri, 13 Nov 2026 11:10:25 +0800
Received: from [127.0.0.1] ([14.103.216.154]) by smtp.feishu.cn with ESMTPS;
 Fri, 13 Nov 2026 11:10:33 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26af67faa+83ed77+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>From 0fe3f49419330852df7d2a82fcf179fa6f80a9a0 Mon Sep 17 00:00:00 2001
From: Renyong Wan <wanry@yunsilicon.com>
Date: Fri, 13 Nov 2026 10:44:50 +0800
Subject: [PATCH 2/2] net/xsc: fix leak and missing NULL check

xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
dereferences xdev->dev_ops.

xsc_ethdev_tx_queue_setup() misses the NULL check on the
rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.

Fixes: fb7d4f7ae39a ("net/xsc: add device initialization")
Fixes: 488262986eee ("net/xsc: support Rx and Tx queue setup")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c    | 1 +
 drivers/net/xsc/xsc_ethdev.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f4895..d685e0c2 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -365,6 +365,7 @@ xsc_dev_init(struct rte_pci_device *pci_dev, struct xsc_dev **xdev)
 	d->dev_ops = xsc_dev_ops_get(pci_dev->kdrv);
 	if (d->dev_ops == NULL) {
 		PMD_DRV_LOG(ERR, "Could not get dev_ops, kdrv=%d", pci_dev->kdrv);
+		rte_free(d);
 		return -ENODEV;
 	}
 
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 20d6f58f..a5c3e4a6 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -545,6 +545,12 @@ xsc_ethdev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 
 	txq = rte_malloc_socket(NULL, sizeof(*txq) + desc_n * sizeof(struct rte_mbuf *),
 				RTE_CACHE_LINE_SIZE, socket);
+	if (txq == NULL) {
+		PMD_DRV_LOG(ERR, "Port %u create txq idx %d failure",
+			    dev->data->port_id, idx);
+		rte_errno = ENOMEM;
+		return -rte_errno;
+	}
 	txq->offloads = conf->offloads | dev->data->dev_conf.txmode.offloads;
 	txq->priv = priv;
 	txq->socket = socket;
