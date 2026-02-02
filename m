Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C84E73165
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 19:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B5B640667;
	Mon,  2 Feb 2026 20:33:43 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 78EFB402AA;
 Mon,  2 Feb 2026 20:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770060816;
 bh=jrtxb0MQ97tU7msavycEwMoRuNZVDzndbKaia4RPedw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BWEeq5otqGus4VhfBwAq5jaNlMsXxrrkM1HEZqfbwENwFehBPoN5H8TYaK05x/OY/
 2vQiG2dFhNZIeczQ9uSKxMhcSqQYJrjKXim/FlCHn50t6juqWe7/4FO0RsPppWl9bn
 aYquDvlxgk/I9xVjdFGFsF/Ih/5k4M+u/YxzczStuwvyihhgEslRxv4h4ORPu5NJG3
 e+m32Y6wnStfLDcHofGp8q49sxYPtP/qY6P3rEVIa4j5XGwuI8xJZ3Vi5gHX8jTLbN
 lI0TKyEQBJzbdlHfKoAWCKxPUhRLOWhmNDY1PZXxjH/G+0U/5Re2DbgXjaZ2U1RU0P
 QwuO33eX1VqgA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 55406118007E;
 Mon,  2 Feb 2026 20:33:36 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>,
	stable@dpdk.org
Subject: [PATCH v5 6/6] net/nfb: stop only started queues in fail path
Date: Mon,  2 Feb 2026 20:33:30 +0100
Message-ID: <20260202193330.3324681-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202193330.3324681-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

The driver should stop only running queues in case of error
inside eth_dev_start.

Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 5197642f61..967f127f40 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -139,11 +139,12 @@ nfb_eth_dev_start(struct rte_eth_dev *dev)
 	return 0;
 
 err_tx:
-	for (i = 0; i < nb_tx; i++)
-		nfb_eth_tx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_tx_queue_stop(dev, i - 1);
+	i = nb_rx;
 err_rx:
-	for (i = 0; i < nb_rx; i++)
-		nfb_eth_rx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_rx_queue_stop(dev, i - 1);
 	return ret;
 }
 
-- 
2.52.0

