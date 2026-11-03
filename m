Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AD606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QcCcIVqd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59CF340265;
	Tue,  3 Nov 2026 18:17:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 30321400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793726261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Bq02msmPWiG2IqHNOKVLx7CFff3EfYBnSgMCVMp4bY=;
 b=QcCcIVqdK/Ab5eOru6F9ZJWw1nRIZu+2o2tAFWgBG3KQnLSk33qNT7RWRrzMHqf72jf/pn
 W3l0cuHqOlvStC1hNULBFo4jfgcTMCoPD3dE1gS1RRuJzo5X+Q3ZaRID3u3UOe2YnXF+gb
 9uSHSjfZbGx1YxWdLa92jxcZM3U/XNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ZEroA3cENkOdF40zdv_adw-1; Tue,
 03 Nov 2026 12:17:39 -0500
X-MC-Unique: ZEroA3cENkOdF40zdv_adw-1
X-Mimecast-MFC-AGG-ID: ZEroA3cENkOdF40zdv_adw_1793726258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8161E1801A0B; Tue,  3 Nov 2026 17:17:38 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BED31800444; Tue,  3 Nov 2026 17:17:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH 1/2] net/tap: fix FD leak on netns change
Date: Tue,  3 Nov 2026 18:17:29 +0100
Message-ID: <20261103171730.1361878-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r-dI5Oz56ucAtHAvLLhg2WipiSaQOKCqlcq4BJsxvrM_1793726258
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
---
 drivers/net/tap/rte_eth_tap.c | 100 ++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1d2b71675a..15320c4b7e 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -17,6 +17,7 @@
 #include <rte_ip.h>
 #include <rte_ethdev.h>
 #include <rte_errno.h>
+#include <rte_alarm.h>
 #include <rte_cycles.h>
 
 #include <assert.h>
@@ -1796,41 +1797,57 @@ tap_mac_addr_remove(struct rte_eth_dev *dev __rte_unused,
 
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
-	if (netns_fd < 0) {
-		TAP_LOG(INFO, "%s: interface deleted", pmd->name);
-		return 0;
-	}
-
-	/* Interface was moved to another namespace */
-	pmd->if_index = 0;
+	if (netns_fd < 0)
+		return -1;
 
-	/* Save current namespace */
-	orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (orig_netns_fd < 0) {
-		TAP_LOG(ERR, "%s: failed to open original netns: %s",
-			pmd->name, strerror(errno));
+	*orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
+	if (*orig_netns_fd < 0) {
 		close(netns_fd);
 		return -1;
 	}
 
-	/* Switch to new namespace */
 	if (setns(netns_fd, CLONE_NEWNET) < 0) {
-		TAP_LOG(ERR, "%s: failed to enter new netns: %s",
-			pmd->name, strerror(errno));
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
+tap_dev_ns_restore(int orig_netns_fd)
+{
+	setns(orig_netns_fd, CLONE_NEWNET);
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
+	if (tap_dev_ns_switch(pmd, &orig_netns_fd) < 0) {
+		TAP_LOG(INFO, "%s: interface deleted", pmd->name);
+		return 0;
+	}
+
+	/* Interface was moved to another namespace */
+	pmd->if_index = 0;
+
 	/*
 	 * Update ifindex by querying interface name.
 	 * The interface now has a new ifindex in the new namespace.
@@ -1840,22 +1857,10 @@ tap_netns_change(struct rte_eth_dev *dev)
 	/* Recreate netlink socket in new namespace */
 	new_nlsk_fd = tap_nl_init(0);
 
-	/* Recreate LSC interrupt netlink socket in new namespace */
-	rte_intr_callback_unregister_pending(pmd->intr_handle, tap_dev_intr_handler, dev, NULL);
-	if (tap_lsc_intr_handle_set(dev, 1) < 0)
-		TAP_LOG(WARNING, "%s: failed to recreate LSC interrupt socket",
-			pmd->name);
+	/* Defer LSC re-registration outside callback context */
+	rte_eal_alarm_set(1, tap_lsc_register_alarm, dev);
 
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
+	tap_dev_ns_restore(orig_netns_fd);
 
 	if (pmd->if_index == 0) {
 		TAP_LOG(WARNING, "%s: interface moved to another namespace, "
@@ -1952,6 +1957,7 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 	}
 
 clean:
+	rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
 	do {
 		ret = rte_intr_callback_unregister(pmd->intr_handle,
 			tap_dev_intr_handler, dev);
@@ -1975,6 +1981,30 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
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
+	tap_dev_ns_restore(orig_netns_fd);
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

