Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5AECCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7ECC40E25;
	Thu, 13 Nov 2025 05:39:18 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 61EC640E2B
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:39:17 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMqYkX1056270 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 ePmewATE3KyCGC2COblLqwAla198RKKbB7q7zIzWNA=; b=FRtkOiV4AaOmNBicK
 OSbX+E6creTbEgyrmUC+qx6MicgeCF+e/t5LFsJNWGC+T58EgjVMOguwQRCpzkPH
 7FPOcg4YY0Feuy7RYt7tblDJD9+rNPFqOzBANAHku/mz2jd3fe5HAk493TcjjbHQ
 IPyamUuMnEW+vrdMRM++QREIG2Ovl/0IjN81ZTT/52FkpfofAEpO4HNt3YAJ22+w
 bjU5ohnl9YlGTDkyUlvg88qBsbMmxkE2XmnCaNa/cJG+cA0cHO3YUK7YpvHRL6hU
 GTTCZ4QPAGTXKMkYMrvQaNgUoeEzuXgO32OakbbcqCadwlyve+Mm/suJw0TtaDJF
 AMKdQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aa66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:16 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D2E463F7076;
 Wed, 12 Nov 2025 20:39:09 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v5 10/23] common/cnxk: feature fn to check 16B alignment
Date: Thu, 13 Nov 2025 10:07:55 +0530
Message-ID: <20251113043808.1180851-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=691560f4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=-bsIhdJEouxmazOkw5YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dbf7Zwu50-nf7i26T7rGS1EusoU2EEgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfXxPAFZEEWZrtj
 EUjBv7zYtNlFP28J34NdPpOtqjGmUqutgUgLhJJa4v0dyHwMNu7ZvpaDscSKWopgod099lffGHp
 sunOpDI/wYDeI36kZRPdSO3ytn4elFPHfKuQTpn27TmZe2DwEAdcuSGGddEYhCFhtF9kLwrVrl/
 6VZYhbFtirBH7WIkhphRuTRcgnSQl+BzLsE8DGgDTMyrK4dg3OH9gLkdigOo1ExjFiFS666kW8D
 vokdOPj08qO7hFe3ShTkqQjKtHmhBfDO2+zsFwLtadwjOZLOEVESG4VjMOyRe8pdCYSYSyuwqux
 BA6mf3mKVxIYnavUshrmh1seCkB2EnLrP7KRim4NdrjxCMfoq+1GdjSinSKQDZ6AqvUC7pECRnm
 M7HYTJFYSrlf46bHZr/sPN4AgLqJLQ==
X-Proofpoint-ORIG-GUID: dbf7Zwu50-nf7i26T7rGS1EusoU2EEgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Added function to check whether board supports
16B alignment

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/roc_features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index c7d2a73d99..9c6adfe058 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -132,4 +132,9 @@ roc_feature_nix_has_sq_cnt_update(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_nix_has_16b_align(void)
+{
+	return roc_model_is_cn20k();
+}
 #endif
-- 
2.34.1

