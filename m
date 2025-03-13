Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5291C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01EA40666;
	Thu, 13 Mar 2025 22:52:14 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7B585402AB
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:09 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-22423adf751so24065395ad.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902729;
 x=1742507529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vyNo/ReQZQK8xErSsqLKSzgU/7EFvX50DTfWrzjKbE=;
 b=xVeLXRSP0jNhr7sG3SniTX9swoeSpTUniBqWAYBWw5NG/UJKuJNv0+m9AlMFm5YD3V
 ozWdTw7MEcolJlltU9CJsbUyTiPnR+Jr7e6e+kqG6F3psvqEAwH25SrViZe5MpCYzByB
 OcILEg9PIMRY5bBEOv47m/MwUSlR2QT7nmbVD8Rkq4LqmjUw/Sn3hTmBMeA57IvRyTME
 rBq/X77uOgc4ULr3Zov1NfTsouIJyQ6062rRCqZhl9N/Aduh4xJc1pxWwIkrGmaNm7nT
 O8QLonLYTzs3E+AgADbseMwmyEZ2IXirqH9+PeilPA/TkkJ7R+dmOdry0CZdoYW0+agN
 3yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902729; x=1742507529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vyNo/ReQZQK8xErSsqLKSzgU/7EFvX50DTfWrzjKbE=;
 b=FRcpeIXmTDYpVdwk9NUJpUQf7EQyGHtGateNA1WjDZ09fLg2yTGtTrflakhAcvBA7i
 FXCvpZJ6nkZ94QtljFVpoczm0b6aN/KeLQG1wAi9NVAni/n1XzhVYNq31E/bdT2Nw4dI
 Sfz1LQ47N2py+KzdI5cbh5oSNBfibZWrC7yfloT+FQKW/SY+fkli7dknvBXG22ATj8to
 Y2GdzyMWwYu42p6bVp7BZkb+Eg32L7/BHLTIHedf0IQKsejh7BAf0tF0lc3HyWqM6zOl
 nI1mLm5HvZFMqhefDnUfiXBJiyu5D4tZahKkfQOTl1zTJ3xG1IuoNXo74sBkIhKLRmuH
 uQGg==
X-Gm-Message-State: AOJu0YwNAJCcCKQzarzRHZiq5OlPVaVEk5TIz12Nv9jWOiCbqMLLaPll
 JP3da15oUy83VoaRIFyNlqXSbZkU2V2YICRMJbdiScAJGY5X/eMyyYFVyq58aZj5GywWp91LLFL
 t
X-Gm-Gg: ASbGncsuc2TPBBz+DxKGKF91JVZr8hZR8bYgkThaCyLr4nHth/rUefLOZ5lkxJoKRpH
 oaBQy7y3wVyipDXMDAPTeyFE15h7Dths2Jy2bWvClX66g5J5IZPJ0f9fsiwutYhPeDX9VtBMlKe
 V1s3DxAqTk78UFm3qP5X6+UAQe9arOd+2pFr5j49DkJPDkgXSKm0ycvveJvVAh22Fb2DCoUbbxM
 i5h0DOmKRLeublwLEX+q7VYlqLeeqPvpdtSfmztaLPTgRnyoCHMeREomLj6Y1BjB8NqHZhWHvPn
 LD4hNbrdvYJzWLgWEUFA4BORMVtkT5RaSWNgy7WGzmpGyIxN7WMh4EQwxLimD8DWfij7mSfzcsB
 BSkITwQhikjjXgnMVtylWdw==
X-Google-Smtp-Source: AGHT+IEW4mHFh88WLZEuJa5KKcSpteA4n3sK0AAMZdu6iVj4TXI2mBiwnZwAEHnqW0LB3OaT6en5TA==
X-Received: by 2002:a17:902:c949:b0:223:5945:ffd5 with SMTP id
 d9443c01a7336-225e0af042bmr1834135ad.32.1741902728691; 
 Thu, 13 Mar 2025 14:52:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 07/10] net/ioring: implement statistics
Date: Thu, 13 Mar 2025 14:50:58 -0700
Message-ID: <20250313215151.292944-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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

Add support for basic statistics

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |  2 +
 drivers/net/ioring/rte_eth_ioring.c | 57 +++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index da47062adb..c9a4582d0e 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -9,6 +9,8 @@ MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Multiprocess aware   = Y
+Basic stats          = Y
+Stats per queue      = Y
 Linux		     = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 2f049e4c4f..18546f0137 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -360,6 +360,61 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
+static int
+eth_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+{
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		const struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		stats->ipackets += rxq->rx_packets;
+		stats->ibytes += rxq->rx_bytes;
+		stats->ierrors += rxq->rx_errors;
+		stats->rx_nombuf += rxq->rx_nombuf;
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = rxq->rx_packets;
+			stats->q_ibytes[i] = rxq->rx_bytes;
+		}
+	}
+
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		const struct tx_queue *txq = dev->data->tx_queues[i];
+
+		stats->opackets += txq->tx_packets;
+		stats->obytes += txq->tx_bytes;
+		stats->oerrors += txq->tx_errors;
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = txq->tx_packets;
+			stats->q_obytes[i] = txq->tx_bytes;
+		}
+	}
+
+	return 0;
+}
+
+static int
+eth_dev_stats_reset(struct rte_eth_dev *dev)
+{
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		rxq->rx_packets = 0;
+		rxq->rx_bytes = 0;
+		rxq->rx_nombuf = 0;
+		rxq->rx_errors = 0;
+	}
+
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct tx_queue *txq = dev->data->tx_queues[i];
+
+		txq->tx_packets = 0;
+		txq->tx_bytes = 0;
+		txq->tx_errors = 0;
+	}
+	return 0;
+}
+
 static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
@@ -696,6 +751,8 @@ static const struct eth_dev_ops ops = {
 	.promiscuous_disable	= eth_dev_promiscuous_disable,
 	.allmulticast_enable	= eth_dev_allmulticast_enable,
 	.allmulticast_disable	= eth_dev_allmulticast_disable,
+	.stats_get              = eth_dev_stats_get,
+	.stats_reset            = eth_dev_stats_reset,
 	.rx_queue_setup		= eth_rx_queue_setup,
 	.rx_queue_release	= eth_rx_queue_release,
 	.tx_queue_setup		= eth_tx_queue_setup,
-- 
2.47.2

