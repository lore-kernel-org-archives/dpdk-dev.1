Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091DC28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B024065D;
	Wed, 12 Mar 2025 00:54:48 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 8CAB640264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:44 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so594109a91.1
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737284;
 x=1742342084; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9isuJqGKXWlOQLwigKpzvj/MbFh+ED+O7EL+KjWAdo=;
 b=bz39uaXcRRw9awfCjGrdnMehQ2zdbkAKAJEnfk+QTuPKv52/u8WKc4YTaommj1q5MX
 qI6VqK2L44R3PcBRE8rAsODsEXO6ecFCMiZC2pqhbSd5LBjk5sdeDM1g+tzQs3ry7ZSX
 M+FZonsP07i81EUl+hOOlagi3N7oZzUw373k9vDdR/WpTvuvYdoK7jnTBXV8biBU2ccH
 KwZl5b9BJ/xq9orHLBFRwQBcUMCd+LvWBnDIIztrCx+FDR/sWOMNMYVMRtisO5dyAnbT
 m072PJw+G8Vplh/UK/1Rw/2C5/ozXd3XHg+zhdhxGQFFw067GnOMZMDok0norXHtp+y/
 R1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737284; x=1742342084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9isuJqGKXWlOQLwigKpzvj/MbFh+ED+O7EL+KjWAdo=;
 b=Ixc4J2PuALYeSuCwrTrT1zuFb+VAeeon8vfNYQn5qLAQfdBlJWvPEM6E9mTRZ6Xn/Q
 h+xXoGQkG+Qq9cBfUtKlfPzHNfkIfGqgYk3oe2ggOsdKmjUdqFp4fY7aiA+VRk5SCq5b
 fWkPnrw3kHLYi2uec7O0ZJVqw8NsbP3Ei2NnOjfu484fU6SOt8nE5NAvj1dGiKlAb2s7
 lgiuVA4uvJ2XNWREwcjozHiqpz/RzIGrVH71IqeBscEveJXj5LzZrCcb0W6QVAlbTLJ+
 Xw5kXB0E2iPuJ55RDfYialSqKPXiM61b/8Serw6zXt+Vx0h365EXMBNEA4TNlsBMblA3
 1zLQ==
X-Gm-Message-State: AOJu0Yz3Rrrn/UXoehw0qhEsE0Zu0H7kv1mrKqUPCmmYLuym3H/PTsqe
 teC9XmWdtL2gFOWkTUYximGxrfe9nrx1lje4w2gNtCZfw0dnMEFB7n7WK27BakmWNisqhlRlezl
 k
X-Gm-Gg: ASbGnctI6GC0YxHQw5AMrN2c4inaEFETxclxzrNOR7sK1oCCVQ3W2hyIIejR6YrrqnU
 RrTcHTgcchRn2pZB4u8amQ99xCiEUblVlsZ1yx+oqbpjx/w8pAHBsgYJEiLOatlDK41KgF8lJnS
 k5uBEqCvCRIfxr1gH0/WabJ63w7XpEfQtmQlq2y3LHNS/z4mxUMlYLQ8gQtPPZgFQq2nQ6DRPZv
 cArGBe5YO7E0tqcVY7zpc0G6hp3AT18nUyU5aTia8hVCNn3Ww9yTN0CDEXqlYqPCs/Nbd5lXhyr
 mc5m6XcV/LHs7p0PVnVhMxfH/46XBhmMyrJs+UniUeNBZMhxeN5sQBUsQHsFZ7zN9xeYEJwfTxP
 9//MauPg+1HLqql+rgGzR9Ostqd7kr9wY
X-Google-Smtp-Source: AGHT+IEYPNZyUtxKhVHqEYQQAMbO0k4Bi29cFLY60FVutsNHpKT7DQWHNa1M6iSPZ4FYYtdDutyHsg==
X-Received: by 2002:a17:90b:2dca:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-301004f8003mr6681987a91.3.1741737283479; 
 Tue, 11 Mar 2025 16:54:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 5/9] net/ioring: implement secondary process support
Date: Tue, 11 Mar 2025 16:51:23 -0700
Message-ID: <20250311235424.172440-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add support for communicating fd's from primary to secondary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |   1 +
 drivers/net/ioring/rte_eth_ioring.c | 136 +++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index 199c7cd31c..da47062adb 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -8,6 +8,7 @@ Link status          = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+Multiprocess aware   = Y
 Linux		     = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index b5b5ffdee3..f01db960a7 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -28,6 +28,7 @@
 #include <rte_log.h>
 
 #define IORING_DEFAULT_IFNAME	"itap%d"
+#define IORING_MP_KEY		"ioring_mp_send_fds"
 
 RTE_LOG_REGISTER_DEFAULT(ioring_logtype, NOTICE);
 #define RTE_LOGTYPE_IORING ioring_logtype
