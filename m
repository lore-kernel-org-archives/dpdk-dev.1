Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8FC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14BF40A89;
	Tue, 15 Sep 2026 12:40:10 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id E7FEB40A7A;
 Tue, 15 Sep 2026 12:40:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru C9DA22C0BA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789468808; bh=jb9YWMCdGVM4QZcNho83oKPJM8N/NZG6aEg7MSeb8EQ=;
 h=From:To:CC:Subject:Date:From;
 b=Sgpu8o8BPLb+QK7K0p1WfOnD0+1Th4yV2Ld4dHiiBjdUuP0UxdDuHRnLSiI2dpOIU
 6nMXb5E2n1JiphUiMEPfjB78ey0uoFwHxb+6OzEHJpGoIYutR7syvTghQwvA037CyL
 JBXJBQQsYD+Y6YoahTFWO8sxKLzP9rCyDZOQxfCE=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id C9DA22C0BA5;
 Tue, 15 Sep 2026 13:40:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 759CF2C0B19
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 759CF2C0B19;
 Tue, 15 Sep 2026 13:40:07 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Evgeny Sokolov
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] Adding the return values checking
Date: Tue, 15 Sep 2026 10:40:05 +0000
Message-ID: <20260915104005.467027-1-Evgeny.Sokolov@infotecs.ru>
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

---
 drivers/net/bnxt/bnxt_ethdev.c          | 29 +++++++++++++++++--------
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c  |  2 ++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..c99c375412 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6395,57 +6395,68 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 	if (ret)
 		goto err;
 
-err:
 	/*
 	 * Handler for "mpc" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,mpc=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
 			   bnxt_parse_devarg_mpc, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "app-id" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,app-id=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
 			   bnxt_parse_devarg_app_id, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "ieee-1588" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,ieee-1588=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
 			   bnxt_parse_devarg_ieee_1588, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "cqe-mode" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,cqe-mode=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
 			   bnxt_parse_devarg_cqe_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "representor" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,representor=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
 			   bnxt_parse_devarg_representor_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "scalar-mode" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,scalar-mode=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
 			   bnxt_parse_devarg_scalar_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "app-instance-id" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,app-instance-id=1"
 	 * This argument is required for enabling truflow hot upgrade feature.
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
 			   bnxt_parse_devarg_app_instance_id, bp);
-
+err:
 	rte_kvargs_free(kvlist);
 	return ret;
 }
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index fa98b2bca9..facce8f125 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
 		return;
 
 	rc = bnxt_ulp_cntxt_tsid_get(bp->ulp_ctx, &tsid);
+	if (rc)
+		return;
 
 	rc = bnxt_ulp_cntxt_fid_get(bp->ulp_ctx, &fid);
 	if (rc)
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
index f17fb6e3b2..075071620f 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c
@@ -404,7 +404,7 @@ ulp_mapper_tf_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 				BNXT_DRV_DBG(DEBUG,
 					     "Fail to insert EM, shall add to wc\n");
 			}
-			ulp_regfile_write(parms->regfile, tbl->tbl_operand,
+			rc = ulp_regfile_write(parms->regfile, tbl->tbl_operand,
 					  tfp_cpu_to_be_64(val));
 		}
 		if (rc)
-- 
2.47.3

