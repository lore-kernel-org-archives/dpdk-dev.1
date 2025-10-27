Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B7CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 18:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C56714066F;
	Mon, 27 Oct 2025 19:19:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F4214066B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 19:19:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761589193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL1PgUURPbTXsRdDEDTSHat/EVEPFfRJvnbB+AR5iXU=;
 b=gVTVmguLHy7ISrMFM8fRKXwu+8y54AMM/LN/R6/KVOlADZ7YttklZtqLVQxDYZ4O+a25q+
 48tVN411Zn6RJO1UZjm7gCwakL5gtFjVn82N0R0EfSCwz9Z5NllhSaAtw91MYPa8KQTyeK
 YK7Qg+3BpmHilMTHJ8xcJYZSr2PLmh4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-h4l93_txOguJIBcyKltorQ-1; Mon,
 27 Oct 2025 14:19:51 -0400
X-MC-Unique: h4l93_txOguJIBcyKltorQ-1
X-Mimecast-MFC-AGG-ID: h4l93_txOguJIBcyKltorQ_1761589190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B310119541B7; Mon, 27 Oct 2025 18:19:50 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E052D1955F1B; Mon, 27 Oct 2025 18:19:48 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v2 2/3] net/tap: replace ioctl with netlink
Date: Mon, 27 Oct 2025 19:19:29 +0100
Message-ID: <20251027181926.489642-7-rjarry@redhat.com>
In-Reply-To: <20251027181926.489642-5-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027181926.489642-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uQSaFS9zTmXENjwp4kUJkdvHxmuJ90s8g5K8ZXfVw7E_1761589190
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

Remove ioctl-based link control implementation. All interface operations
now use netlink exclusively via direct tap_nl_* calls.

Remove tap_ctrl/tap_nl_ctrl wrapper functions, enum ctrl_mode, and
ioctl_sock field. Make netlink socket mandatory - driver fails if
netlink is unavailable.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 298 ++++++++++++++--------------------
 drivers/net/tap/rte_eth_tap.h |   5 +-
 2 files changed, 124 insertions(+), 179 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1bc8ae51cf6b..e006c71989a8 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -22,9 +22,7 @@
 #include <assert.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/socket.h>
 #include <sys/ioctl.h>
-#include <sys/utsname.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <signal.h>
@@ -33,12 +31,9 @@
 #include <stdlib.h>
 #include <sys/uio.h>
 #include <unistd.h>
-#include <arpa/inet.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
-#include <linux/if_ether.h>
 #include <fcntl.h>
-#include <ctype.h>
 
 #include <tap_rss.h>
 #include <rte_eth_tap.h>
@@ -116,13 +111,6 @@ tap_trigger_cb(int sig __rte_unused)
 	tap_trigger = (tap_trigger + 1) | 0x80000000;
 }
 
-/* Specifies on what netdevices the ioctl should be applied */
-enum ioctl_mode {
-	LOCAL_AND_REMOTE,
-	LOCAL_ONLY,
-	REMOTE_ONLY,
-};
-
 /* Message header to synchronize queues via IPC */
 struct ipc_queues {
 	char port_name[RTE_DEV_NAME_MAX_LEN];
@@ -756,93 +744,28 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_tx;
 }
 
