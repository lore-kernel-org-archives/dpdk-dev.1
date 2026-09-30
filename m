Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B42CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADF1A42E84;
	Thu,  1 Oct 2026 00:44:01 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 9CF204281D
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:58 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7c9c2df74so617656a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808238;
 x=1791413038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PrEZfaecDPORdNJRFdIxJezVZoP6c/QkHrOt5m5TcKk=;
 b=mg2U/MOWgBJCVoeWC5CQIDWnB5WoeosgKszS6JCFrEPtR5mLfSVxFDomgsdpPbYssI
 2xMO+Scqo9YFVU3T00GrznoysPLuyWfOlmARQ3fAihL0elubRGn1+6XaaNQCVXclEhKQ
 DlYAfmn3R+d3w917dP25Z3p5Blbp6z9ciPbR/4qERYRvSikSlpwWgcIpwaardMdn7qLB
 rZ8uZLMK6MbDAZ2LsaRhEJp54+FNAOrS1dBXis6h16jO/9HTpfhmTenDyZ2J1O1msBen
 SUxEzIwTgsPjj1zEwgCg7zb2DBcjOjN2e1aacBwbRwYLkd8V0lQqXcYfhWCsQXKP+86S
 UIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808238; x=1791413038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PrEZfaecDPORdNJRFdIxJezVZoP6c/QkHrOt5m5TcKk=;
 b=F9YKD2iLrUIuMDaGWblEJKG841+jpewQcSoiT2Fj4ZIdna7EUYbcUv8UpWuUbzHP3c
 0lGxOs0ap3dR0P1CeuI7wgfBZ4zpiJOF0r4Nawg0u2xd97fslBglBAdOhaScL4lWF/kS
 WHZRXEiUKK5g1owtZI/nmyvX7FrG0h7oBn5lKkuCPM6WHSwVnb8Uh7IMTaFMeKnmcTk1
 SnPRhPEMQegf03vJzZPOfpJVOWh39rUJeV8aPT0eplc+DdARjLHkCDOli4oHsqUnfmzm
 BEm/sxdsxQA9fbz/OPfLISOzlMQCd2gFOywFzyCb98B463Up+65RqbaIUY6xi4+ZPVmF
 gl4A==
X-Gm-Message-State: AFq9FYIXSVtbvAq/XR6demaChXiP17UmtZKF/0kLpfbBOGfldBNaXaJp
 /nuJ/JDyuUhIC0Hg19FiW/RwFpm3oQkobjKCG314sI/snlAqtbZA6ElI6tAouN8n1oZfRhXQnuI
 1Fh+Oc1Q=
X-Gm-Gg: AYBFou3meqdkQvG1w8rRjKXSDC/qVcMJv2OMYCZFZzsq3L/jwUEsBDeYK3f9zrjKCkA
 6h50Fr77YWQ25/5xYmkyYxFx+iDzUbevSI9EafSOd8VLSnSS6KgRP4S6Rk2lmnh/Bg6dTLs56aE
 lxnXx+zkgunzPb6yjRuqOOr4IMiRTTlbP0++FeIBE4q0nBg2hBgda2wGq6j/q1wC1pZjO+7YXml
 LTA7JqaRRzK+OjTDitPqt3/kKSrHj2beTW2ghZTCGMcIP19zh2983Z1lPIMOSrBMtM7qpiYFi/s
 3dm/EHHn+0L7XCTxtCD1wPzoEKkVZPwPF1HTiP7wUALyLvVDUpGCldoIq7QFaL3B1ExNnV/wg0C
 nJ4fo3w4hLXRIwXsxv+CQwdqBm+WlOm/y28xs9SoltlScCHc2vyMLKRI5Ysr8NjbcupuJXk7dMf
 2DSFfexqzqUdD8NLSXR1cso0qlMp2JnODtMyZliP+b8hHJJ4Azs5O3lKn2H4pLa4RY/8JOqP3Da
 JhyhfJBeI4PxGZ1FmjLK3vqUrJn8swYoH/Zsg==
X-Received: by 2002:a17:90b:1e49:b0:3a0:aaed:b254 with SMTP id
 98e67ed59e1d1-3a4f2afcd3fmr498346a91.5.1790808237658; 
 Wed, 30 Sep 2026 15:43:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 14/65] net/af_packet: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:32 -0700
Message-ID: <20260930224340.58580-15-stephen@networkplumber.org>
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

