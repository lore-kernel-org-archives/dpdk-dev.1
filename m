Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24031CCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 15:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0313F40261;
	Sat,  8 Nov 2025 16:32:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D39BA400D5
 for <dev@dpdk.org>; Sat,  8 Nov 2025 16:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762615937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ysDeXWEFm/qs5iHpic/yPth/M2LqduLRhJ38/NzG/2I=;
 b=EgWlrOQiUKufq8UaDYPMDBYpzxuhR2VtslV+OghOTeAXDVA/MIkHVBmGZPI9IeEYcmTd7w
 /z4sEfBYigx7ft3CVqyMAAWe2YRo4GOYNTWJtwOOox8dRn4KS6+lJOtIrD51+Kk+ytNI/R
 boYl5VRa2/kK/j2cDT2b6JBRg+BzngI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-rmYfx1v2MCW64Eo4CkCPnA-1; Sat,
 08 Nov 2025 10:32:13 -0500
X-MC-Unique: rmYfx1v2MCW64Eo4CkCPnA-1
X-Mimecast-MFC-AGG-ID: rmYfx1v2MCW64Eo4CkCPnA_1762615932
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D60519560B2; Sat,  8 Nov 2025 15:32:12 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18B4C1800578; Sat,  8 Nov 2025 15:32:10 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	maxime@leroys.fr
Subject: [PATCH 0/5] Cleanup rte_dpaa2_device
Date: Sat,  8 Nov 2025 16:32:01 +0100
Message-ID: <20251108153207.1512863-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HpiusWL_w9koc197ke0WFwvSAMJCdI-FrxSB0tk0dN4_1762615932
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

The rte_dpaa2_device object keeps track of a device class object
(cryptodev, dmadev, ethdev, rawdev) which is a layer violation.

Make use of the device class respective infrastructure and remove those
back references.

Disclaimer: this series is untested as I don't have the hardware.
I only based those changes on look at the code and other drivers.


-- 
David Marchand

David Marchand (5):
  crypto/dpaa2_sec: remove crypto device in bus device
  dma/dpaa2: remove DMA device in bus device
  net/dpaa2: remove dead code in loopback mode
  net/dpaa2: remove ethdev device in bus device
  bus/fslmc: remove raw device in bus device

 drivers/bus/fslmc/bus_fslmc_driver.h        |  6 ---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |  8 ++--
 drivers/dma/dpaa2/dpaa2_qdma.c              |  9 ++--
 drivers/net/dpaa2/dpaa2_ethdev.c            |  6 ++-
 drivers/net/dpaa2/dpaa2_ethdev.h            |  6 ---
 drivers/net/dpaa2/dpaa2_recycle.c           | 50 ---------------------
 6 files changed, 14 insertions(+), 71 deletions(-)

-- 
2.51.0

