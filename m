Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9FC5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E70440689;
	Thu, 20 Aug 2026 15:03:27 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3721940664;
 Thu, 20 Aug 2026 15:03:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.79.191])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5B103E09F0;
 Thu, 20 Aug 2026 17:03:23 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5B103E09F0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787231003;
 bh=u75byebEr2yvHqIJ/sAoj1kAdmHtMgqh6ece5qu0NkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lcrrgmjsb2P5JxfY6DEJSeH8TNB+VTUvzwEDgLi6pjj+MBfqSTAUcFPpJeFjBo1jF
 LQunBxl2hjDpofCOUsClHzt7GTjxDVk51yLSEJMkQSxLENbkIOGnH949ewSr5IiIdZ
 6yo5XEn+OJ7278p7oQqRnhiilSzbdyhzp/uxHnCsflw3ZAdLwXLtvAU9PqLblrSCB4
 POtr0lpuh9tXT+tink7prknTYA3tZcSiyHQO6ZJJlOubUlo2pLA3JduW/jcw2v+Jiv
 NwsVipaJy588PsCuT7F22gD65VwDQ4nHABEEfoguLTnnCkpIMhtaX+qXFjxCh2fT3F
 Wx417qjXiL21g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 1/2] net/sfc: fix shared adapter pointer set in secondary
 process
Date: Thu, 20 Aug 2026 17:03:13 +0400
Message-ID: <20260820130314.12251-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820130314.12251-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
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

Add the missing assignment to preclude NULL pointer dereference that has
happened in the context of the secondary process at the dev close stage.

Fixes: 5313b441d8ae ("net/sfc: separate adapter primary process and shared data")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/net/sfc/sfc_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 6be91789cf..13619b4b9a 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3224,6 +3224,7 @@ sfc_eth_dev_secondary_init(struct rte_eth_dev *dev, uint32_t logtype_main)
 
 	sap->dp_rx = dp_rx;
 	sap->dp_tx = dp_tx;
+	sap->shared = sas;
 
 	dev->process_private = sap;
 	dev->rx_pkt_burst = dp_rx->pkt_burst;
-- 
2.47.3

