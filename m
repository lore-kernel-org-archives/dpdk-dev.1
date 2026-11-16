Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DEB606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.a=rsa-sha256 header.s=mx header.b=Di4Qw0VI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9613402A4;
	Mon, 16 Nov 2026 08:38:55 +0100 (CET)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTPS id 99A0440294;
 Mon, 16 Nov 2026 08:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru BA3482C0BA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1794814733; bh=+u98GFDffSfjvq9qYliKvB96lBiNus9VMizWaFjcBwM=;
 h=From:To:CC:Subject:Date:From;
 b=Di4Qw0VI3Z9rMmqC3QVCrguk+993w0qeGlxq46HRjwGWCCGRGanSluUrgTVVmjJop
 lpHvINOq0ApULi6rCiLg++Uho2NZkll0ptzJStPB3o3ApqxGVZEqcXYgpEZ7tT2HgF
 gkWvK97Qu1uHTjDq2Jmgs8xwPSVAOIlwwh1ZmLNE=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id BA3482C0BA6;
 Mon, 16 Nov 2026 10:38:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 70BFF2C0B8E
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 70BFF2C0B8E;
 Mon, 16 Nov 2026 10:38:52 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>, Shahaji Bhosle
 <shahaji.bhosle@broadcom.com>, Randy Schacher <stuart.schacher@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: add debug log for ulp_regfile_write failure
Date: Mon, 16 Nov 2026 07:38:49 +0000
Message-ID: <20261116073850.236738-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/11/16 06:45:00 #28892229
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

The return value of ulp_regfile_write() is not checked in this path,
but failures may indicate issues when updating the EM insertion
status in the regfile.

Add a debug log to help diagnose potential failures during flow
processing.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dd0191d5e70 ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2d89f10d5e..ec6ddaf6d6 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -603,8 +603,11 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 				BNXT_DRV_DBG(DEBUG,
 					     "Fail to insert EM, shall add to wc\n");
 			}
-			ulp_regfile_write(parms->regfile, tbl->tbl_operand,
-					  rte_cpu_to_be_64(val));
+			if (unlikely(ulp_regfile_write(parms->regfile, tbl->tbl_operand,
+						       rte_cpu_to_be_64(val)))) {
+				BNXT_DRV_DBG(DEBUG, "Regfile[%d] write failed.\n",
+					     tbl->tbl_operand);
+			}
 		}
 
 		if (rc && rc != -E2BIG)
-- 
2.30.2

