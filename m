Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C9C369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A3D140DFD;
	Sat, 12 Apr 2025 01:49:44 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8B8C44021E
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:41 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-225df540edcso37443925ad.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415380;
 x=1745020180; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wyawPve+P1GRhaFS0eV2ltZqQAdaSAsryCwYScL7IU=;
 b=vOJhOxAJ4rMvrKZhyjLsbeVdVkkcQ1tvGma1AnaMirZPVmnq3ZGQzeCa6xHDOyAWAp
 GFlGCwxllSeiujJ7CfXQfW+SIDTpRrqz5nfyJfmYiHMvy1Cf3UmYrbTs5iVEXnaVfeXp
 FtJwGrZ8b/RA5Hlwzg987r0sphZzBcNTLh238xhIbiKzIPBQjLgrpI+9KprehXONRw1J
 op23j5fLw75zzVI0nB8htmOQwBezUEJnMK6JG64dL6uvlTvD2hRjPrJxo3Gh0SV0JY1D
 q8NLC0awOHLDa0V8ZpyRtYcoS3r6ymvYShqrIGs3pYS0RTvAx1hp7q3R3rydhtn/k5KF
 ZFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415380; x=1745020180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wyawPve+P1GRhaFS0eV2ltZqQAdaSAsryCwYScL7IU=;
 b=Wl8de05S7YetJjuFXrZYMSB2QtNI8LXt/PWbq/gaqhrs68WLEFRWti/FWDPPjRBRQL
 4gvHTqZbRSH6AhhfNzuMUElFM89MR/LAnwRcnZ/ezq7WSjReXCB/jHvPiQcLi2Eo/CGh
 4rFajJHX9fwGPOvz3tpvEf6RihspPzoLWH4Dc2+pFUkgx9Y2fN5P7WitFWbXQVzw0YRe
 +jS2khRAKP4jM9CTaJjedaEp5xQ4wtLHskutUB6ufAawH92WssnH10hfgzoY8+45SB5H
 rnS6xEnmPBaPPb28iJE8iTSHDm7hYtAfbzieZbzWd0D7FUIbr5xhZ6xYNW+W/qziYmXe
 C43w==
X-Gm-Message-State: AOJu0Yzgo9fXlelmiB10F75cgiGjbUGMyx/+rA3Ymq3QamdixYJ9xMpP
 9y1inekhoA0CaTqKOHn3cXwKEhjKR+nDUiHuEQIjY0h7RaoQK7MfnqZhqGLPo7RQJEjfMBOkIPi
 2
X-Gm-Gg: ASbGnct3NlPDTquV8RMn3dieKzTVB5lf6cA2AX7awkJq5rZZZVtJJtYuXSqrsey5a9T
 8msO76y/9oBuJc+a65fM2BCJJJgY3zz6pZt7xoNYrbB4lLRA4vYtGhRmUIxQbD6Dp1Y6+jsx68y
 mYnRGc7hjFX3i8jNZcvoPsPc6WuJ6BSJs/MNps5lC9akzrawbExLzrOLk8X0zJ8oASPIiJH/wiS
 /U6KkZqCuXIJ6+FHDC61zbObIf7iKUxScO8zgR/5uKC37ynZmTwZ9BhL9CJZWjzZPK9YQjVRHhU
 +3RZXP6h+Jbr5BcZNTgraC6nwfRCTIz2tVB+ERCh7dkbPjQB3pFrtMBL93hcaJMu+2iFZk+qld2
 mRzqhpRx6CaQLx/0xNCsTp+XbCNc=
X-Google-Smtp-Source: AGHT+IGRMRY2ONtz+ywGmftEvMNegxURiNDquQS+5q5bU0AE+atputBOlspS6in/9UZndiUv8YCeBA==
X-Received: by 2002:a17:902:ec84:b0:223:4d5e:7592 with SMTP id
 d9443c01a7336-22b7f91b908mr107557875ad.21.1744415380372; 
 Fri, 11 Apr 2025 16:49:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 02/13] ethdev: allow start/stop from secondary process
Date: Fri, 11 Apr 2025 16:44:39 -0700
Message-ID: <20250411234927.114568-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

Before this patch if secondary process called start/stop
it would only impact the secondary process, the ethdev on the
primary process will still not be started.

With this patch, when start/stop is called from secondary,
it calls the primary and does the operation there. The design
is generic, and we can later add queue and other operations
as needed.

Bugzilla ID: 73

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c  | 11 ++++-
 lib/ethdev/ethdev_private.c | 77 ++++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_private.h | 23 ++++++++++
 lib/ethdev/rte_ethdev.c     | 84 +++++++++++++++++++++----------------
 4 files changed, 158 insertions(+), 37 deletions(-)

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
index b96d992ea1..bded3f1722 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -477,3 +477,80 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
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
+static_assert(sizeof(struct ethdev_mp_request) <= RTE_MP_MAX_PARAM_LEN);
+
+int
+ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
+{
+	struct rte_mp_msg mp_resp = {
+		.name = ETHDEV_MP,
+	};
+	struct ethdev_mp_response *resp
+		= (struct ethdev_mp_response *)mp_resp.param;
+	const struct ethdev_mp_request *req;
+
+	mp_resp.len_param = sizeof(*resp);
+
+	req = (const struct ethdev_mp_request *)mp_msg->param;
+
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
+ethdev_request(enum ethdev_mp_operation operation, uint16_t port_id,
+	       uint16_t queue_id __rte_unused)
+{
+	struct rte_mp_msg mp_req = { };
+	struct rte_mp_reply mp_reply;
+	struct ethdev_mp_request *req;
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	int ret;
+
+	req = (struct ethdev_mp_request *)mp_req.param;
+	strlcpy(mp_req.name, ETHDEV_MP, RTE_MP_MAX_NAME_LEN);
+	mp_req.len_param = sizeof(*req);
+
+	req->operation = operation;
+	req->port_id = port_id;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0) {
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
index b07b1b4c42..73df6c4b13 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -79,4 +79,27 @@ void eth_dev_txq_release(struct rte_eth_dev *dev, uint16_t qid);
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
+};
+
+struct ethdev_mp_response {
+	uint16_t res_op;
+	uint16_t port_id;
+	int32_t err_value;
+};
+
+int ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer);
+int ethdev_request(enum ethdev_mp_operation op, uint16_t port, uint16_t queue);
+
 #endif /* _ETH_PRIVATE_H_ */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..f7bf762ff7 100644
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
+		ret = ethdev_request(ETH_REQ_START, port_id, UINT16_MAX);
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
+		ret = ethdev_request(ETH_REQ_STOP, port_id, UINT16_MAX);
+	}
+
 	rte_ethdev_trace_stop(port_id, ret);
 
 	return ret;
-- 
2.47.2

