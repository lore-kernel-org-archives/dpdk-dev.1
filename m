Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B8CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 15:43:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C81B4042F;
	Mon,  3 Nov 2025 16:43:16 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by mails.dpdk.org (Postfix) with ESMTP id A8D6C40281;
 Mon,  3 Nov 2025 16:43:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHH8CejzfEucthVt5SA4UJk3kGfQbG9TuuyjVrbBZI+pWsLB5XYaNua96pcUZY9F3EHPYgfWyTzEe+VNRamhYfgIi26JEYUec+6AM6+ofqE8lBtCUYVMB6daOAX8sIirx2iqjsvdOey73xH07eIqk9wTqiPVgIdTgoPz1XTFs4T++eglxeo6EuBp0uKKYngiT63P4bd04UahgG2OB9gR19aZ415Aq7jnu4YI+ooAo8SPF5vuIMtDDxhYTrWGQrngjNcPcS63D6Xj13iAb+sujet8bbtVzTzOsyWOzt90kHqmZ1+quG7cS9pWolL1VbFeqQcT8ZopTx71L8+2QhCj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlL3QzOg+GvyF7vTFtXdr7wzbCaKvAvykhLimLsp5Dg=;
 b=wN7b5KHG5hWISUVklAucV/LKPW8qsCVSB7Xp52IpSOffmrUWjHDXCM/V+XASYGONuK/quL+swcE+2LnZenhD90oO2slhbtIjeKgoRSX/QCHjqvIdLLIt7JnczKHAezbwOdpunrUlQlcQWi4gF4wH3J2q4jcuZd5b5qTSMXm/yR74T0MDJnb0jGfYJ+ed+vmkq8LYyLKhrJo9AYG5op9CjrTT9gIM782KuaqpznVJtUzXFFZ8ONhdrKi7M0tZvaXctMkiN1dez5OrYRaGtR4rIbVTJCIcWTmr2x2rgBlgMarT9Vai/2PlpHGxO6dxhQ8YXScz/5NyArED/wAEBqYlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlL3QzOg+GvyF7vTFtXdr7wzbCaKvAvykhLimLsp5Dg=;
 b=Hycb9JVXF2glwBHXOcnhSf/ALgfNdMKpBW/3JJPIOi5dwVcskEgUtMk9eYJnY3/UntE0hd2otCDaXIbd0Edv+hHMOA3sEZ4HfwVPT/8ItelD7R/rCns1lgCLj6XH3f/W8VByhhA62AlSM12buITNTOb4wVE+KHRQw052QTvtud4YrFGPBpT8fFtxL9TCtGKpB2N5L6Cub35A4EAzQxE9SUngnyQNxWF7G884DIZdmiBrv5s/BtpyrScqSjMesyNig/YeDwWQeK+RwzqpWyxaKjjGcVwhJN8hMlc4jNRNBnu8Jlfjta6oDWtd1Mo13cZUA02qaAUskj8RaI/6ruOw5g==
