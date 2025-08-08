Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7630140678;
	Fri,  8 Aug 2025 18:58:52 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 67BD640676
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:51 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-459e1338565so22000935e9.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672331;
 x=1755277131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrB/CHJPwLlOJqS4wqEVDyyiaCZCeQR5x1ozZcXaj60=;
 b=3d31dqLeDaKRGqIP/QSuEBD1Qw+1Q0D3hZR2naCR2s9DOywTpT7vcm8R9e0hIIEG7y
 OYaG7nzSarWFW0Id2uR6oL241i2tLNxDDpTqQfibzCXuJQX378LOz4EC8R73Fp3rhNQk
 Gfc+Ge8UHwVl06y28XvpulDFWGQ+23Rx9eY6RENQOZ3z1Ml+rUYWmbDleYuHO7zy17R2
 5Wx9CrEVPl5yfqbMyjd937jRo7c0MgQJhKQhTWQ1fnZhd3KocK9/DXM6vUNudt6cG1jW
 ZXkJcvUcIY34qnXKn8UFwRD7abHvhc9+T0KIft2/x4Sz0drIqClG7Q+qQAC9u/6+XTV1
 VHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672331; x=1755277131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrB/CHJPwLlOJqS4wqEVDyyiaCZCeQR5x1ozZcXaj60=;
 b=iJMPnkREXeDZXNePcV1DFBgYqm6MNZJDtlmomXoUu0hfIk6bw5F+rTcmK/qL72GIgc
 kmAUqkhXXY8unfaQHNi6cZtmQEFnztDqz87Y463BkVUkv9S6pbcxEZnqKLC1K1UlUNgz
 7ZL3SyWHSY3Ar6SwRlAeRTcKTw633Z6RCu0N/VwTGa+EwQW9eIyxrm4M+6MRF+uBdDEF
 IzYvLuXoQkyvyduPhvVlslnACOyumvej7OMBIUIYCNoJV7RelqEQt2egO/amboFZfPTw
 SeNnW47iZf3D235rQDcLxJeYfCd7zCaNqX6MNSmzRcG2fV+7A+hKjbq4zyjVVC7VucE/
 BspA==
X-Gm-Message-State: AOJu0Yw4nDAwio0Bkwk/bHY/ROmI4FgRAsr6A46B9T7oztPZgS8uMsUr
 KDJnz1rAVzTKHQwC7dSalnJCFkUmSxKmMhmpfbJndfXvt8Fxhzm5x6++iUp61Thcj1WbVV4xih0
 aphGl
X-Gm-Gg: ASbGnctqk0doEIU7r2xKdzujCQ3picMpK77gbgl3OkhfNRRBwkgEPuBRo1KJnbgs3Pk
 aM7S+u2taDK1dhsWXZKAFE7bGw1q3iehFbsHxTkmjZ6H9PbOPPiBfhspeuJdnYFigXnWGHllG87
 zv81HsBcBeMHouXwxpUkHXnp3+DD0txAqb83i27Gpy+/hgF0Vyyp/iMHAghvv5hn1Fy9svu0NjU
 0+5WkxqvjFUSCnHl8FIcA05s7xAOGU49KueTo8g13IEKzrRj9AHpDU5f2+uJkMq4TwbwCJggD7l
 JF2PfSKcPm0kmzzwpbOQX3PWKEDGSpWy7ho7Kk2w7AzP2aITUN0yDHq9acZiM4YlTlFUJXs+ef4
 tBZhYPhvt+E/tAhFLWulHyGSMLwmg/ifMTxqSsTYSk5O/f6f/7hKYuf3GQNt0CoA/hshnYu52
X-Google-Smtp-Source: AGHT+IFmFWfqBBw+vqSM0186IaSgX2doAougZqBut54BhDFEONl33e9LszH7aouvGZLwGGUCLARKvQ==
X-Received: by 2002:a05:600c:190b:b0:458:bf0a:6061 with SMTP id
 5b1f17b1804b1-459f4f1425emr31986455e9.24.1754672330967; 
 Fri, 08 Aug 2025 09:58:50 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v11 01/14] ethdev: allow start/stop from secondary process
Date: Fri,  8 Aug 2025 09:55:39 -0700
Message-ID: <20250808165843.39075-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Before this patch if secondary process called start/stop
it would only impact the secondary process, the ethdev on the
primary process was not started.

With this patch, when start/stop is called from secondary,
it calls the primary and does the operation there. The design
is generic, and we can later add queue and other operations
as needed.

Bugzilla ID: 73

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c  | 12 ++++-
 lib/ethdev/ethdev_private.c | 92 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_private.h | 26 +++++++++++
 lib/ethdev/rte_ethdev.c     | 82 +++++++++++++++++++--------------
 4 files changed, 176 insertions(+), 36 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..eac34d7508 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -114,6 +114,15 @@ rte_eth_dev_allocate(const char *name)
 		goto unlock;
 	}
 
