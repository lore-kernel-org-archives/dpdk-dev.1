Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C1CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB7644064C;
	Wed,  3 Jun 2026 20:13:11 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id EE637402C4
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:13:10 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-307631dbfedso178414eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780510390;
 x=1781115190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vzzcF1atIW910HQCLB+UVaIK4GoN205qm8vV8T1mjg=;
 b=OAG+3QomtLYMjr4GT5bPLxA9gyGiQ89MvTa6X7Jb4lU19UvB4hpxFEasFTrZx3K7pk
 A5dYNg3dDcs6As4SG1d08X35mNkvWojCKNLdbKKons+8SMbqBCSrYR3TrCH+58lYkr4I
 XhsaUnLMYTPu+ApeKwu6EyoSQN1oN9ttL9VI8ha0WbPwD91tannqrpUs4md/1p+PPYwK
 JSW1lA7ENbRzUv7axB/79aeP9w6FoEWTFBu4FQWKXa/7knLJCvpc6uf4iQhJWKWdICsj
 VeOWbsqHsE4pCKWjwpkp+bHXcc31L7EOqQv9ghaKGmXc4Sf/dhDJluWdBWlu1Zp9DpNJ
 LlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780510390; x=1781115190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1vzzcF1atIW910HQCLB+UVaIK4GoN205qm8vV8T1mjg=;
 b=gnFOwixQaDH6ccuj8ncmL3IgnowepFXhK2XEJ4sGoVdOpmsFTkXcXWd8fwaeZ+PIlM
 YAcjyohKc4JYkqpZe/eK0UMGop+nTSf8giyDxCw5a8KqziZI+c/XUE82B9ZeCi8zmEJy
 AHeBwGK6DGadXuhkPx+it9aqLp3jm6YJaO2jtFfz1AbnXLeu40bCocDmjj0YDlXWWRpO
 9cfZkDFgXXPWNyRKjRMLUGYo+Fz4vLIwVH65OkqVfduLMhxQbZ8RJ9H+lMeqv1OncQ6R
 nMrEDb7e1MSMhpABnxeK/XkP8LZ06RjWo2t9LKZPCllioyA7Fn/dceiFlvP35vkWH0/x
 ZtRQ==
X-Gm-Message-State: AOJu0YyIBBDk5ubFdB9cIIg7C8cOiVyrjp80Xx9QkFkLjR7+NsW02nll
 7ztQsF7Wr51hwggEoL9gBWX1WXVDRPwcrUCHZNnhO5uyS9m836SdFjFIy/ARWW/VdvKp9sPjPLT
 TEq0s
X-Gm-Gg: Acq92OHzxUCwfqXMsAaSPL41jJHfK6mgvgIZsdULjZWCvdoh43qHI5JM34cLa8C76/8
 18CQa2aMqsOMBEJQUrak/wfW/xbqgwrYcYURcSkNQPlcqHU6kfN1C0B4k8PSBPZT4/NphzLxC4u
 0IJHhy7mJx+o5MxTSIYpw8uEhxtvcjpGFD6pytbkRLXtqE4Ni96LH6GyAEB2/1L4X32S/0lGcLE
 G9FDzad/4IzSAg43WWYn81N9cL/tkw5ls8XYF5NSCDokxA7gT7Dz44RUmduM+zVjpcvakiarOPq
 SmL+ieg812tW5D8LgEMoQBuCgWppkliXjZBthQczimfPLjtNHvw3KDpsxdzDGkosSxUamWjepr+
 IkSoKDvSQErFqiPIIYFFMt0AS8VeuS3kRuqca9QSyO80OF58ThA5PgJtkaReDDM3yvgTfXSRwzv
 wG1+ILvQO5PiSavo3XqGglDyTpFcgXVj15AwRtvB+iTmHBnIdKsGXoi2B6H7Hpq/uD6G6tuY2yP
 q4imLiqNDk=
X-Received: by 2002:a05:7301:6885:b0:304:acc:f086 with SMTP id
 5a478bee46e88-3074fc56550mr2284732eec.33.1780510389877; 
 Wed, 03 Jun 2026 11:13:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df102a1sm2745758eec.20.2026.06.03.11.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:13:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Denis Sergeev <denserg.edu@gmail.com>, stable@dpdk.org,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH] net/af_packet: fix parsing of numeric device args
