Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC4CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152EC42F29;
	Tue, 29 Sep 2026 18:40:00 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 3F65542EBE
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:48 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-881a3a28e72so1400271b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699927;
 x=1791304727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QvgE8Tu53IxpO0ns9Qe15sCN5jqAtH5c/H3I1z0XVlQ=;
 b=0ufXMPoSCj2zKq0XSzGfC7vp3wIH/n2nrnitofEwiyMlq3/X+Fn+eumOyCqZt2IdZj
 lHOjY/papdCEhrSWnjL7GGokkHhl/dwKU7QJE4EenFspWlM9aaOsOB9QgQnClqiQvlPv
 eMyT3nlSKhFkJvUrdiu+Sqaupxjv7H98zZlXAQcHd583cd5UgrvVeeF51pKr+u0jhnuL
 nJiMt/sf80mU0Oz/BnS1ifIRMuiQ+E4QfCtPZqBgYhATMXQir1UthbkIbPfYX3ElFHXu
 z3817U2yAvUHJXG+B30ISsGoLyV+/WRdOx7l4+anfXgwSzVMO2g3FvoDjx2U/lnDMJbU
 p44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699927; x=1791304727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QvgE8Tu53IxpO0ns9Qe15sCN5jqAtH5c/H3I1z0XVlQ=;
 b=ARRlv6PINnEGzZy3lPfq8Z5xrlGQxg2Eh334GJguTVovdW9m8DxxCOTzUxKhGjOMLY
 Nbiw/KdmeIdCLiyZF6x645p9TMzPMucn8yGlEH8VV2AzLkXFGnaCH9M/CmpQDwfOWHnC
 HqfdTyW8QpiPH/1RmlMgwWnXYuvJZgkUyr59xjptHkP+nBB/eAZLyo68bmaPOXoYItoh
 RZTjb6BbIpIjX2xQ4U/71Mttp0iCRjneGy8mzNdzL7nmUo5BHazld1koZWEwBf8/eKRF
 DE4SlDqJf07vqd/htsv5f7OxTTL0nrMzzQweUjAaCNM1wWfGogervHpc4klloYDoH3C7
 DqVg==
X-Gm-Message-State: AFuF++k2ywWOc4JquxOmQJcMrtFhJrq+S+vEol2cBYlR/bm2rWpX5gVv
 SZuwkfqmRefhA9GUTxcpgWZs/4Qa7Mbqsd+So/fKd7t7e1812GIVwK274lqWz9C47PaUf2j4/rh
 08SYHyj4=
X-Gm-Gg: AYBFou3rC/ArP0vhRQm+7Dp6QPWBASkL4Q+ptat3tPzh3ORbISklsQPKAU6lIYa7VGS
 tflC/KyBYWrc1w2BTLVRP2cYrvsHmpk0UYZ8HTwyIM3o40Kvs19tTidMUAnidEdTf+JvnMy6c9u
 /VRA4cNN2yy2C1jZK6txNGX0Xe4mFKuN2hbCe90pvR2QHqLO5GmKD8ra4AjVo39roimYXahpLDk
 wQdiiqGaBwiRakNNi4+29Wobax3IK1FhQdE2oPhyBWXQ/t4Bv69C/k0woSG2rMU6ECimqfHsmN7
 2CJezKGn6EQ5wUKgQHAvW8l0ole25gt3JEZBH/p2n0j8C8rAYkcHNVfDwYK+/VdUSNnhFMM2fby
 jrv5bukKqfTXka5wT1PkcbX5hXOMiLlp2kPycudICJRKhV5p1tV/6cDej8IOn3bFAgUxR99U/D6
 Kx5GmZQqn3p0j3I0KDBT2u1wHklmM9ls9NLr6QN5aEgKeX51wqnuJo8PilQ936YutigqkqynE+s
 x2mwzqV3kOLcZ3tlAW5uQyo7+5KNkZBKjrIRRs9oMHgcKgF
X-Received: by 2002:a05:6a00:90a4:b0:86a:c062:8af2 with SMTP id
 d2e1a72fcca58-87e98d8a469mr12856835b3a.3.1790699927378; 
 Tue, 29 Sep 2026 09:38:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH v2 44/61] net/bnxt: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:47 -0700
Message-ID: <20260929163800.1108305-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

All fourteen handlers repeat the same open coded conversion, testing
errno for ERANGE without ever clearing it first. A stale ERANGE left by
earlier code therefore rejects a valid value, and the test only fires at
all when the result happens to be ULONG_MAX.

