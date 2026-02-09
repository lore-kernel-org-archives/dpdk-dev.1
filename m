Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D1AE7E0D2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE9540A82;
	Mon,  9 Feb 2026 19:41:07 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 2E85B40A72
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:41:04 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so2623499f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662464;
 x=1771267264; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlKvyXv4EqVdAluoq6MSAbQmwzn/RvG7UFQ78l2pyv0=;
 b=WlE7dI0NjIELdK7Cg+NhA2uTS51I2GlJwSu/bbp2U2qvJleCS2TniBDLD1ZUq8nBHH
 hE3xJ3prfLH/Lzfa8unu0028oz+g5fEko5j4wroqkmzRX1V8tn4tPMi0iZUJeHavJzEL
 tyfDSydpnoDIjfXzEZ3uK3ZvhFzS+H9EIJd4jsUpFAwB2a9zwMFm6SQX96hRCVuSayII
 b3qijvsD3kIgv4qysTwmRvpPMQGtaOAKB8ff0oamht7uYWwRAWcbe/U4oo07kTcJ8w/o
 1MJMcTfajUVNZMEwpxhHitCpx2SuSZylhrkYDfHQ4R0Dw8ouXL4pbFS/OwIUsivCPx2N
 l5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662464; x=1771267264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlKvyXv4EqVdAluoq6MSAbQmwzn/RvG7UFQ78l2pyv0=;
 b=pP9koXZh/7pTUvIJVZO/gpyNwOgYHiiVoRimJHh2ditokiEN7EmapeoFo76VmO0Sv7
 WgnCJZ7Et1szXTPwOGu/64YV+cN2dCCSLplu2fibE1reeu+wxmGuFMp1zuH/KL+TI5WD
 0MEUq2CVASCU5QAY5g/aEukLu+pNoR6rotq7X54PR++CwDNTe2kxe/oTHCs1E+XQvOcT
 vsFh4x/BtqxGuHr28b2A1Df2kxtXqrq3LstjdeQVxnNkakCWaeT/iIErqBaDAofhUH88
 4/bTtR592lWb8lLQFVi2szdigCuNvnSf213Ao/bbMAG7lhOamLM7YzAMDQupID4GSHqD
 H3KQ==
X-Gm-Message-State: AOJu0Yygyu7thF6OfSFTYxkyBP5JGgTJnuzmAnQTTMI1JQSjak0vrslQ
 6iq9Dt/O5aq3d+vJwHkHC9yxw2wBIlvtorBSde4xT6o15NHuI8EtXF4ym3C7D4MQgryeb1SO2Mu
 fllIj
X-Gm-Gg: AZuq6aIqbjyOmPHe0OQ3w/Pfye/c66Uh9FZSjJgEYHnhHpU7X3SL29+KrnO7q7SVxhY
 RZQpbEMSeuAIbGuZZi83+vVDHPpAhSkuQJF69zmnw9p70m4qG8745PFw+AV9ns5TvKiPMlv49Xl
 hV6pJfhLpe0+UREQB/ElDNrI1O38SbSqm28DvaXO2jO5d3gB16bDfVP3vs3C1HG6cc0Qm6G+XgT
 oN8tQ1P9BxOYMqt/b4mq5iKbbdykEuSFYwAEU4SuujSUBE/gCrz1V1mj1MsJE24LpCHuw62pk+1
 DAeex0qZIQHZyD0Jn43b6S8Ox22QaGRqMAlXJVyYhzROwhUb/N35BGRN5VgSQf9s13LFo4zbT1f
 lE4ZuHZMHeXFctL56+U+dFB5Gnho/K0yHTNdut9X/s0x2gm1INibxVE0+2RB7l7i6mXBa05UZ0p
 6Sy8/IFlkLLcZ7RJJN6WpDfMfuglaYgpOgvU3qi+juSeS1y0rrjx+kqewdsFSp
X-Received: by 2002:adf:e9c2:0:b0:436:3499:52b9 with SMTP id
 ffacd0b85a97d-436349954a0mr8654946f8f.10.1770662463667; 
 Mon, 09 Feb 2026 10:41:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:41:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 08/10] net/rtap: add multi-process support
