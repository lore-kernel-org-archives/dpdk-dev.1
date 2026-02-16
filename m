Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD5E83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 624C34068E;
	Mon, 16 Feb 2026 19:14:23 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id E36BF40674
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:20 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4362c635319so3460630f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265660;
 x=1771870460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=kKIvNcB3QIHa3kKPo/Qg2fGEvejLdCA+u+B2Yrdz3xA/GKe5YJm+2M+df5ypuSbYVW
 b90oINhRtSY28TfD9PUatBU/oBLbUPE257ZCugWYE7nYMxxsYnYFsvGQUXZKtZyzaGj3
 lCfq+enMq/LmFJ2OVkc2htmejHH4s5SqV+GdCnsoNS2s7z/1LMa3sK8tzHrBdq2ALL7D
 +s1Np93+ndjJyg2Q/2oRaHGpeQ595/0TKLD/xz/5BvZC6FqEpXGUwp2VSn0p9jOIPMuP
 7SXiivfh0J0F7/3IWhEFUDAn5ddsrQKrVhN3veHvVACMM5fb9mjdQX0SXQ2n01V1mu3Q
 ae6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265660; x=1771870460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=toHTd+TO9bThgI6kmD0ewytXvyRiYPoaUeWmwZDkZWlhTUxsAcdee4oP3Bm0uaSuBc
 qd/v9d9SKCdmqlnIj+kYoeViOK7Ukq9SrW9pdiV9xgf6DpCNs2GNl+5qb1VixJ2d1eRL
 585Y6PqViDREg29zqXTehYstYlckbb4cQUutXg4fXXvWuGF9rxYQbN5A/UZe8EGajIia
 68lQwQWiyPt1LLwalBljAnyOLI8aDeVxKg/HJozPaOV34AIuUxJMLq5MEq6H+BbWQdTT
 mQSlVjYYIt7TSmNnOHl72V3hoT2doGGbkvH7kAVcskcwKROutjb8G0WaEu8NSlLaI4ck
 U+Iw==
X-Gm-Message-State: AOJu0YxuLDSLfyPviHE708Dwkr3HfgtAhteSr3C2C+4fKvpze8Q3fv1W
 /m6Fl2Y/2yf8W5X6O7fCVkQE/ik23BSSLYYxJ1kmkK1c3HqD1Q+r52QtKhqnD8R3aeWiLaPzUnP
 CJXRhsDA=
X-Gm-Gg: AZuq6aKlGGD7cTvrATuNrK9vYpvcAP1wxmKYGOzq5/fU9W/Dcrj9+LT5WwKbrMEbUyt
 Pxbz/ev1rj0qHiwIYpCy4014jFlcYzNw45B466H5DnjZ4vblhEY06ddCnliiRFCsN/eF3O1iBz3
 p2AX7hMToQP5sEJvM7PzLxXU54WhDhstD6cnzFqdWgG4x78Dz9hpX9wIqaab54BQAecwz9qF5f0
 C+l1XMI1lDDuBBeoPxr0da6PYUFJ3mA2NRzszJJP/jeDSKSKBmmYcNaR9LMzynpDTR1mXbulBT0
 NTF2MVm4JC5cmGq5LY5qjHYyKenJJGt90Xgu5Iyom8LveYWJZwhe7hwQUImroLwzdR6QQDSrBGU
 uavWAObiHaVTi1A/mcfgm1B4JpJ1rDBqrXCHoqTqR3+UCvovXBHVrjNqbTobt0jcrt9KSe21RiU
 36mfuhltOiOUOwTj/HwJLckk29TSrZ3MiNfAane7ze2e4sy77QPdNcXx70w3N32w==
X-Received: by 2002:a05:6000:430c:b0:436:233c:c7c1 with SMTP id
 ffacd0b85a97d-437978e36e4mr21996066f8f.23.1771265660431; 
 Mon, 16 Feb 2026 10:14:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v16 06/21] net/pcap: advertise Tx multi segment
Date: Mon, 16 Feb 2026 10:12:01 -0800
Message-ID: <20260216181407.428877-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..fedf461be4 100644
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
2.51.0

