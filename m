Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC6D2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 961034067D;
	Tue, 13 Jan 2026 20:25:49 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 11A1740667
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:48 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so13656277a12.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332347;
 x=1768937147; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9orFBSdbzTWWRcubWTEPIoBZq4UAIvYdZOcY28mlSw=;
 b=zjm8vFsUrtlStzhPtJEfGnyrnAQtM7v56dSiiICkI8xg08XzzfQ8gmu0D1SSvtell7
 M74QSybnNG134WoocSbMeoI1fRqE8IuE6aeepEymucEhO30Q+OwQr1P9//5qSvtPsEA9
 sPzzX0MVdMYWQjmlYeCd4d2CaqFu94UlPYoquTMhaRJuC4H2tEsPLCdKM9SvYEpj8WZL
 /weOuM+VkFqNHV5eEIYPDks89O1sslNqlLkbIu1qbyouWdUatkdnCK9VwZ35+X0ZxYzG
 0cv4XjZ1ijmQwS1BvzJ3JT/Ux6unALPmkDgUAtQoNHX7XulKR8MI32axeQuYNvAVlvJk
 Xeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332347; x=1768937147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U9orFBSdbzTWWRcubWTEPIoBZq4UAIvYdZOcY28mlSw=;
 b=aWg4hfDLRMVwfQRiy8V5Ucap4LP7bkFkJvPunfynWgE9N35QXx+UsGXCQ0LXC2FOMK
 GE0/zwYrYfEYsyDdbMpWl0569vqw+RP8o4h2t7JmbXZeJ3oEuEfFllD9OKi0DK0kB7Tq
 df+b9yhkK9xTMo8C5WbK40PbDRH31AMzbJgsPOeliTW24yp3W0CjJ0QCoNu/FPmVc2j1
 j2KopH3MRNUBtawiygNaRQStLXI6K6MlYB3wvXj9J1AgSJeYwSD+k3ULftQQKSWUuLzH
 LFZdvQHUSnPCLQmOKSgcjv4uCJq8lcMlM0YIoPQTUBedHUhzk9gqnLnGQX+bQRptm1Xu
 F/tg==
X-Gm-Message-State: AOJu0YxIYa/2/UbcOSnFoH+9WmqKeoIXh7i3jzPkJhI/zC78r86jyyZn
 2SdM2rVImKjcGeCshKgbcVqoXTPpx6Wtp9pxp0QyEIu/St+Pi1ch3ctBjz3rlZwBFoOWhq9y7mA
 PQ3sZ
X-Gm-Gg: AY/fxX5Mw1OSKurADE4vcpBPN3WJj6WVV2+XmTdx4b07Zcp0CD6+VtqwZ/9eY6+s5zZ
 mpM8uAbchKNsMs2hLKamlVmQ4W+GLvFYAjwt34MVB587ycfxrhn7QF25HccBu2IDRwtXPAJPqHJ
 B479+JBdvH1WbDiXZNRdy7JVKBIqeTZA3ghNurJJxGGXwBJCCGe1HZXlwfBlEM4SOfhWRpGx3L3
 HxVGpdpiV5QTnaG7G5QP+Y7bbiP16iMQg9ljloi1uP6iySsY2fizITHLchNLgIJdlHklBf8DbsS
 9hne8K9jEmLc77ead0IbEqWwmIWeXS97+9+v9+wn7szPyQKtWavVJa5fIBPnwgLZzhOeFSNw0H5
 gxuwjPXuq+mImvbL/BfpuRryuiDje2L7yVl49SuBoYM+5x8tMW4cogJiQdtsFLxzytWGfzNUMU7
 cnSlnq9POBwQhv9yonQapZ30DcPUmN8+/V/QNG8x3hdCuPDfvyTA==
X-Received: by 2002:a05:6402:b59:b0:64b:a79f:da3c with SMTP id
 4fb4d7f45d1cf-653ec46eb20mr43526a12.34.1768332347557; 
 Tue, 13 Jan 2026 11:25:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 5/9] net/pcap: support Tx offloads
Date: Tue, 13 Jan 2026 11:23:37 -0800
Message-ID: <20260113192530.116470-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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
 doc/guides/nics/features/pcap.ini | 1 +
 drivers/net/pcap/pcap_ethdev.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index e75bf03051..c4772031be 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -10,6 +10,7 @@ Scattered Rx         = Y
 Rx Timestamp         = Y
 Basic stats          = Y
 Stats per queue      = Y
+VLAN offload         = P
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 7002f8034a..fde04bd1b2 100644
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

