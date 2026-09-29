Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9667CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D70042E95;
	Tue, 29 Sep 2026 18:38:40 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id C2CB342E69
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:20 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8805988a200so2865139b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699900;
 x=1791304700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PrEZfaecDPORdNJRFdIxJezVZoP6c/QkHrOt5m5TcKk=;
 b=BHXQCHwNSqd1Ulf2dD8E0CGiYBsZf9XlWXNWIeRl6kOADbTyTV6+2P2luQ8kNSZRSx
 hqcr1HAPVq0cAzeRlU5SAe9LgWScUiSjdEr3KGZoil1fM7SHBPeNR/gaZzTv5EunlZKl
 wm1z+fGyVrLGwJfxKtPHWR5osUTNk/ZmPe4g8kv6MKOBLjDx7T05LijK7QvLAySf2KNU
 BzI6YnxlvsFq2xeA6oJJeGKUJy/f4vv8Cjrntq/lEc6WTHlZsRDIEe220VI6ST31Vi0O
 NocMkfGofVv5EW5eMmGEvDPwAho7TZUL7QQX54pSEX2x7hPOri7LFaghL3ibACb6p5vM
 d4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699900; x=1791304700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PrEZfaecDPORdNJRFdIxJezVZoP6c/QkHrOt5m5TcKk=;
 b=SY2kEQqxbwPC9GC33QLMD8ayLkiCRChWNtLQ6JGe6tbKA0Lv+9oyqVQKelDDLi6l2b
 gMAgis+K1h+fIbE/mchm+MT7hUx5lzui/lqKmUKNRdiYpvwX4Qwkn+knZx1C1fn5qFFU
 Q+WoyXBj3vZnaKmn+AiyZ3dCND39k4hvIRQEY2p/5QHp9f0K9eSCS5xLV1CsEa8nyHYH
 IuBuDkd+1HYwJ6ijP0G01pQIUFYRWmNJbfPXHlGAJhC0DMcdugHDchxNDMhOOjiGL9BJ
 frNhKBY/QgiRulXNHbQWfA07gIu/MD6Q34Ok3UEJausnTN6SsZQrZB98SCxKekMg38yV
 ikzA==
X-Gm-Message-State: AFuF++laNOsHh01dnpEBX6MTXIVkBh6a5Ryc6S+igxgkn6q765uCTLek
 9j3YgbzAzOgyIGLkpuq4XSeVRkZH8uxbKI2gb91nq/kkIUFMTJxa4TkLyoE0gZXgb8mFv1M7bdF
 jjppdhi4=
X-Gm-Gg: AYBFou21hPUyfI0rWhVP7YLj5WLALbPPql1XAdFbpNjVeJbDobOZTR/1fErkfUamtyb
 bEX0O48cpdQMs31wpGdfuDCSEA37U1uch1M5h87xhlRvX1Vdqey/kVxBqa7qmoxKvmHWLq47scG
 cS9FpFVgD7B4ef4yJNuLD1WY7l+fBCLC1xb4rNPRW8UvNPUGguOw8F2Psr8gRrgS0yWm7g2weRP
 APc3RAbfLTzqOlzC+xzk/mRlHlnBBUx3lyDo8nA/KO81q5lnR3pndkMBmBpWg9B/CebzYFltVr1
 PnlXOQyhSxIgEHieICtsGwQ+iyDj8PjLZnnGBt/cIxUQN/ORCboXwlxE1DM9e681S3AF7ON7JkD
 Ke8kWadNmxA42pv5WVtrlb8BtEja2rMmVjJaty7CW//jpEeOZUq8DKx05wvOOWBPaud9nulmcI7
 wepUw9eheFDGdRc1HgLSV12oGWCHSlhdJozLEMxmIsvFPcvJTPJWXZqfJR/mPReemXu+GaofhVr
 ogtzCnj12fPHrFtuAr0m8G5ZWIiGGEg+wnVzA==
X-Received: by 2002:a05:6a00:808a:b0:874:708d:b640 with SMTP id
 d2e1a72fcca58-87e9e96dc18mr13607377b3a.33.1790699899894; 
 Tue, 29 Sep 2026 09:38:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 13/61] net/af_packet: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:16 -0700
Message-ID: <20260929163800.1108305-14-stephen@networkplumber.org>
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

The open coded parse_uint() is correct, but the same checks are now
available from kvargs. Use them, and express the lower bound as part of
the range rather than as a separate test after each call.

qdisc_bypass is a boolean, so parse it with rte_kvargs_handle_bool()
into a bool. A bare "qdisc_bypass" with no value now enables it, which
the manual pair loop here supports without any further change.

