Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29CDCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F25F40687;
	Thu, 15 Oct 2026 13:26:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7B537400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/29Cwbp87OeJVPxbMdtJ3x2isr0jy8mobO3AHoZne0=;
 b=apCMgMc1vsHSZGxN1UhUQxoGEgpn5wZ6UQnt92rFRVRNRMQ/SbDAPseWbnX+hI2TunvEPU
 CQ/RQrM43r3YIR6LI0pdZgSKLW1SP1ktBXLeIr59n6W96cFNDI2DFGcx/rqcd3gN3j6W2P
 mJLyof56NfTkWKEDg1x+izDFuZDYuzo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-deWJtl3fMBaH0x8Ft0ZlSg-1; Thu,
 15 Oct 2026 11:26:24 +0000
X-MC-Unique: deWJtl3fMBaH0x8Ft0ZlSg-1
X-Mimecast-MFC-AGG-ID: deWJtl3fMBaH0x8Ft0ZlSg_1792063584
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9A69180067D; Thu, 15 Oct 2026 11:26:23 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D68CE195608D; Thu, 15 Oct 2026 11:26:22 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH dpdk v2 2/2] meson: add drivers to dynamic libraries
Date: Thu, 15 Oct 2026 13:26:10 +0200
Message-ID: <20261015112607.3008792-6-rjarry@redhat.com>
In-Reply-To: <20261015112607.3008792-4-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015112607.3008792-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: osK-D-BwufoTNHw8LffsMRCsZLJPI7htP-vpme_qbD0_1792063584
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v2: added driver shared libs to the list for pkg-config

 drivers/meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 7146f036c4c9..0e8e69798bdf 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -405,6 +405,10 @@ foreach subpath:subdirs
                 dependencies: static_deps)
 
         dpdk_static_drivers += static_lib
+        if headers.length() > 0
+            dpdk_libraries += shared_lib
+            dpdk_shared_lib_deps += shared_dep
+        endif
 
         set_variable('shared_@0@'.format(lib_name), shared_dep)
         set_variable('static_@0@'.format(lib_name), static_dep)
-- 
2.56.0

