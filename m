Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E01CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D06240A4B;
	Fri,  5 Jun 2026 22:53:10 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 67C1E4066C
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:08 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8ce3876a50cso22978766d6.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692788;
 x=1781297588; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5raan3IR4GZt3jZxhOTeylA5OKZTB4G9nN29Fp+lK0=;
 b=xJ97scEW/m97C4Uq0paQTelWoFsB+lMBZp4biEAmn880gn126Fy8RVOQTyX2FKt9GT
 sJb79OIPLhCu99q8AvMOhipw8JIzaMvBcW4Fi5usT8wF2MqEYIufafehLLdXAYf+KouG
 GHcCF7vcTgVneNyBOTMq8VVK4RgrXKCsTezZFb4igM3aKyeplzeWO++DuJ5H+e26GRUX
 C0tjD+uSVMUvUPUtxXpr4YXhiWSEHwaOrpoyn/9hY+hZ1rNvPoTpfwVgAu+w8lsUkduA
 pLG7JPvJvZW1fNS1GtD5snzq9A9FgWYtaz/PStuCr2W4/QzkkVo5tIiZUf+HEke+7Duj
 zz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692788; x=1781297588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5raan3IR4GZt3jZxhOTeylA5OKZTB4G9nN29Fp+lK0=;
 b=KELDa0PItIXhrcuW0vqRsO6puoksL6TwJuYBPUKPnXMmpGSBgVAxNLQmkldtfGTvDt
 DhH12d/icXnLSoEwf8I7f4QYWVyu4jJ21ox1R+tHB2WXK+53Ofm329XtdEN6gwZpzuuv
 175QAAqziPRxNnLj8x5yuzFCZn+PZ29zRUcliiQmwmseti/9pmKqFt7tF4Dpaa39asXX
 bH+4+bIn3VC46htigN5r2HztiupDMX+lShYeKehK7nywv2oEDRuN8FQ/ITWMFfPiQ0Ta
 1py7d1moipGgKLhluNDHCRf3yVbj4hU3Kq1X2J046d4Sx1qpmnxqvmPnLJEgqQehNB3k
 p9cA==
X-Gm-Message-State: AOJu0YymjnxmWmLKqP4a4bh/3KlOLA2yxtGUJLHZAOwM8MlDZfKwUwkQ
 E2F3QQ141jqrkgXearpaTmrkGt311E1CFvrIMGqhxAN8EPxUgqTrIRr2Jd3mvcjPAbvppjCVvlj
 XBkb/
X-Gm-Gg: Acq92OEOLmP7XP35+mFyJmDuE/uTJamdohWxD7mTwpF0QI1xHjE66EsFSq+J7ztWhlg
 DKwJ9ODRhJARmgAM84yIIKqwSiGBF51Ba3ZsQ0kzh2BtwgV8VA2qexiy5++pprGJmag5RkZ6C+U
 430+3H51amCsBXWQhRmqllI/6nfKpQKOIC8dkneez18fmtU02xvOVLVZOYvEbx6GoGVUX6MQ5CS
 FXl66gaeDWvyIhnQL0S+rLcCQ8yw1H9AhujMR5TiX3E6qQ5V1ybrUsCtyXHykK7TTcuRZBLxwrJ
 QXGlkLONOTBY70MieeCl9tyIsSO+a1jJ0VPGXk7rZ/ZvdbmNSaRDk2nfh/zy5onfV5tlEHtGk0t
 FxMe1UzB16K+vlARIIrzkEjIfui9h1VMGGYKoIYDbvZNjBmYxebQcM3U25vdi0XtQBt3Jniaxve
 p6T8M4PZHdgLAqFuJoXE3/2OLyUxxJP08F6HH02awTU2TTovJJS860xI8EDv4ZfTqjpIFZSm8s
X-Received: by 2002:ad4:51d1:0:b0:8c6:2245:3ee1 with SMTP id
 6a1803df08f44-8cee600dfbemr75045256d6.18.1780692787749; 
 Fri, 05 Jun 2026 13:53:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Ganapati Kundapura <ganapati.kundapura@intel.com>,
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
Subject: [PATCH 7/8] eventdev/eth_rx: reject out-of-range telemetry adapter ID
Date: Fri,  5 Jun 2026 13:51:04 -0700
Message-ID: <20260605205253.520196-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

