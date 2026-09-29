Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E1CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716E742EBD;
	Tue, 29 Sep 2026 18:38:47 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id B300D42E76
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:26 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7cadbe09dso315736a12.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699906;
 x=1791304706; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=geFaAqc4zXKUrXTBLyJuDjt7oH8Y6er79XBHrJfcs1JsyGkQBAGgyP/OnEHK/HviQT
 FXc/mxgBaNcI4wAsZlL9eM8QV5/ExkebS/bW5jyllHt4UPZqpoC702nS1BW6cPY58M7O
 ZDsipPG1izZ/3OFOBmAaf097KaqinBZnjctWD/KZj7KP5VjZ4zZjlHSRumh6hpivpEUA
 mRqyPMY868JaAbRnRFyhjQDhdXQfh4a6ppCkL1mB6AFv0rzofTk9GHY6DrY1dg8TyBHz
 POGIuWwS/pSOUXwD1QkvGOJODWc+lQwjNio7GHI9TiIHGBWpT91yoMEyX6jETNk/Dofu
 hkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699906; x=1791304706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uwbTdXrZHHRu5UJRxMdJUVQEUJTKofE3eTpof2vH2Bo=;
 b=uWhBYBTgXtYxq+lxUZsjTZaJ9wYqcEJ0KIlGP67eCQOVqEqzSOiWboLRM8BzjrO4H2
 Uv9zMx6+/dJ+3bgMlWXIUkw5G9vFWtPaT2TH5q+w4Syc84q7CY9VuPm/ko/OAOKLyZch
 aALkx5ZTk4SKhxBIvGsnUmQjTkUxPq/s79GpjJ5vP3S3f7Vk9JJO+1xjLw9AHJJeZOzE
 D2jSt+EXbEDje9zl9MbQi/HcSUd5xLtaY4G4EYnFj8EXUTCAebPRnioOmV3M6UunEhs+
 54H3OeM6WmVdhSkEUi73rykAaOz9DBIVgS9SFhmM92Ob+aa/bnQjDm+xeaqnxg7cOq2G
 xNsg==
X-Gm-Message-State: AFuF++nKEvg/nFNGObcD7zoB0MY0dzOVLWsFy0xMFlPvTPN3+spIMaib
 vpDn1JB0uKIK20PQKJoskw45ecBrZjL5N6SMLWn+VN+6WLtDa0K9UI1PAZLLiKUZBSVccqvBzDD
 N2/W1ix4=
X-Gm-Gg: AYBFou0OiJDLPmnJvzRzVnX3XWYbY643LCGSuvtQFstcsoTDa+HWpM6xGZv5G1NawoI
 spk0ZIoXYioJg0OomNaKHwEWYtsU7PQL02aHXtBBKpRhnOZV0Ds+KjJbGlrJPUaEvtJogZHzN+j
 jHkgCEQzP+R3/9k5CHViT/nXcTFQFndpXQwu3CVuc2sdAtAX3RcaeyTk7aNfWIZyXWLFfojMpKu
 nQJYPIcE0t5PR5qYzOlgH5loHs/lUdeFMedMdxtRkX7yNWo+zyhVvHSLjFc4L2jdZRKUCHMWFV+
 Xw77yaJ7dCHIE3n0rmUIYLEqjQh+OHVlrL43tdm3r5yqEYGz/pwoHniBUCps6yUoW4k4/gmgU7v
 5gCRun5LnEOXTHgiLUXiUG3yG3fQEmQp7ccnBsHBCgpvZgsHl+z07jvnLMbcVruoxQimvxkTPDN
 DB8BFjBet5E4selSl6jzce3KbKwSpEoBjCPspHRMvSCtMTTC6ggyFURg4A9KMfvv0q9S4wwvrJK
 I57MpmuN3aeZgZ6F5a/UczdcRP60sbN4Up1EQ==
X-Received: by 2002:a05:6a20:6f87:b0:3dd:a197:cf2c with SMTP id
 adf61e73a8af0-3de0e942b83mr17275335637.80.1790699905824; 
 Tue, 29 Sep 2026 09:38:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 20/61] net/bonding: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:23 -0700
Message-ID: <20260929163800.1108305-21-stephen@networkplumber.org>
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

The mode, socket id and time_ms parsers all assign the strtol() result
before checking the end pointer and errno, and the mode parser truncates
into a uint8_t so "mode=257" aliases onto mode 1.

parse_port_id() has the same unchecked pattern, and did not bound the
result before using it, relying on rte_eth_dev_is_valid_port() to catch
out of range values.

The socket id parser cast to int8_t when testing for SOCKET_ID_ANY, so
any value whose low byte is 0xff, such as 255 or -257, was accepted as
SOCKET_ID_ANY.

Drop the stray errno reset in the agg mode parser, which only does
string comparisons.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/eth_bond_private.h  |  8 ---
 drivers/net/bonding/rte_eth_bond_args.c | 71 ++++---------------------
 drivers/net/bonding/rte_eth_bond_pmd.c  |  8 +--
 3 files changed, 14 insertions(+), 73 deletions(-)

diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..9a2fb7167e 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -298,10 +298,6 @@ int
 bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args);
 
