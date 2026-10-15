Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29790CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474C24064F;
	Thu, 15 Oct 2026 13:29:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CE09F402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAoRxooPFWzC8yaJBAXKMXKGvAIpN84VWft1IAUfWQU=;
 b=e7VMfqbCLypf7td9XOaPgZ8ZJJBv/18wB34tAvAVeRRQFi1yCWT0id3jIpGd01OlQLpTsk
 nedhXbg8QJWOi1cHGt8iHGCs3xClKyo4c+m4q1VbbvCBQsS83FsiFLkleXCGeke4tLPU39
 1Xe3CejAaE0zolU6igxoSVkmwZoTefU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-kgwAvYwpODeGGA18ma4fAQ-1; Thu,
 15 Oct 2026 11:29:23 +0000
X-MC-Unique: kgwAvYwpODeGGA18ma4fAQ-1
X-Mimecast-MFC-AGG-ID: kgwAvYwpODeGGA18ma4fAQ_1792063762
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C27051956063; Thu, 15 Oct 2026 11:29:21 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6268D195608A; Thu, 15 Oct 2026 11:29:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, anatoly.burakov@intel.com
Subject: [PATCH v2 1/3] buildtools/chkincs: relax checks on driver headers
Date: Thu, 15 Oct 2026 13:29:14 +0200
Message-ID: <20261015112916.2622825-1-david.marchand@redhat.com>
In-Reply-To: <20261014201627.571496-1-thomas@monjalon.net>
References: <20261014201627.571496-1-thomas@monjalon.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qoaqmTJ-r39ck-I2t_DSjYiIu9A2FBccbwU1PrSSrWw_1792063762
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

Driver headers are common consumers of internal APIs, like for example
the ethdev_pci.h header consumed by net PCI drivers, which calls
internal symbols for allocating/releasing a ethdev port.

Checking that a driver header compiles without allowing internal APIs is
then highly likely to fail.

Relax the check and stop expecting driver headers could compile without
ALLOW_INTERNAL_API.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 buildtools/chkincs/meson.build | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index 9a84c1cc25..df674f74ee 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -49,19 +49,13 @@ sources_drivers = files('main.c')
 sources_drivers += gen_c_files.process(dpdk_drivers_headers)
 
 executable('chkincs-drv', sources_drivers,
-        c_args: cflags,
-        include_directories: includes + includes_drivers,
-        dependencies: deps + deps_drivers,
-        install: false)
-
-executable('chkincs-drv-exp', sources_drivers,
-        c_args: [cflags, '-DALLOW_EXPERIMENTAL_API'],
+        c_args: [cflags, '-DALLOW_INTERNAL_API'],
         include_directories: includes + includes_drivers,
         dependencies: deps + deps_drivers,
         install: false)
 
 executable('chkincs-drv-all', sources_drivers,
-        c_args: [cflags, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
+        c_args: [cflags, '-DALLOW_INTERNAL_API', '-DALLOW_EXPERIMENTAL_API'],
         include_directories: includes + includes_drivers,
         dependencies: deps + deps_drivers,
         install: false)
@@ -101,20 +95,14 @@ cpp_sources_drivers = files('main.cpp')
 cpp_sources_drivers += gen_cpp_files.process(dpdk_drivers_headers)
 
 executable('chkincs-drv-cpp', cpp_sources_drivers,
-        cpp_args: ['-include', 'rte_config.h', cflags],
-        include_directories: includes + includes_drivers,
-        dependencies: deps + deps_drivers,
-        install: false)
-
-executable('chkincs-drv-cpp-exp', cpp_sources_drivers,
-        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API'],
+        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_INTERNAL_API'],
         include_directories: includes + includes_drivers,
         dependencies: deps + deps_drivers,
         install: false)
 
 executable('chkincs-drv-cpp-all', cpp_sources_drivers,
-        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API',
-                   '-DALLOW_INTERNAL_API'],
+        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_INTERNAL_API',
+                   '-DALLOW_EXPERIMENTAL_API'],
         include_directories: includes + includes_drivers,
         dependencies: deps + deps_drivers,
         install: false)
-- 
2.54.0