@@ -400,6 +401,84 @@ parse_iface_arg(const char *key __rte_unused, const char *value, void *extra_arg
 	return 0;
 }
 
+/* Secondary process requests rxq fds from primary. */
+static int
+ioring_request_fds(const char *name, struct rte_eth_dev *dev)
+{
+	struct rte_mp_msg request = { };
+
+	strlcpy(request.name, IORING_MP_KEY, sizeof(request.name));
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
+		return -EINVAL;
+	}
+
+	int *fds = dev->process_private;
+	for (int i = 0; i < reply->num_fds; i++)
+		fds[i] = reply->fds[i];
+
+	free(reply);
+	return 0;
+}
+
+/* Primary process sends rxq fds to secondary. */
+static int
+ioring_mp_send_fds(const struct rte_mp_msg *request, const void *peer)
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
+	/* Populate the reply with the xsk fd for each queue */
+	struct rte_mp_msg reply = { };
+	if (dev->data->nb_rx_queues > RTE_MP_MAX_FD_NUM) {
+		PMD_LOG(ERR, "Number of rx queues (%d) exceeds max number of fds (%d)",
+			   dev->data->nb_rx_queues, RTE_MP_MAX_FD_NUM);
+		return -EINVAL;
+	}
+
+	int *fds = dev->process_private;
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++)
+		reply.fds[reply.num_fds++] = fds[i];
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
 ioring_probe(struct rte_vdev_device *vdev)
 {
@@ -407,14 +486,43 @@ ioring_probe(struct rte_vdev_device *vdev)
 	const char *params = rte_vdev_device_args(vdev);
 	struct rte_kvargs *kvlist = NULL;
 	struct rte_eth_dev *eth_dev = NULL;
+	int *fds = NULL;
 	char tap_name[IFNAMSIZ] = IORING_DEFAULT_IFNAME;
 	uint8_t persist = 0;
 	int ret;
 
 	PMD_LOG(INFO, "Initializing %s", name);
 
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-		return -1; /* TODO */
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct rte_eth_dev *eth_dev;
+
+		eth_dev = rte_eth_dev_attach_secondary(name);
+		if (!eth_dev) {
+			PMD_LOG(ERR, "Failed to probe %s", name);
+			return -1;
+		}
+		eth_dev->dev_ops = &ops;
+		eth_dev->device = &vdev->device;
+
+		if (!rte_eal_primary_proc_alive(NULL)) {
+			PMD_LOG(ERR, "Primary process is missing");
+			return -1;
+		}
+
+		fds  = calloc(RTE_MAX_QUEUES_PER_PORT, sizeof(int));
+		if (fds == NULL) {
+			PMD_LOG(ERR, "Failed to alloc memory for process private");
+			return -1;
+		}
+
+		eth_dev->process_private = fds;
+
+		if (ioring_request_fds(name, eth_dev))
+			return -1;
+
+		rte_eth_dev_probing_finish(eth_dev);
+		return 0;
+	}
 
 	if (params != NULL) {
 		kvlist = rte_kvargs_parse(params, valid_arguments);
@@ -432,21 +540,45 @@ ioring_probe(struct rte_vdev_device *vdev)
 			persist = 1;
 	}
 
+	/* Per-queue tap fd's (for primary process) */
+	fds = calloc(RTE_MAX_QUEUES_PER_PORT, sizeof(int));
+	if (fds == NULL) {
+		PMD_LOG(ERR, "Unable to allocate fd array");
+		return -1;
+	}
+	for (unsigned int i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++)
+		fds[i] = -1;
+
 	eth_dev = rte_eth_vdev_allocate(vdev, sizeof(struct pmd_internals));
 	if (eth_dev == NULL) {
 		PMD_LOG(ERR, "%s Unable to allocate device struct", tap_name);
 		goto error;
 	}
 
+	eth_dev->data->dev_flags = RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	eth_dev->dev_ops = &ops;
+	eth_dev->process_private = fds;
+
 	if (ioring_create(eth_dev, tap_name, persist) < 0)
 		goto error;
 
+	/* register the MP server on the first device */
+	static unsigned int ioring_dev_count;
+	if (ioring_dev_count == 0) {
+		if (rte_mp_action_register(IORING_MP_KEY, ioring_mp_send_fds) < 0) {
+			PMD_LOG(ERR, "Failed to register multi-process callback: %s",
+				rte_strerror(rte_errno));
+			goto error;
+		}
+	}
+	++ioring_dev_count;
 	rte_eth_dev_probing_finish(eth_dev);
 	return 0;
 
 error:
 	if (eth_dev != NULL)
 		rte_eth_dev_release_port(eth_dev);
+	free(fds);
 	rte_kvargs_free(kvlist);
 	return -1;
 }
-- 
2.47.2

