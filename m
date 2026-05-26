Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0061CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E21440658;
	Tue, 26 May 2026 10:42:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 921D34066C
 for <dev@dpdk.org>; Tue, 26 May 2026 10:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779784957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NZqaIUMB4LW0BOX2RpA2HN9QH8qfpDccOi4kgJeMPI=;
 b=QizvQ/OlmtutVogLYUwt/ciMtRJhqNX70apsfWwrNCefs1mghy/idCRyQIRmddzfeoJvPh
 Y+id+k94Zh4sDMza64P8okKTQkUOidsi/VBwQE0ht/NMckr76g+cTYhnibV9Ghxk4EWThV
 lgFba9jo+6j/97uDOIjN5eh0mVmzGHA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-BDuMFfPDOSigGjVy8icfuw-1; Tue,
 26 May 2026 04:42:33 -0400
X-MC-Unique: BDuMFfPDOSigGjVy8icfuw-1
X-Mimecast-MFC-AGG-ID: BDuMFfPDOSigGjVy8icfuw_1779784952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F001319560BB; Tue, 26 May 2026 08:42:31 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA29619560AD; Tue, 26 May 2026 08:42:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 03/25] crypto/octeontx: remove check on driver in remove
Date: Tue, 26 May 2026 10:41:43 +0200
Message-ID: <20260526084212.3145685-4-david.marchand@redhat.com>
In-Reply-To: <20260526084212.3145685-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rkr4--UFpF8ieMqqMQLxcEPDBKpPbWtwoWSQzBsJhhs_1779784952
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

The driver reference in the bus-specific device cannot be NULL since
calling the .remove is done after dereferencing this pointer.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Anoob Joseph <anoobj@marvell.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/octeontx/otx_cryptodev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev.c b/drivers/crypto/octeontx/otx_cryptodev.c
index b5ab937c3a..b2f6f53ee3 100644
--- a/drivers/crypto/octeontx/otx_cryptodev.c
+++ b/drivers/crypto/octeontx/otx_cryptodev.c
@@ -87,9 +87,6 @@ otx_cpt_pci_remove(struct rte_pci_device *pci_dev)
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-	if (pci_dev->driver == NULL)
-		return -ENODEV;
-
 	dev_priv = cryptodev->data->dev_private;
 
 	/* free crypto device */
-- 
2.53.0

