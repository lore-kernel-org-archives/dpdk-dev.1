Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CD606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOSgrJEr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCB2740264;
	Thu, 22 Oct 2026 10:26:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 30FBB4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792657588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DP9vENzDEY9VsTStMySujZAVySxD8oxNubriBslNK7M=;
 b=HOSgrJErJrrlyK4Y4An71cE8FTAqF5YUgJlmsStEEPOToCjJk3zokbDHMpkzO62FYrJY+9
 E0Kor8/WyN5UegtTFs7UGjdgwWpLs0KR+LBNnLtCHeybzOquOnSqdV2mrgJa2VglZYOFtl
 CyBYxslV+czVc6DJaYFUJ/vx9ZhQHiY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-g2RyMMfAN9q6J5pL_z4Znw-1; Thu,
 22 Oct 2026 08:26:27 +0000
X-MC-Unique: g2RyMMfAN9q6J5pL_z4Znw-1
X-Mimecast-MFC-AGG-ID: g2RyMMfAN9q6J5pL_z4Znw_1792657586
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B87A1800352; Thu, 22 Oct 2026 08:26:26 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BC1146C; Thu, 22 Oct 2026 08:26:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH] bus/pci: fix interrupt setup for ioport in secondary process
Date: Thu, 22 Oct 2026 10:26:18 +0200
Message-ID: <20261022082618.2730417-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JkW5qs-2pPjVPN45hlC9Jv4gqeA2cNODqDtgWvhPrNw_1792657586
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that the interrupt handle contains a -1 FD by default, the logic in
this code is wrong (yet, checking for a 0 FD was theoretically broken
even before).

The first invocation for a given PCI device will always have a FD < 0,
since no code allocated a interrupt handle in the life of this PCI
device.

Bugzilla ID: 2067
Fixes: 63a0dbf661e5 ("interrupts: mark FDs invalid on allocation")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index fb35bc1d49..94ad31daed 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1189,8 +1189,6 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 
 		vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 		if (vfio_dev_fd < 0) {
-			return -1;
-		} else if (vfio_dev_fd == 0) {
 			if (dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
 					&vfio_dev_fd) != 0)
 				return -1;
-- 
2.54.0

