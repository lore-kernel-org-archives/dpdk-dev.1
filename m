Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA27C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0886940E09;
	Mon, 14 Sep 2026 13:49:35 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id A0A8B40144;
 Mon, 14 Sep 2026 12:10:14 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380614; h=from:subject:to:date:message-id;
 bh=s88zLo1RdNMjd8k/j+b5Fc38lPFqsFPF9VT5wKshpAc=;
 b=JVPKTd/vVs8OYYL9Z3jJF9D+dPyJfy/sV3PY66g4HnGLVuhkA1Cj4WRYj4QKuQIW0HdCgwxlXdC
 HRp4Ml25vaQexf2qxvKU0nPC/UCGO6gOvcrEHA43J8C89xqNik5yLmAnfmDodsRQLHBedF0/p+30j
 Sw3ocrBO4vgFyv8wbRWHOfhPnZVZ4dSZHAJuTxsI71u7henX2ESwC2wSlymu9cJzWO3l4Am39um3b
 KwgXwxWvytMqYdSGYEuzopnr508mzIkjYie24jVkDlGA2rVAU/V0C6QkQlNWbNd/P9mDvXhL6dht+
 bXoIh3yJh/olF++4aTmAFPI/j6PGHR+S0p3A==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:10:14 +0300
From: Artem Novikov <naa@amicon.ru>
To: <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <lvc-project@linuxtesting.org>, <naa@amicon.ru>,
 <rrv@amicon.ru>, <ting.xu@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/ice: ignore WRED parameters for tail drop in DCF
Date: Mon, 14 Sep 2026 13:10:03 +0300
Message-ID: <20260914101003.55635-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:49:28 +0200
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

The traffic management API defines leaf WRED parameters as valid only
when the congestion management mode is WRED. DCF only accepts tail drop,
but still validates the WRED profile and shared contexts. A tail-drop
node with a zero-initialized, unused WRED profile is therefore rejected
unless the application supplies RTE_TM_WRED_PROFILE_ID_NONE.

Compare the mode explicitly against RTE_TM_CMAN_TAIL_DROP and reject
unsupported modes with a precise error message. Do not validate WRED
parameters for the supported tail-drop mode.

Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 795b6e683df55d447163e3f447b4e5b6f17552cd..5b5a90b37afec90619633539749c93993bc42616 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -200,28 +200,9 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
 	}
 
 	/* for leaf node */
-	if (params->leaf.cman) {
+	if (params->leaf.cman != RTE_TM_CMAN_TAIL_DROP) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_CMAN;
-		error->message = "Congestion management not supported";
-		return -EINVAL;
-	}
-	if (params->leaf.wred.wred_profile_id !=
-	    RTE_TM_WRED_PROFILE_ID_NONE) {
-		error->type =
-			RTE_TM_ERROR_TYPE_NODE_PARAMS_WRED_PROFILE_ID;
-		error->message = "WRED not supported";
-		return -EINVAL;
-	}
-	if (params->leaf.wred.shared_wred_context_id) {
-		error->type =
-			RTE_TM_ERROR_TYPE_NODE_PARAMS_SHARED_WRED_CONTEXT_ID;
-		error->message = "WRED not supported";
-		return -EINVAL;
-	}
-	if (params->leaf.wred.n_shared_wred_contexts) {
-		error->type =
-			RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SHARED_WRED_CONTEXTS;
-		error->message = "WRED not supported";
+		error->message = "Only tail drop is supported";
 		return -EINVAL;
 	}
 
-- 
2.43.0
