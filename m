Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43ACD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 22:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C1240611;
	Fri,  5 Jun 2026 00:54:38 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id A67F240270
 for <dev@dpdk.org>; Fri,  5 Jun 2026 00:54:36 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-7de68222e96so12438507b3.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780613676; x=1781218476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M6RdX2cE4d5tJiE4kquHflPoaFupXKbWypY8XZuXPLY=;
 b=cBU1G407k1iCaakc0YcSexc8LFYZSlHlTwUe608wPiyeUhU3e2FSnUTrLgaMWJxIiC
 9htsj6Ev4hmkc2LXpHyUqtAmxLC6zpuMEebpvSOJmCg36RHrVrSj0cScXFARSfzwt4m1
 mFzzsF+EXLtN8x2MXiPzLzDlGkVte0RMQU6gmDqpDPfzXA9ARelHK1itqdO8GpcUZbx8
 +qKjdApxNOYXMR+wD0p4UjceroWsIcYeSBVhsD59HS0Qb4JFN8H9bWkYNOWYMzK1NziE
 RKwBTX1bjP7PenJyAVq9vnmW7vgrfQjTFOeHm25wXYgov7zB2vDXPX3WdFSCvqo4TpBd
 +4nw==
X-Gm-Message-State: AOJu0YxdmB+o/qEcjVQvxKzwAZPOclqutBJK7b5qJkr0wETOV7gVX7Yx
 +tGijPv6XRMkc+DAPNNCkk+239CObYKiikwqMyPLj5jx6pVpijRRDJzIUrEIsRa9K4XVFqo1MMc
 xAlT9zMSAxlXR6ahdEWIzKf6fzblbvmBRHl9c9qc5p/Q1B2fbUPhnuXHbx/dT0wewlWVi+wplv0
 yxvp963Zzlc9nO/fcjUCzQD9Ihrxl5GKMNingjG7zsRkubeqNbwMtzzGAuH3b72e/h4Hj3rjnwO
 OKKlQe9kjyC
X-Gm-Gg: Acq92OEMyRl4FUV4sp0zI7GzZpIhGeqg8xN+gtKHCXXJvHGdPL8Vk4q28OmUNFkSofx
 20vGQqzB4SOgIrdPdWaQJy59BI+2rVjaxUo94ESWL0hWMhaHWv4elstG6GNdTlDFVjpuZoecvF3
 UwlfgiTLb4usy2JQScTJCy1VV8fkd/dJPz724KKc0QUT43cJYZBbtRBWG3ac92+Xx2CeCR4MxoW
 oo0m38vdi8ASxq4gv9wezI6Ve7FML9tuqvQQjd4dlzGjTl3lgI/v+WPMXYTBeV7brA3UlKLzy+o
 pKsAb2dVp/Q4Yr0BbYbmlyo9lQVu1L+QrYABcUIU5TYC4S/JPKsyBH+L54IL6Yna9LRM9tkEKWc
 1DCTbBDKr9XIFNaUIh4tb/yPmO4h24PO01oPeqrOVeCd409vuGz1sRw+abmQ9351QGxuyZGiiup
 O23njXv7QytCLms3BcN9/7WrvTmit1j5mv/WnbkwwGNO9gIVcbr7X3a/WKqcsd/yknb1+gPLNpg
 sAX2SSJ6Q==
X-Received: by 2002:a05:690c:6109:b0:7dd:3f36:59ef with SMTP id
 00721157ae682-7ed0caf598fmr9468527b3.3.1780613675743; 
 Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea23ea24bfsm4704247b3.25.2026.06.04.15.54.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5177f07ea82so30784391cf.3
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780613675; x=1781218475; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6RdX2cE4d5tJiE4kquHflPoaFupXKbWypY8XZuXPLY=;
 b=hzIEfWBzuMNDzYtUjCW0gNg+Lb//aGjt1p5PF4psmlOy/zLEnYmRyW58kzI6wVB2yB
 SVdUtkYjlhrk0q2dY5MrhL6wyuZeURciZC6S7orQIQgnEUN3JxvjIC79847Ob2QiE8ys
 qzoCGb6MZ72ovO3Ce5NQp496SHwDNDnU8BQNM=
X-Received: by 2002:a05:622a:a06:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-51795a40dd2mr15258231cf.19.1780613675037; 
 Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
X-Received: by 2002:a05:622a:a06:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-51795a40dd2mr15257651cf.19.1780613674279; 
 Thu, 04 Jun 2026 15:54:34 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm67043146d6.24.2026.06.04.15.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 15:54:33 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/4] net/bnxt: modify check for short Tx BDs
Date: Thu,  4 Jun 2026 16:56:19 -0600
Message-ID: <20260604225622.2285191-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

There is no need to use the long BDs for transmits
where only checksum offload is needed.
Modify the check for long BD and use long BDs only in cases
where TSO and other offloads are requested.

Fixes: 527b10089cc5 ("net/bnxt: optimize Tx completion handling")
Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 27758898b0..7ef5b15ae8 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -111,8 +111,7 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id)
 static bool
 bnxt_xmit_need_long_bd(struct rte_mbuf *tx_pkt, struct bnxt_tx_queue *txq)
 {
-	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_TCP_CKSUM |
-				RTE_MBUF_F_TX_UDP_CKSUM | RTE_MBUF_F_TX_IP_CKSUM |
+	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
 				RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_OUTER_IP_CKSUM |
 				RTE_MBUF_F_TX_TUNNEL_GRE | RTE_MBUF_F_TX_TUNNEL_VXLAN |
 				RTE_MBUF_F_TX_TUNNEL_GENEVE | RTE_MBUF_F_TX_IEEE1588_TMST |
-- 
2.47.3

