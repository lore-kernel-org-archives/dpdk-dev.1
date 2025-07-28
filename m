Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC279C87FC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 13:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4032B40649;
	Mon, 28 Jul 2025 15:12:43 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0560D402DC
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:12:41 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso2975691b3a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753708361;
 x=1754313161; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRkqjDzYV3kzs98Uoq8jbIOC8DSe/t5KlzFupwDAx2g=;
 b=roj0WiO92xqiOeQycK70Fmazi6pcybXAoDv8acvQa7jN4jT6yDJb5bp5RevMR9KQdw
 tPTQ0C1rW9GxLx66DYGbHe0tB2+4UWel/83QGAE+rajNPahu55ofdjhKYC3s5fk7v/3G
 ekOW7KMfbte9+iELq1bJV6IQxfDXXkbFXyDyY5NJ+uH2s2Iko1qhrp06WxfxRtU6Isg4
 3sIrfdqq60BtCSJ2lbvKMLiaCE9Vb87JYdzMopqi/cYBzadSjXgWUzlYpwQ1TevYF8ol
 IXa6t61j6g2gDCSE11Ivywsap9rl6+rCupjqPJpZl5WTYYENg8CHSSsaU/PSPfU5+Nq2
 qxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753708361; x=1754313161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRkqjDzYV3kzs98Uoq8jbIOC8DSe/t5KlzFupwDAx2g=;
 b=VcFnzvHAc2IVHkpM6JYSuvdF5Gd+Vs4ZQBhZrgL01pOKzeUWWGIj3TFgit9Bs8KmRZ
 rqXLxbZ2Zbz7YNPlCGK+QqXBT78MYABNveLbI525686/g8sYtGXuusxsvfwFlIDfBNqU
 VfDYfHkz1d656OoWq50e8HWLAKafqf570SlnSXbQjYzAKl/f7bBXRXcnVGgfok1tJkEC
 dkoHUrvWCJR0wp5XdA+J6gQW4RsX9XmfGkIsCodrCLJqdIiPs1BYZHVTOxnB+5ZPgHPq
 Im5quVFVvahPOLHVdCluLD+XLXUpYaPoVnk0YRo3bNQm41/BrKVJrrQCtmitgfvwpMS2
 i7OQ==
X-Gm-Message-State: AOJu0YyTCtC0tdlJUimlrrb7PpDl5CoHp67tr0jdAWNS/IP3feAqzuzp
 sSQ9t0svwQUCwr2Q8Ja6n4z/O1kfgiZ0iM2C5I+aUzqyLDmxiOjiWsVfrM4N5B+KNqv4AJGIR0n
 F3wa06Er8wcTP
X-Gm-Gg: ASbGncvg2bNjNFwr0c30yDn4lPFW6wycLOatUPw3mBWGoK66jL3KNREhP6wH1xVwfME
 a7ucOp2xcCFvS25VaL94oQLKVpPQctQnfBhf7qjEzKFbHnhqa3HvdT6izw2nXa4mF/GzYesvyG6
 MzEiRiovVv08PRwvlASkiSmt2E7oSRQp+rAbsm7F0os0u/vnts9xDOb86Z3lZ4y/gzmcWJ/OXMA
 5Ca6o9EUPRgoeCLKQs+X+WFBFUm52ry0qhHPq+HU5+M6Fk6tRj64jWBd/KlQFWt4Q5cZlM7xP38
 h3KIKY3KLf7IFsKgsdJ8ZCRkpm2DIoF/l84qy9Mknxa4gUinCtI7ZlTwL6EHe35Yturpg0KQNo7
 1qN27MzFBedT/pUq57CnOhh/JCZ1CZCkIjUsM3FgbpKvnawvuFvzefLguf8FN5Bw37NWkA6u/av
 z0MLNN3z8bATHZkdVwEWiXsw2M
X-Google-Smtp-Source: AGHT+IGF53ljkK62k5elzzb1N3F9l8mQT3GDWQpP5jNjzVZOKHl2+kcJWoGuDMNqMBHJBx/ZP83RzQ==
X-Received: by 2002:a05:6a20:7f8a:b0:22b:8f7f:5cb2 with SMTP id
 adf61e73a8af0-23d6ffeb0a7mr18912099637.8.1753708360749; 
 Mon, 28 Jul 2025 06:12:40 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6b54e8sm4792046a12.57.2025.07.28.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 06:12:39 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org,
	jasvinder.singh@intel.com,
	bruce.richardson@intel.com
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet packets
Date: Mon, 28 Jul 2025 09:12:22 -0400
Message-ID: <20250728131222.50441-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.47.3
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

Fix incorrect inner_l2_len values for VXLAN, VXLAN-GPE, GTPU, and Geneve.
These protocols carry full Ethernet frames, so inner_l2_len should be
set to the size of an Ethernet header (14 bytes), not include tunnel or
UDP headers.

Fixes: 64ed7f854c ('net: add tunnel packet type parsing')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/net/rte_net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..adcddeb670 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -198,7 +198,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 	case RTE_VXLAN_DEFAULT_PORT: {
 		*off += sizeof(struct rte_vxlan_hdr);
 		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_hdr);
-		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
+		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
 		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
 		return RTE_PTYPE_TUNNEL_VXLAN;
 	}
@@ -210,7 +210,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 			return 0;
 		*off += sizeof(struct rte_vxlan_gpe_hdr);
 		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_gpe_hdr);
-		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
+		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
 		*proto = vgh->proto;
 
 		return RTE_PTYPE_TUNNEL_VXLAN_GPE;
@@ -244,7 +244,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 			*proto = 0;
 		}
 		*off += gtp_len;
-		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
+		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
 		hdr_lens->tunnel_len = gtp_len;
 		if (port_no == RTE_GTPC_UDP_PORT)
 			return RTE_PTYPE_TUNNEL_GTPC;
@@ -262,7 +262,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
 		*off += geneve_len;
 		hdr_lens->tunnel_len = geneve_len;
-		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
+		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
 			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
@@ -498,7 +498,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 		pkt_type |= RTE_PTYPE_INNER_L2_ETHER;
 		proto = eh->ether_type;
 		off += sizeof(*eh);
-		hdr_lens->inner_l2_len += sizeof(*eh);
+		hdr_lens->inner_l2_len = sizeof(struct rte_ether_hdr);
 	}
 
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
@@ -511,7 +511,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 		if (unlikely(vh == NULL))
 			return pkt_type;
 		off += sizeof(*vh);
-		hdr_lens->inner_l2_len += sizeof(*vh);
+		hdr_lens->inner_l2_len += sizeof(struct rte_vlan_hdr);
 		proto = vh->eth_proto;
 	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
 		const struct rte_vlan_hdr *vh;
@@ -524,7 +524,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 		if (unlikely(vh == NULL))
 			return pkt_type;
 		off += 2 * sizeof(*vh);
-		hdr_lens->inner_l2_len += 2 * sizeof(*vh);
+		hdr_lens->inner_l2_len += 2 * sizeof(struct rte_vlan_hdr);
 		proto = vh->eth_proto;
 	}
 
-- 
2.47.3

