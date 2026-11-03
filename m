Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99025606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivb9anR7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58F13410ED;
	Tue,  3 Nov 2026 12:58:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 56AC5410E6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 12:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793707099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4dgHxjzjGF8xxj6ma2+DmoMSUncgoclYAhBjXuXD2k=;
 b=ivb9anR7hkRrZChIu+GEtPhYvGZp888FmlNKKqQfZGRE3fBAq8NNARpPUv9aIWjvVuYVwI
 +rSOXyNusa6vM7wbwip400e0q9WlFCtKbR1IlmA2G2DQ8VGd4clsytQ64Hh30veUNVwjF/
 pSln2XzCeoFQu/7hRIHhc5A17r3aoVw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-sPGoxrrdNQKebit1l1OM6Q-1; Tue,
 03 Nov 2026 06:58:16 -0500
X-MC-Unique: sPGoxrrdNQKebit1l1OM6Q-1
X-Mimecast-MFC-AGG-ID: sPGoxrrdNQKebit1l1OM6Q_1793707095
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72A441801371; Tue,  3 Nov 2026 11:58:07 +0000 (UTC)
Received: from ringo.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18FBD3000714; Tue,  3 Nov 2026 11:58:05 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: stable@dpdk.org
Subject: [PATCH dpdk] net/tap: close old LSC socket on netns change
Date: Tue,  3 Nov 2026 12:57:54 +0100
Message-ID: <20261103115752.1557738-3-rjarry@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Gs43PjRY_2ngyKrJOlACyTmgpPUEjFuBVudUNqO8fk_1793707095
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

When an interface is moved to another namespace, the LSC netlink socket
is recreated in the new namespace and the interrupt handle FD is updated
in place. The old socket is never closed, leaking one FD per move.

Create the new socket first, then close the previous one before updating
the handle, so that the handle never references a closed FD if socket
creation fails.

Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
Cc: stable@dpdk.org

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 1d2b71675a8c..885f1b341388 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1938,15 +1938,21 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 		return 0;
 	}
 	if (set) {
+		int fd;
+
 		/*
 		 * Subscribe to RTMGRP_LINK to receive RTM_NEWLINK (link state
 		 * changes) events. Also receives RTM_DELLINK events which are
 		 * used for namespace change detection when TUNGETDEVNETNS is
 		 * available.
 		 */
-		rte_intr_fd_set(pmd->intr_handle, tap_nl_init(RTMGRP_LINK));
-		if (unlikely(rte_intr_fd_get(pmd->intr_handle) == -1))
+		fd = tap_nl_init(RTMGRP_LINK);
+		if (unlikely(fd == -1))
 			return -EBADF;
+		/* Close the socket of the previous namespace, if any. */
+		if (rte_intr_fd_get(pmd->intr_handle) >= 0)
+			tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
+		rte_intr_fd_set(pmd->intr_handle, fd);
 		return rte_intr_callback_register(
 			pmd->intr_handle, tap_dev_intr_handler, dev);
 	}
-- 
2.56.0

