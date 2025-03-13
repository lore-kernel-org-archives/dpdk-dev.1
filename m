Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DECBC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 183B94066F;
	Thu, 13 Mar 2025 22:52:18 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id B3A6F40648
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:11 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22409077c06so39600925ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902731;
 x=1742507531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9sgKgUyuBTZRLmXsP7d+K5iygbV3EEQBEnKjMwFTLQ=;
 b=VDrFtV1WdIGSuDDJMyTELSkA0w1Nq18YfdonTZ0xzW93EJ0veLCvsrpYYZqwiOlxSh
 SuXF1snqFgPdMxxMJzeaac8VTWFBi7+7Va6eJ/74z6c0dat6VX2BPplxpT/3BWQr5066
 DKVPzIX0RdcNEuj+NxoEPPoJpP9X9Ok1F9GU5fZRp3+GcTPt5WIo4HaWY6BBjOYBFGna
 QADt/4BITMa8hD2UxqUzwv4d/nP2IvPpd6I8/lfIlHGG1clSbWmXDHZROZBKJh/IaTg0
 nE+waWZakwTxa8RJWjEvTgllT6V/wg5O+nzjm4CEpTB8riFZUPk+apULdbDULPRda5aF
 XUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902731; x=1742507531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9sgKgUyuBTZRLmXsP7d+K5iygbV3EEQBEnKjMwFTLQ=;
 b=vy2+ilq4G+pwVpnAr8MFa1ID+9zvTzPOcxK1bUpgpKu0dHDQryhoI8Wh+A636BwO2w
 evO8fuKiqkeiI6QqdXyN2i2WNpg8b5L0+GWbkONhsz2nhLNyYX++zp1XXK/QyoFRkKNT
 FOFowOFkGWBQQLpc2pO2Z8IXG9jxI8AXrEBY2jj1aYS77o/3JfjTJOJ+GagH7rUJag7F
 FVPQVlW+D/nn0CiP7287m7z8i8lbqQioStc96dRkTfXriZ65JZcnR89yrea5WQvLbyGm
 3cW4QnoDwTdzlo5PovWo+vf/BLreXrz2gK0+oMWIsjaVP2lYyxZ083hK3ny9FXCKYlXi
 fi1A==
X-Gm-Message-State: AOJu0YynKWyDDH6QIqmPEZ3RBxaEScSexlrr3dLUXEnkZPRzSy3c0axX
 fwZCnCITy90EMJqIvp8nWDeGI5OAqMdFiUhqdNlAaL2RfzImBEaj3s6EhQi3HPDO9BZ8XULa5v6
 F
X-Gm-Gg: ASbGncsBt3QYIe0Vu+3WfcmTJeV02Cols3Rga7rQ7uSNeXOBfY94FAByxE7r1tyRwGg
 YqR9ZlZoD5myhjuzs1QO7aHmn9mVkiyi87xgJWouaZtytUejjHO0IOd9UVxmsODp2579bJNJKQH
 sCOGIwvlaOd+GLXO5RslUDrrFBuNoZ5C1eexnNG45AZwXQuuCQUvHHalz5YHyb/xFzs78h/kXxC
 Ga7oKIVz2KdSEsHhGNSoOAFsjvWBzh5XFtSFeFZEtpV7+gqaY0DX7eX42Z+1/E2juGKfCtOWMMG
 I6H1xlxoJ/IQeP7MVdzVEZiTY3zxQYGaN0ie+SXh5WlhKDS5Bwj6Izq//7PvhQt1tnVh5KoULZP
 pgRJMwbCIDe7xHlaLQVyYqA==
X-Google-Smtp-Source: AGHT+IFNzhYKEXTye/iqZjd6/vGezPHRRbtfqLULttWVpTLoNjYG0Yv8unos/whMrlvKae1G6RTn5g==
X-Received: by 2002:a17:903:2a88:b0:223:4bd6:3869 with SMTP id
 d9443c01a7336-225e0a3907cmr2608595ad.15.1741902730909; 
 Thu, 13 Mar 2025 14:52:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 10/10] net/ioring: add support for Rx offload
Date: Thu, 13 Mar 2025 14:51:01 -0700
Message-ID: <20250313215151.292944-11-stephen@networkplumber.org>
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

The TAP device supports receive offload.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ioring/rte_eth_ioring.c | 98 ++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 704b887d36..7c60d49b23 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -30,6 +30,7 @@
 #include <rte_ether.h>
 #include <rte_kvargs.h>
 #include <rte_log.h>
+#include <rte_net.h>
 
 static_assert(RTE_PKTMBUF_HEADROOM >= sizeof(struct virtio_net_hdr));
 
