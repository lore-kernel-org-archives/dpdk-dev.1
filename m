Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B348606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvKXgD16
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A225340299;
	Wed,  4 Nov 2026 17:42:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 8B72A40281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 17:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793810525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3z0NPzSsOmiSj/ORxGj4gnoGzukf1bQt7HpT1ICnd1g=;
 b=YvKXgD16kHonPrK1rVtjsZb6p6PqSWfD8TjcQp0IHXBqn5OuQF8oIbEOVVHVl164fC9Dmz
 9IKDSj0tJl5iLF0hrUueLLQVXCxq+48iQIrnQbO1AOeJvJjgEFBq0iTTK6wX/qsN1Lor6r
 40pmflkEtga4xZR9qaIjPTJYECdn0Tk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-3wH4uThhPyKUiyCGDpgzlg-1; Wed,
 04 Nov 2026 11:41:59 -0500
X-MC-Unique: 3wH4uThhPyKUiyCGDpgzlg-1
X-Mimecast-MFC-AGG-ID: 3wH4uThhPyKUiyCGDpgzlg_1793810518
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFA851955DB9; Wed,  4 Nov 2026 16:41:57 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FADB18004D2; Wed,  4 Nov 2026 16:41:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: sriram.yagnaraman@ericsson.com, jgrajcia@cisco.com, thomas@monjalon.net,
 stephen@networkplumber.org
Subject: [PATCH] net/memif: fix use after free on listener socket close
Date: Wed,  4 Nov 2026 17:41:53 +0100
Message-ID: <20261104164153.1674329-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -hp_lh5V4T3zhpzCsaQCN_iYB8AMHTbsI7W3G4Mn97w_1793810518
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

memif_socket_remove_device() calls rte_intr_callback_unregister() on
the listener socket interrupt handle. If memif_listener_handler() is
active at that point, the unregister returns -EAGAIN and the code
proceeds to close and free the handle while the handler is still
running.

Use rte_intr_callback_unregister_sync() which retries until the
handler completes.

Fixes: 7281511c2cfa ("net/memif: fix some interrupt FD leaks")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/memif/memif_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 971964133c..d672ad9f64 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -1198,8 +1198,8 @@ memif_socket_remove_device(struct rte_eth_dev *dev)
 					socket->filename);
 		}
 		if (pmd->role != MEMIF_ROLE_CLIENT) {
-			rte_intr_callback_unregister(socket->intr_handle, memif_listener_handler,
-				socket);
+			rte_intr_callback_unregister_sync(socket->intr_handle,
+				memif_listener_handler, socket);
 			rte_intr_fd_close(socket->intr_handle);
 			rte_intr_instance_free(socket->intr_handle);
 		}
-- 
2.56.0