-static const char *
-tap_ioctl_req2str(unsigned long request)
-{
-	switch (request) {
-	case SIOCSIFFLAGS:
-		return "SIOCSIFFLAGS";
-	case SIOCGIFFLAGS:
-		return "SIOCGIFFLAGS";
-	case SIOCGIFHWADDR:
-		return "SIOCGIFHWADDR";
-	case SIOCSIFHWADDR:
-		return "SIOCSIFHWADDR";
-	case SIOCSIFMTU:
-		return "SIOCSIFMTU";
-	}
-	return "UNKNOWN";
-}
-
-static int
-tap_ioctl(struct pmd_internals *pmd, unsigned long request,
-	  struct ifreq *ifr, int set, enum ioctl_mode mode)
-{
-	short req_flags = ifr->ifr_flags;
-	int remote = pmd->remote_if_index &&
-		(mode == REMOTE_ONLY || mode == LOCAL_AND_REMOTE);
-
-	if (!pmd->remote_if_index && mode == REMOTE_ONLY)
-		return 0;
-	/*
-	 * If there is a remote netdevice, apply ioctl on it, then apply it on
-	 * the tap netdevice.
-	 */
-apply:
-	if (remote)
-		strlcpy(ifr->ifr_name, pmd->remote_iface, IFNAMSIZ);
-	else if (mode == LOCAL_ONLY || mode == LOCAL_AND_REMOTE)
-		strlcpy(ifr->ifr_name, pmd->name, IFNAMSIZ);
-	switch (request) {
-	case SIOCSIFFLAGS:
-		/* fetch current flags to leave other flags untouched */
-		if (ioctl(pmd->ioctl_sock, SIOCGIFFLAGS, ifr) < 0)
-			goto error;
-		if (set)
-			ifr->ifr_flags |= req_flags;
-		else
-			ifr->ifr_flags &= ~req_flags;
-		break;
-	case SIOCGIFFLAGS:
-	case SIOCGIFHWADDR:
-	case SIOCSIFHWADDR:
-	case SIOCSIFMTU:
-		break;
-	default:
-		TAP_LOG(WARNING, "%s: ioctl() called with wrong arg",
-			pmd->name);
-		return -EINVAL;
-	}
-	if (ioctl(pmd->ioctl_sock, request, ifr) < 0)
-		goto error;
-	if (remote-- && mode == LOCAL_AND_REMOTE)
-		goto apply;
-	return 0;
-
-error:
-	TAP_LOG(DEBUG, "%s(%s) failed: %s(%d)", ifr->ifr_name,
-		tap_ioctl_req2str(request), strerror(errno), errno);
-	return -errno;
-}
-
 static int
 tap_link_set_down(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_UP };
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
-	return tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_ONLY);
+	return tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_UP, 0);
 }
 
 static int
 tap_link_set_up(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_UP };
+	int ret;
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
-	return tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_UP, 1);
+	if (ret < 0)
+		return ret;
+	if (pmd->remote_if_index)
+		return tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index, IFF_UP, 1);
+	return 0;
 }
 
 static int
@@ -1131,8 +1054,6 @@ tap_dev_close(struct rte_eth_dev *dev)
 	if (internals->nlsk_fd != -1) {
 		tap_flow_flush(dev, NULL);
 		tap_flow_implicit_flush(internals, NULL);
-		tap_nl_final(internals->nlsk_fd);
-		internals->nlsk_fd = -1;
 		tap_flow_bpf_destroy(internals);
 	}
 #endif
@@ -1150,11 +1071,10 @@ tap_dev_close(struct rte_eth_dev *dev)
 
 	if (internals->remote_if_index) {
 		/* Restore initial remote state */
-		int ret = ioctl(internals->ioctl_sock, SIOCSIFFLAGS,
-				&internals->remote_initial_flags);
+		int ret = tap_nl_set_flags(internals->nlsk_fd, internals->remote_if_index,
+					   internals->remote_initial_flags, 1);
 		if (ret)
 			TAP_LOG(ERR, "restore remote state failed: %d", ret);
-
 	}
 
 	rte_mempool_free(internals->gso_ctx_mp);
@@ -1174,9 +1094,9 @@ tap_dev_close(struct rte_eth_dev *dev)
 
 	rte_intr_instance_free(internals->intr_handle);
 
