Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61DE83856
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:35:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF837402A2;
	Tue, 17 Feb 2026 06:35:00 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 102B84029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:34:59 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1NY9m1442388 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:34:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 96/B7IuOuZztbDrhbNmSPLB5h8uXH1R1xtMXxpwhOk=; b=if/IXMet3xuHTuQel
 8vMwA1vDzIxG7PMPEVD509tWoMeA/XH6eh790LhzowIeIqTDyFNP9LDER8oK+zK8
 uNL0WfgzQQGSYfCObXqTcnwQEOlI2pbQQkgCSAMdcSaV72UGpAQ8vjQ7CJ4Y00nw
 RnBhoJTdYAd4IsJC8EMAY0KWptZwkwLcB+85PQQDBEgmnYScNEqfIGgW4xBgxmTr
 IDkzB4wjh9iw84JJaTKTkKgq/IOSNP/nQFsUkbc1YZzrxOeY0GFdEoJ7AGoCWSIp
 O4mlm3EftXWe7wlmLTf0SgkqV8sL3XxMsZf8Y6Ig7Pqq2bMT0L99gwXzIO+wAcBy
 DzMvw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck0y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:34:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:35:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:35:15 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 5C0A23F707A;
 Mon, 16 Feb 2026 21:34:56 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH v3 0/2] Add HALO support for CN20K mempool
Date: Tue, 17 Feb 2026 11:04:42 +0530
Message-ID: <20260217053448.490168-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251205055140.2395369-3-nkishor@marvell.com>
References: <20251205055140.2395369-3-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=6993fe03 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=BBAdJYo9JbGUQZk1-88A:9
X-Proofpoint-ORIG-GUID: lIcRvZat0C9qgr7Z8MO0fvFBGYLXCzJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NCBTYWx0ZWRfXyqP2NDkymANe
 lCjlJQYC5eMLx1U7+U3AvXPVxz/nesawZTbxumdRoO+u7Qc4YgJ1rC7+SCjgbVbXeaSM+jNEbJV
 ABTn0UP4rOrYrDNzTNV762YCQChJuWb6gmX+M7KgVh832lxjEZksCJm+UUyvsFDRTzdJPJHCGoI
 y4smZTRDzOY6bhxDUtlun053DHWKHqKlAEwlyQ9qy5b1B71juysPm6WbU1xXaZ1smB9dsangmpj
 000OHXMKDK+gnuEP0xT6EQKdNy9Aq/WTK+zyo1B0wYxAQjxC/tlragu/KiIggMOldd9eI43XPOH
 rP+6c5Bd2dXe5dc/M549TK9hE5vVQnD8ca2Al3JYH+5zQz4s2rhyWbyDqP3Beeb+n4uT6pQST2g
 SJ8SAoeEpGUL1WEOJyGHsgdjFrUKhEVNpcvWEn+cOTT5VwoPVCLpRY9IeAufm6TGbNT5R/QJS4D
 HA8mot/y75J3/WR5QUQ==
X-Proofpoint-GUID: lIcRvZat0C9qgr7Z8MO0fvFBGYLXCzJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Changes in v3:
 * Added documentation for HALO support in CNXK mempool driver.

Nawal Kishor (2):
  common/cnxk: add support for halos
  mempool/cnxk: add halo support in mempool

 doc/guides/mempool/cnxk.rst                   |  24 +-
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
 22 files changed, 771 insertions(+), 95 deletions(-)
 create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c

-- 
2.48.1

