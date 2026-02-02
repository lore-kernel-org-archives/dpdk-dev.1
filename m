Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C2E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5480440687;
	Tue,  3 Feb 2026 00:13:10 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id B86AE4067B
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:08 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3416066f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073988;
 x=1770678788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHMsBULD1LBZFQ+wojxYe0fY8rMgkh1bP/2Kfc4H9SY=;
 b=C5LiWBupubSJVSSSbNeJMdHQ1SzEjTs2I4MC3GecCTdWopj5ZojsxL+75A7ShtwXZ6
 CA6ProUgGkVSBOTAEmNKEvk0t3YJg7F2Ec0EYgL3vQM2jrlfWLDuQbSyOiFo/UDGhyUD
 FKvxPvbZ/dQ0Deh7U2l3X9Obv8WGeR4wD2x+mL9R5mmepq2Uu7OB8DKJMNBpU6GFS7kz
 VpRQwzNv4574hdHY4Nt3o5hAxhE7ufYvoEPXRVtgdAGBOuAfwTBu2g0wL3Cs+2aU+zB4
 zpS3S9PLjRf9C9v3k1mF7yiKuPWTRyb+0T2nCUSUQaHzxyMiqu1CNh0TtcRpm+cpbKva
 Dpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073988; x=1770678788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tHMsBULD1LBZFQ+wojxYe0fY8rMgkh1bP/2Kfc4H9SY=;
 b=OJO0L8RS0yVe9m0T48o1SiLmkvPtg2QZqqusoQ2Uy6lNsac/NZ7o4P6gXoUw0vTphj
 fRg9COVJekJ1kHdSxONsVf0t+zC1D17KLP0mqxPsoxYRPyYT8wUxMqg37JqsPxLqsgn/
 y05ORrZ7ZKIo3HVVGTlABf6+PZNrJvmSXpryGg2cG8OO2YOIo5hoJjvcLBll0+243Lg1
 6/9tYV8Z2Y8s5P2uH2QIPuC58jVxYFR7VzMA2q2xZuqHMJv7v57UeEldCR/3VSsm6TFd
 vZkRPocHtMYAaFWQ+odUG4146qjjVAES8ijh/W8ydmugU8/h+W8iyGEqRtbwMIGKQFPb
 obiw==
X-Gm-Message-State: AOJu0Yxhkssbzw4sHZ7hqYO7VNRzPjMgSLH1jdok/RFWWdBfZQGS4J5c
 RS2DfYU3cFMPrS7wNmH+Y0vl1ZvY6aGGW4VbA5MOLS0X6vkC38rRmJ+4lWpHL+Gh6bUbifYi8Dd
 VkN/W
X-Gm-Gg: AZuq6aJDtQJ8h2SfqiJcCAredYXRRHjMwkFmhFVBcINDlaY8xZzYwG48xymHgCT5s8D
 NTJVrv6TlhiOkWIQ1ROjeJe0gQEE1C0joFrvIJszL7FH0yy6rotou9QPPRA0yFi0lscn+RfQJdY
 LfdoC5zoPzylIBLKbIaOikJw8BTSf4mAdfC6qqN6zbm2IEXICC5qx6APE83swckZ2+aiuzSTcoy
 jO7hbd16q3RL0YkJ6tkwUOOMoPJtdlPesIYT7QbvW8ERrvLF+GEOzPvNsc7NK7AaBDvRqpgSQcJ
 AUXRDRXLZrqFlun7ctT+84rjH+TeeCtLVGRwHg06LvXdaRx3qwXUUHuOH0r4IgbLL5CdJSTaejw
 mzAE/6Yu43ZipwOCImMaCMX3FnuaHxMBlZrfi0nSGSX9tj48WVix9HnJiQYiaDpxAqA0tWxEElZ
 Xa226lUb44q+rmUyK024RRV+AEUGzOYYeZcs4euTcmBGpyLqHAYxqEQBNifSXH
X-Received: by 2002:a05:6000:2889:b0:435:a258:769 with SMTP id
 ffacd0b85a97d-435f3ad23d3mr17116218f8f.59.1770073988394; 
 Mon, 02 Feb 2026 15:13:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 09/19] net/pcap: report multi-segment transmit capability
Date: Mon,  2 Feb 2026 15:09:12 -0800
Message-ID: <20260202231245.216433-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
index 0aa3d67e4d..d983135a4a 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -749,6 +749,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

