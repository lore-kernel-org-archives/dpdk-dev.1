Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE4FC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BBC74060C;
	Fri, 31 Jan 2025 14:10:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EBF3940281
 for <dev@dpdk.org>; Fri, 31 Jan 2025 14:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738329007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qmgS+x8WxmRvPTfipBqk3gG6p7zJtzp4bQWjSCpvAgQ=;
 b=J+rKTh8xXUgdp9FrfpxVxksg28S99ZmmWWyLWHugr2GpBUss98UiBQZnKVfKx3Ar0rCkCl
 xNgpYgSwBzyxCq/vq2NLFdXNL38Lnuf0/FCGxG1nH2dpNDt8gPTLuUcsX0sI/0+1ElHhq/
 yKcOxlsNFM9zdoe7WZYFr4oiiTHs+gQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-kmqTPuMeM1CzV49Q059cXA-1; Fri,
 31 Jan 2025 08:10:04 -0500
X-MC-Unique: kmqTPuMeM1CzV49Q059cXA-1
X-Mimecast-MFC-AGG-ID: kmqTPuMeM1CzV49Q059cXA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8441800370; Fri, 31 Jan 2025 13:10:03 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F08561800268; Fri, 31 Jan 2025 13:10:00 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org, otilibil@eurecom.fr, david.marchand@redhat.com,
 chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vhost: fix VDUSE devices registration
Date: Fri, 31 Jan 2025 14:09:57 +0100
Message-ID: <20250131130957.293562-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 51Mu3XuHEM2N-Iieg7anr69PKzVshL7s7hqNcPsLCcU_1738329003
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

This patch fixes a regression in vhost_driver_register()
causing VDUSE devices registration to fail systematically
because the return value was initialized to -1 and not
changed later on for this type of devices.

Fixes: 4d2aa150769b ("vhost: remove check around mutex init")

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/socket.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 433a42bf80..894a0f0dcb 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -893,7 +893,6 @@ vhost_user_socket_mem_free(struct vhost_user_socket *vsocket)
 int
 rte_vhost_driver_register(const char *path, uint64_t flags)
 {
-	int ret = -1;
 	struct vhost_user_socket *vsocket;
 
 	if (!path)
@@ -997,7 +996,6 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	} else {
 #ifndef RTE_LIBRTE_VHOST_POSTCOPY
 		VHOST_CONFIG_LOG(path, ERR, "Postcopy requested but not compiled");
-		ret = -1;
 		goto out_mutex;
 #endif
 	}
@@ -1012,15 +1010,14 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 		} else {
 			vsocket->is_server = true;
 		}
-		ret = create_unix_socket(vsocket);
-		if (ret < 0)
+		if (create_unix_socket(vsocket) < 0)
 			goto out_mutex;
 	}
 
 	vhost_user.vsockets[vhost_user.vsocket_cnt++] = vsocket;
 
 	pthread_mutex_unlock(&vhost_user.mutex);
-	return ret;
+	return 0;
 
 out_mutex:
 	if (pthread_mutex_destroy(&vsocket->conn_mutex)) {
@@ -1028,8 +1025,7 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 	}
 out:
 	pthread_mutex_unlock(&vhost_user.mutex);
-
-	return ret;
+	return -1;
 }
 
 static bool
-- 
2.48.1