The eventdev rx adapter code was using atoi() to parse numeric
parameters which does not handle out-of-range or extra garbage
on input. Tighten the code to only accept valid numbers.

Fixes: 814d01709328 ("eventdev/eth_rx: support telemetry")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_eth_rx_adapter.c | 45 +++++++++++--------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 96a4a0d926..635bd6014b 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -270,8 +270,8 @@ rxa_timestamp_dynfield(struct rte_mbuf *mbuf)
 		event_eth_rx_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
 }
 
-static inline int
-rxa_validate_id(uint8_t id)
+static inline bool
+rxa_validate_id(unsigned long id)
 {
 	return id < RTE_EVENT_ETH_RX_ADAPTER_MAX_INSTANCE;
 }
@@ -294,14 +294,14 @@ rxa_event_buf_get(struct event_eth_rx_adapter *rx_adapter, uint16_t eth_dev_id,
 
 #define RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(id, retval) do { \
 	if (!rxa_validate_id(id)) { \
-		RTE_EDEV_LOG_ERR("Invalid eth Rx adapter id = %d", id); \
+		RTE_EDEV_LOG_ERR("Invalid eth Rx adapter id = %lu", (unsigned long)id); \
 		return retval; \
 	} \
 } while (0)
 
 #define RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_GOTO_ERR_RET(id, retval) do { \
 	if (!rxa_validate_id(id)) { \
-		RTE_EDEV_LOG_ERR("Invalid eth Rx adapter id = %d", id); \
+		RTE_EDEV_LOG_ERR("Invalid eth Rx adapter id = %lu", (unsigned long)id); \
 		ret = retval; \
 		goto error; \
 	} \
@@ -316,8 +316,8 @@ rxa_event_buf_get(struct event_eth_rx_adapter *rx_adapter, uint16_t eth_dev_id,
 } while (0)
 
 #define RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET(port_id, retval) do { \
