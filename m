Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2727C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90CEC40E20;
	Mon,  9 Jun 2025 12:40:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 738EC40E24;
 Mon,  9 Jun 2025 12:40:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55940rBQ009750;
 Mon, 9 Jun 2025 03:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 Zip1AN+A4vkFTwERSVeqKgcqfzcGB9n7z8QfQndOjQ=; b=cL3aLh6wuT6khXnBL
 VP2WDE2Ewe4b4so4+PkiW3Oho4CnddUTwO0THwsWrRNFwTLNf6dmV+jr8mw6J3VL
 v8Q+Dp2UAYg7gXX2KimdLTjZj2M24yrR0D2PvOH3qpcqlt5ax8J3fBPfM9N7/bOu
 TKac2xEffZ7aDqhv0liNEYmDA1awnv+/zj9FAzq1+h6dQloyIcRxSJeD4o+Y4MRc
 i/ElwN5WfjFM2Z70qrxIYt3TKtyis0yKley3+0W7QSHM3Z5hoTUDcvqtSL0OeeUz
 D8lOHzZIo1nDSduAUbZw0trszgXrZgZx4+MR1VK10l3qT6M3LOxAuCEBoFaz02lr
 dF/Ig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 474mxkas9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 03:40:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:40:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:40:45 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 9B6EE3F707D;
 Mon,  9 Jun 2025 03:40:42 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 1/7] crypto/cnxk: fix compilation error
Date: Mon, 9 Jun 2025 16:10:32 +0530
Message-ID: <20250609104038.3102767-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfXxwHisRkmpCk0
 TK83TAG/6fMyAEBQmV9X3mQzJv8RXF1VLccRK9lU50CwF9g/J77hI36jj82w5TYh1otXUksSy6n
 YBIiFwQJanx8N7xQZCJEtS6aoQeDOLZv+zLbJzkxjA5qQukF57vNSug1g6/QojHH30jZjR6nMj9
 kp6oSqTavrew0gUW7OjizAHqgVmaTXaHvmfW5E/emtDjL+aEMaL8vFiznHPhjytQuSs3v/iQiVS
 S8ItTsMIo9TGu/2VhCtk/5nI3uWvyX3lNz7svQJtxp6YT4agVnmqMFmottAIhWdE9eIHeGUta8A
 xLFVLrOpArDNESRsJWW/Ap9W9tD1GrxGlfV40JrC+3jH0lT4PMy+sFZrqCNd1Roku04wLe04mRD
 UjfoS8xdB8Vq7n/ZvTkkM4K51r+EIU3t+8Si1kPvWj7AWDZ0lsPQPuT9F4gflVr5JWc60kAW
X-Proofpoint-GUID: DKqBm5NXaWXKKauWFVgVrnYvgrHfG8XX
X-Authority-Analysis: v=2.4 cv=Lq6Symdc c=1 sm=1 tr=0 ts=6846ba2e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=3qcCxIY1meboau1-x00A:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: DKqBm5NXaWXKKauWFVgVrnYvgrHfG8XX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

Fixing compilation failure by including
required headers.

Fixes: 26bb5c4de63e ("crypto/cnxk: add CPT raw submission PMD API")
Cc: stable@dpdk.org

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
index 02278605a2..46861ab2cf 100644
--- a/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
+++ b/drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h
@@ -13,6 +13,9 @@
 
 #include <stdint.h>
 
+#include <rte_crypto.h>
+#include <rte_security.h>
+
 /* Forward declarations */
 
 /**
-- 
2.25.1

