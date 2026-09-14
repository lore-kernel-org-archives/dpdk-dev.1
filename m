Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7DC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D770240272;
	Mon, 14 Sep 2026 13:49:29 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id CF84F40144;
 Mon, 14 Sep 2026 12:04:05 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380243; h=from:subject:to:date:message-id;
 bh=fLfPK1o3MPir2jUI5dY8EoqNMmBa1rV+hUxJdcgpuDs=;
 b=KQHlwxKYtgeTokE0y2FMMIIAPaF0b+zinEdyU9A1q1ysWLS9dG3Fz58GMnyYkfEBzeMqjDQluFV
 PkQBYNJRhv9wpJkBe9Z139wggXaVsFGeglKrtMagom1dA2hSphIlWbl6/+uEKoYOqV1QL7/swwS6H
 Jqf7TZqG5U/ev5jky6drH7jG4jUcDIl+m2+6E4RoZwy2CgpnltPhOlvJen0dhqgJMuxjeegEd019L
 hnR0+sX28AtDhV5DUlTv5Afa6fWV9wJoDBahDnTadT0nVRMIXT8x9jteCyDRNPFYezz033C0mnHrh
 m4fHOzTR57wb4Dg6XQD4f90EWta76a7Sby3Q==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:04:02 +0300
From: Artem Novikov <naa@amicon.ru>
To: <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <naa@amicon.ru>, <rrv@amicon.ru>,
 <lvc-project@linuxtesting.org>, <ting.xu@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/ice: remove unreachable DCF scheduler branch
Date: Mon, 14 Sep 2026 13:03:50 +0300
Message-ID: <20260914100350.53842-1-naa@amicon.ru>
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

Non-leaf node validation rejects any non-NULL WFQ weight mode before
checking the SP priority count. Therefore the later else-if branch
cannot be reached, because wfq_weight_mode is guaranteed to be NULL at
that point.

Remove the dead branch to avoid keeping an impossible validation path in
the DCF scheduler parameter checks.

Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
Cc: stable@dpdk.org
Cc: ting.xu@intel.com

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 795b6e683d..5895407331 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -188,12 +188,6 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
 				RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SP_PRIORITIES;
 			error->message = "SP priority not supported";
 			return -EINVAL;
-		} else if (params->nonleaf.wfq_weight_mode &&
-			   !(*params->nonleaf.wfq_weight_mode)) {
-			error->type =
-				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
-			error->message = "WFP should be byte mode";
-			return -EINVAL;
 		}
 
 		return 0;
-- 
2.43.0

