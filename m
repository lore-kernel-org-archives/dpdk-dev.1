Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F86C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7EDC40A81;
	Fri, 20 Feb 2026 06:49:03 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 101AD40A7F
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:58 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-506a019a7f3so20660351cf.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566537;
 x=1772171337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ld5D9dTQgR5yxLVHbZpIzHWlwofkuayFqII/6WpE5s=;
 b=0txfuQ6NSdsV0aHKxKCHc16sBO16mFmiF8fNuqIrzF5RFvgpzzSXQDqInL2LnhX7Es
 pDiXhsG7HDJ7dcS2Ur7gvCg70LGsl9Q+w6d5RfZDR9gMLmgtzS3nYTgNRx3eBcaEx8Rd
 oD+/XynUzRmDkkNF2Q85RnqG1X5gbIyFUb0gAlHTu0bRQ8YzQtt6BQ2cShHlQx9m75Pz
 DoNKzo7mc8hRXQv4Bnorvoc3umURgFfCRPmdivsJAzCODIUI9IDcdBjjgDXoZPpaSb/b
 Iv//tAg/iIl8sYB2U0Q34kWPEMACPGyo+a8GoiGTX4P8uVNMFmXx74uolPH3xRWIVg5n
 ycvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566537; x=1772171337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ld5D9dTQgR5yxLVHbZpIzHWlwofkuayFqII/6WpE5s=;
 b=OAmxTCUsqT94rC6bvsBorIaO4HOx6qsc7yDVEGMg5Y8xGDgSrZDXxCOdsB93m7xxoy
 S/SYGxKbcd+KvNSulAeBVmsOq131bo7812vvUkiWe7mHRxt/1xjtuvTFAWPq0XvWPL2W
 8rvE8rhcSEv1Toe8YYccslpPII0hY6yvbJF7DscujjAES8AjEPk/pPcl4ueq26OfW6Wl
 N/vFY+FFWK/hNVxJx6SLfGg6Z0kbR0ZRL1djdhxOTzv6O3pn8a5a8/u/qAv4jLQAjq8E
 couyWuuLkoZoDaS7bZ5QTHhZfuENTMiMzR465t4u28u6E/7Q3mb9fhmusu5nv7OWYmo8
 4Hvw==
X-Gm-Message-State: AOJu0YyijIDQbuzOntq+kwt+wHbD9Gy7O8u4sBPVUQ2634G7ygBB6u5Z
 0zlNj4s6+sKGB5qnQHGC/2EwfybytbOCkXtzpKbV06LHnkfwKQtVrz8x1AeZkb2y+lOnybJdZha
 8Q0Bq
X-Gm-Gg: AZuq6aKTm1qiGKgAlb7BtQRGX4auhTZDh/5JjEYQYZcKiFT72wIZT0ncnr3hPX0WfGg
 EKS1H2DkTiSr+aLXdqBhjWy5zaj1gDAHR8L/PsNdjunQY5y+Gr2Ulx+0AlgwepHvsgD3b1vK//i
 kVlYv1SOl45N2bSfre+3Ghs69g7MNabCRV/eTwinnQTqgckfoUWi33rrPiNkGNoOCKb6irdnTO1
 c1MbN/OZdfKu+MjSeynNYUICuF/85bwAlk+VHDpDtF22cKNU1aCqEinHlIc6eUfq8PWXP72tdhQ
 uUCsl2R4ZaI2QvrFn/3JN8hyOVrjjXnm1T2CcWKrMoVFwEf294GDP9HSIEk2ZyCulgnvFWfSN/w
 GgE4MhOhXi/eD4r1RMuyZZ06oFwArJkf9Y9rT/dKhCAWyKTNXxAOw8vrA1xVpEY4B6kh7tvNTIy
 g6sHXfUrQQX4EJ3spnsSFQ4Cy58M2Nzzumr/C0O4BBPYpuveYNdN0y44sNarUM7g==
X-Received: by 2002:a05:622a:1654:b0:4f4:d2c3:b236 with SMTP id
 d75a77b69052e-506b3fffed1mr287686401cf.47.1771566537342; 
 Thu, 19 Feb 2026 21:48:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 18/23] net/pcap: clarify maximum received packet
Date: Thu, 19 Feb 2026 21:45:53 -0800
Message-ID: <20260220054834.1632201-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
to the largest value the pcap library will return, so that should
also be the largest receive buffer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 74812c6842..27373ec8e8 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -913,10 +913,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t) -1;
+	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPSHOT_LEN - RTE_ETHER_HDR_LEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-- 
2.51.0

