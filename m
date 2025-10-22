Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB602CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 15:57:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64015402A7;
	Wed, 22 Oct 2025 17:57:16 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 98A8540262
 for <dev@dpdk.org>; Wed, 22 Oct 2025 17:57:15 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso6316548b3a.0
 for <dev@dpdk.org>; Wed, 22 Oct 2025 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761148634; x=1761753434; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otG5MsAyve2hMoVxdwCDxgimm2PfZqEIFk5Sv8dnkXM=;
 b=QOAfwPh94PivTsbXw0zp93ENNvaE33Z8HGESDPKHpMfOSkcBnZ+XDlesd517bAKQNq
 am27Buqkgay9b3St9+NsZ99X+MthJTJjfwzm6M+PwJ0Q/e8zWn1dNwZ/HV0fe4FnIbGM
 tZI49cRXrTmhUWHOLt93jWkXzDsoeLsCJ6iTz8wP74QGxdY7dXHapnFzbK1+IX5CMsxZ
 MShj3l5IEjC45kyiByYQkVrh3socwMWRA7ByWkQAbk2ufBlqXLKlAzdB+w9kjg6rKfc1
 OhVJ75X7sBiS8qOTbN/ZiAbeNapiN/iqTpHoGQFFoiEA4BRRs5BIw3Orivihi4iWltQ6
 g61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761148634; x=1761753434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otG5MsAyve2hMoVxdwCDxgimm2PfZqEIFk5Sv8dnkXM=;
 b=DlOtpPN90DzLjcnaOkIGSeU4eTe12W5Hzq96bXJCz328GWfB+1EsM5FADhhIJeTvD3
 R/hY+vN+3WynmYMaxAVnNXFTNsS3/cMKnt/bDLJCiw/Yqeb++2CP96HidSK7pxO0OdF9
 NEkgbh0x5XzcGcigRPozEkmvpzF2d7vTkzfi0GdZk1Rjs4NeHUvBfP73eV6V4Va9fpBY
 AVvW5A7N3jI9IRTs/L8FTnDv9ZrK38ueM/gsdwGCtXP5vjmSrJxy5hcoD/Q1y365KThC
 n/G/vJCN5vPonJNclSfUuqFRGz6A7O6hDVZoHouC48Pb0vHv1O+K+BuPqLa4Iz9Mri5Y
 OFDQ==
X-Gm-Message-State: AOJu0YxdghH34fgox6MORCO4KF+DGshAxX02Is3YiqG9LDEShXLWV+iu
 O6QCDDfPFbCnywEnmsOlGWMqsyxNcl3LtN3yBhpHCcmKAzkVzWml91ohQyYOMA==
X-Gm-Gg: ASbGnctDY7S6e5B9GRhrMLWGNIXpQf4Ns1JjGmLxMmPFVYmeJ1Ole5IECKj9nv20qwH
 OEc4HntjZ6K9MjO7srGTsp74vL3/NKLOn7vpDUv2B5+3kn2xsTjcOzY6RWx0Z1+bUGCBS/qjaVF
 ZxiZQUdYjJyornB7R5lId2xx1tWnjm8foKGSD1QOOS0MgQpkcsc6O7DgG34xSMnoHduhcVIYktG
 XBgVD8Ae8wW1MB1XC+mjziOUJzsj1YDK2dqnViuN8MkEji029zKep3DmhD2Z/GYMMX/HOQXz5RE
 XnxmzYQX4oB5Izr8TsEFOZ8kI98zBr/C1mPkqv/uOSyJzTGlQU9Dt1WeK1Z7uevpbQgFi1lDpJX
 6Xt8wbPWUbLewilhy5Y2tCXRvg9XufFTYRZFC3irrsVAzsOlnEjL0dPAPZehWx9Sf41dUdUaBMA
 aoTvec7mXFqdGgy94MAh5hRVHFiU+KwwUnn4sQ84dH5J9/XnSO/uP+FzPbBg==
X-Google-Smtp-Source: AGHT+IHZqCoTaWJjMsh7S20L7qTgnXC120QgPbm1N4vucdggHNMIPiMDjZ3DesVqdheVm5Fsp/VyXg==
X-Received: by 2002:a05:6a21:999e:b0:32b:70aa:a1d9 with SMTP id
 adf61e73a8af0-334a85fcd29mr29779929637.33.1761148634238; 
 Wed, 22 Oct 2025 08:57:14 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:50bb:5301:cacd:1307])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a76b77bf6sm13437223a12.41.2025.10.22.08.57.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:57:13 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v2] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
Date: Wed, 22 Oct 2025 21:26:51 +0530
Message-Id: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022133523.6977-1-amiyaranjan.mohakud@gmail.com>
References: <20251022133523.6977-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() while writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Cc: stable@dpdk.org

v2:
 - Fixed typo in commit message

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..3c0ddba80c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,12 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)

 	PMD_INIT_FUNC_TRACE();

+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;

--
2.39.5 (Apple Git-154)

