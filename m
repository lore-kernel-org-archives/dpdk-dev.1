Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF37E7DEFB
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 16:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D8A440281;
	Mon,  2 Feb 2026 17:09:50 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC334026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 17:09:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ind82owkkmELHWCT6DVhRy//mrqqATlgzPyVXRstMrikQX/AaeVnD4UnzyjPKy69SQoNdGluR+n8ped2lLWTkavWhNKiEk697xNXsjod0J51SOwGzT3csTgjPJNoYuRKU8f+rn3uu8HdeSny/NBijnZYD1PdVDQcwJjkMb2iSoYkZTXP6zqcJezFc/KgxrseFjmu4zy+kWo21zyJjGIk+3euxIsmRAEaLoU+8XgAI4L8zJC9fAw4LPkj9IWb7VvtI5vr9TZtnfVmHsPK8CSdiAfPalLZn5H9bRI4Si5l3wRuYIQhaALpaQeQk9ZzHdbSeXYTru7Ob6iBpLBDtrHN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA067Damy3KO77G60I68176rSF5+GWIRzPNnXkpuxgk=;
 b=Ol+16FBNPow0dbCn2nIL6r1dR6XPZGwqA11v09RD1p5FvhK+MxvonHUihviZw0OgEl2QFRcCCXAxlxsfNbRUbptVh4duVJtsPQSuGLMScSM9Yzaf2Cdvh1UxIge5vshyJDAVgFpvEUnxXWG/qbRLF1x5Arj+SkTe/1xqAdf4vDqbABBOgA+Z8HSvvNGis6LoxqBwmNwJqaKhPuppqfwKqv28SuA8DeUbwjDEN0n4MXsgyFy5V7JKphMEmtFgOg8VL7uLdGEjyUb0qEq8ysQIe5qFwqFBUDzu+fcdFEnGAyKPepMniXU13B2v+dSEIRqlQLYod2m8NENuGS//bApAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA067Damy3KO77G60I68176rSF5+GWIRzPNnXkpuxgk=;
 b=uhhrAfqz8oUMISENcL64y1KfT856LSCBY/bH0ZXWS4D/wBElFh41PODZMPqe++K9Y4LQmdVIDYfZ9yUYC8P7s9nyI64jvNCJbC6hasVNCwmmI4aZN1BRb9Ti/Q8bjiNJ98vYUc+1cfJ9S5hqB8aCj/BIt3jPABa0RquLJL60E2BlFGPRKxm6Jdccr+m/ZvmgxT+QK/2AFgfYN2MGK5vLGFcPBQn34zVm0VOqo+/T5agrUQ5GHIDpuylm8tGzyp2ygAIU0lOEMRjkvUx4Mw10bb0RFiGI1YKdzgKMFR/yM75TprdPTHteHbBg59lPOR6vk/pHOu6igxvBQRHiZEz2zg==
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:09:42 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::fa) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Mon,
 2 Feb 2026 16:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 2 Feb 2026 16:09:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:19 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:16 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 1/2] ethdev: support selective Rx data
