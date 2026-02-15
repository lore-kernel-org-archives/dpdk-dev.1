Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86CE63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CF8040650;
	Sun, 15 Feb 2026 20:54:03 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 13DF44064C
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:02 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43621bf67ceso1491461f8f.2
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185242;
 x=1771790042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKQ3Uy/UiZs4vEm7f8mMmJshP6YhKPmrxgdSZorD88s=;
 b=z3TRQdB4drEXJCskkLymh3qDKq4NXJx7EHSRyRmHyGBxpnyn8/l0KUYxmmnOQurF7f
 we4wTjiMtDg5Afc6gLQWPNShqDaBT71WXPff8+6BnBjgZ134e4al7KMricf7n1gZJIGS
 UqV6Jw3lJNN24ilHEVMZPcHw0808jPSoAbDdvl42ip0Vo+HMB2+3x4CSZxuMju0ZSt8M
 8EfFJWa7vs15PO8qNRBL/L9nJhSiJifTK0xvJJf7j6MxdQd9cbO3VpDI4+Jt+WhS1TB6
 /0tgYOzezhrclbhg5KJGMingbyJxss1AQK19xOKQW9U7lBC5yJjEQ8oHItgAsREUAout
 s3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185242; x=1771790042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aKQ3Uy/UiZs4vEm7f8mMmJshP6YhKPmrxgdSZorD88s=;
 b=psLIkEFjylfp7GjG1AQGOTEoMDs7nZCYUztyWmGzz5TIJerBOu13lEFaBrHtQBnXJ2
 8MYQ5GAdZBmRx/nglj2JMmGQl2ah8tHe9OoUuC4MUJ8BeTO9zGqvRRHYb4VHnBJpKsRf
 3j92U7msYQ7DGXoMJvF9MlhgNMsBF6/mvVtaJgV3kfiuJQfch9mIhvOcDahdQB5Af0Ia
 pEZC8UVovm3k1se0TwZaqZtNJMn+MgG3roWZChaHz9CPsaNBuDAx9U9qiHEwOWDC86QY
 Tnsf7afo8pxcMnvfTOnLT8LOHltMZolQfBjG3TzkQ8lVrX1Z/YkI7WHQ93GkgrVYndG8
 9FkQ==
X-Gm-Message-State: AOJu0Yyw7OUv3tp7R77+rr0z8N3yrsEULYWHfQeHwm+bc5eSY0RCot5L
 VEL8ZZjg7yb8mDyvMRap6VjM71HEX3j4RS/DDRBzTJ5lTNS+Whey6q3zolGmAJWKlpvMBLi3WwB
 mO8DTn7U=
X-Gm-Gg: AZuq6aJWsdGmn6nsP7Bhc6EU/IzpsksRMRor4vgSw97Qy8FM02nQJwbvn/UZM5ceCB9
 USM6Oj0Y3EPwc8bsVHJkjW9uhDQQ0UUlIx16O+eIzCFNdvx1Xp8ovtGRTcKgsniAfKYRXsWePQi
 T2mK9UKjGvlh4y/0l9o3z12BlTf1PyCU5EGqyglsg09KP6jM1jJqYe8l8vXdHisUu873fTo3bTL
 xjt1+VlWMEXu7HOFEAEBGsyR/tgPASkOdAs39wXwlI5fIIdbDIcfVKJU20st6ZHQ5XxTOFhZaFU
 aWHrLjmErIy5VXub4o0Ms+3YxNTlVKGqNKZyGdXMwIz+X4AzPqcULG0KhqYHjmfMDFK8LeTQyXy
 ie7C6I7RLaBWwbWk3G/UFwWd6WPe9o3ZLELYE4mVvgMPSXVZjMDTgbLM1m503Fi9vynCkmtnAqs
 s9AoX9xUaY6Ok/GT2UHa3ZB00F3yCn32LIjsUDacLHDrDIukGFrfSlAIxH3QppRA==
X-Received: by 2002:a05:600c:8b84:b0:483:4bbc:89ea with SMTP id
 5b1f17b1804b1-48379c42db1mr101982345e9.37.1771185241662; 
 Sun, 15 Feb 2026 11:54:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 05/10] net/tap: skip checksum on truncated L4 headers
Date: Sun, 15 Feb 2026 11:52:23 -0800
Message-ID: <20260215195348.557945-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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
 drivers/net/tap/rte_eth_tap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index fcc452527b..4fa71429fe 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -342,7 +342,7 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 		 * greater than the total received size
 		 */
 		if (l2_len + rte_be_to_cpu_16(iph->total_length) >
-				rte_pktmbuf_data_len(mbuf))
+		    rte_pktmbuf_data_len(mbuf))
 			return;
 
 		cksum = ~rte_raw_cksum(iph, l3_len);
@@ -357,7 +357,7 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 		 * greater than the total received size
 		 */
 		if (l2_len + l3_len + rte_be_to_cpu_16(iph->payload_len) >
-				rte_pktmbuf_data_len(mbuf))
+		    rte_pktmbuf_data_len(mbuf))
 			return;
 	} else {
 		/* - RTE_PTYPE_L3_IPV4_EXT_UNKNOWN cannot happen because
@@ -367,8 +367,15 @@ tap_verify_csum(struct rte_mbuf *mbuf)
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

