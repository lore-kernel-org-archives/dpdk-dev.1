Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D91E7DEFB
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 16:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 090E840608;
	Mon,  2 Feb 2026 17:09:54 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47]) by mails.dpdk.org (Postfix) with ESMTP id 9097E4067E
 for <dev@dpdk.org>; Mon,  2 Feb 2026 17:09:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb8KfB2qBdFXNFvQKgV5/QdnD1Mtu7oVWASM3ZRcd32UFnR6oAwJrpb5qq7wu9GQYqMmiwmn3bS85fk/ngAEoB8R0qvMdb36p3Xr+GqD+98brnFdL83UbttYi2Hhc21YgJ+T0qVNbimG95nYdl7nbpENGvqM/LjeWjHbnCKn3LKIGxHcESVrrbg8zQ5emKWL5cOJ0WAjeJdu1kHW21h/kzamhymFN2+llNzaXEcjvf8paQBm/CeGKD+JPkHTyisQe6GXwaycBXGgKkmqyKl8+eNoqOYewBTlcViVjbJU4H7Zvj/ZVZ817Axui12ADi4uFzXSu06fMXG86ehBEyF7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9GAKhgTbcVKaa8+w/usv6FHFXU7X+YU7usM8o3DwA8=;
 b=mE1OYTHIz1iWGuRB5VNRKqX+nYiY9Mr4cE9QwCswPomq4BoiqWZn1agn2UtiC8E97Cnx0vZ77gAFmQzLlI5nOUb1ShmyRvxhoaOzWVpM9eBPhXmnj33t/k6bCN9WOa9nuESxsBiuLKjRWZ6coAaa0ZKFm2NlOjdWb+khhXN9l1G2LreemlJwFopGp5vB3TEasHvpxpM0GJger64qXRgtSHmWm38p3EPOQeBKiPQGk5hmLc42fgjqKxY4Oli7pyn/bfYTOaitL8L3Ue4EQGlUyqXy1tT0rpIST7jNgkwgeG3rybXhNB25ula4usDddgKHZaXtVfnn0BQ3ZYVwnJq0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9GAKhgTbcVKaa8+w/usv6FHFXU7X+YU7usM8o3DwA8=;
 b=Mz4iMfJAo5MZwhpGieFkHJ8AUZzgZX6s+pmNSfdHCkJHD7wno+ZBOg0J70g+Yf6BWYkQ6B9/oz8HIq4iUXMvrU6QzmAB5uV7wQUEgBFK3LhB/MAtM7pALGqtN+fwBVXeigxIsH/jO4dkL4Jp979KtFDpCgodpFdYCk1E8h7VJK2RIi1NRFBGB/dmqetEFsa+wJYBwsUjkILzPBhuoW6a3ri+LNku5JtVoUSYL3qXqb63PbMtjlzkx4KKkSSjYG9QM1xssonUxKWxBAdVRKgK9fo7JpnaPACUK3lKK5+pKz2c+ZoDxtsZL/+8cUfRu4CqYXOQeTyJe+BxpyeDf+Bsig==
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:09:45 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::6) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 2 Feb 2026 16:09:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:21 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:09:19 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, Claude Sonnet 4.5
 <noreply@anthropic.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 2/2] app/testpmd: support selective Rx data
