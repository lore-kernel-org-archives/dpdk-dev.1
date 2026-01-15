Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2059D44C42
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 13:15:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52CFE40A77;
	Thu, 15 Jan 2026 14:15:39 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66]) by mails.dpdk.org (Postfix) with ESMTP id ABCB14003C;
 Thu, 15 Jan 2026 14:15:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4XPyCnuInb54PAZW41Qqb6D+hD09BLdqe/DJxLiBb+zaXQKydUj7F/txxgRvqlvm+RnqihMUI6Yc7f6BxTWbBVuv3X7UEWuxf501aPpENhHDxBmeTdcUi7EyGOgzmN+yp8z2YW9Gl2UqjZvjmMipIzWnLkwGrMzh/T/Ue98et6FyF3CxugeN/zfiPPBYY8nizvouQYmMLKuCLirwY2LmZc/NZc1hg+6d/2pWhnEnn9wCeP6dzQZYdpggudMCfcwfniDzDyPcJkN/RI6kFiff+pNaL1vpj/dHULGbaF4+0pErGAWihyeUODO/pKxtCoE0bhouHdFmAEf27cYIiF1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHlqZqdyIbujTP0ySNd0/yu8fnkn/IbLXUQBEGrptzc=;
 b=cd6OSUbBKa5eAIdExWpCNh0Wx24YeHA2uWfaezile7SukGRqC4NLDPH9/Y1rfld/3l1xCfx5quQ93hFlRA12krenbkH0V2c+y00vStvYoOcyKDCmT+gl9zdHs+edhHXb6ycDOX+CL9MqaS+QWL2ieWaAnZ6SdABlfHpWYDdw+vAc9uWmROmZzFHU/JZGBjSFwTao5JzzklrzVZH054LsPm8n2pnW7nYtl1Ehz2Y0PLZjqsh586ZcQ67BjNv5oPUtwtzPOt4/osZ9bIttAqeIzWb6ePNWpmSfvb1L9C5rXmvHBOttjG6mR+axJKUKGS+H9Vzdior3IpAZkX0snERmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHlqZqdyIbujTP0ySNd0/yu8fnkn/IbLXUQBEGrptzc=;
 b=Aye07S0isDrSvIdmXsRzoSYZDlsCl7qBllL1tMDeM4loxCKX9WKnkZhLaXL8L9DffJiX0ueKNX9JqXSa/4emWY6P+rBDcnyVTrjifQskHfTaja9brr/XDxMbEoNMrlJYhx44nY5vFcsCmbbSZjazT9j4s7mOQHauZN0vTP6hvAUyPb1AKsUAxPyL5PBu8u2B5nW+RtKodqS7PhpqAaguL8tJvTqPxfKC8qJraGufqisYz4qN/Bn6sdzU/5yaZL5RFnaAS7v5oedz1zA6aoMvQNJdJx08YX2tk42bKVFRBXKWBeEUCjKFU6WAsEjFMsYi9akKfc1EZJG8c7OMaCObFg==
