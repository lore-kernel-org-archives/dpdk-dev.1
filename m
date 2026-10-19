Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85200CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D07740430;
	Mon, 19 Oct 2026 15:48:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A19CF40664
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792417724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCEuCi2qcKSvX6rD85itD7kL3vRQdS2oCCwLLzNeKr8=;
 b=IMd9ZuEuE5cym3C4PFM0zG1Fe0uS967W9UfwLT2S5gKIEZbzc6kJXVWdktFFpWdxbZSsZK
 90o5dFr8751C3G2YVYLboMZP5VQzddvV5O93X1dv/YwC+FDdPvejOUDRFq9Av8Tlne2GFy
 9qt8iauWVXCn8IYi8+4bOWPmogt6JS4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-BdNqpLgHODKFolSuKqpIog-1; Mon,
 19 Oct 2026 13:48:42 +0000
X-MC-Unique: BdNqpLgHODKFolSuKqpIog-1
X-Mimecast-MFC-AGG-ID: BdNqpLgHODKFolSuKqpIog_1792417719
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6E001954214; Mon, 19 Oct 2026 13:48:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72E511800257; Mon, 19 Oct 2026 13:48:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com,
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 6/9] vhost: claim VDUSE support for API version 1
Date: Mon, 19 Oct 2026 15:48:05 +0200
Message-ID: <20261019134808.192525-7-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-1-eperezma@redhat.com>
References: <20261019134808.192525-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cMhMRtOIxbN0yLHWSlsgjosl9m1D0jSE9Q7SbUm__x0_1792417719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 34ed6fce88ee..daa41ee42761 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -25,7 +25,7 @@
 #include "vhost.h"
 #include "virtio_net_ctrl.h"
 
-#define VHOST_VDUSE_API_VERSION 0ULL
+#define VHOST_VDUSE_API_VERSION 1ULL
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
 
 struct vduse {
-- 
2.56.0

