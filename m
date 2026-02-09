Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F600E7E0D2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7FC94065B;
	Mon,  9 Feb 2026 19:40:55 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 2C01340677
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:40:54 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so45785715e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662454;
 x=1771267254; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOaOlQO6fxEVMNmPmTDBmUHNzAN1HEefOgbRUq2oTD4=;
 b=Z+REdNd5rU0wC7j4HoR78ZRfRHyaNLs4/Xp+dwG1Gz/aJV/VklesM9hjnoVSw8rvx5
 uIZgkpPyoPQ8hk2DnuoqcuERpmDEbDOBa/w2UJenApNim/Yu4p4VFzl8VUnsL9Pu9UgW
 PXIXDZxLwatrmM8L6aGXggJF0eryQykkbdfikq1uLJF3BafDyBCYsb4VdYV9gq3ckV3E
 N42v4hdYXL0sFZqVvXbNQfsANr8RLlhyMQ0W9VTg2rHdjDcLX41Ut0r1ft2wl4B0Wv4m
 2GoR25jGkwdSczvmKqEpI+TYQLbC9dOj3fiESTph2R2zBFPwh4hOIHNc4B0safoYddB0
 ncuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662454; x=1771267254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VOaOlQO6fxEVMNmPmTDBmUHNzAN1HEefOgbRUq2oTD4=;
 b=n7cSMZgia9Ca5pVPgzk+c7XV9kAKGlFod0JlK10bqUX01YHqUxhQfuB7kjWHw2Crsm
 BYPokE0RbNore2bsPqu81BhdR6KjKqFPP530xASkWMOQMY8wFF8zzV5mIeT+lfe/glIr
 qIeeJm2La2eS5Qothkcl8VPgqSpCNrKzw9yVYKjM9IwXlqRvv5cB2frjuncEnjVxZij4
 LQac8aB0F6XOR3ycVv/Tm3qHs6BrGZ/CdQpN6F4h/nX72sMwSaBnzQgR3tnsczBvihN0
 3PLYlMaU/9OmcR0B2xrWYNrWKTB/02YjIHtVqWLy2zpqfVkX9gznn7iEDGwmGlhmVK4J
 Ti0w==
X-Gm-Message-State: AOJu0YyOHcSfcI8I+2FZdkJKD40ijYNHJSkt1ZwRPZ57pwy5LIDBim4+
 gjKUZhtORYpwlxEaCKh4Ryofc6Sd9sCs0CIeMgyPPDzfYyjVJtnIyY7YvjH4XdNviBSEOXjqxuk
 nlrPM
X-Gm-Gg: AZuq6aKVszx3mYNPBdcwEOMkNgdZjb99ckCO4gCswdhPy8ZYfay2VOr0PQ6APmFa3pd
 sefLn0UHmb1mis0X13A7wI5QUWbdoq817XyTdC2FOMV1HJdQmttyPTXiZ6J0GJ5Yi4mi+logDLn
 VMa6MDkYhqhx4MEkQ6SSFweNaKclyvrQCFK4kFTrnVQVJnJTDd29bAkay0tb7EHG04mSmTCgtll
 DgpPLa0N9zffz3SWzQQEGvEgbCCArTAeAo60ih5p59POSH8jc806iSiAZuQOMBobqbKGvYRvznP
 yzzty2pEobcJTsvkDenncWbIxRBuCzNsOFKrYUBsBfpg29xwBaPzHdKX2Rc3nsapW/5TJAuXkiM
 ngL4vHHhfRlqIEXkiIgX5+UJ50CeUtlgAm+KxrcjG55QDM32Ov0+T+yQTYjH8v+6c/A50VmZkdH
 nxS1OtHCytqP0bZXj+eP07rRprC/U7MN66qKHsPv3hsvLiyvSs2w==
X-Received: by 2002:a05:600c:c11c:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-4832c98458bmr103909465e9.18.1770662453603; 
 Mon, 09 Feb 2026 10:40:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 02/10] net/rtap: add TAP device creation and queue
 management
Date: Mon,  9 Feb 2026 10:39:01 -0800
Message-ID: <20260209184045.132774-3-stephen@networkplumber.org>
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

