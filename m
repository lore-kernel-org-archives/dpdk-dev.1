Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD98C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:07:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C1D6427CF;
	Fri, 31 Jan 2025 09:06:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E5B1A410F9
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:38 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V52eh7016233
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 MFzmTSEoAbe4mrYZeuzIRZuyqkG/5nB/XmONApdRJM=; b=H//njW9g17x4hKuAj
 h/bTx9EUgR2sWY02xhqbXmlozZ8wI7zYqjhRTpMkHgwAcR4wUi3xUyyXxagX3SeB
 k/qkQ8TwC3PKlbreD1+fg2iL4C4i/SFQhcDRNFF808+F9Tj9ePJPncyxEvFyOLWX
 3Jp0JS7usmDqNu/QSKHsuWQbirfy9lslqy3COo50tmD17MaNSu84wW2h1hUh2/z5
 0Z6qA9xCcU8rzwrLoh819ig/l8Lcv9p2iD+RZwaXJFF1ai2Bz9AUxWTnktMy6l35
 EkR7GFSZ4ef0pCAbkR3Q3jfmbfMTaR+K3WD/om18f7sdhhT9RZKVRxMaZCiwpmTE
 SMr+w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gr198763-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:36 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:36 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 49D5C3F7045;
 Fri, 31 Jan 2025 00:06:34 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 20/34] common/cnxk: add API to fetch inline profile ID
Date: Fri, 31 Jan 2025 13:35:15 +0530
Message-ID: <20250131080530.3224977-20-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 76NAR3kmrZjx0BzAn-Hf8CQZsn3S84hQ
X-Proofpoint-GUID: 76NAR3kmrZjx0BzAn-Hf8CQZsn3S84hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

For Inline device, add new roc API to get IPsec and
reassembly profile id.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 60 +++++++++++++++++++++++++++++++
 drivers/common/cnxk/roc_nix_inl.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 652698d13b..6927de6505 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -743,6 +743,66 @@ roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix, bool inb_inl_dev)
 	return (uintptr_t)nix->inb_sa_base[nix->ipsec_prof_id];
 }
 
+uint16_t
+roc_nix_inl_inb_ipsec_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+	struct nix *nix = NULL;
+
+	if (idev == NULL)
+		return 0;
+
+	if (!inb_inl_dev && roc_nix == NULL)
+		return -EINVAL;
+
+	if (roc_nix) {
+		nix = roc_nix_to_nix_priv(roc_nix);
+		if (!nix->inl_inb_ena)
+			return 0;
+	}
+
+	if (inb_inl_dev) {
+		inl_dev = idev->nix_inl_dev;
+		/* Return inline Ipsec profile ID */
+		if (inl_dev)
+			return inl_dev->ipsec_prof_id;
+		return 0;
+	}
+
+	return nix->ipsec_prof_id;
+}
+
+uint16_t
+roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev)
+{
+	struct idev_cfg *idev = idev_get_cfg();
+	struct nix_inl_dev *inl_dev;
+	struct nix *nix = NULL;
+
+	if (idev == NULL)
+		return 0;
+
+	if (!inb_inl_dev && roc_nix == NULL)
+		return -EINVAL;
+
+	if (roc_nix) {
+		nix = roc_nix_to_nix_priv(roc_nix);
+		if (!nix->inl_inb_ena)
+			return 0;
+	}
+
+	if (inb_inl_dev) {
+		inl_dev = idev->nix_inl_dev;
+		/* Return inline reassembly profile ID */
+		if (inl_dev)
+			return inl_dev->reass_prof_id;
+		return 0;
+	}
+
+	return nix->reass_prof_id;
+}
+
 bool
 roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inb_inl_dev)
 {
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 12f36187cf..10bf7d5c25 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -140,6 +140,8 @@ int __roc_api roc_nix_inl_inb_fini(struct roc_nix *roc_nix);
 bool __roc_api roc_nix_inl_inb_is_enabled(struct roc_nix *roc_nix);
 uintptr_t __roc_api roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix,
 						bool inl_dev_sa);
+uint16_t roc_nix_inl_inb_ipsec_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
+uint16_t roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
 bool __roc_api roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inl_dev_sa);
 uint32_t __roc_api roc_nix_inl_inb_spi_range(struct roc_nix *roc_nix,
 					     bool inl_dev_sa, uint32_t *min,
-- 
2.34.1

