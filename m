Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C2C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF58440613;
	Wed,  2 Apr 2025 01:48:41 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 35BDC4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:48:40 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-22438c356c8so119326145ad.1
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551319;
 x=1744156119; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvYRdNiBbR12G/7uful7iL+qWZL+0e30grQmwl2tgHw=;
 b=Hp/yHcxJkvdg0860s+94T6/YGnkExadDsj7ysORH14cDdfwtZYMYJRIAOJkAjW5fqx
 uurLfPkFi6vsBwW8rP4+XFuWDZXT4toG/eQZ1BxgM1rKLEsxglIf9lbatubjraEDyMxD
 unhkMBUgnXuPGMQJWYHNqudSzpRC3S29u4/LUFieU0VirlxRZM36Sr8bGzhBxPFUO7qa
 1cgMV/cH5s0iqgoADYtOZIAHy9noaPIaOrysErvpbTIFCR8hrc9ssvTD4QmodPCu2I7L
 OSS03JqwVIiFYTwal0drysPoyy0/P5GJY1jTZZ1lPzQJqjyVjnUl0rf/33GDvVQDfWH3
 FrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551319; x=1744156119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvYRdNiBbR12G/7uful7iL+qWZL+0e30grQmwl2tgHw=;
 b=QtEdJO9xj0T+qnUSUGzcmxedCiaCZC3BwtEmoMbRzqenu5KMnL9OfkTmZdOFIGdPqm
 IBuYIePy5P3RRIA6xo1R5u2VRoypN5i/Dc1da4xE6ep+ePvySGz7y0xdGftqc+HvI8/e
 +X+OX59zC1PyhF3/cZpBghRCxkAKY2P3XoN1hzNLdigNuPA7Pvnp6zDQxulShvFteEjU
 5iAK9787KQ2/iuguHGdpCw+SVjrJpSKEpQha9RjfFcvPQQVg9J2cupGP+iWLHzTs5qSC
 i4oazUlXQM3tXo/IRXFk81l58WC+SAj9XckdjWIgwdp0C+fdzgvoUF1vKSIMAxkyVGLx
 HCgg==
X-Gm-Message-State: AOJu0YxRf1n9tkzUX8uGdHUgPWbdOoeT+NZ9Eu23Fleje79ECoiAdXzG
 a1+k51PI/WevahAn/ndhlQWFx58MamZ/QXLBobGGsYit1Oe701LB8bzdLdeQHt+2OuwebUpuafA
 J
X-Gm-Gg: ASbGnctBqcjhP2d1VbSmpjO7cYvrPAmLNZARhuNPAF7ZjKiZmxvJGzjCzIBcmsSXpup
 qO6W8Rmup7YpS0UyqniUfN5xH4tzusGgn9PAeXubFzpa9Rrv6QB5Rbg5tn+aYj/R9FUyELotDkA
 +xMBq0F8TUiREr84emwP652TmK7O682iRMqCXM+Fo3pgF0oZ1nIyL62q/Pm8mSflZ1OzDkduxYp
 uqa9b0mx+m4w6R/5Hr1sy03RRNFQ+VD9DOSSiNRcMK/KSstW1ohFIMFUTLNMKgV5Ulp74yuRM6v
 QHiMXhIh0mxRPXbBTv5qKTjqtxL/9jmFFEnWXXcaYJcPEPNpv549OXRarbXk3dR2zktjVcVSSvM
 V2JmdJCUtHv+keldnz/yZ
X-Google-Smtp-Source: AGHT+IF6ZAljT5+0hWTrECefpGiRqpLYaGSUFXSIz7hg3NqAwjt4DdqIrdgvUm8u/9FyG7QWouZK8g==
X-Received: by 2002:a17:902:e549:b0:223:fbc7:25f4 with SMTP id
 d9443c01a7336-2292f95d954mr205009615ad.14.1743551319321; 
 Tue, 01 Apr 2025 16:48:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8bc5sm95135175ad.250.2025.04.01.16.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:48:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, mukawa@igel.co.jp,
 stable@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v2 1/4] net/null: fix packet copy
Date: Tue,  1 Apr 2025 16:47:26 -0700
Message-ID: <20250401234828.10888-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401234828.10888-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
 <20250401234828.10888-1-stephen@networkplumber.org>
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

If doing copy on transmit, can potentially copy past the data
in the mbuf. Change to only copy data from that segment.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: mukawa@igel.co.jp
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 6764cf2ec1..966748689f 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -35,7 +35,7 @@ struct null_queue {
 	struct pmd_internals *internals;
 
 	struct rte_mempool *mb_pool;
-	struct rte_mbuf *dummy_packet;
+	void *dummy_packet;
 
 	RTE_ATOMIC(uint64_t) rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
@@ -163,17 +163,17 @@ eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 static uint16_t
 eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
-	int i;
 	struct null_queue *h = q;
-	unsigned int packet_size;
+	unsigned int i;
 
 	if ((q == NULL) || (bufs == NULL))
 		return 0;
 
-	packet_size = h->internals->packet_size;
 	for (i = 0; i < nb_bufs; i++) {
-		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(bufs[i], void *),
-					packet_size);
+		struct rte_mbuf *m = bufs[i];
+		size_t len = RTE_MIN(h->internals->packet_size, m->data_len);
+
+		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		rte_pktmbuf_free(bufs[i]);
 	}
 
-- 
2.47.2

