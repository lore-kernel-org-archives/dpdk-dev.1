Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA99F54ADA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C9440B8C;
	Tue, 24 Mar 2026 17:51:35 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id BB37740B8C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:51:33 +0100 (CET)
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 9724C6013F;
 Tue, 24 Mar 2026 17:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774371093;
 bh=ROIZ1bmUjO1vEYjWU8tijgLg+dSMXRJ5GGDHrdUJh/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u59pA/mbd4lcl42ZSGQlq1/T1or6ujqVmB+0urprYsfQNBHzcQgUtp5z2vgytoCaH
 vxJJZFW8EK9H4R4ot4vq4hqEqQhGuqxQIinsDgOxJJaG8DSAkppp+xtv/BfB1tgdgi
 yDLYZi+jMkhQYsPwXXu0dt7qzXwgN1xtzYuMknzhDfJiHxbn9mgu0kbKH2HtUzVa0N
 NTb/O2O8nOJ9VHTi9RzLKm8Ymf8I5XA3GkbP4c/vzFP9R5ktGptKrm7Af//sz9PGJ6
 kIE3aotHYH02wLTRp0DvP4p/nQ3yp4vQuodMdKGjODW4QV1YaJ5mox6iMNA0JsCtpU
 KHoNkvenlAYtQ==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 02/10] common/mlx5: query packet pacing rate table
 capabilities
Date: Tue, 24 Mar 2026 17:50:39 +0100
Message-ID: <20260324165047.391137-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324165047.391137-1-vjardin@free.fr>
References: <20260322134629.94633-1-vjardin@free.fr>
 <20260324165047.391137-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Query additional QoS packet pacing capabilities from HCA attributes:
- packet_pacing_burst_bound: HW supports burst_upper_bound parameter
- packet_pacing_typical_size: HW supports typical_packet_size parameter
- packet_pacing_max_rate / packet_pacing_min_rate: rate range in kbps
- packet_pacing_rate_table_size: number of HW rate table entries

These capabilities are needed by the upcoming per-queue rate limiting
feature to validate devarg values and report HW limits.

Supported hardware:
- ConnectX-6 Dx and later (different boards expose different subsets)
- ConnectX-5 reports packet_pacing but not all extended fields
- ConnectX-7/8 report the full capability set
- BlueField-2 and later DPUs also report these capabilities

Not supported:
- ConnectX-4 Lx and earlier (no packet_pacing capability at all)
- ConnectX-5 Ex may not report burst_bound or typical_size

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 15 +++++++++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 11 ++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index d12ebf8487..8f53303fa7 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1244,6 +1244,21 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 				MLX5_GET(qos_cap, hcattr, packet_pacing);
 		attr->qos.wqe_rate_pp =
 				MLX5_GET(qos_cap, hcattr, wqe_rate_pp);
+		attr->qos.packet_pacing_burst_bound =
+				MLX5_GET(qos_cap, hcattr,
+					packet_pacing_burst_bound);
+		attr->qos.packet_pacing_typical_size =
+				MLX5_GET(qos_cap, hcattr,
+					packet_pacing_typical_size);
+		attr->qos.packet_pacing_max_rate =
+				MLX5_GET(qos_cap, hcattr,
+					packet_pacing_max_rate);
+		attr->qos.packet_pacing_min_rate =
+				MLX5_GET(qos_cap, hcattr,
+					packet_pacing_min_rate);
+		attr->qos.packet_pacing_rate_table_size =
+				MLX5_GET(qos_cap, hcattr,
+					packet_pacing_rate_table_size);
 		if (attr->qos.flow_meter_aso_sup) {
 			attr->qos.log_meter_aso_granularity =
 				MLX5_GET(qos_cap, hcattr,
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index da50fc686c..930ae2c072 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -67,7 +67,16 @@ struct mlx5_hca_qos_attr {
 	/* Power of the maximum allocation granularity Object. */
 	uint32_t log_max_num_meter_aso:5;
 	/* Power of the maximum number of supported objects. */
-
+	uint32_t packet_pacing_burst_bound:1;
+	/* HW supports burst_upper_bound PP parameter. */
+	uint32_t packet_pacing_typical_size:1;
+	/* HW supports typical_packet_size PP parameter. */
+	uint32_t packet_pacing_max_rate;
+	/* Maximum supported pacing rate in kbps. */
+	uint32_t packet_pacing_min_rate;
+	/* Minimum supported pacing rate in kbps. */
+	uint16_t packet_pacing_rate_table_size;
+	/* Number of entries in the HW rate table. */
 };
 
 struct mlx5_hca_vdpa_attr {
-- 
2.43.0