+	/* When first port is created, start the multi-process request handler */
+	if (eth_dev_shared_data->allocated_ports == 0 &&
+	    rte_mp_action_register(ETHDEV_MP, ethdev_server) &&
+	    rte_errno != ENOTSUP) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			 "Could not start %s service", ETHDEV_MP);
+		goto unlock;
+	}
+
 	eth_dev = eth_dev_get(port_id);
 	eth_dev->flow_fp_ops = &rte_flow_fp_default_ops;
 	strlcpy(eth_dev->data->name, name, sizeof(eth_dev->data->name));
@@ -282,7 +291,8 @@ rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 		memset(eth_dev->data, 0, sizeof(struct rte_eth_dev_data));
 		eth_dev->data = NULL;
 
-		eth_dev_shared_data->allocated_ports--;
+		if (--eth_dev_shared_data->allocated_ports == 0)
+			rte_mp_action_unregister(ETHDEV_MP);
 		eth_dev_shared_data_release();
 	}
 
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 285d377d91..1d423290f1 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2018 Gaëtan Rivet
  */
 
+#include <assert.h>
+
 #include <eal_export.h>
 #include <rte_debug.h>
 
@@ -477,3 +479,93 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
 	dev->data->nb_tx_queues = nb_queues;
 	return 0;
 }
+
+static int
+ethdev_handle_request(const struct ethdev_mp_request *req)
+{
+	switch (req->operation) {
+	case ETH_REQ_START:
+		return rte_eth_dev_start(req->port_id);
+
+	case ETH_REQ_STOP:
+		return rte_eth_dev_stop(req->port_id);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static_assert(sizeof(struct ethdev_mp_request) <= RTE_MP_MAX_PARAM_LEN,
+	"ethdev MP request bigger than available param space");
+
+static_assert(sizeof(struct ethdev_mp_response) <= RTE_MP_MAX_PARAM_LEN,
+	"ethdev MP response bigger than available param space");
+
+int
+ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	const struct ethdev_mp_request *req
+		= (const struct ethdev_mp_request *)mp_msg->param;
+
+	struct rte_mp_msg mp_resp = {
+		.name = ETHDEV_MP,
+	};
+	struct ethdev_mp_response *resp;
+
+	resp = (struct ethdev_mp_response *)mp_resp.param;
+	mp_resp.len_param = sizeof(*resp);
+	resp->res_op = req->operation;
+
+	/* recv client requests */
+	if (mp_msg->len_param != sizeof(*req))
+		resp->err_value = -EINVAL;
+	else
+		resp->err_value = ethdev_handle_request(req);
+
+	return rte_mp_reply(&mp_resp, peer);
+}
+
+int
+ethdev_request(uint16_t port_id, enum ethdev_mp_operation operation,
+	       const void *buf, size_t buf_len)
+{
+	struct rte_mp_msg mp_req = { };
+	struct rte_mp_reply mp_reply;
+	struct ethdev_mp_request *req;
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	int ret;
+
+	if (sizeof(*req) + buf_len > RTE_MP_MAX_PARAM_LEN) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+				    "request %u port %u invalid len %zu",
+				    operation, port_id, buf_len);
+		return -EINVAL;
+	}
+
+	strlcpy(mp_req.name, ETHDEV_MP, RTE_MP_MAX_NAME_LEN);
+	mp_req.len_param = sizeof(*req) + buf_len;
+
+	req = (struct ethdev_mp_request *)mp_req.param;
+	req->operation = operation;
+	req->port_id = port_id;
+
+	if (buf_len > 0)
+		memcpy(req->config, buf, buf_len);
+
+	ret = rte_mp_request_sync(&mp_req, &mp_reply, &ts);
+	if (ret == 0) {
+		const struct rte_mp_msg *mp_rep = &mp_reply.msgs[0];
+		const struct ethdev_mp_response *resp
+			= (const struct ethdev_mp_response *)mp_rep->param;
+
+		if (resp->err_value != 0)
+			rte_errno = -resp->err_value;
+		free(mp_reply.msgs);
+	} else {
+		RTE_ETHDEV_LOG_LINE(ERR,
+		       "ethdev request for port %up operation %u failed: %d",
+				    port_id, operation, ret);
+	}
+
+	return ret;
+}
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index b07b1b4c42..f58f161871 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -79,4 +79,30 @@ void eth_dev_txq_release(struct rte_eth_dev *dev, uint16_t qid);
 int eth_dev_rx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 
