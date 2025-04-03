Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3452C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 16:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA7C640E0F;
	Thu,  3 Apr 2025 18:59:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4E5B0406B4
 for <dev@dpdk.org>; Thu,  3 Apr 2025 18:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743699551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6080000lxk62J7S8txiGvq+1HVCOtLrBAn5ILlzB78=;
 b=X14SwH8hDC8WoYEeIM9Di6cv1Dbsx/ot9x9YY+7eTXZwLuxDq0HUxelhIavip80JKDSmcs
 2HSlC7uNnRIjKkAmdtoKya9qfqFp50piTs6Gm7LeZ6Y/oCzzbs4+gpI9ERQuB5Jt5lCdjU
 uWEA7Xk6Kg8tnNots9f+eyBpDKba2Sw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-7wD0_EsvNeKS-JG57gecBg-1; Thu,
 03 Apr 2025 12:59:07 -0400
X-MC-Unique: 7wD0_EsvNeKS-JG57gecBg-1
X-Mimecast-MFC-AGG-ID: 7wD0_EsvNeKS-JG57gecBg_1743699546
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC5F818001DE; Thu,  3 Apr 2025 16:59:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AF7D19560AD; Thu,  3 Apr 2025 16:59:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v7 2/8] drivers: remove incorrect exported symbols
Date: Thu,  3 Apr 2025 18:58:31 +0200
Message-ID: <20250403165845.1315380-3-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -tu023MmbdFUqykhPKGcamjxAA-evzCcqMjvD6tcWzo_1743699546
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
2.49.0

