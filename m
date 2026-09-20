Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE69C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 14:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8151740B8C;
	Sun, 20 Sep 2026 16:42:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8C48A402C3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 16:41:57 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBopX8515748; Sun, 20 Sep 2026 07:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 0fOtMpekWgPYajUvNQXommznLcLEoMjChSnazfQF1U=; b=d8VNq2Y0odtmgnthP
 L6TKfFQw1YYgeQqAUqWsXsDE5XFVZ4euqKrehmblcNtC9UBPDMUsrNDQ4tSvMeo5
 QqAwlkfrXk4E7zopjBa/OvhJjYOojCXTq4b/81J5wGdnnn7pOgHIsU2QVZ8K7GZg
 IrpHLdcswBKPNfsCSGoAHdjJwRyj/rIcRKki0JCiHPD9+29UakSVKyhetuCaME3m
 VXJiDao0VnrKVApTdPoULbmBQgASpJfooCae+AFXFcz4Q2mJX8CLYRCM4idnnl28
 FM5a9akBLJvMXi63J9ibYRYDab9dk4Zu7VEinufEEEN0nPANMXIRkWNZZkI/T76/
 z/Dxg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gsqrmkmn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Sep 2026 07:41:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 20 Sep 2026 07:41:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 20 Sep 2026 07:41:55 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 055793F7040;
 Sun, 20 Sep 2026 07:41:53 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v2 4/4] doc: update 26.11 release notes for cnxk dmadev
Date: Sun, 20 Sep 2026 20:11:32 +0530
Message-ID: <20260920144132.762575-5-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920144132.762575-1-vattunuru@marvell.com>
References: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
 <20260920144132.762575-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX2HXExn2/Nrpa
 a6B29AoodpRZPraU18SMPw3qM2xOujFH1eGHkdzcYwA1jD6GWsM1qzKzZ6se/neW6FNNM4Tk4hp
 2ps0trEKOBTWkojo8QAowNk9McvCDwc5QzYt/2ITPfGxdxcm0i2jX2j2AGXkpgLxIcTfbl4s62G
 YBaExgIeQXMJL44vc9JQ0RGtwxx1SIRmW+ZydNwJePBdgsR7iJle0WjDd1MPVjgoL9lbmSmio3I
 SPqg9qgVtBe1JKOEz0vMf7TLkX53d6juKeagHuwxUuw/+LYayoOnw0wKJObmlcqQ3k8BFV3q5s9
 oDDFSEPDy5TJPDcdCkl0Y1/gcbthGzC65OSgnb66v5/7WPss9sRKQzUW5lHVN72fE+floVNMEDR
 3HT19BG0kbL1XNSgLTSfmNV5Ovx4LjlcE5wxFq0tbOWmd7C77en6ZGJnoODWsSuPOE7k7n2kDTv
 GU3VNx2VHZTpbtkTrPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX54dsaWM+Didm
 P3jSvDu/Nm4FcN6zI9DF8WIJfomTwnS5h0K8anDwBN7V/7Q9YdIPI2VtFuFusAdnM1TJXTXsv3X
 vKjDpA8ypdRdHdaoghK5ICrF+WUTpxg=
X-Proofpoint-GUID: kYCvM8PT-Bn1gY12KjNG_bnX0p5nYiBU
X-Authority-Analysis: v=2.4 cv=Ga2CDgXL c=1 sm=1 tr=0 ts=6aaff0b4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=Sc3mGeuHmLZSIqVDAyQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: kYCvM8PT-Bn1gY12KjNG_bnX0p5nYiBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Document CN20K DPI DMA PF/VF support and inter-process domain DMA
transfers in the Marvell cnxk dmadev PMD for DPDK 26.11.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 doc/guides/rel_notes/release_26_11.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..f9da09ab45 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,23 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Marvell cnxk dmadev driver.**
+
+  Added support for CN20K DPI DMA hardware in the ``cnxk`` dmadev PMD.
+
+  * Added support for CN20K DPI PF (PCI device ID ``0xA0E8``) and VF
+    (PCI device ID ``0xA0E9``) devices.
+  * CN20K DPI PF and VF devices can be bound directly to ``vfio-pci`` and
+    used without the ``octeontx2_dpi.ko`` kernel driver.
+  * Added support for multiple virtual channels per device on CN20K.
+  * Added support for ``copy``, ``copy-sg``, ``fill`` and enqueue/dequeue
+    operations on CN20K.
+  * Added support for inter-process domain DMA transfers on CN20K using the
+    access pair group API
+    (``rte_dma_access_pair_group_create``,
+    ``rte_dma_access_pair_group_join``,
+    ``rte_dma_access_pair_group_handler_get`` and related functions).
+
 
 Removed Items
 -------------
-- 
2.34.1

