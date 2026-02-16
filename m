Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF2E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6BF340A6F;
	Tue, 17 Feb 2026 00:05:04 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 8406A4064E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:05:02 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-436263e31abso3507224f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283102;
 x=1771887902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWbNnZ8Nzzax0S1euyDSaIlyo0Y47R1VAHSrSNiLvQI=;
 b=Jn59iEiSyg9fqdzCDXl0Enhq8zlpAx4jWp7bd2nJ69UNHXf/ev084Fqi8A7xcvQX6F
 23oq4fXhejyvNmr+UEv/YpLll3HTeP0q9DrTNxd4ivKBqLVqoxJdwpiND/oIu5h2DzA5
 cYW4DLxeHLvn5rXe9xrTY8JAL7ANKi67MJ3vAYMRr2AdVMGvoGP4kXK2nyTGdaDd6XpN
 +Xf/itaGgh8svQkZ8eHsq9T1ZSuc7N1IBdYeFQff4SWecW03AMw5eIOW0ZyiGIxBOjJU
 P0BazEjV0A6DgEWI7vrp976/r4NhRS4wr+XSOcVDgFDlGP7MTp4NIf+L1Nq20BwcLXRw
 9A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283102; x=1771887902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wWbNnZ8Nzzax0S1euyDSaIlyo0Y47R1VAHSrSNiLvQI=;
 b=WYosQcQEr08+iWGYzIkLKuSycGOef0Pv/qrPCH+ewlZr3xxLVeM6OoO9E8YNtl1YgI
 Byde8Lqckbx0gPVcpB/pdr2GlS2h4NLD6wsS5qLzrz24i04hpzZNfyadNTkN5UXqHBdR
 D55TJB1bbS4ZPBYsRpvLqBUgA4oK2ntDSmaitv5WynNKEKFZ8xP4r31jyQU21J8LYLnV
 GlttdfskHJLXNch3EQMaEjRVPxHtSwOfI16CejxdQAoVo57MuYCHiE4p3bX2upA26jJK
 7h40Xq9h5ePNyJ1IrDxZz/DoVMR+uxkZqrehp/LfdKHidXesRGIJpcD4YCqdbt/ONQva
 hL7g==
X-Gm-Message-State: AOJu0Yxq5nKUYMwfsx/KkqL/MWTUeGeGiRT9EJ6ntTY+JBqjZVWWwjXf
 KREv9GLF4vkHWKcIPO829wDKpdfwb29cDBz5qnStwbJwESAZF2LMPOxZFMUsfT31NggdmRGwQEn
 fcQMUtvQ=
X-Gm-Gg: AZuq6aLGQsFAPv79Q223BRME62uL+VOU6wmW4qiLbjnaDcPKdtA8ZZbIURRr/1UZXck
 3xPwBUJ0fwiuQ3M0p9YTbVQIjXqjp0m6CdW9kzCZmKmlzfqBXfz+QWk//ord8pXouo91QfcoNys
 yATBCi4AymFAAz+CwdLgCYbFq5fHv2V4cLhbTaePFPaJ58p/s+RLEjomQqRI4+5DBZX3G0l+V9+
 JbHkn70cJTlkFyvlDJzprpJ35nHTUDHh80gLetGP/lKA49+DhO4mm8ZLiaYx/R1dQr5AssADXJM
 HkS2bqTeFsxyrBzIaEGYhEcYuQRwSp3CipbCdoV4HdDQDUw7Tfz+6vwYAWlOrf1YgVlHa3PUeg6
 EmeFNbN8ShqIckkb28VAbFdQ3SC5GilcTnMqAx4l7JnAX6uGZmUTflEuj3jONVeIFBopCfaBzv5
 rdiysEA8kPbN9YvHEvIwE7sv66LHzAldyFWAFFPuJyWuuLfpKXb+5IW7B4AfACGQ==
