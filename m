Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC931C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92B1742686;
	Mon, 14 Sep 2026 07:51:57 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0B2FA410D5
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:56 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2dd4b3c752fso27437335ad.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365115;
 x=1789969915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S6DewSEz7Oeka/8OcHxjLW3H1OmLr9I7MjTFgeKWlLA=;
 b=ab/ziPvqiQ1UffbMa5On99RV3lHGaIUUivlecvBSlcA50Wo+Xnm5ODUQp7BMVHpCdA
 hYXV2Yw4azvb3CC+Nh3c3GqAC1Q+3aw917uoZ1rW464/YXalok5cZNMUT6wQi5bPt9yo
 P8jkDvfliNPnvtm2oGAskYs63FwJ5Izl0yCP/+a/ypK5ZN6KsXWziP+sSnVHZcWYycJz
 HAK6oVYcK7X6X6Z0dsDY4FOgg7j/vzOxpqdanUvHQobTG6FmZ+6VF8i0oeeLQvoFuEQm
 h1VAhIrzNkG7JBk/UMU+AqduO6PY4om3xlABl8q2/c6CmxIhI4DXSD84+wMyfrv8WMA/
 mqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365115; x=1789969915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S6DewSEz7Oeka/8OcHxjLW3H1OmLr9I7MjTFgeKWlLA=;
 b=hx3ELrreb9sCxY3ud3CJSia06BhxDdI5MlJxhWQqq4bmVTcvn+tbzwg9CzVK/NU6RK
 cUphHDwEz5cbYuG6v5WAGtGSNp458xkNmauP7CxWBUuXcy0vfB2nRp1wxaHNEfR7jZ2Z
 jup5qGW7g73a+D2R6nHo82VZZNuC6o5rLpLJRitzx9hr0XjKLQ4SJ9/HDqJpo2f0RrjJ
 msIBAblrjJoCh8FRxmJBitZKnZzqlTdzo6Dxp43o7Qjk0K9mUdIO/3HOGktfS+ULvOG8
 gi8E7jiBR5TXKfNBC+XJk9wtaHWNzdCvuzw8xx2i/cykPqNJNE3XkAcfFjNEnIs5Y+gQ
 7b2Q==
X-Gm-Message-State: AFuF++leLNi/hYuf3T6TQopUMYj3F3ri4u24yXh07k0UYYBC0e6nYiDx
 VEmd08R37PUOVz2xY+hqJPdj4G3XrE2i5jIR2DItGUAQhUkR034k4NKnWOnCctuNtM44sQK1Kvh
 9XMZSe3s=
X-Gm-Gg: AYBFou3sQ2Iterg85OR1v4YNgv9mP8OK8UPAUDujLCnZ4Oug7H30thRpXhD7iVyFWQf
 jtsHi/dmburJd7IjsjAts9aGAB99VlVDu6WgvqV0F9YvZbZBXtBB3yZ8XZQWue1SE7MZM/fBMGW
 PSAvsyASyoibZ8P6MVmmsxkeokFH8ljioXwZtq4pTVSBRjMEnju8zcbcdyPjjQ/LBr3W3b5nm81
 wwXsBZFRwvC71Us2txAPW8BLCOP1OAk3DuhjHy4Cphnt2SomhywvUAduzOlD4mJg0Guz+JsDaxa
 na1ZXOPcjexne/eoV/WVQa/nDXurFy70ZNsq3lxxt6C8p4p0S3owU5vJR659y18GOiKX693l6Dw
 ixk6KFWg95YQP3i7fJoLX4/2ECTCsaFXIXwSUKPtqsg2Vc9PuwF5tG7BqWItprcT2C2GxUzNN9T
 p7zvfl5/77ofNy5i7gHKCNfk5s3euLxXB8Uvn/myKGAtURFZKDD2kYaAMiR2bWSkV2OrMuoHFUi
 m7tKAcXKKxZHyEAW6NVHWMsUBIoYIIskkNV2w==