Date: Wed,  3 Jun 2026 11:13:06 -0700
Message-ID: <20260603181306.459234-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603170812.212262-1-denserg.edu@gmail.com>
References: <20260603170812.212262-1-denserg.edu@gmail.com>
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

This driver has several numeric arguments but it was using
atoi() which allows garbage and negative values.
Convert to a helper using strtoul() with upper bound.

First found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Denis Sergeev <denserg.edu@gmail.com>
Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 58 +++++++++++++++++++----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 8303ff5ca9..b0ff22ea55 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -15,7 +15,9 @@
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
 
+#include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
 #include <arpa/inet.h>
@@ -1138,6 +1140,42 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	return -1;
 }
 
+/* Parse an unsigned integer device argument. */
+static int
+parse_uint(const char *key, const char *value,
+	   unsigned int *out, unsigned long limit)
+{
+	unsigned long val;
+	char *endptr;
+
+	if (value == NULL) {
+		PMD_LOG(ERR, "no value for argument \"%s\"", key);
+		return -1;
+	}
+
+	/* Skip leading whitespace so a leading sign can be detected. */
+	while (isspace((unsigned char)*value))
+		value++;
+
+	/* strtoul() silently accepts and negates a leading '-'. */
+	if (*value == '\0' || *value == '-') {
+		PMD_LOG(ERR, "invalid value \"%s\" for argument \"%s\"",
+			value, key);
+		return -1;
+	}
+
+	errno = 0;
+	val = strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0' || val > limit) {
+		PMD_LOG(ERR, "invalid value \"%s\" for argument \"%s\"",
+			value, key);
+		return -1;
+	}
+
+	*out = (unsigned int)val;
+	return 0;
+}
+
 static int
 rte_eth_from_packet(struct rte_vdev_device *dev,
 		    int const *sockfd,
@@ -1168,7 +1206,9 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	for (k_idx = 0; k_idx < kvlist->count; k_idx++) {
 		pair = &kvlist->pairs[k_idx];
 		if (strstr(pair->key, ETH_AF_PACKET_NUM_Q_ARG) != NULL) {
-			qpairs = atoi(pair->value);
+			if (parse_uint(pair->key, pair->value,
+				       &qpairs, RTE_MAX_QUEUES_PER_PORT) < 0)
+				return -1;
 			if (qpairs < 1) {
 				PMD_LOG(ERR,
 					"%s: invalid qpairs value",
@@ -1178,7 +1218,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_BLOCKSIZE_ARG) != NULL) {
-			blocksize = atoi(pair->value);
+			if (parse_uint(pair->key, pair->value, &blocksize, UINT_MAX) < 0)
+				return -1;
 			if (!blocksize) {
 				PMD_LOG(ERR,
 					"%s: invalid blocksize value",
@@ -1188,7 +1229,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_FRAMESIZE_ARG) != NULL) {
-			framesize = atoi(pair->value);
+			if (parse_uint(pair->key, pair->value, &framesize, UINT_MAX) < 0)
+				return -1;
 			if (!framesize) {
 				PMD_LOG(ERR,
 					"%s: invalid framesize value",
@@ -1198,7 +1240,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_FRAMECOUNT_ARG) != NULL) {
-			framecount = atoi(pair->value);
+			if (parse_uint(pair->key, pair->value, &framecount, UINT_MAX) < 0)
+				return -1;
 			if (!framecount) {
 				PMD_LOG(ERR,
 					"%s: invalid framecount value",
@@ -1208,13 +1251,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_QDISC_BYPASS_ARG) != NULL) {
-			qdisc_bypass = atoi(pair->value);
-			if (qdisc_bypass > 1) {
-				PMD_LOG(ERR,
-					"%s: invalid bypass value",
-					name);
+			if (parse_uint(pair->key, pair->value, &qdisc_bypass, 1) < 0)
 				return -1;
-			}
 			continue;
 		}
 		if (strstr(pair->key, ETH_AF_PACKET_FANOUT_MODE_ARG) != NULL) {
-- 
2.53.0

