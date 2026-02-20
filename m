Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FEC5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9AC340656;
	Fri, 20 Feb 2026 18:06:28 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 11D4B40609
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:24 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-894674a4c4aso34622156d6.3
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607183;
 x=1772211983; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=NvV9hRoj1ZP0s/qj+uF9+FRaraLuQiALbHkwNcQc6Q6aMi+9ax2scpp16QOGEJXRJf
 l7+lLXKHFgNylUQXdIoJWOELkiuUV+EfMy/fpZ9W6Qz8K8EQJfOTYD28wfhNGqqx3pSu
 BvXR0x5HOcmANrr6uVM5X4JmuLzyNcjEc79rMK/0dVvQ8sKGUJVK2MtyvWPmtLYzwqwl
 TnEiazKqaxBlPyGJ//W98iRaGzstqxNIYuOrxjcLJs+7V5VEUW1AjRReC0WFb8iu71nh
 W30OPKeP8gGAeUK2U+rmz/j6xYSoXeX4+NjxalT2h/8oHCIMRJaKFi3KVNmhAbcCkQJQ
 PnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607183; x=1772211983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bzW78w1dPlWGmVg6647acRJROJFPKKATd7WIMabPUwE=;
 b=m74CHt9NXA4GBiaTZGl3YAGK9nIF5MgUJQoo1vXR6cWLoj32jwdPuDM5CSIUwT1m+p
 1GnmMEoD5jO4c/yfha06v/W/xc/KCegh7d/TKGdwZLFXoKTQ26YqgJrm7U0SMb1sIO9O
 1PakIjT2DTGeVLcMenduPoijW/8rB06kUCCZhrwKdYNjUeZRU77cBRLh1Uots3rneuOc
 KWgbhKHYLFNEW3lkC83WxuiWKl+bhps7+X+m3vvwPJE2qNXegpL7aJpnFBn+RobHRbWs
 d/ekIFQGQk3CTc01vBOPTUxAGj6q9ECChtxphUxKfVvbePzNWkwkeMpwf9j4RHj3MQfk
 FnVA==
X-Gm-Message-State: AOJu0YzCXIF36sWE7R1q5t9OxD/NfOmBNm1296B7EpCQqGRLXHSq8QQi
 LPrLycZqH7GsjFLiZ/4keUT8ZUQsC2Ij44eH5mEc5r/a4M0TBzWpsfaP0AJNO/lsKfhAdllA+um
 tUVFT
X-Gm-Gg: AZuq6aKrdfjvoWLVMjGE7zZauv+GwWtOaJRfDZvFkDn+8GeZPdFSVtIHWoFsSc3u0l2
 yhsOCVPSLX/vUQFhaBTgAnsCIk6chgWkqC9BHDwy6fD8X6h/E0cOTCqvZ5VlL/uOyLZyml8yJPT
 8F5g+z3clW0CU4V208I+dyJPNX7TVqI5pSg61BCnYVpJ+djMUNuOqwtOQUm0Qyy7dzQXe7RKBAY
 ZvBtsyu0iKCDipdWCCbKCA93oQjgdNP2DIatfnhhKXxet8YRPQULG6hvMYI+QwGKtyj8bPHqMnu
 ej6ZnP/xlsVRomuMRa/L4LpDuxCnxKEnE9CsMl0h2MCo+Br6TUl5c3xMvlHRkAqC4C1deFiUjOI
 C27qziugQU9dnbxCu33gyj361JuoF7qUw7cXFod5rcI6Mj+7Ns2eOPBmZuPNA0bV70fLjgbKgtA
 5zW7z9yU96AqlHQNKoVl4pGwMLFx0YsDMlrIbRiEiwxKadNrU/OKUPqukhcvTwog==
X-Received: by 2002:a05:6214:40a:b0:87c:2c0d:309e with SMTP id
 6a1803df08f44-89979d4f4camr10316146d6.37.1771607183295; 
 Fri, 20 Feb 2026 09:06:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 04/10] net/tap: skip checksum on truncated L4 headers
Date: Fri, 20 Feb 2026 09:02:04 -0800
Message-ID: <20260220170614.75560-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

Add a bounds check before accessing the UDP or TCP header in
tap_verify_csum(). A single-segment packet whose L4 header extends
past rte_pktmbuf_data_len() would cause an out-of-bounds read.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 8b6d5db37e..45ca32cfb8 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -365,8 +365,15 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 		 */
 		return;
 	}
+
 	if (l4 == RTE_PTYPE_L4_UDP || l4 == RTE_PTYPE_L4_TCP) {
 		int cksum_ok;
+		const unsigned int l4_min_len = (l4 == RTE_PTYPE_L4_UDP)
+			? sizeof(struct rte_udp_hdr) : sizeof(struct rte_tcp_hdr);
+
+		/* Don't verify checksum if L4 header is truncated */
+		if (l2_len + l3_len + l4_min_len > rte_pktmbuf_data_len(mbuf))
+			return;
 
 		l4_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l2_len + l3_len);
 		/* Don't verify checksum for multi-segment packets. */
-- 
2.51.0

