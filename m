Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F61CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D3BB402E7;
	Fri, 16 Oct 2026 17:39:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7258640291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792165138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BypdfU2Xmw5NotLGE/rB2KaCd5Nes4SjCx3rpT2sMCU=;
 b=G5akr/2Ms1ZKdJxwYo6QmaFYYToxooezbOWtcW0Zv6UE00UhgF6mW/lES1LJlQcgsvHBlI
 6yyLI/+VFOGuXE6pe0Odu0H0RY6JG/+NaIBLj0oJ22YBWDTtNJiC5adt1dJfoSOge9LrvJ
 MWzFw8kxKwULjz6vrD5YaotR51CWimU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-rFbfPWFqNByJRgsfdalgzg-1; Fri,
 16 Oct 2026 15:38:56 +0000
X-MC-Unique: rFbfPWFqNByJRgsfdalgzg-1
X-Mimecast-MFC-AGG-ID: rFbfPWFqNByJRgsfdalgzg_1792165135
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B744119300FE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:38:50 +0000 (UTC)
Received: from ringo.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F1D0180886A; Fri, 16 Oct 2026 15:38:49 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v3 0/2] Fix dynamic link of driver symbols with pkgconf
Date: Fri, 16 Oct 2026 17:38:09 +0200
Message-ID: <20261016153807.4020321-5-rjarry@redhat.com>
In-Reply-To: <20261015100921.2944274-5-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G7BhHQyK39UeF-cN4X1kGsMbLMPA-WSpxn95HEWGpXw_1792165135
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

v3:

- Added all shared driver libs to pkg-config, regardless if they have
  a public API. -Wl,--as-needed prevents overlinking at build time.
- Simplified to a single .pc file now that all libraries are listed in
  the correct order.

v2: Added missing update to dpdk_libraries for pkg-config

Robin Jarry (2):
  meson: rename static drivers list
  meson: add all drivers to dynamic libraries

 app/meson.build                   |  2 +-
 buildtools/pkg-config/meson.build | 65 ++++++++++++++++---------------
 buildtools/subproject/meson.build |  2 +-
 drivers/meson.build               |  4 +-
 examples/meson.build              |  2 +-
 meson.build                       |  3 +-
 6 files changed, 42 insertions(+), 36 deletions(-)

-- 
2.56.0

