Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B0C021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67E0240A6F;
	Mon, 24 Feb 2025 10:40:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0481540669
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:40:49 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O8UucI015468;
 Mon, 24 Feb 2025 01:40:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 SYHzFaGz/odCLWv5gV6U17YSk3OwnnY+lIVAd+aCDw=; b=aRxaFFlDXiOuvfs4U
 agpZ3XyTTfd4z7SEZlpMA6yU2HsEPIEk0ej/b9PfYyYMqBtGp3dO5ECCPWPeUyeZ
 kZ5i9Rhqfqi5nncDX/qUkMyydw3G/I0RY3AyAClWPXPa298eiNiYzRIaXHYCgf66
 yDNQcULxV5owTAGkRgAUXERaEGTkMPdaWS5UrzWIgrh6zFmu3mQ+FWEm2qJiVoVj
 hkN/mUTN530XPmzcskIxNPlFGk1cCHQ+nf4PZ2KCINKPbvQM7GDdqpei1n/2osHf
 0DcZ40FfsC9b2RzGBagUZEvFvELh1uAOTFIMkyoEa5/ltlisl3O1UOLUnHtRwPn1
 Cm1Ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450nasg4p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 01:40:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:48 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 540103F706A;
 Mon, 24 Feb 2025 01:40:45 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Monendra Singh Kushwaha <kmonendra@marvell.com>
Subject: [PATCH v2 28/33] common/cnxk: enable allmulti mode on rpm/cgx VF
Date: Mon, 24 Feb 2025 15:09:10 +0530
Message-ID: <20250224093915.1253215-28-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gkYokusCkLHfloQ_rS_czRN5XgDWjmUe
X-Proofpoint-GUID: gkYokusCkLHfloQ_rS_czRN5XgDWjmUe
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

This patch enables allmulti mode on rpm/cgx vf devices.

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 .mailmap                          |  1 +
 drivers/common/cnxk/roc_mbox.h    |  1 +
 drivers/common/cnxk/roc_nix_npc.c | 10 +++++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..d5eb506ad5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1059,6 +1059,7 @@ Mohammed Gamal <mgamal@redhat.com>
 Mohsin Kazmi <mohsin.kazmi14@gmail.com>
 Mohsin Mazhar Shaikh <mohsinmazhar_shaikh@trendmicro.com>
 Mohsin Shaikh <mohsinshaikh@niometrics.com>
+Monendra Singh Kushwaha <kmonendra@marvell.com>
 Morten Brørup <mb@smartsharesystems.com>
 Moti Haimovsky <motih@mellanox.com>
 Muhammad Ahmad <muhammad.ahmad@emumba.com>
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 6d927c7972..a82d120d1d 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1848,6 +1848,7 @@ struct nix_rx_mode {
 #define NIX_RX_MODE_UCAST    BIT(0)
 #define NIX_RX_MODE_PROMISC  BIT(1)
 #define NIX_RX_MODE_ALLMULTI BIT(2)
+#define NIX_RX_MODE_USE_MCE  BIT(3)
 	uint16_t __io mode;
 };
 
diff --git a/drivers/common/cnxk/roc_nix_npc.c b/drivers/common/cnxk/roc_nix_npc.c
index 8c4a5753ee..1d445c0d92 100644
--- a/drivers/common/cnxk/roc_nix_npc.c
+++ b/drivers/common/cnxk/roc_nix_npc.c
@@ -101,7 +101,7 @@ roc_nix_npc_mcast_config(struct roc_nix *roc_nix, bool mcast_enable,
 	struct nix_rx_mode *req;
 	int rc = -ENOSPC;
 
-	if (roc_nix_is_vf_or_sdp(roc_nix)) {
+	if (roc_nix_is_sdp(roc_nix) || roc_nix_is_lbk(roc_nix)) {
 		rc = 0;
 		goto exit;
 	}
@@ -110,9 +110,13 @@ roc_nix_npc_mcast_config(struct roc_nix *roc_nix, bool mcast_enable,
 	if (req == NULL)
 		goto exit;
 
-	if (mcast_enable)
+	if (mcast_enable) {
 		req->mode = NIX_RX_MODE_ALLMULTI;
-	if (prom_enable)
+		if (dev_is_vf(&nix->dev))
+			req->mode |= NIX_RX_MODE_USE_MCE;
+	}
+
+	if (prom_enable && !dev_is_vf(&nix->dev))
 		req->mode = NIX_RX_MODE_PROMISC;
 
 	rc = mbox_process(mbox);
-- 
2.34.1

