Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D441DC369D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 15:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A8D74042C;
	Tue, 22 Apr 2025 17:52:06 +0200 (CEST)
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com
 [209.85.128.97]) by mails.dpdk.org (Postfix) with ESMTP id 41ABF402DE
 for <dev@dpdk.org>; Tue, 22 Apr 2025 17:52:04 +0200 (CEST)
Received: by mail-wm1-f97.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso25111875e9.3
 for <dev@dpdk.org>; Tue, 22 Apr 2025 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1745337124; x=1745941924; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHPssj39VGFIIkgqBoFARWtn4d+9iP+BTx8Pz7s6cb4=;
 b=BWDMJlcpqnHA+KMqgKHD29+9zEHCWF174CR+HA3WN4nlVFjvDgAwlMrxrPSAW0VShi
 wOyPeQE1xoXY3zXtUHQ7i/QvT5ABo1nJNRykoxmgIrpZoNNoeJAUDSSfxI+JNfEmWkrh
 uaUOzYKkQPPphfux5uUQUZrYEw73luD/ZXr+bQg919jhIbOEogLxgGQpjGth26oFA9IF
 vY3bRL3CcPRuYyfrQxI5S4XJKhmbXndKjqfF+M29WVjO3vdY6LbKL75dsydTl7WLBtos
 aZkJCRFESOkpP8HPgqwBQlA0SnMQaz2x/Jg4iIwBdf1KEoBbiznlMlnRQhMVe2hCqYzm
 3oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745337124; x=1745941924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHPssj39VGFIIkgqBoFARWtn4d+9iP+BTx8Pz7s6cb4=;
 b=Lyf4E2q+NJTewb/BvuI+68HAsWUecqs9iS2ZfmpwYDxBmAzy6Lhtxb+ZgmgpmEYi4B
 QyebTnW7O88kuPmXSBpwpkuSzLgGUYQcJCLZDiKjLzmpNMUmH60RCP/mrTzqpxWx4X45
 500D3Gua0TfSPKtleR7nPmfk+EJkpFNq7PpZubmkzuiRCzgjD7PvbeDepbtETXvQlAop
 pYY7NMgV2d7K2Hrf8z15aGmHxO4BMLhu23jI3JohcwCtTMuZVhjnBf879+wpMN05Lb9k
 F33b2+Vzt4zYWBZX1Fdsdb06EE0fR3R19Juz9Bj0BMqsA1GEeTA9apE85Xond4jEMYY3
 PI2A==
X-Gm-Message-State: AOJu0YxMZezghVHHYS4K376ztWlL8OTlOUvTFDv2LtOCqjqA5NV9Nijq
 0lCL03DfXJjn6a2Ln4rrCCoRAzLnK5UPRi1sLa6VMW+83E+i+yTU2qDp5yTlzkR1GEEZFl8Favn
 nGuJ5cmTx6wQvn89F0wu9exFa80Wc6+FiNqUbNTP0
X-Gm-Gg: ASbGncsKYKkuOA3IGyDr2zzwgpEzcH1XQILhknaO0qgL0Ux2RDechTpWKCI05gJQ6v6
 qc9F1KvSMT+wcl+q5VJt4kn283jquxkHC9DogiErtBVYmedl09Stj7HBqRJrqnjUCfF9R2+qxze
 SKU1TodSLv+entmddsG+lWLGctLlwI6rXLJD5w2Yj91Y1tHn5B2+u7tE/3BnFNhhEhova8MMjdZ
 tYccftB0r8teRJyK2iOaDFb70pyUNkhwOtupH5ZHBiPKimET+kRqeivCxhPf3Kf+fcc30Nm17UD
 SE8fDnXacR6zakPbtcvf/xp2qxGozh1JMCeNw5aaBJ3m4DXzQxcbFJNeq4I+Pni0734=
X-Google-Smtp-Source: AGHT+IFvvOrBG0TfeuBmPVgL1rXvzT+JcoRpyInqlIW5PZmgVOXdZP5kBLeg3m++nmQqZ3bQsXRRjllaTDry
X-Received: by 2002:a05:600c:1d02:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-4406ac412c4mr163556955e9.30.1745337123851; 
 Tue, 22 Apr 2025 08:52:03 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-4406d5bf7cfsm9120505e9.22.2025.04.22.08.52.03; 
 Tue, 22 Apr 2025 08:52:03 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (dio.dev.6wind.com [10.17.1.86])
 by smtpservice.6wind.com (Postfix) with ESMTP id 93FA9360DA;
 Tue, 22 Apr 2025 17:52:03 +0200 (CEST)
From: edwin.brossette@6wind.com
To: dev@dpdk.org
Cc: olivier.matz@6wind.com, didier.pallard@6wind.com, lauren.hardy@6wind.com,
 dsinghrawat@marvell.com, palok@marvell.com,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [PATCH 3/5] Revert "net/qede: fix maximum Rx packet length"
Date: Tue, 22 Apr 2025 17:51:41 +0200
Message-Id: <20250422155143.3893525-3-edwin.brossette@6wind.com>
X-Mailer: git-send-email 2.35.0.4.g44a5d4affccf
In-Reply-To: <20250422155143.3893525-1-edwin.brossette@6wind.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
 <20250422155143.3893525-1-edwin.brossette@6wind.com>
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

From: Edwin Brossette <edwin.brossette@6wind.com>

This reverts commit d8ded501e05ce879f27f0ed1df7721a88b737e25.

The maximum length for Rx packets computed in qede_rx_queue_setup()
takes Ethernet CRC into account. This is not consistent with the value
computed in qede_set_mtu(). RTE_ETHER_CRC_LEN should not be added to
max_rx_pktlen, as HW does not include CRC in received frames passed to
host.

The original commit tries to fix another bug with this inappropriate
patch: packets with size nearing MTU limit are being dropped. This is
not because CRC length is not being accounted for in Rx buff size, but
because of the flooring applied to it: the rx_buff size computed is
lower than expected because we try to align it.

This issue will be fixed in the following patch.

CC: stable@dpdk.org

Signed-off-by: Edwin Brossette <edwin.brossette@6wind.com>
Acked-by: Didier Pallard <didier.pallard@6wind.com>
---
 drivers/net/qede/qede_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index 601fcb30b357..fe839a6ba844 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -235,7 +235,7 @@ qede_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
 		dev->data->rx_queues[qid] = NULL;
 	}
 
-	max_rx_pktlen = dev->data->mtu + RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
+	max_rx_pktlen = dev->data->mtu + RTE_ETHER_HDR_LEN;
 
 	/* Fix up RX buffer size */
 	bufsz = (uint16_t)rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEADROOM;
-- 
2.35.0.4.g44a5d4affccf

