Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07353CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0142342ED2;
	Thu,  1 Oct 2026 00:44:10 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id B95C542EA4
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:07 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so2435697a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808247;
 x=1791413047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3y2XabNe+O9HCLZu+RfaW6FjpssBvDv7RiWwnse9es=;
 b=oRydmKapZ1w4UotE65KT01XZH9x9pwA3buDWXjeM0nHEH2LTIVSaCoStMktd5BkE27
 ETYPj8YCvkFTeEtM62UnDiHsqB2bR1pbJm+nCFRQAsIwEw8VC7N74GgR+i3bV33+uVnb
 IaDUJdBMtLhJwbxm3r4a28imH1a55tRan+k7ZD64/YyHEawE6bi+OMUOA5EHM9A4/TFS
 ZaNroDg9EKdHmbuKTtDhHHqu33tmAWDAQhD8SjZcR2gDfzFSiWkf/ARj/UWfOAbyv31l
 hnqTsndvemOUjRRlbCxPAOtWe4Um4mWgo1bgvGv/oPcs1yJvIYIKQLd/I4k2uDu05qvT
 f4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808247; x=1791413047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U3y2XabNe+O9HCLZu+RfaW6FjpssBvDv7RiWwnse9es=;
 b=JKJFmy3ikTfwuSfd7nqJ5/oaG2eR4rMKBRO233si8sgVl7D6zgIj5+OgCBVJU/U//9
 KDIhxtFRKlSQ/4k9a5LcBEQpAu17iLNTxqqgj0uOCDKNl6olOa1K1RKiycOaGcrzeHdP
 zCqoelSAx9iIdEkKv2y4jPG4ql+G/sfIwAPMRE1TEXju8JFqVcAuSc1wzAMVAXbTmJKv
 NZWRC/vrsG3rBwWl0IRMSgINezlvTTFL4qW0mApOYPxX1bjlOe8h5UZCY3RV7I8cX9UR
 VYntc3ZSn7tmHmC996qfzzLo5mAkWwcuCdMOUcSv7lUtHKFHekbkJk/mLPQ6x99XBAKC
 IlKg==
X-Gm-Message-State: AFq9FYJBllXAOys+46MZm5ZN5dSYEYFb7Uuk19OVxajtgRb5h0s9sOdg
 1Y1uHwZGN5hIs7/5gfY5NM+VYET6V5//Bscvcu9V9xm3ct57OeNzkuMGzRr1e1k7f5JU2sfZhvx
 58mdK1ns=
X-Gm-Gg: AYBFou3nptwKJ0ZEVLTxpVjBZ833GldnGVQaUVI2DqIonHvgG3N9UnYJe/y02jCgXbf
 kjW5wBN0Q8FWutScavn5Nl3ZMDiJ2Y5q9gQQoxo1B9KIXCXuhqT9eSLKZZXGwl8OmweeTshjeaS
 5nCcbXPoYyV8SSmMu0vboTskO3ns7yuXIonbZI7UbJiKm9cQ6U9vFM8MuelXyaKDN9+NRGWyAJA
 m6XBsn9yKeK/L1GOX2YhEkeYwHWccEvBFMTGx7mbqyqaoXH/u43j5uYFLCDvd+IaUEnv3lGHiOa
 p3W/vd6LcShbNfHoXrogF6LrZeogUj2PwbrK4AZkQzVk/rCzlcFD24OVnTZcVEU0Qj/vM/XGeaJ
 ISaDgEfELOaLkpQ5bCHkBeGIwIZPhB4VUW5qxBJr5S5CYF0N5ymEBaUe61q37jUD6zMifBuZabu
 /jJy1rxUHH2AkxeiVCuB0+Kp4KFZlsJnoJyWwvbXDwm0nTKZk39TkIuI9hlr2wgMfzzYio4KQtO
 LF0RRGM5tbuw06q3cOxV/hdyZJi12nVDwkSdQ==
X-Received: by 2002:a17:90b:2c88:b0:3a0:2ffd:1a51 with SMTP id
 98e67ed59e1d1-3a4d1543f55mr2135264a91.10.1790808246837; 
 Wed, 30 Sep 2026 15:44:06 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v3 22/65] net/ena: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:40 -0700
Message-ID: <20260930224340.58580-23-stephen@networkplumber.org>
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

ena_process_uint_devarg() only checks that strtoull() consumed at least
one character, so trailing garbage such as "8junk" is accepted, and a
negative value is silently wrapped to a huge unsigned value.

