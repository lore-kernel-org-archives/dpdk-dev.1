Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DDCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91FDB40665;
	Wed, 12 Nov 2025 10:11:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79D7E4014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kMV18Z2l8hdkBda+Nt+23ZIwTO9Eww2O0MF8d3VoGI=;
 b=gewfcpCviwRAxFY+8jpKdruNbionu4YSTvW1Awc09szQEePp6btr6MKCaPN0JxOQr4eJD6
 sOzZtOVI0Q4hed++crFhhtbShqmyQ1IAZ6w3/AjnDqzqDjaRyCvnPk9fImDv8TwxTTCeOc
 DqgPZ+HWsWUSuoG3sZr4A6RVsGDHOn0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-SxCrXKn5McOtkq1dJQWHOw-1; Wed,
 12 Nov 2025 04:11:04 -0500
X-MC-Unique: SxCrXKn5McOtkq1dJQWHOw-1
X-Mimecast-MFC-AGG-ID: SxCrXKn5McOtkq1dJQWHOw_1762938663
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 530761800250; Wed, 12 Nov 2025 09:11:03 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEF5718004A3; Wed, 12 Nov 2025 09:11:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	maxime@leroys.fr
Subject: [PATCH v2 0/5] Cleanup rte_dpaa2_device
Date: Wed, 12 Nov 2025 10:10:43 +0100
Message-ID: <20251112091049.2669481-1-david.marchand@redhat.com>
In-Reply-To: <20251108153207.1512863-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cQtJIxIR54_-nUT5MZSNaezlao2Oiiyb2ZMQgpq6VWk_1762938663
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

Changes since v1:
- removed (wrong) attempt at fixing a double close bug in patch 4,


David Marchand (5):
  crypto/dpaa2_sec: remove crypto device in bus device
  dma/dpaa2: remove DMA device in bus device
  net/dpaa2: remove dead code in loopback mode
  net/dpaa2: remove ethdev device in bus device
  bus/fslmc: remove raw device in bus device

 drivers/bus/fslmc/bus_fslmc_driver.h        |  6 ---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c |  8 ++--
 drivers/dma/dpaa2/dpaa2_qdma.c              |  9 ++--
 drivers/net/dpaa2/dpaa2_ethdev.c            |  3 +-
 drivers/net/dpaa2/dpaa2_ethdev.h            |  6 ---
 drivers/net/dpaa2/dpaa2_recycle.c           | 50 ---------------------
 6 files changed, 11 insertions(+), 71 deletions(-)

-- 
2.51.0

