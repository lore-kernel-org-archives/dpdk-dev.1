Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22055D2CE1C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 05:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED13040156;
	Fri,  5 Dec 2025 06:51:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D00DF40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 06:51:52 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B4JJG2H1156066 for <dev@dpdk.org>; Thu, 4 Dec 2025 21:51:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 d6pxLnIYctUdv7scEI3F5F0v2AclbFlmNhsUulBQ9I=; b=GqnExXnLpJN5SZDBa
 iC7uOBcd+WF3B4rdBI+4zkWcBzMclifwtck3JWUYLagYEZ5d/bWcGjcAr5cJAYg1
 A2AD895eKxB65vT0w+oQnvAWRNCLlfW9EDi/JsoFu/H5z1qhvM/v6HsQnTnePmCq
 BpBAcOnC4RbGNZk01f1SPYwMPSA+keOj1BFZCkvJmhbHUN36o7EwX9l4p/gGKi8d
 Z/CYVcwRCwaGirXtUK+M+Nqb629ybofu0OfSuCAlFisrMnHJ7nVf1d7hSuy0VMwT
 LdAV9s3yaljVbywzr4MtFn+8+kg0fbZHlpsiM0OHAuHNEq0Arb4MdEDGYo/rdYOZ
 KU8Ag==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4au6n1at4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Dec 2025 21:51:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Dec 2025 21:52:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Dec 2025 21:52:05 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id B1BB43F710A;
 Thu,  4 Dec 2025 21:51:49 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH v2 0/2] cnxk: add HALO support for CN20K mempool
Date: Fri, 5 Dec 2025 11:21:32 +0530
Message-ID: <20251205055140.2395369-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251204065203.1866809-2-nkishor@marvell.com>
References: <20251204065203.1866809-2-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jypPJxe_YL5T6I4c-RJCjHDEXsYhlb1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAzOSBTYWx0ZWRfX5RzGH0MP3T6x
 3ZL7JVmJsrq7QrziWDYjs2SS/kFhQbOXU9b1oRmgYXqqrV7mLxXwqgC2MT1YXHBWY0qpSHkS8PG
 LhcCBlK59xsL0U+kHGMiFLN8tfJaj0KcmLHXlGcW9cFRuPwc9rmYq3efVGtYCZb6FOZMUYVwNbs
 ElnvfRKbDcRWpjJ4wc3A9i/AnIKgXVRFoez+CaIFVOr/mhqFT9qlt08OwelQyn6Scq4ApXmP2o2
 mxdBOwBxVGmTK0+QsBpoyTOP3krnGrpi25zvnue51re0S/dzrViLR6hpPR92p18/hykiZIoUXDv
 3Rt8tbgDIzzYKW9ovDEPsvLGoXE5NkzfP3LdhlosILPpeTHSsbmyLP6lJ448/VjxD2yAKyZREhe
 0j6WHSnHohM4zB1slfKa1rfwgMHeaw==
X-Authority-Analysis: v=2.4 cv=b/O/I9Gx c=1 sm=1 tr=0 ts=693272f7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=BBAdJYo9JbGUQZk1-88A:9
X-Proofpoint-GUID: jypPJxe_YL5T6I4c-RJCjHDEXsYhlb1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
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

This series of patches adds support for HALO in CNXK mempool driver.

Changes in v2:
 * Fixed compilation warnings.

Nawal Kishor (2):
  common/cnxk: add support for halos
  mempool/cnxk: add halo support in mempool

 drivers/common/cnxk/hw/npa.h                  |  81 ++++++
 drivers/common/cnxk/roc_idev.c                |  25 ++
 drivers/common/cnxk/roc_idev.h                |   3 +
 drivers/common/cnxk/roc_idev_priv.h           |   1 +
 drivers/common/cnxk/roc_mbox.h                |   6 +
 drivers/common/cnxk/roc_nix.h                 |   1 +
 drivers/common/cnxk/roc_nix_queue.c           |  46 ++-
 drivers/common/cnxk/roc_npa.c                 | 268 ++++++++++++++++--
 drivers/common/cnxk/roc_npa.h                 |  20 +-
 drivers/common/cnxk/roc_npa_debug.c           | 201 ++++++++++++-
 drivers/common/cnxk/roc_npa_priv.h            |   3 +
 .../common/cnxk/roc_platform_base_symbols.c   |   2 +
 drivers/common/cnxk/roc_sso.c                 |  35 ++-
 drivers/common/cnxk/roc_sso.h                 |   1 +
 drivers/mempool/cnxk/cn10k_mempool_ops.c      |  19 +-
 drivers/mempool/cnxk/cn20k_mempool_ops.c      |  60 ++++
 drivers/mempool/cnxk/cn9k_mempool_ops.c       |   2 +-
 drivers/mempool/cnxk/cnxk_mempool.c           |  40 ++-
 drivers/mempool/cnxk/cnxk_mempool.h           |  16 +-
 drivers/mempool/cnxk/cnxk_mempool_ops.c       |  11 +-
 drivers/mempool/cnxk/meson.build              |   1 +
 21 files changed, 750 insertions(+), 92 deletions(-)
 create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c

-- 
2.48.1