Received: from BY3PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:39a::31)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 13:15:32 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::56) by BY3PR03CA0026.outlook.office365.com
 (2603:10b6:a03:39a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 13:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 13:15:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 05:15:14 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 05:15:11 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <didier.pallard@6wind.com>, <getelson@nvidia.com>,
 <mkashani@nvidia.com>, <olivier.matz@6wind.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, <thomas@monjalon.net>
Subject: [PATCH v2] net: fix parsing of frames with arbitrary VLAN stacks
Date: Thu, 15 Jan 2026 15:14:56 +0200
Message-ID: <20260115131456.554948-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114113327.3618b433@phoenix.local>
References: <20260114113327.3618b433@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 749e92bd-b5b5-4e6d-8579-08de54382913
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LmzOk9OZL6IJpddZUM3INda8oEhhqGoSMGeBY1o2BQrzyBlKCVf7HhvHCAh0?=
 =?us-ascii?Q?msy17gyMKINFgtBrvBairiMiARKYA/UQ+ZElxS5c/DHcQA5YhzIk6s38JtQ6?=
 =?us-ascii?Q?HQ0qZPU2VmEejlojRMU8Cdhcl12ziHQESzKawkqffp02ytADCgDiBtZ5EH9W?=
 =?us-ascii?Q?FEr/6uF4zqd8RKMIveHjlTPMtTGnfLjMWMvUejiuqFtzuPQPu5A1SKS//IlH?=
 =?us-ascii?Q?n/K9wDfJN/ZVbCU5vKobu0qIRoQahd7IIM0WJNt1A87f5S7nO4Ym934+6P1Q?=
 =?us-ascii?Q?MERsrsHu987kKn+aDa+UMRh1KIzgJ4rB+Th0z34MftpX1hvwaCMDEZJUI6vV?=
 =?us-ascii?Q?b+7v/DRiL2r8MA+/pkn9mfpOd7bmWAypcAgl/SnjMwwv24c7U1OLqj3yN6BY?=
 =?us-ascii?Q?Z+RZXA4XeXrHFQ8P6ay8Q04ifOOzenbCgoJMaF8Al8w9s0zoikZsXAE5Xl1F?=
 =?us-ascii?Q?WDdHnCZ7ifDxJFo3dvhnsyRryBIPkE+b16GQ8t42dklsJ3VZ7jmfaWmFkoIu?=
 =?us-ascii?Q?hRS87hH6CRTh260fw3OYFytOQQgtt+kXA5/f1jGoG0jMidV84KbQISjCe3F6?=
 =?us-ascii?Q?NGCQxTcIsTBAvOxcVxxn7NhLeoVJkN/x/xXD9rU9s4BjhGW/gpp9W8KUg0cG?=
 =?us-ascii?Q?etaZrix5KtSqP7zpz9tpOPxihqNf9dUM6QIwiSwwHn5o6M1fjpTbtXrLLaVF?=
 =?us-ascii?Q?Exudm60oGaV+ybC5ZwMNof4qZG6LhVofF1LnphFxn8HYZ82gsTlmfWzZIT8p?=
 =?us-ascii?Q?nyxvoxOhuHqoOE1WpRjQQsKOQrEkteXSkNL/9vGlJ1rXTgu8Bz/OcFpTaOes?=
 =?us-ascii?Q?KWfWaal0x2ipKrCHMR8kNmiTyRZZ7oG+6MH2To+AeCsAI4/lDH8dQFJsgtKD?=
 =?us-ascii?Q?E+gLq3zxCo/XuRAkROHEvhnx/l51IzUKwSd6xop0CfK0hLLj8nvinS1fXaio?=
 =?us-ascii?Q?n0iBISyvuPN9z1fFKIOf6AzPMF7AGLG/2oR1Vj1uMK3I9xlszpu00zJeKe3N?=
 =?us-ascii?Q?jt1pNCmhBTC0BqLYuYoohBwjBaPTecFSZXludN7e8p+1R7vCRWquL4Ft1SVn?=
 =?us-ascii?Q?6tFmc+eV86p5w8hmNGqkLoVTDDL7XUt9Rs/PUTIKNhAFjBwJ5Co5P4QWfQv+?=
 =?us-ascii?Q?WCm+ZYjqoqfDfCxGESCMNBGfWMKPNRt5gba+QMk9YWR6oI++YSOvCbxH7Gsf?=
 =?us-ascii?Q?F0V/UY3d1Qy5u20q5vPgVXBbKpoWyPSZywz67k1MrNqQio1FixAPXXDtsGYj?=
 =?us-ascii?Q?Seb7OML+yglQpqrPj/PSjWkl7SLBw/bhNBVL8IfUqzF9RzFQUmazl3cvhGwb?=
 =?us-ascii?Q?PA/8dv+xevhIcHHavd+rehlBVjdNMz4ge5KzGchDGsgU9QRS+Swu00kaNJ5K?=
 =?us-ascii?Q?+9VNCbFDI9wHjpre/adR4ZNVkpPAiTSsqzDyCVWhJ1FkIXTGb3zZj8VfBiPK?=
 =?us-ascii?Q?RFP8n8849Whui2MKq31ltEDD9A2Dj2QCcZCyRc1TIApyAK6sUNaU1T/pgR7s?=
 =?us-ascii?Q?eGELtT3//9w2MgbsLn/Fxwa7XjlNu/zbgz1Hrvwm3lymR2EUmLuWklFq2tHm?=
 =?us-ascii?Q?w3yoVvywAwRLBDrymKrZyf7iBe4g1AY34F8yCXMpbMKRMb224gQXGWDvE/7p?=
 =?us-ascii?Q?6yzZ/SBir1f6ZCGQ5V/IbgDPKN6pHub5eSNTPinyMqaX?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:15:31.6498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e92bd-b5b5-4e6d-8579-08de54382913
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
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
1. Allow frames with up to RTE_NET_VLAN_MAX_DEPTH:=8
   number of VLAN headers.

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
v2: Limit maximal supported number of VLAN headers to 8.
---
 lib/net/rte_net.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index c70b57fdc0..458b4814a9 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -320,6 +320,9 @@ rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 	return -1;
 }
 
+/* limit number of supported VLAN headers */
+#define RTE_NET_VLAN_MAX_DEPTH 8
+
 /* parse mbuf data to get packet type */
 RTE_EXPORT_SYMBOL(rte_net_get_ptype)
 uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
@@ -329,7 +332,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	const struct rte_ether_hdr *eh;
 	struct rte_ether_hdr eh_copy;
 	uint32_t pkt_type = RTE_PTYPE_L2_ETHER;
-	uint32_t off = 0;
+	uint32_t off = 0, vlan_depth = 0;
 	uint16_t proto;
 	int ret;
 
@@ -349,30 +352,26 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
 		goto l3; /* fast path if packet is IPv4 */
 
-	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
+	while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+	       proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
 
-		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
+		if (++vlan_depth > RTE_NET_VLAN_MAX_DEPTH)
+			return 0;
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

