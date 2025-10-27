Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5F3CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 15:38:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B8CA40609;
	Mon, 27 Oct 2025 16:38:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B33FE402ED
 for <dev@dpdk.org>; Mon, 27 Oct 2025 16:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjpH/7sZu7EHKCUPSFh2Ra8QoIFmmOaux0iQhDfYOAA=;
 b=OtQc3S7ytFEgd/0TKlQ2U8ETOhDRCqUHRTvaTrrJ2iXkguceKrUHi6dTLP30V9Mf3QleVe
 V9VJgBRnn7UysmlBNnWKUhTSSlSRW+U6g50Fxj7wiVLv+NpJmclPkg/+L4DV9p2bX2qpQB
 qw4G5Pqf+GTe/InHwEBGejQE1EsA0B8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-cJDq-DPANdKYjn3LHSKqgw-1; Mon,
 27 Oct 2025 11:38:11 -0400
X-MC-Unique: cJDq-DPANdKYjn3LHSKqgw-1
X-Mimecast-MFC-AGG-ID: cJDq-DPANdKYjn3LHSKqgw_1761579490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 948791809C8C; Mon, 27 Oct 2025 15:38:10 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.145])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C0371800451; Mon, 27 Oct 2025 15:38:08 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk 2/4] net/tap: rename internal ioctl wrapper
Date: Mon, 27 Oct 2025 16:37:53 +0100
Message-ID: <20251027153750.445275-8-rjarry@redhat.com>
In-Reply-To: <20251027153750.445275-6-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ibOuZyScj_zQwfJ1oewFq7rlAtRUaq6l1uoJbvCK_WQ_1761579490
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Prepare to replace ioctl with netlink by renaming enum ioctl_mode to
ctrl_mode and wrapping tap_ioctl with tap_ctrl.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 59 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1bc8ae51cf6b..5b98e381b424 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -117,7 +117,7 @@ tap_trigger_cb(int sig __rte_unused)
 }
 
 /* Specifies on what netdevices the ioctl should be applied */
-enum ioctl_mode {
+enum ctrl_mode {
 	LOCAL_AND_REMOTE,
 	LOCAL_ONLY,
 	REMOTE_ONLY,
@@ -757,7 +757,7 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 }
 
 static const char *
-tap_ioctl_req2str(unsigned long request)
+tap_ctrl_req2str(unsigned long request)
 {
 	switch (request) {
 	case SIOCSIFFLAGS:
@@ -776,7 +776,7 @@ tap_ioctl_req2str(unsigned long request)
 
 static int
 tap_ioctl(struct pmd_internals *pmd, unsigned long request,
-	  struct ifreq *ifr, int set, enum ioctl_mode mode)
+	  struct ifreq *ifr, int set, enum ctrl_mode mode)
 {
 	short req_flags = ifr->ifr_flags;
 	int remote = pmd->remote_if_index &&
@@ -821,10 +821,17 @@ tap_ioctl(struct pmd_internals *pmd, unsigned long request,
 
 error:
 	TAP_LOG(DEBUG, "%s(%s) failed: %s(%d)", ifr->ifr_name,
-		tap_ioctl_req2str(request), strerror(errno), errno);
+		tap_ctrl_req2str(request), strerror(errno), errno);
 	return -errno;
 }
 
+static int
+tap_ctrl(struct pmd_internals *pmd, unsigned long request,
+	 struct ifreq *ifr, int set, enum ctrl_mode mode)
+{
+	return tap_ioctl(pmd, request, ifr, set, mode);
+}
+
 static int
 tap_link_set_down(struct rte_eth_dev *dev)
 {
@@ -832,7 +839,7 @@ tap_link_set_down(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_UP };
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
-	return tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_ONLY);
+	return tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_ONLY);
 }
 
 static int
@@ -842,7 +849,7 @@ tap_link_set_up(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_UP };
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
-	return tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	return tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
 }
 
 static int
@@ -1234,14 +1241,14 @@ tap_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	struct ifreq ifr = { .ifr_flags = 0 };
 
 	if (pmd->remote_if_index) {
-		tap_ioctl(pmd, SIOCGIFFLAGS, &ifr, 0, REMOTE_ONLY);
+		tap_ctrl(pmd, SIOCGIFFLAGS, &ifr, 0, REMOTE_ONLY);
 		if (!(ifr.ifr_flags & IFF_UP) ||
 		    !(ifr.ifr_flags & IFF_RUNNING)) {
 			dev_link->link_status = RTE_ETH_LINK_DOWN;
 			return 0;
 		}
 	}
