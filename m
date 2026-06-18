Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0145ACD98FA
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E734B4066D;
	Thu, 18 Jun 2026 17:29:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AF44A40616
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781796541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0INlPNt/RqWV/rR8zuq6W1S7D2HB0H4FkxiO9JRvWQ=;
 b=S3RTxwRSs/0zCcc6P7fh+cRCqyVayvMO0W9W71O/I50n5E7HYHtHRFmx6HNfLeMfWv5Baz
 stoJC/H1+Uyu0aOoRRQjJz8JChSIAldMuquXhs0U9t6VCGxFhbT2Oasj5woPdDVnOilOkv
 23uD4cP3EVt+uxpQeRT2SUS6RNiSeCk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-JSOz6RYSNhWCHUW1Ynq4PQ-1; Thu,
 18 Jun 2026 11:28:57 -0400
X-MC-Unique: JSOz6RYSNhWCHUW1Ynq4PQ-1
X-Mimecast-MFC-AGG-ID: JSOz6RYSNhWCHUW1Ynq4PQ_1781796535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8282119540E3; Thu, 18 Jun 2026 15:28:55 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.50.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 585CD1800598; Thu, 18 Jun 2026 15:28:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 04/10] bus/pci: fix mapping leak in bus cleanup
Date: Thu, 18 Jun 2026 17:28:19 +0200
Message-ID: <20260618152826.490569-5-david.marchand@redhat.com>
In-Reply-To: <20260618152826.490569-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dt-7BUdK1hywxk9LbIvaxPTdQXQPvYHmwLQUDSYZoPQ_1781796535
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

When calling this bus cleanup, PCI resources were not unmapped.

Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/pci/pci_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index fd18b8772b..791e9a7b49 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -344,6 +344,10 @@ pci_cleanup(void)
 			rte_errno = errno;
 			error = -1;
 		}
+
+		if (drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
+			rte_pci_unmap_device(dev);
+
 		dev->device.driver = NULL;
 
 free:
-- 
2.53.0

