Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D6C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:50:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08FA240A6E;
	Tue,  3 Jun 2025 13:50:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A5216406FF
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKnOM010637
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 NT2PMZaoGjHXal4xNlt+JkO/H2fS+M8nOvxS5d6cIw=; b=ZATw1csmSKlwn6f42
 8hRva8DaOJV2ZFJN6bIjV7EFMV8fyOYeg5mnTjPvP0nuT0bp7C9JqKJN9KpoMud3
 18RvWOg8Dt6Kjo9YQHrPhgwJVtG3PwgjjW9XeUwk7eR6rzKTOFYv27vh7oG70SXN
 XqaCkPo24W0cSimgQuVsA1i9Vf1tWZQUPe69pqU2Oxnt4gE0SHzaWEfGtK2CQCzy
 MdnPcev+n7nJqMd/TUskjx92ENpU29JEg1ZCGtYHqAvWjqP1JsrF9cxKPMjegVia
 Hl2MEaPP3DZUpTUbZSQ3FsmQCn3DlrzyAFBBv8tpiELl9hLxz82SafMh6ZCf2vQ8
 zocEw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98hw6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:36 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 441545B6923;
 Tue,  3 Jun 2025 04:50:33 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 03/25] crypto/cnxk: add dev info get
Date: Tue, 3 Jun 2025 17:20:04 +0530
Message-ID: <20250603115026.2664706-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX9J33jbdeAb9P
 /2sMISPA+DNe6TARk3/mZ9FzzCrA40qVT9DLuADTfd6yT9ZRtDUuJEqFa5kvy3MQMIuO5DomUod
 43AUW3wg5a30WtZa0HFW2RM8QcRB/wZBy4dUnl9wPJVFLJVtbo0ot37c0OHe8UkE/V/85dVaM2n
 Q3Vva/jOBUl/xrItwUNDZMvX2Kr/yS8dooYX//SNr/28OJX33QxO3BG7yNCJ1x8oQ51LjT/YTNB
 KYUJOKHO3fXt+a1kxWSp1BfP6oUwLr5lPDXbHH5AnSCz1mK3dY5plNlndYV7+lMamOqUYCA3FIo
 3DO5lmsZ9niP6bCKoOuK0OzPXOO6ZkBdGH4BHMq29CaotO+N/lBczAP2InhrTF6Zbpavf9b97AQ
 116KtlYz6hy4t6fFbBAubGWZzO35rEGyYpS8SiyM1Cm/dgHZ28E9nKlNB4Rtw9+mK7yVuat7
X-Proofpoint-ORIG-GUID: l8gKXMsGHOAsR-bE5WhF2Xg-hdbFLikm
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683ee18c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Pe1cafgnUAMM2Of7aycA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: l8gKXMsGHOAsR-bE5WhF2Xg-hdbFLikm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add dev info get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 64ab285235..ac321a2b91 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -33,8 +33,10 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 static void
 cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
 {
-	(void)dev;
-	(void)info;
+	if (info != NULL) {
+		cnxk_cpt_dev_info_get(dev, info);
+		info->driver_id = cn20k_cryptodev_driver_id;
+	}
 }
 
 static int
-- 
2.25.1

