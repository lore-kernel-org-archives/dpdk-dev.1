Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924DBC83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCBB40664;
	Thu, 10 Jul 2025 18:42:44 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 46163402D1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:43 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so13105921cf.3
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165762;
 x=1752770562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwal5wMF6fzRUOulrCFKxPXLZIUCadXAAYsGPKswqww=;
 b=bvXx4rgCXgJ2KeBNXocXxGEPr10QTFZsS8U/FEf1N8G6OTUVsGF78XA55Wa7+Ih9dY
 HjCxfkupKUxT8Vi3kam5K8HOZAtWo7mJ9NEwWndBogJPcwjfehOVfJxrA2dkMjVllCWQ
 4re3qdeUyHZOPRpDYST4GH3CmMMmT1z1sNb8rC93GYcSQTH2ySddjmHSKacLNI9500+0
 oSq57cUcid9gvkw9z4hINfS8vHRT4gp2mBTSlE7HbGXDQyyhDK49t7VZ6pxUPVEuwPrW
 NH1m6YVTwq54h9UkGewb02bz/dtUW133RF2WZV1+78eHX6VB+6gg1QBzxOyfuPwcs4Kr
 O/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165762; x=1752770562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwal5wMF6fzRUOulrCFKxPXLZIUCadXAAYsGPKswqww=;
 b=rmTv8kI+4MyOiddfgBYLzT6w/lsQKCoSEDvn2At3/jfJTTbPP0mvONEXlJ/0ZBT66V
 S7bY32BQDvfokRSwmZvTN8fguTuO/dqevCckRuhDoKToVHcMLVSvyPPOcKC66z6OPieN
 kZXngUv6MmKI8NDdxsqoQ/9hh1cj7FWstA92w0G3j3BiYUyt2mMxI+v/05Ww2nmAerM2
 z5qeIzM5z3Jj/NuUK14mD3OEGR/+nD5gJqx5H7nBagJtV5nNCI5ARkVfaOfd59onV1gd
 4mpcoxaIgWJNWgWb5CG6CAtSLc+jY9St5Kkf4B1vN/nx1S83SMmquYkxJmV8uWBdQC94
 cOJw==
X-Gm-Message-State: AOJu0YybG+9BJ9/pMCBpyo/X8HLp0TutrtRzvarq1ChH878Z89vA1sb7
 ERoWRZmyF56vToa7oOjPNq2gopZSNSitRl2GC/blXh7xduutxnmsUWi2C1QKuiaJd4NcemT/2ol
 7VSCg
X-Gm-Gg: ASbGncv33SMHjjR/7qpZNk8eAHuNzEot6L+dvE0sg/XQh/ub8/VUDVnbPnrsuTHasjN
 pz1yYgT4JCESYJKnNgIJ9RHF26FfZ1TaLip+AtxMVzP9ijAT/82t//XDh+aI1denyRdHNB4gXDS
 c9GKrkF0+ZpjeQeg7IdQCAqmOOdXeQEMITfg0h1QpWj5OpiTs9iZEwbVG1wBtKywX9fi3bGG3P4
 Ob5aiplLine+sXvXSqNMhHXgokACs2c9IyWyWne80j3F6fPs6nhdHEnG9CoKs7NUG2zGgL8OMsm
 v0cyLjQ1l7o8xbX9iCHYzlc+adey34nUdlvSe/SDWPClkEtoH2Os8g3uRyU93CwSCRmfGp+D3hY
 nqdt6hxYL7EoEqmYb1oHPmu0sxdhfqrbCpSHT
X-Google-Smtp-Source: AGHT+IHWQWyJ4edigPm6WX4emJw1YGC78JwhKiygUe0fZy19EynGheuHvqq/E6EURQqj/zrtyMJQzw==
X-Received: by 2002:a05:6214:e86:b0:700:bc43:27a3 with SMTP id
 6a1803df08f44-704a39c6989mr162446d6.36.1752165762410; 
 Thu, 10 Jul 2025 09:42:42 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 01/13] ethdev: allow start/stop from secondary process
Date: Thu, 10 Jul 2025 09:16:42 -0700
Message-ID: <20250710164237.8630-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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
 lib/ethdev/ethdev_driver.c  | 11 ++++-
 lib/ethdev/ethdev_private.c | 93 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_private.h | 26 +++++++++++
 lib/ethdev/rte_ethdev.c     | 84 +++++++++++++++++++--------------
 4 files changed, 177 insertions(+), 37 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..66ba7dafc9 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -114,6 +114,14 @@ rte_eth_dev_allocate(const char *name)
 		goto unlock;
 	}
 
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
@@ -282,7 +290,8 @@ rte_eth_dev_release_port(struct rte_eth_dev *eth_dev)
 		memset(eth_dev->data, 0, sizeof(struct rte_eth_dev_data));
 		eth_dev->data = NULL;
 
-		eth_dev_shared_data->allocated_ports--;
+		if (--eth_dev_shared_data->allocated_ports == 0)
+			rte_mp_action_unregister(ETHDEV_MP);
 		eth_dev_shared_data_release();
 	}
 
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 285d377d91..184cf33f99 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2018 Gaëtan Rivet
  */
 
+#include <assert.h>
+
 #include <eal_export.h>
 #include <rte_debug.h>
 
@@ -477,3 +479,94 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
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
+		if (resp->err_value == 0)
+			ret = 0;
+		else
+			rte_errno = -resp->err_value;
+		free(mp_reply.msgs);
+	}
+
+	if (ret < 0)
+		RTE_ETHDEV_LOG_LINE(ERR,
+		       "port %up ethdev op %u failed", port_id, operation);
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
index dd7c00bc94..41363af2c3 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1800,54 +1800,61 @@ rte_eth_dev_start(uint16_t port_id)
 
 	if (dev->data->dev_configured == 0) {
 		RTE_ETHDEV_LOG_LINE(INFO,
-			"Device with port_id=%"PRIu16" is not configured.",
-			port_id);
+				    "Device with port_id=%"PRIu16" is not configured.",
+				    port_id);
 		return -EINVAL;
 	}
 
 	if (dev->data->dev_started != 0) {
 		RTE_ETHDEV_LOG_LINE(INFO,
-			"Device with port_id=%"PRIu16" already started",
-			port_id);
+				    "Device with port_id=%"PRIu16" already started",
+				    port_id);
 		return 0;
 	}
 
-	ret = rte_eth_dev_info_get(port_id, &dev_info);
-	if (ret != 0)
-		return ret;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
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
+		diag = dev->dev_ops->dev_start(dev);
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
+			ret_stop = rte_eth_dev_stop(port_id);
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

