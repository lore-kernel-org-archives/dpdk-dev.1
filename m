Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC10CA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9006402D5;
	Fri,  9 Oct 2026 13:48:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E66674026F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791546508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j2D6KQJdEQY8WIzxePcCT96q522SxQXyPwB4FTqQTug=;
 b=Itlg/uwVoS3YDp50PeQ5nEkiYxXDvZ9byV2ExRT/r5/zofjlGmuvMRbesCIcItRcZgu7k8
 4vSFj7idpjZ2fhceNvj4dTkx2iXdCb8vrJIxU8HU5c7ews5124FaIa+wKxndHZBkSAysvJ
 A8xp6Sia/JEz0enevIDLzjAdIaucUTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-tHZaIK7fPiyfBdg4dkigzA-1; Fri,
 9 Oct 2026 11:48:24 +0000
X-MC-Unique: tHZaIK7fPiyfBdg4dkigzA-1
X-Mimecast-MFC-AGG-ID: tHZaIK7fPiyfBdg4dkigzA_1791546503
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D43CB1944EBF; Fri,  9 Oct 2026 11:48:22 +0000 (UTC)
Received: from dmarchan.home (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D61D930000E3; Fri,  9 Oct 2026 11:48:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH] drivers/crypto: remove dead code for NXP driver names
Date: Fri,  9 Oct 2026 13:48:18 +0200
Message-ID: <20261009114818.3630839-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fY_OdmchfnOVg0b5VtHgpxNsAepglg8Hp23MvxDJSHY_1791546503
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

Both drivers invoke RTE_PMD_REGISTER_DPAA/RTE_PMD_REGISTER_DPAA2 macros
that overwrites the driver name at registration time.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 3 ---
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..0d638363aa 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4534,9 +4534,6 @@ cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
 static struct rte_dpaa2_driver rte_dpaa2_sec_driver = {
 	.drv_flags = RTE_DPAA2_DRV_IOVA_AS_VA,
 	.drv_type = DPAA2_CRYPTO,
-	.driver = {
-		.name = "DPAA2 SEC PMD"
-	},
 	.probe = cryptodev_dpaa2_sec_probe,
 	.remove = cryptodev_dpaa2_sec_remove,
 };
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..f03efb316d 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3848,9 +3848,6 @@ cryptodev_dpaa_sec_remove(struct rte_dpaa_device *dpaa_dev)
 
 static struct rte_dpaa_driver rte_dpaa_sec_driver = {
 	.drv_type = FSL_DPAA_CRYPTO,
-	.driver = {
-		.name = "DPAA SEC PMD"
-	},
 	.probe = cryptodev_dpaa_sec_probe,
 	.remove = cryptodev_dpaa_sec_remove,
 };
-- 
2.54.0

