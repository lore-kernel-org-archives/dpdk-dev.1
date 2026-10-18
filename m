Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBECCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3051C40A8B;
	Sun, 18 Oct 2026 11:54:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5A26E40698
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:54:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69I5teq81783529 for <dev@dpdk.org>; Sun, 18 Oct 2026 02:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 xk3GndfVhuwTJSVDT4LTnU/w9+IxV9mOT8M41Gv0HQ=; b=cb7sYYH4xBah85DAn
 BlAaxogxNjrmRKJEFR29u7qws8E5mknRcP5atV3SXBN97u2HbUcIi6SiS3zkOAsw
 iJ7MYqYfJZK6hCo+imFk81Dy/5IVRkUuucOxDVSC1WHOMKwVj2CDmwU3H9V6uBLp
 dDU1fyoD3zh0R+XP84T3lYUBGpNaW8t8RxPyoDC21hNKjgf4k5Cte+SbiPn0jEVU
 HH+1R2QDVOZxtC4qn9gL7s4qMEU4Ovshv3CvySj4/14Eu2Ji6fTLxm5wXCV0Qt6d
 PoU5vlaPEr6u6cLxmVbQOQm0Jvks9De5tmIs6uK1T+CNXSTfZnchWge2V0vZ3cw0
 smUGg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hc6cj29nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 18 Oct 2026 02:54:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Oct 2026 02:54:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Oct 2026 02:54:52 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 7D5133F704D;
 Sun, 18 Oct 2026 02:54:51 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, Vamsi Attunuru
 <vattunuru@marvell.com>
Subject: [PATCH v2 2/2] doc: update 26.11 release notes for octeon_ep driver
Date: Sun, 18 Oct 2026 15:24:37 +0530
Message-ID: <20261018095437.1531211-3-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261018095437.1531211-1-vattunuru@marvell.com>
References: <20260830163133.1399749-1-vattunuru@marvell.com>
 <20261018095437.1531211-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: E7KwBj0hKtPacQRBephnC4vrD1n_zM3m
X-Authority-Analysis: v=2.4 cv=L7KI0OT8 c=1 sm=1 tr=0 ts=6ad4976d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=v8o9b25e7WxfiL_yG7IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDAzOSBTYWx0ZWRfX2AtT+T06lf/Q
 KUVXON/GyX3AvoBGp+pp1ooZh/AavrQbSMVSqf+x9lguu34szlfZ9yuRWpsOVAlLSZwDKI0Lf+F
 Ln8ZgrsJ05MXBH86tDt/uHhY4lyLzsx/Q4x7IsgF/R78ZRPaRIMwXRLDcejh07Pqs7SHhJPQdiu
 MWVuxB8tT+eo77y8fAVlW7yw56esqah/DxMIkfe9oCoGlTrAy6MLV4kwVXhH0Ru1zZRV6C6yvX6
 Rv/G7itqn1Perhsw87MlzGNEvMNzyD6+jn1NvlWQarB/j5VaFrNdCcVA1b2H6UY6XIrFRmshK+1
 scp21o59iQ27Hau7D23lrFK1VMvIpRZMFM2ns+o3FQiEhgTXL9ztse9Q+CzdQwREv4FDCA2gZN5
 Gf84GgfsTjFyUpFK+DSv4uFqTswaGEQ/aHrtN6+4e+zp9OTzCj2DVgOpTrEayDWbgaGZxC/Su9L
 QmTip9LRX1lYZFTgzdg==
X-Proofpoint-GUID: E7KwBj0hKtPacQRBephnC4vrD1n_zM3m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDAzOSBTYWx0ZWRfXyoXvAM/wrX7g
 TGUiIDcg0IB2/T77Jty0W0+ABUNG0kAUQGqWWNWYbTLwVK+YrOGLxrAO8AVtr79M00HfGDgv2u5
 SNE+IhpiadzLFq9A3fI+7NB3FzL+fvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_02,2026-10-14_01,2025-10-01_01
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

Document CN20K SDP VF support in the Marvell octeon_ep
PMD for DPDK 26.11.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 doc/guides/rel_notes/release_26_11.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 235967d8c3..fd82e627d5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -236,6 +236,14 @@ New Features
   * Added support for CN20K DPI DMA hardware.
   * Added support for inter-process domain DMA transfers using access pair group API.
 
+* **Updated Marvell octeon_ep ethernet driver.**
+
+  * Added support for CN20K SDP VF endpoint devices (PCI device IDs ``0xC203`` and
+    ``0xCA03``).
+  * CN20K uses a mailbox to the SDP physical function for ring allocation and device
+    control. The ``max_rings`` devarg (``1`` to ``8``) sets the number of Tx/Rx queue
+    pairs on CN20K SDP VFs.
+
 * **Added per-queue statistics API in bbdev.**
 
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
-- 
2.34.1

