Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D234CC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 10:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 300DD40661;
	Fri, 28 Mar 2025 11:53:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8044B4065E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 11:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743159196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abBzSG8XjTYj6/FZ0vVIoNf085jhdgAxbWNKvCExGqg=;
 b=O7/3Ww948Cc0EVJsssGw/7Ii9BrAR3Mg0Tbn8Ic3qP1DMS4YM/ydU1DQMltM3oRcY/fAU7
 gH18oGPfFXO/cE6hFsOsN9vqkSA3lNjyUWiop1c4rVe/9L5AN8qD36ABlQD+BWjBhJlReu
 ZTxTvVkR98jFwwQ7L5raIFL0SWvTPc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-zezeOXelMF2uQCCED3uKbA-1; Fri,
 28 Mar 2025 06:53:13 -0400
X-MC-Unique: zezeOXelMF2uQCCED3uKbA-1
X-Mimecast-MFC-AGG-ID: zezeOXelMF2uQCCED3uKbA_1743159192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA5D9196B370; Fri, 28 Mar 2025 10:53:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4A2D1828A84; Fri, 28 Mar 2025 10:53:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v6 2/8] drivers: remove incorrect exported symbols
Date: Fri, 28 Mar 2025 11:52:39 +0100
Message-ID: <20250328105250.3082414-3-david.marchand@redhat.com>
In-Reply-To: <20250328105250.3082414-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mst3HTMNU5yt_SBsYRLhAkVGzFkVvsCaYyIU3yDVGYM_1743159192
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Declaring inline helpers in version.map is unnecessary.
There is no exported symbol and this will probably be treated as an
error by MSVC linker.

rte_dpaa2_dev_type is an enum token.
roc_se_ctx_swap has no implementation (leftover from a previous rework)
and can be removed.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/version.map    | 1 -
 drivers/bus/fslmc/version.map   | 2 --
 drivers/common/cnxk/roc_se.h    | 1 -
 drivers/common/cnxk/version.map | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/bus/dpaa/version.map b/drivers/bus/dpaa/version.map
index a17d57632e..8f09b72757 100644
--- a/drivers/bus/dpaa/version.map
+++ b/drivers/bus/dpaa/version.map
@@ -18,7 +18,6 @@ INTERNAL {
 	dpaa_update_link_speed;
 	dpaa_intr_disable;
 	dpaa_intr_enable;
-	dpaa_seqn;
 	dpaa_svr_family;
 	dpaa_update_link_status;
 	fman_dealloc_bufs_mask_hi;
diff --git a/drivers/bus/fslmc/version.map b/drivers/bus/fslmc/version.map
index 2c36895285..ba3c7f36e3 100644
--- a/drivers/bus/fslmc/version.map
+++ b/drivers/bus/fslmc/version.map
@@ -22,7 +22,6 @@ INTERNAL {
 	dpaa2_get_mcp_ptr;
 	dpaa2_io_portal;
 	dpaa2_seqn_dynfield_offset;
-	dpaa2_seqn;
 	dpaa2_svr_family;
 	dpbp_disable;
 	dpbp_enable;
@@ -108,7 +107,6 @@ INTERNAL {
 	qbman_swp_push_set;
 	qbman_swp_release;
 	rte_dpaa2_alloc_dpci_dev;
-	rte_dpaa2_dev_type;
 	rte_dpaa2_free_dpci_dev;
 	rte_dpaa2_intr_disable;
 	rte_dpaa2_intr_enable;
diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
index ede8d69c0e..f2c4056169 100644
--- a/drivers/common/cnxk/roc_se.h
+++ b/drivers/common/cnxk/roc_se.h
@@ -405,7 +405,6 @@ int __roc_api roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type ty
 int __roc_api roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type,
 				  const uint8_t *key, uint16_t key_len);
 
-void __roc_api roc_se_ctx_swap(struct roc_se_ctx *se_ctx);
 void __roc_api roc_se_ctx_init(struct roc_se_ctx *se_ctx);
 
 void __roc_api roc_se_hmac_opad_ipad_gen(roc_se_auth_type auth_type, const uint8_t *key,
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index cdbfc1d39a..7f40dcced2 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -164,7 +164,6 @@ INTERNAL {
 	roc_mcs_custom_tag_cfg_get;
 	roc_mcs_dev_init;
 	roc_mcs_dev_fini;
-	roc_mcs_dev_get;
 	roc_mcs_event_cb_register;
 	roc_mcs_event_cb_unregister;
 	roc_mcs_flowid_entry_enable;
@@ -546,7 +545,6 @@ INTERNAL {
 	roc_tim_lf_enable;
 	roc_tim_lf_free;
 	roc_tim_lf_interval;
-	roc_se_ctx_swap;
 	roc_ree_af_reg_read;
 	roc_ree_af_reg_write;
 	roc_ree_config_lf;
-- 
2.48.1