ena_process_llq_policy_devarg() ignores the end pointer entirely, so any
unparsable value becomes zero and disables the LLQ policy rather than
being rejected.

ena_process_bool_devarg() only served enable_frag_bypass, and did
nothing beyond accepting "0" or "1" and storing into a bool, so drop it
and point rte_kvargs_handle_bool() at the field. A bare
"enable_frag_bypass" now enables it, along with the usual spellings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ena/ena_ethdev.c | 45 +++++-------------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ae48afcfdc..732f5f6f34 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -48,8 +48,6 @@
 
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 
-#define DECIMAL_BASE 10
-
 #define MAX_WIDE_LLQ_DEPTH_UNSUPPORTED 0
 
 #define ENA_TS_OFFSET_UNSET -1
@@ -321,9 +319,6 @@ static int ena_xstats_get_by_id(struct rte_eth_dev *dev,
 static int ena_process_llq_policy_devarg(const char *key,
 			const char *value,
 			void *opaque);
-static int ena_process_bool_devarg(const char *key,
-				   const char *value,
-				   void *opaque);
 static int ena_parse_devargs(struct ena_adapter *adapter,
 			     struct rte_devargs *devargs);
 static void ena_copy_customer_metrics(struct ena_adapter *adapter,
@@ -3832,11 +3827,9 @@ static int ena_process_uint_devarg(const char *key,
 				  void *opaque)
 {
 	struct ena_adapter *adapter = opaque;
-	char *str_end;
 	uint64_t uint64_value;
 
-	uint64_value = strtoull(value, &str_end, DECIMAL_BASE);
-	if (value == str_end) {
+	if (rte_kvargs_to_uint(value, 0, UINT64_MAX, &uint64_value) < 0) {
 		PMD_INIT_LOG_LINE(ERR,
 			"Invalid value for key '%s'. Only uint values are accepted.",
 			key);
@@ -3881,17 +3874,15 @@ static int ena_process_uint_devarg(const char *key,
 static int ena_process_llq_policy_devarg(const char *key, const char *value, void *opaque)
 {
 	struct ena_adapter *adapter = opaque;
-	uint32_t policy;
+	uint64_t policy;
 
-	policy = strtoul(value, NULL, DECIMAL_BASE);
-	if (policy < ENA_LLQ_POLICY_LAST) {
-		adapter->llq_header_policy = policy;
-	} else {
+	if (rte_kvargs_to_uint(value, 0, ENA_LLQ_POLICY_LAST - 1, &policy) < 0) {
 		PMD_INIT_LOG_LINE(ERR,
 			"Invalid value: '%s' for key '%s'. valid [0-3]",
 			value, key);
 		return -EINVAL;
 	}
+	adapter->llq_header_policy = policy;
 	PMD_INIT_LOG_LINE(INFO,
 		"LLQ policy is %u [0 - disabled, 1 - device recommended, 2 - normal, 3 - large]",
 		adapter->llq_header_policy);
@@ -3899,30 +3890,6 @@ static int ena_process_llq_policy_devarg(const char *key, const char *value, voi
 	return 0;
 }
 
-static int ena_process_bool_devarg(const char *key, const char *value, void *opaque)
-{
-	struct ena_adapter *adapter = opaque;
-	bool bool_value;
-
-	/* Parse the value. */
-	if (strcmp(value, "1") == 0) {
-		bool_value = true;
-	} else if (strcmp(value, "0") == 0) {
-		bool_value = false;
-	} else {
-		PMD_INIT_LOG_LINE(ERR,
-			"Invalid value: '%s' for key '%s'. Accepted: '0' or '1'",
-			value, key);
-		return -EINVAL;
-	}
-
-	/* Now, assign it to the proper adapter field. */
-	if (strcmp(key, ENA_DEVARG_ENABLE_FRAG_BYPASS) == 0)
-		adapter->enable_frag_bypass = bool_value;
-
-	return 0;
-}
-
 static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *devargs)
 {
 	static const char * const allowed_args[] = {
@@ -3956,8 +3923,8 @@ static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *de
 		ena_process_uint_devarg, adapter);
 	if (rc != 0)
 		goto exit;
-	rc = rte_kvargs_process(kvlist, ENA_DEVARG_ENABLE_FRAG_BYPASS,
-		ena_process_bool_devarg, adapter);
+	rc = rte_kvargs_process_opt(kvlist, ENA_DEVARG_ENABLE_FRAG_BYPASS,
+		rte_kvargs_handle_bool, &adapter->enable_frag_bypass);
 	if (rc != 0)
 		goto exit;
 
-- 
2.53.0

