Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC8606A895
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=H8l732Iy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BC15402C3;
	Tue, 17 Nov 2026 17:47:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 8527C402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:46:59 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFSgas1878888 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:46:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Mqrf/qTPZt0UGFNXnRAmsKv
 +BxaY/+aT760UZuDTAQo=; b=H8l732IypLnW8qBA0bjXD15unGBcEYv5Ag8eWIk
 IgJbqg6XfmYKPVcIE+ymUB5gl4d0znchLcXcZlkeinP1F2i+ZYIfP6OynJ5/NLqX
 6DbEWikNOLnmv/vB78F44UzHC5WfAexJjNEw3eEWbmvwwToOc8BkCCC8ZIgVQeO7
 vDEJfsk3zRRSM93ZOd1Bak9eXR5FUvDaZ6N3ZD/1K+mENqiYM17RjI7iHjwWTwf1
 3Z6ZQHHRlkO0tXl6zPeX5l0BmVVyGN078nlmzluawBrlPgF5NcW9Dp5fiiqkMHFB
 yOUYMoVU45ZOLA+1K+lR4YKeHHhzGPoXsuxFsyydL9krxQg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j0kqn1vxa-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:46:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Nov 2026 08:46:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Nov 2026 08:46:44 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.38.196])
 by maili.marvell.com (Postfix) with ESMTP id B93793F704E;
 Tue, 17 Nov 2026 08:46:52 -0800 (PST)
From: Harman Kalra <hkalra@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Mohit Kumar
 Parjapat" <mprajapat@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] common/cnxk: fix inline CPT IRQ double registration
Date: Tue, 17 Nov 2026 22:16:46 +0530
Message-ID: <20261117164646.236458-1-hkalra@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PZpqFShd c=1 sm=1 tr=0 ts=6afc8502 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NiBTYWx0ZWRfX8ZIRHVB/WtGE
 UNfT1+cIWc/iajXhWIjRh47Ix9iStkamjqAX0QxvjrfXAq6kHabif34FSF1xrW9rJWN1aYLqvxm
 p+pmt4bZ4j+CTsc2dpEsuR1/lU1K2Ls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NiBTYWx0ZWRfX5x4CDPWpnCAP
 f0CghaSL1VDdwEtI2fYUAUUwjWHmshaXaH1I+//pOybDCNvj/NXrx+vCBQ5QWDDtDbe+JlwP2BW
 CWdPoXpjjBv3TfvYATJQCxHsIwPNed0NmahKn5mkCQZ5Mpb7YU/iSZ9G2vq1aBk3994cSWyxFY/
 FdIKRbJwz8JA4mvj5YI/5quDqL3qXo6WvQZIB5ld4GpXOuaIne3v2ffz6rys/ogC04uy82ZzAK/
 rpaRaLEfDx1sMU3HfS/nbsvKBhXoTKaDalgwz2oDL9JIdvUl7h8NAT3JX5qfT/obgowGofMs5VG
 QpntPW+QarZcOn5Ew4hw/Qvv6+dWP0KgWNXjTygpWBZxP7xI6eddc8wh1sOLakcvawSfJRTqkKe
 lsN1mWq4E8Tx3yHSVC73sS8rTdNs/SjNkaNIGTT6hxqqNk41R765D0T454JRXkJqUEjWcD6q6Z3
 jMCheqtjOhr/oJAZUZQ==
X-Proofpoint-ORIG-GUID: wAoj0nO6hQy7gecnBcvgjjHVIvVWfkxf
X-Proofpoint-GUID: wAoj0nO6hQy7gecnBcvgjjHVIvVWfkxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohit Kumar Parjapat <mprajapat@marvell.com>

Defer inbound CPT LF IRQ setup to nix_inl_cpt_cq_inb_setup() when
CQ is enabled so the same MSI-X vector is not registered twice.

Fixes: 42a7770cd0c9 ("common/cnxk: use one interrupt handle per vector")

Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index bfdeef2688..f0703f3154 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -420,6 +420,18 @@ nix_inl_nix_ipsec_cfg(struct nix_inl_dev *inl_dev, bool ena)
 	return rc;
 }
 
+/*
+ * With CPT CQ enabled, inbound LF IRQs are registered later by
+ * nix_inl_cpt_cq_inb_setup() with the CQ-aware done callback.
+ */
+static bool
+nix_inl_cpt_irq_defer(struct nix_inl_dev *inl_dev, int lf_id)
+{
+	return roc_feature_nix_has_cpt_cq_support() && inl_dev->cpt_cq_ena &&
+	       lf_id >= inl_dev->inb_cpt_lf_id &&
+	       lf_id < inl_dev->inb_cpt_lf_id + inl_dev->nb_inb_cptlfs;
+}
+
 static int
 nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 {
@@ -458,7 +470,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 		lf->msixoff = inl_dev->cpt_msixoff[i];
 		lf->pci_dev = inl_dev->pci_dev;
 
-		rc = cpt_lf_init(lf, false);
+		rc = cpt_lf_init(lf, nix_inl_cpt_irq_defer(inl_dev, i));
 		if (rc) {
 			plt_err("Failed to initialize CPT LF, rc=%d", rc);
 			goto lf_free;
@@ -485,7 +497,7 @@ nix_inl_cpt_setup(struct nix_inl_dev *inl_dev, bool inl_dev_sso)
 lf_fini:
 	for (i = 0; i < inl_dev->nb_cptlf; i++) {
 		struct roc_cpt_lf *lf = &inl_dev->cpt_lf[i];
-		cpt_lf_fini(lf, false);
+		cpt_lf_fini(lf, nix_inl_cpt_irq_defer(inl_dev, i));
 	}
 lf_free:
 	rc |= cpt_lfs_free(dev);
-- 
2.43.0

