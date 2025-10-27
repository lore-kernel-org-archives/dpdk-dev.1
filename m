Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C7CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 15:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 826D240647;
	Mon, 27 Oct 2025 16:38:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D0E740611
 for <dev@dpdk.org>; Mon, 27 Oct 2025 16:38:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Du5ly1lOBx1mfl9DYeBIxWJ7W4E5SXM26Rrxq3J4Jwk=;
 b=OIw0eJHMWHTBf2TSjapt+c/lVzv0rVeF7bCrRIJ/t+Uk+4ej9eSjrZRxTIkeVeU4g7eEhI
 2qnNUROFxnqVgZA7qHo90shMFgveLA/9Z68zx4F1lM+JA5PnM+Fecv/0rVeFbrqLGLjbne
 wPkzXLVs0kJD1p09GnlbENLpPTt44Ck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-dFbnA054NByc5_XQHjDe5g-1; Mon,
 27 Oct 2025 11:38:13 -0400
X-MC-Unique: dFbnA054NByc5_XQHjDe5g-1
X-Mimecast-MFC-AGG-ID: dFbnA054NByc5_XQHjDe5g_1761579492
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0F42180066C; Mon, 27 Oct 2025 15:38:12 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.145])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65218180035A; Mon, 27 Oct 2025 15:38:10 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk 3/4] net/tap: use netlink if possible
Date: Mon, 27 Oct 2025 16:37:54 +0100
Message-ID: <20251027153750.445275-9-rjarry@redhat.com>
In-Reply-To: <20251027153750.445275-6-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yyIIP9-bzWX_NEDiAupicgf8XXqQlns7jmO1-Wgp4w4_1761579492
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

Make netlink socket available unconditionally, not just for rte_flow.

Use netlink for get/set operations on link flags, MAC, and MTU when
available. Fall back to ioctl if netlink socket creation fails.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 143 ++++++++++++++++++++++++++++------
 drivers/net/tap/rte_eth_tap.h |   2 +-
 2 files changed, 122 insertions(+), 23 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 5b98e381b424..b53c85746056 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -774,6 +774,89 @@ tap_ctrl_req2str(unsigned long request)
 	return "UNKNOWN";
 }
 
