Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E6F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F3042709;
	Fri,  6 Mar 2026 14:31:05 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 3FFEF4279E
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:04 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso86323575e9.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803864; x=1773408664; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dF+IhIlbLjB1WGNWYN3FPOn9WaUWaJ4hjm0HMKzTE4=;
 b=kyuLCXfsTHJKBf+oY8ZJkTkCbq9jW6edKXvhq4lJOKKaNwyIp+4huXFVkHrcoOdx0q
 MF0CzLvTUpejt2aYGWJix1Bri3HIRYM3o+RWQvckFVBF4Z8ULHyXeSH091DO+SNophg0
 m6joTjQU0dWf/LU3toKepFu8Zf11xFZyP2xiIjKwtjLnuoIS0VJ+ReBUPdEYq8etkNOJ
 fDMOaiaJUDFXYJAo/u0+yVZoUaFS/N1Y37NPBLKatC55kJnsiXicKKxCJFsOyRm5fppA
 PSHx4LGvOZXNvWS3OiZFpJVYeHyroiHTlspPKTv+77o8Mz4he1ei0JyuozOZqnSKf4Oq
 XNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803864; x=1773408664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dF+IhIlbLjB1WGNWYN3FPOn9WaUWaJ4hjm0HMKzTE4=;
 b=nrVZmwkGAa1w7tOORkLCQrdYd+5IRnbwIq9XWqwI7GwaH4SRUlD6Zd0V31oq6vWI79
 5PYgH7AGGvwgRXOF1j4bu84VqOA1c81oHZ59112+g+bYuft2ZBUWzM8yVt05fkKTP5/H
 1MsgO0HoakjggqjQLnNH1z21fpJOW/hxfRc3UTGV0JBpAKZHWGy4ZHwwLhpi1ry5bb59
 fP7om6uEbrMeGMWKS0C07MgrSTxU1+bGMJWplMD1SpfaYT5YDrPgaKB+3MM1cFbFkkrq
 6j0cEpTX9toAUjmOnB/hksR0kgh9KJn7NYjhX/Mpp1lchGtPhtfMGSmu0SYRPx+n/q/c
 uTOw==
X-Gm-Message-State: AOJu0YwKK0ZpG/yr99PmMKtW01NqIY9KKMYKvEHhpvaBvmOwOLQGb2Eo
 c6r7QLCDhQUN+JySUV2jm0XiBM32lxLTvsV+gjouP7nf71fOLBbodn5rD0nrix1n
X-Gm-Gg: ATEYQzzAbU8yPBvnFQ942FbT+HekQQ+/0DpkXI3WFzljOtAy7hQga01mM6zyWXqcMJv
 ZWNqswElz14gwoWWTMp8P22be2K/TcgDvqRrhF4gHs0rxo5BpNT5Dv1oum1CTFVKRIWoGmSBShH
 LMt8LAbxOol3GGgJWHveshWOrvHd9PQoVZC4nXD3Y55ULeLDYPRtGmCee52UysZDyzY0kZKUvsv
 fgUSYvvfex4U6bNWTPIh6o1SiL3bNhNkhnPZUf5+9xL8DZSrxKpCYy1hNBXpBnvapDBgnmfvJ9S
 20iqNZ1ErasJFcLAbZHtcdNeLbQ7c7bTWFPeeWcPImNKEw6V46nP/PjEYRPcb/kRIAHtHjuobmf
 9MsyIk8UT3jm3m86XwoWFu1pxeIAPlIW2MlahcRFDd3J6HxQA9B9Rz7o1scwO3jauPS1JaSo56E
 ZmvMVWrIM5YFXWBRbl0SWuulQLkkY=
X-Received: by 2002:a05:600c:4ece:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-48526966375mr33452035e9.25.1772803863753; 
 Fri, 06 Mar 2026 05:31:03 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2bdf8sm4012186f8f.25.2026.03.06.05.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:03 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 09/17] net/dpaa2: fix L4 packet type in slow parse path
Date: Fri,  6 Mar 2026 14:30:27 +0100
Message-ID: <20260306133035.179709-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

RTE_PTYPE_L4_* values are not independent bits but mutually exclusive
values in a single field. The code set RTE_PTYPE_L4_NONFRAG (0x600)
first then OR'd the specific L4 type on top, corrupting the result:
- TCP: 0x600 | 0x100 = 0x700 (undefined)
- UDP: 0x600 | 0x200 = 0x600 (UDP lost, still NONFRAG)
- SCTP: 0x600 | 0x400 = 0x600 (SCTP lost, still NONFRAG)
- ICMP: 0x600 | 0x500 = 0x700 (undefined)

Move RTE_PTYPE_L4_NONFRAG to the final else fallback so it is only
set when no known L4 protocol is identified, matching how
rte_net_get_ptype() handles L4 classification.

Also remove the L3_IP_UNKNOWN_PROTOCOL check that OR'd
RTE_PTYPE_UNKNOWN (0x0), which was a no-op. That case is now
correctly covered by the NONFRAG fallback.

Not tested, found by code review.

Fixes: a5fc38d422a7 ("net/dpaa2: support Rx packet parsing")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 0de52cbef2..9c908f87b1 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -212,24 +212,18 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 	    L3_IP_N_MORE_FRAGMENT)) {
 		pkt_type |= RTE_PTYPE_L4_FRAG;
 		goto parse_done;
-	} else {
-		pkt_type |= RTE_PTYPE_L4_NONFRAG;
 	}
 
 	if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_UDP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_UDP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_TCP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_TCP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_SCTP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_SCTP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_ICMP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_ICMP;
-
-	else if (BIT_ISSET_AT_POS(annotation->word4, L3_IP_UNKNOWN_PROTOCOL))
-		pkt_type |= RTE_PTYPE_UNKNOWN;
+	else
+		pkt_type |= RTE_PTYPE_L4_NONFRAG;
 
 parse_done:
 	return pkt_type;
-- 
2.43.0

