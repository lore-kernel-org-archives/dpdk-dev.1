Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA7EF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4522A402ED;
	Sun, 15 Feb 2026 00:47:47 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 4376340651
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:44 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so22856555e9.1
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112864;
 x=1771717664; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WY3yWHN/gAL4mwqCmH+YNbFkKp/W/255X9ckRGrkmU4=;
 b=eSgcO4/lCMDxKSLPhpXwocr0oUjamZl7PAL0nKsCOaOSot4MmaInbcxDMtraXnTUJ0
 er3+g+a0lMBfJQfKkYvwLJBppk7V9Bh4+/eaPNJo09Nxhl/fo4N+5cRDm5jEy+nsyhyH
 bt5uAlxbjQp8UZ/F6KanUpq0mlJPc5eW8YUxVjJsN5f4BSCPY/DOK4zbO2QWz5yTcuqM
 sjfyIqGF6VZGs7GcT4NZ9+FYqzjNSLgD+7L4zMejvE2dtqlc2NLsd/1ch6p7IA6BpHxU
 Ilj2cOIKiYoXP9VGRueIBh9ZMUgo2bWMvULwW3Nia9U/Y0IqTrUL1KIvXj+vHqaC0NYC
 l+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112864; x=1771717664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WY3yWHN/gAL4mwqCmH+YNbFkKp/W/255X9ckRGrkmU4=;
 b=kqeiHRGyref1r5KdVh57qjQwJSRiGKGNCjRnKmdPfb4C7r7NzrfaRqCtfd1Qc4x6LJ
 1nZsCIzAGuwCiv8haTY5hWiBJDVV9YKdgXzhEaA8JHLQuokQw6pt1g3u18I8jGR1Zc+b
 /9tDgIqlOTALLn2LGtkVpW+qJZ3+HVMwsl8EZh2DMv/9Xx2TZ3zxmgO3dJWcnVzAMXN+
 HuwHWBurQao4rbbdHMp8mTh5DDyGi8eGP7K6JR5A7KN3AvBWSegu9Tuqahc0C8OK8PAl
 psnsPOnqu1uEyhYKw2cJs6uMu1eeii+Px/EAgpI4gHIFbh8NO6tKHWqFPFAtk4V7WyYA
 BWFQ==
X-Gm-Message-State: AOJu0YwkNH8HG+FRWcryyxX2fi/rKnJ4bVCwfY0Y77X4QFXv4PvXqju1
 LflntCtf9nJWJtHBzVzjqbQT0dhsscUkDfbdlVc9sYX+NGMJax8+I9p+6n9go5/uPObh53G9x8a
 Ktots
X-Gm-Gg: AZuq6aI8pAOktmN83luuNtqAWuqNDW/8ne/FdqKCWdHoGCabB7mFsbLGp3mLJTBBFU1
 lQpt0yYVCB0Wglqf4AA1ynLrneAd4ivGrzb+WcUMJEc0TjfRDQIyqjDF663mmOCZB5spzYu+NtG
 CS2AIsco0Lk8utoZ/RL40z0zEuwKcMv1G0iHdETBQqcHoScJqSo4iXKTaZ2/JKazC/xT3yyM6An
 yyJqlFtJTgjxhnXsyxdRd3alIPcywuFNJ4b2ayNuOR+Wxo/KBUj/zOQYZ7ZMKDXLzSFqfJXh2Ef
 HvrVNYJeELH20nb+TsKweWGnSGQt7EhMykywenL8MQ3sAQqyLPfeSULT8NBAtSJcBmNI8vP+2n1
 HsFxLq3fl5Cigcp7tUWVX9qECg+KiGD6R2R7uHYsSmzy+xfpvrQ4EPby7cuzflpf+EZmNXQUDy0
 LkF1bABhU6JmAWBgsIbHoXQny/B8SmFdwsqPH/HUrERV9Qzu7Ysc5H59l6VcCi+rox
X-Received: by 2002:a05:600c:4686:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-483739ff981mr118707135e9.3.1771112863705; 
 Sat, 14 Feb 2026 15:47:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 07/11] net/rtap: add multi-process support