-	if (internals->ioctl_sock != -1) {
-		close(internals->ioctl_sock);
-		internals->ioctl_sock = -1;
+	if (internals->nlsk_fd != -1) {
+		tap_nl_final(internals->nlsk_fd);
+		internals->nlsk_fd = -1;
 	}
 	free(dev->process_private);
 	dev->process_private = NULL;
@@ -1231,21 +1151,22 @@ tap_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
 	struct rte_eth_link *dev_link = &dev->data->dev_link;
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = 0 };
+	unsigned int flags = 0;
 
 	if (pmd->remote_if_index) {
-		tap_ioctl(pmd, SIOCGIFFLAGS, &ifr, 0, REMOTE_ONLY);
-		if (!(ifr.ifr_flags & IFF_UP) ||
-		    !(ifr.ifr_flags & IFF_RUNNING)) {
-			dev_link->link_status = RTE_ETH_LINK_DOWN;
-			return 0;
+		if (tap_nl_get_flags(pmd->nlsk_fd, pmd->remote_if_index, &flags) == 0) {
+			if (!(flags & IFF_UP) || !(flags & IFF_RUNNING)) {
+				dev_link->link_status = RTE_ETH_LINK_DOWN;
+				return 0;
+			}
 		}
 	}
-	tap_ioctl(pmd, SIOCGIFFLAGS, &ifr, 0, LOCAL_ONLY);
-	dev_link->link_status =
-		((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING) ?
-		 RTE_ETH_LINK_UP :
-		 RTE_ETH_LINK_DOWN);
+	if (tap_nl_get_flags(pmd->nlsk_fd, pmd->if_index, &flags) == 0) {
+		if ((flags & IFF_UP) && (flags & IFF_RUNNING))
+			dev_link->link_status = RTE_ETH_LINK_UP;
+		else
+			dev_link->link_status = RTE_ETH_LINK_DOWN;
+	}
 	return 0;
 }
 
@@ -1253,20 +1174,28 @@ static int
 tap_promisc_enable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_PROMISC };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_PROMISC, 1);
 	if (ret != 0)
 		return ret;
 
