Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D0606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEMNnDo6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AD240DDA;
	Tue, 10 Nov 2026 11:03:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 58B5040DD7
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794305002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZTd93HNu58HGO6q42jVt9XVvLeDaLBy4et5u4MnThM=;
 b=eEMNnDo65vDH597WSoJhYqQHJSCB0QDqlQ8s0+0pXh3lydm6clqZQXKzFc/CgFbeKdTtnf
 ozp47GSQH3AjOYKxWybOylyEXHScXOoQr0RVEXmYuPcDT0UVicwRR4w1oN024PMF1bpga8
 008CttBHwZ/xy6RvEHm4/50J41gd7sE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-8qx7MEEVN0K9DQM40s72Jg-1; Tue,
 10 Nov 2026 05:03:18 -0500
X-MC-Unique: 8qx7MEEVN0K9DQM40s72Jg-1
X-Mimecast-MFC-AGG-ID: 8qx7MEEVN0K9DQM40s72Jg_1794304997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94F871800547; Tue, 10 Nov 2026 10:03:17 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CC0C1800347; Tue, 10 Nov 2026 10:03:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/2] net/tap: fix FD leak on netns change
Date: Tue, 10 Nov 2026 11:03:07 +0100
Message-ID: <20261110100308.3190833-1-david.marchand@redhat.com>
In-Reply-To: <20261103171730.1361878-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2XduJWucogKzXU28SGhIU49MxI1qZ-hbxarIMbxIda4_1794304997
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a tap interface moves to another namespace, tap_netns_change()
calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
without first tearing down the old one. The previous LSC netlink
socket fd is never closed.

Defer the full LSC teardown and re-registration to an alarm callback
which runs in the interrupt thread but outside any active source
context. The alarm switches to the device's network namespace, tears
down the old LSC handle, sets up a new one (opening a fresh netlink
socket in the correct namespace), restores the original namespace,
and forces carrier state back up.

Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
namespace switch logic between tap_netns_change and the alarm.

Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Robin Jarry <rjarry@redhat.com>
---
Changes since v2:
- added retry loop for the unregister retry loop,

Changes since v1:
- moved pmd->if_index clearing before trying to change netns,
- moved alarm registration after netns changes succeed,
- added second alarm cancel for unregister race with netns change,
- ignored ENOENT suggestion from AI review,
- added error logs to please AI review,

---
 drivers/net/tap/rte_eth_tap.c | 130 +++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 41 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1d2b71675a..87779710a7 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -17,6 +17,7 @@
 #include <rte_ip.h>
 #include <rte_ethdev.h>
 #include <rte_errno.h>
+#include <rte_alarm.h>
 #include <rte_cycles.h>
 
 #include <assert.h>
@@ -1796,26 +1797,23 @@ tap_mac_addr_remove(struct rte_eth_dev *dev __rte_unused,
 
 static void tap_dev_intr_handler(void *cb_arg);
 static int tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set);
+static void tap_lsc_register_alarm(void *arg);
 
+#ifdef TUNGETDEVNETNS
 static int