Date: Mon, 2 Feb 2026 18:09:02 +0200
Message-ID: <20260202160903.254621-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: b71ff9f9-715a-45f5-ed4c-08de627578b2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ucREISf/nEE3ZXV2k2NUKLufU2omI7gbytGxslHRSu6K+tFPc0X4JcDjl0l8?=
 =?us-ascii?Q?B0ft1r8hmzNCrOJf/jEGOW/4wVig4DFU1RruCe61yNMTq4Qlsyc//GCl8gDj?=
 =?us-ascii?Q?lT1EdpfFWfSNDZPF/ZBgiL82IVDLp8ujUkUjHyJ/Ji7ILoC6EAHyZeuG+6ov?=
 =?us-ascii?Q?X0iql7JHRyNRAlgU0QLrquLcshbglth7yhBWa5gKEL9JWHMa9dy4UXBnZPjY?=
 =?us-ascii?Q?1Ww1scCBH0gR3hXiLkx16s0N8SoTR5SapsGQ0VKbjRbl6y9KebitXxVlkN0U?=
 =?us-ascii?Q?2dTBzjNx9s/q/WSb1dKCfgiLPN1pQNXl85W8le93tXVpPibI0dLNo+K1AJgm?=
 =?us-ascii?Q?xu+8RK1Sibx+CakJGUSVP0DWbDkxtcSi6HRY8X0xu/rsMi1j4Lm1zSKTuDKy?=
 =?us-ascii?Q?Un4Joiezi20ayU1I83SdJLTztCjfplaHjOBsjmngeoX3/gP8cnbMfx77amGp?=
 =?us-ascii?Q?q/h5EQWykUU773hhjH8o231qT4l7USenWzHpiQIdEJy3FGB9rumUdOnxG/Jw?=
 =?us-ascii?Q?OKsAhcheGSnt6myO3AgxCEmR6utkGBf1DnHd5seWS5pBSGQOCXrxVsy9mhtF?=
 =?us-ascii?Q?b7fDOnR6d0gL6Q2GCq3sLgbv/PsG0lhtPX+/kSshY9VW7p/8u3eiR6f6pVb1?=
 =?us-ascii?Q?/1VlhdYwwynEd8gpECb9keHAuhm+iY6+r3f7kh95K1UQMbrw1kfyqW14kmJ7?=
 =?us-ascii?Q?aevjXpSEqvDgj63vnNMAQG4iuWQVTqLCpEaoTAan4esHgeK9FIBX5Nvjr5Zk?=
 =?us-ascii?Q?g/HTYsPX7B8JfpuMGdSmUrvHeaLzkjjjl29CI5sH3F7ZV9unl0BOQqCPXn2s?=
 =?us-ascii?Q?tiC/jZXJ1hxzb6HAgm0SrMp1jYYWdiNUaDKWbe8Pg0Xh7+iSaSuUrCbvksV9?=
 =?us-ascii?Q?coxlGUwnetZ8KCHvpx9fchZsJ4V3BwjNH9cHGMgYK+sJs6Lv3Hirt2syofoQ?=
 =?us-ascii?Q?WwEAjhIv3dac9t7cDWsqFGlvW2qz/WF8fGKTvsxKprEXn2IVvuT2DejqyUIf?=
 =?us-ascii?Q?OYK1SUIMmizs7MN6edJT5vG/TYYbMYi2F+IaqOR94uJMf0z3SGQZ660uAIYm?=
 =?us-ascii?Q?5iFogjcmlLqwUHiuONdPacTECxsfgSgTpIRx/Lc0QWqOiwTiIue3dU+6lKWF?=
 =?us-ascii?Q?cZof+h+nl8wPDFtNDpBpw7I8T+HiysOZrd7VnbjOL/nTKG+inTzbhYV2tSim?=
 =?us-ascii?Q?uhl51jegY2v2bTdJyo5Er4QgowkeglfA2IJfrUxwPOptR/BZ++wKiXa+wF47?=
 =?us-ascii?Q?NO9OBhtOkzDpr+1WP7TUt89/PPVkBhXpqtluL6+9ykVAJMUv+cMbK/3rht9k?=
 =?us-ascii?Q?0RV1RISEiYdmMixaL4r9gFmOeT5uIpff5CRHUzFxDBpmEo9CYYuk1J+DThnR?=
 =?us-ascii?Q?imMjYBw9tnrF9CqoTP0AAlQLV63cU9G4TnemWCmRAZ6nqFXyESFKQBAD8T2n?=
 =?us-ascii?Q?cDZAVtVpfyiAp4XKD+NHHTnOdPRwQKC6hwUdSzWXuPY0EFZk64oW3BI23Jqq?=
 =?us-ascii?Q?ZQpQ3BCfRIUZq/7nAJk/+TyVN2G3NYQ91Aj402BdKfoAr4Xm0laLNFJDvKDq?=
 =?us-ascii?Q?eyAQ+HPEImFvJpxgz091eFym/qULyCZHydtX9TC4Kb4eaT/IEOUOAEQBGvwo?=
 =?us-ascii?Q?GoJly6ZRLqnAS8nbPtlnUiz3KeIXQjNNu+p/FVGvbc+R66iK5HfxO/55vaCC?=
 =?us-ascii?Q?GnhZHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SdTtI+D6XxgImbY0tT0dDly6IWPC0GMB95gm3nJ08PaWOvggXGf1DbHyPBa6t76uTtRg+Bgm+M6mgLYknYWrrB2/h94LtAkmuNzMeEWMNhX22y96ie3DmHrX7cbbacOcusGU8TEhEdyAENJpicDPANLz812k6+FwjisgmRluII1zMDVk978NhpbtANl3+W15MQruAB6G5ilZ2C3yH/oDDUhjlP2Be60DAgU34c24xehZsuhddSbLCN8bCfPtFsumYeqBjGZ+lblDsxeV0V+/HhXS0WkntWe4BfwaspkCjBQQXIVvY4aIWFvHGEGjmnS/k5eLhvCkgLLP11i1EVRgtzbDsw3KZ/Yfv6vmaPNv543iSNQJyQs4Rueh7Xk1HDqTOFsSd7DfYhjev+tJonpb/Pjc4z4Jstz1rVuQ0C+qvxz0fr4zdJ2Iu53+f83nPP98
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:09:40.7963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71ff9f9-715a-45f5-ed4c-08de627578b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

