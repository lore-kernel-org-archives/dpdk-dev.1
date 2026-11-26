Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABF606A335
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LJ4D3E/u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42721402C9;
	Thu, 26 Nov 2026 15:29:51 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by mails.dpdk.org (Postfix) with ESMTPS id 9870C402BD;
 Thu, 26 Nov 2026 15:29:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWv3BU8clg1CCiiJCklCNRN7795cfc9diq+zIuX8zud9hZOMG6MuPWx7nR0GTtvw0gaerj2ahsq78uLVSeF8ZU6RyFsYT+kgoW2NRnxOxBzDG+VY/9QXBvQD94svagfKqiFh12T4KLP5wiu8ThpsGvrVPKLvXTyU9R3q0gapzpkxbkAxKlXQlD31XlWRW5ICgEvs377R+nWVUgmJvToOy3UyauhiTuiWSab7ZAYX7hliiitQm87u1Yapl8Q+dtfJrfbt+jJ4euOgUQss5UTJHRkr2hewHTmPQ0fwxciDexpuWIlruOgqxEV9VS6stTXWK6dC1f/KLIk5USgyYAj7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAFD9+NFW1IQxUSwO4xCq+i2/Agz4V2zYwaS8dwWgGo=;
 b=a0hBngOwIi+kzdadEwrp3g0FZCl9tmnmfx8+FK3aTgG2C3I/tRPq4HpmqN/LIoPSOH8LTkCZFO3baEweR4h3BbU5j7wJGsaFdfhRmNkf5UMd/c0rIoJJtJC+uCsazORThzNNad+1VnBX49azE2PExV0Ej2AXunnX2t+nMgaZfVf7PAQlLwStFWPNsh4HO8DaK25iaA/07ccC+iYnVyCoGCqCtX7IdikibNibwBqzkMunYC6myqXvss3+gWjF12w71RPmcyMqRowetwxc5Ty2iy259YE5dMqG+cZ1+rA1IfQQ1t+02QpjNiTrUaew/JweR47zHoex6X6jQb9WqFmF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAFD9+NFW1IQxUSwO4xCq+i2/Agz4V2zYwaS8dwWgGo=;
 b=LJ4D3E/ucI4Gys58gZmHFTNQFipvr/uYbC4szk7AblgaQBUIta0Qrt6NB4scFq6IG/hb77q2iEUEFiH6etN0N+1pX7F2cpTDUyH2cutvheuQ1QS9mH0r52uKy7xscIit7duL+qjnvi7FPjAW8Vi6WNRHc+98zpgLSTscCGK9sMuH9nMRUMcL56KRLi3i90yi1Fyb3ga8oa7fEpKZyiz543XYWkqjuwijPFV7uklEPLEFmG/bSOorCaffaqDy9XHx5IaBYjryI/e+Lc/yRSTW4OcIQctOF3MtWR56UMMQckcGPl5GHSS6LPWYJpdkSfOfYf5Jy+35d+kAbSDKTGui5g==
Received: from IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::7)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Thu, 26 Nov
 2026 14:29:17 +0000
