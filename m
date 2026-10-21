Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9718606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ddu96M9b
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69839409FA;
	Wed, 21 Oct 2026 11:23:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D7D6940689
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPCojlRiZRt4T+mVk3++69Nu2MYIJj3lh79J4+8maCY=;
 b=Ddu96M9bALJZCiSgPtPzdsLOi7j1CAiPW94D5esEOWneKPf44x3SF6IcWvYbGXa27S6cIq
 OUyYML+Ycymc97rS7si/6cArGHvNiMEZfu4VHyVJNYwmbWFBRdDUsQ1knYXZR9YV9QzdYk
 GuXmcKk3vuhydbR8buSW90Ps+W5m/U4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-snPI1QQ2N56NTjx3Q-QnFw-1; Wed,
 21 Oct 2026 05:23:53 -0400
X-MC-Unique: snPI1QQ2N56NTjx3Q-QnFw-1
X-Mimecast-MFC-AGG-ID: snPI1QQ2N56NTjx3Q-QnFw_1792574631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6816819560AE; Wed, 21 Oct 2026 09:23:51 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95EF8195608A; Wed, 21 Oct 2026 09:23:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, stable@dpdk.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 6/9] net/memif: fix some interrupt FD leaks
Date: Wed, 21 Oct 2026 11:23:15 +0200
Message-ID: <20261021092318.1554295-7-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RGhojBK8szALwHVVbzAWtoMMH6qWGATfAwUiQvASjRg_1792574631
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

Fix several resource leaks in error handling and cleanup paths:

In memif_socket_create(), when rte_intr_callback_register() fails,
return via error path instead of returning directly, ensuring sockfd,
sock and intr_handle are properly cleaned up.

In memif_socket_init(), when rte_hash_add_key_data() fails, clean up
the newly created socket including unregistering callback, closing fd
and freeing intr_handle for listener sockets.

In memif_socket_remove_device(), unregister the listener callback and
close the socket fd before freeing the interrupt handle.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/memif/memif_socket.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 2d16decbef..bd52a95473 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -1051,7 +1051,7 @@ memif_socket_create(char *key, uint8_t listener, bool is_abstract, uid_t owner_u
 		if (ret < 0) {
 			MIF_LOG(ERR, "Failed to register interrupt "
 				"callback for listener socket");
-			return NULL;
+			goto error;
 		}
 	}
 
@@ -1115,6 +1115,14 @@ memif_socket_init(struct rte_eth_dev *dev, const char *socket_filename)
 		ret = rte_hash_add_key_data(hash, key, socket);
 		if (ret < 0) {
 			MIF_LOG(ERR, "Failed to add socket to socket hash.");
+			if (socket->listener) {
+				rte_intr_callback_unregister(socket->intr_handle,
+					memif_listener_handler, socket);
+				close(rte_intr_fd_get(socket->intr_handle));
+				rte_intr_fd_set(socket->intr_handle, -1);
+				rte_intr_instance_free(socket->intr_handle);
+			}
+			rte_free(socket);
 			return ret;
 		}
 	}
@@ -1180,8 +1188,13 @@ memif_socket_remove_device(struct rte_eth_dev *dev)
 				MIF_LOG(ERR, "Failed to remove socket file: %s",
 					socket->filename);
 		}
-		if (pmd->role != MEMIF_ROLE_CLIENT)
+		if (pmd->role != MEMIF_ROLE_CLIENT) {
+			rte_intr_callback_unregister(socket->intr_handle, memif_listener_handler,
+				socket);
+			close(rte_intr_fd_get(socket->intr_handle));
+			rte_intr_fd_set(socket->intr_handle, -1);
 			rte_intr_instance_free(socket->intr_handle);
+		}
 		rte_free(socket);
 	}
 }
-- 
2.54.0

