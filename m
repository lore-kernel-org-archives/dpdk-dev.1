Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C37CD3427
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 17:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E3E540270;
	Sun, 10 May 2026 19:03:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8F0994026C
 for <dev@dpdk.org>; Sun, 10 May 2026 19:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8gRTEN3yLVLV7eh/XYvHLWySvA/PIBU+IMzHqxwfBM=;
 b=bner1hEnFjZWOuHIoe5Q1jkcNbTWdizlsRvuc854Mkx0Rul7DDhr6BHCaJL9WHkl71tJPx
 CddQbys/buinPxErLYasW1PXmrLKv3Cgtol5EGSpXJ2EhlSuUQRrV8cSnlPrFV2ziMgJmp
 gMcUqr0fSsYB6PjaOw4xfHon+c4TDPE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-AyJhtHXaNZOaVWeGWFRkYA-1; Sun,
 10 May 2026 13:03:12 -0400
X-MC-Unique: AyJhtHXaNZOaVWeGWFRkYA-1
X-Mimecast-MFC-AGG-ID: AyJhtHXaNZOaVWeGWFRkYA_1778432591
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BB719560B2
 for <dev@dpdk.org>; Sun, 10 May 2026 17:03:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5689219560A2; Sun, 10 May 2026 17:03:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v3 0/5] Remove limitations coming from legacy VMDq
Date: Sun, 10 May 2026 19:03:00 +0200
Message-ID: <20260510170306.3406045-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: co3hrkwMdknJDWh1h0ks2gAAI8BIkOHiyfaObR-AC_s_1778432591
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

Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
VMDq has been imposing a maximum number of mac addresses in the
mac_addr_add/del API.

Nowadays, new Intel drivers do not support the feature and few other
drivers implement this feature.

This series enforces that the driver announces VMDq pools before
using VMDq related features, then remove the limit of number of
mac addresses for others.

Next step could be to remove the VMDq pool notion from the generic API.
However I have some concern about this, as changing the quite stable
mac_addr_add/del API now seems a lot of noise for not much benefit.


-- 
David Marchand

Changes since v2:
- changed approach: did not introduce a new device capability,
  relied on already existing dev_info->max_vmdq_pools,
- fixed duplicate mac addition without VMDq,
- updated documentation,

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,
- fixed buffer overflow on mailbox messages during port restart/VF reset,
- fixed duplicate MAC address installation on port start/restart,


David Marchand (5):
  ethdev: check VMDq availability
  ethdev: skip VMDq pools unless configured
  ethdev: hide VMDq internal sizes
  net/iavf: accept up to 32k unicast MAC addresses
  net/iavf: fix duplicate MAC addresses install

 doc/guides/rel_notes/release_26_07.rst |  15 ++++
 drivers/net/cnxk/cnxk_ethdev_ops.c     |   1 -
 drivers/net/intel/iavf/iavf.h          |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |  43 ++++++----
 drivers/net/intel/iavf/iavf_vchnl.c    | 113 ++++++++++++++++++-------
 lib/ethdev/ethdev_driver.h             |   8 +-
 lib/ethdev/rte_ethdev.c                |  68 +++++++++++----
 lib/ethdev/rte_ethdev.h                |   6 --
 8 files changed, 186 insertions(+), 73 deletions(-)

-- 
2.53.0

