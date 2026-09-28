Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D0C9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 13:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B5240E43;
	Mon, 28 Sep 2026 15:30:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 46C9B40E3B
 for <dev@dpdk.org>; Mon, 28 Sep 2026 15:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790602198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZkuTdMpx1dAu3rw8/q/trRqAoAkyAheXYT4GE6J78U=;
 b=afEoaOVq94IYuksP/ovp6qyfK0iVOsRV4oPkAYEupbm6Cpz9Ts5fIZZ/Wm0i88UB+WeuyT
 7s1speEw179Flm9aUqK/QM/FYOK371KZSVVp4DmQLMmxgjCbR6vzptN2t4WgGwhE3lC7Rb
 2kaC4hd9JPWm4/bHi6dTrGXzacZRhAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-jKwbyr2-N_yvzxPLlLCTLA-1; Mon,
 28 Sep 2026 09:29:55 -0400
X-MC-Unique: jKwbyr2-N_yvzxPLlLCTLA-1
X-Mimecast-MFC-AGG-ID: jKwbyr2-N_yvzxPLlLCTLA_1790602194
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A2ED195F152; Mon, 28 Sep 2026 13:29:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.15])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0731767; Mon, 28 Sep 2026 13:29:51 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>,
 jasowangio@gmail.com, chenbox@nvidia.com, david.marchand@redhat.com
Subject: [PATCH v2 11/11] doc: add release notes for VDUSE live migration
 support
Date: Mon, 28 Sep 2026 15:29:13 +0200
Message-ID: <20260928132913.1376278-12-eperezma@redhat.com>
In-Reply-To: <20260928132913.1376278-1-eperezma@redhat.com>
References: <20260928132913.1376278-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vBhw51eOH-Uv7V8irAgth3yhL7qSVyL8-KDy-sE3AaY_1790602194
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

Document the new VDUSE API version 1 features added to support
live migration:
- Address Space ID (ASID) support
- Virtqueue groups
- Queue ready feature (VDUSE_F_QUEUE_READY)
- Suspend feature (VDUSE_F_SUSPEND)
- Link status support (VIRTIO_NET_F_STATUS)

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 doc/guides/rel_notes/release_26_07.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3d18ba2dd04e..4943b84f8c9b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -104,6 +104,14 @@ New Features
 
   Added network driver for the LinkData network adapters.
 
+* **Added VDUSE API version 1 support in vhost library.**
+
+  Updated VDUSE (vDPA Device in Userspace) support with API version 1 features
+  to enable live migration:
+
+  * Added Address Space ID (ASID) support for multiple independent address spaces
+    per device, enabling better isolation and support for virtqueue groups.
+
 * **Updated Microsoft mana driver.**
 
   Added device reset support to the MANA PMD,
-- 
2.55.0

