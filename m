Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EECFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:45:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00BE9402AC;
	Wed, 29 Apr 2026 13:45:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AB916402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0hixVmn5XeIqz/JshhwFDUvP2j2MbaFr/X/lvwnu2U=;
 b=hNCIti1pVhwJa4+1PjeHrcsn+4qNaJGHSdcL+lb7uGKIcCfFiF6w08kAK77XvF1JHlG3xt
 AvL5Nma0j2Hn9+5wP8i5fqK/PU0+6Mr6bvG6Dy65XAEzyAPBNrKNl8w3bCxub7NPZnRleF
 KFoOLJThwbH3fO9uZP+5C2SZnaw3Zno=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-4fQiGo7kMSyKXJUnoiLwrQ-1; Wed,
 29 Apr 2026 07:45:22 -0400
X-MC-Unique: 4fQiGo7kMSyKXJUnoiLwrQ-1
X-Mimecast-MFC-AGG-ID: 4fQiGo7kMSyKXJUnoiLwrQ_1777463121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FC561800347; Wed, 29 Apr 2026 11:45:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4441B195608E; Wed, 29 Apr 2026 11:45:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 02/23] crypto/octeontx: remove check on driver in remove
Date: Wed, 29 Apr 2026 13:44:35 +0200
Message-ID: <20260429114503.932575-3-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7xbxeZrasPw1UKnmEsHXeL2FBRI7QLtqzlNF_dfuJpY_1777463121
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

