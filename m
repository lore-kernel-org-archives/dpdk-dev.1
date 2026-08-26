Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D30C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:39:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A4940395;
	Wed, 26 Aug 2026 19:39:03 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 04DD840374
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:39:03 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-9377f717879so67628185a.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765942; x=1788370742; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X7DvYbig0vzS/aT42RQ3zm6pvU2AtaGwZBtYAdr9bDA=;
 b=hdn8fBz6mxgHp+FaPJx12LliigrM+ra0BSKL67sEb073OMiB1ZiwGOBT+iB5r/9ADl
 1aMAf2flR+O3+L2ekeNBRidaQ/5v4ulMy53bzGn4Ypn7CwOT829L4AV6t7pL2IcB5aKD
 DWwoXseRlexPQ8MqWHSifl6FB3Mq5XO0K/Sod/xRhlkRzf6nV9WwO8gyjS5E+DRXK9N3
 KY74bb7xZTdbfsCcMYKRedlkqYK+KFUNLMilNo2wR6yNxdfZg4hvV6cjJO5vD2hIJs2f
 i0GpZYMoSiohGfe0r+n1nNX8v7rdBN3rYerx4ajP6D8+5MYGSLq3PwA6JDCEzaCsaE0/
 y7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765942; x=1788370742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X7DvYbig0vzS/aT42RQ3zm6pvU2AtaGwZBtYAdr9bDA=;
 b=odIipgtQj+9JPp6ketF2x2u/jxgk4CpCIBg7EmpZZ3U0s+ZiNa1r9FJJmCd9952C++
 Obe3rdMAzrCRkf0muxRNOQ78qSaT9FcGBMe8U7uWRzlkfwvbmoQW0/293SeMZ/cBry5X
 AjahMvDsRIHC0WTDBAFYSAKcXFmIxHM908KIatD10CnVhjXSCOCWVLYmqJCZVe0tQvVx
 qPfc+clmHSwWJESWlvnLCbgjwIJ0y0kLiBpbqQ9py/EMt4yOVkex5C801qxKjRIvBqkC
 SbLcW7bxIZGPNsV/sZRKOTFlXACzA4zBOVyajAPFZ+zGG/qaJD4SKjsMQElwLcSePmNH
 1cow==
X-Gm-Message-State: AFuF++mG5x0LHkrYASKe3IQLCTYgQ1lxDxUnjqsODrO9U39eeaYQLhzX
 SurswpqePWNET0npJkSfFg3PsfCAh3yEr7OEcCeTiZ9bHpASXuzkIXn6fb/WUSOH
X-Gm-Gg: AR+sD12yp0+J0EGk86xNNoqYBB4C7i9eQqMToFNes+9wtIE8cDrNo66Nry8JtLbYRiL
 xX1N3gNdIXm7qm9njdNpMu6RJ9DeEnGqYYoJzwK6l8Ww+7u4noC5x528ZBbxSbunOdNwC+qhe9c
 O9aW+NaQ11fnUkRYf7yvIBm0PFvYOE5mGSinxzmTaFY+czFGaIxZFBy9/I4Ee00wQNPkrMtUwOO
 fLNQUjB8vvXWjdu/j5eo+UjgmYpwvYrPIKuao8kwkEHUemdiQdEeWiUme5IslvhBhp/dpStncz2
 VvlbtehgXzS4X/nrnUS9oZBW0hgGvZ4jVj9VAPIc/vSpxzNFcxN6qhPHTOYgcdu6yz7zYP+9RIp
 J+VC0GHH7/n1aTRpcqg1GfYbklwObsYVLphwzVEGoZjMp3y4e+j1fMAq+rDEobHLg8OTbG8N/H+
 3u/onAnnJt/OZxC70QfIyU9UabqSaMhYCGDc1pg0/W8MXhzx8Mv7fZcQhDJByCuA==
X-Received: by 2002:a05:620a:2615:b0:931:5fce:46ba with SMTP id
 af79cd13be357-937803c24bbmr968636785a.19.1787765942285; 
 Wed, 26 Aug 2026 10:39:02 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616605sm263115585a.29.2026.08.26.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:39:01 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>
Subject: [PATCH v2 2/4] net/af_packet: make Rx VLAN stripped flag handling
 explicit
Date: Wed, 26 Aug 2026 13:38:39 -0400
Message-ID: <20260826173842.1298754-2-blandwwa@gmail.com>
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

Rx VLAN handling set RTE_MBUF_F_RX_VLAN_STRIPPED unconditionally,
relying on rte_vlan_insert() to clear it again. This produced correct
flags, but in a way that was not readily apparent from the driver.

Make the flag handling explicit in the driver itself: only set
RTE_MBUF_F_RX_VLAN_STRIPPED when vlan_strip is requested, or when
reinsertion fails. No behavioral change.

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b0ff22ea55..d95d045a37 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -223,10 +223,14 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
 			mbuf->vlan_tci = ppd->tp_vlan_tci;
-			mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
+			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
 
-			if (!pkt_q->vlan_strip && rte_vlan_insert(&mbuf))
+			if (pkt_q->vlan_strip) {
+				mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+			} else if (rte_vlan_insert(&mbuf) != 0) {
 				PMD_LOG(ERR, "Failed to reinsert VLAN tag");
+				mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
+			}
 		}
 
 		/* add kernel provided timestamp when offloading is enabled */
-- 
2.43.0

