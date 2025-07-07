Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA866C83030
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D03CA40696;
	Tue,  8 Jul 2025 01:18:22 +0200 (CEST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 524F44066E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:19 +0200 (CEST)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2355651d204so31934515ad.2
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930298; x=1752535098; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zhdn/imtq7YMm5c62/6IVGuAwLQwan5d9W1SwOdUHd8=;
 b=MrCPd/V/5i/39ph/CcQQA8PybR4vl8A0SZvmIi+TpzaitjOZX4gr1DExykOQD92/tQ
 ntftIcLYKo9rXLHvDdFczci/cfdvK4F7/uWj0Hayy7dNRV/jz19gtKGkmVTYpfnOlBer
 aMCVf6e+t72XX+B9KW1yBpRm3T+++5voC54+wi//rJwGp40tZIEnYVnyDxtb5CCgLAeJ
 Pau3FEYHCyNgQh0l2oZIvRxVKknKe7ypYFjxIfR5pIlT3+4twE5Wiqh8U1Q98lFIxe5w
 oq6X9obs36pr0NN+L/CV1LykPjVbiZuBJWUwyEFqB/fhu8BxUCenQ9g7Npjzn/KoS36W
 9LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930298; x=1752535098;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zhdn/imtq7YMm5c62/6IVGuAwLQwan5d9W1SwOdUHd8=;
 b=EoS6OWyaDvL09dK2ueiSGILuaB+7sZZHQCez+3ia0qjzaeCAJPQgC7/Z2UJjGXJ6GT
 JS597kRtWwX8bk9mpW7JTPcxb0UvcSVrS+DlB2eVfd2KzpXCFH6cfeiKadGyCJleVUNW
 pWrka9PNk5CV2DVMBgGRcA4iApEVwpyaReTfuluJtQEqHwDa36HXis7fZMa90zgVPaLQ
 BpB0HO4U9BshQvXNeO5FPu7dFA1eFafzxvm718tqVnecZ1cY6whmoqetutg/ROddRmmB
 MdIGw/fx/hsVTEvfZaFvvpNWgXgHfmcDUo6WjSBDBsKju8QPoBTUn4BQjRpgAgd3f8WE
 AX7w==
X-Gm-Message-State: AOJu0YxE7lgaM2LQMMnw9/S+UIrhcBDVv15RFstyF9TqQ1hCoTOGY2IP
 vQy5OufGvDSdEmU8Dx241VHgpY88m09xcWP+rmA7RTo8ojP7OH2Skt9OwDKoXO/7OFFWB+8Gfkf
 KMpPRjly7Mt/sPg==
X-Google-Smtp-Source: AGHT+IFYMV+rHjoZCrap7x735sDlWz1yhsCgrQOuZnmJ8AlSHGrCU1OPagdlOli4pgfoBi1Dy2IvFoe1Cohzvw==
X-Received: from plxe8.prod.google.com ([2002:a17:902:ef48:b0:234:d477:3b7a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ac8:b0:22e:6cc6:cf77 with SMTP id
 d9443c01a7336-23dd1d9df3emr6239445ad.53.1751930298465; 
 Mon, 07 Jul 2025 16:18:18 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:07 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-4-joshwash@google.com>
Subject: [PATCH 3/7] net/gve: don't write zero-length descriptors
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, junfeng.guo@intel.com, stable@dpdk.org, 
 Ankit Garg <nktgrg@google.com>
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

Writing zero-length descriptors to the hardware can cause the hardware
to reject that packet and stop transmitting altogether.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: junfeng.guo@intel.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 652a0e5175..b2e5aae634 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -168,6 +168,11 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			if (sw_ring[sw_id] != NULL)
 				PMD_DRV_LOG(DEBUG, "Overwriting an entry in sw_ring");
 
+			/* Skip writing descriptor if mbuf has no data. */
+			if (!tx_pkt->data_len)
+				goto finish_mbuf;
+
+			txd = &txr[tx_id];
 			sw_ring[sw_id] = tx_pkt;
 
 			/* fill Tx descriptors */
@@ -189,12 +194,14 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				tx_id = (tx_id + 1) & mask;
 			}
 
+finish_mbuf:
 			sw_id = (sw_id + 1) & sw_mask;
 			bytes += tx_pkt->data_len;
 			tx_pkt = tx_pkt->next;
 		} while (tx_pkt);
 
-		/* fill the last descriptor with End of Packet (EOP) bit */
+		/* fill the last written descriptor with End of Packet (EOP) bit */
+		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
 
 		txq->nb_free -= nb_descs;
-- 
2.50.0.727.gbf7dc18ff4-goog

