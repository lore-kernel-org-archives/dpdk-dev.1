Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C4CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 250E3406B8;
	Fri,  5 Jun 2026 22:53:09 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 193DD40698
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:07 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8ccf6a63a45so28322256d6.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692786;
 x=1781297586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE9R6rQTKl0XD+UnYbX8shgxtI1skfkfaL6lYYyJlHk=;
 b=V3WSZS7ZxdYSeEyuJ88olo0W6ChbyM6mSDXfGFfSKtvELBFDm9v2VndcF8buXbbb55
 hy0c0Cyb80jobuvxuzOwdYTzfUatnOQ9YA9GdneJ63lKWHbjkw8a4fRvs2IW/3JdyT9e
 8C7XW3m1Blcp/ct3BPmLmOd3mRKPfjg/eGP0a5vUW2qlKsv5w7mxCFUmgupe11Mr663q
 4wQeRF7fzuC7mnEEQ0/gcJgiRr3f7MTFtCC+ZmZOR7DS1NQxEsZ4y4r1lJIds/Q/8784
 EywHI/kmX+D5EMx6yL+lI9r5cE/gP5APDgxVI4AhmlAAwxFFAWZjhHggFpldPljwTSpR
 tn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692786; x=1781297586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LE9R6rQTKl0XD+UnYbX8shgxtI1skfkfaL6lYYyJlHk=;
 b=IgYyXE3mVclwxNTAu1IrAHhuk5wF5OdSiSO67ZYhPPLHscuo95k+q10Ny4ErjI9umR
 wsw7MND4eRCte4RYLPEYzJnvxC5eakfkiE+l4VsJ9pH7dXxrNN5FE5xukSivImljyWuL
 cZos0r2Vy4EuNYe4CpAoY5KsOSUhNXYulGEym8SpKZbkRxgF9dG38whKHKHyzhOIUMk3
 HNvWoKsGbRW8AP2sMRiXbmMWKiFkPgrf2xvWWaNb6tHPmD70CJi4YluNSnvhuM0sSgL4
 A5RUmozcRADfNCrsGimTJqffD9z8JmJ16voAL5US7JQ03sYsbXbVz71mVzRa2ad+ziJC
 zBqw==
X-Gm-Message-State: AOJu0YyuVgAZiaxuqL5aJ9xhd0ox+BxSvXVRyb75kmW2U1ZHsBC/vaWp
 NQ2Rbn2iFHWNlqe1nwBgtXi199bmwCKcAN+NyHg4jHw730agK+Ot32tRSLZdoYYSrGfyxkkUE2P
 8GqTX
X-Gm-Gg: Acq92OFsXMrzaKDyaV8DgZxpmwyh0rbjK7gORI1ufzf/Xa2Va0FN7tFDgQvpJb3oa7W
 L46H7QHQrqSF1qVa4l3Erb1DRoCCr6QBPEjk+RLwPWNX0adD8BuDnWqg/gfdHs2RbPWn5O6LGY3
 OTZ9RDJPOUHC9vJyGyM9UryLBrpf9Us7QdAD6hBaJPQv7TEow7/G7zfFgn1cCbXynxAKELOhskr
 woSqK/bJmvbmtpgagFvtoYdPVKNtVoADA5BTMrSoZ6LoppvQL12vjran2I5GZz2KZa1VLTsvE3W
 K1wgrZpC/SHNFCkWJP2rUPlcbhRCJAuvWgNqjdp5rDyT1w30juR1fITP7cnDyivEaQpeVDu4vBx
 OqwCAqac+bGDBt8lRUUeXMBnXWJrvYIAPZRZDrC7Xrn6V/dFn/kvEg73OhRgIzQJslaYO4vtgQv
 s1BO9JexKqQSrF1f92LXWhp0h8x+K9UMeNQ8HN2nEHbBaEYv15F0db0OuUgEr73l9xFJoBvE2a
X-Received: by 2002:a0c:fd87:0:b0:8ae:60c4:857 with SMTP id
 6a1803df08f44-8cee6023aaamr69368456d6.18.1780692786285; 
 Fri, 05 Jun 2026 13:53:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Ganapati Kundapura <ganapati.kundapura@intel.com>,
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
Subject: [PATCH 6/8] eventdev/eth_rx: fix thread-unsafe telemetry parsing
Date: Fri,  5 Jun 2026 13:51:03 -0700
Message-ID: <20260605205253.520196-7-stephen@networkplumber.org>
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

The eth Rx adapter telemetry handlers parse multi-field parameter
strings with a strtok()/strtok(NULL, ...) continuation chain.
Since strtok() holds its parser state in a process-global static,
and telemetry callbacks run in a separate thread per client connection.
With concurrent clients the continuation calls read another thread's
state - and since each handler strdup()s and frees its own buffer,
a stale continuation can dereference freed memory.
Thread the parse through a local save pointer with strtok_r().

Also passing was passing a char to isdigit(), which is undefined
in C standard for high-bit input.

Fixes: 814d01709328 ("eventdev/eth_rx: support telemetry")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_eth_rx_adapter.c | 52 ++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 2183adce6f..96a4a0d926 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -308,7 +308,7 @@ rxa_event_buf_get(struct event_eth_rx_adapter *rx_adapter, uint16_t eth_dev_id,
 } while (0)
 
 #define RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, retval) do { \
