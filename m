Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC13C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 979F24066C;
	Wed,  5 Feb 2025 18:20:16 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id 8091F40667
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:14 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-71e3284f963so33211a34.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776014; x=1739380814; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmgHhcZZlQatMO0TcMOaHZ5yw3xVSSdvoQBasv4ZB40=;
 b=cBTQDdgOApx+uaQ9ZKHkbB4SSwl878jKuPtVEaZ69nnaEpxH0eYPPQE78yBP81NsUY
 lpDse7GMwNpHLXhzKQCXyBaLbDXugTuC69fSJnUmuRdJcY3K+3B6prDkLhEschm+x0bI
 aDW344Qgyecx85G4IX3k3i0+H6pHIXaf5PaUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776014; x=1739380814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmgHhcZZlQatMO0TcMOaHZ5yw3xVSSdvoQBasv4ZB40=;
 b=VMgg+yuL1ObGK7RBGTkoxbHFY2ld6P5FnPypItczlBDsFyyBK5sfYtB09+5CZkY9dt
 1Q85gp/cBMulm8KieWbHEkur7A8tA4MviTCDi3ghdofFAAus2FG/jf4HsHi0RUXEZxRx
 S2breKKK5IRDZGyn3kAcmOamEc3I2MhYBaPO/9hD3JgwNSGRiE3q2YdCE4NpKmcnpcUK
 lleOFw/R4GDDDSbMkSzjRT58TXqVSbNKwdRarWUXZ5nVpO70j0+sg/QxvbVaPPVxJnJD
 xuayoYxdD7ShsFBZtBwa8SJF+h202l/oM6lwrYpVclj36+vMqNWzwOw8nu2RSI97qWBc
 6JfA==
X-Gm-Message-State: AOJu0YxFp8MgqSM5zYq568msAVwIye78QGnixAWUH6r3sCOrEw2RDbZF
 hHhk6MnCmXRi+msB8bIxx9Ep0Z0nshvqj4FuPrGT/baF3NqMd8jT4/gi2UlFeVD5C4u3OjUy42Z
 fPmty1zdL+OaoS4R5zyowF+6zx+w8vNus5tIFLNZX7ntwmkVvI9+v+PN/T/c3aqUjiB1xwQZI3I
 vg+tvnsc+QGHGvSxf0A+sgLqhYUFUp
X-Gm-Gg: ASbGnctvbPm0kWb2FzX+dATfpFUddPTVq1vrDigIZKXM3fdZKioR1qVTJUg8vpMICm4
 vrNDXhfomYC4R7rEqd9iWtRvhlcqxQ9YCiLUIdH6s6YFkdCB4h8mgRZpHl5NekxqDCnmV0s2EPo
 l5BpN1nwJ23qfSPauPQwyS5OU0Q3TY5J8+baRIDPRDtSRnNTXtg/GkBI6XbTV25QN09GX3XBfC+
 /bL3Mg0x2owqRrfuA59kTajsN71zbSvSBXThyZJpRUnsLpl+Z5iBlj8vVQfPP9DCVZU/E3MqDYB
 vLW0fFoC2R2JP3oHLe3b8SadstFjLjBWdlH4wR261+FCtASRsyDVfWGXx7pOepY9SEhVdDLdwlf
 /cjCPngGr
X-Google-Smtp-Source: AGHT+IGEGoTYtqOdN0ZjNKTOE0Am/1dUUE2rsUC5PVa9kQxHFK0reiluaJc1GEe5NSZSKJGRYnhWNQ==
X-Received: by 2002:a05:6830:6303:b0:71d:b6a9:7489 with SMTP id
 46e09a7af769-726a41870c6mr2706428a34.7.1738776013692; 
 Wed, 05 Feb 2025 09:20:13 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:13 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Somnath Kotur <somnath.kotur@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 04/11] net/bnxt: set burst handler correctly
Date: Wed,  5 Feb 2025 09:19:57 -0800
Message-Id: <20250205172004.50395-5-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

We are incorrectly setting the Rx and Tx burst handlers to static mode
by default. Fix that by using the bnxt_receive_function and
bnxt_transmit_function calls to determine if the vector mode is enabled
and identify the appropriate burst handler during the initialization.

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 81a7723c7e..b18247feb2 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6532,8 +6532,8 @@ bnxt_dev_init(struct rte_eth_dev *eth_dev, void *params __rte_unused)
 	eth_dev->rx_queue_count = bnxt_rx_queue_count_op;
 	eth_dev->rx_descriptor_status = bnxt_rx_descriptor_status_op;
 	eth_dev->tx_descriptor_status = bnxt_tx_descriptor_status_op;
-	eth_dev->rx_pkt_burst = &bnxt_recv_pkts;
-	eth_dev->tx_pkt_burst = &bnxt_xmit_pkts;
+	eth_dev->rx_pkt_burst = bnxt_receive_function(eth_dev);
+	eth_dev->tx_pkt_burst = bnxt_transmit_function(eth_dev);
 
 	/*
 	 * For secondary processes, we don't initialise any further
-- 
2.39.5 (Apple Git-154)

