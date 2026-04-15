Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E96F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E71B40697;
	Wed, 15 Apr 2026 16:48:20 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mails.dpdk.org (Postfix) with ESMTP id C9ECE40685
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:17 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-4764484296eso4195472b6e.3
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264497;
 x=1776869297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=Fm+0PIGmlzIT0T5OJ0G9m21FVzzBMynQYNk3oC8kIWKTMBP0FUbvxF8ria5i51ZWJ+
 VNQoeZCXRL45yzE/rF7F/f1ZVNxhvc613K7qn/YUgn1SOqDjlpROHrACaPwU0RemByJL
 Rc1J+UMrjMRz5m+NxtnxVhQfdN4Z3zHeU8V8YZIsx7JEZ0oFNui9QO4OQyu2nrMRKk3S
 n1hIUS7qNx7WOVTBGlBI3gq4BJAHf1aocCYxMjU3Pgz/9p/zsSkxs1v11v4dmyjFp/MJ
 VgQx+wW6+1rJhXRaE4ymjqipHSPfoanD5Yv9R2Hp2zbHgOx0SJugG+wjQumuhGpCerUU
 /HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264497; x=1776869297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=Ic8/82YyMwzAkcrH4wxnr+jUKninoLfC7xp2nIEtT44EBs7rMzDmT/vBzmPX8XXPrq
 YejelVDQtzbEzryeIwm8cyqZjRqnWGU4pZjdPU3SMgUNeGSBduIqszm2e1wj1LeW7kp+
 pb4U8z0t0GcoYY6OkF3WlhGUXXd8ls9v0ruyKLDZSy3qnWmCu6b3ZojUyLD//Y474Q8x
 zGX9PJh/O/AkZe1XHYsx3AvvFZKmk+ByoR6DZI+AHFYQppn8UpHraDxirsp/Am4QfSnl
 iYyM5RmpNwRfiymoJdnn044wYhUM6DdcKBK2Ism1dxBMHIJc4eE+ff2BE7VAONIaGSAT
 YPuQ==
X-Gm-Message-State: AOJu0YwgeXFTsjdw9uwJWhrwk22+osZA/snW4qqfz/u8Q1nvnMGG42NN
 l1dgUAGzOkZ8oNlGFFtp5ZpJ5qU0cjlxv8obTJ5ahQlTAJ1BxiSEG718oHHOGWqDUkHYfBXHffK
 APPrx
X-Gm-Gg: AeBDietVhDAdk7EKHxGTpdCbP1ccFPiGhU0EkTY7dw/6KjidTF6RZOeaU4tJnmy9lXG
 8up3apKucz4xHcvPGcXVdzEyysYCEyflkiVagZvAOlcJlnFSWXcSaNzfUV6kgV6dQOiYPdOTEKW
 Y3FihZVzpcqX6+LINXvmaxx32Xj24xdUkPMjNvAnt+bmbXYppDclAm1mIrnFErFSWzPNsTRuXub
 0fl2tVjr4YTH1RvtCB4z1nu9g7YXLcWObqQ/TwV8nc/7esYidKpITtKIggsbM1YouufN9jsscwr
 lf2SJWpKwJ2bL1BgCIBZiM8OaWEPkxRXzTVQTA8kzsewxYWt0SebbUdrZj8QppnkVjAgi0aBXJF
 QENMohQHKXyvFxnB8nuWx7j4oczDy2Rs1NAUyNhJPsSF3YMoeO03/bsjVT5qSXSF6u0Rvh7tLST
 8q6QB9xrptgspkoZ1ZCeVAanNEU4orodL3wKchqAEI5F4=
X-Received: by 2002:a05:6808:6505:b0:467:11ab:cd86 with SMTP id
 5614622812f47-4789f90051emr11569399b6e.43.1776264496957; 
 Wed, 15 Apr 2026 07:48:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v23 07/24] net/pcap: advertise Tx multi segment
Date: Wed, 15 Apr 2026 07:45:56 -0700
Message-ID: <20260415144717.226161-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 724b7a9038..ebc96fafe5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.53.0

