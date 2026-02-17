Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715BE68169
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 10:39:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF22D402A2;
	Tue, 17 Feb 2026 11:39:39 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 06812400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 11:39:38 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GIxaK21907473 for <dev@dpdk.org>; Tue, 17 Feb 2026 02:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 Xkw44yvUR9XHDmxfghIYRn4M8J93aEhRizarY4Q4lY=; b=UNw/00HndDsTi4YBo
 t5l3oaIB6P4uAuikbntKjUUWKgAwvcY8f/0QxnrL/kVvf6/fbQg4k2TR/I+1iaYl
 RK0y3ptCf29AFGPi7Rj/HQzUHCZi4FQniWEzMunvmqOv1eiJ48nGSg1FiZR3UNYV
 wKWD9iQlsljpDOzGBiVMXsLyQUgBnrKMa/zksdltqLiMMArJ9UgA13eVwHG3/MTs
 Cw6CgHQpLQWfpKwcbLWGvnl29R8aAkFwIOtzpcTkt/I0r/HxeIvTuPfeyTn6IjoA
 vXWMQWwlacWFTwi7IXeWnhW+1WbmBDbSDP5RLQocaWOs0ZGNDBGQtk7BPtYHCr4s
 loy0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cbapcbmpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Feb 2026 02:39:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Feb 2026 02:39:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 17 Feb 2026 02:39:53 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id CE6C63F7089;
 Tue, 17 Feb 2026 02:39:35 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH v4 0/2] Add HALO support for CN20K mempool
Date: Tue, 17 Feb 2026 16:09:20 +0530
Message-ID: <20260217103932.679806-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251205055140.2395369-3-nkishor@marvell.com>
References: <20251205055140.2395369-3-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fMw0HJae c=1 sm=1 tr=0 ts=6994456a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=BBAdJYo9JbGUQZk1-88A:9
X-Proofpoint-ORIG-GUID: S3r84yfRIfrktRooyEeXP2v3vLpyGYdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA4OCBTYWx0ZWRfX1WerbEtizaC0
 XNoOJdr6VSNn5ZrmomPYTLvSIxzxN9JiXRde+i39Ieqx5/vQfajiabT+CxPtFktEJ8z5AUGdUGY
 y7vRFN8y/sL7WVBgUbqJdBKHxzAqQNyp9iYnU9IIL31/xm8xMSZ98wlIUnoRUv4nBlSXUxUVx+V
 S1GuJrVD14oV4u5qThdRg52RwkLjbAAwH4qzfOuM3oRzdRmLY51UfLufa37+rRit13iK2A7acll
 lvTfQu94K2nJ5Bgc40kBZ1APEjjqrDzZVItynUYyCgt5GLUUGYE9yx1qG/Lxu+JQVYSW7JzhraS
 I+AYWGYP+HL2Ot4r2r2YaRjN9OFBC8dmVSZLGI9UisRJFdlmMVThJXggx2jqgDE2H6SICeSH2GL
 peg3D9UjZ/PMvcCRPksOXf83pG3bCZHN6YPbnuMhaS8iOUPkuDApL5hsxsX79cSBQcAtgHwTbyx
 qzim7WiJbgzYlqMSzSg==
X-Proofpoint-GUID: S3r84yfRIfrktRooyEeXP2v3vLpyGYdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
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

Changes in v4:
 * Added roc_feature_npa_has_halo() as per review comments.

Nawal Kishor (2):
  common/cnxk: add support for halos
  mempool/cnxk: add halo support in mempool

 doc/guides/mempool/cnxk.rst                   |  24 +-
 drivers/common/cnxk/hw/npa.h                  |  81 ++++++
 drivers/common/cnxk/roc_features.h            |   7 +
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
 23 files changed, 778 insertions(+), 95 deletions(-)
 create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c

-- 
2.48.1

