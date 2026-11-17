Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3F606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=eWiQjTH0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37DBB402C4;
	Tue, 17 Nov 2026 12:14:39 +0100 (CET)
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 2FB3D402D4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 12:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794914070; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JgDFRu30WErl58ckRC93IhriMSt3YPe8bCPpGVjklGw=;
 b=eWiQjTH0fUOtKETyxiCDoaBlEw8Y0WINl8bzQwl/b9lNm4ngylAJagXWQYTpCb47DlQmOT
 ybqZbmkf63oXX5eHa8gZJTMpoCN6fe1o8Akh1M3GnrDZUirWcaNf7nvQ5n8CBkhlmDt6ti
 AkHYt/2/oc/xC8GowYhuZJf3hLk99D76fWWylZXquOxXk4x6Zukfz241gjdIeFwFn1WRcO
 5vszoUXH88/g0ZlfhZh+RCfcTuc+/GoTNFTbHhcKlB0l9Q/V/yh8sJs8OZpp3MqIR0E1aD
 mmFDRL1KSEixOS/vQMNlbAFEJ5EBIHsSZMIN15rW9PZmsMsKgLzre1k+N6n4hA==
Content-Transfer-Encoding: 7bit
Received: from [10.211.5.164] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 17 Nov 2026 19:14:27 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26afc3714+7fd5c5+dpdk.org+wanry@yunsilicon.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
Date: Tue, 17 Nov 2026 19:14:20 +0800
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: <dev@dpdk.org>
Subject: [PATCH v4 2/3] net/xsc: fix leak and missing null check
Message-Id: <1794914060.189871@yunsilicon.com>
In-Reply-To: <1794914060.606144@yunsilicon.com>
References: <1794914060.606144@yunsilicon.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 953409a9..f048efd7 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -375,6 +375,7 @@ xsc_dev_init(struct rte_pci_device *pci_dev, struct xsc_dev **xdev)
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
