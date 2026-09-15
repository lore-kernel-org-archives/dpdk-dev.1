Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EBC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07FCD406A2;
	Tue, 15 Sep 2026 10:42:35 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 29BB240290;
 Tue, 15 Sep 2026 10:42:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 7E3AB2C0BB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789461753; bh=dudabxHlNMrXM6grTaccDodOyeaS9BgfWIB+sZBf9oo=;
 h=From:To:CC:Subject:Date:From;
 b=vNbbWAm9+TVobkUsR4mRPvrp2VHVzQm0c/Qov+5u0DWQhYXCtYEPqE2VtytoixssZ
 CH9TvYo7RxmoO/c/EzkyuvDcqhIYHOlSw0XBjOdT3QJJpInEB9E/urK9diuBOjcMlN
 81/SmfGSGP9TddsMvvE3mFV1Q1MdKZTncwwFiIIA=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 7E3AB2C0BB2;
 Tue, 15 Sep 2026 11:42:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 2CEAD2C0BA8
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 2CEAD2C0BA8;
 Tue, 15 Sep 2026 11:42:33 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Mike Baucom <michael.baucom@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Shuanglin Wang
 <shuanglin.wang@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: add debug log for ulp_regfile_write failure
Date: Tue, 15 Sep 2026 08:42:30 +0000
Message-ID: <20260915084230.430706-1-Evgeny.Sokolov@infotecs.ru>
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

The return value of ulp_regfile_write() is not checked in this path,
but failures may indicate issues when updating the EM insertion
status in the regfile.

Add a debug log to help diagnose potential failures during flow
processing.

Fixes: dd0191d5e70 ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2d89f10d5e..66cd538c83 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -603,9 +603,11 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 				BNXT_DRV_DBG(DEBUG,
 					     "Fail to insert EM, shall add to wc\n");
 			}
-			ulp_regfile_write(parms->regfile, tbl->tbl_operand,
-					  rte_cpu_to_be_64(val));
-		}
+			if (unlikely(ulp_regfile_write(parms->regfile, tbl->tbl_operand,
+						       rte_cpu_to_be_64(val)))) {
+				BNXT_DRV_DBG(DEBUG, "Regfile[%d] write failed.\n",
+					     tbl->tbl_operand);
+			}
 
 		if (rc && rc != -E2BIG)
 			BNXT_DRV_DBG(ERR,
-- 
2.30.2

