Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48209606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RCMg1obM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A1B4402C8;
	Sat, 24 Oct 2026 15:21:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8EA1A4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsSM+lLCBvzaQpNLQsgP/JWhy/FN1TMXleaWFm7/0qI=;
 b=RCMg1obM+o9jRT/bdJDPaGiZOfWKhq+YCR0TlcF9TTXWEtibX5rA/T/lyAFkm8TgoYbZ8S
 a+V4BPpUVgR0k3HTGYjw3Mo9KKZUAH6egIosBq74hj/Xss1sSl1nKAz1Td9JnYirUvvqK+
 wc64Sp7IePgybZtalwYft/R7+omX5Ac=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-tcixOWXfP3CFj_Y1yFrSCA-1; Sat,
 24 Oct 2026 09:21:44 -0400
X-MC-Unique: tcixOWXfP3CFj_Y1yFrSCA-1
X-Mimecast-MFC-AGG-ID: tcixOWXfP3CFj_Y1yFrSCA_1792848103
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 600381955F02; Sat, 24 Oct 2026 13:21:43 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2CFF472; Sat, 24 Oct 2026 13:21:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com
Subject: [PATCH v2 00/12] Interrupt fixes for leaks and warnings
Date: Sat, 24 Oct 2026 15:21:25 +0200
Message-ID: <20261024132138.7239-1-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u7k1tY-wY3rs625TvJa-9b2Jhis7kemsEFSu3Ri6dKg_1792848103
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Following commit d770ee9caed0 ("interrupts: warn on leaked FDs"), a
number of leaks, but also false positive warnings have been identified.

The most notable change in this series is the removal of the interrupt
handle duplication. I concluded the principle is wrong (see patch 2
commitlog).
This will need some careful reviews.


-- 
David Marchand

Changes since v1:
- added Anatoly fixes which also extend the interrupt check to efds
  https://patchwork.dpdk.org/project/dpdk/list/?series=39788&state=*


Anatoly Burakov (3):
  eal/linux: fix closing of event FDs not owned by EAL
  eal/linux: fix eventfd leaks when enabling interrupts
  interrupts: warn on leaked event FDs

David Marchand (7):
  eal/linux: reset FD in interrupt handle for uevent
  interrupts: do not duplicate interrupt handles
  net/mana: reset FD in interrupt handle
  net/memif: fix some interrupt FD leaks
  net/memif: reset FD in interrupt handle
  net/sxe2: reset FD in interrupt handle
  raw/ifpga: reset FD in interrupt handle

Stephen Hemminger (2):
  eal/linux: fix FD leak in alarm subsystem
  bus/pci: reset VFIO device FD after release

 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/bus/pci/linux/pci_vfio.c       |  4 +-
 drivers/common/cnxk/roc_platform.h     |  1 -
 drivers/net/mana/mana.c                |  4 ++
 drivers/net/memif/memif_socket.c       | 28 ++++++--
 drivers/net/sxe2/sxe2_irq.c            |  2 +
 drivers/raw/ifpga/ifpga_rawdev.c       |  2 +
 lib/eal/common/eal_common_interrupts.c | 31 ++-------
 lib/eal/freebsd/eal_interrupts.c       | 17 ++---
 lib/eal/include/rte_interrupts.h       | 24 ++-----
 lib/eal/linux/eal_alarm.c              |  1 +
 lib/eal/linux/eal_dev.c                |  4 +-
 lib/eal/linux/eal_interrupts.c         | 94 +++++++++++++++-----------
 13 files changed, 109 insertions(+), 104 deletions(-)

-- 
2.54.0

