Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B6FD8FD3
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA0F8402E7;
	Thu, 26 Feb 2026 17:21:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 66890402E6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHYHZX3pbA6Oj0e0IqFpTpECVPeiPNKKJWVEZkTpNJw=;
 b=XLlX9C43Zn9HDloEZgRFWUiXbgtvrUKIH3zSzPxXCxpm6R8ohofP4Xa+c/GX5hvNIFEzFB
 FNFIBX5kQUHS6ja6GiMiEECPV9THCIjyEgVueyqfGWRCkBI4q44/hTp3rYJotUOVVF4ODS
 BPz7n8AdVU4B26ytNNV0Yzaxfvc9Qgw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587--v5LTrhmPf-wm5w_ZjhcDg-1; Thu,
 26 Feb 2026 11:21:04 -0500
X-MC-Unique: -v5LTrhmPf-wm5w_ZjhcDg-1
X-Mimecast-MFC-AGG-ID: -v5LTrhmPf-wm5w_ZjhcDg_1772122863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B537F180061C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 16:21:03 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F111B1800351
 for <dev@dpdk.org>; Thu, 26 Feb 2026 16:21:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [RFC v2 0/5] Rework device probing
Date: Thu, 26 Feb 2026 17:20:51 +0100
Message-ID: <20260226162057.207202-1-david.marchand@redhat.com>
In-Reply-To: <20260225112922.3982104-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FM6l-XF9Xl1_TzlvI7l2s4SPx9apBJShJ6SszK2LRHQ_1772122863
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

Applications relying on device hotplug don't work well with the default
probing of all available resources.
This series proposes to change this behavior via a new EAL option.


-- 
David Marchand

Changes since RFC v1:
- reviewed bus probe() and cleaned up NXP drivers,
- changed approach following Bruce comment,

David Marchand (5):
  devtools: check packet forwarding in null test
  bus/fslmc: fix bus cleanup
  drivers/bus: require probe function for NXP drivers
  bus: factorize device selection
  eal: configure initial device probing

 app/test/test_eal_flags.c                 |  9 +++++++
 devtools/test-null.sh                     | 10 +++++--
 doc/guides/linux_gsg/eal_args.include.rst |  6 +++++
 drivers/bus/auxiliary/auxiliary_common.c  | 15 +----------
 drivers/bus/cdx/cdx.c                     | 21 +--------------
 drivers/bus/dpaa/dpaa_bus.c               | 26 ++++++------------
 drivers/bus/fslmc/fslmc_bus.c             | 29 ++++++--------------
 drivers/bus/fslmc/fslmc_vfio.c            | 22 +++++-----------
 drivers/bus/pci/pci_common.c              | 15 +----------
 drivers/bus/platform/platform.c           | 28 ++------------------
 drivers/bus/uacce/uacce.c                 | 22 +---------------
 drivers/bus/vmbus/vmbus_common.c          | 21 +--------------
 drivers/dma/idxd/idxd_bus.c               | 32 +++++++++--------------
 lib/eal/common/eal_common_bus.c           | 31 ++++++++++++++++++++++
 lib/eal/common/eal_common_options.c       |  3 +++
 lib/eal/common/eal_option_list.h          |  1 +
 lib/eal/common/eal_private.h              |  6 +++++
 lib/eal/include/bus_driver.h              |  7 +++++
 18 files changed, 112 insertions(+), 192 deletions(-)

-- 
2.53.0

