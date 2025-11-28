Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6878D116F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77494013F;
	Fri, 28 Nov 2025 14:56:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB1D400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0riyaBP9QoxfzbKIIjoHwrp0c03qfPWdZ5vMToeJr+U=;
 b=CJsVwwjBNgr5hbb331IqqDaUr4CHdozJBdAhd+Bhl1nY7fATk8OwZ0wFSTMGoKSWKHcWhS
 yUc3TmOQ95Zu6TNWSnVT1fsBHDpMvzIpL8CbN41O9bbchmWCJkWO5x/dXly8NgkTOPXiK5
 huUpTSL3NcxWOwlM3G8EQTwgMYGJU9k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-tiV_l5WiPXitJKE2TESlRg-1; Fri,
 28 Nov 2025 08:56:20 -0500
X-MC-Unique: tiV_l5WiPXitJKE2TESlRg-1
X-Mimecast-MFC-AGG-ID: tiV_l5WiPXitJKE2TESlRg_1764338180
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADF491800451
 for <dev@dpdk.org>; Fri, 28 Nov 2025 13:56:19 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D42611800240
 for <dev@dpdk.org>; Fri, 28 Nov 2025 13:56:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH 0/7] Fixes for Fedora Rawhide
Date: Fri, 28 Nov 2025 14:56:08 +0100
Message-ID: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IPBH8cqCc_PDcC2q9mM3QClWSUYhOgAy97VdYjT3kRo_1764338180
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

Similary to https://git.dpdk.org/dpdk/commit/?id=f4ef899bb3ae, we have
many strstr/str*chr calls on const char * stored to non const pointers.

This breaks build in Fedora Rawhide as a change in its glibc now
triggers build warnings.

Probably too late for 25.11, but sending in any case...

-- 
David Marchand

David Marchand (7):
  bus/ifpga: fix const pointer in device name parsing
  bus/uacce: fix const pointer in device matching
  drivers: fix some const pointers in qat drivers
  crypto/caam_jr: fix const pointer in UIO filename parsing
  net/enetfec: fix const pointer in UIO filename parsing
  net/memif: fix const pointer in socket check
  app/procinfo: fix const pointer in collectd format

 app/proc-info/main.c                 |  2 +-
 drivers/bus/ifpga/ifpga_bus.c        |  4 ++--
 drivers/bus/uacce/uacce.c            |  2 +-
 drivers/common/qat/qat_device.c      |  7 ++++---
 drivers/common/qat/qat_device.h      |  2 +-
 drivers/compress/qat/qat_comp_pmd.c  |  2 +-
 drivers/crypto/caam_jr/caam_jr_uio.c | 12 ++----------
 drivers/crypto/qat/qat_asym.c        |  2 +-
 drivers/crypto/qat/qat_sym.c         |  2 +-
 drivers/net/enetfec/enet_uio.c       |  8 +-------
 drivers/net/memif/rte_eth_memif.c    |  3 ++-
 11 files changed, 17 insertions(+), 29 deletions(-)

-- 
2.51.1

