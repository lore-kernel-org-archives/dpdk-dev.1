Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC5CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 06:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E839340281;
	Tue,  9 Sep 2025 08:29:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by mails.dpdk.org (Postfix) with ESMTP id 22E0340270;
 Tue,  9 Sep 2025 08:29:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbqv+OSUZliq5bXLWuxY+lGkJ/u6TOg9gQn3oP+Ib9JdRq5o7RK+STDR6T1cCK/jMpOwq4xJIlln1xiRuKOiU1njdTFMXDW6e/8YNv84i4hOhNNEDfew2HOBi9mxFDJBLiDky9TcvvZn19zby2gITi3/KQIZR/EE41tvWdYLgzqI72ZSjfJWUzWPdeO81b7h81HsWZ1k9Olj/kES4Q14xWA+UEq+vJgOriVf9PE8JeplUbPWoSOTxCqr0/NcaoubX9f2Ws60zZEMAuW5eO82RYlS9ILWUUnmgMjdCxc/eFxT/LEInv1lrwzbrKOSroor2OCd4oHeb0r8/wFCEKsz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg+l6/GNTzaVywYqIK7Kun9K3EXlJ7rLOHCt8+zZdJg=;
 b=EGepe7qmVxGkBrra7VthPTLDKmxjBqL2KWPAn5qOWxDpCoyNq9rbuI0cso5CyhJgvB/azVvkaQsuaj+48k1NHGftxQT8ewdkd2vYb8cTIS1PQpC+wulEPf6ko6mZOgzSjEJav7kgh50M/6L0P68PQBvgXg3144x7mXeWEVao0jowPOh9ZuqexJOhuxrEEJr9gRUxos/uHAx53X2nQUbQM83aY4ml7aNBJrSj2UFYpkFfWr1ffGUZy8Oj74kg6R0DhJf1crZetldaqcSGoWqhBjNM2Qw6fPn4q+AKjT3VcmgEoyN3g71wA/PcSxB72JeYuoDDkxCap/R3acZXrtMzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg+l6/GNTzaVywYqIK7Kun9K3EXlJ7rLOHCt8+zZdJg=;
 b=cWnbtWZb+3a9coGyqfZXmTZmIgiGpFJSTEVca06TJV/qfpgbNEQUBV2HpOt6qYpX3piT0wj0XMZkaNQXfbAemD/uFcLh/M87mKlaTvz3JOPQVN9MldUQ2JN/ZggGszTmjt8xaEgw3FOIE2Mb+RtqF3LF4JIUy5Duggr7jMy/hyeSjoBu76tdyGS+OVCZyN6ea/zg4dTBaBaV4U6fTetCObScYNjCe6ScoLY3EK4Gcqzao/FFzYrDmzCmDFc3k6f3LoI0TLVifUw6obJA661mLchmSy0fgIbjfGrYD8T+DxWHWaL0rZW4Hb29qV1lo8xGKOhdmY9SyAdIitm9RFMU6Q==