+	if (pmd->remote_if_index) {
+		ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index, IFF_PROMISC, 1);
+		if (ret != 0)
+			return ret;
+	}
+
 #ifdef HAVE_TCA_FLOWER
 	if (pmd->remote_if_index && !pmd->flow_isolate) {
 		dev->data->promiscuous = 1;
 		ret = tap_flow_implicit_create(pmd, TAP_REMOTE_PROMISC);
 		if (ret != 0) {
 			/* Rollback promisc flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+			tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_PROMISC, 0);
+			if (pmd->remote_if_index)
+				tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index,
+						 IFF_PROMISC, 0);
 			/*
 			 * rte_eth_dev_promiscuous_enable() rollback
 			 * dev->data->promiscuous in the case of failure.
@@ -1282,20 +1211,28 @@ static int
 tap_promisc_disable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_PROMISC };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_PROMISC, 0);
 	if (ret != 0)
 		return ret;
 
+	if (pmd->remote_if_index) {
+		ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index, IFF_PROMISC, 0);
+		if (ret != 0)
+			return ret;
+	}
+
 #ifdef HAVE_TCA_FLOWER
 	if (pmd->remote_if_index && !pmd->flow_isolate) {
 		dev->data->promiscuous = 0;
 		ret = tap_flow_implicit_destroy(pmd, TAP_REMOTE_PROMISC);
 		if (ret != 0) {
 			/* Rollback promisc flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+			tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_PROMISC, 1);
+			if (pmd->remote_if_index)
+				tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index,
+						 IFF_PROMISC, 1);
 			/*
 			 * rte_eth_dev_promiscuous_disable() rollback
 			 * dev->data->promiscuous in the case of failure.
@@ -1312,20 +1249,28 @@ static int
 tap_allmulti_enable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_ALLMULTI };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_ALLMULTI, 1);
 	if (ret != 0)
 		return ret;
 
+	if (pmd->remote_if_index) {
+		ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index, IFF_ALLMULTI, 1);
+		if (ret != 0)
+			return ret;
+	}
+
 #ifdef HAVE_TCA_FLOWER
 	if (pmd->remote_if_index && !pmd->flow_isolate) {
 		dev->data->all_multicast = 1;
 		ret = tap_flow_implicit_create(pmd, TAP_REMOTE_ALLMULTI);
 		if (ret != 0) {
 			/* Rollback allmulti flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+			tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_ALLMULTI, 0);
+			if (pmd->remote_if_index)
+				tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index,
+						 IFF_ALLMULTI, 0);
 			/*
 			 * rte_eth_dev_allmulticast_enable() rollback
 			 * dev->data->all_multicast in the case of failure.
@@ -1342,20 +1287,28 @@ static int
 tap_allmulti_disable(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_flags = IFF_ALLMULTI };
 	int ret;
 
-	ret = tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 0, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_ALLMULTI, 0);
 	if (ret != 0)
 		return ret;
 
+	if (pmd->remote_if_index) {
+		ret = tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index, IFF_ALLMULTI, 0);
+		if (ret != 0)
+			return ret;
+	}
+
 #ifdef HAVE_TCA_FLOWER
 	if (pmd->remote_if_index && !pmd->flow_isolate) {
 		dev->data->all_multicast = 0;
 		ret = tap_flow_implicit_destroy(pmd, TAP_REMOTE_ALLMULTI);
 		if (ret != 0) {
 			/* Rollback allmulti flag */
-			tap_ioctl(pmd, SIOCSIFFLAGS, &ifr, 1, LOCAL_AND_REMOTE);
+			tap_nl_set_flags(pmd->nlsk_fd, pmd->if_index, IFF_ALLMULTI, 1);
+			if (pmd->remote_if_index)
+				tap_nl_set_flags(pmd->nlsk_fd, pmd->remote_if_index,
+						 IFF_ALLMULTI, 1);
 			/*
 			 * rte_eth_dev_allmulticast_disable() rollback
 			 * dev->data->all_multicast in the case of failure.
@@ -1372,8 +1325,8 @@ static int
 tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	enum ioctl_mode mode = LOCAL_ONLY;
-	struct ifreq ifr;
+	struct rte_ether_addr current_mac;
+	bool set_remote = false;
 	int ret;
 
 	if (pmd->type == ETH_TUNTAP_TYPE_TUN) {
@@ -1388,28 +1341,31 @@ tap_mac_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 		return -EINVAL;
 	}
 	/* Check the actual current MAC address on the tap netdevice */
-	ret = tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, LOCAL_ONLY);
+	ret = tap_nl_get_mac(pmd->nlsk_fd, pmd->if_index, &current_mac);
 	if (ret < 0)
 		return ret;
-	if (rte_is_same_ether_addr(
-			(struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data,
-			mac_addr))
+	if (rte_is_same_ether_addr(&current_mac, mac_addr))
 		return 0;
-	/* Check the current MAC address on the remote */
-	ret = tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY);
-	if (ret < 0)
-		return ret;
-	if (!rte_is_same_ether_addr(
-			(struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data,
-			mac_addr))
-		mode = LOCAL_AND_REMOTE;
-	ifr.ifr_hwaddr.sa_family = AF_LOCAL;
 
-	rte_ether_addr_copy(mac_addr, (struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data);
-	ret = tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 1, mode);
+	/* Check the current MAC address on the remote */
+	if (pmd->remote_if_index) {
+		ret = tap_nl_get_mac(pmd->nlsk_fd, pmd->remote_if_index, &current_mac);
+		if (ret < 0)
+			return ret;
+		if (!rte_is_same_ether_addr(&current_mac, mac_addr))
+			set_remote = true;
+	}
+
+	ret = tap_nl_set_mac(pmd->nlsk_fd, pmd->if_index, mac_addr);
 	if (ret < 0)
 		return ret;
 
+	if (set_remote) {
+		ret = tap_nl_set_mac(pmd->nlsk_fd, pmd->remote_if_index, mac_addr);
+		if (ret < 0)
+			return ret;
+	}
+
 	rte_ether_addr_copy(mac_addr, &pmd->eth_addr);
 
 #ifdef HAVE_TCA_FLOWER
@@ -1658,9 +1614,16 @@ static int
 tap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { .ifr_mtu = mtu };
+	int ret;
 
-	return tap_ioctl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE);
+	ret = tap_nl_set_mtu(pmd->nlsk_fd, pmd->if_index, mtu);
+	if (ret < 0)
+		return ret;
+
+	if (pmd->remote_if_index)
+		return tap_nl_set_mtu(pmd->nlsk_fd, pmd->remote_if_index, mtu);
+
+	return 0;
 }
 
 static int