Received: from BN9P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::14)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:43:09 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::fc) by BN9P220CA0009.outlook.office365.com
 (2603:10b6:408:13e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 15:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Mon, 3 Nov 2025 15:43:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 07:42:48 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 07:42:45 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>, Didier Pallard <didier.pallard@6wind.com>
Subject: [PATCH] net: fix parsing of frames with arbitrary VLAN stacks
Date: Mon, 3 Nov 2025 17:41:27 +0200
Message-ID: <20251103154128.297748-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c1f765-3127-4964-2160-08de1aefaf24
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6+qJHVm0MzNzTOFvsxcVDvOtXLwuyg4NU0dHKSuMIK+lO6AH/BElanNTbjR?=
 =?us-ascii?Q?JTPltaPXx2m6GCj0PeVzrYxWaHgDtLWsmVPj3dqSogrCoiR+wcMQbIqVvp7I?=
 =?us-ascii?Q?ySFAyjkUZfem1OtzVQe5zxnRmQhSq8mCWoP9UM2QUgCp93NkK7ooOUFZ2iEt?=
 =?us-ascii?Q?UZxrb7gwnJ9ADrtxhsgPN9pINX47uVxrp7DHA2PuqL0lQNgvNoFWBiz+O+qF?=
 =?us-ascii?Q?ESsoJ1w19EpUdmuOnWQsuI/YBv3Pk0TgRGufnPOSCJcaqUWd6KiYE/BXKIrf?=
 =?us-ascii?Q?3jK6CVHzW+OJQd4InsqfJlhv6hE1DrTQNVCT6v4Jc0J8AsD4ODHOvo4G5+LO?=
 =?us-ascii?Q?5BRESGNTiCtzSXMqakDXFVTMB6AZwUYXSZlQ17Vvn62cyfsFLXDzrVc9tSLx?=
 =?us-ascii?Q?8k9UlgK1ASVaHdCgFxqJ4qY7xrMKV+5trDW89xDKjaBzy1YhVRUC3HjOeqFV?=
 =?us-ascii?Q?cyRfeqPr/L5ynCAJdo0enxltA99odKYIxEefEaLyGNgNvWNKLm3uWHivOD8P?=
 =?us-ascii?Q?IE6cnr5Equp4cS5tLBODgDp33Qcz4vmAp5latOyf303QQ3vvZMOhpAk5UOeO?=
 =?us-ascii?Q?7HNm2lnGq4grNLFrVUZ+AdrH8ZBizrk/7bzLLyWq0f7h08/IW5yjPsmhGH5k?=
 =?us-ascii?Q?P6ksTmLgrmxfVWh6TBWsQFmyj6J56I5DfDLkbTEwoV+jZJqYg2Vs3PE24o30?=
 =?us-ascii?Q?RTlivCFSrmGyfrdSmqs8PMQVGyVSVEoYDp/DD/fLOemQqLige84FJin1dTPq?=
 =?us-ascii?Q?QhKvesCEJ7LwAUKc19aXftTqNZStDiZm5ocfdaE0X409HaOD23v7ryt8kgHz?=
 =?us-ascii?Q?XiTZiC6Dy8wmrBv0bEOum7HpNKg4ie38hyl51hIU4XEZblyoC3PPtxOdTFhh?=
 =?us-ascii?Q?pRkfyb9QlQEg0Ggsh2tcgW15o7aaPUHzOBNUCTY0FQ1GrT4iB/3hN2aEDDQG?=
 =?us-ascii?Q?BpsXYkSScqKtSg00d7l193rMFGVgnyAZkEjky3g/i+7B2qCeDT+frLwBiMMS?=
 =?us-ascii?Q?4nkom6c1iVlQ6wEiA0guEvO9P0Q3QIMmC5g13BMLalCEciNJIrhNkEKTNDxG?=
 =?us-ascii?Q?a52MKAeDFPh9+uO/SWGSKqtfQOrk+AUdaPvVlhMt4aStElwJ2ga/IS5Ni7Lg?=
 =?us-ascii?Q?MYdhTASXV3Q5QbReNHT2GHCvyTWtc3mCgDybdXVEyiONCb+KT/bZHdrB8aLq?=
 =?us-ascii?Q?OoL3BFkGTQeGOWamm2HjyOvLB8PJZVnK6aVnhREZxfy+Cmm3cPHksxYCoO5j?=
 =?us-ascii?Q?DbtgNQ6NzNBVwAd+ULkbNKYrGdkCppDSb4i76aCxLaQ5Owvj6Ga5dlHlWqBj?=
 =?us-ascii?Q?3/CzY/grDfrvU1VjqICpuF3Z6UUnVCloyDXbO+yGMGdg/VilSuEdg9jn8Rzk?=
 =?us-ascii?Q?Z/2vYSkpZSx1CkJRgf/fR2RjWBagUr06ikzxySR5I5z1pUq7gsfuAosnzF4q?=
 =?us-ascii?Q?OtOS+VdmmotlUdqpRB5DI2xFp4oI21bMpIN27AyQy8EG/Ubgy9+paPwxMTvr?=
 =?us-ascii?Q?HESj4KK9ac2vXYcFzjdFjAZ7rmXVf4xoXquIjq7mnK2ziC19JlMzptKdEUO0?=
 =?us-ascii?Q?kZ3SOT9ON1/+ImbDWw0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:43:06.9235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c1f765-3127-4964-2160-08de1aefaf24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
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

The rte_net_get_ptype() supported only 2 types of VLAN headers frames
that are defined in the IEEE standards 802.1Q and 802.1ad:

frames with a single 0x8100 VLAN header:
  eth type VLAN / vlan / [IPv4 | IPv6 ]

frames with 0x88A8 QinQ header followed by 0x8100 VLAN:
 eth type QinQ / vlan type VLAN / vlan / [IPv4 | IPv6 ]

The function did not parse frames where VLAN headers were stacked in
different configurations.
Such frames should also be allowed to provide HW vendor flexibility.
As a result, ptype bitmask and header length returned from
rte_net_get_ptype() for a custom VLAN frame were wrong.

For example, the parser result for the frame
  eth type QinQ / vlan type QinQ / vlan type VLAN / vlan / ipv4
was:
pkt_type:=0x120007
   RTE_PTYPE_L2_ETHER_QINQ         0x00000007 OK
   RTE_PTYPE_INNER_L2_ETHER_VLAN   0x00020000 wrong
   RTE_PTYPE_INNER_L3_IPV4         0x00100000 wrong

hdr_lens:={
  l2_len       = 22 wrong
  inner_l2_len =  4 wrong
  l3_len       =  0 wrong
  inner_l3_len = 20 wrong
}

The patch changes:
1. Allow frames with an arbitrary number of VLAN headers.

2. Set each parsed VLAN type in the returned ptype bitmask.
   Multiple VLAN headers are referenced by a single
   RTE_PTYPE_L2_ETHER_VLAN bit.
   Multiple QinQ headers are references by a single
   RTE_PTYPE_L2_ETHER_QINQ bit.

3. Preserve RTE_PTYPE_L2_ETHER bit if VLAN or QinQ type was detected.

Fixes: eb173c8def0a ("net: support VLAN in software packet type parser")
Fixes: 218a163efd67 ("net: support QinQ in software packet type parser")

Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 lib/net/rte_net.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..96fb054f55 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -349,30 +349,24 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
 		goto l3; /* fast path if packet is IPv4 */
 
-	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
+	while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+	       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
 
-		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
+		pkt_type |=
+			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
+				 RTE_PTYPE_L2_ETHER_VLAN :
+				 RTE_PTYPE_L2_ETHER_QINQ;
 		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
 		if (unlikely(vh == NULL))
 			return pkt_type;
 		off += sizeof(*vh);
 		hdr_lens->l2_len += sizeof(*vh);
 		proto = vh->eth_proto;
-	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
-		const struct rte_vlan_hdr *vh;
-		struct rte_vlan_hdr vh_copy;
+	}
 
-		pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
-		vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
-			&vh_copy);
-		if (unlikely(vh == NULL))
-			return pkt_type;
-		off += 2 * sizeof(*vh);
-		hdr_lens->l2_len += 2 * sizeof(*vh);
-		proto = vh->eth_proto;
-	} else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
+	if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
 		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
 		unsigned int i;
 		const struct rte_mpls_hdr *mh;
-- 
2.51.0

