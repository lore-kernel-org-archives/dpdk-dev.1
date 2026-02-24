Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4286F3C991
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 217EF40649;
	Tue, 24 Feb 2026 16:27:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E085840288
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771946874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kf9vgG1BM+EJSPmBJ/JIlCewNVgbMt6JelSsa3EQkrs=;
 b=gcraWa1NdIhyArTQO6V1u5PCO7sQJoRph5lfRe3WHqN6kl1weay6t4YD+vQJqm9qpWG0aB
 8MbUVUwGTo21qF0pk70jw6vW/KJFv/EOPYxzG2JXLvhT4Trov8q7m1Scy2nBO5Z2x8z0PE
 w/mtGQFBgbSlR95343t+uOC8cAMn5+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-lfKBc09JNCW35_7b0McBKw-1; Tue,
 24 Feb 2026 10:27:53 -0500
X-MC-Unique: lfKBc09JNCW35_7b0McBKw-1
X-Mimecast-MFC-AGG-ID: lfKBc09JNCW35_7b0McBKw_1771946871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA1861800451; Tue, 24 Feb 2026 15:27:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A47E1800370; Tue, 24 Feb 2026 15:27:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ktraynor@redhat.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/tap: defer qdisc initialisation for rte_flow
Date: Tue, 24 Feb 2026 16:27:44 +0100
Message-ID: <20260224152744.3860285-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bc6O1cmpFda_8vgMTTR9W6aGvYjAWKIyh98XRk1J3Cw_1771946871
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

qdisc setup is required when using a remote_iface or when creating
rte_flow rules.
Otherwise, many applications don't care about it.

Let's postpone the qdisc init to when it is really needed, that will
avoid spewing ERR logs for nothing.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 32 +++++---------------------------
 drivers/net/tap/rte_eth_tap.h |  1 +
 drivers/net/tap/tap_flow.c    | 26 ++++++++++++++++++++++++++
 drivers/net/tap/tap_flow.h    |  2 ++
 4 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 7a8a98cddb..71fb0a74fa 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2122,26 +2122,14 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	pmd->persist = persist;
 
 #ifdef HAVE_TCA_FLOWER
-	/*
-	 * Set up everything related to rte_flow:
-	 * - mandatory QDISCs
-	 * - rte_flow actual/implicit lists
-	 * - implicit rules
-	 */
-	if (qdisc_create_multiq(pmd->nlsk_fd, pmd->if_index) < 0) {
-		TAP_LOG(ERR, "%s: failed to create multiq qdisc.",
-			pmd->name);
-		goto disable_rte_flow;
-	}
-	if (qdisc_create_ingress(pmd->nlsk_fd, pmd->if_index) < 0) {
-		TAP_LOG(ERR, "%s: failed to create ingress qdisc.",
-			pmd->name);
-		goto disable_rte_flow;
-	}
-
 	LIST_INIT(&pmd->flows);
 
 	if (strlen(remote_iface)) {
+		if (tap_flow_init(pmd) < 0) {
+			TAP_LOG(ERR, "Remote feature requires flow support.");
+			goto error_exit;
+		}
+
 		pmd->remote_if_index = if_nametoindex(remote_iface);
 		if (!pmd->remote_if_index) {
 			TAP_LOG(ERR, "%s: failed to get %s if_index.",
@@ -2196,16 +2184,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	rte_eth_dev_probing_finish(dev);
 	return 0;
 
-disable_rte_flow:
-	TAP_LOG(ERR, " Disabling rte flow support: %s(%d)",
-		strerror(errno), errno);
-	if (strlen(remote_iface)) {
-		TAP_LOG(ERR, "Remote feature requires flow support.");
-		goto error_exit;
-	}
-	rte_eth_dev_probing_finish(dev);
-	return 0;
-
 #ifdef HAVE_TCA_FLOWER
 error_remote:
 	TAP_LOG(ERR, " Can't set up remote feature: %s(%d)",
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 218ee1b811..59d61582cc 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -79,6 +79,7 @@ struct pmd_internals {
 	int nlsk_fd;                      /* Netlink socket fd */
 
 #ifdef HAVE_TCA_FLOWER
+	int flow_init;                    /* 1 if qdiscs were created */
 	int flow_isolate;                 /* 1 if flow isolation is enabled */
 
 	struct tap_rss *rss;		  /* BPF program */
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 9d4ef27a8a..8877cef3ff 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1235,6 +1235,12 @@ tap_flow_create(struct rte_eth_dev *dev,
 	struct tap_nlmsg *msg = NULL;
 	int err;
 
+	if (pmd->flow_init == 0 && tap_flow_init(pmd) < 0) {
+		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_HANDLE,
+				   NULL,
+				   "can't create rule, qdisc not initialized");
+		goto fail;
+	}
 	if (!pmd->if_index) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL,
@@ -1875,6 +1881,26 @@ static int rss_add_actions(struct rte_flow *flow, struct pmd_internals *pmd,
 }
 #endif
 
+int
+tap_flow_init(struct pmd_internals *pmd)
+{
+	if (qdisc_create_multiq(pmd->nlsk_fd, pmd->if_index) < 0) {
+		TAP_LOG(ERR, "%s: failed to create multiq qdisc.",
+			pmd->name);
+		return -1;
+	}
+
+	if (qdisc_create_ingress(pmd->nlsk_fd, pmd->if_index) < 0) {
+		TAP_LOG(ERR, "%s: failed to create ingress qdisc.",
+			pmd->name);
+		return -1;
+	}
+
+	pmd->flow_init = 1;
+
+	return 0;
+}
+
 /**
  * Get rte_flow operations.
  *
diff --git a/drivers/net/tap/tap_flow.h b/drivers/net/tap/tap_flow.h
index 8b19347a93..49e7e04050 100644
--- a/drivers/net/tap/tap_flow.h
+++ b/drivers/net/tap/tap_flow.h
@@ -45,6 +45,8 @@ enum implicit_rule_index {
 	TAP_REMOTE_MAX_IDX,
 };
 
+int tap_flow_init(struct pmd_internals *pmd);
+
 int tap_dev_flow_ops_get(struct rte_eth_dev *dev,
 			 const struct rte_flow_ops **ops);
 int tap_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error);
-- 
2.53.0

