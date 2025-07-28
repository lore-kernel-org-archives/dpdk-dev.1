Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FBC83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 12:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85ED440671;
	Mon, 28 Jul 2025 14:31:14 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3245740668
 for <dev@dpdk.org>; Mon, 28 Jul 2025 14:31:13 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-236377f00a1so37583665ad.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753705872;
 x=1754310672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gh+cxwv0s71NdM+qqlCBYVldE2yaVcjTByaveepAR8o=;
 b=VMx5+8OnTQ+xtT60HXGfOEj/l9mFoIdxIg7Vp6UIJcsysHAt+e2d4hGk2DF6svs7rq
 LjP2gHdknZHAkgXEvPp0E/MdQCP1/JUXBfYaOTLW9I2fV01dJfkTZQB7hoRCI2FKTZyJ
 RwheteYya7hDXAEisNdzgXSVGSvExs//2UfGFqmRfPKFzsD2WR89cdMv8+z05PZocohI
 0MiVVnbB3obsBoZOfBOfAqK1vLXuLs9FfMfMvFdx8ZREkEkolV7soCWQMjuPr0+Gc3fq
 qEGmRQN72fhnND2lj8VFu4r5SvtOsiVNDAWYircZ/YgQiZ2IL1iky6hRG0qCpojWZJx0
 qT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753705872; x=1754310672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gh+cxwv0s71NdM+qqlCBYVldE2yaVcjTByaveepAR8o=;
 b=fJzPITXPz0uNZK+g+GEEkPyLRwFhCGzcl59iN3Tm0KhWMjNjkvOQjIPlFZ+30iL3ga
 xgiRhzHIhshEE/4wgoYQYGtGsX2jVchFASA8Oq2yjGpN2fGm0CM6KIVoiiyAYf1Vrrc0
 NqYeHTNN84HMxXqcRt/1/xIIIGUrTS1jcoc8HXXJqYjVVXTrQq70uopWs/iiKlBuQDH2
 hsQEdREGqCZEs47sdQ+4/lCh/Igud6Aei/GiSV/YUc3dTaNReHib60yjrJaU/v3qG4uW
 HLBhfM3/fLjWU8DvBdc37r6I7L0QLIJxcu73g4eZlWsrUN+IQpFXZEpolZjzEb3BflnS
 PVBw==
X-Gm-Message-State: AOJu0YxROMqJDKConTuDX0p5mzvo8+M18IzBHZzhXRTFb3Z5d7GgM2hb
 14/IT8G3SZGphknkffFJXHhRwY8Ou4eWZn2bVLfC1o3t+EddsHvFbRXuI3FJG3mOWb2bTGjcmAS
 Z0MD/X6uQ06FS
X-Gm-Gg: ASbGnctw83E2Fv/eWat7EVlyMKgGtI3i+wxZtApghPAOewVh9Ft6gknc5WJIeZeI9Bg
 j/fCiPPsbPoQ9W0KK2txuWs2nGscI4X7ApynEg/bDhdCLLd4rTljrUNyZpj5jYK419jxbgP5ekU
 ee6tHzjiQjHezfV9i5F5FhRQ02qY+fbhOJSJwL2tozVoHCwg2wJBRrS3yp/oHIOw/JtOg5PHTQw
 4LQiLAvE4dDpXd1mJeQu6+h1Aipf635bTOA87gENot1kFGc2D9kmpCe++deHOcf/e+uFmRf7vCp
 Td7YSy+Yqfx68k101Bi+0NNQzL/cQOmuAfLiWtkIihowmbZWyiZqG6zhE1EThXujYYHhu1I+4sF
 HqvE8vL8wQIUpPIf38r3jGmQIXDPiPTvRtba0OWtIQY0gumykwW4+l+zYtEjuhTkR6nbm8WJn3c
 fGeb5lHulCvnODCK2EjE/nIm2I
X-Google-Smtp-Source: AGHT+IGVVSfGuYteSNcCsYpJB68QMK8CT0lgvaj3S09y8SA7QY9LMWTeaHaauScgpEdykZCkNsEDdg==
X-Received: by 2002:a17:902:e292:b0:23f:cd4d:a91a with SMTP id
 d9443c01a7336-23fcd4dab54mr71430375ad.30.1753705872035; 
 Mon, 28 Jul 2025 05:31:12 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe327443sm53542905ad.44.2025.07.28.05.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 05:31:11 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org,
	jasvinder.singh@intel.com,
	bruce.richardson@intel.com
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet packets
Date: Mon, 28 Jul 2025 08:30:48 -0400
Message-ID: <20250728123048.49029-1-14pwcse1224@uetpeshawar.edu.pk>
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
2.47.3

