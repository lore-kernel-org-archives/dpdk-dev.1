Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D1606A32F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XdyfEzjB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A27402D8;
	Fri,  6 Nov 2026 15:57:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id A3664402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 15:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793977061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dyo2ZhUNWDIf9Uej+fki7UZqkbUBfw8SZEcgg9TwtRk=;
 b=XdyfEzjB8Zpp9MucM62qWi8637YwFfppri+lmljT3t0gippHZ3BPHL0z37N52N/OEex6eh
 gPi4i3+KSmUd6qUys+wXJt3ni31ysypM65eNlPOH5MTGNjdsJm20/utwujbKyHa4YOfgok
 ko+bvBIeIQtg+noGhbh1NYUCukWw3og=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-ZMCpzD-kOlutWX6qLrN6EA-1; Fri,
 06 Nov 2026 09:57:37 -0500
X-MC-Unique: ZMCpzD-kOlutWX6qLrN6EA-1
X-Mimecast-MFC-AGG-ID: ZMCpzD-kOlutWX6qLrN6EA_1793977056
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 096111800635; Fri,  6 Nov 2026 14:57:36 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6B8D39201; Fri,  6 Nov 2026 14:57:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v2] net/memif: fix use after free on listener socket close
Date: Fri,  6 Nov 2026 15:57:29 +0100
Message-ID: <20261106145730.2561787-1-david.marchand@redhat.com>
In-Reply-To: <20261104164153.1674329-1-david.marchand@redhat.com>
References: <20261104164153.1674329-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JyThDb7Myj3d4WLHUL4nQIzmt7aQZZMQVoIc9WZNUG0_1793977056
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
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
Changes since v1:
- added missing _sync in other call,

---
 drivers/net/memif/memif_socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 971964133c..b3cd84bf21 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -1126,7 +1126,7 @@ memif_socket_init(struct rte_eth_dev *dev, const char *socket_filename)
 		if (ret < 0) {
 			MIF_LOG(ERR, "Failed to add socket to socket hash.");
 			if (socket->listener) {
-				rte_intr_callback_unregister(socket->intr_handle,
+				rte_intr_callback_unregister_sync(socket->intr_handle,
 					memif_listener_handler, socket);
 				rte_intr_fd_close(socket->intr_handle);
 				rte_intr_instance_free(socket->intr_handle);
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

