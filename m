Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD61CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1524C402C5;
	Mon, 13 Oct 2025 09:00:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D3EA6402C5
 for <dev@dpdk.org>; Mon, 13 Oct 2025 09:00:20 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNu3is003130
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 g3t6i888jM1znbMAvXnyh2tOcerRydyiEO40Y9+r0Y=; b=RsaulZg/QLJln+Y5S
 ELvifKmQXIZmBLbi1mx5j4D4GX1g7lrt/bZzgBp0NM96La+N0Exbnxduyf6fffps
 jcoXpsTNYGFaRQlHRPWlA4HPIWpq+tSvhVL81QD5kLz2Hf+hQ0SMrCUIT6Mmw4hu
 uuUDAzFXXWnbPZbZnAZW1C16B4me16VK1+rlkuU4KEQq60il91h3ntsfLfsal+1/
 apOeQroS6Dutx74ujv2kwfgGP3PZqz46SVfBg7DHLn49pEeaSUZV47Wy6Y5t6dH+
 ZGgE4+FGyX6uQ7DEswhRIQ1NRjh5QMIPsJbV8P0v1Ktv3I94HI6X0fKIZDPAEu+T
 QgwgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1s8mdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 13 Oct 2025 00:00:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:28 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 65DF33F70CE;
 Mon, 13 Oct 2025 00:00:16 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 08/19] common/cnxk: update DF flag in IPv4 fragments
Date: Mon, 13 Oct 2025 12:29:38 +0530
Message-ID: <20251013065949.200414-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PIhw0PQ1k5nuQASdwZ3EWkACffgR2Sgh
X-Authority-Analysis: v=2.4 cv=ENQLElZC c=1 sm=1 tr=0 ts=68eca383 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=shHwveO5flH-z4HOgfUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfX/XkE9HXaN/j9
 J1akkwehkPDxyvgSip1dxSYaGFNc4aSJ26RG+E18xou6EyEdbcZZUjjD2P8M/hd+aSIJBs2rWDE
 ARovxg0I4ZwpLoQvTXOfic/nkaNbHE7VICb7O6UzhESijbVQC8S4k3aaRYCLJASlAb2tYDGdudD
 zUTNeym/19zkHeJqcOc5xA/sCCzY4uMKyXho3rgL5QXxmP1dtDputZdlUXoLnEBDBSboU8tYWc8
 phKkqpr/1tvV6wTkfb3S9sCn2JX3KA8jtrf0WH7mByeKLNfmuixHHjiAHPT3/igK9KvRQMsVO+8
 9qO9iI8rUEadKlgfcbGaJKw3HNRQr+B2a4k1Gm8NDSrlWExKeXcFzv2dq8TIJUSqkAawIwj5UHJ
 iAP+hNoZvH+c5DNikiVZ4yayx5zFpQ==
X-Proofpoint-GUID: PIhw0PQ1k5nuQASdwZ3EWkACffgR2Sgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

While performing IPv4 fragmentation, consider the DF flag from the
original packet header instead of setting it to zero.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 138090317a..12a12c6e35 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -240,11 +240,11 @@ nix_lso_ipv4(struct roc_nix *roc_nix)
 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
 	alt_flags.s.alt_fsf_set = 0x2000;
-	alt_flags.s.alt_fsf_mask = 0x1FFF;
+	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
-	alt_flags.s.alt_msf_mask = 0x1FFF;
+	alt_flags.s.alt_msf_mask = 0x5FFF;
 	alt_flags.s.alt_lsf_set = 0x0000;
-	alt_flags.s.alt_lsf_mask = 0x1FFF;
+	alt_flags.s.alt_lsf_mask = 0x5FFF;
 	flag_idx = roc_nix_lso_alt_flags_profile_setup(roc_nix, &alt_flags);
 	if (flag_idx < 0)
 		return rc;
-- 
2.34.1