Note that the qdisc_bypass parameter of rte_pmd_init_internals() stays
an unsigned int: its address is passed to setsockopt(), which expects a
four byte int.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 72 +++++------------------
 1 file changed, 16 insertions(+), 56 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index a93df97023..18153d9e7e 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -15,7 +15,6 @@
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
 
-#include <ctype.h>
 #include <errno.h>
 #include <limits.h>
 #include <linux/if_ether.h>
@@ -1156,36 +1155,17 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 /* Parse an unsigned integer device argument. */
 static int
 parse_uint(const char *key, const char *value,
-	   unsigned int *out, unsigned long limit)
+	   unsigned int *out, unsigned long min, unsigned long max)
 {
-	unsigned long val;
-	char *endptr;
+	uint64_t val;
 
-	if (value == NULL) {
-		PMD_LOG(ERR, "no value for argument \"%s\"", key);
-		return -1;
-	}
-
-	/* Skip leading whitespace so a leading sign can be detected. */
-	while (isspace((unsigned char)*value))
-		value++;
-
-	/* strtoul() silently accepts and negates a leading '-'. */
-	if (*value == '\0' || *value == '-') {
-		PMD_LOG(ERR, "invalid value \"%s\" for argument \"%s\"",
-			value, key);
-		return -1;
-	}
-
-	errno = 0;
-	val = strtoul(value, &endptr, 10);
-	if (errno != 0 || *endptr != '\0' || val > limit) {
+	if (rte_kvargs_to_uint(value, min, max, &val) < 0) {
 		PMD_LOG(ERR, "invalid value \"%s\" for argument \"%s\"",
-			value, key);
+			value == NULL ? "" : value, key);
 		return -1;
 	}
 
-	*out = (unsigned int)val;
+	*out = val;
 	return 0;
 }
 
@@ -1204,7 +1184,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int framesize = DFLT_FRAME_SIZE;
 	unsigned int framecount = DFLT_FRAME_COUNT;
 	unsigned int qpairs = 1;
-	unsigned int qdisc_bypass = 1;
+	bool qdisc_bypass = true;
 	const char *fanout_mode = NULL;
 
 	/* do some parameter checking */
@@ -1219,52 +1199,32 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	for (k_idx = 0; k_idx < kvlist->count; k_idx++) {
 		pair = &kvlist->pairs[k_idx];
 		if (strstr(pair->key, ETH_AF_PACKET_NUM_Q_ARG) != NULL) {
-			if (parse_uint(pair->key, pair->value,
-				       &qpairs, RTE_MAX_QUEUES_PER_PORT) < 0)
+			if (parse_uint(pair->key, pair->value, &qpairs,
+				       1, RTE_MAX_QUEUES_PER_PORT) < 0)
 				return -1;
-			if (qpairs < 1) {
-				PMD_LOG(ERR,
-					"%s: invalid qpairs value",
-					name);
-				return -1;
-			}
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_BLOCKSIZE_ARG) != NULL) {
-			if (parse_uint(pair->key, pair->value, &blocksize, UINT_MAX) < 0)
+			if (parse_uint(pair->key, pair->value, &blocksize,
+				       1, UINT_MAX) < 0)
 				return -1;
-			if (!blocksize) {
-				PMD_LOG(ERR,
-					"%s: invalid blocksize value",
-					name);
-				return -1;
-			}
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_FRAMESIZE_ARG) != NULL) {
-			if (parse_uint(pair->key, pair->value, &framesize, UINT_MAX) < 0)
+			if (parse_uint(pair->key, pair->value, &framesize,
+				       1, UINT_MAX) < 0)
 				return -1;
-			if (!framesize) {
-				PMD_LOG(ERR,
-					"%s: invalid framesize value",
-					name);
-				return -1;
-			}
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_FRAMECOUNT_ARG) != NULL) {
-			if (parse_uint(pair->key, pair->value, &framecount, UINT_MAX) < 0)
+			if (parse_uint(pair->key, pair->value, &framecount,
+				       1, UINT_MAX) < 0)
 				return -1;
-			if (!framecount) {
-				PMD_LOG(ERR,
-					"%s: invalid framecount value",
-					name);
-				return -1;
-			}
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_QDISC_BYPASS_ARG) != NULL) {
-			if (parse_uint(pair->key, pair->value, &qdisc_bypass, 1) < 0)
+			if (rte_kvargs_handle_bool(pair->key, pair->value,
+						   &qdisc_bypass) < 0)
 				return -1;
 			continue;
 		}
-- 
2.53.0

