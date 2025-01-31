Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECE1C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:05:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C84B410EE;
	Fri, 31 Jan 2025 09:05:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 061CC410DC
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:05:43 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V52WQi016178
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 85H+dv9YEnYOotlvuRPn2AkSp0Gv0QSAGbAIvoKISg=; b=b6vyzpUhVvVPLrekz
 0hRlUgLvOuRPamUjGrldh9tZPXuNECsRuwN+KvAQwaXS2Gnl2qhVVkz7UY/3+Mr2
 XWs3oSCa+oB3Aznm+ZvskPCNYG7VoJQxmg87/FTu3PYvJTUr5JwBan7Z8UDHgJru
 /MgPg9vOOZEHnjSVRvolPZkes7/AxWkY9ptKTnL+aYh/PAD+XSpFn8wfwkhYqiFD
 JcVWt/vdsnM8jhV7B+FUbJv5Ic/iRxKbkIc1fJkKw7EwkaCv5e08GKYOCROmyeOv
 Zzk2hTiCP2+qiDh1l5gRIFI/hf5BxkfM6ZDQH2E1BKfIOAcH+u32zzqlobf20DME
 pVpIg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gr1986xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:43 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:05:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:05:42 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id EC42E3F705C;
 Fri, 31 Jan 2025 00:05:39 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 03/34] net/cnxk: remove unnecessary delay on stats read
Date: Fri, 31 Jan 2025 13:34:58 +0530
Message-ID: <20250131080530.3224977-3-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wJMdHQ2wMssQ68beKvcCAoIm5GnTG_fL
X-Proofpoint-GUID: wJMdHQ2wMssQ68beKvcCAoIm5GnTG_fL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

Remove unnecessary delay on security stats read as
application is expected to poll if stats are not updated as expected.

It is expected that there would be a delay in stats to show up like
any other ethdev stats get API.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cn10k_ethdev_sec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 3f81913d41..68691d2bfe 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -1243,7 +1243,6 @@ cn10k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
 			    ROC_NIX_INL_SA_OP_FLUSH);
 	if (rc)
 		return -EINVAL;
-	rte_delay_ms(1);
 
 	stats->protocol = RTE_SECURITY_PROTOCOL_IPSEC;
 
-- 
2.34.1

