Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F2606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mnam68Uh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB4B440299;
	Fri, 30 Oct 2026 10:41:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B6EC40BA4
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353267; x=1824889267;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5kgvgGk2Kp18qphWqESRKm9zyCObp6jxe0KuiGgyObI=;
 b=Mnam68UhD3s7czZqZOtGkMIbnQZHW+pPKTtQy6SSU3ZnKHM1Pu99H2p1
 l2d9HiF1ab5KfPXDEbRvl1EdNeuDamlU2qUw13sntO74SF73SH0YIRsXD
 My+BJo69IlJxbDXCmX7CejviMEs9vD1hJhvjsyGonJH8MpgdiqclPwjMv
 kEtc29vgK8/fzRYdLKoYr6soG5g0z7yW4Vmjd4KcpDw5dOZxpkVWsXUxt
 MErlnY5zqwhH56R68nJu6T3bjGBwsMOcxp33YwNd+EJrY3u92r7D0gs1o
 ZTbcb6cW8JLoKQjEzEopvwgQ14ZUotowuOGuKE1XM6XfoLn9hRZDmXHzO g==;
X-CSE-ConnectionGUID: PYijPOY/SRe18tXf0STqmg==
X-CSE-MsgGUID: 8339pMePRiy3oBDxCJTG3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126080"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126080"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:41:07 -0700
X-CSE-ConnectionGUID: 0wdOi4ziS/KnuqFPcgGLIQ==
X-CSE-MsgGUID: 23Awx5y3QSOCewwvj/ElgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299676"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:41:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 8/9] net/i40e: disable tunnel replacement in multi-driver
 mode
Date: Fri, 30 Oct 2026 09:40:21 +0000
Message-ID: <49b2bbaec2f222b9d289adb39378484e1af56b22.1793353215.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Cloud filter replacement is not supported in multi-driver mode, so
tunnel flows that need it (MPLS, GTP, QinQ, L4 port) always failed to
install. The failure also marked the tunnel state as needing a device
reset, which blocked all other tunnel flows.

Do not initialize the engines for these tunnel types in multi-driver
mode.

Fixes: 28a3d1c89167 ("net/i40e: reimplement tunnel parsers")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_tunnel.c | 34 ++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_tunnel.c b/drivers/net/intel/i40e/i40e_flow_tunnel.c
index 237678ab8c2..d74f46705f7 100644
--- a/drivers/net/intel/i40e/i40e_flow_tunnel.c
+++ b/drivers/net/intel/i40e/i40e_flow_tunnel.c
@@ -1883,6 +1883,20 @@ i40e_tunnel_flow_engine_init(const struct ci_flow_engine *engine __rte_unused,
 	return tunnel_priv->state == NULL ? -ENOMEM : 0;
 }
 
+static int
+i40e_tunnel_replace_flow_engine_init(const struct ci_flow_engine *engine,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev_data->dev_private);
+
+	/* tunnel filter replacement is not supported in multi-driver mode */
+	if (pf->support_multi_driver)
+		return -ENOTSUP;
+
+	return i40e_tunnel_flow_engine_init(engine, dev_data, priv);
+}
+
 static void
 i40e_tunnel_flow_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
 		void *priv)
@@ -1903,6 +1917,18 @@ static const struct ci_flow_engine_ops i40e_flow_engine_tunnel_ops = {
 	.flow_uninstall = i40e_tunnel_flow_uninstall,
 };
 
+/* for tunnel types that require tunnel filter replacement */
+static const struct ci_flow_engine_ops i40e_flow_engine_tunnel_replace_ops = {
+	.engine_init = i40e_tunnel_replace_flow_engine_init,
+	.engine_uninit = i40e_tunnel_flow_engine_uninit,
+	.ctx_init = i40e_tunnel_ctx_init,
+	.ctx_to_flow = i40e_tunnel_ctx_to_flow,
+	.flow_register = i40e_tunnel_flow_register,
+	.flow_unregister = i40e_tunnel_flow_unregister,
+	.flow_install = i40e_tunnel_flow_install,
+	.flow_uninstall = i40e_tunnel_flow_uninstall,
+};
+
 const struct ci_flow_engine i40e_flow_engine_tunnel_nvgre = {
 	.name = "i40e_tunnel_nvgre",
 	.ops = &i40e_flow_engine_tunnel_ops,
@@ -1923,7 +1949,7 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_vxlan = {
 
 const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
 	.name = "i40e_tunnel_mpls",
-	.ops = &i40e_flow_engine_tunnel_ops,
+	.ops = &i40e_flow_engine_tunnel_replace_ops,
 	.ctx_size = sizeof(struct i40e_tunnel_ctx),
 	.flow_size = sizeof(struct i40e_tunnel_flow),
 	.priv_size = sizeof(struct i40e_tunnel_priv),
@@ -1932,7 +1958,7 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_mpls = {
 
 const struct ci_flow_engine i40e_flow_engine_tunnel_gtp = {
 	.name = "i40e_tunnel_gtp",
-	.ops = &i40e_flow_engine_tunnel_ops,
+	.ops = &i40e_flow_engine_tunnel_replace_ops,
 	.ctx_size = sizeof(struct i40e_tunnel_ctx),
 	.flow_size = sizeof(struct i40e_tunnel_flow),
 	.priv_size = sizeof(struct i40e_tunnel_priv),
@@ -1941,7 +1967,7 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_gtp = {
 
 const struct ci_flow_engine i40e_flow_engine_tunnel_l4 = {
 	.name = "i40e_tunnel_l4",
-	.ops = &i40e_flow_engine_tunnel_ops,
+	.ops = &i40e_flow_engine_tunnel_replace_ops,
 	.ctx_size = sizeof(struct i40e_tunnel_ctx),
 	.flow_size = sizeof(struct i40e_tunnel_flow),
 	.priv_size = sizeof(struct i40e_tunnel_priv),
@@ -1950,7 +1976,7 @@ const struct ci_flow_engine i40e_flow_engine_tunnel_l4 = {
 
 const struct ci_flow_engine i40e_flow_engine_tunnel_qinq = {
 	.name = "i40e_tunnel_qinq",
-	.ops = &i40e_flow_engine_tunnel_ops,
+	.ops = &i40e_flow_engine_tunnel_replace_ops,
 	.ctx_size = sizeof(struct i40e_tunnel_ctx),
 	.flow_size = sizeof(struct i40e_tunnel_flow),
 	.priv_size = sizeof(struct i40e_tunnel_priv),
-- 
2.52.0