+/* Used to allow start/stop from secondary */
+#define ETHDEV_MP	"mp_ethdev"
+
+enum ethdev_mp_operation {
+	ETH_REQ_START,
+	ETH_REQ_STOP,
+};
+
+struct ethdev_mp_request {
+	uint16_t operation;
+	uint16_t port_id;
+	uint32_t reserved;
+
+	uint8_t config[]; /* operation specific */
+};
+
+struct ethdev_mp_response {
+	uint16_t res_op;
+	uint16_t port_id;
+	int32_t err_value;
+};
+
+int ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer);
+int ethdev_request(uint16_t port_id, enum ethdev_mp_operation op,
+		   const void *buf, size_t buf_len);
+
 #endif /* _ETH_PRIVATE_H_ */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..adeec575be 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1787,10 +1787,8 @@ int
 rte_eth_dev_start(uint16_t port_id)
 {
 	struct rte_eth_dev *dev;
-	struct rte_eth_dev_info dev_info;
 	uint64_t restore_flags;
-	int diag;
-	int ret, ret_stop;
+	int ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 	dev = &rte_eth_devices[port_id];
@@ -1812,42 +1810,51 @@ rte_eth_dev_start(uint16_t port_id)
 		return 0;
 	}
 
-	ret = rte_eth_dev_info_get(port_id, &dev_info);
-	if (ret != 0)
-		return ret;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		struct rte_eth_dev_info dev_info;
+
+		ret = rte_eth_dev_info_get(port_id, &dev_info);
+		if (ret != 0)
+			return ret;
 
-	restore_flags = rte_eth_get_restore_flags(dev, RTE_ETH_START);
+		restore_flags = rte_eth_get_restore_flags(dev, RTE_ETH_START);
 
-	/* Lets restore MAC now if device does not support live change */
-	if ((*dev_info.dev_flags & RTE_ETH_DEV_NOLIVE_MAC_ADDR) &&
-	    (restore_flags & RTE_ETH_RESTORE_MAC_ADDR))
-		eth_dev_mac_restore(dev, &dev_info);
+		/* Restore MAC now if device does not support live change */
+		if ((*dev_info.dev_flags & RTE_ETH_DEV_NOLIVE_MAC_ADDR) &&
+		    (restore_flags & RTE_ETH_RESTORE_MAC_ADDR))
+			eth_dev_mac_restore(dev, &dev_info);
 
-	diag = dev->dev_ops->dev_start(dev);
-	if (diag == 0)
-		dev->data->dev_started = 1;
-	else
-		return eth_err(port_id, diag);
+		int diag = dev->dev_ops->dev_start(dev);
+		if (diag == 0)
+			dev->data->dev_started = 1;
+		else
+			return eth_err(port_id, diag);
 
-	ret = eth_dev_config_restore(dev, &dev_info, restore_flags, port_id);
-	if (ret != 0) {
-		RTE_ETHDEV_LOG_LINE(ERR,
-			"Error during restoring configuration for device (port %u): %s",
-			port_id, rte_strerror(-ret));
-		ret_stop = rte_eth_dev_stop(port_id);
-		if (ret_stop != 0) {
+		ret = eth_dev_config_restore(dev, &dev_info, restore_flags, port_id);
+		if (ret != 0) {
 			RTE_ETHDEV_LOG_LINE(ERR,
-				"Failed to stop device (port %u): %s",
-				port_id, rte_strerror(-ret_stop));
-		}
+				"Error during restoring configuration for device (port %u): %s",
+				 port_id, rte_strerror(-ret));
+			int ret_stop = rte_eth_dev_stop(port_id);
+			if (ret_stop != 0) {
+				RTE_ETHDEV_LOG_LINE(ERR,
+					"Failed to stop device (port %u): %s",
+					 port_id, rte_strerror(-ret_stop));
+			}
 
-		return ret;
-	}
+			return ret;
+		}
 
-	if (dev->data->dev_conf.intr_conf.lsc == 0) {
-		if (dev->dev_ops->link_update == NULL)
-			return -ENOTSUP;
-		dev->dev_ops->link_update(dev, 0);
+		if (dev->data->dev_conf.intr_conf.lsc == 0) {
+			if (dev->dev_ops->link_update == NULL)
+				return -ENOTSUP;
+			dev->dev_ops->link_update(dev, 0);
+		}
+	} else {
+		/* in secondary, proxy to primary */
+		ret = ethdev_request(port_id, ETH_REQ_START, NULL, 0);
+		if (ret != 0)
+			return ret;
 	}
 
 	/* expose selection of PMD fast-path functions */
@@ -1880,9 +1887,14 @@ rte_eth_dev_stop(uint16_t port_id)
 	/* point fast-path functions to dummy ones */
 	eth_dev_fp_ops_reset(rte_eth_fp_ops + port_id);
 
-	ret = dev->dev_ops->dev_stop(dev);
-	if (ret == 0)
-		dev->data->dev_started = 0;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = dev->dev_ops->dev_stop(dev);
+		if (ret == 0)
+			dev->data->dev_started = 0;
+	} else {
+		ret = ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
+	}
+
 	rte_ethdev_trace_stop(port_id, ret);
 
 	return ret;
-- 
2.47.2

