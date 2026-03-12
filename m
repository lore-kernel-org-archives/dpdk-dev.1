Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE4D103E301
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6688B40430;
	Thu, 12 Mar 2026 11:36:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C2B6440275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 11:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773311793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1NjExP3YTFFSRFA6kU8gjhwO1AJ5veJaaYU1vo33JnU=;
 b=AXkzR0z5JIq9hBUJqgyRHT+50JSXRKhxa2AlIAXIZH1Iz2H9iGLvrltdVOfmoHcXIOEDTd
 cwD/oWoicJc8Te/fBi3BzDr9W0EaEbM2JD4X+GiWGFwiYW893OQmUbkNAhBR5aqXzA615E
 3E74tOWHShSmAN1a3p0DP+m0Y1CV55o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-2wsT9D8_Mw2vP0ljs08xsQ-1; Thu,
 12 Mar 2026 06:36:32 -0400
X-MC-Unique: 2wsT9D8_Mw2vP0ljs08xsQ-1
X-Mimecast-MFC-AGG-ID: 2wsT9D8_Mw2vP0ljs08xsQ_1773311791
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC15180034E; Thu, 12 Mar 2026 10:36:30 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 336B230001A1; Thu, 12 Mar 2026 10:36:26 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: dev@dpdk.org
Cc: Kevin Traynor <ktraynor@redhat.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/4] vhost: fix resource leak
Date: Thu, 12 Mar 2026 10:36:03 +0000
Message-ID: <20260312103606.702617-2-ktraynor@redhat.com>
In-Reply-To: <20260312103606.702617-1-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VA39jA5k1HpRcCZMUx9MPL7Yjw5WLTm9LO_BwnF_6-I_1773311791
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

When the return value check for pthread_mutex_init() was removed the
out_free label and vhost_user_socket_mem_free() were removed.

The free is still needed as vsocket was not being freed on out_mutex
error path.

Restore vhost_user_socket_mem_free() on error path.

Fixes: 4d2aa150769b ("vhost: remove check around mutex init")
Cc: stable@dpdk.org

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
---
 lib/vhost/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index ae95e7e6b0..278a2c01d8 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -1037,4 +1037,5 @@ rte_vhost_driver_register(const char *path, uint64_t flags)
 		VHOST_CONFIG_LOG(path, ERR, "failed to destroy connection mutex");
 	}
+	vhost_user_socket_mem_free(vsocket);
 out:
 	pthread_mutex_unlock(&vhost_user.mutex);
-- 
2.53.0