X-Received: by 2002:a05:6000:310f:b0:437:8fc0:87d3 with SMTP id
 ffacd0b85a97d-43797913ba8mr21586350f8f.35.1771283102010; 
 Mon, 16 Feb 2026 15:05:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:05:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 11/11] net/tap: track device by ifindex instead of name
Date: Mon, 16 Feb 2026 15:02:35 -0800
Message-ID: <20260216230437.847578-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

Remove name and remote_iface strings from pmd_internals.
The interface name can change at any time due to udev or admin
action, making cached names unreliable.

Resolve ifindex once at creation via TUNGETIFF on the keep-alive
fd. For per-queue opens, recover the name on demand with
if_indextoname(). In tap_netns_change(), use TUNGETIFF to get
the current kernel name before resolving the new ifindex,
fixing a bug where a rename during namespace move would lose
the device.

Log messages now use dev->device->name (DPDK vdev name) or
the ifindex, following the pattern established by the rtap PMD.

Bugzilla ID: 1880

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 194 +++++++++++++++++++---------------
 drivers/net/tap/rte_eth_tap.h |   2 -
 2 files changed, 108 insertions(+), 88 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index deb1d72382..f5712055ee 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -130,6 +130,9 @@ static int tap_intr_handle_set(struct rte_eth_dev *dev, int set);
  * @param[in] pmd
  *   Pointer to private structure.
  *
+ * @param[in] ifname
+ *   Name of the TUN/TAP interface to open or create.
+ *
  * @param[in] is_keepalive
  *   Keepalive flag
  *
@@ -140,7 +143,8 @@ static int tap_intr_handle_set(struct rte_eth_dev *dev, int set);
  *   -1 on failure, fd on success
  */
 static int
-tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
+tun_alloc(struct pmd_internals *pmd, const char *ifname,
+	  int is_keepalive, int persistent)
 {
 	struct ifreq ifr;
 #ifdef IFF_MULTI_QUEUE
@@ -157,7 +161,7 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
 		IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);
 
-	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
 	if (fd < 0) {
@@ -199,12 +203,7 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 		goto error;
 	}
 
