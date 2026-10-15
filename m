Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0952ECC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF79B4064E;
	Thu, 15 Oct 2026 12:10:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AD4B540430
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792059010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhRDySAfVnPs/RwSFfy28UQXGdJiy/Ql1BYXw7TPAzQ=;
 b=NkA5TCTWHHU4pYt+7PR8ta05VHnmgCKJ01h9uSdZbeFmzctF39TwnAHigXkkZ/7suFCmvq
 J9il+eMUa0VRS122GKFcXWmIGmyuTbv84yVsDRm7i9Pe895FIBWH9CuA5ravZ1gM1HWMIn
 bj6GWHZelq6ia9zjQXBOnNSBecXKi7o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-pLgPs6QmNjuhCpD15c9sOg-1; Thu,
 15 Oct 2026 10:10:08 +0000
X-MC-Unique: pLgPs6QmNjuhCpD15c9sOg-1
X-Mimecast-MFC-AGG-ID: pLgPs6QmNjuhCpD15c9sOg_1792059007
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BF119560B8
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:10:07 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB7B31803A40; Thu, 15 Oct 2026 10:10:06 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 2/2] meson: add drivers to dynamic libraries
Date: Thu, 15 Oct 2026 12:09:24 +0200
Message-ID: <20261015100921.2944274-7-rjarry@redhat.com>
In-Reply-To: <20261015100921.2944274-5-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k-QGlKncjwuj2wzfcn0-qbxr88aSwPLvcwY9fJQFlpc_1792059007
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

dpdk_shared_lib_deps only collects library dependencies, so DPDK built
as a meson subproject with shared libraries never links against
drivers that install public headers (e.g. bus/pci, bus/vdev). Add
these drivers to dpdk_shared_lib_deps as well, mirroring what is
already done for libraries in lib/meson.build.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 7146f036c4c9..37b152979109 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -405,6 +405,9 @@ foreach subpath:subdirs
                 dependencies: static_deps)
 
         dpdk_static_drivers += static_lib
+        if headers.length() > 0
+            dpdk_shared_lib_deps += shared_dep
+        endif
 
         set_variable('shared_@0@'.format(lib_name), shared_dep)
         set_variable('static_@0@'.format(lib_name), static_dep)
-- 
2.56.0