Date: Mon, 2 Feb 2026 18:09:03 +0200
Message-ID: <20260202160903.254621-2-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202160903.254621-1-getelson@nvidia.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1632a9-b07a-4753-6c77-08de62757aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQOhObZ0baa/dR02AxF64Nee6vEiFOvVlm4zCIH6Eedu8Oe0GVgWs1GIW3nO?=
 =?us-ascii?Q?31nGx3T26+JzMHT28LxGpYjFZF5gVSq3WnNOsglNo8XBWr3sp5vZOO8LGjXU?=
 =?us-ascii?Q?hfQGbLlWzbNpF+RZIILFkIelXRorOvnM12M4WTfTd49c8jfJy6/nLqU6Rwaq?=
 =?us-ascii?Q?o02R3LPnHFtHY4qAxZeF1AopeletTielDU5uAiuJ4tpT7sZy1U7X9MYhE21D?=
 =?us-ascii?Q?NZdMPNTU/zr/YyjS5LPH+Nk/u8oU2V39AU26B7b6NepPtLDd+/FlbD+8zxg4?=
 =?us-ascii?Q?oE4OEB6Pxzul3/qaej3Ph1DKfZa58LACNdelMVwjXYnciAFHx0DcRFiuMmL5?=
 =?us-ascii?Q?lQzcn3cakajX6kPLtG+Dq+U4LOeaX7lF4a0BBchjfnY/dmQyJx1BkD3OD6IB?=
 =?us-ascii?Q?/+vgUWi55vesw9YLEoKWKs+zdsl1een7WthXRNhyH1ADQZeSCJnrFudNrSG+?=
 =?us-ascii?Q?EXUEJFRnPq3KoUbJL8uYJfvf18hDVV7TyJwKhQg0og4fDjk3igomMDJkqg/S?=
 =?us-ascii?Q?rZ9aO9C8z2YV5cPWcn8RnJqIVpaQPbI6/gYNK/f/sFBN7XIHm+HObQP8wh/w?=
 =?us-ascii?Q?QIchaM5bE4Rnmw6vHs/U2V9oeAoRprIyakBDUsbLfg8Lbpz+90fyWeHCGu2L?=
 =?us-ascii?Q?1qj9ulkC87ZsBTZAWgS6DTqZ6EGPUsfe8V7mLLFW7ivCht/WHuRm4kzMGfNi?=
 =?us-ascii?Q?TSf2ssU0JSOVp91jLS64s0uv4Ujl+iPO2oF6EM4COeSFuCPNCwuRSPFoi/ig?=
 =?us-ascii?Q?bLRNF5i07K5kJgEX3T74+Pr7TjGpd+blIW50ABKeDwQ3gthPs4RQR4BXJWIe?=
 =?us-ascii?Q?q84C2Mpd9UOMeZuWZxe26DYylpi4irtkMTt2JH3i5ZTpWyGVaunwBwX3IrHu?=
 =?us-ascii?Q?pOEurEjXc+bJYiK0OciZA0Rbv8W74tIsq5Yjs2Lyux4Sd3TqU4TrGsR7v0Cd?=
 =?us-ascii?Q?aa2X8B6cpCrRqE43T5THvXFRmw5/l+X03HuGI6MwkEwMzOW/wNerZ9Bkdbi4?=
 =?us-ascii?Q?BGCb5+RuZJfdjARSbYXVp3+52szHZPL/z9oZkCcj24Ee+QD2juxnUYjWVJQ0?=
 =?us-ascii?Q?6ehZ2kow7pd5GncPzO5VbI6r8DpyXDmtKtj7rXhd//CnaZ/L1MUMzX+3Sd8F?=
 =?us-ascii?Q?2zkGBf3sAjdiqwRNMEzYkx2FeRRLNieYbQxmD4uk/dbBtagf4wu+Nj5Kws6u?=
 =?us-ascii?Q?bNEk6/Kt6A8Zkb/cpPxzzKzihYggkOzdbd7+k7MWqbJw2xyEgk90QHlabZXo?=
 =?us-ascii?Q?rX30rcof4gBeJXQ0RC4slgsMigPpNgl74PGV8nbvuSmw9+9DZIK0cmyFZAuA?=
 =?us-ascii?Q?yBKVEEjFdPsJtazMh3cqeS/btJFql4BiXOL7QgDQ0Tkl1qQFiiuC2HFYyRRp?=
 =?us-ascii?Q?OHwJocFk4GpEwRS9x7bF/H+mReJoqjEI8yZb/ufEdKHlUwoj9vFQ3mHYoyZ5?=
 =?us-ascii?Q?gbGV7lmufBtFqThWC/TDqj0q8Trc5WDyFX3AJdKLRLWKAGGlu+FexanPSZKY?=
 =?us-ascii?Q?eyXlv0tjM6nMzxjzN6a7bHoAPM1XAIi75n7mWQQs+Zg6w0LioLsV6GBi9pH/?=
 =?us-ascii?Q?6LqYXCaKLyN6+EjGFq2Ry429rqX1lJgimfno2MoPK1zGKBQJD6cfTw1OGxz0?=
 =?us-ascii?Q?e1irZ5kV9kEl1+jqmsvWFm7PES7nfCIR3xK9+nNecsepuLakYfWNOho6IRaa?=
 =?us-ascii?Q?FxFoog=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KBSfNJaxws9Xd1cD7f8+AkRhSZBqmosg49J+7qkiQ1UIzRVizjELtXYMbPCeK4qn20yG/j7zzveJPdOMZCTMvhKisPQ2dGxPpEvYpz9ue1SQGroGiomLwPlyYnaolF2519axm04PfGrkhOqePbL/qB8b5Ie98tk24qVGSuptzI+D+ZY9Qqv+Ct4lWO3P1VFqYhVN9ShdqSGHrg+KN8mDsZikAlvPSobFHsWd4G9K3+TKdQ3AMZCBQDI5Wfao2RCA4wjNgi+xd7AdsOyDMMSsbb5erRYmFeLRGYdla/qjZCFCKUVysfriA/E5xGNyC9LUOZAh/9NfTpFGeFmnvzh1erlezcsD1wSt2tax3ugaaETb9Sdqe8zAv8kc3V1SukQYjKuBtqzggDMzN/vnNIFb39dkYx24U272yQQtw4GWBdslwsrchFqJ7Qv8f1x1R6dS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:09:44.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1632a9-b07a-4753-6c77-08de62757aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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