@@ -44,7 +45,10 @@ static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd
 				 RTE_ETH_TX_OFFLOAD_TCP_CKSUM | \
 				 RTE_ETH_TX_OFFLOAD_TCP_TSO)
 
-#define IORING_RX_OFFLOAD	RTE_ETH_RX_OFFLOAD_SCATTER
+#define IORING_RX_OFFLOAD	(RTE_ETH_RX_OFFLOAD_UDP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_TCP_CKSUM | \
+				 RTE_ETH_RX_OFFLOAD_TCP_LRO | \
+				 RTE_ETH_RX_OFFLOAD_SCATTER)
 
 #define IORING_DEFAULT_IFNAME	"itap%d"
 #define IORING_MP_KEY		"ioring_mp_send_fds"
@@ -349,10 +353,31 @@ eth_dev_stop(struct rte_eth_dev *dev)
 static int
 eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *pmd = dev->data->dev_private;
+
 	/* rx/tx must be paired */
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues)
 		return -EINVAL;
 
+	/*
+	 * Set offload flags visible on the kernel network interface.
+	 * This controls whether kernel will use checksum offload etc.
+	 * Note: kernel transmit is DPDK receive.
+	 */
+	const struct rte_eth_rxmode *rx_mode = &dev->data->dev_conf.rxmode;
+	unsigned int offload = 0;
+	if (rx_mode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM) {
+		offload |= TUN_F_CSUM;
+
+		if (rx_mode->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)
+			offload |= TUN_F_TSO4 | TUN_F_TSO6 | TUN_F_TSO_ECN;
+	}
+
+	if (ioctl(pmd->keep_fd, TUNSETOFFLOAD, offload) != 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETOFFLOAD) failed: %s", strerror(errno));
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -558,7 +583,6 @@ eth_ioring_rx_alloc(struct rx_queue *rxq)
 	return m;
 }
 
-
 /* set length of received mbuf segments */
 static inline void
 eth_ioring_rx_adjust(struct rte_mbuf *mb, size_t len)
@@ -582,6 +606,69 @@ eth_ioring_rx_adjust(struct rte_mbuf *mb, size_t len)
 	}
 }
 
+static int
+eth_ioring_rx_offload(struct rte_mbuf *m, const struct virtio_net_hdr *hdr)
+{
+	uint32_t ptype;
+	bool l4_supported = false;
+	struct rte_net_hdr_lens hdr_lens;
+
+	/* nothing to do */
+	if (hdr->flags == 0 && hdr->gso_type == VIRTIO_NET_HDR_GSO_NONE)
+		return 0;
+
+	m->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN;
+
+	ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+	m->packet_type = ptype;
+	if ((ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP ||
+	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP ||
+	    (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_SCTP)
+		l4_supported = true;
+
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		uint32_t hdrlen = hdr_lens.l2_len + hdr_lens.l3_len + hdr_lens.l4_len;
+		if (hdr->csum_start <= hdrlen && l4_supported) {
+			m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_NONE;
+		} else {
+			/* Unknown proto or tunnel, do sw cksum. */
+			uint16_t csum = 0, off;
+
+			if (rte_raw_cksum_mbuf(m, hdr->csum_start,
+					       rte_pktmbuf_pkt_len(m) - hdr->csum_start,
+					       &csum) < 0)
+				return -EINVAL;
+			if (likely(csum != 0xffff))
+				csum = ~csum;
+			off = hdr->csum_offset + hdr->csum_start;
+			if (rte_pktmbuf_data_len(m) >= off + 1)
+				*rte_pktmbuf_mtod_offset(m, uint16_t *, off) = csum;
+		}
+	} else if ((hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID) && l4_supported) {
+		m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+	}
+
+	/* GSO request, save required information in mbuf */
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		/* Check unsupported modes */
+		if ((hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN) || hdr->gso_size == 0)
+			return -EINVAL;
+
+		/* Update mss lengths in mbuf */
+		m->tso_segsz = hdr->gso_size;
+		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		case VIRTIO_NET_HDR_GSO_TCPV4:
+		case VIRTIO_NET_HDR_GSO_TCPV6:
+			m->ol_flags |= RTE_MBUF_F_RX_LRO | RTE_MBUF_F_RX_L4_CKSUM_NONE;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static uint16_t
 eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -626,6 +713,13 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		else
 			eth_ioring_rx_adjust(mb, len);
 
+		if (unlikely(eth_ioring_rx_offload(mb, hdr) < 0)) {
+			PMD_RX_LOG(ERR, "invalid rx offload");
+			++rxq->rx_errors;
+			goto resubmit;
+		}
+
+		__rte_mbuf_sanity_check(mb, 1);
 		num_bytes += mb->pkt_len;
 		bufs[num_rx++] = mb;
 
-- 
2.47.2

