Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE874C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0501A4065A;
	Thu, 13 Mar 2025 22:52:17 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id F02C1402E5
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:10 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22423adf751so24065725ad.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902730;
 x=1742507530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLrRAcEqpC3N7sK8qZlTHuDiMJASvRwnlhTYi11KLeY=;
 b=QjwdL89vB+esxDKMAQL3RgPYktufmdgyh3FH8De2RzACnURaEOsBEDI9KaNSLeX4DC
 Osp3m5lMDCLVAQ8l2s7aiNkuYMw9uocQtetAnB85b07/Kb8B9adxjcc46K+Z11cnQfxi
 QQn/mSTMAQspAPuf7VwZfcW33Mpfml2vBAbgGyp8WOnvMvzje1iPxOOqnQzElH1bVBuQ
 GIWwtRKRcjKBZgFqaMRib4Wl45u3xo8vym70+5r62jxP5UCdYfPj4waaNsVNvyGDCkQG
 67Hzc/fqYoQNxfLPwKdsr2+g53F1gXxoZRJWcuWLhwgU4+bF4y7B/9bWYq13hnULVNli
 vLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902730; x=1742507530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLrRAcEqpC3N7sK8qZlTHuDiMJASvRwnlhTYi11KLeY=;
 b=gcaCdgkKybYG1oxDCzkMVaZ0RPAhUTcj8Vk4PLt+ivn9mmQsNHSHSUIWKE1XNPE4DR
 9rIcqyAlWnIn8z9oVy2Ggt+kbISNfw/F3smlX+1F4GtSvfCU6fdnVWDMOony97kkHNR7
 YLAZF8Ln+dcznRHSiZKgN76T11YtbRqneD1YJ12kHFSdB/QKvaJ0t9Mm3RbhO2IbmcWi
 20n9NUjPMVZ/ZhdnbUzKZMOvyEVAfRM4skk/ub+xgD0DO4RFwLP4zVg7uCfsxp1rIz11
 7ynA2wOWCJ3gGvr6eG/wEjjM1J9Yi5HF0ngqY9XxfRg4jRZvwK29SWoSIVkRoPfVBXy3
 x0+g==
X-Gm-Message-State: AOJu0YwW5QfzQ/pEtMvk2HK6Ge9pYDYCYsywEb0U7snnv2PflHCohqnA
 E5VKyR90sAQTGo1kgSAGKiiXZx+E+zpyzO8dtG8gFIBePTSisLSqYqxM2X/jv7E1wRtxGiVtIDs
 g
X-Gm-Gg: ASbGncuOQRHfUDy0JbBqG7iol95W0rk5+YPm6FzswwpYVYUD3z5pOnQf64oXCidXZF0
 gYNGWgdnU0h46hYgmY6ovOASCNHv5pUXzgri3WkhG7NqZeAeesOS7FcWY6huvdBJti5shLR9u/J
 tnka+HL3hdsPOem8nDS1cOoViI+yyTE2uSriWc+XLKRA1YMwstVPhHy9whG+JJzC+rxtXQs2cBQ
 IajVeRi6LvfUUCw8tw9mBeK63opfc0kWpN/Y8BGGIJ4qFUG72G9LT037pPaDoQraFPKECrxd5Qo
 yP5nFVAZzgMG2Bq1vXonUSvTkZK17kl5ylXAHsy8Bl2M4LDM6d10ZCDqloVWA3FWYwfd9Qv/l4Q
 192vXO7AI02GFG5snDravtw==
X-Google-Smtp-Source: AGHT+IHLAX8mCQJKByMh7WmkpxOtwCHI9T0N8mImeLMfbqdhK1zaGMspDWnsP3xm5+9eJslBiZZYQQ==
X-Received: by 2002:a17:902:e785:b0:220:fce7:d3a6 with SMTP id
 d9443c01a7336-225e0a75becmr2470095ad.23.1741902730161; 
 Thu, 13 Mar 2025 14:52:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 09/10] net/ioring: support Tx checksum and segment offload
Date: Thu, 13 Mar 2025 14:51:00 -0700
Message-ID: <20250313215151.292944-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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

The code for transmit flag mapping can be copied from virtio
driver. The TAP device does not support querying features of the
virtio net header, so the driver assumes checksum offload is allowed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |  2 ++
 drivers/net/ioring/rte_eth_ioring.c | 51 ++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index c9a4582d0e..17497e1fd3 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -10,6 +10,8 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 Multiprocess aware   = Y
 Basic stats          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Stats per queue      = Y
 Linux		     = Y
 x86-64               = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 633bfc21c2..704b887d36 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -39,7 +39,10 @@ static_assert(RTE_PKTMBUF_HEADROOM >= sizeof(struct virtio_net_hdr));
 
 static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
 
-#define IORING_TX_OFFLOAD	RTE_ETH_TX_OFFLOAD_MULTI_SEGS
+#define IORING_TX_OFFLOAD	(RTE_ETH_TX_OFFLOAD_MULTI_SEGS | \
+				 RTE_ETH_TX_OFFLOAD_UDP_CKSUM | \
+				 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
+				 RTE_ETH_TX_OFFLOAD_TCP_TSO)
 
 #define IORING_RX_OFFLOAD	RTE_ETH_RX_OFFLOAD_SCATTER
 
@@ -780,6 +783,51 @@ eth_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 	io_uring_queue_exit(&txq->io_ring);
 }
 
+/* Convert mbuf offload flags to virtio net header */
+static void
+eth_ioring_tx_offload(struct virtio_net_hdr *hdr, const struct rte_mbuf *m)
+{
+	uint64_t csum_l4 = m->ol_flags & RTE_MBUF_F_TX_L4_MASK;
+	uint16_t o_l23_len = (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
+			     m->outer_l2_len + m->outer_l3_len : 0;
+
+	if (m->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+		csum_l4 |= RTE_MBUF_F_TX_TCP_CKSUM;
+
+	switch (csum_l4) {
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		hdr->csum_start = o_l23_len + m->l2_len + m->l3_len;
+		hdr->csum_offset = offsetof(struct rte_udp_hdr, dgram_cksum);
+		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+		break;
+
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		hdr->csum_start = o_l23_len + m->l2_len + m->l3_len;
+		hdr->csum_offset = offsetof(struct rte_tcp_hdr, cksum);
+		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+		break;
+
+	default:
+		hdr->csum_start = 0;
+		hdr->csum_offset = 0;
+		hdr->flags = 0;
+		break;
+	}
+
+	/* TCP Segmentation Offload */
+	if (m->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		hdr->gso_type = (m->ol_flags & RTE_MBUF_F_TX_IPV6) ?
+			VIRTIO_NET_HDR_GSO_TCPV6 :
+			VIRTIO_NET_HDR_GSO_TCPV4;
+		hdr->gso_size = m->tso_segsz;
+		hdr->hdr_len = o_l23_len + m->l2_len + m->l3_len + m->l4_len;
+	} else {
+		hdr->gso_type = 0;
+		hdr->gso_size = 0;
+		hdr->hdr_len = 0;
+	}
+}
+
 static uint16_t
 eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -823,6 +871,7 @@ eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		io_uring_sqe_set_data(sqe, mb);
+		eth_ioring_tx_offload(hdr, mb);
 
 		PMD_TX_LOG(DEBUG, "write m=%p segs=%u", mb, mb->nb_segs);
 		void *buf = rte_pktmbuf_mtod_offset(mb, void *, -sizeof(*hdr));
-- 
2.47.2

