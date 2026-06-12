Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D79CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 16:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CE114353D;
	Fri, 12 Jun 2026 18:13:49 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id E77EB40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:13:46 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-13810b63a1aso2534928c88.1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781280826;
 x=1781885626; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+1wXv7Q/7vBANMH9NZHh7Q4R60V36H5kPFyGaiWYNA=;
 b=QTJqVlgGNX9YolK50JI/8fh5fEy1da83biJGjhtOeFn/l42ggxjgfMh9qjsdV8oTup
 ol2n67b4vbRwks4gX56Sr5HBSMbpNNhulAhIBs4uX3j5o74JXCjx07xUN+i/PZiZVIw7
 O5OjzwK4//MBtX84Q236hYmiAIsxBW+RtN4fTigmoVzmzp9YMu1kssk3FmgVYAztdwHW
 5LAK2HHva7SGKww/VCtJu4wjwZYvsXeu4GkHroGsfKAtbLrhaLQvFnYfo7ibwSvSwjK9
 +2pHv15CNccfj1QonOcd1C4dr47COo7SROuiAbM7GsjcwprdNQOlpLRpotHvHqCbkb3h
 P2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781280826; x=1781885626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+1wXv7Q/7vBANMH9NZHh7Q4R60V36H5kPFyGaiWYNA=;
 b=OIotsG0PQB8YKZvWpo+8W64X4LSsGCoc4i7k7NDnqEjpWdxD8dy16qFpUJiIM5W6tT
 ZzicrI0TyeawMNMQR+Ke1h/BizRB0LGDDsndWgtycbtNb4jeCVdiQdMCoNe32CPNE3Yq
 X/9OmWXj9f3iAaSCTI2Dzk7wOZxlM3Cizh7zzIw8yqgl66L83+dRwYjx4+nwbVWRzLdi
 U5ViVNU5aQoWjOYwndpBFIJh6w2Vtz9FOM0b9juVcjvJQ2++pLM7Y42zx/LgxSkFSKmE
 xyVgVTf1JFe20TelN8BZRyzkf5gItALGycM1GQIyqwdQhJGnZ+b/dp8aHPh9dVb+cxyH
 5eMg==
X-Gm-Message-State: AOJu0YwfgL88J3mrKTUBuxdwpcWysEa2V2i8sAh1o3gp7sWHZHQTF3ZF
 8JC70G5dcyiWozrM2yer3oySI4+9oY4wZywCu2cWy09HZ180L8wcSor59TVs+UIhQsI=
X-Gm-Gg: Acq92OGLaUwup+zbqjjZ+B8/Vfx+K2HX07+sdCIeNQl5OngP2flFdGwx5+mJxkXkaBX
 ZrfXQZgTJ15e0E6C6QK3BxeQ4bVdWQA6SNUF7wuiqELKJRc6MQzOmhdTrQzrBjDnm8pFi6H2S/B
 THrVyROflpHVhLYt42qlwGhAkOqTC6blg9zXnUvfFm5YwdFOHCFihYVzueM3m5BoOwdIM1SW7ne
 zgEmnYO6AAm3NE4zex7pc8qhkvl6NDOK6Zpa2kIyCVLuU1oJA3VA+qTipqNM6ShkC/RIV2Fszjd
 dUEvSes1wpOvNhtolUsyv2JeVnZbDHDvrt0oAzx10dwxzKXo/ONySt2OW10uLwcEGWH8jD0Sinn
 f3Tb7upe6/pQBjqj1MnN9m1/1WjpRjfyP9iZ9Ak7SLco4DSsxfGGh9uq+aRkRmooaBXF4cybKQn
 WoIdDjXL0sPKqCfQUox+yI0kDtEPz5D4kBP7oF79ErPZpO/MeWDn6zLPaBJkqLsffgGA6WMT809
 PY=
X-Received: by 2002:a05:7022:112:b0:135:3025:be5c with SMTP id
 a92af1059eb24-1384bbc5364mr1704550c88.27.1781280825851; 
 Fri, 12 Jun 2026 09:13:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b8f9889sm2557074c88.3.2026.06.12.09.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:13:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:13:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v2] app/testpmd: add padding mode to txonly engine
Message-ID: <20260612091343.14344ef7@phoenix.local>
In-Reply-To: <20260612091217.2899755-1-yangxingui@huawei.com>
References: <20260612091217.2899755-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

On Fri, 12 Jun 2026 17:12:17 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> Add a new padding mode to the txonly forwarding engine, which allows
> sending packets with configurable small sizes without standard L2/L3
> headers. This is useful for testing NIC padding logic.
>=20
> When padding mode is enabled via --tx-pkt-pad-mode flag:
> - l2_len and l3_len are set to 0 instead of standard header lengths
> - Packet data is filled with a static pattern instead of
>   Ethernet/IP/UDP headers
> - Minimum packet length validation is bypassed to allow small
>   packet sizes (e.g., set txpkts 14)
>=20
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
> v2: Fix compilation exception of unterminated-string-initialization
> ---

What about something like this (*not tested*) patch.

=46rom 84ff35849f9881a93eed65ccd43a5cd1197cecb8 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 12 Jun 2026 09:10:17 -0700
Subject: [PATCH] testpnd: allow configuring runt frames

Allow setting transmit size to be a small value which has
ethernet header but no IP or UDP header.
---
 app/test-pmd/config.c                       | 12 +++----
 app/test-pmd/txonly.c                       | 35 +++++++++++++++++++--
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 13 ++++++++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d457ca88e..46ff678b9f 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6327,9 +6327,6 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsign=
ed int nb_segs)
 	/*
 	 * Check that each segment length is greater or equal than
 	 * the mbuf data size.
-	 * Check also that the total packet length is greater or equal than the
-	 * size of an empty UDP/IP packet (sizeof(struct rte_ether_hdr) +
-	 * 20 + 8).
 	 */
 	tx_pkt_len =3D 0;
 	for (i =3D 0; i < nb_segs; i++) {
@@ -6341,10 +6338,11 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsi=
gned int nb_segs)
 		}
 		tx_pkt_len =3D (uint16_t)(tx_pkt_len + seg_lengths[i]);
 	}