-	if ((token) == NULL || strlen(token) == 0 || !isdigit(*token)) { \
+	if ((token) == NULL || strlen(token) == 0 || !isdigit((unsigned char)*token)) { \
 		RTE_EDEV_LOG_ERR("Invalid eth Rx adapter token"); \
 		ret = retval; \
 		goto error; \
@@ -3764,7 +3764,7 @@ handle_rxa_stats(const char *cmd __rte_unused,
 	uint8_t rx_adapter_id;
 	struct rte_event_eth_rx_adapter_stats rx_adptr_stats;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
@@ -3804,7 +3804,7 @@ handle_rxa_stats_reset(const char *cmd __rte_unused,
 {
 	uint8_t rx_adapter_id;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
@@ -3829,29 +3829,29 @@ handle_rxa_get_queue_conf(const char *cmd __rte_unused,
 	uint16_t rx_queue_id;
 	uint16_t eth_dev_id;
 	int ret = -1;
-	char *token, *l_params;
+	char *token, *l_params, *saveptr = NULL;
 	struct rte_event_eth_rx_adapter_queue_conf queue_conf;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
 	l_params = strdup(params);
 	if (l_params == NULL)
 		return -ENOMEM;
-	token = strtok(l_params, ",");
+	token = strtok_r(l_params, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 	rx_adapter_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_GOTO_ERR_RET(rx_adapter_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get device ID from parameter string */
 	eth_dev_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET(eth_dev_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get Rx queue ID from parameter string */
@@ -3862,7 +3862,7 @@ handle_rxa_get_queue_conf(const char *cmd __rte_unused,
 		goto error;
 	}
 
-	token = strtok(NULL, "\0");
+	token = strtok_r(NULL, "\0", &saveptr);
 	if (token != NULL)
 		RTE_EDEV_LOG_ERR("Extra parameters passed to eventdev"
 				 " telemetry command, ignoring");
@@ -3902,29 +3902,29 @@ handle_rxa_get_queue_stats(const char *cmd __rte_unused,
 	uint16_t rx_queue_id;
 	uint16_t eth_dev_id;
 	int ret = -1;
-	char *token, *l_params;
+	char *token, *l_params, *saveptr = NULL;
 	struct rte_event_eth_rx_adapter_queue_stats q_stats;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
 	l_params = strdup(params);
 	if (l_params == NULL)
 		return -ENOMEM;
-	token = strtok(l_params, ",");
+	token = strtok_r(l_params, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 	rx_adapter_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_GOTO_ERR_RET(rx_adapter_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get device ID from parameter string */
 	eth_dev_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET(eth_dev_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get Rx queue ID from parameter string */
@@ -3935,7 +3935,7 @@ handle_rxa_get_queue_stats(const char *cmd __rte_unused,
 		goto error;
 	}
 
-	token = strtok(NULL, "\0");
+	token = strtok_r(NULL, "\0", &saveptr);
 	if (token != NULL)
 		RTE_EDEV_LOG_ERR("Extra parameters passed to eventdev"
 				 " telemetry command, ignoring");
@@ -3974,28 +3974,28 @@ handle_rxa_queue_stats_reset(const char *cmd __rte_unused,
 	uint16_t rx_queue_id;
 	uint16_t eth_dev_id;
 	int ret = -1;
-	char *token, *l_params;
+	char *token, *l_params, *saveptr = NULL;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	/* Get Rx adapter ID from parameter string */
 	l_params = strdup(params);
 	if (l_params == NULL)
 		return -ENOMEM;
-	token = strtok(l_params, ",");
+	token = strtok_r(l_params, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 	rx_adapter_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_GOTO_ERR_RET(rx_adapter_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get device ID from parameter string */
 	eth_dev_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET(eth_dev_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get Rx queue ID from parameter string */
@@ -4006,7 +4006,7 @@ handle_rxa_queue_stats_reset(const char *cmd __rte_unused,
 		goto error;
 	}
 
-	token = strtok(NULL, "\0");
+	token = strtok_r(NULL, "\0", &saveptr);
 	if (token != NULL)
 		RTE_EDEV_LOG_ERR("Extra parameters passed to eventdev"
 				 " telemetry command, ignoring");
@@ -4036,22 +4036,22 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 	uint16_t rx_queue_id;
 	uint16_t eth_dev_id;
 	int ret = -1;
-	char *token, *l_params;
+	char *token, *l_params, *saveptr = NULL;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	if (params == NULL || strlen(params) == 0 || !isdigit((unsigned char)*params))
 		return -1;
 
 	l_params = strdup(params);
 	if (l_params == NULL)
 		return -ENOMEM;
-	token = strtok(l_params, ",");
+	token = strtok_r(l_params, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get device ID from parameter string */
 	eth_dev_id = strtoul(token, NULL, 10);
 	RTE_EVENT_ETH_RX_ADAPTER_PORTID_VALID_OR_GOTO_ERR_RET(eth_dev_id, -EINVAL);
 
-	token = strtok(NULL, ",");
+	token = strtok_r(NULL, ",", &saveptr);
 	RTE_EVENT_ETH_RX_ADAPTER_TOKEN_VALID_OR_GOTO_ERR_RET(token, -1);
 
 	/* Get Rx queue ID from parameter string */
@@ -4062,7 +4062,7 @@ handle_rxa_instance_get(const char *cmd __rte_unused,
 		goto error;
 	}
 
-	token = strtok(NULL, "\0");
+	token = strtok_r(NULL, "\0", &saveptr);
 	if (token != NULL)
 		RTE_EDEV_LOG_ERR("Extra parameters passed to eventdev"
 				 " telemetry command, ignoring");
-- 
2.53.0