@@ -1921,7 +1884,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	struct pmd_process_private *process_private;
 	const char *tuntap_name = tuntap_types[type];
 	struct rte_eth_dev_data *data;
-	struct ifreq ifr;
 	int i;
 
 	TAP_LOG(DEBUG, "%s device on numa %u", tuntap_name, rte_socket_id());
@@ -1946,20 +1908,9 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	strlcpy(pmd->name, tap_name, sizeof(pmd->name));
 	pmd->type = type;
 	pmd->ka_fd = -1;
-
-#ifdef HAVE_TCA_FLOWER
 	pmd->nlsk_fd = -1;
-#endif
 	pmd->gso_ctx_mp = NULL;
 
-	pmd->ioctl_sock = socket(AF_INET, SOCK_DGRAM, 0);
-	if (pmd->ioctl_sock == -1) {
-		TAP_LOG(ERR,
-			"%s Unable to get a socket for management: %s",
-			tuntap_name, strerror(errno));
-		goto error_exit;
-	}
-
 	/* Allocate interrupt instance */
 	pmd->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
 	if (pmd->intr_handle == NULL) {
@@ -2013,15 +1964,27 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	}
 	TAP_LOG(DEBUG, "allocated %s", pmd->name);
 
-	ifr.ifr_mtu = dev->data->mtu;
-	if (tap_ioctl(pmd, SIOCSIFMTU, &ifr, 1, LOCAL_AND_REMOTE) < 0)
+	/*
+	 * Create netlink socket for interface control.
+	 * Netlink provides ifindex-based operations and is namespace-safe.
+	 */
+	pmd->nlsk_fd = tap_nl_init(0);
+	if (pmd->nlsk_fd == -1) {
+		TAP_LOG(ERR, "%s: failed to create netlink socket.", pmd->name);
+		goto error_exit;
+	}
+
+	pmd->if_index = if_nametoindex(pmd->name);
+	if (!pmd->if_index) {
+		TAP_LOG(ERR, "%s: failed to get if_index.", pmd->name);
+		goto error_exit;
+	}
+
+	if (tap_nl_set_mtu(pmd->nlsk_fd, pmd->if_index, dev->data->mtu) < 0)
 		goto error_exit;
 
 	if (pmd->type == ETH_TUNTAP_TYPE_TAP) {
-		memset(&ifr, 0, sizeof(struct ifreq));
-		ifr.ifr_hwaddr.sa_family = AF_LOCAL;
-		rte_ether_addr_copy(&pmd->eth_addr, (struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data);
-		if (tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0)
+		if (tap_nl_set_mac(pmd->nlsk_fd, pmd->if_index, &pmd->eth_addr) < 0)
 			goto error_exit;
 	}
 
@@ -2031,23 +1994,10 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 #ifdef HAVE_TCA_FLOWER
 	/*
 	 * Set up everything related to rte_flow:
-	 * - netlink socket
-	 * - tap / remote if_index
 	 * - mandatory QDISCs
 	 * - rte_flow actual/implicit lists
 	 * - implicit rules
 	 */
-	pmd->nlsk_fd = tap_nl_init(0);
-	if (pmd->nlsk_fd == -1) {
-		TAP_LOG(WARNING, "%s: failed to create netlink socket.",
-			pmd->name);
-		goto disable_rte_flow;
-	}
-	pmd->if_index = if_nametoindex(pmd->name);
-	if (!pmd->if_index) {
-		TAP_LOG(ERR, "%s: failed to get if_index.", pmd->name);
-		goto disable_rte_flow;
-	}
 	if (qdisc_create_multiq(pmd->nlsk_fd, pmd->if_index) < 0) {
 		TAP_LOG(ERR, "%s: failed to create multiq qdisc.",
 			pmd->name);
@@ -2071,19 +2021,19 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		strlcpy(pmd->remote_iface, remote_iface, RTE_ETH_NAME_MAX_LEN);
 
 		/* Save state of remote device */
-		tap_ioctl(pmd, SIOCGIFFLAGS, &pmd->remote_initial_flags, 0, REMOTE_ONLY);
+		if (tap_nl_get_flags(pmd->nlsk_fd, pmd->remote_if_index,
+					  &pmd->remote_initial_flags) < 0)
+			pmd->remote_initial_flags = 0;
 
 		/* Replicate remote MAC address */
-		if (tap_ioctl(pmd, SIOCGIFHWADDR, &ifr, 0, REMOTE_ONLY) < 0) {
+		if (tap_nl_get_mac(pmd->nlsk_fd, pmd->remote_if_index, &pmd->eth_addr) < 0) {
 			TAP_LOG(ERR, "%s: failed to get %s MAC address.",
 				pmd->name, pmd->remote_iface);
 			goto error_remote;
 		}
 
-		rte_ether_addr_copy((struct rte_ether_addr *)&ifr.ifr_hwaddr.sa_data, &pmd->eth_addr);
-		/* The desired MAC is already in ifreq after SIOCGIFHWADDR. */
-		if (tap_ioctl(pmd, SIOCSIFHWADDR, &ifr, 0, LOCAL_ONLY) < 0) {
-			TAP_LOG(ERR, "%s: failed to get %s MAC address.",
+		if (tap_nl_set_mac(pmd->nlsk_fd, pmd->if_index, &pmd->eth_addr) < 0) {
+			TAP_LOG(ERR, "%s: failed to set %s MAC address.",
 				pmd->name, remote_iface);
 			goto error_remote;
 		}
@@ -2134,14 +2084,10 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 #endif
 
 error_exit:
-#ifdef HAVE_TCA_FLOWER
 	if (pmd->nlsk_fd != -1)
 		close(pmd->nlsk_fd);
-#endif
 	if (pmd->ka_fd != -1)
 		close(pmd->ka_fd);
-	if (pmd->ioctl_sock != -1)
-		close(pmd->ioctl_sock);
 	/* mac_addrs must not be freed alone because part of dev_private */
 	dev->data->mac_addrs = NULL;
 	rte_intr_instance_free(pmd->intr_handle);
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index ce4322ad046e..218ee1b811d8 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -73,13 +73,12 @@ struct pmd_internals {
 	int type;                         /* Type field - TUN|TAP */
 	int persist;			  /* 1 if keep link up, else 0 */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
-	struct ifreq remote_initial_flags;/* Remote netdevice flags on init */
+	unsigned int remote_initial_flags;/* Remote netdevice flags on init */
 	int remote_if_index;              /* remote netdevice IF_INDEX */
 	int if_index;                     /* IF_INDEX for the port */
-	int ioctl_sock;                   /* socket for ioctl calls */
+	int nlsk_fd;                      /* Netlink socket fd */
 
 #ifdef HAVE_TCA_FLOWER
-	int nlsk_fd;                      /* Netlink socket fd */
 	int flow_isolate;                 /* 1 if flow isolation is enabled */
 
 	struct tap_rss *rss;		  /* BPF program */
-- 
2.51.0

