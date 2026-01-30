Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD7E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F30B640685;
	Fri, 30 Jan 2026 18:35:23 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id B392840647
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:11 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so18811515e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794511;
 x=1770399311; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3MdQYdU3LlOhmib+owipODgKux/7V5ilHdrXhfNIE8=;
 b=sSSu0br4yp9efZUtw7R73eslmkSVe+8MzNb211QrLAb/tjdn43uRogE3HZNCESq9uZ
 R+ojl3TdXbTVLkVGwKE6fYkZ0DrPiQMHOxcMOJ69kCZxU1nYG7tg5k6gvappjU8eZ9gz
 9r2WKycoNYbrFl5Iz5jljRQahBC+0FoGPbLb0ibheJDxBWgWhCU0ypPH9Ec8LujwXRtL
 5OE08+Zro/gfGkdvzmM7rKzlviuezjJxH54GKakf9i7CP/BsAhjuXWqQRhsb1134zXye
 uFQrVAc3sE+4ncWvsQv9ZaDLBZPoSjPB9RAwwrgKN3w/gccGyyk4WIaaR8tidrFGq2R/
 P4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794511; x=1770399311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3MdQYdU3LlOhmib+owipODgKux/7V5ilHdrXhfNIE8=;
 b=ASQgyD7BhnZoxWxuPJOvPPWcvuyrl3UNL8AQE6d/jCSLQJk3ir6arOUt8Kom95Kyiu
 8xYhlr/rWFKN9JGmOlRYFUbPuFkNDe48vbs/xurzlUYEEHQIXIjoN8e/BxXeOtEQB9D3
 s3o+qfWB2X2/m1d9XOzdiTcEUCGQw73Xgnf7e/1ynt+QdcWmyza6N8m0bSbX7lYwn3nq
 DlVGLgyvJWTI6IYa0kaVBTqy4CuGd4QFvIOcX7QvBrPjX6TnPvxNbIAxqyyQF8LdqN7V
 lh8cbuGLIJhShuNiDPNeH+D9AkiI4zjEqWLwQ3IkzsaHj9h6KxGGaG2bIRwo3K3DBGrC
 6NEA==
X-Gm-Message-State: AOJu0YwIUEb6GmOk7mx9783blhjUOOCVuhCe1bdhLS6nZtepuJba/fRm
 uTUQAhDLzxufdnE0F7opMZ6rjiKjzgxBdYO498AbSbaC+lON3qbrDsymlChMJESpL+DeHGTE9fA
 +NPTs
X-Gm-Gg: AZuq6aLc+Bz2RtmqpQ05KMn++K0MdcS9rWN9Yyl8K0yUd8lRIxlxeNFStwNowBDI4rP
 zkhJpmT/Sov1oc+uncJn/4Ge0XgTdkXEOqeGtl42OwCv//RP0BoS6gdUr8dDqkaTK5dU+Up/WaE
 kUmA2rnVzperPB9Ih+hs0txJPAvItmHIIczvg5rg6NqSvHLmAN0KEYo9CADPjWr6DLswVrHAwHv
 bTBYUDsH6gCXFItpQTKX7SlXeyz1h4Pr82uxRrvwBe2xToLsKw7BgebJ1CxW2RTKpvGT3C+npvk
 0FP8U0MjevzH7tVxatjjZIUE43GY+bI1tyG59Of/kAkI2TtizjMEet7+qO1w8Z8rqUdDHvyoKQY
 wxWpXa9IhX6RlJMo97/7SyyqjlHPIhJg3gixwcN0WW0ZDeVmvyw3HdLi8YtEi83Ezz/f/dnBXLH
 YbW+H8k8EWn86tp3Zkx4fvZd9y87FNoU7fZJYFFazDVvSIBbWKTkxnEbOzJ5Hu
X-Received: by 2002:a05:600c:6814:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-482db4ac0b0mr47610415e9.16.1769794511267; 
 Fri, 30 Jan 2026 09:35:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 09/19] net/pcap: report multi-segment transmit capability
Date: Fri, 30 Jan 2026 09:33:22 -0800
Message-ID: <20260130173447.14546-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

The driver has always handled multi-segment transmit
but the flag was never set in the offload capabilities.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 394fd0b6b2..bd33e72a02 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -737,6 +737,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

