Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F06C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7BAF406B8;
	Tue, 29 Jul 2025 00:10:02 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6ED8C4060C
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:01 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7dd8773f9d9so456237585a.2
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740601;
 x=1754345401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrB/CHJPwLlOJqS4wqEVDyyiaCZCeQR5x1ozZcXaj60=;
 b=eAENacHYzXAvuXOI9jW8o8fIzZ99CTy3tgpF5hvoiMgJzKXKBU6lQ2vsB/C5ZVkOFW
 TKT3zCNqvwkASUQtVMsEeKUUoHd+tmlvJ+kDXiSa32spg9jTlGf53qvP06mAQLSuBJsj
 NKksGPXD3pA2f+66OFfG7Sx6gerKPpP6vCgdI5VFYmAAO10KRdwa5Xf5kHn9PV4Lg/CW
 8/SMVDghtK+7nygT2ze5DwmnedUhVp6mJY7JSMeze1/4AZqZVIjjeIcrSxF4Twuht0l+
 RAf8jc9WsneQawBa0bTrzoGnZzJ7QbLz8u0+h7CA7eqVOaahiLFpo6LatN4qdbhVnxun
 Wmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740601; x=1754345401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrB/CHJPwLlOJqS4wqEVDyyiaCZCeQR5x1ozZcXaj60=;
 b=NdYPREIgoRHy8S4HMNiQDjzLxlfgHQomIXDCQykzaIKpxjWuoJk9X6H5utuwcB7oz+
 lEmymCUEi4pwS4p4R7Kr59ZuuHTw4swQqCKhlT7gpOxVlBZ2V8pE++r8/iFjFIpCATZT
 Izb17HNy2WPXOIV5qCioDuRXmlHqapXMuXSLx7GgNhPDBQY24I7EAeDK04ieYyN5oAKy
 +9JLRbXqXRvfvRVGsrVzPmxLl6zcWhFnmyp/7Npozn00EEyFkS41GvMebXHaUuesQbvc
 uUoMMzaM6GRfRvY9nhEvGgc6ILszs0K2h+QmtbUZvGcR95tg6g4IwXh70pkKJ5vyhZj7
 XrCQ==
X-Gm-Message-State: AOJu0YzaxStUwg+TeTpCMHIdjfsl/DGc4ESFN9rfO/V106BNDpw8CPRJ
 wU85Ek95r062zcfO1lDwYqrLtShKZTzRirwQM3mU71vIcghAR6oRhKars+ytSyGDcqJljWgzR4s
 NH143
X-Gm-Gg: ASbGnctkva3HEdhnd0kVGUehmwfMzqv++I5+/I/2nZcF4L3IZygjqVJrQOuozxEF/HM
 0Skol0ZS0kbxKVUQdnEeB2GvDXcDzEdvzIVeiSu09I8PaPlSUHvy//8AaUBwH/zSj+mV9Er6/IL
 OppHuoDmzBGT6f3fNgWpdDpPjtu612MlSLk/fGgecQWXMO6fg+SpZGj07WYn0r0LsRNzmeCLo18
 K4RlUgMDbc+px+If6DynH3cHcOd+qJfHIFk+4saVhEc/GUNEKGE5vTrxwblatiZVf3HIb+/fVZ9
 cfWAMW/1Kvoe/+j/imjPUD0EMg515QiY0pxzOlesjbRjJn6do0peaohxmi4CHL8w8JV5Wr+mH78
 m8MCxDK+HnLzkWj26ZNhwJfYtCWaiTX8C/bwL16SSByUXA4p+R7iQtEl1kZpinGhNmCd0wnZl
X-Google-Smtp-Source: AGHT+IHssbOHi8UdTIrv1bjXhVZ/KP/lX/8VNN+DHmIEV+jg7396DNiIsAKqs4dZG9f0r06hURVlCw==
X-Received: by 2002:a05:620a:3bda:b0:7e3:3384:4a8b with SMTP id
 af79cd13be357-7e63bfa8ffemr1475059785a.37.1753740600712; 
 Mon, 28 Jul 2025 15:10:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 01/12] ethdev: allow start/stop from secondary process
Date: Mon, 28 Jul 2025 15:08:09 -0700
Message-ID: <20250728220955.332924-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

