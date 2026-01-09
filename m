Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03376D232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C83B0406BB;
	Fri,  9 Jan 2026 02:18:08 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id C1084406B8
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:06 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b728a43e410so660169166b.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921486;
 x=1768526286; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wz5dpNnIbC6sLjGL52CYxprkQodNvlzFEBBeftG3q88=;
 b=GC8uygDTwIEh/TiFMqv2nMfOj/rVJgODciR8LO5k+a5poLNDETHpMbOlK+/yDt+S2H
 /Ild9RdInO5aaKtMk9Oi6fRJhUBv3892lEay6FXtPKyLcUvYKSBd5SwLLEYVqACsEdCC
 k6ftS+1B09OGjeBZFStIWm1gQBwBLMkOJ6v5H6FNgI5wmOB+aq+2JWl8t3+oL6M41ewI
 Qc3G/tcjoNz4GuAnjbUFX0aIko3HnG858Lpa21WztJrMn5GOxfxGdFiVDrkbwZeLuuv0
 5MrG8hNQzCiumMFKLJ1AjfSzAdX8156YVBR9zLHbWG9vtSvZkPG7rLW8m1CGf1wiaqNX
 FwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921486; x=1768526286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wz5dpNnIbC6sLjGL52CYxprkQodNvlzFEBBeftG3q88=;
 b=f7qZPCupVWkWbUDYvhEBdT0CMSUtZKo9MZbqUQ5MatLZgWS1P++CWye5gTVXANt6W6
 Evv+oBou9+cJq5AFGOdNODOhWEfCkBCbYenWH+iBoKQIRhjNWB1K/l7FvaCKQ8Q/StRY
 IZEVunkZzZfSZMNYJ4z9Aj/sIrp/CNYuw+a1BQOxTxY6AZLkcWLrja+HfMrdUy1axPur
 y4EdCEqVQ0s3QyW3y2msAdqZeSvByOoe0pvDEaE43KKtRZapCRcwCtVPwKNreHYVY/Vb
 2QntRAq6SB6purdIbEqbvit51s88EpChLF/ZUJEX5HzYU5ZxYcS1YLBrCyq+A9keIK3n
 EM/w==
X-Gm-Message-State: AOJu0Ywa/F0TftSx4qfVeejA/yDGSbEYKG5x3YZnJTn2S/xwwgVEy41g
 zm9+47IzTyLkbeyjoalGZbL0ZDOxpgVmpOzqY7Az2iLzZ+yDburHIM5d78Q/CU/bho8qu52PYQ+
 ldDye
X-Gm-Gg: AY/fxX5a6HOk7T6yTyx7dAh1ZmnOUCdimV2fW4VEd++nep4h1B8MdGaSIs2R5kfv3pP
 MGAXeF5wyVDPWJ1mcHy/g9lToNZ5x3lYlF3JSFmnGvM4LnXJ0AmjMPfB1JkrMDP9Qe7L6yv86Ns
 yMMHqWNTxLOF8qd3yjSggpcddBjyJiWziAK/KKR81/hlXrKT1nZP/EguiBOh1bbnhRoP8dveUg1
 JTVnPqPaCQ/tlAwp36KvEPPkmnX/sEBiZJTOZgN/jms9IFrVaparkcmCVS7RUsNGvliqljR9RyD
 tx+7RIqur8LVzCYvhiDlUCwV3tzDM2EBtP9zYYfXZp9PcQsasq1BFFhzhyw+fVvAggCs13Uoni6
 Z+4Y0sHoKWhg3iLfv5rw0EmWAvjf90W2jWOsiaZfDDCANgOnHXWNTDP1ZuDSdxIl4ZjB6Rj+Ee/
 293pik6m3yQRqeFK4qX6HK6ErCnI6oxHgXvkGl0/xyOjvad4FDjw==
X-Google-Smtp-Source: AGHT+IFvH/7Vc7RHSbsBJ5kKnIqxUL1vbNjMLzvGrMRzwmycgftubqJoB42kTGfKPHOmCChFi1F79g==
X-Received: by 2002:a17:907:2d0e:b0:b84:200d:15b7 with SMTP id
 a640c23a62f3a-b84453385c0mr842642466b.39.1767921486320; 
 Thu, 08 Jan 2026 17:18:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 4/9] net/pcap: support Tx offloads
Date: Thu,  8 Jan 2026 17:16:21 -0800
Message-ID: <20260109011755.362857-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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

The driver already handles multi-segment mbufs but did not report
that in offload flags. Driver can easily insert vlan tag making
testing easier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 5db44ab1ea..a27a132002 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -403,6 +403,9 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (unlikely(len > mtu))
 			continue;
 
+		if ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) && rte_vlan_insert(&mbuf))
+			continue;
+
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
@@ -485,6 +488,9 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (unlikely(len > mtu))
 			continue;
 
+		if ((mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) && rte_vlan_insert(&mbuf))
+			continue;
+
 		/* rte_pktmbuf_read() returns a pointer to the data directly
 		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
 		 * a pointer to temp_data after copying into it.
@@ -741,6 +747,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 
 	return 0;
 }
-- 
2.51.0