Add TAP device creation using the Linux TUN/TAP interface with
IFF_MULTI_QUEUE, IFF_NO_PI, and IFF_VNET_HDR flags. Enable NAPI
mode when the kernel supports it.

The driver maintains a keep-alive file descriptor to the TAP device
and opens additional per-queue file descriptors for data path I/O.
This mirrors the multi-queue TAP architecture where each queue pair
(rx + tx) shares a single TAP fd.

Add the rtap_create() function that:
  - Opens the TAP device with configurable interface name
  - Configures the virtio-net header size
  - Reads the kernel-assigned MAC address
  - Supports the 'persist' option to keep the interface after exit
  - Detaches the keep-alive queue from data traffic

Add rtap_queue_open() and rtap_queue_close() for per-queue fd
management used during queue setup and teardown.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rtap/rtap.h        |   4 +
 drivers/net/rtap/rtap_ethdev.c | 216 ++++++++++++++++++++++++++++++++-
 2 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 507ab000f3..39a3188a7b 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -66,4 +66,8 @@ struct rtap_pmd {
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 };
 
+/* rtap_ethdev.c */
+int rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id);
+void rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id);
+
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index ee5b5bad1b..4e7847ff8d 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -39,13 +39,140 @@ static const char * const valid_arguments[] = {
 	NULL
 };
 