Add support for selective Rx data using existing rxoffs and rxpkts
command line parameters.

When both rxoffs and rxpkts are specified on PMDs supporting
selective Rx data (selective_read capability), testpmd automatically:
1. Inserts segments with NULL mempool for gaps between configured
   segments to discard unwanted data.
2. Adds a trailing segment with NULL mempool to cover any remaining
   data up to MTU.

Example usage to receive only Ethernet header and a segment at
offset 128:
  --rxoffs=0,128 --rxpkts=14,64

This creates segments:
- [0-13]: 14 bytes with mempool (received)
- [14-127]: 114 bytes with NULL mempool (discarded)
- [128-191]: 64 bytes with mempool (received)
- [192-MTU]: remaining bytes with NULL mempool (discarded)

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Claude Sonnet 4.5 <noreply@anthropic.com>
---
 app/test-pmd/testpmd.c                | 74 +++++++++++++++++++++++++--
 doc/guides/testpmd_app_ug/run_app.rst | 19 +++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..62129f0d28 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2676,11 +2676,58 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	int ret;
 
 
-	if ((rx_pkt_nb_segs > 1) &&
+	if ((rx_pkt_nb_segs > 1 || rx_pkt_nb_offs > 0) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+		struct rte_eth_dev_info dev_info;
+		uint16_t seg_idx = 0;
+		uint16_t next_offset = 0;
+		uint16_t mtu = 0;
+		bool selective_rx;
+
+		ret = rte_eth_dev_info_get(port_id, &dev_info);
+		if (ret != 0)
+			return ret;
+
+		selective_rx = rx_pkt_nb_offs > 0 &&
+			       dev_info.rx_seg_capa.selective_read != 0;
+
+		if (selective_rx) {
+			ret = rte_eth_dev_get_mtu(port_id, &mtu);
+			if (ret != 0)
+				return ret;
+		}
+
 		/* multi-segment configuration */
 		for (i = 0; i < rx_pkt_nb_segs; i++) {
-			struct rte_eth_rxseg_split *rx_seg = &rx_useg[i].split;
+			struct rte_eth_rxseg_split *rx_seg;
+			uint16_t seg_offset;
+
+			seg_offset = i < rx_pkt_nb_offs ?
+				     rx_pkt_seg_offsets[i] : next_offset;
+
+			/* Insert gap segment if selective Rx and there's a gap */
+			if (selective_rx && seg_offset > next_offset) {
+				if (seg_idx >= MAX_SEGS_BUFFER_SPLIT) {
+					fprintf(stderr,
+						"Too many segments (max %u)\n",
+						MAX_SEGS_BUFFER_SPLIT);
+					return -EINVAL;
+				}
+				rx_seg = &rx_useg[seg_idx++].split;
+				rx_seg->offset = next_offset;
+				rx_seg->length = seg_offset - next_offset;
+				rx_seg->mp = NULL; /* Discard gap data */
+				next_offset = seg_offset;
+			}
+
+			/* Add the actual data segment */
+			if (seg_idx >= MAX_SEGS_BUFFER_SPLIT) {
+				fprintf(stderr,
+					"Too many segments (max %u)\n",
+					MAX_SEGS_BUFFER_SPLIT);
+				return -EINVAL;
+			}
+			rx_seg = &rx_useg[seg_idx++].split;
 			/*
 			 * Use last valid pool for the segments with number
 			 * exceeding the pool index.
@@ -2688,8 +2735,7 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			mp_n = (i >= mbuf_data_size_n) ? mbuf_data_size_n - 1 : i;
 			mpx = mbuf_pool_find(socket_id, mp_n);
 			/* Handle zero as mbuf data buffer size. */
-			rx_seg->offset = i < rx_pkt_nb_offs ?
-					   rx_pkt_seg_offsets[i] : 0;
+			rx_seg->offset = seg_offset;
 			rx_seg->mp = mpx ? mpx : mp;
 			if (rx_pkt_hdr_protos[i] != 0 && rx_pkt_seg_lengths[i] == 0) {
 				rx_seg->proto_hdr = rx_pkt_hdr_protos[i] & ~prev_hdrs;
@@ -2699,8 +2745,26 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 						rx_pkt_seg_lengths[i] :
 						mbuf_data_size[mp_n];
 			}
+
+			if (selective_rx)
+				next_offset = seg_offset + rx_seg->length;
 		}
-		rx_conf->rx_nseg = rx_pkt_nb_segs;
+
+		/* Add trailing segment to MTU if selective Rx enabled */
+		if (selective_rx && next_offset < mtu) {
+			if (seg_idx >= MAX_SEGS_BUFFER_SPLIT) {
+				fprintf(stderr,
+					"Too many segments (max %u)\n",
+					MAX_SEGS_BUFFER_SPLIT);
+				return -EINVAL;
+			}
+			rx_useg[seg_idx].split.offset = next_offset;
+			rx_useg[seg_idx].split.length = mtu - next_offset;
+			rx_useg[seg_idx].split.mp = NULL; /* Discard trailing data */
+			seg_idx++;
+		}
+
+		rx_conf->rx_nseg = seg_idx;
 		rx_conf->rx_seg = rx_useg;
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 97d6c75716..638c0b0eb3 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -364,6 +364,11 @@ The command line options are:
     feature is engaged. Affects only the queues configured
     with split offloads (currently BUFFER_SPLIT is supported only).
 
+    When used with ``--rxpkts`` on PMDs supporting selective Rx data,
+    enables receiving only specific packet segments and discarding the rest.
+    Gaps between configured segments and any trailing data up to MTU are
+    automatically filled with NULL mempool segments (data is discarded).
+
 *   ``--rxpkts=X[,Y]``
 
     Set the length of segments to scatter packets on receiving if split
@@ -373,6 +378,20 @@ The command line options are:
     command line parameter and the mbufs to receive will be allocated
     sequentially from these extra memory pools.
 
+    **Selective Rx Data Example:**
+
+    To receive only the Ethernet header (14 bytes at offset 0) and
+    a 64-byte segment starting at offset 128, while discarding the rest::
+
+        --rxoffs=0,128 --rxpkts=14,64
+
+    This configuration will:
+
+    * Receive 14 bytes at offset 0 (Ethernet header)
+    * Discard bytes 14-127 (inserted NULL mempool segment)
+    * Receive 64 bytes at offset 128
+    * Discard bytes 192-MTU (inserted NULL mempool segment)
+
 *   ``--txpkts=X[,Y]``
 
     Set TX segment sizes or total packet length. Valid for ``tx-only``
-- 
2.51.0

