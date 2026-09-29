Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C59CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F5D642EC1;
	Tue, 29 Sep 2026 18:38:48 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 0AF7442E1C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:28 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc797656e5eso2093977a12.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699907;
 x=1791304707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3y2XabNe+O9HCLZu+RfaW6FjpssBvDv7RiWwnse9es=;
 b=IgE1OotF0+/+d9OgKPr0blw+xMezZJ03vehlLR+E9CphNB6qqzdqOqORx8QgnRy8gB
 uYw3dsIL7XnN6bpafRIyFEBL+7fVZ2bVnNoBBP6iPiTFH0XF44Ta9dHUoURCSrnJCxsL
 TCOa0rM+1yC/rdX4T0IJgRg5qWKf8yeIiXYP7rOUiknkPmyDA1O6W89X7M5jxJmXUIMU
 XrN+QYwuh9S6BRrzWPevpDfAR1tciYbwvka5NCvNbYMig7Tpme3BQ1YAsBuc457q8Kgq
 uENz/lfnmZ8Mk6bkLzWPmLjctV0sgRzSz33+xMDqheEdduSaqFbRsc+E0BJh9eeszNC2
 /CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699907; x=1791304707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U3y2XabNe+O9HCLZu+RfaW6FjpssBvDv7RiWwnse9es=;
 b=mHqLaZ9IRhYVWuSiu4Ei9GnzuQOBdIKcO17SNJMd6TrI/T896DMnq6e4zSsL2/G7UV
 5syzJGh4KKYCHVQ1BV4yIJ7rAlXAaVikqhJXcvajtjtIDgSHfIo3sity2D5kBmFeWkl3
 KFSEO7Jo8GYlfjOq1/dNJn/gIIKJq9wgoFtUikJUeBPTp5+cOM8XwZqJ/dK/rmzE7ruy
 onqAahFI/3Kg6U06XU+aB9yXE9Byxh2FnDRZqRv/Vdhdl3q6ef9Rg4Aj77QRKkNy4n+v
 Cn7jufy05//Pe5yxm0EQTsAtcSsMYTAn0qZu51LNJaXkid2VXWTaWzCp9vkIPcL7H/iz
 7f8w==
X-Gm-Message-State: AFuF++nwEvvM/jnumEBnB6UinhXjec70dVuBP4E4TAt6ZpIHwNJs93yi
 viKPsd1F5g3b18cZesKch0ps2/ryqby7Dgvvrh1RoGWoHXNmsvLK10l46l/VIlShD8Ct0tw6XPc
 149OUgYc=
X-Gm-Gg: AYBFou0p3pjFortOsA8+VmqzpDIZoFFpc4KL0ID+5V3oeugpV//fyMrl+TGXf1ZE8rC
 tspHax88Ijg+74BngNSydYNN/S+hCu0ECOI/kKtAGVS+XiqMa1zHvKCFjUP0Kwtems+y0SvmW3w
 WZEW+79pJdCFLu1e18QYcLjFW9A5hJCUIM/m+IFRRlFabK/1r8OJ5c6itOgtBKx34eHg8XF0NRI
 NvpkFA5B5BMpLpkot5xz7+QTfv791W2yz2Dm5bWlu0eBBwRcJw2xbwREYhWlnboY8T8ERLVIKpt
 7zfSI0uze/wUN9r1otWxLx2bXVtp3MvISg7zFGDBeeOGwjNPFWyfe0jov4rgAPHDV8OHhPGSga1
 Abfa5bPKN4rmVcT1ENf+6NlcaSZyhDprecCOF5MDftHq5kdmNpEQyP7wZPF23XRIVx2UhsmHq69
 1YCTCQMXOidyp3k88ISXirIiS2o8B/mk0On5HcbULZ7ZlZGYvbRbl+Ct7xJzZqJI664lWqTYmBH
 ngXJ/ahmDPMn1guLqdnOZqL+6Lgv2lri5ga6g==
X-Received: by 2002:a05:6a21:32a3:b0:3de:51e1:e7c1 with SMTP id
 adf61e73a8af0-3de51e1eb60mr9130194637.3.1790699906675; 
 Tue, 29 Sep 2026 09:38:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v2 21/61] net/ena: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:24 -0700
Message-ID: <20260929163800.1108305-22-stephen@networkplumber.org>
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

