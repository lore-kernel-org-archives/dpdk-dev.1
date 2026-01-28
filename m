Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B50D46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CAF94067A;
	Wed, 28 Jan 2026 19:41:47 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id BE9BF4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:41 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43590777e22so121488f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625701;
 x=1770230501; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=1xCIuQyXGwvNRQLfjH8sizH4F2Y+/SIgx7pwVCyedhFrBKPmvlQYf6yKcFjQIuoK2+
 N0rYxXS25ZbhTapbrJJVijChIsdDY2777VG5PJ+FMQldC08rVvGpyNjQA4ytr7TPYN2b
 ll16Ih3QmHPec8dIoNtXsR/QLEcuBSQB9wfPqf1eaMiGwUAcurWKHYtW6YHci//kmL4J
 lN9W/1gQMaLuq6V/u9LcAtn2aEGuYVhX9j6eMzj0dLJ7AfkVALfeX/e6fv111EtjK7ZT
 E44rWjSP0NF8mWp2hkMUPs5SVx/wKPYhV2qqBtskppdNjdUKLW+8uICAIr0b1YMaMuh9
 xIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625701; x=1770230501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=Az3/w4v9sDqXCtArfx8J/rDwhRi/Z8URH/nYhGtSzez8Wnss/VKgKshc/llystU1ml
 KtkRCZsTXTCXDKhqJueen5tMNDe7FAmEV8j+7lSP+JCPM9oZywXaY0nFDe6IifRdsBQP
 qUi5c1FQ66ZJu6/5AtL2A6ZxfO9prV1B9CyoKaSQgxgIsahxjInUE3uJLi/plQdCbBhq
 SyLsfUP/tc/SVWndzeNE+uUUVv+4bbmNWZEJ8tWkkYu0lQS2/dtmJnUdY58PgHhD9heO
 bwsg3CpEew3jHvmxMHDmC1D2JBxDJnLHYjt/UJfQhRAH4fQKakiEsHDg04hdNSQdDfa4
 A6/Q==
X-Gm-Message-State: AOJu0YxcMCNDtFKg574zJceCiHxtcNDh/pJ8QRbK72GQjOFdAxT/xJsT
 2qvjICIGb4T281yyWi879QbAhvDumgS6DQrFW3zBx3AD6IFuqnI4trHt1UtwWtT0ZKNptJM3Sh0
 w+ZXb
X-Gm-Gg: AZuq6aJi08ryGDPtGhQW05KJqxCwQH6bnR3IqEcSPgfk2Dsq8of+/n/yrQ+vdOYgHTC
 qZJRwTn5PklKqFecprJbdJIdaWpK1Ffv7JmvFrcD2lKhVd6gRJJki0pvO19+qYXZgks7jye9XGv
 Ngn1FhPRT8rB1GvEwa1UM5+ZAnOUALG3BjaC+PpKqECiUc1DljiAui0Ik34pm0yiSjc5gk35G/t
 D4htKEKGe6QC6G6tD/KwklXFD1/Fm13MDD8xsufkepaPDc/h9crRNjZYUT/9bFvfPbBaRPptdxK
 bVjgYenpWVYR2lxVRVDEwGVUwyJH+9O9YxMvE86q75VtG3l465odV7Mugf6MR0nKYu/0418EIGK
 GyQRHz/srbI6z4sbSXsIaTf1tJSZpDQcBM6FJyXqDo276BuxFbjdp1sAQk2zexSPpI+/Ki4nSef
 QMittKebdPYz0w0by65HCaMHp4AO8al58A2x/O0sEgANCqYUWgyw==
X-Received: by 2002:a05:6000:402b:b0:431:104:6dc2 with SMTP id
 ffacd0b85a97d-435dd051ba8mr8563540f8f.8.1769625701385; 
 Wed, 28 Jan 2026 10:41:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 04/15] net/pcap: remove unnecessary casts
Date: Wed, 28 Jan 2026 10:40:33 -0800
Message-ID: <20260128184130.445567-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The function rte_zmalloc returns void * so cast is unnecessary.

Correct the indentation in that code. Not really worth backporting.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index d09ba5abe9..0177cbc7df 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1221,9 +1221,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
+	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1591,10 +1590,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
+		pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+				 RTE_CACHE_LINE_SIZE);
 
 		if (pp == NULL) {
 			PMD_LOG(ERR,
-- 
2.51.0

