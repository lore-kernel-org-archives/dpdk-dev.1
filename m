Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D5CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 10:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09254427AC;
	Tue, 29 Sep 2026 12:54:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6E2D040FDE
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790679251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTGLdb841FcZVQU2n8MexjvtXQuNDgmiEl/AIe86Vww=;
 b=hlm56ukOzWqvobDwGQnR4WvjSjvzLg/Kn96i9AuJPzxlrSTzgG3oA3bYvaKIRLkffuhrd/
 VNrSEh6C1WPJQ279dyHnzUCHVYWBPyINOYzsh1SyRyTVlHkK68JpFpfeAe2ojTaa1+SLgd
 /OiHcR7J307AkebTOEAV2qtS6AtbJX0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-2UV25terP2GqsDrhyOTCww-1; Tue,
 29 Sep 2026 06:54:08 -0400
X-MC-Unique: 2UV25terP2GqsDrhyOTCww-1
X-Mimecast-MFC-AGG-ID: 2UV25terP2GqsDrhyOTCww_1790679247
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5758319541B7; Tue, 29 Sep 2026 10:54:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.139])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70F4E30000E4; Tue, 29 Sep 2026 10:54:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, david.marchand@redhat.com, dev@dpdk.org,
 Yongji Xie <xieyongji@bytedance.com>, chenbox@nvidia.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
Subject: [PATCH v3 6/9] vhost: claim VDUSE support for API version 1
Date: Tue, 29 Sep 2026 12:53:36 +0200
Message-ID: <20260929105339.1554051-7-eperezma@redhat.com>
In-Reply-To: <20260929105339.1554051-1-eperezma@redhat.com>
References: <20260929105339.1554051-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ID6M6kFx5aCq0FIEtHfyTFOcmxpG1E1biZuAD34AV0E_1790679247
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

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 lib/vhost/vduse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 2d3d8a536773..4950a5da01dd 100644
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
2.55.0

