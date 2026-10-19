Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D0CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F33974064A;
	Mon, 19 Oct 2026 15:08:06 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6FBDA40297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:05 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8ON0J242492 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rXaKnWq1nYZfrEdKIJQs416
 F2fF6fQDGosAa7qh4THc=; b=hQZ7ppiNEKXWcKxqTlNNz8sD5d0YdiW81+EDacb
 axqSM5L2IzWyi2nk5iFXJYWq5wVCXC03ek+xX0hFRIvrfuLjDuKNwR89LI7sWIxU
 KfYmjd2Yq0VN1Mymhh96B05CejXwe+FNp0Xtyjl9JfDnZb2p2AxSMTXN9jskZPRI
 uuZjEH1BGTYWGm6zpTAquBYnAePuao1n6PIXldOVcqNefBAqclvApTlhE7/ftIiY
 xx8/UeEzkFd33NBpyv58h4O3V++xcBtCti37mKxx/31CYyz8+N6BpwH2P4d+6usc
 pU5h3DTLhmk+ED8hY9BNfwkPq63GexBWgHKTO6b8o4KdnnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hcw98k3b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:02 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 844C93F70B8;
 Mon, 19 Oct 2026 06:08:00 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 00/16]  fixes and improvements to cnxk crypto PMD
Date: Mon, 19 Oct 2026 18:37:41 +0530
Message-ID: <20261019130759.2181566-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tMnmtf9xL6tnEOo71LQpXir2kOXyxlLp
X-Proofpoint-ORIG-GUID: tMnmtf9xL6tnEOo71LQpXir2kOXyxlLp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwIdUwewaRzAF
 /iorqAvzZlnSp57I1LdiQSTrfjVPFS9/4T+jRZTwjD2NODqgnaFgshZ+dW2RRpWFBnsU6FJCRYG
 PUaZLBRK9YZKN+8df2V89pRaylafNoQ=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ad61634 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=1UHvJGfXtobXNyDZ0jwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwQZL0WSeYBdB
 grYDb/r0uzsQwWJOo40Nr2/AvDLtl57jamC1QdryY/PCxR9J5nn/1Xtvgpzwhjgzem1xXW8JqsR
 PierFf0ORrCKgBQzjAZvqRZG1RdJadftPrb01YjsfUYyxe+yGnvOYCVAnDEWwc34xDEXjktoiop
 b99A8GpqaG0lhwKz1pFbfFL5kynewJ43aVbQ+pUD160wYNN3yONhSlzuXCgKEAa6s0XY/+0NO9k
 ZJO23dXF0iROV7r5SRBoz5iBzvrJYnAXsRHwcptP//VmUzE5HrDxNRWcqPrfxTKiO3tscHGITFU
 kSnVORhTcDO4vz9zxlSqBeYZfIpIRkHzMqcJ+LgtoL3lZumbkXJhuXSrXnUAwol6y1rVRO3rm7F
 VnKTxJIffp+Gv3kGGf9IW9SJswl5Xg5GRA4nxPTXv1uFq+YV+FUt94VR/CaWhttHajXOGmRvvYZ
 /BIU3x6o4WdZyJGEyvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

This series adds improvements and fixes to cnxk crypto PMD.

Rupesh Chiluka (11):
  common/cnxk: validate cipher key length in IPsec SA fill
  crypto/cnxk: reject truncated TLS records in decrypt
  crypto/cnxk: validate TLS xform and keys before SA key copy
  crypto/cnxk: reject oversized SG vectors in raw datapath
  crypto/cnxk: guard trim len bounds in TLS 1.2 MAC trim
  crypto/cnxk: guard trim len in TLS 1.2 MAC trim for CN20K
  crypto/cnxk: validate TLS 1.2 MAC trim lengths
  crypto/cnxk: bound SG segment count in packet iov builders
  crypto/cnxk: bound SG iovec index in mbuf walk
  crypto/cnxk: add cq_ena devarg for CPT CQ mode
  crypto/cnxk: size CN20K IPsec SA by context length

Tejasree Kondoj (5):
  common/cnxk: use context invalidate for cn20k
  crypto/cnxk: return HW CPTR from cptr_get for cn20k
  crypto/cnxk: enable cq_all and allocate extra CQ line
  crypto/cnxk: fix CN20K CPT error recovery
  crypto/cnxk: enable ctx cache for cn20k crypto

 doc/guides/cryptodevs/cnxk.rst               | 16 ++++
 drivers/common/cnxk/cnxk_security.c          | 15 ++-
 drivers/common/cnxk/roc_cpt.c                | 97 +++++++++++++++++---
 drivers/common/cnxk/roc_cpt.h                |  3 +
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c    | 36 ++++++--
 drivers/crypto/cnxk/cn10k_tls.c              | 33 ++++++-
 drivers/crypto/cnxk/cn10k_tls_ops.h          | 12 +++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c    | 39 ++++++--
 drivers/crypto/cnxk/cn20k_ipsec.c            | 42 +++------
 drivers/crypto/cnxk/cn20k_tls.c              | 73 +++++++--------
 drivers/crypto/cnxk/cn20k_tls_ops.h          |  6 ++
 drivers/crypto/cnxk/cnxk_cryptodev.h         |  1 +
 drivers/crypto/cnxk/cnxk_cryptodev_devargs.c | 28 +++++-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c     | 10 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h     |  4 +-
 drivers/crypto/cnxk/cnxk_se.h                | 84 +++++++++++++++--
 16 files changed, 389 insertions(+), 110 deletions(-)

-- 
2.43.0

