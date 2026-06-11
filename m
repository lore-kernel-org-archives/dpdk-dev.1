Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50387CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69B4B42791;
	Thu, 11 Jun 2026 15:08:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A170F40041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 15:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781183283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ElB6JQWSHyIECjLiayZs10JfW9h7hPnXgduelAomrxs=;
 b=BMN5sgPkHmeMkDZG21hEX9rGx9U1dMsJDFSQ5V2qDkYmOMm/JhTdUPUCPiV0sn+KDG/sw9
 JdjYPhgsJi2xPqhWkuHHBdXyxUTrLVSQe4mzXUvS4LuSareBdGwpu/hE3DG/ZOpBoZaOy6
 94GzYY8YrQd9b9eVX710oUhZrE8eDV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-vS6UcMkzMoylDms4fXQggg-1; Thu,
 11 Jun 2026 09:08:01 -0400
X-MC-Unique: vS6UcMkzMoylDms4fXQggg-1
X-Mimecast-MFC-AGG-ID: vS6UcMkzMoylDms4fXQggg_1781183280
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 896F71944D1C; Thu, 11 Jun 2026 13:08:00 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E7863008B3D; Thu, 11 Jun 2026 13:07:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 0/3] Cleanup rte_dpaa_device
Date: Thu, 11 Jun 2026 15:07:34 +0200
Message-ID: <20260611130738.1720628-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iREfuYUDNkU76C-lI91pkjG7Rxh7jzQ86Xi5kY80tZg_1781183280
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

Similar to the cleanup on the FSLMC bus, the DPAA bus device can
be cleaned.

The rte_dpaa_device object keeps track of a device class object
(cryptodev, dmadev, ethdev) which is a layer violation.

Make use of the device class respective infrastructure and remove those
back references.

Disclaimer: this series is untested as I don't have the hardware.
I only based those changes on look at the code and other drivers.


-- 
David Marchand

David Marchand (3):
  crypto/dpaa_sec: remove cryptodev pointer from bus device
  dma/dpaa: remove dmadev pointer from bus device
  net/dpaa: remove ethdev pointer from bus device

 drivers/bus/dpaa/bus_dpaa_driver.h |  5 ----
 drivers/crypto/dpaa_sec/dpaa_sec.c |  8 ++----
 drivers/dma/dpaa/dpaa_qdma.c       | 39 +++++++++++++++---------------
 drivers/net/dpaa/dpaa_ethdev.c     |  3 +--
 4 files changed, 22 insertions(+), 33 deletions(-)

-- 
2.53.0

