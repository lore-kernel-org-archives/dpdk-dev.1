Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35129C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA6DA40A80;
	Tue,  7 Jul 2026 18:40:31 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id A2514406FF
 for <dev@dpdk.org>; Tue,  7 Jul 2026 18:40:30 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-84786d85ec2so5864311b3a.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783442430; x=1784047230; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uOt0cNDsmnJQxi4vbXR7Zp5xE4/SiVdMNxSM3BU9YWM=;
 b=bFEAGcllXTWTSiaupNYNSnah/hA2122Eg4HrCmCT0KuPBth09AMWZLAmxEDiPL/01i
 DCMvNaNlLCSVLLfYL21Z6VNvzzg3UgHCvzPbxByt2sH/BMUruMCmsdgV/dHCQB8c7bgC
 23UG88yZrQDXHvZucTFpaoaM2BSvWq/92PGTH+RfpBwtRUNFhe42cOj/qUOU5qVq8MA9
 1o0VYPQyTlwIpaIkI88Ua0lrbjuItyyyjrIieg4xYLgR3PF4CDvqL3z9du0mRv0oBuVg
 Fu0eYPtxABAIeWmw0xR96ZY9LJ4380G6+JLSMhYVStlFM2tCiral1BU+HWYbeF9Ne4lK
 To3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442430; x=1784047230;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOt0cNDsmnJQxi4vbXR7Zp5xE4/SiVdMNxSM3BU9YWM=;
 b=ThmI+I+dZbwRco1Sgje1UvgbM2MKBqoJOYdLqzQVmnqOlgnx2h+TmUNx9loG4F/IZD
 8l6yBUFECypXdE6ZDN4++c6IRbxh03nqVYmOaI8Gi5nMjoS3AtnLX9tzcuW0ylC2yQS6
 4YjJcO6fgd0yWFIqd6SdhR8/slU70vM/sXmRsHoMYFFbafVezlZklRbuN/OPTbzJXmGX
 eXQH50vDBeDVc+PChUflFTfW+HH2xNbNBgOAaw0z8U0P9Bhf/olsAwt0jaW7kJfn24Tj
 hkEsX0yg1OERcFurk66pkZuSlmKyRrCPMNNBgBF7LVSCqWDB7gePX0RnNoJBgJUYIVeG
 8r/g==
X-Gm-Message-State: AOJu0YyIJq0ep71VmLTi1F40vFQnme0W/rAz8TVrLSwavK40fM0awDjP
 OqSfTHRDR7up9dmA6Qj2yWcvJmVy+yiFH5TTzT66qGDsci225dI4ypsJeO1/waYbfvGEG0YDDr1
 xc/SyLDIwhtdJHQ==
X-Received: from pfbbk21.prod.google.com ([2002:aa7:8315:0:b0:847:878f:44f3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd90:b0:847:902a:57c1 with SMTP id
 d2e1a72fcca58-84826dfff92mr5387070b3a.57.1783442429560; 
 Tue, 07 Jul 2026 09:40:29 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:40:14 -0700
In-Reply-To: <20260707164020.2936476-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260703131308.2507403-1-joshwash@google.com>
 <20260707164020.2936476-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707164020.2936476-5-joshwash@google.com>
Subject: [PATCH v3 4/9] net/gve: validate buf ID before processing Rx packet
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
2.55.0.rc2.803.g1fd1e6609c-goog

