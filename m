Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC01DC369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:52:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 321C2402BB;
	Tue, 22 Apr 2025 17:52:02 +0200 (CEST)
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com
 [209.85.128.97]) by mails.dpdk.org (Postfix) with ESMTP id 0CD5640156
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:52:00 +0200 (CEST)
Received: by mail-wm1-f97.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so26432685e9.1
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745337119; x=1745941919; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwonqo2DAzOi429Hnc79jsjZQcCg6vsB2CeH16qHOtg=;
 b=SXJ+U0sR/MiShev0VqUcKI02Gw9ba864Vu02GG9eXVZErzu+TURtsAkqDVqKzojUBE
 CZll1dC3PeeNSSVQiSg3k+UsgIHb3A+O3YrmJBoPyHidn2AFnY773BxoMdfw7+EdqgES
 IbNyE1TZ4yRXjupJXF6RZUnbflxlrrJmlrn68/3McISYrFAhU7rsZHZbZZb9AXbtPjH5
 I6F68b5f0GD1FGiDtjJgsb6SBfrcse6ArPEdOxArL09T34sPD2GpwkTEJy6BgPXFUZBH
 Y5rbBYfJnWKeKMnW6T1axXfGTRW4MtK+znGOUKulGIbp6Z+VW34HrexQFlFiUTgkRm9B
 1kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337119; x=1745941919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zwonqo2DAzOi429Hnc79jsjZQcCg6vsB2CeH16qHOtg=;
 b=CrXwf2GQOjdHCd+gXYOiHxiE2yyEx6heIQUz1nJBZONC0nrnlcHY+eG+Tvno3eUkXq
 PzGRQGT2n33Q+FyXIcDVIXhJV+StTAtL1pA3qjNBDuks4Y78SdP5pykSgEG1RUL6E+md
 V2fDbLCCZk4mnkxViwhkZ4jFqRwlBZaH0a6H+IgUmHq/TehPFbSFSyfyntd410ewBryb
 8Hbyh2jM6JAjqnyiHno17jJyGMDdIBQ4FzPbin8ejjidcK6N68agOxJO+8G4Imsbuela
 F6UrSQYaTwvqzYqlftNjyx/jpQF6cHFjoSrdy1n0eajBBeb6Du4ff4/id1ncBRXXF/Es
 +pSw==
X-Gm-Message-State: AOJu0Yyu//GXyKmv+nTB9D0pANJqivO9nMm/D9GmizQTOLgE8/n2dnbP
 U9jqbKa9ve/08tXjlfPMUu9qxNLVdn0Yeydci94uW41bDGWx9lWc2X4baVlxz/P3A11ctMoHGO1
 OmEzW4VsA+Yk/e+5NO4hCcNj3hjeatqh5kwNxEQFt
X-Gm-Gg: ASbGncsGA9HsUg5qMAd8CNofuw870+7fJWwgNcItNJRNBRZdjcTUGDavPcBAUgb7I4W
 JRMVckgeu+AFl0yBqrchHIXKZqyH6EcZKoxNJ57b7jQ8RMLzzuw3OINRr29L/ew7QjkaW5zyqzI
 0dFXvjwE+4c6uOq//J22+EvobqT6N+tZ52pMDyJ5acwfQQl0QhMHywQ9Lq3qtdAMZKq9Njy/IFb
 MKlfNer9RCKQRl8u78mcxnfHRuUtkQIPuvAwJiRvclZqRUMRSVKLXEjAqXn5iGCURwZ/wkr5ZHy
 vQD5TW9SKcnsBuK0eSunPm6eXiUSWXD1SlhVaHzacbq154iECCQRGQ7/Vok24QWoYT0=
X-Google-Smtp-Source: AGHT+IHe0VlCYKrrF1GT45RpukEpPhSnGzKX/XpEtKF6Agc1rePGQ9I0ndYAK+OKRv338l7YaaPIYb3Q9vU5
X-Received: by 2002:a05:600c:3d18:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-4406aba67bdmr160369505e9.17.1745337119457; 
 Tue, 22 Apr 2025 08:51:59 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-4406d56716dsm9591455e9.0.2025.04.22.08.51.59; 
 Tue, 22 Apr 2025 08:51:59 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
 by smtpservice.6wind.com (Postfix) with ESMTP id 2AFFB360D7;
 Tue, 22 Apr 2025 17:51:59 +0200 (CEST)
From: edwin.brossette@6wind.com
To: dev@dpdk.org
Cc: olivier.matz@6wind.com, didier.pallard@6wind.com, lauren.hardy@6wind.com,
 dsinghrawat@marvell.com, palok@marvell.com, stable@dpdk.org,
 Edwin Brossette <edwin.brossette@6wind.com>
Subject: [PATCH 1/5] qede: fix tunnel checksums offload flags
Date: Tue, 22 Apr 2025 17:51:39 +0200
Message-Id: <20250422155143.3893525-1-edwin.brossette@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
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

From: Didier Pallard <didier.pallard@6wind.com>

In tunnel case, L3 bad checksum is properly setting
RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD while all other flags are set in inner
part of offload flags, this can cause both L4 flags BAD and GOOD to be set
in inner offloads when a tunnel packet is processed, changing these flags
to RTE_MBUF_F_RX_L4_CKSUM_NONE instead of GOOD/BAD values. This in turn can
cause upper layers to take incorrect decision on what to do with the
packet.

Remove IP_CKSUM_GOOD flag on outer IP layer, since there is currently no
way to indicate that this csum is good using DPDK offload flags.

Fixes: 81f8804992c9 ("net/qede: enhance Rx CPU utilization")
Fixes: 3d4bb4411683 ("net/qede: add fastpath support for VXLAN tunneling")
CC: stable@dpdk.org

Signed-off-by: Edwin Brossette <edwin.brossette@6wind.com>
Signed-off-by: Didier Pallard <didier.pallard@6wind.com>
Acked-by: Olivier Matz <olivier.matz@6wind.com>
---
 drivers/net/qede/qede_rxtx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index 25e28fd9f61b..c764e3d83763 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -1617,9 +1617,9 @@ qede_recv_pkts_regular(void *p_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					    "L4 csum failed, flags = 0x%x",
 					    parse_flag);
 				rxq->rx_hw_errors++;
-				ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+				ol_flags |= RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD;
 			} else {
-				ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+				ol_flags |= RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD;
 			}
 
 			if (unlikely(qede_check_tunn_csum_l3(parse_flag))) {
@@ -1628,8 +1628,6 @@ qede_recv_pkts_regular(void *p_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					parse_flag);
 				rxq->rx_hw_errors++;
 				ol_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
-			} else {
-				ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
 			}
 
 			flags = fp_cqe->tunnel_pars_flags.flags;
@@ -1887,9 +1885,9 @@ qede_recv_pkts(void *p_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					    "L4 csum failed, flags = 0x%x",
 					    parse_flag);
 				rxq->rx_hw_errors++;
-				ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+				ol_flags |= RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD;
 			} else {
-				ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+				ol_flags |= RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD;
 			}
 
 			if (unlikely(qede_check_tunn_csum_l3(parse_flag))) {
@@ -1898,8 +1896,6 @@ qede_recv_pkts(void *p_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 					parse_flag);
 				  rxq->rx_hw_errors++;
 				ol_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
-			} else {
-				ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
 			}
 
 			if (tpa_start_flg)
-- 
2.35.0.4.g44a5d4affccf