X-Received: by 2002:a17:90b:2541:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-39debf6bb19mr2476097a91.4.1789365115110; 
 Sun, 13 Sep 2026 22:51:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 45/62] net/bnxt: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:16 -0700
Message-ID: <20260914054912.755403-46-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index 8e8ead8f61..4903f6fb10 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5866,8 +5866,7 @@ bnxt_parse_devarg_flow_xstat(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long flow_xstat;
-	char *end = NULL;
+	uint64_t flow_xstat;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5875,9 +5874,7 @@ bnxt_parse_devarg_flow_xstat(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	flow_xstat = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (flow_xstat == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &flow_xstat) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to flow_xstat devarg.");
 		return -EINVAL;
@@ -5901,8 +5898,7 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 					const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long max_num_kflows;
-	char *end = NULL;
+	uint64_t max_num_kflows;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5910,9 +5906,7 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	max_num_kflows = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-		(max_num_kflows == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &max_num_kflows) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			"Invalid parameter passed to max_num_kflows devarg.");
 		return -EINVAL;
@@ -5926,8 +5920,8 @@ bnxt_parse_devarg_max_num_kflows(__rte_unused const char *key,
 
 	bp->max_num_kflows = max_num_kflows;
 	if (bp->max_num_kflows)
-		PMD_DRV_LOG_LINE(INFO, "max_num_kflows set as %ldK.",
-				max_num_kflows);
+		PMD_DRV_LOG_LINE(INFO, "max_num_kflows set as %uK.",
+				(unsigned int)max_num_kflows);
 
 	return 0;
 }
@@ -5937,8 +5931,7 @@ bnxt_parse_devarg_cqe_mode(__rte_unused const char *key,
 			   const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long cqe_mode;
-	char *end = NULL;
+	uint64_t cqe_mode;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5947,9 +5940,7 @@ bnxt_parse_devarg_cqe_mode(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	cqe_mode = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (cqe_mode == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &cqe_mode) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to cqe-mode "
 			    "devargs.");
@@ -5974,8 +5965,7 @@ bnxt_parse_devarg_app_instance_id(__rte_unused const char *key,
 				  const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long app_instance_id;
-	char *end = NULL;
+	uint64_t app_instance_id;
 
 	if (!opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -5983,9 +5973,7 @@ bnxt_parse_devarg_app_instance_id(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	app_instance_id = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (app_instance_id == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &app_instance_id) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Invalid parameter passed to instance devargs");
 		return -EINVAL;
@@ -6008,8 +5996,7 @@ bnxt_parse_devarg_app_id(__rte_unused const char *key,
 				 const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long app_id;
-	char *end = NULL;
+	uint64_t app_id;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6018,9 +6005,7 @@ bnxt_parse_devarg_app_id(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	app_id = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (app_id == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &app_id) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to app_id "
 			    "devargs.");
@@ -6044,8 +6029,7 @@ bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long ieee_1588;
-	char *end = NULL;
+	uint64_t ieee_1588;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6054,9 +6038,7 @@ bnxt_parse_devarg_ieee_1588(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	ieee_1588 = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (ieee_1588 == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &ieee_1588) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to ieee_1588 "
 			    "devargs.");
@@ -6088,8 +6070,7 @@ bnxt_parse_devarg_rep_is_pf(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_is_pf;
-	char *end = NULL;
+	uint64_t rep_is_pf;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6097,9 +6078,7 @@ bnxt_parse_devarg_rep_is_pf(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_is_pf = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_is_pf == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_is_pf) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_is_pf devargs.");
 		return -EINVAL;
@@ -6125,8 +6104,7 @@ bnxt_parse_devarg_rep_based_pf(__rte_unused const char *key,
 			       const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_based_pf;
-	char *end = NULL;
+	uint64_t rep_based_pf;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6135,9 +6113,7 @@ bnxt_parse_devarg_rep_based_pf(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_based_pf = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_based_pf == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_based_pf) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_based_pf "
 			    "devargs.");
@@ -6163,8 +6139,7 @@ bnxt_parse_devarg_rep_q_r2f(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_q_r2f;
-	char *end = NULL;
+	uint64_t rep_q_r2f;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6173,9 +6148,7 @@ bnxt_parse_devarg_rep_q_r2f(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_q_r2f = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_q_r2f == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_q_r2f) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_q_r2f "
 			    "devargs.");
@@ -6200,8 +6173,7 @@ bnxt_parse_devarg_rep_q_f2r(__rte_unused const char *key,
 			    const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_q_f2r;
-	char *end = NULL;
+	uint64_t rep_q_f2r;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6210,9 +6182,7 @@ bnxt_parse_devarg_rep_q_f2r(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_q_f2r = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_q_f2r == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_q_f2r) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_q_f2r "
 			    "devargs.");
@@ -6237,8 +6207,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_fc_r2f;
-	char *end = NULL;
+	uint64_t rep_fc_r2f;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6247,9 +6216,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_fc_r2f = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_fc_r2f == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_fc_r2f) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_fc_r2f "
 			    "devargs.");
@@ -6264,7 +6231,7 @@ bnxt_parse_devarg_rep_fc_r2f(__rte_unused const char *key,
 
 	vfr_bp->flags |= BNXT_REP_FC_R2F_VALID;
 	vfr_bp->rep_fc_r2f = rep_fc_r2f;
-	PMD_DRV_LOG_LINE(INFO, "rep-fc-r2f = %lu", rep_fc_r2f);
+	PMD_DRV_LOG_LINE(INFO, "rep-fc-r2f = %u", (unsigned int)rep_fc_r2f);
 
 	return 0;
 }
@@ -6274,8 +6241,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 			     const char *value, void *opaque_arg)
 {
 	struct bnxt_representor *vfr_bp = opaque_arg;
-	unsigned long rep_fc_f2r;
-	char *end = NULL;
+	uint64_t rep_fc_f2r;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6284,9 +6250,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep_fc_f2r = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep_fc_f2r == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep_fc_f2r) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Invalid parameter passed to rep_fc_f2r "
 			    "devargs.");
@@ -6301,7 +6265,7 @@ bnxt_parse_devarg_rep_fc_f2r(__rte_unused const char *key,
 
 	vfr_bp->flags |= BNXT_REP_FC_F2R_VALID;
 	vfr_bp->rep_fc_f2r = rep_fc_f2r;
-	PMD_DRV_LOG_LINE(INFO, "rep-fc-f2r = %lu", rep_fc_f2r);
+	PMD_DRV_LOG_LINE(INFO, "rep-fc-f2r = %u", (unsigned int)rep_fc_f2r);
 
 	return 0;
 }
@@ -6311,8 +6275,7 @@ bnxt_parse_devarg_representor_mode(__rte_unused const char *key,
 				   const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long rep;
-	char *end = NULL;
+	uint64_t rep;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6320,9 +6283,7 @@ bnxt_parse_devarg_representor_mode(__rte_unused const char *key,
 		return -EINVAL;
 	}
 
-	rep = strtoul(value, &end, 10);
-	if (end == NULL || *end != '\0' ||
-	    (rep == ULONG_MAX && errno == ERANGE)) {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &rep) < 0) {
 		PMD_DRV_LOG_LINE(ERR,
 				 "Invalid param passed to rep mode in devargs");
 		return -EINVAL;
@@ -6340,8 +6301,7 @@ bnxt_parse_devarg_scalar_mode(__rte_unused const char *key,
 			      const char *value, void *opaque_arg)
 {
 	struct bnxt *bp = opaque_arg;
-	unsigned long rep;
-	char *end = NULL;
+	uint64_t rep;
 
 	if (!value || !opaque_arg) {
 		PMD_DRV_LOG_LINE(ERR,
@@ -6349,9 +6309,7 @@ bnxt_parse_devarg_scalar_mode(__rte_unused const char *key,
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

