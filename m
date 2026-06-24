Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D183CDE002
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEFF040672;
	Wed, 24 Jun 2026 12:44:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 94BD9406B6
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUzMpYiswAaXPByBSwMlmQs7e1bI/26Ws6ZcVObG3Xw=;
 b=UZzDI5XQXVcznsdHUxwX2SasRp+HrgQc68UKbvJHQT/bti2znS2FiWd5pYW1jXHig9bZ83
 l5JAIW/nvdJZjkCT0xxrUcKhf+1mf4EeOjsu1xeVJV5JBlSFWtCLpnyRYoWS+BLrY2BEzD
 C+ZqF8w0y3ygUmqoln7HmyuCEl9+x3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-aJnSmTe2NXC9Vb0bZmA0Mw-1; Wed,
 24 Jun 2026 06:44:03 -0400
X-MC-Unique: aJnSmTe2NXC9Vb0bZmA0Mw-1
X-Mimecast-MFC-AGG-ID: aJnSmTe2NXC9Vb0bZmA0Mw_1782297841
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1448195604C; Wed, 24 Jun 2026 10:44:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 111081800667; Wed, 24 Jun 2026 10:43:56 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v4 05/12] bus/pci: fix mapping leak in bus cleanup
Date: Wed, 24 Jun 2026 12:43:16 +0200
Message-ID: <20260624104324.3576408-6-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7VlW7nLZDgkklWjTpgGY5JzKKbRjrTuFmWyW3dHtJLc_1782297841
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
2.54.0