Date: Mon,  9 Feb 2026 10:39:07 -0800
Message-ID: <20260209184045.132774-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209184045.132774-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260209184045.132774-1-stephen@networkplumber.org>
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

Add support for DPDK multi-process operation. Secondary processes
need access to the per-queue TAP file descriptors owned by the
primary process.

Implement fd sharing using the DPDK multi-process IPC mechanism:
  - Primary registers an MP action handler that responds to fd
    requests by sending queue fds via rte_mp_reply()
  - Secondary process attaches to the existing device and requests
    fds from primary via rte_mp_request_sync()

The MP action is registered on the first device probe and
unregistered when the last device is closed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   1 +
 drivers/net/rtap/rtap_ethdev.c    | 130 ++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index 36a14e9696..fe0c88a8fc 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -14,6 +14,7 @@ Basic stats          = Y
 Stats per queue      = Y
 TSO                  = Y
 L4 checksum offload  = Y
+Multiprocess aware   = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 8c22021655..9b8ad1f452 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -42,6 +42,8 @@
 				 RTE_ETH_RX_OFFLOAD_TCP_LRO | \
 				 RTE_ETH_RX_OFFLOAD_SCATTER)
 
+#define RTAP_MP_KEY		"rtap_mp_send_fds"
+
 #define RTAP_DEFAULT_BURST	64
 #define RTAP_NUM_BUFFERS	1024
 #define RTAP_MAX_QUEUES		128
