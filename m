Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BFCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:26:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32AA3402DA;
	Thu, 15 Oct 2026 13:26:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 741D9400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9r7TNjEjBgMKTddMtdtXjfXWgZ4YBxitd0KrX12yq2E=;
 b=Rge9dU94HrmuKat5aWGhijDP2c6Ptj/+QsfJskKE9QtI1O+LxeVo/JtGnHOzoyrRcQ5r/M
 uQvZU/h8F4V09UcEfalQYNsqmLeaPp5ikcWubBYCyhVzg8/6PciCzsNnsoss9G5zxNXqQE
 Lt97XjSR7ExUdYGQz4lgej0ys7pTzb0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-L3w6BhMKM8eeCjZJzavB3g-1; Thu,
 15 Oct 2026 11:26:21 +0000
X-MC-Unique: L3w6BhMKM8eeCjZJzavB3g-1
X-Mimecast-MFC-AGG-ID: L3w6BhMKM8eeCjZJzavB3g_1792063581
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC433180067D
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:26:20 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EC4A195608A; Thu, 15 Oct 2026 11:26:19 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v2 0/2] Fix dynamic link of driver symbols with pkgconf
Date: Thu, 15 Oct 2026 13:26:08 +0200
Message-ID: <20261015112607.3008792-4-rjarry@redhat.com>
In-Reply-To: <20261015100921.2944274-5-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SdXJpA_pkN7afxB-HnKvGkPjlHoja-Skka4M5rjFHdc_1792063581
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

When building against dynamic libraries using pkg-config, linking fails
because symbols exposed by drivers are not found:

	/usr/bin/x86_64-linux-gnu-ld.bfd: ....o:(.data.rel.ro+0x148):
		undefined reference to `rte_pci_dump'

That symbol is in librte_bus_pci.so which is *not* listed in the libs
section of the pkg-config file.

This series is about fixing this.

v2: Added missing update to dpdk_libraries for pkg-config

Robin Jarry (2):
  meson: rename static drivers list
  meson: add drivers to dynamic libraries

 app/meson.build                   | 2 +-
 buildtools/pkg-config/meson.build | 2 +-
 buildtools/subproject/meson.build | 2 +-
 drivers/meson.build               | 6 +++++-
 examples/meson.build              | 2 +-
 meson.build                       | 2 +-
 6 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.56.0

