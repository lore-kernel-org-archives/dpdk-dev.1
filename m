Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129E606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=MnJk7Oiq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108154064C;
	Sun, 22 Nov 2026 15:22:59 +0100 (CET)
Received: from lf-2-40.ptr.blmpb.com (lf-2-40.ptr.blmpb.com [101.36.218.40])
 by mails.dpdk.org (Postfix) with ESMTPS id 93D074064C
 for <dev@dpdk.org>; Sun, 22 Nov 2026 15:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795357369; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sGUl5/QuZpqxNcVAmYnnDe9x0xYeWrOurZpWY5vqyns=;
 b=MnJk7Oiqi3yX1z4BEpZRKAElrU3BciRbiX9wPSftykApmzDQW4B94wnVYGmdGIAD1Ijkk/
 0SQ9z0IWsgNWYHvS8SjjW9wcacVQ0DurMLiwnQzbyQSYx0CdGbkQ33HLi86XBkrnqAcnZW
 +3QJgG/uAC8aFjYfebbJvuHN+xaGvhe7/Wa5uRxLEeKCI0Da+XKF+I9dvh7oUn3jUZ8wJh
 IF+ub2iTKMj4V8brFfd5ufhRCujdNMiQJfcguhPJcLKpJHE/d11/7abLrkkiCJ9iSQKuFm
 7wOv7e1I/cKC3HwcHe3+0GK5+F6DX6jU1UAoTMIfiLASla0h5PUtaGWGE5L5KA==
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Sun, 22 Nov 2026 22:22:37 +0800
Content-Type: text/plain; charset=UTF-8
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Received: from [192.168.0.85] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sun, 22 Nov 2026 22:22:47 +0800
X-Lms-Return-Path: <lba+26b02fab8+70ac00+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <1795357356.312312@yunsilicon.com>
References: <1795357356.312312@yunsilicon.com>
To: <dev@dpdk.org>
Subject: [PATCH v5 3/4] net/xsc: check Tx queue allocation result
Message-Id: <1795357357.432789@yunsilicon.com>
Content-Transfer-Encoding: 7bit
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

xsc_ethdev_tx_queue_setup() misses the NULL check on the
rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.

Fixes: 488262986eee ("net/xsc: support Rx and Tx queue setup")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
