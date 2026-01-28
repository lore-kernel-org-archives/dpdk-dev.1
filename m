Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1AED3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1206840431;
	Wed, 28 Jan 2026 07:04:13 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 152D6400D6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:10 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S0YHBU190463 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 CbhH7PCgRpO1fDrZ1iT3OiZEnCRzqVWBt3bGVSmOm0=; b=M8oeUn1SNY91OcHym
 MR/xxRc9dlOBeiDLKxMZp+SXx9CstFCDPvKSq0hviw5ael+I59K4sFct5s2dMn1a
 6PQJJzs2/m9lPh5nYqRKYMTKRGpWQrZyuOxm0ATx0A38GN29H+YKsYNneYhEnt1k
 DW45oQ+LpT9MYZ/V2IJXZF6nnj1UTEypNOIGlDQ3SmcK0zh6IrLMAC2C5/xbm1p7
 6iFCjy6bh0ynHLUNalpbQw6zBb9WT5jmE7G4MmSRgmnt+iV7fNBlEP9yg77zasHI
 rHoxuTlZX5maRQXk32Fd1Xdp7IlauPBWdORs4R8o7fV9UOWty15iiv38jLdSHDJn
 ICQig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4by80yghdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:09 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:24 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7E9E73F706F;
 Tue, 27 Jan 2026 22:04:06 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 07/18] net/cnxk: avoid security flag for custom inbound SA
Date: Wed, 28 Jan 2026 11:33:05 +0530
Message-ID: <20260128060316.3967610-7-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FYc6BZ+6 c=1 sm=1 tr=0 ts=6979a6d9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=XyxXChsBumu1WMGwIQ0A:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX5JG3KHHKAWBK
 9OkmPan4ZPqjszHA6NXg+l/YYg46RIQWdWFJqFAi0INudw5QEx67XehuE2FRn1pMCgqmOf+Rfa+
 KQlB1flh+ZgsFiFuQSvLIyg6zVlK4yqqCj8qJgYPslWef9Z7tKKIgFDtjGluRrnKegVLWmEDSa/
 +cEQAEH8KldIyveL6pFddC4xEt19Wm0dWxHNr5VXQrWWIQCg045C2f3cFE2twiu0wJkL4pykG6D
 /R/z9HxkUl9ajtYGrSoc2x1fopgXV4YrVcVVYRLcyWnsm5D/CF9MwsLkX9llK1+BuqT8uQAlpIK
 NmmDFcoau07UzTSzPJvlbNkz8Ac4/IY2a89J0G4ikE239vcVWK7xRq2dJDXnkwXHYNMPESFuDjo
 4DFqhqIm7YZx3vAoFEQmXQtMHvCW2Wcdd88Q5y+9atV/kX2bGeDHIA51o9KwaYSNoJ0e9OSK6Bw
 6Jk0aEGfAviBTyot1Tg==
X-Proofpoint-GUID: jxpAzPe6MgBvURN0rPnCNVHc3U_vlLkh
X-Proofpoint-ORIG-GUID: jxpAzPe6MgBvURN0rPnCNVHc3U_vlLkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Avoid NIX_RX_OFFLOAD_SECURITY_F fast path flag for custom_inb_sa
config.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index a7ef1dd386..20be35c0e0 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -35,7 +35,7 @@ nix_rx_offload_flags(struct rte_eth_dev *eth_dev)
 	if (!dev->ptype_disable)
 		flags |= NIX_RX_OFFLOAD_PTYPE_F;
 
-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)
+	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY && !dev->nix.custom_inb_sa)
 		flags |= NIX_RX_OFFLOAD_SECURITY_F;
 
 	return flags;
-- 
2.34.1

