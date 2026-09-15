Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708BC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB323410F6;
	Tue, 15 Sep 2026 11:09:23 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 8903140A77;
 Tue, 15 Sep 2026 11:09:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru B48772C0BCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789463362; bh=Ps9exPGQSrcz8pjvr69VQLOG5a0vDtMhRBtDP82BRhQ=;
 h=From:To:CC:Subject:Date:From;
 b=MC9YUYU5oI2W+5VY2/f99eaQVhEPhU/j/lJp/WWfAbqTdhXF87OyWUac5RktHQCSv
 zQ9h/PzuttWh+SCB4DlMONEFRdniVLdqbeLGjx8S8sGNaYqwLk6MOSDqol0NCHRMOP
 o9jQk4ezI/boI9MFgZDyW6AujQi2BMzWsp4c1ocI=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id B48772C0BCB;
 Tue, 15 Sep 2026 12:09:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 7E7622C0B6E
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 7E7622C0B6E;
 Tue, 15 Sep 2026 12:09:21 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: simplify NVGRE pointer validation
Date: Tue, 15 Sep 2026 09:09:19 +0000
Message-ID: <20260915090919.431388-1-Evgeny.Sokolov@infotecs.ru>
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

Previous validation guarantees that nvgre_spec and nvgre_mask are
both non-NULL when this code is reached.

Remove the redundant condition and execute the enclosed code
directly.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Cc: stable@dpdk.org
---
 drivers/net/bnxt/bnxt_flow.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..4a38c036de 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -632,26 +632,24 @@ bnxt_validate_and_parse_flow_type(const struct rte_flow_attr *attr,
 				return -rte_errno;
 			}
 
-			if (nvgre_spec && nvgre_mask) {
-				tni_masked =
-					!!memcmp(nvgre_mask->tni, tni_mask,
-						 RTE_DIM(tni_mask));
-				if (tni_masked) {
-					rte_flow_error_set
-						(error,
-						 EINVAL,
-						 RTE_FLOW_ERROR_TYPE_ITEM,
-						 item,
-						 "Invalid TNI mask");
-					return -rte_errno;
-				}
-				rte_memcpy(((uint8_t *)&tenant_id_be + 1),
-					   nvgre_spec->tni, 3);
-				filter->vni =
-					rte_be_to_cpu_32(tenant_id_be);
-				filter->tunnel_type =
-				 CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE;
+			tni_masked =
+				!!memcmp(nvgre_mask->tni, tni_mask,
+					 RTE_DIM(tni_mask));
+			if (tni_masked) {
+				rte_flow_error_set
+					(error,
+					 EINVAL,
+					 RTE_FLOW_ERROR_TYPE_ITEM,
+					 item,
+					 "Invalid TNI mask");
+				return -rte_errno;
 			}
+			rte_memcpy(((uint8_t *)&tenant_id_be + 1),
+				   nvgre_spec->tni, 3);
+			filter->vni =
+				rte_be_to_cpu_32(tenant_id_be);
+			filter->tunnel_type =
+			 CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE;
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_GRE:
-- 
2.30.2

