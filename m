Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8BC5DF66
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 20:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1430B40658;
	Thu, 13 Aug 2026 22:17:56 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id 37F304026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 22:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1003; q=dns/txt;
 s=iport01; t=1786652274; x=1787861874;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VzS4o9wsuvIm6eKWaLvXEGj4XqzN2BE+7mhBolStq38=;
 b=hdpFeS4AZI6RdVddvl6tVVAohzZOsHIjo3EtFXAmjYQqca2tN+83rBfk
 2WBAiSFR9onm9iBhtzHpnLcxWvLeSPLZ+JFl0eEsFUfpWGCFZb9Jupk0x
 FjKh7S9q2jxWFsW8bOXOzpun1F1o6S3B/dRNdSOTjuGJE2sY2fipFMrVw
 GpRDHzOE7PrAF2NG1ogQhZ4MmN4DmES8NdHnD1pY3Vjf/9nvYBnj3Q6ki
 Xt43oWQ9XIyu3EnCe27ZfYpzY6V4V9TM1mA2GF+Gbxevcf1CXmme3SPQt
 6Ns+LVZKG3LUu8zWV2hDVgbgPoQcCjaX/83lhU10q04/b8NHt+yj+j/G5 w==;
X-CSE-ConnectionGUID: RoGObpxdSRSc7obgodARtw==
X-CSE-MsgGUID: 3g1kl1UmQnesYzviEIvn1Q==
X-IPAS-Result: =?us-ascii?q?A0A9AgDxJH5q/5IQJK1aglmCV4FSQ0m0aIF+DwEBAQ9RB?=
 =?us-ascii?q?AEBhQWNagImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zch?=
 =?us-ascii?q?l02AUaBUIMCgnUDwU2CLIEBhH3ZSoFmAQsUAYE4jWCFcicbgUlEgRWDaYUQh?=
 =?us-ascii?q?XgEgy6TGUiBHgNZLAFVEw0KCwcFgWYDNRIqFW4yHYEjPheBDRsGBYEdgSiEN?=
 =?us-ascii?q?SMZNnqBCV6BKyplARIXgQmCFQKCc4EoYQIBSQsLGA1IESw3FBkEPm4Hjh0gg?=
 =?us-ascii?q?kcObROCFMdJhCihWxozqmsBmQiCAaJZhGmBaDyBWTMaCBsVgyJTGQ+OLRbQF?=
 =?us-ascii?q?SsyPwcCBw8Ck3EBAQ?=
IronPort-Data: A9a23:TUtk9KuA87GDW3RDA24LkqMyb+fnVOdcMUV32f8akzHdYApBsoF/q
 tZmKTzUOvnZZWH3c4xwa9jnoE4A78fVx4BrGVRq/ytgEiITgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZTdJ5xYuajhKs/La80s21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwwOFYJmtW5
 fAjEgsGMReJiOW66YinVbw57igjBJGD0II3s3Vky3TdSP0hW52GG/SM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgl/5JEWxI9EglHlbzxTpXqepLE85C7YywkZPL3FYIKJIYPQGZsP9qqej
 jnJpmf9WywfDdqS0guX7HOBp/HJxBquDer+E5X9rJaGmma7ymENIBEOWVj9puO24nNSQPpWL
 0gSvy5rpq8o+QnzH5/2XgazpziPuRt0t8dsLtDWITqlksL8izt1zEBdJtKdQLTKbPMLeAE=
IronPort-HdrOrdr: A9a23:y/b2j6DNcTaWEUPlHely55DYdb4zR+YMi2TDGXocdfUzSL37qy
 nAppomPHPP4gr5O0tQ+uxoWpPgfZq0z/ccirX5Vo3MYOCJggaVBbAnxZf+wjHmBi31/vNQ2O
 NdaaRkYeeAaGSS9fyb3CCIV/A93dKA7Kekwc3az3trUEVWTpsI1XYcNu5eeXcGIjWvwvECZf
 2h2vY=
X-Talos-CUID: 9a23:1oQ2tGx3mnorHUrZmQyuBgUuHe8CeGXNwEzqGETnDmxmT7G8c0OPrfY=
X-Talos-MUID: 9a23:OBMLZgqa3wahWxAVmG0ez2ptbcRsupmrMUYAiqQUpcipFDJ2Yg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,221,1779148800"; d="scan'208";a="804372462"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Aug 2026 20:17:53 +0000
Received: from rtice-VMware20-1 (unknown [10.189.17.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rtice@cisco.com)
 by alln-l-core-09.cisco.com (Postfix) with ESMTPSA id 8865718000167;
 Thu, 13 Aug 2026 20:17:52 +0000 (GMT)
From: Randy Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Randy Tice <rtice@cisco.com>
Subject: [PATCH] eal/linux: harden uevent recv error handling
Date: Thu, 13 Aug 2026 16:16:56 -0400
Message-ID: <20260813201656.65649-1-rtice@cisco.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: rtice@cisco.com
X-Outbound-Client-TLS: ANONYMOUS; unknown [10.189.17.96]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 10.189.17.96, [10.189.17.96]
X-Outbound-Node: alln-l-core-09.cisco.com
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

The Linux uevent handler is harded for non-blocking receive behavior

Signed-off-by: Randy Tice <rtice@cisco.com>
---
 lib/eal/linux/eal_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index ec408649d0..29a889800a 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -241,9 +241,14 @@ dev_uev_handler(__rte_unused void *param)
 
 	ret = recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
 		   MSG_DONTWAIT);
-	if (ret < 0 && errno == EAGAIN)
+	if (ret < 0 &&
+		(errno == EAGAIN || errno == EWOULDBLOCK))
 		return;
-	else if (ret <= 0) {
+	else if (ret < 0 &&
+		 (errno == ENOBUFS || errno == ENOMEM)) {
+		EAL_LOG(ERR, "unexpected error on uvent recv: %d", errno);
+		return;
+	} else if (ret <= 0) {
 		/* connection is closed or broken, can not up again. */
 		EAL_LOG(ERR, "uevent socket connection is broken.");
 		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
-- 
2.51.0

