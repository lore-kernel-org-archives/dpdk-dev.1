Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29901C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1483E40B95;
	Mon, 14 Sep 2026 07:50:36 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 6B33D406B4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:34 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2713086a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365033;
 x=1789969833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwKwFHW3vkfCRVGNDKjIdmB+Xu6uTQ0amFZuhLJOvYc=;
 b=RZbSTDFMZqW9lnP1orVfU4eDkhIgTRvMp/PxK3y++MSLRurdXLltichM3K5iireVSG
 QwXFjIThTGVOEn9L/JbPxbcLEHrl1p53s7lEaP4zfeGmtisuZ0T9gps6JLIllFb22JO0
 wOmneyqz1Fu/BieUn3pFqzXJXSaW80PnsGfIkGyaQcG1luYOzsZb3v3zS9mtxoM+uD6r
 SLE6G+KNIW7ScdNoIRFan4M2SJz0oaSQWMuGCanbjvxjCCSTvv2cam6UyO89vAyjfbJa
 Z06k4VNGXCRKkZCLf2T4p1hICHkQCMz86knfRsqoGojhXmJXzyoNJ8KKMzGrj1IkylT1
 yRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365033; x=1789969833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwKwFHW3vkfCRVGNDKjIdmB+Xu6uTQ0amFZuhLJOvYc=;
 b=Co5qb6f4YQvll40ZYBkPmawZIZKlo9p7yrhoHAyCRbUzYgfPm6B5A9uKzz5iPCmRSG
 7dSjE58E0mYGo4OstnwV2x8CvmykCIwdVNYmnkZTIjHpLQM/Q2H6D1xEYzyD0UPo41db
 JrpeapcO9SP5+rjR65cEfsOOXsCp6sbxyTrOzRiLk//+OZf+VZ906aMqVQo3Wzkh02G8
 pE1Y38FTJvHDsleBJrois0HuclseA/D297yjZ+knxY1faaFD9fyYIH2mJ+y0o4I28FKM
 hDZxZ5UslBT4ab1/TKKRq7twwYAN3aCUUI32QwQCVY7KK1Zv5gaE95ePQgfzOWVhb9AY
 cCiQ==
X-Gm-Message-State: AFuF++mH/LpdYxt3MYfIIeg9/mIJTvXAVnZJwk4Ics6CBXGW7X2qemt/
 h18+mfmJ323tuiZOoszyvOREOQL3kDW6wi4k73FsFbPC2XVO3zxdkC7xjeUAtp9ysG/nBBnO2/H
 DaGjK
X-Gm-Gg: AYBFou3zN/2BDG5o3xS0ZBQf7Qftb9FYUwqfGPKQevPnX/BDpubJU6uQBUwBKwU+tR1
 kMAFlXifTc1d+KGh7AMejLxsNu30VnNUDLKvKsqyFSWd/2SLuqO6Kj4AoOXMhqCYjyMWq6BAxUJ
 qxhyk3U46cbZH/u1hRn8Z2khwNw8W4jZq0mjH2V6D5jrNHTBdJpXgO8lhsxWjLVRhkWKTPejRir
 g8FMCnxt3e0fb3iV9zbcDFz84l20nxr4BuxFq7Fnm/soW4GORbDWoCw0rpD4smUHe6UiUnTMznP
 9jg9I++D8TUQsFFyoayUisV7WBWycWgBwCnZlznk5CAe0fFLMEN3A7a39mCAufzXVnK/fAXWKHu
 H6LeLpUscwqDCJnQcyOKg1shKwE4gWTwGmSRPrH/TYtDQkHAhtHlYere0MDUhbAzCTubRaeGMgf
 hyGLo42u5mw7Mik1ZsMLXjGeIKT7RGYXAllJZVh0fh4w+DNQVb5HC7stEyMVbhnibLuxbN5rCcD
 b3wlJQhrugpsoMzHqvb1KZhS07/TzUYFKD+sjLXavcDYMbg
X-Received: by 2002:a17:90b:1d82:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39dec0be84amr2388685a91.19.1789365033535; 
 Sun, 13 Sep 2026 22:50:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH 22/62] net/ena: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:53 -0700
Message-ID: <20260914054912.755403-23-stephen@networkplumber.org>
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
index ad2ac6dbbf..c91f4f4b73 100644
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
@@ -3841,11 +3836,9 @@ static int ena_process_uint_devarg(const char *key,
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
@@ -3890,17 +3883,15 @@ static int ena_process_uint_devarg(const char *key,
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
@@ -3908,30 +3899,6 @@ static int ena_process_llq_policy_devarg(const char *key, const char *value, voi
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
@@ -3965,8 +3932,8 @@ static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *de
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

