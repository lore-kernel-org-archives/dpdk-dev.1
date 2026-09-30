Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B9CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EE2542FB2;
	Thu,  1 Oct 2026 00:44:35 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 0CAA542F91
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:33 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 41be03b00d2f7-cc7a15ba46fso1795613a12.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808272;
 x=1791413072; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QvgE8Tu53IxpO0ns9Qe15sCN5jqAtH5c/H3I1z0XVlQ=;
 b=z6S/w4RyZOUg2hxNODrtKF3eHgk9kJ839XpqjvAK5tFgNVCbvaBP8rsQIBXMRHs8DA
 DN6ECXM1CuxO/yo2zmRW3Z8ce3/1cfqZSmre0cPs5kuT3x/6aW5322kqvEJO4B8BEm2h
 caVHrweEpc25w7p6AttsMhNH/V9JVPB4PhxObT0gqZdD8UDPoRHTayzrKskx6Nu0xmcp
 74SusgKwtUbn/7V6XGsJHwElzE3SzMJuuL53b2Eo7s6v+s+u5EjgCH0U9OdJBS3h/EDF
 rcRq7s3PEsfp4GaiPPKmaNgb/G5Q+pit/lF0SJ5b+Hli/57CjN2n32/BZkKoHu/h4CjX
 hX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808272; x=1791413072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QvgE8Tu53IxpO0ns9Qe15sCN5jqAtH5c/H3I1z0XVlQ=;
 b=TCu4pW7yBrhi2mcoun6VzhcV+ui5vihieDUJpdF9IGiTr+PtkAATSYB7uROrcEciWr
 yeVILBrtk5d03IuCkjht4dL9sisWu52qjjZ8j8e7kAqT/NHqoDAJFzvOhfJz6rnaspOg
 toFFAfbtLnnjOyNhbHqB7bFl4sSKqP/CsKXWGt8mcwQ7Rq+KUJIPCj4uMvx+TjlGqdNy
 yJjCSG1mnMxgKrQfGcUB+QIwf1JXHjr+tEXN0WEbwL0DVkeenioMb3HfgOUcQPBUfDEX
 0CLE89+kfI6aduGnDr2B5CXctyDAQQ0C8Hz5lb0g40cTNuAh5nqnI53fUpYWhbeuiRQb
 abbA==
X-Gm-Message-State: AFq9FYLaTF8Xk4OIuMPkT72waPeftgriuOkxDfLFrJ4wHjBwMpeorczN
 xOgHtnjcOTx/DBoeMvytUrhtuHNrMHqJo8CyQwTkApP0WEw31wnq67pulq4TukZ7be1Gfh92uS7
 ny5a9RPg=
X-Gm-Gg: AYBFou2eKc1ShJr3aXyB4ax3DfmqP94/OShMjvze0ehXu3iemJPMzBuQ65+nxJFa2dl
 p+xd/H7CpeOkirhhaYzNUfpKF9kDvz0iHwAD/WbArjmU/mzey2FF5frSyqlBAbGe2N9EAYZ3QM1
 GAwzH8UyZoT2wKZGLejOMbXC0oVmPSowZVCg1NmXTTFIa7xouwynAWv7zkTobz3HSOna91vuuZf
 thwW+AdMuXoMW3i0esT3GOP9fg4032YpjyLww9cNH5wbJKopfpy1Af7S9ocUAQDImF9jRzVTYOq
 sRqQrWWIPtp85XgyvbRCCZuROrHfaARy6+NX39SH0YNbeuA/Nto0p24qHEJ5O0JqKh405VaP6mh
 HwMOCrbVY3THK6uAOAviSH7lU56VFMc34eKYbDT18IJlEq6+kVOQI5xV24azvFxezpkEUOY78GH
 A8wvhRJr4xMprPwnlrsHnzsu2iCUxoee9RkPV8S/tMhh305HXI/DD/5Jw/noREMCD6ls7NhL+T0
 I+qc8p25iRwgWyVD8qNdoOj6FBtYtq+JHC8yw==
X-Received: by 2002:a17:90a:a97:b0:3a4:e31b:9310 with SMTP id
 98e67ed59e1d1-3a4e31ba0e1mr1108188a91.67.1790808271780; 
 Wed, 30 Sep 2026 15:44:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH v3 45/65] net/bnxt: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:03 -0700
Message-ID: <20260930224340.58580-46-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