-	if (!rte_eth_dev_is_valid_port(port_id)) { \
-		RTE_EDEV_LOG_ERR("Invalid port_id=%u", port_id); \
+	if (port_id >= RTE_MAX_ETHPORTS || !rte_eth_dev_is_valid_port(port_id)) { \
+		RTE_EDEV_LOG_ERR("Invalid port_id=%lu", (unsigned long)port_id); \
 		ret = retval; \
 		goto error; \
 	} \
@@ -3761,14 +3761,14 @@ handle_rxa_stats(const char *cmd __rte_unused,
 		 const char *params,
 		 struct rte_tel_data *d)
 {
-	uint8_t rx_adapter_id;
+	unsigned long rx_adapter_id;
 	struct rte_event_eth_rx_adapter_stats rx_adptr_stats;
 
 	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
-	rx_adapter_id = atoi(params);
+	rx_adapter_id = strtoul(params, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(rx_adapter_id, -EINVAL);
 
 	/* Get Rx adapter stats */
@@ -3802,13 +3802,13 @@ handle_rxa_stats_reset(const char *cmd __rte_unused,
 		       const char *params,
 		       struct rte_tel_data *d __rte_unused)
 {
-	uint8_t rx_adapter_id;
+	unsigned long rx_adapter_id;
 
 	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
-	rx_adapter_id = atoi(params);
+	rx_adapter_id = strtoul(params, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(rx_adapter_id, -EINVAL);
 
 	/* Reset Rx adapter stats */
@@ -3825,9 +3825,7 @@ handle_rxa_get_queue_conf(const char *cmd __rte_unused,
 			  const char *params,
 			  struct rte_tel_data *d)
 {
-	uint8_t rx_adapter_id;
-	uint16_t rx_queue_id;
-	uint16_t eth_dev_id;
+	unsigned long rx_adapter_id, rx_queue_id, eth_dev_id;
 	int ret = -1;
 	char *token, *l_params, *saveptr = NULL;
 	struct rte_event_eth_rx_adapter_queue_conf queue_conf;
@@ -3857,7 +3855,7 @@ handle_rxa_get_queue_conf(const char *cmd __rte_unused,
 	/* Get Rx queue ID from parameter string */
 	rx_queue_id = strtoul(token, NULL, 10);
 	if (rx_queue_id >= rte_eth_devices[eth_dev_id].data->nb_rx_queues) {
-		RTE_EDEV_LOG_ERR("Invalid rx queue_id %u", rx_queue_id);
+		RTE_EDEV_LOG_ERR("Invalid rx queue_id %lu", rx_queue_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -3898,9 +3896,7 @@ handle_rxa_get_queue_stats(const char *cmd __rte_unused,
 			   const char *params,
 			   struct rte_tel_data *d)
 {
-	uint8_t rx_adapter_id;
-	uint16_t rx_queue_id;
-	uint16_t eth_dev_id;
+	unsigned long rx_adapter_id, rx_queue_id, eth_dev_id;
 	int ret = -1;
 	char *token, *l_params, *saveptr = NULL;
 	struct rte_event_eth_rx_adapter_queue_stats q_stats;
@@ -3930,7 +3926,7 @@ handle_rxa_get_queue_stats(const char *cmd __rte_unused,
 	/* Get Rx queue ID from parameter string */
 	rx_queue_id = strtoul(token, NULL, 10);
 	if (rx_queue_id >= rte_eth_devices[eth_dev_id].data->nb_rx_queues) {
-		RTE_EDEV_LOG_ERR("Invalid rx queue_id %u", rx_queue_id);
+		RTE_EDEV_LOG_ERR("Invalid rx queue_id %lu", rx_queue_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -3970,9 +3966,7 @@ handle_rxa_queue_stats_reset(const char *cmd __rte_unused,
 			     const char *params,
 			     struct rte_tel_data *d __rte_unused)
 {
-	uint8_t rx_adapter_id;
-	uint16_t rx_queue_id;
-	uint16_t eth_dev_id;
+	unsigned long rx_adapter_id, rx_queue_id, eth_dev_id;
 	int ret = -1;
 	char *token, *l_params, *saveptr = NULL;
 
@@ -4001,7 +3995,7 @@ handle_rxa_queue_stats_reset(const char *cmd __rte_unused,
 	/* Get Rx queue ID from parameter string */
 	rx_queue_id = strtoul(token, NULL, 10);
 	if (rx_queue_id >= rte_eth_devices[eth_dev_id].data->nb_rx_queues) {
-		RTE_EDEV_LOG_ERR("Invalid rx queue_id %u", rx_queue_id);
+		RTE_EDEV_LOG_ERR("Invalid rx queue_id %lu", rx_queue_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -4033,8 +4027,7 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 			struct rte_tel_data *d)
 {
 	uint8_t instance_id;
-	uint16_t rx_queue_id;
-	uint16_t eth_dev_id;
+	unsigned long rx_queue_id, eth_dev_id;
 	int ret = -1;
 	char *token, *l_params, *saveptr = NULL;
 
@@ -4057,7 +4050,7 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 	/* Get Rx queue ID from parameter string */
 	rx_queue_id = strtoul(token, NULL, 10);
 	if (rx_queue_id >= rte_eth_devices[eth_dev_id].data->nb_rx_queues) {
-		RTE_EDEV_LOG_ERR("Invalid rx queue_id %u", rx_queue_id);
+		RTE_EDEV_LOG_ERR("Invalid rx queue_id %lu", rx_queue_id);
 		ret = -EINVAL;
 		goto error;
 	}
@@ -4074,7 +4067,7 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 						  rx_queue_id,
 						  &instance_id)) {
 		RTE_EDEV_LOG_ERR("Failed to get RX adapter instance ID "
-				 " for rx_queue_id = %d", rx_queue_id);
+				 " for rx_queue_id = %lu", rx_queue_id);
 		return -1;
 	}
 
-- 
2.53.0

