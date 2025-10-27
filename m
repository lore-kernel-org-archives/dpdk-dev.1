Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A1CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 22:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 690B940430;
	Mon, 27 Oct 2025 23:18:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1BD274066F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 23:18:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761603480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+Qrkv9gwffZsS1AuiEzcs+vGE1LsL/3hyhV1y+7ESo=;
 b=A92ih9dapCmZ5KvMPKAGmjpXh9FTYj8153IQHy+ZaKczxPSTW0XPJ9uj+4b84Gu6SJP41u
 ILRpDmk45coGDIupqL+X9WZC4AyRRqc45Ti+w7MuZPv7YyFbB9jkVO5K4f6BPa0KdhBkyk
 zTMH95gB6XZBn6hsI39YxN/6rsftjEQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-GwV39wPuPYWF71MGWqCRlg-1; Mon,
 27 Oct 2025 18:17:48 -0400
X-MC-Unique: GwV39wPuPYWF71MGWqCRlg-1
X-Mimecast-MFC-AGG-ID: GwV39wPuPYWF71MGWqCRlg_1761603467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9169180899A; Mon, 27 Oct 2025 22:17:47 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8A530001A7; Mon, 27 Oct 2025 22:17:45 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v3 3/3] net/tap: detect namespace change
Date: Mon, 27 Oct 2025 23:16:25 +0100
Message-ID: <20251027221622.494080-8-rjarry@redhat.com>
In-Reply-To: <20251027221622.494080-5-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027221622.494080-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7mrDNYnwx_cCC0Xasc62ORf1l-ye908ZdEMp7PpW3ag_1761603467
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

When an interface is moved to another network namespace, the kernel
sends RTM_DELLINK. Detect this case by using TUNGETDEVNETNS ioctl on the
keep-alive fd. If successful, the interface still exists but in
a different namespace.

To handle this, temporarily switch to the new namespace using setns(),
query the new ifindex, recreate netlink and LSC interrupt sockets in
that namespace, then switch back. Replace the old netlink socket with
the new one so subsequent operations work in the target namespace.

This allows the driver to track interfaces across namespace changes
without losing control.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 doc/guides/rel_notes/release_25_11.rst |   1 +
 drivers/net/tap/rte_eth_tap.c          | 114 ++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 41b6131c80f3..fe191bd78aa2 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -171,6 +171,7 @@ New Features
 
   * Replaced ``ioctl`` based link control with a Netlink based implementation.
   * Linux net devices can now be renamed without breaking link control.
+  * Linux net devices can now be moved to different namespaces without breaking link control.
 
 
 Removed Items
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index e006c71989a8..bb96aa7e61ec 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -33,6 +33,7 @@
 #include <unistd.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
+#include <linux/sched.h>
 #include <fcntl.h>
 
 #include <tap_rss.h>
@@ -1638,17 +1639,118 @@ tap_set_mc_addr_list(struct rte_eth_dev *dev __rte_unused,
 	return 0;
 }
 
