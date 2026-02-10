Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43479E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3850B40A79;
	Tue, 10 Feb 2026 01:02:37 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 00F7440B9B
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:35 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so1350649f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681755;
 x=1771286555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8P/Ldrayrb2OdCB7T+We5wTtR494Pik1p5pic4BGAw=;
 b=yQV+NDUDpWQanmED2mTVSZASgLU4/MwpOFec2+lxXy7nKe2C0zmmSogbamtr2lOqIH
 I6vLnQhk7aP/lfDS7wL3DQd2gCN9CvdUqK6Pv8UyLzodOUxzy4URyf1myoIAMV0rvRvs
 /I3rf1KAH1r4z9J1kTX5xAxWttDR26SvBJo9KycC5sBnvnNIaZGN1rS7WOSdGtWMFJUJ
 yWAPfpZwpQR4CXdbwsVZz1nRjHKTRxdYboeEXE6xJx7XHjoH7WDBYhy4Wnr5mNAxfSSp
 Fns4AElyc+mz9L6bQsFJkUjL2KWz3azRSgB8nEXq6AMagb4t1MJwiGr6pV7Dd2HEG3z9
 Ya2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681755; x=1771286555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8P/Ldrayrb2OdCB7T+We5wTtR494Pik1p5pic4BGAw=;
 b=Nvd7WGxAlU9WpGsdQFAdEkOqXVKkFgXsgW9+kuB4mKgtmir8aqUS9tuhRwksvY7BHE
 idYxZe6iwfa8dwo5d8W5g7Kz84fufjGRPIHQgqeg4Sbpu15P+uXJ9h5S+MIY7oHD9lr6
 4uJOfAwpBqRZX0c3S/jw0oeVnBRTThsh8/JwXttl06WJ6ote3rR2J09EXLFMvRBSbS7f
 4oZGfjt+hrQoHrs/DvBWvZWoG+m7xbToGMVWLeGbujCBVm0WMhylGLe7Zysw+hy8Kf9a
 yWp+SjIEgJghpGJX7V1PEr/gtlghYtTxSvXtsClNM86aPW9B71T1PclyP7bi80LfNA2T
 +opQ==
X-Gm-Message-State: AOJu0Yy886OmMe2jWtu0tK2KD6d/OvOE/QMqMX4TfNUNY6R+vgFTQpot
 X5qbdLvMDnaJwmFWRdZ+pNsaNaRpDKCxa5oaWFwQREBFefvoFW0fEoqqvxDyAPOu/bYDFFkmqJh
 FO8GI
X-Gm-Gg: AZuq6aL3pdcuJHwXevLPqmT5b6s4dWhNU+K+DSyqkXT1VxBlBnWkCsOTbNm2DLlnkHs
 1xqH3k9GUvD0sRQ1tf7GxYmcyiwUkcHC40vRsCZCPv5oza81Q07nYH+c+N6fNokZxZka7yA48ij
 ew7VK+BTHSpUD6sypxJq4m/foRhOQHLCzYR46XlJk6pAfVs4BP91HoOjs0G8Ae3nW86dEBKmjIp
 aFG//jvosP+CqcHSeVX8cHolU+8RwyuF6JOM00hIcLfxFDZdcco5Bk04Ae+AZ/1OLGVmg131peg
 8D3Q2sURH8ukxG2hbCj1dAUnigQEu+C5azGiPg1t5CpfOjhM3khtnocgbmARQhw3nUEW5lfH4hq
 CzyYGjqzGK0mfBNJHFacmmBza0nhNwUyIQmdgZ8B90u+rikTd8H0/OF34ZArtALsdlcZhPVPiAy
 UVJn0Xax9FJ+UjojziyVigxR5NbtdtW9w/R85iDR6PB/olQD/r5A==
X-Received: by 2002:a5d:584e:0:b0:435:a501:359 with SMTP id
 ffacd0b85a97d-4362967defbmr19298581f8f.41.1770681755549; 
 Mon, 09 Feb 2026 16:02:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 14/16] net/pcap: clarify maximum received packet
Date: Mon,  9 Feb 2026 16:00:45 -0800
Message-ID: <20260210000201.295839-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
index acfee68711..2413e44377 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -896,10 +896,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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

