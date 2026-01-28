Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DDDD46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EA9240B99;
	Wed, 28 Jan 2026 19:42:07 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id CDFCE40672
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:56 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so2493515e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625716;
 x=1770230516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMhSvOYxK29Y3rt+q/Jgz8KU+ocx8m/RmyfM9jHRXu8=;
 b=I00h/aizcODMgNSHd58ga7EKUyMfptBWYJ8kpDq4QWPt/X5AsV8nl5wTipmm6J05PZ
 qnRIgWa6aVclkzhx9SISq/mmvHNMDrz6cW+2q7HJj/3RaR3jM0+IrpchvhyAyEHHgGmP
 ky7707t68/icKcy6euZSjG5QKy7PfyRtWIZsptS7kKNIBeNvN6yFKcRbQfMu89s6VgRC
 nYJ7kln2EJocFDeY7FEo8YKq8hUNkeKw+wHigkMV1+VnXOkq393yY7MSVCW4XwUgo8Ra
 FCaWelwcOVZJbIBfXF0HUnPHGDqCK2yx/gILOYxxwfJTg3KjfeW1CvmlWGvRGvT0R5PX
 WtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625716; x=1770230516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMhSvOYxK29Y3rt+q/Jgz8KU+ocx8m/RmyfM9jHRXu8=;
 b=xO1/K8ydBsDsUCKwPtNjFI7NjXT2srlJZRXLM9xtBfrVGg+W7ZcT9UxQ54PjvwYbr2
 Aq7Ytx0R7dxP8L0o6h2KO65wgbuByuIY4kMmDwPAZByxnmyqqvJuZJwjPSolNaQ8Ptws
 ltDk6ipmLyrrxWBc8M68WZiUvwkUXdKldxVpJ2v/nIpXir+RwXbeCed3iU8GW6e2xsam
 6xFsu9sXHmFc+IYjR3zasNVRMIWztVX9AMeYkiH+B36RdbEA8nYWJ7b0sb8Bf1HWJ3pn
 CgBYEqNvkmVcm6CV1/fRcOUs/xIEQpKPUntD33hRBQzw+Qm46MzboihUqF3f3VTKAcEK
 5I6Q==
X-Gm-Message-State: AOJu0YykQ3ui+Y6lPgylHWKicsvDwXCyPGegxeG+2J0MiGmMSDDV/2RW
 dfiUHmiiq6MB5j3s1sAcW3eED/+V6DbD2WB00JmNACitMFzn0vB64WyK/RlhnTa/KRmiPOkniWY
 7ujGS
X-Gm-Gg: AZuq6aI4qcz/eMI5I+v0gIx1AG1wEynKCVT2K5QCNmYFwtkWaP994zwVNlkZU48cI1X
 sBFTGfgQwkXjxo75KY3BfCEGW6cf5S3ENNgsYKg7JnXDZRtFSFAnUm+XkGye5JtTEg8hm7dDXTm
 3dApbRl4X8WGRg86ifCsBtdN48f0ufJZPVBuaQbOkfQAk+BkV1a8vSi2kcwLfXRYj2A5viJ0N8A
 ufWu6spwPdtw5Zlyy9Fl7t+cRPqOQIrCEhomigEVj1m88l5ukSMyYFqknw/4RCqq+dmpvwQAZfG
 +DKhnLAkfDafwKShoeE+FDYaEIIzeDI7lPYN8yTCBXfAZOhbve1XVJzoOwvVQFPHsE+PCc/fDkA
 BFVA3GxWTDeBrpCq2egfYOYl+8YKOrB3FeENwqtjK/mZUDxkB/zaOnS6RlBa7Ol1hDhysB5sZoS
 GMhK2VuPRy5QZW2bPnHUJi7RlXDARM7lX+vZD3fS62Vs0GaY9Cng==
X-Received: by 2002:a05:600c:3b8d:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-48069c86bcbmr86435315e9.34.1769625716428; 
 Wed, 28 Jan 2026 10:41:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 13/15] net/pcap: clarify maximum received packet
Date: Wed, 28 Jan 2026 10:40:42 -0800
Message-ID: <20260128184130.445567-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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
index 6380d76110..cc72f7f657 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -821,10 +821,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

