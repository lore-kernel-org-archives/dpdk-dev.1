Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB39C021A6
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19F9140673;
	Fri, 14 Feb 2025 18:42:38 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id F3E154066E
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:36 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so3471980a91.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554956;
 x=1740159756; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRWPYg+T7lV1cBfqD5Ts06Di5ESmhauVJafEp/P05Rk=;
 b=p8F9vb/KGxfRyJb97gDOTCaZDByHMq07OjPTUs9KP0NObZFeLhYkO3L6GstxHAN9/6
 cynjbalFZ1DxTh6ynM7AxAiG2KLSRltP6g/QdgeabtUEmpOZ6Tah1RqwEvKPDl0qYEJB
 s1PXJ9RI04FulINjAiUtDxt17sjC/EpDzpBw0pR8fdzopBbbSR4if8+JvXAfqzTk5wkw
 pnCbYyp+ViOrEtW3Kda9Jafq6kFGTngX0jlFUoO2hQ4hXLLMJb5HVyP/hTOKaWyasrCZ
 XHQnOxdD2B6fLrH2LyGXeCPC7fVEdEGtocd4qyzEa7dhkoSYTl5Gfjmom+Q/nf2jA0hO
 sn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554956; x=1740159756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRWPYg+T7lV1cBfqD5Ts06Di5ESmhauVJafEp/P05Rk=;
 b=hAnTT5g8vVS7io67C9q4i7B2O2JhdmO8ZZFUecOGrbBU5lcOESYB1OVuD1NnTy8PFY
 7pkdg19+c9yWg6bRGMvVGhDJLWH3ZGVIgLUHeBkPr1osZhxzDA4R9E00EVylDWrqYnCr
 xI2aOcRSLRsgPpkHlYJ7oNvHJd6zxCMcKpTkK9njvIryraOFJv+3XEJeVoVEKulPstF3
 SLLwoT3MaOuaJtJP0su1bSk0OxS+wIwEhkOUJebFgI/NjnJamOn7wUvvMNQoFi+Pe8vB
 AWKfNBIcpYFAWlHs8iEgOCD+BSy5x0HnraC3BEDFSN79SOyhX+hx7n1hIIJIJ60nHPKU
 QL5Q==
X-Gm-Message-State: AOJu0YzMcFt6zhzEekb9hmMVCyUME/BIzMRwjWCCH0ozEzLwrXYPbQKq
 rO+xCcDzdHts6ierTofteIxku9bOMBkYJQT0yj33U1pXCsi2Bb7nbFTI17LVvf4Ir2m+2K1sG9E
 bNAI=
X-Gm-Gg: ASbGncskn6JTkz8CynzNoSqAPQUT3NivT4gwMXNarqkqCQVoCPIC5SO8R2adI5+BwvF
 Bq0kT9I5IN5r1xSHxaeUUy9EyMbFrzGQzLIj93U7LPxf0C4WRqfOmoB9uM3eIHfzUDp/Vd3D5vq
 8K5tD6x2YXRBGb7kTwq2DbkPn30hFi0eR2FPnVHSB6Itzo8A9VcdxEYRdqMaEvHJroXs69pagvl
 EGIxmv6EQhfKW46nYociNSo+NyoEj928nmFtoRorLDGhg2jfEPSDJhxFPBzMraip2J4HZwdcT+9
 99hbIwBx/DCVhJPsBEOE8S96LF22nAFG8Gc1OSSITVXvH+2HQ83eYPK6Q6efRcoDLF/q
X-Google-Smtp-Source: AGHT+IHHAKJDhQA45sYCOPs6Ui8YPIfkVtJG6H6sVXCjsqtM/hLMsoOhBAk2onC++j8poUbRvxMr3Q==
X-Received: by 2002:a17:90b:2f90:b0:2fa:1451:2d56 with SMTP id
 98e67ed59e1d1-2fbf5c5a078mr19358057a91.25.1739554956215; 
 Fri, 14 Feb 2025 09:42:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 1/6] ethdev: check that device supports deferred start
Date: Fri, 14 Feb 2025 09:38:54 -0800
Message-ID: <20250214174224.79142-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

The check for supporting deferred start should be handled at
the ethdev level for all devices.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 lib/ethdev/rte_ethdev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c4079bb924..5493b3b9f8 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2274,6 +2274,13 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	if (rx_conf != NULL)
 		rx_offloads |= rx_conf->offloads;
 
+	/* Deferred start requires that device supports queue start */
+	if (rx_conf && rx_conf->rx_deferred_start && *dev->dev_ops->rx_queue_start == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			    "Deferred start requested, but driver does not support Rx queue start");
+		return -ENOTSUP;
+	}
+
 	/* Ensure that we have one and only one source of Rx buffers */
 	if ((mp != NULL) +
 	    (rx_conf != NULL && rx_conf->rx_nseg > 0) +
@@ -2585,6 +2592,13 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
+	/* Deferred start requires that device supports queue start */
+	if (tx_conf && tx_conf->tx_deferred_start && *dev->dev_ops->tx_queue_start == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			    "Deferred start requested, but driver does not support Tx queue start");
+		return -ENOTSUP;
+	}
+
 	ret = rte_eth_dev_info_get(port_id, &dev_info);
 	if (ret != 0)
 		return ret;
-- 
2.47.2