-tap_netns_change(struct rte_eth_dev *dev)
+tap_dev_ns_switch(struct pmd_internals *pmd, int *orig_netns_fd)
 {
-	struct pmd_internals *pmd = dev->data->dev_private;
-#ifdef TUNGETDEVNETNS
-	int netns_fd, orig_netns_fd, new_nlsk_fd;
+	int netns_fd;
 
 	netns_fd = ioctl(pmd->ka_fd, TUNGETDEVNETNS);
 	if (netns_fd < 0) {
 		TAP_LOG(INFO, "%s: interface deleted", pmd->name);
-		return 0;
+		return -1;
 	}
 
-	/* Interface was moved to another namespace */
-	pmd->if_index = 0;
-
 	/* Save current namespace */
-	orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (orig_netns_fd < 0) {
+	*orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (*orig_netns_fd < 0) {
 		TAP_LOG(ERR, "%s: failed to open original netns: %s",
 			pmd->name, strerror(errno));
 		close(netns_fd);
@@ -1827,10 +1825,37 @@ tap_netns_change(struct rte_eth_dev *dev)
 		TAP_LOG(ERR, "%s: failed to enter new netns: %s",
 			pmd->name, strerror(errno));
 		close(netns_fd);
-		close(orig_netns_fd);
+		close(*orig_netns_fd);
 		return -1;
 	}
 
+	close(netns_fd);
+	return 0;
+}
+
+static void
+tap_dev_ns_restore(struct pmd_internals *pmd, int orig_netns_fd)
+{
+	if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
+		TAP_LOG(ERR, "%s: failed to restore original netns: %s",
+			pmd->name, strerror(errno));
+	close(orig_netns_fd);
+}
+#endif
+
+static int
+tap_netns_change(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+#ifdef TUNGETDEVNETNS
+	int orig_netns_fd, new_nlsk_fd;
+
+	/* Interface was moved to another namespace */
+	pmd->if_index = 0;
+
+	if (tap_dev_ns_switch(pmd, &orig_netns_fd) < 0)
+		return 0;
+
 	/*
 	 * Update ifindex by querying interface name.
 	 * The interface now has a new ifindex in the new namespace.
@@ -1840,22 +1865,7 @@ tap_netns_change(struct rte_eth_dev *dev)
 	/* Recreate netlink socket in new namespace */
 	new_nlsk_fd = tap_nl_init(0);
 
-	/* Recreate LSC interrupt netlink socket in new namespace */
-	rte_intr_callback_unregister_pending(pmd->intr_handle, tap_dev_intr_handler, dev, NULL);
-	if (tap_lsc_intr_handle_set(dev, 1) < 0)
-		TAP_LOG(WARNING, "%s: failed to recreate LSC interrupt socket",
-			pmd->name);
-
-	/* Force carrier back after switching netns */
-	tap_carrier_set(pmd, 1);
-
-	/* Switch back to original namespace */
-	if (setns(orig_netns_fd, CLONE_NEWNET) < 0)
-		TAP_LOG(ERR, "%s: failed to return to original netns: %s",
-			pmd->name, strerror(errno));
-
-	close(orig_netns_fd);
-	close(netns_fd);
+	tap_dev_ns_restore(pmd, orig_netns_fd);
 
 	if (pmd->if_index == 0) {
 		TAP_LOG(WARNING, "%s: interface moved to another namespace, "
@@ -1877,6 +1887,11 @@ tap_netns_change(struct rte_eth_dev *dev)
 		tap_nl_final(pmd->nlsk_fd);
 	pmd->nlsk_fd = new_nlsk_fd;
 
+	/* Defer LSC re-registration outside callback context */
+	if (rte_eal_alarm_set(1, tap_lsc_register_alarm, dev) < 0)
+		TAP_LOG(ERR, "%s: failed to schedule LSC re-registration",
+			pmd->name);
+
 	TAP_LOG(INFO, "%s: interface moved to another namespace, new ifindex: %u",
 		pmd->name, pmd->if_index);
 #else
@@ -1929,6 +1944,7 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
 	int ret;
+	int fd;
 
 	/* In any case, disable interrupt if the conf is no longer there. */
 	if (!dev->data->dev_conf.intr_conf.lsc) {
@@ -1953,28 +1969,60 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 
 clean:
 	do {
-		ret = rte_intr_callback_unregister(pmd->intr_handle,
-			tap_dev_intr_handler, dev);
-		if (ret >= 0) {
-			break;
-		} else if (ret == -EAGAIN) {
+		rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
+		fd = rte_intr_fd_get(pmd->intr_handle);
+		if (fd < 0)
+			return 0;
+
+		do {
+			ret = rte_intr_callback_unregister(pmd->intr_handle, tap_dev_intr_handler,
+				dev);
+			if (ret >= 0 || ret == -ENOENT)
+				break;
+			if (ret != -EAGAIN) {
+				TAP_LOG(ERR, "intr callback unregister failed: %d", ret);
+				break;
+			}
 			rte_delay_ms(100);
-		} else {
-			TAP_LOG(ERR, "intr callback unregister failed: %d",
-				     ret);
+		} while (true);
+
+		/* Alarm may have replaced the fd while unregistering */
+		rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
+		if (rte_intr_fd_get(pmd->intr_handle) == fd)
 			break;
-		}
 	} while (true);
 
-	if (rte_intr_fd_get(pmd->intr_handle) >= 0) {
-		tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
-		/* fd has been closed already, only clear reference here. */
-		rte_intr_fd_set(pmd->intr_handle, -1);
-	}
+	tap_nl_final(fd);
+	/* fd has been closed already, only clear reference here. */
+	rte_intr_fd_set(pmd->intr_handle, -1);
 
 	return 0;
 }
 
+static void
+tap_lsc_register_alarm(void *arg)
+{
+#ifdef TUNGETDEVNETNS
+	struct rte_eth_dev *dev = arg;
+	struct pmd_internals *pmd = dev->data->dev_private;
+	int orig_netns_fd;
+
+	if (tap_dev_ns_switch(pmd, &orig_netns_fd) < 0)
+		return;
+
+	tap_lsc_intr_handle_set(dev, 0);
+	if (tap_lsc_intr_handle_set(dev, 1) < 0)
+		TAP_LOG(ERR, "%s: failed to register LSC interrupt", pmd->name);
+
+	tap_dev_ns_restore(pmd, orig_netns_fd);
+
+	tap_carrier_set(pmd, 1);
+	tap_link_update(dev, 0);
+#else
+	RTE_SET_USED(arg);
+#endif
+}
+
 static int
 tap_intr_handle_set(struct rte_eth_dev *dev, int set)
 {
-- 
2.56.0

