Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42541CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:46:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D1442FBF;
	Thu, 11 Jun 2026 11:46:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 900E142FBD
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0INlPNt/RqWV/rR8zuq6W1S7D2HB0H4FkxiO9JRvWQ=;
 b=SDAi9Vg/sy69BgKGcTuBpdwMn3Pn/fIlNGHV7Ddp5HBYqy47zU6AMT9yZTx6+uAlZY9PCS
 m83ZYwgoJj05iPgWQL0aU1xSkYIdkLB9l1nracAyBQAV6sWHQKixHJIVD/7fSYFsmUH4Od
 DHlGi3AEMTk5BMGIBOdsRBkFTFa/khs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-oYCMZa2LOReQRa6pjUdRmQ-1; Thu,
 11 Jun 2026 05:46:36 -0400
X-MC-Unique: oYCMZa2LOReQRa6pjUdRmQ-1
X-Mimecast-MFC-AGG-ID: oYCMZa2LOReQRa6pjUdRmQ_1781171195
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32C801801323; Thu, 11 Jun 2026 09:46:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DAD7E1800591; Thu, 11 Jun 2026 09:46:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH 06/13] bus/pci: fix mapping leak in bus cleanup
Date: Thu, 11 Jun 2026 11:45:43 +0200
Message-ID: <20260611094551.1514962-7-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -eKzFA7N3t9IF3tIGCnF1QDYBCOq96PwLHmffl08G4Q_1781171195
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

