Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D97606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=AmTYxW6G
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D05B740DD8;
	Wed, 11 Nov 2026 01:01:09 +0100 (CET)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F6DB402A2
 for <dev@dpdk.org>; Wed, 11 Nov 2026 01:01:08 +0100 (CET)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3b10ca4e3f9so1507405a91.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794355266; x=1794960066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6mZogJRmJCqL/zJAWLCFLSFO1Nugy5PcMdh7HpgPBL4=;
 b=YZsnSG6x84XKk4+b9pcNMg5sGGeal/WI5Hk5dyewvdNB+Ks5RVAAAY6u68IPDpsMuj
 H0qwqVuQA2IFCsIMWgFgutm6+ogB07bStWEKwSYpR2/KkOJRL6lah+fE3osBzd1htL4p
 HxYDfEh788oKR1FxRmyW9CERpSew9ONq+zcBDbIl73uCUfg4id5+JOxZI2wugVViCV7a
 OnIblMYDOwgaRJkXLrqCPUUNMhgPcOd0sNwuzH1SZYe+w0PKWuH1GRUBmRE3gyWB8ozR
 MUlr7tHnd+1U9FiI+WZZTkjNUBAr7kOXzZrX/C+q+rjDwEjxgUk0+9lrajUyXk/tt9xn
 9N+g==
X-Gm-Message-State: APuU4Z/6MkM3++Qr74Q3DzMNqmxC4A1MpLmde/7n+jH6wdYxZAAZhBn5
 Ga1ixqKpm3vU/oj9ZUF6kbz+2ARKS4S67RwGhmIdVinmBDT7j4h69+pZxPM88OdzrfeAqttHkrI
 1t/j/8DtjTDPcslKqN2aibf1fb6qDqKdbyGwCAGAWFB3ku0DxWVUuJYhJBCOhcVcWHp5LYW0+Vk
 BnoJ0gAFWnrTqS2ZGCSfPZOc4wMUDCV+x4uGWPWdLcRv9KNek6R7ylyglHZNNyzWLYZ/yiCh7kl
 /ceSAYgus0R
X-Gm-Gg: AYBFou3wLtUoQ2gsFr95j2WjAAlVCj8wzx3QI/1b1kOcIyg1ZFgMyMF00KfwE5VAFXZ
 mb+YnUXQ5NeTAVYxpafASMFw2sAdz7AfO++TiWtz+f6lna1CRqmLPtwZ7YIBzHM5x69i+dLZAyN
 ObZMOnEW2LdnnF4Sh/UdijV89OW48gGUVhIfXMDfuxM9F4SkAx7Y92tMiEUh9mIueXCZFZ8uw8f
 ypThnpBLM3BWrkAMj8eTtx2Cy9D1MNzh4JG9/UXcWTpIO/ne/7/1QsETzjiZfIrDQHejLFtgBmI
 9L2cyyB89xdxH2aUzYZxdbaKZ9EP+Dr6lWj7DnS/8uU+U6niuvbyWaS/ZwJH/0nuPIea4L7JZBk
 d9UJy4XomWzOYad2V5XuLvsPhxMxxDI3t21YiD/W8RCWNnykwhHMgDBQ1D2J/+V2wkRhw5WE6nO
 pQVUtbcbcjFHZag6znGgsFjnZ15X9+g/8mdQX70HHGBGLiqmdUNg==
X-Received: by 2002:a17:90b:2d03:b0:3ad:a17d:f46c with SMTP id
 98e67ed59e1d1-3b182fcd3c4mr601935a91.62.1794355266226; 
 Tue, 10 Nov 2026 16:01:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b181fa190fsm307688a91.2.2026.11.10.16.01.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Nov 2026 16:01:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so4193326c88.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794355264; x=1794960064; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6mZogJRmJCqL/zJAWLCFLSFO1Nugy5PcMdh7HpgPBL4=;
 b=AmTYxW6GgCnGbj3h3IUfnZHqINMWHEc8S2BbDLLrp46WzsQDhCpBjtFH2qdc06zAe9
 ZaSQtlWYpMoYWuL6nFAfyW27FKxwotT4mjRkbGSQedKTR0gnWsqkJuog515SupOwjSK5
 GW77h9vFnn+uF/wCzw4sNG6TShpUAf8vHscdM=
X-Received: by 2002:a05:701b:2504:b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1b3c0341facmr654551c88.28.1794355264271; 
 Tue, 10 Nov 2026 16:01:04 -0800 (PST)
X-Received: by 2002:a05:701b:2504:b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1b3c0341facmr654515c88.28.1794355263394; 
 Tue, 10 Nov 2026 16:01:03 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b4b90csm9331674c88.14.2026.11.10.16.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 16:01:02 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix Tx checksum offload with short BD
Date: Tue, 10 Nov 2026 17:04:17 -0700
Message-ID: <20261111000417.1900551-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Commit 2feea0f3b8b0 ("net/bnxt: modify check for short Tx BD") removed
the TCP, UDP and IP checksum flags from bnxt_xmit_need_long_bd().
The checksum flags are written to the second descriptor
(txbd1->lflags), which only exists for a long BD.
With only checksum offload requested, the packet now uses a short BD
that carries no checksum flags, so the hardware does not compute the
checksums and packets with bad checksums are forwarded unchanged.

Request a long BD again when TCP, UDP or IP checksum offload is set.

Fixes: 2feea0f3b8b0 ("net/bnxt: modify check for short Tx BD")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 4c01e8a275a..e765cc3e6f3 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -114,7 +114,8 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq, unsigned int socket_id)
 static bool
 bnxt_xmit_need_long_bd(struct rte_mbuf *tx_pkt, struct bnxt_tx_queue *txq)
 {
-	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
+	if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_TCP_CKSUM |
+				RTE_MBUF_F_TX_UDP_CKSUM | RTE_MBUF_F_TX_IP_CKSUM |
 				RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_OUTER_IP_CKSUM |
 				RTE_MBUF_F_TX_TUNNEL_GRE | RTE_MBUF_F_TX_TUNNEL_VXLAN |
 				RTE_MBUF_F_TX_TUNNEL_GENEVE | RTE_MBUF_F_TX_IEEE1588_TMST |
-- 
2.47.3