-	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8)) {
-		fprintf(stderr, "total packet length=3D%u < %d - give up\n",
-				(unsigned) tx_pkt_len,
-				(int)(sizeof(struct rte_ether_hdr) + 20 + 8));
+
+	/* Allow runt packets this is a test tool. */
+	if (tx_pkt_len < (sizeof(struct rte_ether_hdr))) {
+		fprintf(stderr, "total packet length=3D%u < %zu - give up\n",
+			tx_pkt_len, sizeof(struct rte_ether_hdr));
 		return;
 	}
=20
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index 64893fa205..2e0abe361e 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -76,6 +76,12 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte=
_mbuf *pkt,
 	while (offset >=3D seg->data_len) {
 		offset -=3D seg->data_len;
 		seg =3D seg->next;
+		/*
+		 * The packet may be shorter than the header stack when
+		 * generating runt frames; stop once it runs out of segments.
+		 */
+		if (seg =3D=3D NULL)
+			return;
 	}
 	copy_len =3D seg->data_len - offset;
 	seg_buf =3D rte_pktmbuf_mtod_offset(seg, char *, offset);
@@ -84,6 +90,8 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_=
mbuf *pkt,
 		len -=3D copy_len;
 		buf =3D ((char*) buf + copy_len);
 		seg =3D seg->next;
+		if (seg =3D=3D NULL)
+			return;
 		seg_buf =3D rte_pktmbuf_mtod(seg, char *);
 		copy_len =3D seg->data_len;
 	}
@@ -193,7 +201,6 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_memp=
ool *mbp,
 	pkt->vlan_tci =3D vlan_tci;
 	pkt->vlan_tci_outer =3D vlan_tci_outer;
 	pkt->l2_len =3D sizeof(struct rte_ether_hdr);
-	pkt->l3_len =3D sizeof(struct rte_ipv4_hdr);
=20
 	pkt_len =3D pkt->data_len;
 	pkt_seg =3D pkt;
@@ -204,6 +211,24 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mem=
pool *mbp,
 		pkt_len +=3D pkt_seg->data_len;
 	}
 	pkt_seg->next =3D NULL; /* Last segment of packet. */
+
+	/*
+	 * A runt frame may be too short to carry a full IPv4/UDP header.
+	 * Clamp l3_len and drop any checksum offload whose header is not
+	 * fully present, so the PMD is never asked to checksum bytes that
+	 * are not in the frame. pkt_len is at least sizeof(rte_ether_hdr),
+	 * so the subtraction below cannot underflow.
+	 */
+	pkt->l3_len =3D RTE_MIN(sizeof(struct rte_ipv4_hdr),
+			      pkt_len - sizeof(struct rte_ether_hdr));
+	if (pkt_len < sizeof(struct rte_ether_hdr) +
+			sizeof(struct rte_ipv4_hdr))
+		pkt->ol_flags &=3D ~(RTE_MBUF_F_TX_IP_CKSUM |
+				   RTE_MBUF_F_TX_L4_MASK);
+	else if (pkt_len < sizeof(struct rte_ether_hdr) +
+			sizeof(struct rte_ipv4_hdr) +
+			sizeof(struct rte_udp_hdr))
+		pkt->ol_flags &=3D ~RTE_MBUF_F_TX_L4_MASK;
 	/*
 	 * Copy headers in first packet segment(s).
 	 */
@@ -405,7 +430,13 @@ tx_only_begin(portid_t pi)
 	pkt_hdr_len =3D (uint16_t)(sizeof(struct rte_ether_hdr) +
 				 sizeof(struct rte_ipv4_hdr) +
 				 sizeof(struct rte_udp_hdr));
-	pkt_data_len =3D tx_pkt_length - pkt_hdr_len;
+	/*
+	 * tx_pkt_length may be smaller than the full header stack when
+	 * generating runt frames; clamp the payload length to zero in that
+	 * case so the IP/UDP length fields stay sane.
+	 */
+	pkt_data_len =3D tx_pkt_length > pkt_hdr_len ?
+			tx_pkt_length - pkt_hdr_len : 0;
=20
 	if ((tx_pkt_split =3D=3D TX_PKT_SPLIT_RND || txonly_multi_flow) &&
 	    tx_pkt_seg_lengths[0] < pkt_hdr_len) {
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testp=
md_app_ug/testpmd_funcs.rst
index f0f2b0758b..d2e5b63586 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -876,6 +876,19 @@ Set the length of each segment of the TX-ONLY packets =
or length of packet for FL
=20
 Where x[,y]* represents a CSV list of values, without white space.
=20
+The total packet length may be set as small as the Ethernet header
+(``sizeof(struct rte_ether_hdr)``), which is below the size of an empty
+UDP/IPv4 packet. This generates runt frames with a truncated (or absent)
+IPv4/UDP header, which is useful for testing how a driver handles
+undersized frames. Any header bytes that do not fit in the requested
+length are simply not emitted. Checksum offloads are automatically
+dropped for a frame too short to contain the corresponding header.
+
+Note that random split (``set txsplit rand``) and multi-flow
+(``set txonly-flows``) still require the first segment to hold the full
+Ethernet/IPv4/UDP header stack, so they cannot be combined with runt
+lengths.
+
 set txtimes
 ~~~~~~~~~~~
=20
--=20
2.53.0