-	/*
-	 * Name passed to kernel might be wildcard like dtun%d
-	 * and need to find the resulting device.
-	 */
-	TAP_LOG(DEBUG, "Device name is '%s'", ifr.ifr_name);
-	strlcpy(pmd->name, ifr.ifr_name, RTE_ETH_NAME_MAX_LEN);
+	TAP_LOG(DEBUG, "Opened TUN/TAP '%s'", ifr.ifr_name);
 
 	if (is_keepalive) {
 		/*
@@ -879,8 +878,6 @@ tap_dev_stop(struct rte_eth_dev *dev)
 static int
 tap_dev_configure(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *pmd = dev->data->dev_private;
-
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
 		TAP_LOG(ERR,
 			"%s: number of rx queues %d must be equal to number of tx queues %d",
@@ -890,12 +887,6 @@ tap_dev_configure(struct rte_eth_dev *dev)
 		return -1;
 	}
 
-	TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
-		dev->device->name, pmd->name, dev->data->nb_tx_queues);
-
-	TAP_LOG(INFO, "%s: %s: RX configured queues number: %u",
-		dev->device->name, pmd->name, dev->data->nb_rx_queues);
-
 	return 0;
 }
 
@@ -1371,17 +1362,18 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 	return 0;
 }
 
-static int tap_carrier_set(struct pmd_internals *pmd, int carrier)
+static int tap_carrier_set(struct rte_eth_dev *dev, int carrier)
 {
+	struct pmd_internals *pmd = dev->data->dev_private;
 #ifdef TUNSETCARRIER
 	int ret = ioctl(pmd->ka_fd, TUNSETCARRIER, &carrier);
 	if (ret < 0) {
 		TAP_LOG(ERR, "%s: ioctl(TUNSETCARRIER) failed: %s",
-			pmd->name, strerror(errno));
+			dev->device->name, strerror(errno));
 		return ret;
 	}
 #else
-	(void)pmd;
+	(void)dev;
 	(void)carrier;
 #endif
 	return 0;
@@ -1407,9 +1399,9 @@ tap_gso_ctx_setup(struct rte_gso_ctx *gso_ctx, struct rte_eth_dev *dev)
 				dev->device->name);
 		if (ret < 0 || ret >= (int)sizeof(pool_name)) {
 			TAP_LOG(ERR,
-				"%s: failed to create mbuf pool name for device %s,"
+				"%s: failed to create mbuf pool name,"
 				"device name too long or output error, ret: %d",
-				pmd->name, dev->device->name, ret);
+				dev->device->name, ret);
 			return -ENAMETOOLONG;
 		}
 		pmd->gso_ctx_mp = rte_pktmbuf_pool_create(pool_name,
@@ -1418,8 +1410,8 @@ tap_gso_ctx_setup(struct rte_gso_ctx *gso_ctx, struct rte_eth_dev *dev)
 			SOCKET_ID_ANY);
 		if (!pmd->gso_ctx_mp) {
 			TAP_LOG(ERR,
-				"%s: failed to create mbuf pool for device %s",
-				pmd->name, dev->device->name);
+				"%s: failed to create mbuf pool",
+				dev->device->name);
 			return -1;
 		}
 	}
@@ -1450,18 +1442,27 @@ tap_setup_queue(struct rte_eth_dev *dev,
 	fd = process_private->fds[qid];
 	if (fd != -1) {
 		/* fd for this queue already exists */
-		TAP_LOG(DEBUG, "%s: fd %d for %s queue qid %d exists",
-			pmd->name, fd, dir, qid);
+		TAP_LOG(DEBUG, "%s: fd %d for %s queue %d exists",
+			dev->device->name, fd, dir, qid);
 		gso_ctx = NULL;
 	} else {
-		fd = tun_alloc(pmd, 0, 0);
+		char ifname[IFNAMSIZ];
+
+		if (if_indextoname(pmd->if_index, ifname) == NULL) {
+			TAP_LOG(ERR, "%s: ifindex %d not found",
+				dev->device->name, pmd->if_index);
+			return -1;
+		}
+
+		fd = tun_alloc(pmd, ifname, 0, 0);
 		if (fd < 0) {
-			TAP_LOG(ERR, "%s: tun_alloc() failed.", pmd->name);
+			TAP_LOG(ERR, "%s: tun_alloc() failed",
+				dev->device->name);
 			return -1;
 		}
 
-		TAP_LOG(DEBUG, "%s: add %s queue for qid %d fd %d",
-			pmd->name, dir, qid, fd);
+		TAP_LOG(DEBUG, "%s: add %s queue %d fd %d",
+			dev->device->name, dir, qid, fd);
 
 		process_private->fds[qid] = fd;
 	}
@@ -1555,12 +1556,12 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* set carrier after creating at least one rxq */
-	ret = tap_carrier_set(internals, 1);
+	ret = tap_carrier_set(dev, 1);
 	if (ret < 0)
 		goto error;
 
