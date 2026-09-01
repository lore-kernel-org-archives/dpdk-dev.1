Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE1C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 07:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21E3B402E9;
	Tue,  1 Sep 2026 09:00:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 05DA44027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 09:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788246042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ho4IWL2uSkdvJN1Ik1Kf8gPpdxOOB4CK2OGFNJ9v+LQ=;
 b=T3ZUW7kqavu1NvUi9+Jbe7D+UcW8fAKamT/98W1EZkxzPdhbOAKi6qQSfwBNx5fZLbG8bl
 DPsTCf8ASfREAqhdoS4s1bHwrX/fJyayHZwgm2e4BkNhdzXJji7NcRaRPI5Lr4bk8JI9NR
 virBaFBkOf98zSEPqhWXmA1yK7DtRCM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-f2iyqiFBPFS5tyQJ4DOwLA-1; Tue,
 01 Sept 2026 03:00:37 -0400
X-MC-Unique: f2iyqiFBPFS5tyQJ4DOwLA-1
X-Mimecast-MFC-AGG-ID: f2iyqiFBPFS5tyQJ4DOwLA_1788246036
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 525461944D2B; Tue,  1 Sep 2026 07:00:36 +0000 (UTC)
Received: from dmarchan.home (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83C971955F0D; Tue,  1 Sep 2026 07:00:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Sunil Pai G <sunil.pai.g@intel.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [PATCH v2] vhost: remove dependency on PCI library
Date: Tue,  1 Sep 2026 09:00:24 +0200
Message-ID: <20260901070024.1606766-1-david.marchand@redhat.com>
In-Reply-To: <20260831074159.1506521-1-david.marchand@redhat.com>
References: <20260831074159.1506521-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _O6ZZk2rrXziKnkTylIkH2FPQm6iMSQlYcqKHdEtrMU_1788246036
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

Since the async datapath code switched to dmadev, there is no reason to
depend on the pci library.

Fixes: 53d3f4778c1d ("vhost: integrate dmadev in asynchronous data-path")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- fixed "internal" dependencies of examples,

---
 examples/vdpa/meson.build  | 1 +
 examples/vhost/meson.build | 1 +
 lib/vhost/meson.build      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/examples/vdpa/meson.build b/examples/vdpa/meson.build
index 45f8a6fa31..3a319dd539 100644
--- a/examples/vdpa/meson.build
+++ b/examples/vdpa/meson.build
@@ -12,6 +12,7 @@ if not is_linux
 endif
 
 deps += 'vhost'
+deps += 'pci'
 allow_experimental_apis = true
 sources = files(
         'main.c',
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index e938be8f45..1cf061c597 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -13,6 +13,7 @@ endif
 
 deps += 'vhost'
 deps += 'dmadev'
+deps += 'pci'
 allow_experimental_apis = true
 sources = files(
         'main.c',
diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
index 6a24981d10..64698182cd 100644
--- a/lib/vhost/meson.build
+++ b/lib/vhost/meson.build
@@ -44,4 +44,4 @@ headers = files(
 driver_sdk_headers = files(
         'vdpa_driver.h',
 )
-deps += ['ethdev', 'cryptodev', 'hash', 'pci', 'dmadev']
+deps += ['ethdev', 'cryptodev', 'hash', 'dmadev']
-- 
2.54.0

