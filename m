Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8C606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.a=rsa-sha256 header.s=mx header.b=L/rTIcAO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA8F4402A4;
	Mon, 16 Nov 2026 08:39:19 +0100 (CET)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTPS id C7DE140294;
 Mon, 16 Nov 2026 08:39:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru F3D2B2C0B99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1794814757; bh=+G5oA4m2+fop4xT5i2yt99UveXHgo+nGNR5bl9zx8FI=;
 h=From:To:CC:Subject:Date:From;
 b=L/rTIcAOGBIMBwktUEpxqLe+6dr8y+E43XaW04QeIF1/EphJcRcbLa8PpGxFiBBIg
 wUV9dM8qWvxPYrBEhUlavYyjKsS9zXhhM/Wy4+fVXEGFv9V5rlU0RC77+AHsLsvdTN
 kAiQcthW46hVerL17xI4YHZAsmy6bRmUFZao5ux4=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id F3D2B2C0B99;
 Mon, 16 Nov 2026 10:39:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt C30062C0B8E
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id C30062C0B8E;
 Mon, 16 Nov 2026 10:39:16 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: check backing ethdev after creation
Date: Mon, 16 Nov 2026 07:39:14 +0000
Message-ID: <20261116073914.236781-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/11/16 06:45:00 #28892229
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

Check whether the backing Ethernet device was successfully retrieved.
If the device is not found, return -ENODEV

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 23edd94444..8dcf62f176 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6994,6 +6994,9 @@ static int bnxt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 			return ret;
 
 		backing_eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+		if (backing_eth_dev == NULL) {
+			return -ENODEV;
+		}
 	}
 	PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d pci probe",
 		    backing_eth_dev->data->port_id);
-- 
2.30.2

