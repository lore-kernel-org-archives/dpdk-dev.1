Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0381ED73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86BA04068E;
	Fri, 30 Jan 2026 02:14:17 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 097F64065B
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:05 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso13219505e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735645;
 x=1770340445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3MdQYdU3LlOhmib+owipODgKux/7V5ilHdrXhfNIE8=;
 b=j8WNH5mx8IV8RQ2g+3juhA6otKtS4Q1vGoKTYJhPQ8A8CK+tgMJaXfon+iBD950aOS
 qx42/+mcRkPqeo2j6Mi2Whd2E4mFmIoUSZltI9OEWk2nTJVofTRQ7fR9nH1HGYZXIIsr
 LrUrbEg0HUrOuHs+JHHd74SAcKtYHm9CqhV6SI+c+ZYwpgWzWg/BA5watEohqf6PfXry
 KAz2rohScRa28/aYnY4iEaH1e0ckRAAcMlOVGLM2clzMY6WlKDgrR3OW+eCi6PM6RtG1
 gQISPWmvO179rdtRwvk5fY7FlUjyphLyrrE0pvCbFfSADusmoY7OKKc1cggX4VYih2CB
 incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735645; x=1770340445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3MdQYdU3LlOhmib+owipODgKux/7V5ilHdrXhfNIE8=;
 b=TOd2zm3bJPUwXhUSmAapv0nYubgffLavEem3m3PxIqqakN0lHg7Izmg3IzJIhnbTd6
 kojN6oR5AAeG9miroGFiLMosFEWeAn1GM8gTBwXpkJkAgmwqinKOgR5CTr7d4lbgAi/l
 FlgeV92/lJ1yqlhWP92L0tn9pRnyzViM2oO0NrYqf2FkmVAXtOAByNcyzVLk3ebaOMTX
 OAPH2U4k77zu7E54mynvtPXIAyqPvYPA1X3FJ2kzGFcfRJ4y6if235a7/Etna7pdxDZQ
 2aJNUQXYXX7bQMlNX7Td71iUaLd2IGQe+jQJBzjBbCMXfofzO4jf7uSy9Tzvz7nDKuaN
 9b2A==
X-Gm-Message-State: AOJu0YzpnwuYErEz8sZWgO0XhvIfwdw2opX3J8tdZuOP+g2BUX3wCNQj
 hKtYsEhgzA/+UPAv1n7ELYQWzJfPuNY1I9QCPnhbOCM2YlAUF4xjzEZEl755uLRGBDBDdrmfMeG
 /NhP+
X-Gm-Gg: AZuq6aLs2N2hVtBIfbQnlE9YOmznu1VHR0EnKYJRI7mSzjqUWM28Tid0HavPJrLOfYD
 WY/30UPD8aa6rsOK7PD/Gw5YxO5kA/7q7e8MlAObDHj7SXPrRmdF+qQhFMWCAjq7SUAfhmOr4vF
 Sz4zV3WjcREkRQELuVCt9RA+MEKeXQpnWu/fKvxRDd6SKyOeHMNV1nDpGHlhhCC8QV2c5uODMPj
 UydII+7UYVsbX+PqV+nQAFopPgCsBbIYW3wZjuPN0ZFLcgyORRHoUwO7+z6notxojwFVyG3NzY2
 rK9a7MmNiRY5XmkU2TsJ5DujedUkmoLcrHpnzgY4vp4HJtBUTGBUu/arCb+HdgNE9sO1VGkz0xA
 JB8eC7t0YZWF9cPr0BZcCeAaOj+Pb5L2Lb8fVAHh8GMxxz1K378PMPNYG9z0Y2fCGZNvsAJboE4
 k2PxnK0iB5UCbeotvkgw9dGdBBXO63G+VV7wQCycfLep+Dss1Krg==
X-Received: by 2002:a05:600c:4506:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-482db448862mr12365935e9.1.1769735644678; 
 Thu, 29 Jan 2026 17:14:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 09/19] net/pcap: report multi-segment transmit capability
Date: Thu, 29 Jan 2026 17:12:25 -0800
Message-ID: <20260130011344.204233-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

