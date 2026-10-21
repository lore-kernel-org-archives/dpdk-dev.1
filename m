Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D0606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a56SArcF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A905C40A67;
	Wed, 21 Oct 2026 11:23:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EEB57406B4
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQbiSFc7dfbcjJkI6uNLx03SpEWH+bBrbbX3RDm8gFo=;
 b=a56SArcF1uDxOWCmelmE+naFjUOtbgs5bpNyA3QKIXTeCcKS06MiXK5eoNECu40C+NSdvT
 j2sx5gFQfXCzlcwXKKh/NFXJO7kwpPwlPzqR2PDaxcnvydFHWjf+b8j73fvlHvLKy25w9s
 TYVDwmMv5szWsSq/xokmmyK11UeKjUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-xRKk2hEaObKIj3uASQIfRw-1; Wed,
 21 Oct 2026 09:23:45 +0000
X-MC-Unique: xRKk2hEaObKIj3uASQIfRw-1
X-Mimecast-MFC-AGG-ID: xRKk2hEaObKIj3uASQIfRw_1792574623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79E9F1800633; Wed, 21 Oct 2026 09:23:43 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BDF91956087; Wed, 21 Oct 2026 09:23:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 4/9] bus/pci: reset VFIO device FD after release
Date: Wed, 21 Oct 2026 11:23:13 +0200
Message-ID: <20261021092318.1554295-5-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dGYI-Rt5qnQ1CFhes4UNeFpHtTiMtgwZ5Ev5FJzapoo_1792574623
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stephen Hemminger <stephen@networkplumber.org>

The VFIO device fd is closed by dev_vfio_release_device() but is left
in the interrupt handle, so freeing the handle on cleanup logs a bogus
FD leak warning.

Mark dev_fd invalid after release.

In secondary process the request handle is unused and does not have to
be set in the first place.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index fb35bc1d49..c81d20200d 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -998,8 +998,6 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 	/* we need save vfio_dev_fd, so it can be used during release */
 	if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
 		goto err_map;
-	if (rte_intr_dev_fd_set(dev->vfio_req_intr_handle, vfio_dev_fd))
-		goto err_map;
 
 	return 0;
 err_map:
@@ -1103,6 +1101,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
@@ -1142,6 +1141,7 @@ pci_vfio_unmap_resource_secondary(struct rte_pci_device *dev)
 		PCI_LOG(ERR, "Cannot release VFIO device");
 		return ret;
 	}
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	vfio_res_list =
 		RTE_TAILQ_CAST(dev_vfio_tailq.head, mapped_pci_res_list);
-- 
2.54.0

