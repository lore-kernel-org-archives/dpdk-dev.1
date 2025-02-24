Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC5C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC15A41104;
	Mon, 24 Feb 2025 10:55:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DF67040E42
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:55 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKh001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=M
 gr6qTctNoRCkAuQ+R4Zwniz3U3lDbQt9BlnjXnG1w0=; b=jl5+VMXw4ZjWS+nsx
 PumGhDUP3VfdnOHDcgNy5xFu+FdqLUqYibbeFbbd5Fnqh+f1elB+sE7Q+hZZXR7N
 K0xFhUc7ZVntt2G8G6qG6OcmvjTARFUSwDmQ/OyMC6sZT2KlSy8K2BI3wkqBi829
 hOTQHHJYywyNU3DoTxGwFYAeur/guO1+b8l5WJh7YDObjGVTBH0QWrdS67OdZ8+z
 8lpQ/fn3nZnbWQsjvcmOLgCaz7wsFbOMAybFsMs+adOc4Y9c98M0J62uzE+4Tsc2
 ZW+ypK9z8tK+wZgeKryNdT0O2lfKzHWOGS/zmKhQx+8wepxK3rXiPNSJtTq11ZqR
 bMd3Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh3c-16
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:38 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 099453F7067;
 Mon, 24 Feb 2025 01:54:35 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Monendra Singh Kushwaha <kmonendra@marvell.com>
Subject: [PATCH v3 30/33] common/cnxk: add stats reset for inline device
Date: Mon, 24 Feb 2025 15:22:38 +0530
Message-ID: <20250224095241.1263700-30-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: N_NUWaB7bvcOqSYIMhrTa1_CouWRhBFP
X-Proofpoint-ORIG-GUID: N_NUWaB7bvcOqSYIMhrTa1_CouWRhBFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch adds support to reset inline device stats.

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.h     |  1 +
 drivers/common/cnxk/roc_nix_inl_dev.c | 27 +++++++++++++++++++++++++++
 drivers/common/cnxk/version.map       |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 2db3a0d0f2..dab4918535 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -130,6 +130,7 @@ void __roc_api roc_nix_inl_dev_lock(void);
 void __roc_api roc_nix_inl_dev_unlock(void);
 int __roc_api roc_nix_inl_dev_xaq_realloc(uint64_t aura_handle);
 int __roc_api roc_nix_inl_dev_stats_get(struct roc_nix_stats *stats);
+int __roc_api roc_nix_inl_dev_stats_reset(void);
 int __roc_api roc_nix_inl_dev_cpt_setup(bool use_inl_dev_sso);
 int __roc_api roc_nix_inl_dev_cpt_release(void);
 bool __roc_api roc_nix_inl_dev_is_multi_channel(void);
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 041ccd9c13..2e753440b7 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1295,6 +1295,33 @@ roc_nix_inl_dev_stats_get(struct roc_nix_stats *stats)
 	return 0;
 }
 
+int
+roc_nix_inl_dev_stats_reset(void)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev = NULL;
+	struct mbox *mbox;
+	int rc;
+
+	if (idev && idev->nix_inl_dev)
+		inl_dev = idev->nix_inl_dev;
+
+	if (!inl_dev)
+		return -EINVAL;
+
+	mbox = mbox_get((&inl_dev->dev)->mbox);
+
+	if (mbox_alloc_msg_nix_stats_rst(mbox) == NULL) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_nix_inl_dev_init(struct roc_nix_inl_dev *roc_inl_dev)
 {
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index 36eb46e3a1..cdbfc1d39a 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -252,6 +252,7 @@ INTERNAL {
 	roc_nix_inl_dev_is_multi_channel;
 	roc_nix_inl_dev_is_probed;
 	roc_nix_inl_dev_stats_get;
+	roc_nix_inl_dev_stats_reset;
 	roc_nix_inl_dev_lock;
 	roc_nix_inl_dev_rq;
 	roc_nix_inl_dev_rq_get;
-- 
2.34.1

