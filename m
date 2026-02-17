Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A6E8384C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:44:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A64440674;
	Tue, 17 Feb 2026 06:44:40 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 03EDD4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:38 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1uDfm1495978 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 TAqiDe3Gl3fK+a8lX4x1hGdoZtiglrZZdrdFd+L8+g=; b=IO4/Bg0s2zIvNcAhs
 vRz4JE6iGjTD78OkzDXwj8JWwMXl8A1SazMnZ8PIFNlg8vfcq6mE6yWT9NFdyit8
 a9A+CMVVdwXAwFPf5SeY5szoRO+pKbLsAjaLfXoFFR/cBRMnchpilVH+PGGLCssF
 LKA4/grWyoQL/2WXVfNcdB4UvW3wHPHMb2k3w8tyt1tbA57FcqM2v+ju2nOahFYm
 mSCeBiPoRonLPHb/DQBNyOxwvg6fZR+z54tc2NOw4Uf3JqPf7J0TKttnRYZKOOQw
 M59Bp8pyuH3krnfQqt3fnfjmB9ncNcfkuxP7UQ19jjVD0ncpo+iIiLb3BBV8XHOJ
 IPG2w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cbe6ck1kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:44:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:44:54 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id B308A5B696D;
 Mon, 16 Feb 2026 21:44:34 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 09/18] net/cnxk: skip write SA for cn20k
Date: Tue, 17 Feb 2026 11:13:36 +0530
Message-ID: <20260217054345.2759687-9-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KO9XzVFo c=1 sm=1 tr=0 ts=69940046 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=NXbdYXIHLiDtoYsHkOwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8zv0TRIwi-SHKSIHbdqhAJhDPFOREMTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX70Bseod/ly7/
 KV31bTPIhZ7GnT/Rfb54cuSR056JsuQcAzoiDd9B1XmdFe25vepF94NVGQHdN6o2JjexJwqpStV
 zgX4ktMJY6TNMMgV6xGhp39QhkvDJppyka2mu90CHK/LSYMeLmD5HaF9LUy8yOHzuS2moBg9Ubd
 Oi0Nz6kdFmdQ1r8vispGMwmheepMtPOs1hANHWjAiYnrWSVN9kNPoQZ6HDbjwSeXWtzsD5ZxYah
 c0Ev2Z3NN679aHCEJPM8Q0VVpNm2JXgmrZNDfbdh8cAbgiumxBqr4fNBAuMQd2zhPh4T7AiC3aw
 oooMUstYNLRRnJG3lEL2Ca6SriQQIiUy//dZM0qHxMAT+s1aDdzRxYPXvvorpNflmugwhP7CiGe
 3wlOtA4BgBB27TVrX1/lTrCr6LChHUMTsm8+/+K4DGOnprU7gy0zYO3E7LMb1qSDwlJPOwqRntC
 oId310Ah/P7VB+uvZsA==
X-Proofpoint-GUID: 8zv0TRIwi-SHKSIHbdqhAJhDPFOREMTe
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

For CN20k platform, write SA option is not required.
This will disable it and execute the hardware suggested
sequence to write SA context.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated commit message.

 drivers/net/cnxk/cn20k_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 20be35c0e0..7e9e32f80b 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -948,8 +948,8 @@ cn20k_nix_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 	/* Register up msg callbacks for PTP information */
 	roc_nix_ptp_info_cb_register(&dev->nix, cn20k_nix_ptp_info_update_cb);

-	/* Use WRITE SA for inline IPsec */
-	dev->nix.use_write_sa = true;
+	/* Skip WRITE SA for inline IPsec */
+	dev->nix.use_write_sa = false;

 	return 0;
 }
--
2.34.1

