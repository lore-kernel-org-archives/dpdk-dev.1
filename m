Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C85F54ADA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:51:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C94A40B94;
	Tue, 24 Mar 2026 17:51:50 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id 0337740B9B
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:51:49 +0100 (CET)
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id E268F5FFAF;
 Tue, 24 Mar 2026 17:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774371108;
 bh=kBIRV21MAldJ7ZNtcftaaF+GUqHbTzOqmMwvlWGJVr0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kX069jFzvG2NDLUufqsUm1t/b74/bK2hibEoT30Hwaykd4FYXNMHDvs6uDxq3KYLf
 ES8cnfddGFc2xRuTMTHOE7stYeLu1MMYqREyaIyY76ketMyhDyQF1XmYyIn2GvGt2I
 RxiyGQNDLhS5VI+FZkd4zFK6ue3Cy5V91vHl0aFi3uy0XqvmDrwJrh/anWVAA4MlXv
 VWp6YQ3NPFYeejr5R5SwbVFGDd936zaRP29YPOA4KNmXaGCbaZgkkN6YtFtNhIdxSc
 o1ZTZbqLyZJv1lQ/zw0Z9J84WXS2CN+Mnu4LEvSiNnxgmelzYFWepQ8A0uXd96ofax
 ybxcQNzmPf5FA==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, aman.deep.singh@intel.com,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 03/10] common/mlx5: extend SQ modify to support rate limit
 update
Date: Tue, 24 Mar 2026 17:50:40 +0100
Message-ID: <20260324165047.391137-4-vjardin@free.fr>
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

Add rl_update and packet_pacing_rate_limit_index fields to
mlx5_devx_modify_sq_attr. When rl_update is set, the modify SQ
command sets modify_bitmask bit 0 and writes the PP index into
the SQ context, allowing dynamic rate changes on a live RDY SQ
without teardown.

modify_sq_in.modify_bitmask[0x40] bit 0 controls the
packet_pacing_rate_limit_index.

Supported hardware:
- ConnectX-6 Dx: per-SQ rate via packet_pacing_rate_limit_index
- ConnectX-7/8: same SQ context field, also supports wait-on-time
- BlueField-2/3: same modify_sq command support

Not supported:
- ConnectX-5: supports packet_pacing but only at SQ creation time,
  dynamic modify_bitmask update may not be supported on all FW
- ConnectX-4 Lx and earlier: no packet_pacing support

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 8 ++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 3 +++
 drivers/common/mlx5/mlx5_prm.h       | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 8f53303fa7..102f84fd5c 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -2129,6 +2129,14 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
 	MLX5_SET(sqc, sq_ctx, state, sq_attr->state);
 	MLX5_SET(sqc, sq_ctx, hairpin_peer_rq, sq_attr->hairpin_peer_rq);
 	MLX5_SET(sqc, sq_ctx, hairpin_peer_vhca, sq_attr->hairpin_peer_vhca);
+	if (sq_attr->rl_update) {
+		uint64_t msk = MLX5_GET64(modify_sq_in, in, modify_bitmask);
+
+		msk |= MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDEX;
+		MLX5_SET64(modify_sq_in, in, modify_bitmask, msk);
+		MLX5_SET(sqc, sq_ctx, packet_pacing_rate_limit_index,
+			 sq_attr->packet_pacing_rate_limit_index);
+	}
 	ret = mlx5_glue->devx_obj_modify(sq->obj, in, sizeof(in),
 					 out, sizeof(out));
 	if (ret) {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 930ae2c072..82d949972b 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -519,6 +519,9 @@ struct mlx5_devx_modify_sq_attr {
 	uint32_t state:4;
 	uint32_t hairpin_peer_rq:24;
 	uint32_t hairpin_peer_vhca:16;
+	uint32_t rl_update:1;
+	/* Set to update packet_pacing_rate_limit_index on a live SQ. */
+	uint32_t packet_pacing_rate_limit_index:16;
 };
 
 
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index ba33336e58..597d06362f 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -2985,6 +2985,7 @@ struct mlx5_ifc_create_tis_in_bits {
 	struct mlx5_ifc_tisc_bits ctx;
 };
 
+/* Bits for modify_rq_in.modify_bitmask (Receive Queue). */
 enum {
 	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_WQ_LWM = 1ULL << 0,
 	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_VSD = 1ULL << 1,
@@ -2992,6 +2993,12 @@ enum {
 	MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_RQ_COUNTER_SET_ID = 1ULL << 3,
 };
 
+/* Bits for modify_sq_in.modify_bitmask (Send Queue). */
+enum {
+	MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDEX =
+		1ULL << 0,
+};
+
 struct mlx5_ifc_modify_rq_in_bits {
 	u8 opcode[0x10];
 	u8 uid[0x10];
-- 
2.43.0

