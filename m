Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63851CEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A778A40E18;
	Tue,  6 Jan 2026 19:33:24 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id F1D104028B
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:22 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6503b561daeso1916375a12.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724402;
 x=1768329202; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vd2Iuv+ckOrW/YwaU90RK529m3/DFNOryT3qzuVQyL8=;
 b=wbae9KurU4s0btKdtT7wFCG1Io6RGULHa9Vbou0ineLi6bGI37LJmgmGH+tO5p6zxJ
 UsDPBkpwkscTAYJXjdXtZGLMR5LzlzWAvuNWwZknYdAuyfXxPDvxDj1zE5V3p0ebnUpb
 DSY6KBBPyFCIPDmtQBaaMW0D0q8EuuvueP1EgrFeHLYV5diU8eA+trrJGV6AE9gtP/sR
 691Mb5SLjnvWZIacxiMd7mtSVR50lQyYGsgc1wuUG1ZPNsSP9cAIZTfGfstZIESt8P7b
 g9I1NMUht5W0AtyBusJgDIOo1vAxwBAqRQImhVy2TeWACVgUaq0y0r8cGY1O5vEagMIs
 ziug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724402; x=1768329202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vd2Iuv+ckOrW/YwaU90RK529m3/DFNOryT3qzuVQyL8=;
 b=qa3i5zpNFQU8qG69tRLDsvNLP9UVk/jaBJefAhU7uWPXNIZ8fp3sCmJ3lWNsSpCqd7
 41XP5s09vxI8b61/NQDPEiEQOI+b/yegG0o9O0QdCvIt+/SoqXtZxb5VklDAhEWbHr2l
 VeDXoleIwyQPWUYOq4OtopWcTPfH4Yt997K/uOiCtCRcIfiie8rjtnBlO0BB8b6KOpq7
 Xwrlw4dSGZsmyKtnndDtFtZgB1YvaBgCOVobMgTlkD3PEfL2mkB1kdmIq7Sv2d7dF2sa
 b709ZuwOvFtuFoiA/iNVB8qFB6f/CZ6DoZ1N9OErVK/hbiKEpQ+2Sedh545LBD6ocriN
 0NUw==
X-Gm-Message-State: AOJu0YyrhWRflgTSjZSvPr1GQzqM8fBQbMhtqtZqLiv0sGOtz8ABctUy
 ZUZhZDwTGGy0F9u9XvLcaAs6YHfx4IihWXcwr5RBhA9PVW9XPCYALHlWZ8GXEXDQWDAktalDDeT
 UIogP4Ss=
X-Gm-Gg: AY/fxX5YAnEulBHOZmfpf5YCMrTsjGKAkjBuCOBkCS3SwQdr09nACAPjYQ5oEHZ+Zno
 bcC/XYUZDerdN1XwT5FRexcA+zudR/JaScXv+q4gMNxAZ7CSRxFiFdpCzLSPogV1ukcGLrqyQE0
 a1FY+bsxrlDux9sU7ZxX+8lOOLqMoPLhU0H4vS4SAcYERG7+fgjZXzpp5Rm0EaDS3D75iuN/IBU
 Tv04c6rOq0k8U8xn0AocBovh6KBzPf+LXCjR8WRDivUIKzLTkf96bFQM0fME/GSJY/hhQbzVcjk
 hT+YRaze00wWkzIE31jgOKnCpDjmaNiX/xmvZJ0zWp+NH87PSP5puWMbt5AZiaExzc9Dz1fkkye
 8WdNq/hadCp4ITLgpkxEN8BD1NFBKh0mHkm5sLI5BZXmMUtrSgw1478K337qzhJwHdn84WgaxIA
 wi+dFgiI9q0lnGsUj3WeknpDaQJ+HnTjCsX1UZd9id2F2Z/fUXsQ==
X-Google-Smtp-Source: AGHT+IE4oT54loNi108gs/6zE1eryPPxKfihFyHtzYkCVa+ObuMx8+LZkF1RjGlGUsFXenl7EUF0EQ==
X-Received: by 2002:a05:6402:3551:b0:64d:1f6b:f594 with SMTP id
 4fb4d7f45d1cf-65097dfc572mr1570a12.15.1767724402513; 
 Tue, 06 Jan 2026 10:33:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/12] net/pcap: support Tx offloads
Date: Tue,  6 Jan 2026 10:26:43 -0800
Message-ID: <20260106182823.192350-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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
index 6a3e89aeab..41c5bc638f 100644
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

