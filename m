Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE33C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D68D402BA;
	Tue, 15 Sep 2026 11:55:10 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 1FFB04003C;
 Tue, 15 Sep 2026 11:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 571AF2C0B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789466108; bh=GTclUZKUc0pJjhq4G4PydcWTJhh+xm0IFusJe7L67LU=;
 h=From:To:CC:Subject:Date:From;
 b=uI6T+kmj81VbZAfqyzlRKN8wfW3KRxRoj6Ta0n2uNTMGNednxTmOLMZ89gsizz8Vu
 zyC2igG9XYtfZW9EhOKCU1/h2uQPU0D+nplnkkmlUwiqcoNJtLbAvZjNQU7+b0lG2Y
 uiGQIFxAsZ23XMqSkryhZvx+FfftsqxKSkaOLdK4=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 571AF2C0B1D;
 Tue, 15 Sep 2026 12:55:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt F22172C0B19
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id F22172C0B19;
 Tue, 15 Sep 2026 12:55:07 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <damodharam.ammepalli@broadcom.com>,
 Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH 4/5] Fixing the printing the data that can be referenced by
 the null pointer
Date: Tue, 15 Sep 2026 09:55:04 +0000
Message-ID: <20260915095504.432070-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 09:01:00 #28584736
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

---
 drivers/net/bnxt/bnxt_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 920b298486..6da4247a7a 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1408,7 +1408,7 @@ void bnxt_print_link_info(struct rte_eth_dev *eth_dev)
 			(uint32_t)link->link_speed,
 			(link->link_duplex == RTE_ETH_LINK_FULL_DUPLEX) ?
 			("full-duplex") : ("half-duplex"),
-			(uint16_t)bp->link_info->active_lanes);
+			(bp->link_info)?(uint16_t)bp->link_info->active_lanes:-1);
 	else
 		PMD_DRV_LOG_LINE(INFO, "Port %d Link Down", eth_dev->data->port_id);
 }
-- 
2.39.5