Received: from BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:29:24 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::50) by BY3PR04CA0019.outlook.office365.com
 (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 06:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 06:29:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 23:29:01 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 23:28:57 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, <stable@dpdk.org>, Matan Azrad
 <matan@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Hamdan Igbaria <hamdani@nvidia.com>
Subject: [PATCH v2 1/3] net/mlx5: fix ESP header match in strict mode
Date: Tue, 9 Sep 2025 09:28:51 +0300
Message-ID: <20250909062853.60592-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250804050514.244896-1-viacheslavo@nvidia.com>
References: <20250804050514.244896-1-viacheslavo@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4237e3-7807-4e51-abf0-08ddef6a37c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kxx/TBsN8/r25cGbzQKkev5Q2LzuOQ3cbIM16ga6Dj2SEHH7z05LlEYJBeGy?=
 =?us-ascii?Q?/0NpKkYXdwZIyQtqYL+UBSodINidVYm7RW/O7Za66XKRq45hBaL5UhlEiggr?=
 =?us-ascii?Q?5tcZhI7d8ph7Q2HsyTuQr899eo1I7l+UDwkv3u2hjp53HkH81dZQgX/jPqwP?=
 =?us-ascii?Q?tg3H+anWtM+wvf6QsUYQItFdANpc1ZNhf3sWmSLa+AOpLjtILEbRuGryOrSN?=
 =?us-ascii?Q?S2byo20AVjemSDLcRZrT1a67dGPM2VMo14KwD2RQz+mYZcCKiVx/wAlY3Um4?=
 =?us-ascii?Q?QzCphRJnfOr9aKSVSFyWTxC3HFCO1mm4HECqB49rVBgCr10ubYxo55GEj4Qc?=
 =?us-ascii?Q?UVNkceDfSvOGXAJ8ZwWVtmdSTs0AgeC6yODTUOvci16x8M7gvt5O7rz9S5ui?=
 =?us-ascii?Q?qIo1B0BbiMuMhWIzpYOMkFFuylA9gkNuMETXp2PLt78rhxa9RPKnSrbiKLb4?=
 =?us-ascii?Q?TyeMD4n6I5bn2gune5SiahTH2ncnQSmTNnAVraGGA+WFC8wd5N3nMKlvc7ar?=
 =?us-ascii?Q?LZnh6hpDy/FEdC5jp0twkHlKCzou4wjJyhvrWlc/rTvwKo6wsUxQKhOOQnaD?=
 =?us-ascii?Q?9HXNZaqu8ghV84aMtkexhbE8npApDRgKuqUM1GKhK2Ay70OEcJGQrdXbjcQG?=
 =?us-ascii?Q?FzkgGAcBdWWTykfd2gvBLp4RsBYcwOeXHGciQ8bJ2biowmAdtzTi1TLHhkdx?=
 =?us-ascii?Q?rL2HkV1TwyPO5sXUAj75N7IoEmUsZiXVUQwFOBThvN349bZ8VS+3HDpP6ou9?=
 =?us-ascii?Q?KsCtHHnv8DjIevuFS/EtdeHSf5KrNO3OOoOuHVMqVmlJRxyhBCz0+eqnKn5k?=
 =?us-ascii?Q?2wN/ASE39PIM0p29UaBDWzn99QIQ73NeVqaWikb5gV3wcqHouzKTuhuoP54G?=
 =?us-ascii?Q?6yMIoxUJMPtnG1efEBicHXB7N4ZgymX3/UOfcsulUknNcdDmdafgRv5oK0gO?=
 =?us-ascii?Q?gUum4FRXx3WWankXuvhNsm60GAxLkIF8U/XmeQxIc+BDR97gLqThMs7Ped+V?=
 =?us-ascii?Q?nF6PuANT6/meiaewklCeo760hfto+tlknCeD8kd0fUnbx/S0posusd0gH2Pq?=
 =?us-ascii?Q?htAxrGwq80fvINHC5oQ7HetvviAbkxHYlyIHTDNs9umoyEDry6o6P6/9DB7F?=
 =?us-ascii?Q?xi6Bkaztkyp6snh9VPlFtqCiacEiEsao+Ty4o74CtWL0fr0Pncz68Iy+Qox3?=
 =?us-ascii?Q?yjAks6h93bLTlQckJkbh3QX2oO+DWzcH6+tQxEUy1l/CxX7I+a12gIQZOYFO?=
 =?us-ascii?Q?dO/xKWsWIolGWSp4Tu48Z/OibSzSsl9sxAMS+uYHjHuu0hHxpO22VPRgxYMk?=
 =?us-ascii?Q?9lKm0FECIZr7CL1Gl5R7Dx1qMAfWsWnNiJk5C1bxUrKCQwLk9az4/vLDKEjK?=
 =?us-ascii?Q?2a7s1SZJhV3sRZBYKvVdgq+bgY28pglGzd1P/UNv+vPOdQ/UiY+/mhDyvsvs?=
 =?us-ascii?Q?5eUloNXnbyraLAmJS3Z9mFKjgr70s7WTkk9NR905h+1R8iMWanWPPc+Elvwd?=
 =?us-ascii?Q?5/eLFEU3LbOFJp2+cdVpgVQLHFn7HeWbp+tp?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:29:23.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4237e3-7807-4e51-abf0-08ddef6a37c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>

The pattern like "eth / ipv6 / esp / end" matched on any IPv6
packet in strict mode, because there was no implicit match on the
IP.proto forced.

This patch adds the implicit match on IP.proto with value 50 (ESP)
and adds implicit match on UDP.dport with value 4500 for the case
ESP over UDP.

Fixes: 81cf20a25abf ("net/mlx5/hws: support match on ESP item")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_definer.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_definer.c b/drivers/net/mlx5/hws/mlx5dr_definer.c
index 7464d953739..02eba861bc5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_definer.c
+++ b/drivers/net/mlx5/hws/mlx5dr_definer.c
@@ -14,6 +14,7 @@
 #define UDP_VXLAN_PORT	4789
 #define UDP_VXLAN_GPE_PORT	4790
 #define UDP_GTPU_PORT	2152
+#define UDP_ESP_PORT	4500
 #define UDP_PORT_MPLS	6635
 #define UDP_GENEVE_PORT 6081
 #define UDP_ROCEV2_PORT	4791
@@ -231,6 +232,8 @@ struct mlx5dr_definer_conv_data {
 	X(SET_BE16,	nvgre_protocol,		v->protocol,		rte_flow_item_nvgre) \
 	X(SET_BE32P,	nvgre_dw1,		&v->tni[0],		rte_flow_item_nvgre) \
 	X(SET,		meter_color,		rte_col_2_mlx5_col(v->color),	rte_flow_item_meter_color) \
+	X(SET,		ipsec_protocol,		IPPROTO_ESP,		rte_flow_item_esp) \
+	X(SET,		ipsec_udp_port,		UDP_ESP_PORT,		rte_flow_item_esp) \
 	X(SET_BE32,     ipsec_spi,              v->hdr.spi,             rte_flow_item_esp) \
 	X(SET_BE32,     ipsec_sequence_number,  v->hdr.seq,             rte_flow_item_esp) \
 	X(SET,		ib_l4_udp_port,		UDP_ROCEV2_PORT,	rte_flow_item_ib_bth) \
@@ -2930,6 +2933,32 @@ mlx5dr_definer_conv_item_esp(struct mlx5dr_definer_conv_data *cd,
 	const struct rte_flow_item_esp *m = item->mask;
 	struct mlx5dr_definer_fc *fc;
 
+	/* To match on ESP we must match on ip_protocol and optionally on l4_dport */
+	if (!cd->relaxed) {
+		bool over_udp;
+
+		fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
+		over_udp = fc->tag_set == &mlx5dr_definer_udp_protocol_set;
+
+		if (over_udp) {
+			fc = &cd->fc[DR_CALC_FNAME(L4_DPORT, false)];
+			if (!fc->tag_set) {
+				fc->item_idx = item_idx;
+				fc->tag_mask_set = &mlx5dr_definer_ones_set;
+				fc->tag_set = &mlx5dr_definer_ipsec_udp_port_set;
+				DR_CALC_SET(fc, eth_l4, destination_port, false);
+			}
+		} else {
+			fc = &cd->fc[DR_CALC_FNAME(IP_PROTOCOL, false)];
+			if (!fc->tag_set) {
+				fc->item_idx = item_idx;
+				fc->tag_set = &mlx5dr_definer_ipsec_protocol_set;
+				fc->tag_mask_set = &mlx5dr_definer_ones_set;
+				DR_CALC_SET(fc, eth_l3, protocol_next_header, false);
+			}
+		}
+	}
+
 	if (!m)
 		return 0;
 	if (m->hdr.spi) {
-- 
2.21.0