Received: from BL4PEPF000003EE.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::ad) by IA1P220CA0023.outlook.office365.com
 (2603:10b6:208:464::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 14:29:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL4PEPF000003EE.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 14:29:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 06:29:00 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 06:28:57 -0800
From: Gavin Hu <gahu@nvidia.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [PATCH] net/mlx5: fix mbuf corruption in vectorized MPRQ Rx
Date: Thu, 26 Nov 2026 16:28:24 +0200
Message-ID: <20261126142824.187895-1-gahu@nvidia.com>
X-Mailer: git-send-email 2.27.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003EE:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 183edf51-0d30-4854-951f-08df4bc9a70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261028144727099003|261022105027099003|10067099003|11063799006|261026140227099003|56012099006|261026121527099003|261009223027099003|261102123227099003|261021121427099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: /Tg3QvhR9Xj8vJHtRCZ0jqe3acx1FI2Cj7UOv30a+ydSOko9xNZZRUy/yJVJbM62DdSLZJjgXkoN8nFV1hFF/rEfvOMDf+diIDxXN0hE4fkqkj6IoRt2wWA1sgG5CNo5uB7EVg5uI7FGfopeTAEsvc7onfSy3c/jhDGE8xpcRxdwGH4LceZq04tvx4h3EJqToaM4TZjnIk+kpV9YAVfsOoiu4dH5aF9coRq4XyOwxMGcBM57aL5uL2dJAuxRLkokG/VskYO9Lw8fktnTTqLDNHTCapK8w+38fzig7ETJZ0G28laSau3Zp6qauUlPq8CHHqGwRxZ0LJ1ud+XiYr2kldY4JdBib44ytw2aXJ5mO3gLmUWL5lZqufuiji8sAPAFLXgOaXx/ljxq//y0MxKwFaOp3IPQqB0+0R1d4iw0KbP46OsPqiad5jJNMKOeMs8dB21LkSI5Xfxx2EVQmylhiMxuC9b6vjBoa/Nf1uOYxdgC7sIJQMGvG4lAcrFz1LCQDK/oJX/yRMNUx5bLHUS9mIDEKBa267QliV9ATAxZZDhKwnf/1wiJtSmz+pwQquCoo3xP0CC37DMQO9EA9KVDuFrOqD0tFDEdRVhDcE+SMIDvtQATr9aJBgYKHNleXbHBtiQLrl1zNVnUdYAa/rTCsvovG7ZmzuC4K94Ee9+DqldXz0mQpnXgmMTsuKp2/spCZQYgQSoUe8WcrVpQGLFrLw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261028144727099003)(261022105027099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261026121527099003)(261009223027099003)(261102123227099003)(261021121427099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xCq+jgiLtHvZXTp3dw+agYu5XTZZNAyuycXDUZvPGPJNcGCMFpbdWW6tKlz1SJer2y0u8jpwwt/iTlcOKpAP8z3WqzDLhnDwyvMbqtdk42A1psXEsKinIqNGHn+l9Segp4G/9ksoG0ti4f5SENMpApsIpivAJTn4mjUjnQF+voFUunO/AZMpY6KNuxUrqW7ZRav30Mz6hEZR3oYcHrgY6q3GsmWBIAFKG4xuNBmnoSUWnPRsEuGe83nAp030h0eF/RWyQzncAUJeFOxd8VO7gtcKl9haFLNLvKbcq6vi0O9jwWYNUWxhPaRoPfh1N7u2VzNqIFkR7g0WDUlTtfom19aIlXaQZsswJX+ubxz1lFpN+o3Fu8AaZJidec2rgTBcNtayCCq3oWBkehbW5Y2qpMy/MmcFpElgwOcVACm1HFqJrQouuVswh2QVF1S3iRS1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:29:17.1274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183edf51-0d30-4854-951f-08df4bc9a70b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL4PEPF000003EE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rxq_burst_mprq_v() caps the packets it handles by the number of
replenished mbufs:

	pkts_n = RTE_MIN(pkts_n, rxq->elts_ci - rxq->rq_pi);

That cap bounds rxq_cq_process_v() and the mbufs returned to the
application, but not the compressed CQE session handled at the
"decompress" label. rxq_cq_decompress_v() takes the session length
from the title CQE and always writes all of it into elts[].

For SPRQ this cannot overrun: the elts mbufs are the buffers posted to
the RQ, so the HW never completes more packets than there are mbufs.
MPRQ posts strides instead. The HW keeps completing packets no matter
how many elts the SW managed to replenish, so the session length is
unrelated to the number of available elts.

Once the mbuf pool runs dry, unzipping therefore walks past the
MLX5_VPMD_DESCS_PER_LOOP fake_mbuf guards placed at elts_ci and reaches
the slots beyond them, which still hold mbufs already handed to the
application. It overwrites their rearm_data and rx_descriptor_fields1.
rearm_data covers ol_flags, so the victim loses RTE_MBUF_F_EXTERNAL
while buf_addr and shinfo keep pointing at the MPRQ stride: the mbuf
now claims to be direct, but its buffer lives in stride memory. The lost
RTE_MBUF_F_EXTERNAL flag triggers incorrect mbuf handling later in the
application, when the mbuf is attached to another one.

Compute the session length from the title CQE before unzipping, the
same way rxq_cq_decompress_v() does, and leave the session in the CQ
until it fits entirely in the available elts. The CQ consumer index is
not advanced, so the session is retried on a later burst once
replenishment succeeds.

Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
Cc: stable@dpdk.org

Signed-off-by: Gavin Hu <gahu@nvidia.com>
---
 drivers/net/mlx5/mlx5_rxtx_vec.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 228ff2bfcb..c86d1f9f7e 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -561,7 +561,22 @@ rxq_burst_mprq_v(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 decompress:
 	/* Decompress the last CQE if compressed. */
 	if (comp_idx < MLX5_VPMD_DESCS_PER_LOOP) {
+		volatile struct mlx5_cqe *tcqe = &cq[nocmp_n];
+		uint32_t mcqe_n;
+
 		MLX5_ASSERT(comp_idx == (nocmp_n % MLX5_VPMD_DESCS_PER_LOOP));
+		/*
+		 * MPRQ HW completes packets regardless of how many elts were
+		 * replenished, and unzipping always writes the whole session.
+		 * Leave the session in the CQ until it fits.
+		 */
+		mcqe_n = rxq->cqe_comp_layout ?
+			 (MLX5_CQE_NUM_MINIS(tcqe->op_own) + 1U) :
+			 rte_be_to_cpu_32(tcqe->byte_cnt);
+		if (unlikely(mcqe_n > rxq->elts_ci - rxq->rq_pi)) {
+			*no_cq = !rcvd_pkt;
+			return rcvd_pkt;
+		}
 		rxq->decompressed = rxq_cq_decompress_v(rxq, &cq[nocmp_n],
 							&elts[nocmp_n], false);
 		/* Return more packets if needed. */
-- 
2.27.0

