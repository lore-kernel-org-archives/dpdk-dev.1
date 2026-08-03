Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AC7C5516F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A5D8402E2;
	Mon,  3 Aug 2026 08:24:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B9C1F40615
 for <dev@dpdk.org>; Mon,  3 Aug 2026 08:24:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6730JVJH3316373; Sun, 2 Aug 2026 23:24:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 XYO/ecmaho+W+NBO61gTwLHtXRXxbCIrfG2gmxUj2k=; b=AnJNB7WPoanWAF6og
 CdXGIkc09ZwA8N8sWoKmkDyh6QcPKTgyl6n1MRp5BiUsP5y5rOT9A5V7OQGjsEDA
 t2noRLLwT3N0N09TW4Q0MTafQsulAG5gutKtujBFHrqH0qd1hUHdBZbtFgrvKlp0
 btg3KF633YiWjrrGhShfAu5PgOmB2RqA0Yi5Xn6YYu7JvHs0V8rBZg1ryDPHeXgp
 SLyveFIHJ2Uo32K4k4YiAGgcDTWCE4cGsLXB78YznwdbV7yEFrV2eK9oQ2isgRnC
 geUT6MDSzk/E84vT61t0Ylb0/fepTrEELoaiOYLIs+odVSWZL7Bdw3c8Pesn0ZTl
 KdaVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ft1j8hwkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 23:24:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 2 Aug 2026 23:24:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 2 Aug 2026 23:24:33 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 0AB1F3F70A4;
 Sun,  2 Aug 2026 23:24:29 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <ktejasree@marvell.com>, <anoobj@marvell.com>,
 <jerinj@marvell.com>, <stephen@networkplumber.org>, Rupesh Chiluka
 <rchiluka@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v1 3/3] net/cnxk: use timing-safe MAC address comparison
Date: Mon, 3 Aug 2026 11:54:15 +0530
Message-ID: <a902ba117c37b0d392a91c3e89692bc89e49f9b9.1785737875.git.rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
References: <89e98b3ccc1ad93ed67fb5750c88df94f0c1ecf7.1785737875.git.rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ip0utr/g c=1 sm=1 tr=0 ts=6a703422 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=3jWfGPZ2yggDclZvyaYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfX1BUzJ798NaBg
 rVRyZ1QOEMRP8zd6vCARYAIEvdGuDEA3c9LnkQrqaEcGhyTlyj1ZsxbNIIQvRqjHSnEHpUehvCz
 Upb6gnlde3QCYbZBq1B/wHkL+OUI3Z0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1MyBTYWx0ZWRfX/YcALvwueldz
 1qtBpqL8dkAXYih7VhLle9DIWdOptVEvAJpnQHHp94uF2mNIbI0k0RGnWnAM720MqkTT9Fb5p3c
 PxOvfVxE87uBcOxWfw+73QER3OrOsKPHU4RxCwssDPd04ZUcm7EnkanpxfkQNm/hTEcPsrKo6A8
 Ho/k4A5XCDb8iqt9NaVGOnw0i2XhNHi0FZ7HXkciP9xjWlYsmOaH9TgWmCT3VSJ68QT66tVrniP
 3Cdm1qCD6g4MvmUFieDWBLjUZiIzRSThdNP5QG0ccjyJEhtcD5vcNBFoagSny0EUBg/YgpBRRct
 Zvt1oB5TNzdE16k8ukjouckjclCxaqpPloEZK8xHUzB8Q+fCfSVUn+vPr0U/fCrUYus6ZNj1vTS
 kDfKTEwBrPPhAawmc0TvgKvTNpuRMJvdABSiPyRukfpjxapeT0oW7LzEv4mUg2qY1xAurn32xGG
 HA90CiZXuSScKmOM8YQ==
X-Proofpoint-GUID: rSqUYVFYqvrV9S_SStjIvJTe84nVDv58
X-Proofpoint-ORIG-GUID: rSqUYVFYqvrV9S_SStjIvJTe84nVDv58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
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

nix_find_mac_addr() compared MAC addresses with memcmp(), which
returns early on the first differing byte. Use rte_memeq_timingsafe()
for constant-time comparison.

Bugzilla ID: 1773

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 0ea3d7e89f..094312e406 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -1147,7 +1147,7 @@ nix_find_mac_addr(struct rte_eth_dev *eth_dev, struct rte_ether_addr *addr)
 	memset(&null_mac_addr, 0, sizeof(null_mac_addr));
 	addr = addr ? addr : &null_mac_addr;
 	for (i = 0; i < dev->max_mac_entries; i++) {
-		if (!memcmp(&eth_dev->data->mac_addrs[i], addr, sizeof(*addr)))
+		if (rte_memeq_timingsafe(&eth_dev->data->mac_addrs[i], addr, sizeof(*addr)))
 			return i;
 	}
 
-- 
2.48.1

