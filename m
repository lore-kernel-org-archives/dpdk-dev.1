Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A97C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1377D40A6F;
	Mon, 14 Sep 2026 07:50:09 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id C06B040BA5
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:07 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb5so1320086a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365007;
 x=1789969807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utY1f8BicQnR4R38lvPoYl7vjlkfRxZOwGR77DApHy8=;
 b=RSH+jNweoBJc0KQi2ZnA/8zC1KYQBw8jlErgPY1WXORz9rXh6u0d/ooaHcC0icSb9v
 88jbx7borNFMs3FgzN+zT4FlyFm126pOICBtt9YW2jmgRLmMdIh9emw2jnwbH2jo8jBN
 0ZDjis/WlUuwbpzFGu7ZCM8wtzJXGE2BkP2VzUZa3qMNbSGLotqBgWxQaZAs+CLAie1e
 n3Ger40WVIzoZkYLQg5VcL7VL/W1QZ+QhX3z17TX2P7MINNzGZCAA/GcYkSYrDme8g2f
 zd2RJ0luZMWerqPqKVfI3ZTG+++Z8OPvGOl+z5su4ujw8OlyD/S+4zN0OrVPD1sTrNKM
 25dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365007; x=1789969807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=utY1f8BicQnR4R38lvPoYl7vjlkfRxZOwGR77DApHy8=;
 b=pt/fk71SeWm0KkgWx+r/fW8kopRbHAMGJbc7vh1XT1EW7Ec7sP7ri97BV488rVfZdI
 UOjqGAKl6mJuNodD+72/ZyTIXXS5oB0VgQb91HvNHBGv485VJ6V2BMyZ0sMEjIksVvHc
 Vvj/LX8jllsUa8Zh5kXc3wO6czJVPBMeucxJKobf6RVFm9r1biUJ5e0hJy0UTQz3ABAR
 BBZnW9Kcku+lsPCoCMrqnrdfYtmNYO1MmKoE2nUvxqdzX0kUATmbR+tJi8QZpa90A79N
 cH5RoYiBlA0QEEvp+xsAsYC6CIBvxcQvEcsEHpASl8fjFa765HPnnUa1kFwx99SJM+cR
 47Ig==
X-Gm-Message-State: AFuF++kNqdDqlQf1yWa5n4oqTgLyuH/QDUaqQi22IJbwbu/n34j7OXiB
 DeI3jfCe1jS+ZQke10VVCbEgkOGPGRxn/PeE3jBn0uE6h/AraMohAqtGp/EUoy4iy08mgx8up4K
 rT56E
X-Gm-Gg: AYBFou2Obc/yzttPTTM6YmGyF//dUdvObzgo/v4tGrXMg1S5Ew7eAndeySwzqs43aqh
 Qz+ZgwVBegaVMGZ5y0cIWUdM5XsUFm9x6ohhypI0IL60W3+FqkoLexfHEZ5H/TAaxKJYi6NBc1B
 XNvPJlE6L79BySvZEg9BVzYBgMu2DoCNHDuYPEaoAW9bbmQ3xcNugnfwz994lh9/9VsqkYnZOOn
 gpIU8yZKh/XfkYRlMLP/6uaqU2hAosOQ+o7eC+1NFCENTX3l8tsVeXYTrVqFjKqDX3avOoWw4c1
 Z7T8b/3ZhlyWMffOsRlYA3wXPTh853tGeo7i9azRcxjYSBSk8DfbxY8gKzApwlKy9T2ydqjnN4u
 fQSoMU9Y1EwATgbJsDVXuVbOE6Dt571bhg6a/fECyOo6en7AhR7/EeqSwLPItLagniv/FgxDeZv
 OJLnHqHVsHm7H9YUn3Dw3WFKlH3+RehJhzyahjD6frUJVui8Q1uYhwmRLP4s1b7APs3qACrSAb5
 amCpqnmVxNdrdiVFA/DiKV82AXaTFvl1lGNWg==
X-Received: by 2002:a17:90b:390f:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39dec079f10mr2416206a91.14.1789365006900; 
 Sun, 13 Sep 2026 22:50:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 14/62] net/af_packet: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:45 -0700
Message-ID: <20260914054912.755403-15-stephen@networkplumber.org>
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
index b0ff22ea55..8de4705744 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -15,7 +15,6 @@
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
 
-#include <ctype.h>
 #include <errno.h>
 #include <limits.h>
 #include <linux/if_ether.h>
@@ -1143,36 +1142,17 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
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
 
@@ -1191,7 +1171,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int framesize = DFLT_FRAME_SIZE;
 	unsigned int framecount = DFLT_FRAME_COUNT;
 	unsigned int qpairs = 1;
-	unsigned int qdisc_bypass = 1;
+	bool qdisc_bypass = true;
 	const char *fanout_mode = NULL;
 
 	/* do some parameter checking */
@@ -1206,52 +1186,32 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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