@@ -53,6 +55,8 @@ static_assert(RTAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd li
 #define RTAP_IFACE_ARG		"iface"
 #define RTAP_PERSIST_ARG	"persist"
 
+static RTE_ATOMIC(unsigned int) rtap_dev_count;
+
 static const char * const valid_arguments[] = {
 	RTAP_IFACE_ARG,
 	RTAP_PERSIST_ARG,
@@ -530,6 +534,8 @@ rtap_dev_close(struct rte_eth_dev *dev)
 	free(dev->process_private);
 	dev->process_private = NULL;
 
+	if (rte_atomic_fetch_sub_explicit(&rtap_dev_count, 1, rte_memory_order_release) == 1)
+		rte_mp_action_unregister(RTAP_MP_KEY);
 	return 0;
 }
 
@@ -669,6 +675,89 @@ rtap_parse_iface(const char *key __rte_unused, const char *value, void *extra_ar
 	return 0;
 }
 
+/* Secondary process requests rxq fds from primary. */
+static int
+rtap_request_fds(const char *name, struct rte_eth_dev *dev)
+{
+	struct rte_mp_msg request = { };
+
+	strlcpy(request.name, RTAP_MP_KEY, sizeof(request.name));
+	strlcpy((char *)request.param, name, RTE_MP_MAX_PARAM_LEN);
+	request.len_param = strlen(name);
+
+	/* Send the request and receive the reply */
+	PMD_LOG(DEBUG, "Sending multi-process IPC request for %s", name);
+
+	struct timespec timeout = {.tv_sec = 1, .tv_nsec = 0};
+	struct rte_mp_reply replies;
+	int ret = rte_mp_request_sync(&request, &replies, &timeout);
+	if (ret < 0 || replies.nb_received != 1) {
+		PMD_LOG(ERR, "Failed to request fds from primary: %s",
+			rte_strerror(rte_errno));
+		return -1;
+	}
+
+	struct rte_mp_msg *reply = replies.msgs;
+	PMD_LOG(DEBUG, "Received multi-process IPC reply for %s", name);
+	if (dev->data->nb_rx_queues != reply->num_fds) {
+		PMD_LOG(ERR, "Incorrect number of fds received: %d != %d",
+			reply->num_fds, dev->data->nb_rx_queues);
+		free(reply);
+		return -EINVAL;
+	}
+
+	int *fds = dev->process_private;
+	for (int i = 0; i < reply->num_fds; i++) {
+		fds[i] = reply->fds[i];
+		PMD_LOG(DEBUG, "Received queue %u fd %d from primary", i, fds[i]);
+	}
+
+	free(reply);
+	return 0;
+}
+
+/* Primary process sends rxq fds to secondary. */
+static int
+rtap_mp_send_fds(const struct rte_mp_msg *request, const void *peer)
+{
+	const char *request_name = (const char *)request->param;
+
+	PMD_LOG(DEBUG, "Received multi-process IPC request for %s", request_name);
+
+	/* Find the requested port */
+	struct rte_eth_dev *dev = rte_eth_dev_get_by_name(request_name);
+	if (!dev) {
+		PMD_LOG(ERR, "Failed to get port id for %s", request_name);
+		return -1;
+	}
+
+	/* Populate the reply with the fds for each queue */
+	struct rte_mp_msg reply = { };
+	if (dev->data->nb_rx_queues > RTE_MP_MAX_FD_NUM) {
+		PMD_LOG(ERR, "Number of rx queues (%d) exceeds max number of fds (%d)",
+			   dev->data->nb_rx_queues, RTE_MP_MAX_FD_NUM);
+		return -EINVAL;
+	}
+
+	int *fds = dev->process_private;
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		PMD_LOG(DEBUG, "Send queue %u fd %d to secondary", i, fds[i]);
+		reply.fds[reply.num_fds++] = fds[i];
+	}
+
+	/* Send the reply */
+	strlcpy(reply.name, request->name, sizeof(reply.name));
+	strlcpy((char *)reply.param, request_name, RTE_MP_MAX_PARAM_LEN);
+	reply.len_param = strlen(request_name);
+
+	PMD_LOG(DEBUG, "Sending multi-process IPC reply for %s", request_name);
+	if (rte_mp_reply(&reply, peer) < 0) {
+		PMD_LOG(ERR, "Failed to reply to multi-process IPC request");
+		return -1;
+	}
+	return 0;
+}
+
 static int
 rtap_probe(struct rte_vdev_device *vdev)
 {
@@ -683,6 +772,38 @@ rtap_probe(struct rte_vdev_device *vdev)
 
 	PMD_LOG(INFO, "Initializing %s", name);
 
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		eth_dev = rte_eth_dev_attach_secondary(name);
+		if (!eth_dev) {
+			PMD_LOG(ERR, "Failed to probe %s", name);
+			return -1;
+		}
+		eth_dev->dev_ops = &rtap_ops;
+		eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+		eth_dev->device = &vdev->device;
+
+		if (!rte_eal_primary_proc_alive(NULL)) {
+			PMD_LOG(ERR, "Primary process is missing");
+			goto error;
+		}
+
+		fds = calloc(RTE_MAX_QUEUES_PER_PORT, sizeof(int));
+		if (fds == NULL) {
+			PMD_LOG(ERR, "Failed to alloc memory for process private");
+			goto error;
+		}
+		for (uint16_t i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++)
+			fds[i] = -1;
+
+		eth_dev->process_private = fds;
+
+		if (rtap_request_fds(name, eth_dev))
+			goto error;
+
+		rte_eth_dev_probing_finish(eth_dev);
+		return 0;
+	}
+
 	if (params != NULL) {
 		kvlist = rte_kvargs_parse(params, valid_arguments);
 		if (kvlist == NULL)
@@ -721,6 +842,15 @@ rtap_probe(struct rte_vdev_device *vdev)
 	if (rtap_create(eth_dev, tap_name, persist) < 0)
 		goto error;
 
+	/* register the MP server on the first device */
+	if (rte_atomic_fetch_add_explicit(&rtap_dev_count, 1, rte_memory_order_acquire) == 0) {
+		if (rte_mp_action_register(RTAP_MP_KEY, rtap_mp_send_fds) < 0) {
+			PMD_LOG(ERR, "Failed to register multi-process callback: %s",
+				rte_strerror(rte_errno));
+			goto error;
+		}
+	}
+
 	rte_eth_dev_probing_finish(eth_dev);
 	rte_kvargs_free(kvlist);
 	return 0;
-- 
2.51.0

