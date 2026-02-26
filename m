Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B3FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B23840BA2;
	Thu, 26 Feb 2026 15:34:19 +0100 (CET)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68]) by mails.dpdk.org (Postfix) with ESMTP id 25FAD4067E
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:11 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so620559f8f.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116451; x=1772721251; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wICoJ1xm5vDGX4G3oGTdg0TpTtW9PY/KVYX8jM7S+rY=;
 b=SwYdHD7hvoVH0i2DRZ4jiEezAsuJWUtxaQOWS2csx/wz7mRojnF/5P5oKlJeGUbrJZ
 RbJlv6l2X2GB6gK4qQEjU/5KPipYsEWWuToj/F1qn6XQBnsXALWgZr9F2ZqrWB30LRbj
 7xTzyVz9CH2gVtHcNLWhSHbuwu2PuOISAdVGihep5jbzI6c+BqurKvlNmYFcoP9VGYH9
 iYh2pO8TT8zyUCdcb9NNSw59ezzsxMZ9a5wrskRSMefFBRT4nIFyLi1N7PMf6eF+EfNy
 hb+8BezqasZMh17YTA6/bXgRcf/RtrS5QfbiOVUqNpK5S/hrfFb0rJeJetxQD2XKdlsA
 4eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116451; x=1772721251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wICoJ1xm5vDGX4G3oGTdg0TpTtW9PY/KVYX8jM7S+rY=;
 b=BeJNl7yHnBB0Cd06BZUNjYHCk86Q9pFTyfwPOcbVOnaHrQasF+YevMpGBdEmmW9kqN
 bxP2nJMQm1VNyHFesHJG6dM56SrsZcJ47BnsZ+jXAKMzY5U5Nkse2oyRBfb4D8dscvJS
 srgjiDR02FVtyde6G1PENynXx/asLjRuDqXfbzEqHZZGRXvnIbHwazaz6QIQOzgMGFcb
 jU7C865QUr3oGA6nbErZjSW7CY7a0rMuyMJmVzHMem7bNLn8JV7eFu+CNATT4xHd/1um
 87CZZC6LQb3aPT6LJTCK66D1cwvZKn2C45IzoxK0oauAstaZDm6pjt4VMyxE7Hn00TbF
 1Iew==
X-Gm-Message-State: AOJu0YwL40kJRbNI+4B13dLxKMZyGto5l28nrKAkFqfeNiw+qwoJh+Wy
 wr3Qs+KYchq/m2lOL4LmIAruDA+v5LA4ptNEyereHGMB5V/rfHtJQ5yS3P/5dA8/
X-Gm-Gg: ATEYQzxO1FxLZDSdOLjoLOBNsqG4l85xQBePKrPDIYZuL2CUgUbypbsBOzMOFVWW2mn
 R38plSKst9ckD2mJ9+IkAwaAlkh3O7bJGNu2ZCKmOouq7bE6dIrbDIGOluxukIraSNCdGYyMXvh
 46WiOXrFY3cI6uDWvjtJX/G0+XjEojIv47jFRN0tTFfMBTKjPQ5yrxfrNGhpH5kZyn2vBSCtXsU
 sIPcjAX7J8Tbog2GXbcpihAZ9T2Z/XHR9W31aIvCyDNrbyx2oJr/7d5vrqZ5OmBuUbYTck/8C/4
 5+lG2hg73j9qRaqrPlT+iYhPT7FmrUBHXAvk5hqUkYjXDXEmxejN+7OWc6NJuAIpjl5O79fyhdb
 EoYHJuXsTSmWq97ciZKiRSvV/Y6A8IqF9HLvrj1dlv72YNpmF1IKi6HWAKJfXRbiYjKOMyxkc6v
 3sszF/tV0RiSjz1vfoj2dpRtjwOg==
X-Received: by 2002:a05:6000:2283:b0:437:6629:9b82 with SMTP id
 ffacd0b85a97d-439943060camr7661152f8f.52.1772116450566; 
 Thu, 26 Feb 2026 06:34:10 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:10 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 09/17] net/dpaa2: fix L4 packet type classification in slow
 parse path
Date: Thu, 26 Feb 2026 15:33:33 +0100
Message-ID: <20260226143341.282188-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Fixes: 5765e0b7c875 ("net/dpaa2: add parse function for LX2 device")
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