+#ifdef TUNGETDEVNETNS
+static void tap_dev_intr_handler(void *cb_arg);
+static int tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set);
+
+static int
+tap_netns_change(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+	int netns_fd, orig_netns_fd, new_nlsk_fd;
+
+	netns_fd = ioctl(pmd->ka_fd, TUNGETDEVNETNS);
+	if (netns_fd < 0) {
+		TAP_LOG(INFO, "%s: interface deleted", pmd->name);
+		return 0;
+	}
+
+	/* Interface was moved to another namespace */
+	pmd->if_index = 0;
+
+	/* Save current namespace */
+	orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (orig_netns_fd < 0) {
+		TAP_LOG(ERR, "%s: failed to open original netns: %s",
+			pmd->name, strerror(errno));
+		close(netns_fd);
+		return -1;
+	}
+
+	/* Switch to new namespace */
+	if (setns(netns_fd, CLONE_NEWNET) < 0) {
+		TAP_LOG(ERR, "%s: failed to enter new netns: %s",
+			pmd->name, strerror(errno));
+		close(netns_fd);
+		close(orig_netns_fd);
+		return -1;
+	}
+
+	/*
+	 * Update ifindex by querying interface name.
+	 * The interface now has a new ifindex in the new namespace.
+	 */
+	pmd->if_index = if_nametoindex(pmd->name);
+
+	/* Recreate netlink socket in new namespace */
+	new_nlsk_fd = tap_nl_init(0);
+
+	/* Recreate LSC interrupt netlink socket in new namespace */
+	rte_intr_callback_unregister_pending(pmd->intr_handle, tap_dev_intr_handler, dev, NULL);
+	if (tap_lsc_intr_handle_set(dev, 1) < 0)
+		TAP_LOG(WARNING, "%s: failed to recreate LSC interrupt socket",
+			pmd->name);
+
+	/* Switch back to original namespace */
+	if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
+		TAP_LOG(ERR, "%s: failed to return to original netns: %s",
+			pmd->name, strerror(errno));
+
+	close(orig_netns_fd);
+	close(netns_fd);
+
+	if (pmd->if_index == 0) {
+		TAP_LOG(WARNING, "%s: interface moved to another namespace, "
+			"failed to get new ifindex",
+			pmd->name);
+		if (new_nlsk_fd >= 0)
+			close(new_nlsk_fd);
+		return -1;
+	}
+
+	if (new_nlsk_fd < 0) {
+		TAP_LOG(WARNING, "%s: failed to recreate netlink socket in new namespace",
+			pmd->name);
+		return -1;
+	}
+
+	/* Close old netlink socket and replace with new one */
+	if (pmd->nlsk_fd >= 0)
+		tap_nl_final(pmd->nlsk_fd);
+	pmd->nlsk_fd = new_nlsk_fd;
+
+	TAP_LOG(INFO, "%s: interface moved to another namespace, new ifindex: %u",
+		pmd->name, pmd->if_index);
+
+	return 0;
+}
+#endif
+
 static int
 tap_nl_msg_handler(struct nlmsghdr *nh, void *arg)
 {
 	struct rte_eth_dev *dev = arg;
 	struct pmd_internals *pmd = dev->data->dev_private;
 	struct ifinfomsg *info = NLMSG_DATA(nh);
+	int is_local = (info->ifi_index == pmd->if_index);
+	int is_remote = (info->ifi_index == pmd->remote_if_index);
 
-	if (nh->nlmsg_type != RTM_NEWLINK ||
-	    (info->ifi_index != pmd->if_index &&
-	     info->ifi_index != pmd->remote_if_index))
+	/* Ignore messages not for our interfaces */
+	if (!is_local && !is_remote)
 		return 0;
+
+#ifdef TUNGETDEVNETNS
+	if (nh->nlmsg_type == RTM_DELLINK && is_local) {
+		/*
+		 * RTM_DELLINK may indicate the interface was moved to another
+		 * network namespace. Check if the device still exists by
+		 * querying its namespace via the keep-alive fd.
+		 */
+		int ret = tap_netns_change(dev);
+		if (ret < 0)
+			return ret;
+	}
+#endif
 	return tap_link_update(dev, 0);
 }
 
@@ -1677,6 +1779,12 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 		return 0;
 	}
 	if (set) {
+		/*
+		 * Subscribe to RTMGRP_LINK to receive RTM_NEWLINK (link state
+		 * changes) events. Also receives RTM_DELLINK events which are
+		 * used for namespace change detection when TUNGETDEVNETNS is
+		 * available.
+		 */
 		rte_intr_fd_set(pmd->intr_handle, tap_nl_init(RTMGRP_LINK));
 		if (unlikely(rte_intr_fd_get(pmd->intr_handle) == -1))
 			return -EBADF;
-- 
2.51.0