-	tap_ioctl(pmd, SIOCGIFFLAGS, &ifr, 0, LOCAL_ONLY);
+	tap_ctrl(pmd, SIOCGIFFLAGS, &ifr, 0, LOCAL_ONLY);
 	dev_link->link_status =
 		((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING) ?
 		 RTE_ETH_LINK_UP :
@@ -1256,7 +1263,7 @@ tap_promisc_enable(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_PROMISC };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
 	if (ret != 0)
 		return ret;
 
@@ -1266,7 +1273,7 @@ tap_promisc_enable(struct rte_eth_dev *dev)
 		ret = tap_flow_implicit_create(pmd, TAP_REMOTE_PROMISC);
 		if (ret != 0) {
 			/* Rollback promisc flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+			tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
 			/*
 			 * rte_eth_dev_promiscuous_enable() rollback
 			 * dev->data->promiscuous in the case of failure.
@@ -1285,7 +1292,7 @@ tap_promisc_disable(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_PROMISC };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+	ret = tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
 	if (ret != 0)
 		return ret;
 
@@ -1295,7 +1302,7 @@ tap_promisc_disable(struct rte_eth_dev *dev)
 		ret = tap_flow_implicit_destroy(pmd, TAP_REMOTE_PROMISC);
 		if (ret != 0) {
 			/* Rollback promisc flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+			tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
 			/*
 			 * rte_eth_dev_promiscuous_disable() rollback
 			 * dev->data->promiscuous in the case of failure.
@@ -1315,7 +1322,7 @@ tap_allmulti_enable(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_ALLMULTI };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
 	if (ret != 0)
 		return ret;
 
@@ -1325,7 +1332,7 @@ tap_allmulti_enable(struct rte_eth_dev *dev)
 		ret = tap_flow_implicit_create(pmd, TAP_REMOTE_ALLMULTI);
 		if (ret != 0) {
 			/* Rollback allmulti flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+			tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
 			/*
 			 * rte_eth_dev_allmulticast_enable() rollback
 			 * dev->data->all_multicast in the case of failure.
@@ -1345,7 +1352,7 @@ tap_allmulti_disable(struct rte_eth_dev *dev)
 	struct ifreq ifr = { .ifr_flags = IFF_ALLMULTI };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+	ret = tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
 	if (ret != 0)
 		return ret;
 
@@ -1355,7 +1362,7 @@ tap_allmulti_disable(struct rte_eth_dev *dev)
 		ret = tap_flow_implicit_destroy(pmd, TAP_REMOTE_ALLMULTI);
 		if (ret != 0) {
 			/* Rollback allmulti flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+			tap_ctrl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
 			/*
 			 * rte_eth_dev_allmulticast_disable() rollback
 			 * dev->data->all_multicast in the case of failure.
@@ -1372,7 +1379,7 @@ static int
 tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	enum ioctl_mode mode = LOCAL_ONLY;
+	enum ctrl_mode mode = LOCAL_ONLY;
 	struct ifreq ifr;
 	int ret;
 
@@ -1388,7 +1395,7 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 		return -EINVAL;
 	}
 	/* Check the actual current MAC address on the tap netdevice */
-	ret = tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, LOCAL_ONLY);
+	ret = tap_ctrl(pmd, SIOCGIFHWADDR, &ifr, 0, LOCAL_ONLY);
 	if (ret < 0)
 		return ret;
 	if (rte_is_same_ether_addr(
@@ -1396,7 +1403,7 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 			mac_addr))
 		return 0;
 	/* Check the current MAC address on the remote */
-	ret = tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY);
+	ret = tap_ctrl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY);
 	if (ret < 0)
 		return ret;
 	if (!rte_is_same_ether_addr(
@@ -1406,7 +1413,7 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 	ifr.ifr_hwaddr.sa_family = AF_LOCAL;
 
 	rte_ether_addr_copy(mac_addr, (struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data);
-	ret = tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 1, mode);
+	ret = tap_ctrl(pmd, SIOCSIFHWADDR, &ifr, 1, mode);
 	if (ret < 0)
 		return ret;
 
@@ -1660,7 +1667,7 @@ tap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	struct pmd_internals *pmd = dev->data->dev_private;
 	struct ifreq ifr = { .ifr_mtu = mtu };
 
-	return tap_ioctl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE);
+	return tap_ctrl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE);
 }
 
 static int
@@ -2014,14 +2021,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	TAP_LOG(DEBUG, "allocated %s", pmd->name);
 
 	ifr.ifr_mtu = dev->data->mtu;
-	if (tap_ioctl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE) < 0)
+	if (tap_ctrl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE) < 0)
 		goto error_exit;
 
 	if (pmd->type == ETH_TUNTAP_TYPE_TAP) {
 		memset(&ifr, 0, sizeof(struct ifreq));
 		ifr.ifr_hwaddr.sa_family = AF_LOCAL;
 		rte_ether_addr_copy(&pmd->eth_addr, (struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data);
-		if (tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0)
+		if (tap_ctrl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0)
 			goto error_exit;
 	}
 
@@ -2071,10 +2078,10 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		strlcpy(pmd->remote_iface, remote_iface, RTE_ETH_NAME_MAX_LEN);
 
 		/* Save state of remote device */
-		tap_ioctl(pmd, SIOCGIFFLAGS, &pmd->remote_initial_flags, 0, REMOTE_ONLY);
+		tap_ctrl(pmd, SIOCGIFFLAGS, &pmd->remote_initial_flags, 0, REMOTE_ONLY);
 
 		/* Replicate remote MAC address */
-		if (tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY) < 0) {
+		if (tap_ctrl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY) < 0) {
 			TAP_LOG(ERR, "%s: failed to get %s MAC address.",
 				pmd->name, pmd->remote_iface);
 			goto error_remote;
@@ -2082,7 +2089,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 
 		rte_ether_addr_copy((struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data, &pmd->eth_addr);
 		/* The desired MAC is already in ifreq after SIOCGIFHWADDR. */
-		if (tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0) {
+		if (tap_ctrl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0) {
 			TAP_LOG(ERR, "%s: failed to get %s MAC address.",
 				pmd->name, remote_iface);
 			goto error_remote;
-- 
2.51.0