Date: Sat, 14 Feb 2026 15:44:16 -0800
Message-ID: <20260214234726.188947-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
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
 drivers/net/rtap/rtap_ethdev.c    | 140 ++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index b8eaa805fe..cfbd29ef08 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -13,6 +13,7 @@ Basic stats          = Y
 Stats per queue      = Y
 TSO                  = Y
 L4 checksum offload  = Y
+Multiprocess aware   = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index c4125e04b3..705d98323e 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <time.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
@@ -19,10 +20,12 @@
 #include <rte_common.h>
 #include <rte_dev.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_kvargs.h>
 #include <rte_log.h>
+#include <rte_stdatomic.h>
 #include <bus_vdev_driver.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
@@ -41,6 +44,8 @@
 				 RTE_ETH_RX_OFFLOAD_TCP_LRO | \
 				 RTE_ETH_RX_OFFLOAD_SCATTER)
 
+#define RTAP_MP_KEY		"rtap_mp_send_fds"
+
 #define RTAP_DEFAULT_BURST	64
 #define RTAP_NUM_BUFFERS	1024
 #define RTAP_MAX_QUEUES		128
@@ -52,6 +57,8 @@ static_assert(RTAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd li
 #define RTAP_IFACE_ARG		"iface"
 #define RTAP_PERSIST_ARG	"persist"
 
+static RTE_ATOMIC(unsigned int) rtap_dev_count;
+
 static const char * const valid_arguments[] = {
 	RTAP_IFACE_ARG,
 	RTAP_PERSIST_ARG,
@@ -433,6 +440,8 @@ rtap_dev_close(struct rte_eth_dev *dev)
 	free(dev->process_private);
 	dev->process_private = NULL;
 
+	if (rte_atomic_fetch_sub_explicit(&rtap_dev_count, 1, rte_memory_order_release) == 1)
+		rte_mp_action_unregister(RTAP_MP_KEY);
 	return 0;
 }
 
@@ -578,6 +587,96 @@ rtap_parse_iface(const char *key __rte_unused, const char *value, void *extra_ar
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
+	request.len_param = strlen(name) + 1;
+
+	/* Send the request and receive the reply */
+	PMD_LOG(DEBUG, "Sending multi-process IPC request for %s", name);
+
+	struct timespec timeout = {.tv_sec = 1, .tv_nsec = 0};
+	struct rte_mp_reply replies;
+	int ret = rte_mp_request_sync(&request, &replies, &timeout);
+	if (ret < 0) {
+		PMD_LOG(ERR, "Failed to request fds from primary: %s",
+			rte_strerror(rte_errno));
+		return -1;
+	}
+
+	struct rte_mp_msg *reply = replies.msgs;
+	PMD_LOG(DEBUG, "Received multi-process IPC reply for %s", name);
+
+	if (replies.nb_received != 1) {
+		PMD_LOG(ERR, "Got %u replies from primary", replies.nb_received);
+		free(reply);
+		return -EINVAL;
+	}
+
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
+	if (dev == NULL) {
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
+	reply.len_param = strlen(request_name) + 1;
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
@@ -592,6 +691,38 @@ rtap_probe(struct rte_vdev_device *vdev)
 
 	PMD_LOG(INFO, "Initializing %s", name);
 
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		eth_dev = rte_eth_dev_attach_secondary(name);
+		if (eth_dev == NULL) {
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
@@ -630,6 +761,15 @@ rtap_probe(struct rte_vdev_device *vdev)
 	if (rtap_create(eth_dev, tap_name, persist) < 0)
 		goto error;
 
+	/* register the MP server on the first device */
+	if (rte_atomic_fetch_add_explicit(&rtap_dev_count, 1, rte_memory_order_acquire) == 0 &&
+	    rte_mp_action_register(RTAP_MP_KEY, rtap_mp_send_fds) < 0) {
+		rte_atomic_store_explicit(&rtap_dev_count, 0, rte_memory_order_relaxed);
+		PMD_LOG(ERR, "Failed to register multi-process callback: %s",
+			rte_strerror(rte_errno));
+		goto error;
+	}
+
 	rte_eth_dev_probing_finish(eth_dev);
 	rte_kvargs_free(kvlist);
 	return 0;
-- 
2.51.0

