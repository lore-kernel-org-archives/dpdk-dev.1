Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A30CC0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 997E640E17;
	Mon,  3 Feb 2025 05:07:27 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6CFAB40A6B
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C45C0205491D; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C45C0205491D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555607;
 bh=n3fSQnNofQakaC6d4g4JW0HciO7hBKP91yevfTvAgQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BVS6/752jbkSC+xEGZp8oaIjbzvoRB8K3fwdsvwCbGigfarTYK7NDnLX/hmwI6e/F
 YWw/9gT+Vg0O5TpVsfTdv8DEiws8lbsevANAsMul/Dizqii49k4e2J5yEhafhN83db
 R4MVHLzvgz69aslf/7djL0fL1/8hZS77WOCBZxOk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v19 16/27] common/mlx5: remove use of VLAs for Windows built
 code
Date: Sun,  2 Feb 2025 20:06:19 -0800
Message-Id: <1738555590-12753-17-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
---
 drivers/common/mlx5/mlx5_common.h    | 4 ++--
 drivers/common/mlx5/mlx5_devx_cmds.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 1abd1e8239..f29f06a86e 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -125,10 +125,10 @@ mlx5_fp_debug_enabled(void)
 /* Allocate a buffer on the stack and fill it with a printf format string. */
 #define MKSTR(name, ...) \
 	int mkstr_size_##name = snprintf(NULL, 0, "" __VA_ARGS__); \
-	char name[mkstr_size_##name + 1]; \
+	char *name = alloca(mkstr_size_##name + 1); \
 	\
 	memset(name, 0, mkstr_size_##name + 1); \
-	snprintf(name, sizeof(name), "" __VA_ARGS__)
+	snprintf(name, mkstr_size_##name + 1, "" __VA_ARGS__)
 
 enum {
 	PCI_VENDOR_ID_MELLANOX = 0x15b3,
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index a75f011750..804ee67cd6 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -284,10 +284,9 @@ mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
 				 void *cmd_comp,
 				 uint64_t async_id)
 {
-	int out_len = MLX5_ST_SZ_BYTES(query_flow_counter_out) +
-			MLX5_ST_SZ_BYTES(traffic_counter);
-	uint32_t out[out_len];
+	uint32_t out[MLX5_ST_SZ_BYTES(query_flow_counter_out) + MLX5_ST_SZ_BYTES(traffic_counter)];
 	uint32_t in[MLX5_ST_SZ_DW(query_flow_counter_in)] = {0};
+	const int out_len = RTE_DIM(out);
 	void *stats;
 	int rc;
 
@@ -346,7 +345,7 @@ mlx5_devx_cmd_mkey_create(void *ctx,
 	int klm_num = attr->klm_num;
 	int in_size_dw = MLX5_ST_SZ_DW(create_mkey_in) +
 		     (klm_num ? RTE_ALIGN(klm_num, 4) : 0) * MLX5_ST_SZ_DW(klm);
-	uint32_t in[in_size_dw];
+	uint32_t *in = alloca(sizeof(uint32_t) * in_size_dw);
 	uint32_t out[MLX5_ST_SZ_DW(create_mkey_out)] = {0};
 	void *mkc;
 	struct mlx5_devx_obj *mkey = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*mkey),
-- 
2.47.2.vfs.0.1

