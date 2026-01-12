Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C2C9EC7D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D18640BA4;
	Mon, 12 Jan 2026 13:23:15 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2761640B9B
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:23:14 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60BNHe8o4109721 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=8vMqBvTM+A4y7mlVKHNgXjl
 43YCKruvDRPhyoTPgI6M=; b=T+4VMgvTyTnxDEGF1Jx1Vh6tS8o4NADTLuzHvTl
 hBv+oeeDz18UWixG72g2uJNgDwQlbqGhoANqcr/lkg97zfxMI8jncI0OR84dJO1u
 H4uEdSb56kxlWoZdMVHlhWVOWTXY4SVui60hNbwl0g3CSrnP4rc5souPP8OJDE4O
 /P8IglYvtcv4iEzaMBmLZ7fqGyOQYWceIVIchVNRA0mqlot47AogEar3Q2JUBEvQ
 GTivyjc3/3EXFRdtgybWRV7edOX1MIYTbQI/kwudLC9jDG6kC9OhmHe6bicvztlU
 QRYopFPvNjdL7+eXN5jB2PjZFXGeUZGec85kaWzN26SCXtA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bmbw8t413-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:13 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 12 Jan 2026 04:23:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 12 Jan 2026 04:23:12 -0800
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A47B53F70A1;
 Mon, 12 Jan 2026 04:23:10 -0800 (PST)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/2] align crypto CPTR as per platform
Date: Mon, 12 Jan 2026 17:53:07 +0530
Message-ID: <20260112122309.2448535-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ygw7FV7shTMrnMBuTsXLF2BVNbJZJSy0
X-Proofpoint-ORIG-GUID: ygw7FV7shTMrnMBuTsXLF2BVNbJZJSy0
X-Authority-Analysis: v=2.4 cv=SradKfO0 c=1 sm=1 tr=0 ts=6964e7b1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jRy6b6r3VE0oKd58g5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5OSBTYWx0ZWRfX5Wojp/P8Yq4d
 qdFL0nfRldCPGAdL1vB6IgahQX6ZGD9ehtQR12UQXhkv0uSfnbnk4lRWJN4dGC4x43ENm1yKSW9
 YvENyNeSrTFl9XgvZfTfLLBFuOrV0dWdA9k3//OkS6AlbvHLLIe5MPEGHGbfmbk/7bPE+oifjJ2
 DLw7rnDbe77kDgq7eiLpnTXPQ55Y/7egT1jo42vu29JdiN+z75ryAaOrLLJ9xNIlklAN6tz7NeW
 rZ/urSEkOyCsQ2pJxum6Ll6JUZJj+EAsj8FxHxjCHcuDgzWEobU4ui2eX/sF4FRvjIb7sINN3qN
 eIdIH7oOgWfs3neoSm6MZgF+h7tkhULBqfFCQI/+OFGj+UQPkyn5W5/jQeAi2HzhWKmGS87OyqF
 cUzHWr4jL+3+DsodxAY2UrF9PJ2kN5Q4uNcsGYVMImwTq7lX83YRMIJZe7F6bPpRXXPO9XRqT0/
 r+//FI1Lw6S5pEJ/IFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
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

Aligning CPTR as per HW requirements for
cnxk crypto PMD.

Nithinsen Kaithakadan (1):
  common/cnxk: set CPT cache line size per platform

Tejasree Kondoj (1):
  crypto/cnxk: align TLS CPTR to 256B

 drivers/common/cnxk/roc_cpt.c       |  4 +--
 drivers/common/cnxk/roc_cpt.h       |  5 +++
 drivers/crypto/cnxk/cn20k_tls.c     | 47 +++++++++++++++++++++++------
 drivers/crypto/cnxk/cn20k_tls.h     | 15 ++++++---
 drivers/crypto/cnxk/cn20k_tls_ops.h |  6 +++-
 5 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.25.1

