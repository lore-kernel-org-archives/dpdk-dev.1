Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A749C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B6024025A;
	Mon, 31 Aug 2026 09:43:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D4817400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788162184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pYegBasAjivQ+YHie32dx89PYK9wwhG7Tx3EAiLbMVU=;
 b=PFcFMOxCY33oAceLt4CacG3hv0qfbJNv0Fj2QsUhAEelH6jX6/dpMkHtXsb1+CvCElCMzz
 xU7tABXEYERr+Dczme1TEJqrHvl8XEiij9coMGS9Otg+jJLmD6ctwv2PcmuF/MtxZhADny
 LExKW7lfoX8eYrMM0qWMCo3f0zhgrY0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77--GAzP9mnMFOAosD7PhK42A-1; Mon,
 31 Aug 2026 03:43:00 -0400
X-MC-Unique: -GAzP9mnMFOAosD7PhK42A-1
X-Mimecast-MFC-AGG-ID: -GAzP9mnMFOAosD7PhK42A_1788162179
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 679FD1831341; Mon, 31 Aug 2026 07:42:59 +0000 (UTC)
Received: from dmarchan.home (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEB2C362; Mon, 31 Aug 2026 07:42:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Sunil Pai G <sunil.pai.g@intel.com>
Subject: [PATCH] vhost: remove dependency on PCI library
Date: Mon, 31 Aug 2026 09:41:59 +0200
Message-ID: <20260831074159.1506521-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5XxKpvZRcfQQ8LKioJi5LGR3N8XofYGluJvFocO-QCc_1788162179
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
 lib/vhost/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

