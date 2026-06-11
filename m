Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC061CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3B4C4327C;
	Thu, 11 Jun 2026 16:22:14 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 46A9A432C6
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:22:13 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXef12094976 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:22:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 6kOLT2jO/2svj5wv3bm9BthdXG19p+R17OEXwSHW+M=; b=PeGxB+cA5cttZyIZg
 uEWL2Ol8AYoNXbOFJsTlTDfKsCfKONnvDdtBjYZuHl+z5I30xwlqdoBaukXMRL8Z
 Fq6Ke7S+//OIL3rn33YxPymYp+BTkT6TY89xBvW+II4bLBDsNi1JzN1M/tEbj5Zn
 wniFEoAX6F8NLMOuzb0OInCMsca7oEAY1UoRLUJQMeqnWGLX0Fxx6wxYvvVyxTr3
 0zQf9g2OaYqpg2jK+JtDOx6nAQhPzLZhz4ocCjBCGoDRApKUhPTgGLD4BWnV7c7Y
 m6BexWTIIZERdgxlne+nzKPPA6rIDyMwova5usAIPClzbnz5LH7/qLVUULCHwprQ
 JyRzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w3737-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:22:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:22:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:22:11 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 0738C5B6974;
 Thu, 11 Jun 2026 07:22:08 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 18/22] common/cnxk: add FEC configuration support
Date: Thu, 11 Jun 2026 19:50:25 +0530
Message-ID: <20260611142029.3351415-18-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX3Vca9MW0Y+Sh
 srNdVFtVsIcX013KwLjfeIqAG/CS15DsNtSIUNs4MHOX+T1WKhVqnW/fT3JozGHEtxwHrdGCA2p
 G1c31XBvAd1LaVn3chU8yjX4PvX75DnKLuztGQMJPr01aM/4PIecOl+9iV7oYexoriaTbMibGf5
 c+dmBFW7MttErCiML2e4yMb33QGt/5wizKmeAGhm3dUVyWtQVPau9i0j42vdKerXA3n2+A/HYPN
 jk1DaxvX7uhzbnZw66zZMsEX/sIfiVuf9oCPxzOA6ZfQRUneJ2vywSYQgDxbFZzZYuVbNiEhnJS
 iXUYhf6AGm/hR5xZARNh0eZe0DyqosXcEFxCQY2gMtBXIjF3Dak5/GlipMh4RLOkCM6b+TZL6xq
 wPmNv0URSm7oAtywhpA4YgEdDHQknP4ihwPMnKaEkFARBabWKrc2UPcqdpZmqVDJKX5Lw7L1+Jj
 eBjEfRGdYA3s3Bva7uA==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2ac494 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=xu7QeC3gvlaRLQ3BY4cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX2KWsZfub4GuG
 ZW4+G9SatXRUFmc+XyO3KACLH4KwWF7ir7plLO0bFF1tOtp0IkkZaPU/B8J5Oml9XQ5opHarD/t
 asVK1S+ELTDi+zh0YTzWakMLBc5qfWs=
X-Proofpoint-GUID: iFhVY7jVMWGY2gQJ3xb9ZJ8DdzT4RizE
X-Proofpoint-ORIG-GUID: iFhVY7jVMWGY2gQJ3xb9ZJ8DdzT4RizE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Add ROC APIs for Forward Error Correction (FEC) configuration:
- roc_nix_mac_fec_set: Set FEC mode on the link
- roc_nix_mac_fec_supported_get: Query supported FEC modes
  from firmware

These APIs use CGX mailbox messages to configure and query
FEC parameters on PF interfaces.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_nix.h                 |  2 +
 drivers/common/cnxk/roc_nix_mac.c             | 52 ++++++++++++++++++-
 .../common/cnxk/roc_platform_base_symbols.c   |  2 +
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 49ede85f9a..802519f5e8 100644
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
index 376ff48522..9440cad33d 100644
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
@@ -283,7 +334,6 @@ roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 exit:
 	mbox_put(mbox);
 	return rc;
-
 }

 int
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index d1c9f2304d..ffae154788 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -316,6 +316,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_state_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_mtu_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_rx_len_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fec_supported_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_stats_reset)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fwdata_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_register)
--
2.34.1