+static int
+tap_nl_ctrl(struct pmd_internals *pmd, unsigned long request,
+	    struct ifreq *ifr, int set, enum ctrl_mode mode)
+{
+	bool remote = pmd->remote_if_index && (mode == REMOTE_ONLY || mode == LOCAL_AND_REMOTE);
+	struct rte_ether_addr *mac;
+	int ret = 0;
+
+	switch (request) {
+	case SIOCSIFFLAGS:
+		if (mode == LOCAL_ONLY || mode == LOCAL_AND_REMOTE) {
+			ret = tap_nl_set_link_flags(pmd->nlsk_fd, pmd->if_index,
+						    ifr->ifr_flags, set);
+			if (ret < 0)
+				return ret;
+		}
+		if (remote)
+			ret = tap_nl_set_link_flags(pmd->nlsk_fd, pmd->remote_if_index,
+						    ifr->ifr_flags, set);
+		break;
+
+	case SIOCGIFFLAGS:
+		if (mode == REMOTE_ONLY && pmd->remote_if_index) {
+			unsigned int flags = 0;
+			ret = tap_nl_get_link_flags(pmd->nlsk_fd, pmd->remote_if_index, &flags);
+			if (ret == 0)
+				ifr->ifr_flags = flags;
+		} else {
+			unsigned int flags = 0;
+			ret = tap_nl_get_link_flags(pmd->nlsk_fd, pmd->if_index, &flags);
+			if (ret == 0)
+				ifr->ifr_flags = flags;
+		}
+		break;
+
+	case SIOCGIFHWADDR:
+		mac = (struct rte_ether_addr *)ifr->ifr_hwaddr.sa_data;
+		if (mode == REMOTE_ONLY && pmd->remote_if_index) {
+			ret = tap_nl_get_link_mac(pmd->nlsk_fd, pmd->remote_if_index, mac);
+			if (ret == 0)
+				ifr->ifr_hwaddr.sa_family = AF_LOCAL;
+		} else {
+			ret = tap_nl_get_link_mac(pmd->nlsk_fd, pmd->if_index, mac);
+			if (ret == 0)
+				ifr->ifr_hwaddr.sa_family = AF_LOCAL;
+		}
+		break;
+
+	case SIOCSIFHWADDR:
+		mac = (struct rte_ether_addr *)ifr->ifr_hwaddr.sa_data;
+		if (mode == LOCAL_ONLY || mode == LOCAL_AND_REMOTE) {
+			ret = tap_nl_set_link_mac(pmd->nlsk_fd, pmd->if_index, mac);
+			if (ret < 0)
+				return ret;
+		}
+		if (remote)
+			ret = tap_nl_set_link_mac(pmd->nlsk_fd, pmd->remote_if_index, mac);
+		break;
+
+	case SIOCSIFMTU:
+		if (mode == LOCAL_ONLY || mode == LOCAL_AND_REMOTE) {
+			ret = tap_nl_set_link_mtu(pmd->nlsk_fd, pmd->if_index, ifr->ifr_mtu);
+			if (ret < 0)
+				return ret;
+		}
+		if (remote)
+			ret = tap_nl_set_link_mtu(pmd->nlsk_fd, pmd->remote_if_index, ifr->ifr_mtu);
+		break;
+
+	default:
+		TAP_LOG(WARNING, "%s: unsupported netlink request", pmd->name);
+		return -EINVAL;
+	}
+
+	if (ret < 0) {
+		TAP_LOG(DEBUG, "%s: netlink %s failed: %s(%d)", pmd->name,
+			tap_ctrl_req2str(request), strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
+}
+
 static int
 tap_ioctl(struct pmd_internals *pmd, unsigned long request,
 	  struct ifreq *ifr, int set, enum ctrl_mode mode)
@@ -782,8 +865,6 @@ tap_ioctl(struct pmd_internals *pmd, unsigned long request,
 	int remote = pmd->remote_if_index &&
 		(mode == REMOTE_ONLY || mode == LOCAL_AND_REMOTE);
 
-	if (!pmd->remote_if_index && mode == REMOTE_ONLY)
-		return 0;
 	/*
 	 * If there is a remote netdevice, apply ioctl on it, then apply it on
 	 * the tap netdevice.
@@ -829,6 +910,14 @@ static int
 tap_ctrl(struct pmd_internals *pmd, unsigned long request,
 	 struct ifreq *ifr, int set, enum ctrl_mode mode)
 {
+	if (!pmd->remote_if_index && mode == REMOTE_ONLY)
+		return 0;
+
+	/* Use netlink if available */
+	if (pmd->nlsk_fd >= 0 && pmd->if_index > 0)
+		return tap_nl_ctrl(pmd, request, ifr, set, mode);
+
+	/* Otherwise, fall back to ioctl */
 	return tap_ioctl(pmd, request, ifr, set, mode);
 }
 
@@ -1138,12 +1227,15 @@ tap_dev_close(struct rte_eth_dev *dev)
 	if (internals->nlsk_fd != -1) {
 		tap_flow_flush(dev, NULL);
 		tap_flow_implicit_flush(internals, NULL);
-		tap_nl_final(internals->nlsk_fd);
-		internals->nlsk_fd = -1;
 		tap_flow_bpf_destroy(internals);
 	}
 #endif
 
+	if (internals->nlsk_fd != -1) {
+		tap_nl_final(internals->nlsk_fd);
+		internals->nlsk_fd = -1;
+	}
+
 	for (i = 0; i < RTE_PMD_TAP_MAX_QUEUES; i++) {
 		struct rx_queue *rxq = &internals->rxq[i];
 
@@ -1953,10 +2045,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	strlcpy(pmd->name, tap_name, sizeof(pmd->name));
 	pmd->type = type;
 	pmd->ka_fd = -1;
-
-#ifdef HAVE_TCA_FLOWER
 	pmd->nlsk_fd = -1;
-#endif
 	pmd->gso_ctx_mp = NULL;
 
 	pmd->ioctl_sock = socket(AF_INET, SOCK_DGRAM, 0);
@@ -2035,26 +2124,38 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	/* Make network device persist after application exit */
 	pmd->persist = persist;
 
-#ifdef HAVE_TCA_FLOWER
 	/*
-	 * Set up everything related to rte_flow:
-	 * - netlink socket
-	 * - tap / remote if_index
-	 * - mandatory QDISCs
-	 * - rte_flow actual/implicit lists
-	 * - implicit rules
+	 * Try to create netlink socket for better interface control.
+	 * This provides ifindex-based operations and is more namespace-safe.
+	 * Fall back to ioctl if netlink is not available.
 	 */
 	pmd->nlsk_fd = tap_nl_init(0);
 	if (pmd->nlsk_fd == -1) {
-		TAP_LOG(WARNING, "%s: failed to create netlink socket.",
+		TAP_LOG(INFO, "%s: netlink unavailable, using ioctl fallback.",
+			pmd->name);
+	} else {
+		pmd->if_index = if_nametoindex(pmd->name);
+		if (!pmd->if_index) {
+			TAP_LOG(WARNING, "%s: failed to get if_index.",
+				pmd->name);
+			close(pmd->nlsk_fd);
+			pmd->nlsk_fd = -1;
+		}
+	}
+
+#ifdef HAVE_TCA_FLOWER
+	/*
+	 * Set up everything related to rte_flow:
+	 * - mandatory QDISCs (requires netlink)
+	 * - rte_flow actual/implicit lists
+	 * - implicit rules
+	 */
+	if (pmd->nlsk_fd == -1) {
+		TAP_LOG(WARNING, "%s: rte_flow requires netlink support.",
 			pmd->name);
 		goto disable_rte_flow;
 	}
-	pmd->if_index = if_nametoindex(pmd->name);
-	if (!pmd->if_index) {
-		TAP_LOG(ERR, "%s: failed to get if_index.", pmd->name);
-		goto disable_rte_flow;
-	}
+
 	if (qdisc_create_multiq(pmd->nlsk_fd, pmd->if_index) < 0) {
 		TAP_LOG(ERR, "%s: failed to create multiq qdisc.",
 			pmd->name);
@@ -2141,10 +2242,8 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 #endif
 
 error_exit:
-#ifdef HAVE_TCA_FLOWER
 	if (pmd->nlsk_fd != -1)
 		close(pmd->nlsk_fd);
-#endif
 	if (pmd->ka_fd != -1)
 		close(pmd->ka_fd);
 	if (pmd->ioctl_sock != -1)
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index ce4322ad046e..bb5aa8966bb0 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -77,9 +77,9 @@ struct pmd_internals {
 	int remote_if_index;              /* remote netdevice IF_INDEX */
 	int if_index;                     /* IF_INDEX for the port */
 	int ioctl_sock;                   /* socket for ioctl calls */
+	int nlsk_fd;                      /* Netlink socket fd */
 
 #ifdef HAVE_TCA_FLOWER
-	int nlsk_fd;                      /* Netlink socket fd */
 	int flow_isolate;                 /* 1 if flow isolation is enabled */
 
 	struct tap_rss *rss;		  /* BPF program */
-- 
2.51.0