In some cases application does not need to receive entire packet
from port hardware.
If application could receive required Rx data only and safely discard
the rest of Rx packet data, that could improve port performance by
reducing PCI bandwidth and application memory consumption.

Selective Rx data allows application to receive
only pre-configured packet segments and discard the rest.
For example:
- Deliver the first N bytes only.
- Deliver the last N bytes only.
- Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.

Selective Rx data is implemented on-top of the existing Rx
BUFFER_SPLIT functionality:
- The rte_eth_rxseg_split will use the NULL mempool for data segments
that should be discarded.
- PMD will not create MBUF segments if no data was read.

For example: Deliver Ethernet header only

Rx queue segments configuration:
struct rte_eth_rxseg_split split[2] = {
    {
        .mp = <some mempool>,
        .length = sizeof(struct rte_ether_hdr)
    },
    {
        .mp = NULL, /* discard data */
        .length = <MTU>
    }
};

Received MBUF configuration:
mbuf[0].pkt_len = sizeof(struct rte_ether_hdr);
mbuf[0].data_len = sizeof(struct rte_ether_hdr);
mbuf[0].next = NULL; /* The next segment did not deliver data */

After selective Rx, the mbuf packet length reflects only the
existing data that was actually received, and can be less than the
original wire packet length.

A PMD activates the selective Rx data capability by setting the
rte_eth_rxseg_capa.selective_read bit.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 lib/ethdev/rte_ethdev.c | 10 +++++++---
 lib/ethdev/rte_ethdev.h |  8 +++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..68a51c97c5 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2161,9 +2161,11 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 		uint32_t proto_hdr = rx_seg[seg_idx].proto_hdr;
 
 		if (mpl == NULL) {
-			RTE_ETHDEV_LOG_LINE(ERR, "null mempool pointer");
-			ret = -EINVAL;
-			goto out;
+			if (dev_info->rx_seg_capa.selective_read == 0) {
+				RTE_ETHDEV_LOG_LINE(ERR, "null mempool pointer");
+				ret = -EINVAL;
+				goto out;
+			}
 		}
 		if (seg_idx != 0 && mp_first != mpl &&
 		    seg_capa->multi_pools == 0) {
@@ -2185,6 +2187,8 @@ rte_eth_rx_queue_check_split(uint16_t port_id,
 				goto out;
 			}
 		}
+		if (mpl == NULL)
+			goto out;
 
 		offset += seg_idx != 0 ? 0 : RTE_PKTMBUF_HEADROOM;
 		*mbp_buf_size = rte_pktmbuf_data_room_size(mpl);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..173c773e72 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1121,7 +1121,12 @@ struct rte_eth_txmode {
  *   The rest will be put into the last valid pool.
  */
 struct rte_eth_rxseg_split {
-	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
+	/**
+	 * Memory pool to allocate segment from.
+	 * NULL means skipped segment in selective Rx data. @see selective_read.
+	 * Skipped Rx segment length is not reflected in mbuf packet length.
+	 */
+	struct rte_mempool *mp;
 	uint16_t length; /**< Segment data length, configures split point. */
 	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
 	/**
@@ -1758,6 +1763,7 @@ struct rte_eth_rxseg_capa {
 	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
 	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
 	uint32_t offset_align_log2:4; /**< Required offset alignment. */
+	uint32_t selective_read:1; /**< Supports selective read. */
 	uint16_t max_nseg; /**< Maximum amount of segments to split. */
 	uint16_t reserved; /**< Reserved field. */
 };
-- 
2.51.0

