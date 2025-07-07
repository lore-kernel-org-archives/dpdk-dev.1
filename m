Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D168C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:19:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F63840A84;
	Tue,  8 Jul 2025 01:18:28 +0200 (CEST)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mails.dpdk.org (Postfix) with ESMTP id BEE0040A67
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:25 +0200 (CEST)
Received: by mail-pg1-f202.google.com with SMTP id
 41be03b00d2f7-b31bc3128fcso5278936a12.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930305; x=1752535105; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iUIeyx+rYzJDb5Ul1KAff7qqm0zR3OAgzP3cO4wGMFQ=;
 b=ao3joRA+gbr/MkIqpW6J9on5EFYQSuuWkeibOFpswVh2HJmkn/7l6yVbhTnYjebFti
 hRVV4je0d9U5lg8FsagIVf3Z7P4KeIOjNmEbGnj4T5a5pycjbgNgZ9G3zYX32g6OMbC9
 ZumztYfoxLSLm1+AmcsNjlxmj23OVNGccIylv7BfUNCdnqLvppnYPV6ZtIo7oZVK1g49
 yV4zJE/2/hMVFQ7+82laBOR6AtmQyT0gDGqiBCLywu28qoAS9JnUAxvrxn76qhPVPe7U
 MMyfkcMxexXEyyKQq4xBbW8/FpCz2zuW/2e2h6FAImcSJNsM0OQ0vCUAWB+nzZIXGZxy
 uySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930305; x=1752535105;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iUIeyx+rYzJDb5Ul1KAff7qqm0zR3OAgzP3cO4wGMFQ=;
 b=gs0nY2B8nX+P/gXlcl1JY9XvbKIUbmIFH1PzHKnYBw7+mgIH2G8fncC6LqdiGSQh31
 Mk3eioS70I73F+AOnbXByZM1iZ+rcKW+JFNDG5Y20N2UwukNukzuGGf/DNFQuVXljVXd
 V3awMNDQcMw8aShd3WEtqGoWcgkmX+qWLJogFwTZQVmGP1RpH1x5JHS+CVawo3rzNjzT
 HEePfnDx6G+q1tKU1w6DVKwXSfIuwxudUA5VtLASPnk/zMMEZ7p/MwuH/M/qhEWaEdMU
 Eai4z4CgCZrrgkbSclvB8CPUQc+b2wvay21QcwOrR40unHyfY5vZ7F4gAXHT7BGgGqvR
 sb8Q==
X-Gm-Message-State: AOJu0YwhZqNgbo+abQGDWskDWJwvKwdMxOgAPhSRvUY6HnWThUIIm2ZP
 m1VDGzGjOy1rJsaojNdRtpojbPlQaJU4TqtQijn6+29Vxvn1Pr0G1TMkuk9mUoJ3tbpRSKW1XSF
 cX41kxnZ08NjRgQ==
X-Google-Smtp-Source: AGHT+IGVx31dgqmdPbL9EO2OF2dOANfvEXvk2OkVXcu/brUAnbw3o4TrRnnr2dN0zW77oGSDXmfEbBUzn8tH3A==
X-Received: from pge7.prod.google.com ([2002:a05:6a02:2d07:b0:b2f:1e09:528b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734e:b0:220:2327:e6c2 with SMTP id
 adf61e73a8af0-225b85f3ec6mr22562985637.15.1751930304913; 
 Mon, 07 Jul 2025 16:18:24 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:11 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-8-joshwash@google.com>
Subject: [PATCH 7/7] net/gve: clear DQO Tx descriptors before writing
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>,
 Rushil Gupta <rushilg@google.com>, 
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
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

When TSO was introduced, it became possible for two differing descriptor
formats to be written to the descriptor ring, GVE_TX_PKT_DESC_DTYPE_DQO
and GVE_TX_TSO_CTX_DESC_DTYPE_DQO. Because these descriptor types have
different formats, they end up setting different fields, which can be
misinterpreted by the hardware if not fully cleared.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: tathagat.dpdk@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 3befbbcacb..169c40d5b0 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -159,6 +159,8 @@ static inline void
 gve_tx_fill_seg_desc_dqo(volatile union gve_tx_desc_dqo *desc, struct rte_mbuf *tx_pkt)
 {
 	uint32_t hlen = tx_pkt->l2_len + tx_pkt->l3_len + tx_pkt->l4_len;
+
+	desc->tso_ctx = (struct gve_tx_tso_context_desc_dqo) {};
 	desc->tso_ctx.cmd_dtype.dtype = GVE_TX_TSO_CTX_DESC_DTYPE_DQO;
 	desc->tso_ctx.cmd_dtype.tso = 1;
 	desc->tso_ctx.mss = (uint16_t)tx_pkt->tso_segsz;
@@ -257,6 +259,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 					mbuf_offset;
 
 				txd = &txr[tx_id];
+				txd->pkt = (struct gve_tx_pkt_desc_dqo) {};
 				txd->pkt.buf_addr = rte_cpu_to_le_64(buf_addr);
 				txd->pkt.compl_tag = rte_cpu_to_le_16(first_sw_id);
 				txd->pkt.dtype = GVE_TX_PKT_DESC_DTYPE_DQO;
-- 
2.50.0.727.gbf7dc18ff4-goog