+/* Creates a new tap device, name returned in ifr */
+static int
+rtap_tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
+{
+	static const char tun_dev[] = "/dev/net/tun";
+	int tap_fd;
+
+	tap_fd = open(tun_dev, O_RDWR | O_CLOEXEC | O_NONBLOCK);
+	if (tap_fd < 0) {
+		PMD_LOG_ERRNO(ERR, "Open %s failed", tun_dev);
+		return -1;
+	}
+
+	int features = 0;
+	if (ioctl(tap_fd, TUNGETFEATURES, &features) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNGETFEATURES): %s", tun_dev);
+		goto error;
+	}
+
+	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI | IFF_VNET_HDR;
+	if ((features & flags) != flags) {
+		PMD_LOG(ERR, "TUN features %#x missing support for %#x",
+			features, features & flags);
+		goto error;
+	}
+
+#ifdef IFF_NAPI
+	/* If kernel supports using NAPI enable it */
+	if (features & IFF_NAPI)
+		flags |= IFF_NAPI;
+#endif
+	/*
+	 * Sets the device name and packet format.
+	 * Do not want the protocol information (PI)
+	 */
+	strlcpy(ifr->ifr_name, name, IFNAMSIZ);
+	ifr->ifr_flags = flags;
+	if (ioctl(tap_fd, TUNSETIFF, ifr) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNSETIFF) %s", ifr->ifr_name);
+		goto error;
+	}
+
+	/* (Optional) keep the device after application exit */
+	if (persist && ioctl(tap_fd, TUNSETPERSIST, 1) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNSETPERSIST) %s", ifr->ifr_name);
+		goto error;
+	}
+
+	int hdr_size = sizeof(struct virtio_net_hdr);
+	if (ioctl(tap_fd, TUNSETVNETHDRSZ, &hdr_size) < 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETVNETHDRSZ) %s", strerror(errno));
+		goto error;
+	}
+
+	return tap_fd;
+error:
+	close(tap_fd);
+	return -1;
+}
+
+static int
+rtap_dev_start(struct rte_eth_dev *dev)
+{
+	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
+
+static int
+rtap_dev_stop(struct rte_eth_dev *dev)
+{
+	int *fds = dev->process_private;
+
+	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		for (uint16_t i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++) {
+			if (fds[i] == -1)
+				continue;
+
+			close(fds[i]);
+			fds[i] = -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+rtap_dev_configure(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	/* rx/tx must be paired */
+	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues)
+		return -EINVAL;
+
+	if (ioctl(pmd->keep_fd, TUNSETOFFLOAD, 0) != 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETOFFLOAD) failed: %s", strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 rtap_dev_close(struct rte_eth_dev *dev)
 {
 	struct rtap_pmd *pmd = dev->data->dev_private;
+	int *fds = dev->process_private;
 
 	PMD_LOG(INFO, "Closing %s", pmd->ifname);
 
+	/* Release all io_uring queues (calls rx/tx_queue_release for each) */
+	rte_eth_dev_internal_reset(dev);
+
+	/* Close any remaining queue fds (each process owns its own set) */
+	for (uint16_t i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++) {
+		if (fds[i] == -1)
+			continue;
+		PMD_LOG(DEBUG, "Closed queue %u fd %d", i, fds[i]);
+		close(fds[i]);
+		fds[i] = -1;
+	}
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* mac_addrs must not be freed alone because part of dev_private */
 		dev->data->mac_addrs = NULL;
@@ -63,10 +190,96 @@ rtap_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Setup another fd to TAP device for the queue */
+int
+rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	int *fds = dev->process_private;
+
+	if (fds[queue_id] != -1) {
+		PMD_LOG(DEBUG, "queue %u already has fd %d", queue_id, fds[queue_id]);
+		return 0;	/* already setup */
+	}
+
+	struct ifreq ifr = { 0 };
+	int tap_fd = rtap_tap_open(pmd->ifname, &ifr, 0);
+	if (tap_fd < 0) {
+		PMD_LOG(ERR, "tap_open failed");
+		return -1;
+	}
+
+	PMD_LOG(DEBUG, "Opened %d for queue %u", tap_fd, queue_id);
+	fds[queue_id] = tap_fd;
+	return 0;
+}
+
+void
+rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	int *fds = dev->process_private;
+	int tap_fd = fds[queue_id];
+
+	if (tap_fd == -1)
+		return; /* already closed */
+	PMD_LOG(DEBUG, "Closed queue %u fd %d", queue_id, tap_fd);
+	close(tap_fd);
+	fds[queue_id] = -1;
+}
+
 static const struct eth_dev_ops rtap_ops = {
+	.dev_start		= rtap_dev_start,
+	.dev_stop		= rtap_dev_stop,
+	.dev_configure		= rtap_dev_configure,
 	.dev_close		= rtap_dev_close,
 };
 
+static int
+rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct rtap_pmd *pmd = data->dev_private;
+
+	pmd->keep_fd = -1;
+
+	dev->dev_ops = &rtap_ops;
+
+	/* Get the initial fd used to keep the tap device around */
+	struct ifreq ifr = { 0 };
+	pmd->keep_fd = rtap_tap_open(tap_name, &ifr, persist);
+	if (pmd->keep_fd < 0)
+		goto error;
+
+	PMD_LOG(DEBUG, "Created %s keep_fd %d", ifr.ifr_name, pmd->keep_fd);
+
+	/* Use name returned by kernel i.e if tap_name is rtap%d this will be rtap0 */
+	strlcpy(pmd->ifname, ifr.ifr_name, IFNAMSIZ);
+
+	/* Read the MAC address assigned by the kernel */
+	if (ioctl(pmd->keep_fd, SIOCGIFHWADDR, &ifr) < 0) {
+		PMD_LOG_ERRNO(ERR, "Unable to get MAC address for %s", ifr.ifr_name);
+		goto error;
+	}
+	memcpy(&pmd->eth_addr, &ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	data->mac_addrs = &pmd->eth_addr;
+
+	/* Detach this instance, not used for traffic */
+	ifr.ifr_flags = IFF_DETACH_QUEUE;
+	if (ioctl(pmd->keep_fd, TUNSETQUEUE, &ifr) < 0) {
+		PMD_LOG_ERRNO(ERR, "Unable to detach keep-alive queue for %s", ifr.ifr_name);
+		goto error;
+	}
+
+	PMD_LOG(DEBUG, "%s setup", ifr.ifr_name);
+
+	return 0;
+
+error:
+	if (pmd->keep_fd != -1)
+		close(pmd->keep_fd);
+	return -1;
+}
+
 static int
 rtap_parse_iface(const char *key __rte_unused, const char *value, void *extra_args)
 {
@@ -129,7 +342,8 @@ rtap_probe(struct rte_vdev_device *vdev)
 	eth_dev->process_private = fds;
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
-	RTE_SET_USED(persist); /* used in later patches */
+	if (rtap_create(eth_dev, tap_name, persist) < 0)
+		goto error;
 
 	rte_eth_dev_probing_finish(eth_dev);
 	rte_kvargs_free(kvlist);
-- 
2.51.0

