Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB3C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 12:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C2B4066D;
	Mon, 28 Jul 2025 14:21:25 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id C871240666
 for <dev@dpdk.org>; Mon, 28 Jul 2025 14:21:23 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31ecd1f0e71so1260097a91.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753705283;
 x=1754310083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sm2mYWL1vz3iqtI/92wk4MpBE4vfaMEIrlR4W9vMKXw=;
 b=AWXl86NcmcKDL4DLLc7oE5TT2NqdAWQ1MwWZ4CNQP8zl2fgd1Wvj/CymBWfqsLQ9of
 /VEULKDANxY+1yq5zNlwDR/86fZrGJocjtD5/VlLWRYjDaVbjuWerqHKUVIibMg0AX0Y
 frOSa1k1mCw1k10ebjdUxkCQrpX/bYn0GWMzP0eCUvDw09jU0w/TGVg5LVwVpDaUKInM
 ON7X7JPDe8q6u5PZ8su9wjJm+qhOpR7A+5bwplj3R0rlMFqihGyQUC0dkIY3Q5TZDFpg
 3pjqQ81wXfnWpeA/7utrpDa3dPtTKSeexNAOjnQV+HJRNJRJb76KNzzx9lHuyI85qipH
 z6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753705283; x=1754310083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sm2mYWL1vz3iqtI/92wk4MpBE4vfaMEIrlR4W9vMKXw=;
 b=EyMhBom+JxWxYUq0e3cIopwYtuHltWxVXgHna8N572TX2MZMjrMSo0+ULAZXtoTc7S
 WQ5hkl9LRiVPBEVsBhlqqLCXmliNBdkT066iX8igY2fTdIvPh+jxX5KqERsqg4QMlq0T
 P6g3iDbCLXgFnLyvPvTSTvLc2BqzhJHoJjj2IluRtjh859mw7Up3Cm/sjcIX67zOr1pX
 MtS0rAip4ks+ZxKJktLvcJ5qAoIF+qmMJPbWClky5xcT6kcTvnyoEHwW8qmaYZB1jF+k
 3Un7UzwNFpmd7TL4S05LoQO4SxIcbUhcv4N0jjemnttyQVXNEyIM3xBGWRvj3KByENXw
 5eIw==
X-Gm-Message-State: AOJu0Yx7XwkYjcf9/phn6xfxBUCG5AZU1ZwW2B5B1GbYQScbMeznZ/TD
 nnBFCy8wrT4X2l4CfCBGzHAGFPvFf48qmUcoTBPkrBIgmCF4wGSeNGqCc877LBlFL24LRF4+Kf2
 ZYHW9YDlIKbQq
X-Gm-Gg: ASbGncvGdEmKQpAe9jQ9dhSiBBNaSOh2hfHfozu3KXJ1XAwj0CJppi6025WEnVXb3Xs
 SubsEp5B9tiSiEKeR+ashPaK3AyQcbjYBcHuWc68DYBhb5IDnpOqR+ewGw7wk5bBV9QA+t8gJJ4
 umm5/l8Z60LRYIL9ayhMdANGa92Mbjofhn/TCrmeJnkZesvOxP3L+lFceNWIyiuVfjZ44Nu/wZs
 DU3gv6o+9BR6ZuHXYG1MM9yt8jEcx9Y0pJgvfN1AKdCWSNeVVyYmUizlX5HAczjS72EvnZaY+oM
 villdxr7yJ1hVqJPh3q0NT26g1WDaHIrkp6UrN9KqBFJ9/O1wH6kXcALYrUHpfaBC4Lt4xtl8fd
 EJpC20Gwy58k9/iRbwFag8vPn517N+qqEsBdc/gEniywmg6NXhBVi85sIy9SlbzgZC3qr96RS2m
 Ac1pOM5jJWEK0Gx7zIFaGP6BBt
X-Google-Smtp-Source: AGHT+IE6YsQnknQ32Smkk+RadCkO5dRl+6hGmaNlWj5H/ykF0oaXSwaX96s3e9cM06cpiqaEZunUlg==
X-Received: by 2002:a17:90b:53cb:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-31e77a0a59bmr17171462a91.2.1753705282575; 
 Mon, 28 Jul 2025 05:21:22 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31ebeae44e2sm3713521a91.3.2025.07.28.05.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 05:21:22 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org,
	jasvinder.singh@intel.com,
	bruce.richardson@intel.com
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet packets
Date: Mon, 28 Jul 2025 08:21:10 -0400
Message-ID: <20250728122110.48653-1-14pwcse1224@uetpeshawar.edu.pk>
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

Fixes: 44fb6c0f51 ('net: initial tunnel type parser')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/net/rte_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..ca9260a67b 100644
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
-- 
2.47.1