-int
-bond_ethdev_parse_socket_id_kvarg(const char *key,
-		const char *value, void *extra_args);
-
 int
 bond_ethdev_parse_primary_member_port_id_kvarg(const char *key,
 		const char *value, void *extra_args);
@@ -314,10 +310,6 @@ int
 bond_ethdev_parse_bond_mac_addr_kvarg(const char *key,
 		const char *value, void *extra_args);
 
-int
-bond_ethdev_parse_time_ms_kvarg(const char *key,
-		const char *value, void *extra_args);
-
 void
 bond_tlb_disable(struct bond_dev_private *internals);
 
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index 823ed80f07..25602b3b47 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -91,13 +91,13 @@ parse_port_id(const char *port_str)
 		/* try parsing as device name, virtual devices */
 		port_id = find_port_id_by_dev_name(port_str);
 		if (port_id < 0) {
-			char *end;
-			errno = 0;
+			uint64_t val;
 
 			/* try parsing as port id */
-			port_id = strtol(port_str, &end, 10);
-			if (*end != 0 || errno != 0)
+			if (rte_kvargs_to_uint(port_str, 0, RTE_MAX_ETHPORTS - 1, &val) < 0)
 				return -1;
+
+			port_id = val;
 		}
 	}
 
@@ -136,19 +136,17 @@ int
 bond_ethdev_parse_member_mode_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	uint8_t *mode;
-	char *endptr;
+	uint8_t *mode = extra_args;
+	uint64_t val;
 
-	if (value == NULL || extra_args == NULL)
+	if (extra_args == NULL)
 		return -1;
 
-	mode = extra_args;
-
-	errno = 0;
-	*mode = strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
+	if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0)
 		return -1;
 
+	*mode = val;
+
 	/* validate mode value */
 	switch (*mode) {
 	case BONDING_MODE_ROUND_ROBIN:
@@ -176,7 +174,6 @@ bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 
 	agg_mode = extra_args;
 
-	errno = 0;
 	if (strncmp(value, "stable", 6) == 0)
 		*agg_mode = AGG_STABLE;
 
@@ -197,35 +194,6 @@ bond_ethdev_parse_member_agg_mode_kvarg(const char *key __rte_unused,
 	}
 }
 
-int
-bond_ethdev_parse_socket_id_kvarg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	long socket_id;
-	char *endptr;
-
-	if (value == NULL || extra_args == NULL)
-		return -1;
-
-	errno = 0;
-	socket_id = strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
-		return -1;
-
-	/* SOCKET_ID_ANY also consider a valid socket id */
-	if ((int8_t)socket_id == SOCKET_ID_ANY) {
-		*(int *)extra_args = SOCKET_ID_ANY;
-		return 0;
-	}
-
-	/* validate socket id value */
-	if (socket_id >= 0 && socket_id < RTE_MAX_NUMA_NODES) {
-		*(int *)extra_args = (int)socket_id;
-		return 0;
-	}
-	return -1;
-}
-
 int
 bond_ethdev_parse_primary_member_port_id_kvarg(const char *key __rte_unused,
 		const char *value, void *extra_args)
@@ -278,22 +246,3 @@ bond_ethdev_parse_bond_mac_addr_kvarg(const char *key __rte_unused,
 	return rte_ether_unformat_addr(value, extra_args);
 }
 
-int
-bond_ethdev_parse_time_ms_kvarg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	uint32_t time_ms;
-	char *endptr;
-
-	if (value == NULL || extra_args == NULL)
-		return -1;
-
-	errno = 0;
-	time_ms = (uint32_t)strtol(value, &endptr, 10);
-	if (*endptr != 0 || errno != 0)
-		return -1;
-
-	*(uint32_t *)extra_args = time_ms;
-
-	return 0;
-}
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..766dfd9459 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3869,7 +3869,7 @@ bond_probe(struct rte_vdev_device *dev)
 	arg_count = rte_kvargs_count(kvlist, PMD_BOND_SOCKET_ID_KVARG);
 	if (arg_count == 1) {
 		if (rte_kvargs_process(kvlist, PMD_BOND_SOCKET_ID_KVARG,
-				&bond_ethdev_parse_socket_id_kvarg, &socket_id)
+				rte_kvargs_handle_socket_id, &socket_id)
 				!= 0) {
 			RTE_BOND_LOG(ERR, "Invalid socket Id specified for "
 					"bonding device %s", name);
@@ -4207,7 +4207,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LSC_POLL_PERIOD_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &lsc_poll_interval_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid lsc polling interval value specified for bonding"
@@ -4236,7 +4236,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LINK_UP_PROP_DELAY_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &link_up_delay_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid link up propagation delay value specified for"
@@ -4266,7 +4266,7 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 
 		if (rte_kvargs_process(kvlist,
 				       PMD_BOND_LINK_DOWN_PROP_DELAY_KVARG,
-				       &bond_ethdev_parse_time_ms_kvarg,
+				       rte_kvargs_handle_u32,
 				       &link_down_delay_ms) < 0) {
 			RTE_BOND_LOG(INFO,
 				     "Invalid link down propagation delay value specified for"
-- 
2.53.0

