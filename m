Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5F106ACEF
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71346402D0;
	Thu, 12 Mar 2026 23:02:23 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id 9316740275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:02:22 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id CE3AC780372;
 Thu, 12 Mar 2026 23:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773352942;
 bh=wXfYN7Rr7QFUVo6XaG5rS3ksa4s08IozWwm69oIKlsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GOJH5cDP0cHCjilIN1Zqwm+mq4nGHKa9pLCj2mU4+J3D5bLKiJrDWFhxKwtIaWmx9
 Fjk2mwDsqfOVHw/yrZ+U/hr9pI64OMUMoqjQNE+D/LwRIIfPow2mZsOrQLAMcaf1oW
 FMb9zSA9Uh8WMzhZTKIbCkEQpjPiysY9DyvIb0K/l9xGe0ticXLdkIhIXvWjegQWEK
 b0pwIJcApd5GwWMe/6pBMWzFBxJaxjY+rGxuDbPdZherQW3Eld3LR0u+vofpqykSQH
 VHReNx8/lUeXcsqtEBANjxk4GJe0P4fJVLkGF1y5mHhevUknmi3R8EgJltaMDPJ3Q2
 Zv/XxYsVIiH7w==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 03/9] common/mlx5: extend SQ modify to support rate limit
 update
Date: Thu, 12 Mar 2026 23:01:14 +0100
Message-ID: <20260312220120.3256755-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312220120.3256755-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
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

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 5 +++++
 drivers/common/mlx5/mlx5_devx_cmds.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index 8f53303fa7..17378e1753 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -2129,6 +2129,11 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
 	MLX5_SET(sqc, sq_ctx, state, sq_attr->state);
 	MLX5_SET(sqc, sq_ctx, hairpin_peer_rq, sq_attr->hairpin_peer_rq);
 	MLX5_SET(sqc, sq_ctx, hairpin_peer_vhca, sq_attr->hairpin_peer_vhca);
+	if (sq_attr->rl_update) {
+		MLX5_SET64(modify_sq_in, in, modify_bitmask, 1);
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
 
 
-- 
2.43.0

