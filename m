Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5ACC61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:39:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3307940658;
	Wed, 26 Aug 2026 19:39:30 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 81693402D3
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:39:28 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-938cd95b06eso10296785a.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765968; x=1788370768; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8yDtIR0JUIAhqjODSydl4xNvggBmwVQX2T2avG5Edjc=;
 b=FqehCuhXSagIAn3JPR0FZbnduovhofdXDo1uZabSjc0j8JK/9yImcFhkguHKD7TBSJ
 sPZ67+5ZQVgnDkMW5nB4Qm428ZUC9hcWrGjoGe1U8F37zZzDMZFzYvQU41rrHYNoZ5eu
 5zq+lBGzfKH0tVt2K1Q18K4aqMtjKc9vT7fYxqh2DaqMS2ifQw5ZZQpUD/mXl6Tv+2xF
 V6j5RtIqYdFc+Dr53TkTOWdrvBQwK1HuFAzjxeE4k1SqTMqBm7IoHGZyTAAsa+21ienh
 OFiUVFbzbylDv4KCUNKH2qCxyXx/yTL1YJucSG415vXBzSS+5nCTy0mVGBS6kG737Mor
 y4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765968; x=1788370768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8yDtIR0JUIAhqjODSydl4xNvggBmwVQX2T2avG5Edjc=;
 b=msTJNvtWxrhHzTp9EbNUl+zXuGCAs4uA+i4ww+TGz3cZr39ZRO2TM2HPB8VYmFtcrF
 AwJasfpxCMrfAMzmw3DW5Z7DF2FB88q+iOMpeY/IzG75hSZ0mlTzer6cQBxUAZ1FUpDS
 rgNGv7SF6kAr5XoD4hLejmwB733KTDVP0G87L2QsSl3yiPRSKn4lSY7xw0zAHYadJv3D
 YAKKm1sPISu31iTp0Y/NlbzJ3Le4qLblmZEr1sqSa34J9EtkB3iySofB8mA1Qh9pFA1d
 iOspdHyDPQrc7knW+7KKnz8aCsVPQ/4K2/gbk6C3uHXun0xn4Fsp/Kc8sV/X3pMdllOL
 8nPg==
X-Gm-Message-State: AFuF++n1quojDdB9enf5cHq84WwEAhnDo62G6jN5ZuAYl655LazintWh
 6cRUeV39jZ/LfyeW9IQFw2sX6p1gJn5tlk4BX4LCoFkkDXm8NKCkTbGK
X-Gm-Gg: AR+sD10uOgetI3yx/g8j9zUMXXa/GZ1YNu+CF8dIHwL3GetrnrZosv3EGWYwXMqBZ0G
 PHL+UQVAzbUtMo/v1xiJLSpmW7G3a2ObDGjEoS0jHAq8bWK21LFgHjp2P/TLt8P/MTu/VaJB8jR
 DB7F5SX+ApLXvOYPXiuBE57TF4LgxEs1XlZyV20inboI59Sb3Eh1ZY+LEh4ikt8tLbI6vGdR7fL
 VFa81o4DM54ZxwnMZGf29BucR/ncbgl20WEMBR4F6Enya0cKmSqiz6BvKIr1gP1jEj+dOg7Lw6I
 PR0QPAFKHk4cbcDG2xRXEqOxYa4n6UU28Cm+4q9AbMtrq9BZGyOECYTsMcShzLrTRM9yg0r5FYV
 lq3ADYQHv+r6vo4e2jJCF4TdNgvBXo86ZgyB0Aq1i7/S/RPmom1zU44SkHK4/1iOrpUS4w5gUse
 N5yChUZnZ5XSuTDt0EP8Bz0BBLpsIATHluiFlGPm0jNi4DYLRCwN5hHkj1zbvrF1zOvFDki+uG
X-Received: by 2002:a05:620a:3947:b0:937:628:a448 with SMTP id
 af79cd13be357-93900124172mr105742685a.1.1787765967718; 
 Wed, 26 Aug 2026 10:39:27 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616605sm263115585a.29.2026.08.26.10.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:39:27 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Chas Williams <3chas3@gmail.com>
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>,
	stable@dpdk.org
Subject: [PATCH v2 4/4] net/af_packet: fix QinQ outer TPID on VLAN reinsertion
Date: Wed, 26 Aug 2026 13:38:41 -0400
Message-ID: <20260826173842.1298754-4-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826173842.1298754-1-blandwwa@gmail.com>
References: <20260826173842.1298754-1-blandwwa@gmail.com>
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

eth_af_packet_rx() called rte_vlan_insert(), which hardcodes EtherType
0x8100 (802.1Q). This was wrong when reinserting a stripped tag whose
original TPID was 0x88a8 (802.1ad QinQ).

Fix by reading the actual TPID from tp_vlan_tpid (struct tpacket2_hdr),
then passing it to rte_vlan_insert_tpid().

This depends on the rte_vlan_insert_tpid() function added by "net: add
VLAN insert function with a TPID argument".

Fixes: 23deeebfcfa8 ("net/af_packet: support 802.1Q VLAN")
Cc: stable@dpdk.org

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index d95d045a37..e7fbb3c31d 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -222,14 +222,20 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
+			uint16_t tpid;
+
 			mbuf->vlan_tci = ppd->tp_vlan_tci;
 			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
 
 			if (pkt_q->vlan_strip) {
 				mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
-			} else if (rte_vlan_insert(&mbuf) != 0) {
-				PMD_LOG(ERR, "Failed to reinsert VLAN tag");
-				mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+			} else {
+				tpid = (ppd->tp_status & TP_STATUS_VLAN_TPID_VALID) ?
+					ppd->tp_vlan_tpid : RTE_ETHER_TYPE_VLAN;
+				if (rte_vlan_insert_tpid(&mbuf, tpid) != 0) {
+					PMD_LOG(ERR, "Failed to reinsert VLAN tag");
+					mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+				}
 			}
 		}
 
-- 
2.43.0

