Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6FC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:06:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2675A427A1;
	Fri, 31 Jan 2025 09:06:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 362A54279D
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:03 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V70InQ004350
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 BMrYET1GMOFMVXmV0STlvfSDbcSTpn2hT8znynmO9U=; b=Gble/A1DNUIF/1Nro
 DEeRSZKI1Tcj0jqTTjG+23C+NqeqCKUPkZs7OITzTAQIbITa+z7qKXGXjKcaqp9d
 shDhFhMCIWBsHL55/iFxgGG0rqbDDMP7cAp3lIE8u/3p7CLanROv2LuSGe+ZKrit
 ZsxOwIPK7dopK5LGHwcLcRIAKz8gyVx4+ASgFUcYFibAiRHnNDnGQWgcG+AvJE50
 GbMazqVvmwwspIQsS7tF1zYiNleSVNPZsOMPm2jdG5ZbrhpWMf5jFl3Mb6yh/Tls
 fk48strckV0lcdnvUFdkydSS1z36ThB8unW/T37VNnkSthc6LvxC3uekUp/LrhwC
 nfC3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gsr3g30a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:01 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 08E8F3F705C;
 Fri, 31 Jan 2025 00:05:58 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 09/34] common/cnxk: add CPT LMT defines
Date: Fri, 31 Jan 2025 13:35:04 +0530
Message-ID: <20250131080530.3224977-9-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4Ht6QlTqSRaWJQhgDPS8n06UxR1QKiOo
X-Proofpoint-GUID: 4Ht6QlTqSRaWJQhgDPS8n06UxR1QKiOo
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

From: Anoob Joseph <anoobj@marvell.com>

add CPT LMT defines

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index c8cf9354da..ac27479371 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -60,6 +60,9 @@
 	 ROC_CN10K_TWO_CPT_INST_DW_M1 << (19 + 3 * 13) |                                           \
 	 ROC_CN10K_TWO_CPT_INST_DW_M1 << (19 + 3 * 14))
 
+#define ROC_CN20K_CPT_LMT_ARG	   ROC_CN10K_CPT_LMT_ARG
+#define ROC_CN20K_DUAL_CPT_LMT_ARG ROC_CN10K_DUAL_CPT_LMT_ARG
+
 /* CPT helper macros */
 #define ROC_CPT_AH_HDR_LEN	12
 #define ROC_CPT_AES_GCM_IV_LEN	8
-- 
2.34.1

