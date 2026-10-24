Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7F606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1nPhTnW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3DB340698;
	Sat, 24 Oct 2026 15:22:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 908B2406B7
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNlCkXJAMCvh2w99o+05YoRW0Lw1rI021wqVcVV3JPU=;
 b=E1nPhTnWN4iBX/A9DSu7euVbzb/MnIigb7OHqkBzFUTb8Scfs7N4CStxCQmBbuAALQBKNS
 DD7xj9wXrXnPuxVmkSZAlXl+anyK8aGwyvzdm81QqrGbP2HPvWEID/TxRfr2g3L21IS5gx
 RxVW0RU6rj/q0tcXpnR8yC/ElE3UqkE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-M3eAReY5P6C49uXNb8Pgvg-1; Sat,
 24 Oct 2026 09:22:15 -0400
X-MC-Unique: M3eAReY5P6C49uXNb8Pgvg-1
X-Mimecast-MFC-AGG-ID: M3eAReY5P6C49uXNb8Pgvg_1792848134
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0071956089; Sat, 24 Oct 2026 13:22:14 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AE181956087; Sat, 24 Oct 2026 13:22:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 07/12] net/memif: reset FD in interrupt handle
Date: Sat, 24 Oct 2026 15:21:32 +0200
Message-ID: <20261024132138.7239-8-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iovY9wagaIUdk0wrZ6jldz-Cngb1mglWxRTANtlAHvE_1792848134
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clear FD references before freeing interrupt handles to avoid
spurious leak warnings. In error paths where the socket fd is
closed separately, clear the reference. In cleanup paths, use
rte_intr_fd_close() to close and clear in one call.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/memif/memif_socket.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index bd52a95473..b47c7a3b1b 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -638,7 +638,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 							pmd->cc,
 							memif_intr_unregister_handler);
 			} else if (ret > 0) {
-				close(rte_intr_fd_get(ih));
+				rte_intr_fd_close(ih);
 				rte_intr_instance_free(ih);
 				rte_free(pmd->cc);
 			}
@@ -962,6 +962,8 @@ memif_listener_handler(void *arg)
 	if (cc != NULL) {
 		rte_intr_callback_unregister(cc->intr_handle, memif_intr_handler,
 					 cc);
+		/* fd is closed below, clear reference here. */
+		rte_intr_fd_set(cc->intr_handle, -1);
 		rte_intr_instance_free(cc->intr_handle);
 		rte_free(cc);
 	}
@@ -1060,6 +1062,8 @@ memif_socket_create(char *key, uint8_t listener, bool is_abstract, uid_t owner_u
  error:
 	MIF_LOG(ERR, "Failed to setup socket %s: %s", key, strerror(errno));
 	if (sock != NULL) {
+		/* fd is closed below, clear reference here. */
+		rte_intr_fd_set(sock->intr_handle, -1);
 		rte_intr_instance_free(sock->intr_handle);
 		rte_free(sock);
 	}
@@ -1118,8 +1122,7 @@ memif_socket_init(struct rte_eth_dev *dev, const char *socket_filename)
 			if (socket->listener) {
 				rte_intr_callback_unregister(socket->intr_handle,
 					memif_listener_handler, socket);
-				close(rte_intr_fd_get(socket->intr_handle));
-				rte_intr_fd_set(socket->intr_handle, -1);
+				rte_intr_fd_close(socket->intr_handle);
 				rte_intr_instance_free(socket->intr_handle);
 			}
 			rte_free(socket);
@@ -1191,8 +1194,7 @@ memif_socket_remove_device(struct rte_eth_dev *dev)
 		if (pmd->role != MEMIF_ROLE_CLIENT) {
 			rte_intr_callback_unregister(socket->intr_handle, memif_listener_handler,
 				socket);
-			close(rte_intr_fd_get(socket->intr_handle));
-			rte_intr_fd_set(socket->intr_handle, -1);
+			rte_intr_fd_close(socket->intr_handle);
 			rte_intr_instance_free(socket->intr_handle);
 		}
 		rte_free(socket);
@@ -1290,6 +1292,8 @@ memif_connect_client(struct rte_eth_dev *dev)
 		sockfd = -1;
 	}
 	if (pmd->cc != NULL) {
+		/* fd is closed above, clear reference here. */
+		rte_intr_fd_set(pmd->cc->intr_handle, -1);
 		rte_intr_instance_free(pmd->cc->intr_handle);
 		rte_free(pmd->cc);
 		pmd->cc = NULL;
-- 
2.54.0

