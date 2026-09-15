Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB7EC88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:51:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A931740E2F;
	Tue, 15 Sep 2026 10:51:30 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id EB36840A82;
 Tue, 15 Sep 2026 10:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 728AA2C0BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462289; bh=3LIwTqG1okifUkrB6FUeelwNDycs8F8WbISQJ2nN7NM=;
 h=From:To:CC:Subject:Date:From;
 b=a2Ft0M+Tv2hTCjb9H76VUIaqiDdVztoa9p2gWfmlt5rHKLlLwD0UXw4TC7SAWxPgL
 mQn838890D+cVYaVAVV5UJryvkLZprTFRT+I9Uzwf4dLnaftxoT0YTgJrweGMbwiB+
 EgOvML+wbvIuEeAuCCLvNEw1NYKasjhE0Ebcv+RM=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 728AA2C0BBE;
 Tue, 15 Sep 2026 11:51:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 19F222C0BA8
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 19F222C0BA8;
 Tue, 15 Sep 2026 11:51:29 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <shuanglin.wang@broadcom.com>, Sokolov
 Evgeny <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: check TSID retrieval failure
Date: Tue, 15 Sep 2026 08:51:25 +0000
Message-ID: <20260915085125.430901-1-Evgeny.Sokolov@infotecs.ru>
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

Check the return value of bnxt_ulp_cntxt_tsid_get() and log an
error when TSID retrieval fails.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index fa98b2bca9..d5ce4c3c18 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 		return;
 
 	rc = bnxt_ulp_cntxt_tsid_get(bp->ulp_ctx, &tsid);
+	if (unlikely(rc))
+		BNXT_DRV_DBG(ERR, "Failed to get the table scope\n");
 
 	rc = bnxt_ulp_cntxt_fid_get(bp->ulp_ctx, &fid);
 	if (rc)
-- 
2.30.2

