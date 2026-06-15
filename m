Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3397CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4D640A8A;
	Mon, 15 Jun 2026 18:27:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 179D740B99;
 Mon, 15 Jun 2026 18:27:29 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbkek392400; Mon, 15 Jun 2026 09:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 0HiJcK90orzCOK2FXdFRA1RjslSfaQY5ijJZOmi8V0=; b=OHxhY292T+i/RQsdZ
 Pz+oNdwABRULnnJQmdhs5pxq3DT+nF6pKMHpUKjeOu5azO/4fGKzV/152PBDa40V
 MqBKpigxpu+vwssds1dqLDkSOQ0NJoxvPpSy8tUyUh98BZ8ZEOhK5ivAMbgAFAzv
 jx7fFIOi7KA02mmJ6qYNTyYL3koPmI2gkvjIpnK2YjewPsu6w7KuQqAFkeTVUKMr
 /b1Dn3m9JOeo8TK4YWZXsVHODME7gtSlqd1kyN1BdmJNAUw2BtCVCOb9DEGEIDCf
 /Ut4LY3fGoltUIpFJbLz5MqChFrdffMCabXI6A0Oj4OauOc78TkWNjYmP1SX701e
 TtppQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4esqy8d7sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:28 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 984DF3F7063;
 Mon, 15 Jun 2026 09:27:25 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 18/20] event/cnxk: fix Klocwork static analysis issues
Date: Mon, 15 Jun 2026 21:54:44 +0530
Message-ID: <20260615162446.578336-18-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SbzHsPRu c=1 sm=1 tr=0 ts=6a3027f1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=xLgxMG3VJGjQXdvEKNMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: ir4txZWXhAau5QtDPh-i1GWRxJTuyaIo
X-Proofpoint-ORIG-GUID: ir4txZWXhAau5QtDPh-i1GWRxJTuyaIo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX/t1HOesEmMmn
 UxBLxrOxFDGvE1CVbuaaz0i0tR++I1xWVC/xHBX4D5h08wPrAk55KqfZS/Lb4solwoZpYm2QshW
 gOib885HgnYPlHyvVk9NE2QmkZa+I1zOL624QoInEmFhGUA4LrqQIOdzT5jgJHeFzFusFbes3Yf
 rPPyU6z+smRKxi1+WaxouQkEXjlsmam4ZBEiffhwHaIje/cWoVx1JIIIkztLTv0q63UWxSUzWc1
 myDh+2a/V8PxuQclrvqxBvNN8gXVqEGsW2hfZTcGJQLXu4Q/qNYZ20fAM6LsDK5Iuchb5/uRyeD
 WB+wloz2CluLJDs4MB3h1DbPa6GE3IeGaJNaU39Dp1Y4XmO3B6lWFgYGFTrj0Esjd+QGRPLWu30
 de30KSqagcibYjRRerAwaNHhcaR2dtX4YoCgrdSUCfqbKR1TbQFwA3OSO9KUneS6jROmp47fFTV
 OWM6y4wofXBgi33XJEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX0+YPYpSX2Pwz
 lcuWm1Vg+fNbAqWXJIWwTG/3mLeVZEXgM8XefWmPxWxzl/+essDv54bEbUQyLLmW55wUeqU92Fh
 uZbPLxVJy4MHZospQ2GdcPK1TVsTpfk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Cast uint16_t operands to uint64_t before bitwise OR with
uint64_t rx_offloads to fix operand size mismatches. Add NULL
check for bracket parser end pointer to prevent undefined
behavior from pointer comparison with NULL.

Fixes: 697883bcb0a8 ("event/cnxk: fix Rx timestamp handling")
Fixes: fe7ed2ebbf37 ("event/cnxk: set Rx offload flags")
Fixes: 38c2e3240ba8 ("event/cnxk: add option to control SSO HWGRP QoS")
Fixes: 8a3d58c189fd ("event/cnxk: add option to control timer adapters")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No code change. FEC patches removed from series and patches reordered.
Changes in v2: No change.

 drivers/event/cnxk/cn10k_eventdev.c      | 2 +-
 drivers/event/cnxk/cnxk_eventdev.c       | 2 +-
 drivers/event/cnxk/cnxk_eventdev_adptr.c | 4 ++--
 drivers/event/cnxk/cnxk_tim_evdev.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 2e4b8aab92..62fea93b0b 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -660,7 +660,7 @@ cn10k_sso_tstamp_hdl_update(uint16_t port_id, uint16_t flags, bool ptp_en)
 	struct rte_eventdev *event_dev = cnxk_eth_dev->evdev_priv;
 	struct cnxk_sso_evdev *evdev = cnxk_sso_pmd_priv(event_dev);

-	evdev->rx_offloads |= flags;
+	evdev->rx_offloads |= (uint64_t)flags;
 	if (ptp_en)
 		evdev->tstamp[port_id] = &cnxk_eth_dev->tstamp;
 	else
diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index be6a487b59..4aa16f9026 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -566,7 +566,7 @@ parse_list(const char *value, void *opaque, param_parse_t fn)
 		else if (*s == ']')
 			end = s;

-		if (start && start < end) {
+		if (start && end && start < end) {
 			*end = 0;
 			fn(start + 1, opaque);
 			s = end;
diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 8536dee5bf..5678e5d264 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -285,7 +285,7 @@ cnxk_sso_rx_adapter_queues_add(const struct rte_eventdev *event_dev,
 	/* Propagate force bp devarg */
 	cnxk_eth_dev->nix.force_rx_aura_bp = dev->force_ena_bp;
 	cnxk_sso_tstamp_cfg(eth_dev->data->port_id, eth_dev, dev);
-	dev->rx_offloads |= cnxk_eth_dev->rx_offload_flags;
+	dev->rx_offloads |= (uint64_t)cnxk_eth_dev->rx_offload_flags;
 	return 0;

 fail:
@@ -330,7 +330,7 @@ cnxk_sso_rx_adapter_start(const struct rte_eventdev *event_dev,
 {
 	struct cnxk_eth_dev *cnxk_eth_dev = eth_dev->data->dev_private;
 	struct cnxk_sso_evdev *dev = cnxk_sso_pmd_priv(event_dev);
-	dev->rx_offloads |= cnxk_eth_dev->rx_offload_flags;
+	dev->rx_offloads |= (uint64_t)cnxk_eth_dev->rx_offload_flags;
 	return 0;
 }

diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 994d1d1090..8cdb8a72dd 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -508,7 +508,7 @@ cnxk_tim_parse_ring_ctl_list(const char *value, void *opaque)
 		else
 			continue;

-		if (start && start < end) {
+		if (start && end && start < end) {
 			*end = 0;
 			cnxk_tim_parse_ring_param(start + 1, opaque);
 			start = end;
--
2.34.1

