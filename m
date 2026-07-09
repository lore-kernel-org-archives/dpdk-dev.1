Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C4C44501
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 04:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2146B40A6D;
	Thu,  9 Jul 2026 06:07:51 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 2F8B240A67
 for <dev@dpdk.org>; Thu,  9 Jul 2026 06:07:50 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2cce406883eso14500815ad.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783570069; x=1784174869; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AjZ0gLYfA7Xmf7HdChBkhfcI4CRLBE4b3igEtRzjo6Y=;
 b=s42ZVSRexQrxx0zVP9S3gd3X/STkNYcDBMuygMGWO1JN1UzaNuYBBuDDORLRutFUrg
 X4SJuUwpAPhKjAgb3uBKZ0e35WAJ3OLxWWDU+VYJCDvEMy45Nuz3I/4SxZmHTcc9L5jo
 t4iQjP/C+FQGTgQRiUsx75Skqc06hkE+zsB9Q9Kmea82MExgVw/SenDaKrOtG/9bgCOd
 QRlvhWmhaE/HH0u4csbihH/hFLLfMUK2y5JyIdUWh1T7mGoOvWKs6rLSvEF4GQ22LO59
 pHESayOypPBPKFW9yebYkFLjwiQnRaViLmo457yxVsLyQzP+BbMlT0y7JXUQCSsSapeE
 54xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570069; x=1784174869;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AjZ0gLYfA7Xmf7HdChBkhfcI4CRLBE4b3igEtRzjo6Y=;
 b=TWXpFm8isls08x7foeXsVKvf/tzG7ZIJ4OfyROshEPes/XgatJSAtFkLFbeMj65Yux
 WXAgni04hK3mEA3E59crWOkghHo+y+J+6gFkKj6ffXP6BdXoaVaa4EXbo6EqYmKeKrfE
 TCYpmTqeJMvcmamcOQT8qJhAaAlQ5ZPO6lFdJeDuzNPACEPdOkmawCGEQ7r1j0UIGaxy
 brypl+sK9ZV7PpvT29jRuG2/974TFGEgWs69AfqJynAp9ChqJq9vC5xtc5+m4wFwSMpN
 p4fzG7nWlkPMSb3boK2uN92jCku/ypbYSPl+NcHobQWG5fw0C8+6B+TG3nexzz4bwL5z
 13AA==
X-Gm-Message-State: AOJu0YzlK6+uvVWl/Zy4TL7Bta8cr57Sdx7Qah+e5gwuibwb4yBajUL+
 E6Pz6CdwWgftl4Gxlkbo+8Ys+WIMd6oJ59BHFCrqyrSXkphiOuEHHlLGBLly2ooYs2fDX4Gxshl
 jNMMUB76y/VL0pw==
X-Received: from pjzh3.prod.google.com ([2002:a17:90a:ea83:b0:380:f2d3:86f3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dc2:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-389418d96c1mr5466810a91.20.1783570069164; 
 Wed, 08 Jul 2026 21:07:49 -0700 (PDT)
Date: Wed,  8 Jul 2026 21:07:32 -0700
In-Reply-To: <20260709040739.3184955-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709040739.3184955-5-joshwash@google.com>
Subject: [PATCH v4 4/9] net/gve: validate buf ID before processing Rx packet
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Ankit Garg <nktgrg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

The buffer id is part of the RX completion descriptor for packets in the
DQ format. This value can technically go up to 64K, while the max RX
ring size is 4K, meaning that there could similarly be an expected 4K RX
buffer IDs. Validate that the RX buffer ID is valid before attempting to
access it in the sw_ring to prevent a potential out of bounds in the
event of a hardware error.

Fixes: 1aed73b23ac0 ("net/gve: support out-of-order completions on DQ Rx")
Cc: stable@dpdk.org
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_rx_dqo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index cc343f3fd8..c4e2d32067 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -200,6 +200,11 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		}
 
 		rx_buf_id = rte_le_to_cpu_16(rx_desc->buf_id);
+		if (unlikely(rx_buf_id >= rxq->nb_rx_desc)) {
+			PMD_DRV_DP_LOG(ERR, "Invalid buf_id %d", rx_buf_id);
+			continue;
+		}
+
 		rxm = rxq->sw_ring[rx_buf_id];
 		gve_completed_buf_list_push(rxq, rx_buf_id);
 
-- 
2.55.0.795.g602f6c329a-goog