-	TAP_LOG(DEBUG, "  RX TUNTAP device name %s, qid %d on fd %d",
-		internals->name, rx_queue_id,
+	TAP_LOG(DEBUG, "  RX %s qid %d on fd %d",
+		dev->device->name, rx_queue_id,
 		process_private->fds[rx_queue_id]);
 
 	return 0;
@@ -1603,8 +1604,8 @@ tap_tx_queue_setup(struct rte_eth_dev *dev,
 	if (ret == -1)
 		return -1;
 	TAP_LOG(DEBUG,
-		"  TX TUNTAP device name %s, qid %d on fd %d csum %s",
-		internals->name, tx_queue_id,
+		"  TX %s qid %d on fd %d csum %s",
+		dev->device->name, tx_queue_id,
 		process_private->fds[tx_queue_id],
 		txq->csum ? "on" : "off");
 
@@ -1647,40 +1648,46 @@ tap_netns_change(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
 #ifdef TUNGETDEVNETNS
-	int netns_fd, orig_netns_fd, new_nlsk_fd;
+	struct ifreq ifr = { 0 };
+	int netns_fd, orig_netns_fd, new_nlsk_fd, new_ifindex;
 
 	netns_fd = ioctl(pmd->ka_fd, TUNGETDEVNETNS);
 	if (netns_fd < 0) {
-		TAP_LOG(INFO, "%s: interface deleted", pmd->name);
+		TAP_LOG(INFO, "ifindex %d: interface deleted",
+			pmd->if_index);
 		return 0;
 	}
 
-	/* Interface was moved to another namespace */
-	pmd->if_index = 0;
-
 	/* Save current namespace */
 	orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
 	if (orig_netns_fd < 0) {
-		TAP_LOG(ERR, "%s: failed to open original netns: %s",
-			pmd->name, strerror(errno));
+		TAP_LOG(ERR, "ifindex %d: failed to open original netns: %s",
+			pmd->if_index, strerror(errno));
 		close(netns_fd);
 		return -1;
 	}
 
 	/* Switch to new namespace */
 	if (setns(netns_fd, CLONE_NEWNET) < 0) {
-		TAP_LOG(ERR, "%s: failed to enter new netns: %s",
-			pmd->name, strerror(errno));
+		TAP_LOG(ERR, "ifindex %d: failed to enter new netns: %s",
+			pmd->if_index, strerror(errno));
 		close(netns_fd);
 		close(orig_netns_fd);
 		return -1;
 	}
 
 	/*
-	 * Update ifindex by querying interface name.
-	 * The interface now has a new ifindex in the new namespace.
+	 * Get the current name from the TUN fd and resolve to the new
+	 * ifindex. TUNGETIFF always returns the current kernel name
+	 * regardless of any renames.
 	 */
-	pmd->if_index = if_nametoindex(pmd->name);
+	if (ioctl(pmd->ka_fd, TUNGETIFF, &ifr) < 0) {
+		TAP_LOG(ERR, "ifindex %d: TUNGETIFF failed: %s",
+			pmd->if_index, strerror(errno));
+		new_ifindex = 0;
+	} else {
+		new_ifindex = if_nametoindex(ifr.ifr_name);
+	}
 
 	/* Recreate netlink socket in new namespace */
 	new_nlsk_fd = tap_nl_init(0);
@@ -1688,32 +1695,31 @@ tap_netns_change(struct rte_eth_dev *dev)
 	/* Recreate LSC interrupt netlink socket in new namespace */
 	rte_intr_callback_unregister_pending(pmd->intr_handle, tap_dev_intr_handler, dev, NULL);
 	if (tap_lsc_intr_handle_set(dev, 1) < 0)
-		TAP_LOG(WARNING, "%s: failed to recreate LSC interrupt socket",
-			pmd->name);
+		TAP_LOG(WARNING, "ifindex %d: failed to recreate LSC socket",
+			pmd->if_index);
 
 	/* Force carrier back after switching netns */
-	tap_carrier_set(pmd, 1);
+	tap_carrier_set(dev, 1);
 
 	/* Switch back to original namespace */
 	if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
-		TAP_LOG(ERR, "%s: failed to return to original netns: %s",
-			pmd->name, strerror(errno));
+		TAP_LOG(ERR, "ifindex %d: failed to return to original netns: %s",
+			pmd->if_index, strerror(errno));
 
 	close(orig_netns_fd);
 	close(netns_fd);
 
-	if (pmd->if_index == 0) {
-		TAP_LOG(WARNING, "%s: interface moved to another namespace, "
-			"failed to get new ifindex",
-			pmd->name);
+	if (new_ifindex == 0) {
+		TAP_LOG(WARNING, "ifindex %d: moved to new namespace, "
+			"failed to get new ifindex", pmd->if_index);
 		if (new_nlsk_fd >= 0)
 			close(new_nlsk_fd);
 		return -1;
 	}
 
 	if (new_nlsk_fd < 0) {
-		TAP_LOG(WARNING, "%s: failed to recreate netlink socket in new namespace",
-			pmd->name);
+		TAP_LOG(WARNING, "ifindex %d: failed to recreate netlink socket",
+			pmd->if_index);
 		return -1;
 	}
 
@@ -1721,12 +1727,13 @@ tap_netns_change(struct rte_eth_dev *dev)
 	if (pmd->nlsk_fd >= 0)
 		tap_nl_final(pmd->nlsk_fd);
 	pmd->nlsk_fd = new_nlsk_fd;
+	pmd->if_index = new_ifindex;
 
-	TAP_LOG(INFO, "%s: interface moved to another namespace, new ifindex: %u",
-		pmd->name, pmd->if_index);
+	TAP_LOG(INFO, "interface moved to new namespace, new ifindex: %u",
+		pmd->if_index);
 #else
-	TAP_LOG(WARNING, "%s: interface deleted or moved to another namespace",
-		pmd->name);
+	TAP_LOG(WARNING, "ifindex %d: interface deleted or moved",
+		pmd->if_index);
 #endif
 
 	return 0;
@@ -2017,7 +2024,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	pmd = dev->data->dev_private;
 	dev->process_private = process_private;
 	pmd->dev = dev;
-	strlcpy(pmd->name, tap_name, sizeof(pmd->name));
 	pmd->type = type;
 	pmd->ka_fd = -1;
 	pmd->nlsk_fd = -1;
@@ -2069,12 +2075,34 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	 * This keep-alive file descriptor will guarantee that the TUN device
 	 * exists even when all of its queues are closed
 	 */
-	pmd->ka_fd = tun_alloc(pmd, 1, persist);
+	pmd->ka_fd = tun_alloc(pmd, tap_name, 1, persist);
 	if (pmd->ka_fd == -1) {
 		TAP_LOG(ERR, "Unable to create %s interface", tuntap_name);
 		goto error_exit;
 	}
-	TAP_LOG(DEBUG, "allocated %s", pmd->name);
+
+	/*
+	 * Get the kernel-assigned name from the TUN fd and resolve the
+	 * ifindex. From this point on, the device is tracked by ifindex
+	 * which is stable even if the interface is renamed.
+	 */
+	{
+		struct ifreq ifr = { 0 };
+
+		if (ioctl(pmd->ka_fd, TUNGETIFF, &ifr) < 0) {
+			TAP_LOG(ERR, "Unable to get interface name: %s",
+				strerror(errno));
+			goto error_exit;
+		}
+		pmd->if_index = if_nametoindex(ifr.ifr_name);
+		if (pmd->if_index == 0) {
+			TAP_LOG(ERR, "Unable to get ifindex for '%s'",
+				ifr.ifr_name);
+			goto error_exit;
+		}
+		TAP_LOG(DEBUG, "Created '%s' ifindex %d",
+			ifr.ifr_name, pmd->if_index);
+	}
 
 	/*
 	 * Create netlink socket for interface control.
@@ -2082,13 +2110,8 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	 */
 	pmd->nlsk_fd = tap_nl_init(0);
 	if (pmd->nlsk_fd == -1) {
-		TAP_LOG(ERR, "%s: failed to create netlink socket.", pmd->name);
-		goto error_exit;
-	}
-
-	pmd->if_index = if_nametoindex(pmd->name);
-	if (!pmd->if_index) {
-		TAP_LOG(ERR, "%s: failed to get if_index.", pmd->name);
+		TAP_LOG(ERR, "ifindex %d: failed to create netlink socket",
+			pmd->if_index);
 		goto error_exit;
 	}
 
@@ -2111,13 +2134,13 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	 * - implicit rules
 	 */
 	if (qdisc_create_multiq(pmd->nlsk_fd, pmd->if_index) < 0) {
-		TAP_LOG(ERR, "%s: failed to create multiq qdisc.",
-			pmd->name);
+		TAP_LOG(ERR, "ifindex %d: failed to create multiq qdisc",
+			pmd->if_index);
 		goto disable_rte_flow;
 	}
 	if (qdisc_create_ingress(pmd->nlsk_fd, pmd->if_index) < 0) {
-		TAP_LOG(ERR, "%s: failed to create ingress qdisc.",
-			pmd->name);
+		TAP_LOG(ERR, "ifindex %d: failed to create ingress qdisc",
+			pmd->if_index);
 		goto disable_rte_flow;
 	}
 
@@ -2126,11 +2149,10 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	if (strlen(remote_iface)) {
 		pmd->remote_if_index = if_nametoindex(remote_iface);
 		if (!pmd->remote_if_index) {
-			TAP_LOG(ERR, "%s: failed to get %s if_index.",
-				pmd->name, remote_iface);
+			TAP_LOG(ERR, "ifindex %d: failed to get ifindex for remote '%s'",
+				pmd->if_index, remote_iface);
 			goto error_remote;
 		}
-		strlcpy(pmd->remote_iface, remote_iface, RTE_ETH_NAME_MAX_LEN);
 
 		/* Save state of remote device */
 		if (tap_nl_get_flags(pmd->nlsk_fd, pmd->remote_if_index,
@@ -2139,14 +2161,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 
 		/* Replicate remote MAC address */
 		if (tap_nl_get_mac(pmd->nlsk_fd, pmd->remote_if_index, &pmd->eth_addr) < 0) {
-			TAP_LOG(ERR, "%s: failed to get %s MAC address.",
-				pmd->name, pmd->remote_iface);
+			TAP_LOG(ERR, "ifindex %d: failed to get remote MAC",
+				pmd->if_index);
 			goto error_remote;
 		}
 
 		if (tap_nl_set_mac(pmd->nlsk_fd, pmd->if_index, &pmd->eth_addr) < 0) {
-			TAP_LOG(ERR, "%s: failed to set %s MAC address.",
-				pmd->name, remote_iface);
+			TAP_LOG(ERR, "ifindex %d: failed to set local MAC",
+				pmd->if_index);
 			goto error_remote;
 		}
 
@@ -2158,8 +2180,8 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		qdisc_flush(pmd->nlsk_fd, pmd->remote_if_index);
 		if (qdisc_create_ingress(pmd->nlsk_fd,
 					 pmd->remote_if_index) < 0) {
-			TAP_LOG(ERR, "%s: failed to create ingress qdisc.",
-				pmd->remote_iface);
+			TAP_LOG(ERR, "remote ifindex %d: failed to create ingress qdisc",
+				pmd->remote_if_index);
 			goto error_remote;
 		}
 		LIST_INIT(&pmd->implicit_flows);
@@ -2168,8 +2190,8 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		    tap_flow_implicit_create(pmd, TAP_REMOTE_BROADCAST) < 0 ||
 		    tap_flow_implicit_create(pmd, TAP_REMOTE_BROADCASTV6) < 0) {
 			TAP_LOG(ERR,
-				"%s: failed to create implicit rules.",
-				pmd->name);
+				"ifindex %d: failed to create implicit rules",
+				pmd->if_index);
 			goto error_remote;
 		}
 	}
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 218ee1b811..74ad0b9253 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -68,8 +68,6 @@ struct tx_queue {
 
 struct pmd_internals {
 	struct rte_eth_dev *dev;          /* Ethernet device. */
-	char remote_iface[RTE_ETH_NAME_MAX_LEN]; /* Remote netdevice name */
-	char name[RTE_ETH_NAME_MAX_LEN];  /* Internal Tap device name */
 	int type;                         /* Type field - TUN|TAP */
 	int persist;			  /* 1 if keep link up, else 0 */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
-- 
2.51.0

