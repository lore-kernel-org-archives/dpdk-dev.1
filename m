Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DAFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D33CD40E0F;
	Tue, 10 Mar 2026 03:49:53 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id A476340DD3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:48 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d741f61ee5so1705218a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110988;
 x=1773715788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvG73nzdEYqzyzq5+pgq1ZEEdPRoJ/um9UEqKgdYzss=;
 b=rfRBpPjHdNWKyOlHNj4gkq44Aonn+IWCiqsUL9cyGCtT/nMgMp0YpNShm3kwV1jAyJ
 m/Rk6X0oPv34CuIBWiHMX1d57vXlOb1wKr9qSdlD5++fU5qa0v/wH+P0YReDoe6mKTnJ
 bXy6CbKZ/l+SFVnNaCfGddyET6C4jJaiVdVFRRbIVA0oaNSmW/kRHxx7tAu81poOH6aW
 TI2w7KtjRpS/a4YZkuDwDHwT5jT3RGUI1Hgy0TJwF0iEFF+RkaUvY/9b498ThV7ZU+JZ
 8mu17XjR4VjQrw+88BC/40RNjX22a/tu2CYeIumyr7mVjXlKsWSYCws3p24QLwaeCZgC
 MAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110988; x=1773715788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FvG73nzdEYqzyzq5+pgq1ZEEdPRoJ/um9UEqKgdYzss=;
 b=vxpr1f10XsFW5CDbYp+LvaGf1wxwZsXUTlX10sOWMg7EnQef5WHNufaVbdpEcw+C6R
 gsmgWNs8HwaNGf3bhsYCen0f3yScIFEhTSZalYSkzmsTj1hXUDU9zq14FA09Tut83XEf
 Jr2a/O1SgntOPzaAnEMr1Bkb/MeVraHu29YiPcPb9PW1YKiN0yBe02a8lSWwzklqL9SR
 bmFUro5pp5KY+Ukr+pwwNwZdbSAc8FOC7h75qKTsMKGENpW0GMOJ9IgsNbG0yiHu+YRU
 f1aB71pJ0D+3Jpl7Y1W6g3aZC2E5zUG/0GN5AachxdJOl431CS18nAshIzQBPCFqqy/Q
 J5zw==
X-Gm-Message-State: AOJu0YyNm8pcUWI2VEjjuBRyp9M+5Nx3HmAcBzKQPL2cr4tXgkNZMWii
 C1lcWciNCiG3hGbU8/fqsjISG53VYLx1DACdiRXY9/Xa0RTkhq8WhZYz12eKgOVNePIgWDBqEJm
 XYw8yAYE=
X-Gm-Gg: ATEYQzxdPkZdPq1/r0avsVi/G0RqKz2paV3sb8zosSbYaiv8p7zYjdaFy+CgkJYndwv
 G9v8mPfwbPbJfLed7vvksaecQhABybNVcwA/3ftoSusdL4g48ybN0s1mOQeuVIqkLwR71+8MMR8
 IJ/nkTA3odX/VslU9ptX1J6WGJLHNSBL33gDg0p9QSqzH1D85ZBLVdMvnQY/YUpWup7MMNulBmT
 ut6URd26MQy/W4xabgbwa9zNk/Eb5rSgHT9dhmZE37YVT+1L1aTUpF3k6JBZM0c60fH548auS16
 to9UFetpjGpzyn+GLT23YnpbRCS7L/auBgzZJmSU0PxLFBKM/dIWLfcGvSKXk8qhMQPuk52vCM8
 0kd1GRDvfIIjbwmQlblTxOKvjrzRHLZ6q/J3D4NMzk/RXKSfDawq6Exoksu1iVWbLqDZ3X1jZ5L
 lr8ZUzsYCCgHwhjTndFwHaL6UO9m7iXRZx
X-Received: by 2002:a05:6830:25c6:b0:7d7:4aec:7ae1 with SMTP id
 46e09a7af769-7d74aec8087mr3671432a34.31.1773110987973; 
 Mon, 09 Mar 2026 19:49:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 18/25] net/pcap: clarify maximum received packet
Date: Mon,  9 Mar 2026 19:47:53 -0700
Message-ID: <20260310024925.476543-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
index 20e4b8e6aa..2ffbce2448 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -884,10 +884,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