The per-argument range checks are left as they are, since they carry the
documented limits for each devarg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_ethdev.c | 106 ++++++++++-----------------------
 1 file changed, 32 insertions(+), 74 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4d4349457c..2942482579 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5872,8 +5872,7 @@ bnxt_parse_devarg_flow_xstat(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long flow_xstat;
-	char *end = NULL;
+	uint64_t flow_xstat;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5881,9 +5880,7 @@ bnxt_parse_devarg_flow_xstat(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	flow_xstat = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (flow_xstat == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &flow_xstat) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to flow_xstat devarg.");
 		return -EINVAL;
@@ -5907,8 +5904,7 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 					const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long max_num_kflows;
-	char *end = NULL;
+	uint64_t max_num_kflows;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5916,9 +5912,7 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	max_num_kflows = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-		(max_num_kflows == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &max_num_kflows) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Invalid parameter passed to max_num_kflows devarg.");
 		return -EINVAL;
@@ -5932,8 +5926,8 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 
 	bp->max_num_kflows = max_num_kflows;
 	if (bp->max_num_kflows)
-		PMD_DRV_LOG_LINE(INFO, "max_num_kflows set as %ldK.",
-				max_num_kflows);
+		PMD_DRV_LOG_LINE(INFO, "max_num_kflows set as %uK.",
+				(unsigned int)max_num_kflows);
 
 	return 0;
 }
@@ -5943,8 +5937,7 @@ bnxt_parse_devarg_cqe_mode(__rte_unused const char *key,
 			   const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long cqe_mode;
-	char *end = NULL;
+	uint64_t cqe_mode;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5953,9 +5946,7 @@ bnxt_parse_devarg_cqe_mode(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	cqe_mode = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (cqe_mode == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &cqe_mode) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to cqe-mode "
 			    "devargs.");
@@ -5980,8 +5971,7 @@ bnxt_parse_devarg_app_instance_id(__rte_unused const char *key,
 				  const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long app_instance_id;
-	char *end = NULL;
+	uint64_t app_instance_id;
 
 	if (!opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5989,9 +5979,7 @@ bnxt_parse_devarg_app_instance_id(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	app_instance_id = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (app_instance_id == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &app_instance_id) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Invalid parameter passed to instance devargs");
 		return -EINVAL;
@@ -6014,8 +6002,7 @@ bnxt_parse_devarg_app_id(__rte_unused const char *key,
 				 const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long app_id;
-	char *end = NULL;
+	uint64_t app_id;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6024,9 +6011,7 @@ bnxt_parse_devarg_app_id(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	app_id = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (app_id == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &app_id) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to app_id "
 			    "devargs.");
@@ -6050,8 +6035,7 @@ bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long ieee_1588;
-	char *end = NULL;
+	uint64_t ieee_1588;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6060,9 +6044,7 @@ bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	ieee_1588 = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (ieee_1588 == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &ieee_1588) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to ieee_1588 "
 			    "devargs.");
@@ -6094,8 +6076,7 @@ bnxt_parse_devarg_rep_is_pf(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_is_pf;
-	char *end = NULL;
+	uint64_t rep_is_pf;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6103,9 +6084,7 @@ bnxt_parse_devarg_rep_is_pf(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_is_pf = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_is_pf == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_is_pf) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_is_pf devargs.");
 		return -EINVAL;
@@ -6131,8 +6110,7 @@ bnxt_parse_devarg_rep_based_pf(__rte_unused const char *key,
 			       const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_based_pf;
-	char *end = NULL;
+	uint64_t rep_based_pf;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6141,9 +6119,7 @@ bnxt_parse_devarg_rep_based_pf(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_based_pf = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_based_pf == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_based_pf) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_based_pf "
 			    "devargs.");
@@ -6169,8 +6145,7 @@ bnxt_parse_devarg_rep_q_r2f(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_q_r2f;
-	char *end = NULL;
+	uint64_t rep_q_r2f;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6179,9 +6154,7 @@ bnxt_parse_devarg_rep_q_r2f(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_q_r2f = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_q_r2f == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_q_r2f) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_q_r2f "
 			    "devargs.");
@@ -6206,8 +6179,7 @@ bnxt_parse_devarg_rep_q_f2r(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_q_f2r;
-	char *end = NULL;
+	uint64_t rep_q_f2r;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6216,9 +6188,7 @@ bnxt_parse_devarg_rep_q_f2r(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_q_f2r = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_q_f2r == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_q_f2r) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_q_f2r "
 			    "devargs.");
@@ -6243,8 +6213,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_fc_r2f;
-	char *end = NULL;
+	uint64_t rep_fc_r2f;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6253,9 +6222,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_fc_r2f = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_fc_r2f == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_fc_r2f) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_fc_r2f "
 			    "devargs.");
@@ -6270,7 +6237,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 
 	vfr_bp->flags |= BNXT_REP_FC_R2F_VALID;
 	vfr_bp->rep_fc_r2f = rep_fc_r2f;
-	PMD_DRV_LOG_LINE(INFO, "rep-fc-r2f = %lu", rep_fc_r2f);
+	PMD_DRV_LOG_LINE(INFO, "rep-fc-r2f = %u", (unsigned int)rep_fc_r2f);
 
 	return 0;
 }
@@ -6280,8 +6247,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_fc_f2r;
-	char *end = NULL;
+	uint64_t rep_fc_f2r;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6290,9 +6256,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_fc_f2r = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_fc_f2r == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_fc_f2r) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_fc_f2r "
 			    "devargs.");
@@ -6307,7 +6271,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 
 	vfr_bp->flags |= BNXT_REP_FC_F2R_VALID;
 	vfr_bp->rep_fc_f2r = rep_fc_f2r;
-	PMD_DRV_LOG_LINE(INFO, "rep-fc-f2r = %lu", rep_fc_f2r);
+	PMD_DRV_LOG_LINE(INFO, "rep-fc-f2r = %u", (unsigned int)rep_fc_f2r);
 
 	return 0;
 }
@@ -6317,8 +6281,7 @@ bnxt_parse_devarg_representor_mode(__rte_unused const char *key,
 				   const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long rep;
-	char *end = NULL;
+	uint64_t rep;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6326,9 +6289,7 @@ bnxt_parse_devarg_representor_mode(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Invalid param passed to rep mode in devargs");
 		return -EINVAL;
@@ -6346,8 +6307,7 @@ bnxt_parse_devarg_scalar_mode(__rte_unused const char *key,
 			      const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long rep;
-	char *end = NULL;
+	uint64_t rep;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6355,9 +6315,7 @@ bnxt_parse_devarg_scalar_mode(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Invalid param passed to scalar mode in devargs");
 		return -EINVAL;
-- 
2.53.0

