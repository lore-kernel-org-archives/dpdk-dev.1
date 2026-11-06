Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21845606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsDlGVTW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD65442D26;
	Fri,  6 Nov 2026 09:57:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id DA5F442D0C
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793955433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFenXUkbGL6gVAnQOa+uiZMNPva0E7R2f7mflNmqDag=;
 b=bsDlGVTW9z97+TlwOtx+T/5dUwdynYCkL3kXaD3HU189QHBNYeaAqAIIrQJGsLjxmOJG2S
 HLeWWDJF2mYFFN8DOUIYXec4wbYil3yu+Y+tym1sV46zrmCOaLbDtv3fRaF3UOmPS5hKhb
 APnc0YRuKR+IrTD30iMGqV6dhu6tbnk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-kzoEdXcGNTinJ4vU0S_HSw-1; Fri,
 06 Nov 2026 03:57:09 -0500
X-MC-Unique: kzoEdXcGNTinJ4vU0S_HSw-1
X-Mimecast-MFC-AGG-ID: kzoEdXcGNTinJ4vU0S_HSw_1793955428
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC9D195605C; Fri,  6 Nov 2026 08:57:07 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 707CD1955F73; Fri,  6 Nov 2026 08:57:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/2] net/tap: fix FD leak on netns change
Date: Fri,  6 Nov 2026 09:56:59 +0100
Message-ID: <20261106085701.2429186-1-david.marchand@redhat.com>
In-Reply-To: <20261103171730.1361878-1-david.marchand@redhat.com>
References: <20261103171730.1361878-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sMqfkQNcHCdN2xryDJrj-YkVaJ6tfT6JHilRboV9YZ4_1793955428
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
Changes since v1:
- moved pmd->if_index clearing before trying to change netns,
- moved alarm registration after netns changes succeed,
- added second alarm cancel for unregister race with netns change,
- ignored ENOENT suggestion from AI review,
- added error logs to please AI review,

---
 drivers/net/tap/rte_eth_tap.c | 99 +++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 27 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1d2b71675a..66a55301e7 100644
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
@@ -1952,6 +1967,10 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 	}
 
 clean:
+	rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
+	if (rte_intr_fd_get(pmd->intr_handle) < 0)
+		return 0;
+
 	do {
 		ret = rte_intr_callback_unregister(pmd->intr_handle,
 			tap_dev_intr_handler, dev);
@@ -1966,6 +1985,8 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 		}
 	} while (true);
 
+	rte_eal_alarm_cancel(tap_lsc_register_alarm, dev);
+
 	if (rte_intr_fd_get(pmd->intr_handle) >= 0) {
 		tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
 		/* fd has been closed already, only clear reference here. */
@@ -1975,6 +1996,30 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
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

