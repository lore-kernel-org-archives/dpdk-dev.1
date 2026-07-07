Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA04C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28C8409FA;
	Tue,  7 Jul 2026 14:45:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2765340A87
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9A4MOt2o+F03Gn1K9t7ud4oCpW1CHIqQz+wP4SDtS2A=;
 b=CWDSF+fjKHa7sgJ1Vu72z94LMHOrYJ/MJBCpNSgXYDeW0Ke3x5uiwab65WM4qWnTFgsaSS
 h3bH2VO7aBLx8aun6Wzv7EBKxA4HDnoSBLhQJ5C114M1mwBD04x2DAjuG4Kk0lRFpXjrTU
 HSW0xZgKY23Vj2ls7pV6ght8exWyH14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Oyus5YNGPSa6_OD_7kCqBQ-1; Tue,
 07 Jul 2026 08:45:47 -0400
X-MC-Unique: Oyus5YNGPSa6_OD_7kCqBQ-1
X-Mimecast-MFC-AGG-ID: Oyus5YNGPSa6_OD_7kCqBQ_1783428346
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7861C180130E; Tue,  7 Jul 2026 12:45:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D279218005B5; Tue,  7 Jul 2026 12:45:43 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, david.marchand@redhat.com,
 dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com
Subject: [RFC v4 11/11] doc: add release notes for VDUSE live migration support
Date: Tue,  7 Jul 2026 14:45:07 +0200
Message-ID: <20260707124507.251729-12-eperezma@redhat.com>
In-Reply-To: <20260707124507.251729-1-eperezma@redhat.com>
References: <20260707124507.251729-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h66OyovAaYe1fefzi0RKjk4y_5qBnEtePKVe-m7PALA_1783428346
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
 doc/guides/rel_notes/release_26_07.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6352ef27ab05..22c4da3efed6 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -131,6 +131,23 @@ New Features
   to support adding and removing memory regions without resetting
   the whole guest memory map.
 
+* **Added VDUSE API version 1 support in vhost library.**
+
+  Updated VDUSE (vDPA Device in Userspace) support with API version 1 features
+  to enable live migration:
+
+  * Added Address Space ID (ASID) support for multiple independent address spaces
+    per device, enabling better isolation and support for virtqueue groups.
+  * Added virtqueue group support to assign different virtqueues to separate
+    address spaces (e.g., control queue vs data queues).
+  * Added ``VDUSE_F_QUEUE_READY`` feature for explicit dataplane queue
+    readiness signaling, ensuring proper device initialization ordering
+    during live migration.
+  * Added ``VDUSE_F_SUSPEND`` feature to reliably suspend virtqueue processing
+    and fetch virtqueue state during live migration.
+  * Added ``VIRTIO_NET_F_STATUS`` support for link status reporting and
+    gratuitous ARP signaling in VDUSE network devices.
+
 * **Added LinkData sxe2 ethernet driver.**
 
   Added network driver for the LinkData network adapters.
-- 
2.55.0

