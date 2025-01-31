Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C9C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:06:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0651A4278C;
	Fri, 31 Jan 2025 09:06:02 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 265CD4278C
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:00 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V52egd016233
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 HioFiN0FN9vBZh8UPXjunVFRiJyAtR4fA4HVVwpgHM=; b=MU0lh73Ce4O9HZ39v
 4bJ0P0eXcaW9OQbarNXuTjCoQf47Wd4tIKaTdAZEJzsI6ui+O56OYsQHSQtNjzCo
 ihGZXFZSwcE6ejYnKnqsJOJxVmW3yqu8mteO1xHaUH+RC1OUIsncYl/qrb1k5uAN
 cM2TYsnB1BYUdxw9opbV9/g+G8DgX6t/r38aV2A32QEmgHmGATA4xQj16Vk+1QzE
 XtSUA259AvnCZ9miDXeY/dqgIBjeaEzuPmqzuh6SL5x2CGbTqA7jGlf8tBRBUEwk
 l4E0YXk7hSGZO7MTeCsuVd3L4V/x8BY1JRT40XDz8T8Pb+QKsJ9y3+L13/7/BC2r
 BqbOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gr1986yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:05:59 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:05:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:05:58 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id C56553F705C;
 Fri, 31 Jan 2025 00:05:55 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 08/34] common/cnxk: add CPT cn20k device enumeration
Date: Fri, 31 Jan 2025 13:35:03 +0530
Message-ID: <20250131080530.3224977-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -Kn5QvO40AQUqmHkg_Ty4Ocy0-DfraiB
X-Proofpoint-GUID: -Kn5QvO40AQUqmHkg_Ty4Ocy0-DfraiB
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

Add CPT cn20k device enumeration.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/roc_constants.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/cnxk/roc_constants.h b/drivers/common/cnxk/roc_constants.h
index 67cd74b28a..ac492651de 100644
--- a/drivers/common/cnxk/roc_constants.h
+++ b/drivers/common/cnxk/roc_constants.h
@@ -55,6 +55,8 @@
 #define PCI_DEVID_CN9K_RVU_CPT_VF  0xA0FE
 #define PCI_DEVID_CN10K_RVU_CPT_PF 0xA0F2
 #define PCI_DEVID_CN10K_RVU_CPT_VF 0xA0F3
+#define PCI_DEVID_CN20K_RVU_CPT_PF 0xA0F2
+#define PCI_DEVID_CN20K_RVU_CPT_VF 0xA0F3
 
 #define PCI_DEVID_CN10K_ML_PF 0xA092
 
-- 
2.34.1

