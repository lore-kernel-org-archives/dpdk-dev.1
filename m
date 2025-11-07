Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805D7CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D69840BA4;
	Fri,  7 Nov 2025 11:49:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 034864068A
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:49:02 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A7AKtZv2930303 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:49:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 LhOISwReuGuypB9xILFBsA8VWCNKvGmORx0qa8jPL8=; b=S4G8QxWL0C2uCFC/E
 Pz89QssQeKxWewWjOOduDH41TsVNzlXSsyzhYlJQftufGslnNIe3/A0Jp8WsvoPz
 bTtTEBp1YNLrGbwoW1jYR4MTkuk5Mq2HzpXkUCuEPtIO8PYX0ofdGn18bZvuKJKO
 kmiasRg9/DNg2egq+70B1+dSCPOfBfCHJcrJ8OIqPYHuO2MAx5qv+/q/2LMSKzx/
 EBe7ORhlU0rb5dghdQzr/vKwU3IravNGH/zq7C1gZ6J6CV8/mYkQbnaBxeiDjyTn
 V5lu2TCJvWjnR+LjP8Gj/ZvJ1YHTb3NfA1TvmEeSOZZe3qnaMNyzQi6Vy6eIs5+H
 ehL9Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9excg2fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:49:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:49:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:49:01 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 467C23F70C9;
 Fri,  7 Nov 2025 02:48:58 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v4 22/23] net/cnxk: fix illegal access of Rx inject LF
Date: Fri, 7 Nov 2025 16:17:46 +0530
Message-ID: <20251107104747.1131008-22-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX3J+r36utHo08
 z6WLrxQ8ZMmQc+X/kPfT9djLmUfkloeD7WQ+yd4PeT35lDcss0ddwsDC1Jp+crJ44qg9FUuOh0R
 E5nNDhiqar8TXmIxlG/nWAL8M9vggE0scTli1yZDuPvAb9SUJ3JAgvDVEGgAuy52HtFKFsO5u4T
 Jscpf5NJzR9E1sb64/BOR97yqESEZmQ0MFV7YGBGCUYR3rxwOCAczy1SO+ZYrVP/tyBIw4WJpdB
 PmXXx1QAtU39DagYrCyufs5xbehdcXSTlBkGg8xZVQ3eCrSKsjUP0mifM9XebvJgUg3069uBybq
 QicoBsdP5Dq9DoqKbRyic+QRlcuB2YllwDnaM86mrnpVgAXSOEyH+sY4pXYH2YH8rkBqNBG4bHV
 ippT2RivcVlUJjz3+Ia2fMSn7o2CJg==
X-Proofpoint-ORIG-GUID: ldDeizi-mSQf6D2OscpsTOstOwSQbd6J
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=690dce9e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=R85t8e4DdIUT_508euUA:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ldDeizi-mSQf6D2OscpsTOstOwSQbd6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Fix illegal access on error.

Fixes: 47cca253d605 ("net/cnxk: support Rx inject")
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/net/cnxk/cn10k_ethdev_sec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index f26830637f..855bea1796 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -1336,6 +1336,8 @@ cn10k_eth_sec_rx_inject_config(void *device, uint16_t port_id, bool enable)
 	roc_idev_nix_rx_inject_set(port_id, enable);
 
 	inl_lf = roc_nix_inl_inb_inj_lf_get(nix);
+	if (!inl_lf)
+		return -ENOTSUP;
 	sa_base = roc_nix_inl_inb_sa_base_get(nix, dev->inb.inl_dev);
 
 	inj_cfg = &dev->inj_cfg;
-- 
2.34.1

