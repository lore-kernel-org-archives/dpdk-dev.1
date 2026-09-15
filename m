Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F7C88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC7840E72;
	Tue, 15 Sep 2026 11:07:20 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4C940A77;
 Tue, 15 Sep 2026 11:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A75C12C0B19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789463238; bh=kyIXMLZsvX+kQPlZliAKLO8fSy4gweEMc9gidg6X+h0=;
 h=From:To:CC:Subject:Date:From;
 b=q++UizSewZGTXslvAB0Ls/A54c03FS6GqIurW4DL7IQFI8+5c40DJ980bnzhmwzJ+
 XYLAvV8WeGdo+ITjCYWAiRhUDLXJ1PeIp8mrX8h37zmPJ6H9RNSvmzapOc2l21Js+A
 wSwvc8mY2009/iHpRq0v2Np2b8u3I5dNO9n+5jD0=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id A75C12C0B19;
 Tue, 15 Sep 2026 12:07:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 57FCC2C0BB2
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 57FCC2C0BB2;
 Tue, 15 Sep 2026 12:07:17 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: remove redundant VNIC NULL check
Date: Tue, 15 Sep 2026 09:07:15 +0000
Message-ID: <20260915090715.431258-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-01.infotecs-nt (10.17.0.3) To
 msk-exch-02.infotecs-nt (10.17.0.2)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 05:24:00 #28584173
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

Since commit 51fafb89a9a ("net/bnxt: get rid of ff pools and use
VNIC info array"), VNIC objects are obtained from the VNIC info
array.

The address of an array element cannot be NULL, making the NULL
check redundant.

Remove the dead code.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_rxq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 023cb0e174..b7e16c8a14 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -131,11 +131,6 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 
 	for (i = 0; i < pools; i++) {
 		vnic = &bp->vnic_info[i];
-		if (!vnic) {
-			PMD_DRV_LOG_LINE(ERR, "VNIC alloc failed");
-			rc = -ENOMEM;
-			goto err_out;
-		}
 		vnic->flags |= BNXT_VNIC_INFO_BCAST;
 		bp->nr_vnics++;
 
-- 
2.30.2

