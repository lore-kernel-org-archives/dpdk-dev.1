Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1BACD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 04:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA21540289;
	Tue, 16 Jun 2026 06:35:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1108B40285
 for <dev@dpdk.org>; Tue, 16 Jun 2026 06:35:43 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0UBNK1374158 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:35:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 7KfgWaVJHsEvhnWyCutA5jkuH+XVAuRK7J7FA3Y3BI=; b=AzRSYD7lNd5PNVmC9
 +aFZj73/iW2o60YdI0V3QL3Dzqjnr+Mp3eam06KsdoX/lU/K41Od7TZtSqnHJPD5
 nOwyaCGi12+LabR0MlJlv8tEkInazDPeJVfXY98eLRbqV3BNUPiUG9Nug02n6T2a
 IkaVMkOMRZa9sX5IYeQAqbS7NGCM/ufPJwUEbXLuYlB+2fKWoR31EMvYb9WkJDC9
 NR/kgxpyWJZ6db/RGoIo9ZFXHDQDtLY6knms+eecTEbAFfQmhItZ06iS30Z2Xlgp
 LheDffV0OX++udaHy2G/S6hD1SEK0UanwXbPeZ7tnim+e5dL46E/kGu3BU3H/Uww
 cKr7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38gxpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:35:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 21:35:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 21:35:42 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 7C6CD3F7087;
 Mon, 15 Jun 2026 21:35:39 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 1/2] common/cnxk: add FEC configuration support
Date: Tue, 16 Jun 2026 10:05:35 +0530
Message-ID: <20260616043536.4034946-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260416120031.3553798-2-rkudurumalla@marvell.com>
References: <20260416120031.3553798-2-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YqVRPTAJs6Pg-C1UZDoqDlCXqmzlgPNU
X-Proofpoint-ORIG-GUID: YqVRPTAJs6Pg-C1UZDoqDlCXqmzlgPNU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA0MiBTYWx0ZWRfXzHGSCu+qwETD
 A5kMv3cyKfRNZukzSpxrb6+4VmC1p5DaWSWpkfYT744AdhLzryYwlmf9sNiPVtDJ39cyLYvdlcw
 ipQjEsERzBp3IwIFjtx3SzX9iuuaYoQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA0MiBTYWx0ZWRfXz87GHwRTOVRe
 Dce33ASn9z1k0fFoFOxXWPAjHRF/QsrAR5naWG/PMxl8LosG8G2Nl+AQNWxTg0udcW8wbRpkOZ5
 4N7uuRH2XBi/xI6uGdoboq9piKflKvSSRl4RnKZegqbvBPN5yK5XHQg7p0hSrPiYV1rJ/s88kqv
 OhkrAzw9EvgzNhXkKumsdy0vTFjx1zX//fOcKHVIUf12zG+w8R3/iYgigsqBHNVvsOaQREPRNl3
 2b4AyG1ZAwXwlz+ZBaolCYjiqXotC7TiKVXfxpYqXN4hd+Ywe8kf4O/3WE6IqFhKxFJEq9InShY
 AEhjcVipMEm+OjZ2mgZJ5M3BI3TC0pMDy5RT54XZWZKpr5k2w9h3AaGxJvaBY2KW+R8UDD+MyP0
 ia6xo5qx6xotAvY7W29hTY+mvx0vVJrLKZJbOTioSxB/KpWvGmEfN9InYQoPj/7hekPlZ67uFyW
 QJvezz7gUv8vMP2jhzg==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a30d29f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=xu7QeC3gvlaRLQ3BY4cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
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

Add ROC APIs for Forward Error Correction (FEC) configuration:
- roc_nix_mac_fec_set: Set FEC mode on the link
- roc_nix_mac_fec_supported_get: Query supported FEC modes
  from firmware

These APIs use CGX mailbox messages to configure and query
FEC parameters on PF interfaces.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
V3: Updated doc/guides/nics/cnxk.rst

 drivers/common/cnxk/roc_nix.h                 |  2 +
 drivers/common/cnxk/roc_nix_mac.c             | 51 +++++++++++++++++++
 .../common/cnxk/roc_platform_base_symbols.c   |  2 +
 3 files changed, 55 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 8ba8b3e0b6..6130e4c42b 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -975,6 +975,8 @@ int __roc_api roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 					struct roc_nix_link_info *link_info);
 int __roc_api roc_nix_mac_link_info_get(struct roc_nix *roc_nix,
 					struct roc_nix_link_info *link_info);
+int __roc_api roc_nix_mac_fec_set(struct roc_nix *roc_nix, int fec);
+int __roc_api roc_nix_mac_fec_supported_get(struct roc_nix *roc_nix, uint64_t *supported_fec);
 int __roc_api roc_nix_mac_mtu_set(struct roc_nix *roc_nix, uint16_t mtu);
 int __roc_api roc_nix_mac_max_rx_len_set(struct roc_nix *roc_nix,
 					 uint16_t maxlen);
diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 376ff48522..4f856677e0 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -257,6 +257,57 @@ roc_nix_mac_link_state_set(struct roc_nix *roc_nix, uint8_t up)
 	return rc;
 }
 
+int
+roc_nix_mac_fec_set(struct roc_nix *roc_nix, int fec)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct fec_mode *req;
+	int rc = -ENOSPC;
+
+	if (roc_nix_is_vf_or_sdp(roc_nix)) {
+		rc = NIX_ERR_OP_NOTSUP;
+		goto exit;
+	}
+
+	req = mbox_alloc_msg_cgx_set_fec_param(mbox);
+	if (req == NULL)
+		goto exit;
+	req->fec = fec;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_nix_mac_fec_supported_get(struct roc_nix *roc_nix, uint64_t *supported_fec)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct cgx_fw_data *rsp = NULL;
+	int rc;
+
+	if (roc_nix_is_vf_or_sdp(roc_nix)) {
+		rc = NIX_ERR_OP_NOTSUP;
+		goto exit;
+	}
+
+	mbox_alloc_msg_cgx_get_aux_link_info(mbox);
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+
+	*supported_fec = rsp->fwdata.supported_fec;
+	rc = 0;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 			  struct roc_nix_link_info *link_info)
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index ed34d4b05b..f116f32cf4 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -307,6 +307,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_rxtx_start_stop)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_event_start_stop)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_loopback_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_supported_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_entries_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_add)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_del)
-- 
2.25.1

