Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB0CCF2D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 086BB40A70;
	Mon, 19 Oct 2026 13:47:07 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id D0EC940291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:46:09 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-144f79153f5so1071219c88.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172769; x=1792777569; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/2AO/6S0iRF6Q+aQAtlg8DD5SmzyokGXscCcnLp9B7k=;
 b=sCsd+YW+/TwCfdDpSNduIAUEAS/iMzY9nUwcgLy2oatQYvTFRf7wpdyoom3PQ2wryo
 cjvsQLO/jXv3doK68sLEd0pQdA1u2j30w+MhkYmhRSBeDhe+U6kUFe8ulfGjI7MuIrYD
 RpGYtGVY1EFR/uX2mpLgdFGjs2NEnmsR1nWuIdXESsU6nM16K4dGmc76PeBHlMF9zX3z
 r17YK59ajeQH4+8K/cpEwdBzvUpvBMauOLrr4meyB235yCVeRhWgE8RZfUxL2d196/mh
 krd3DacbcZ3DSCkoPKCn8+RtJEPYrOVZdjr0T8Devu9oYRWYuVN6h2SjIrd4epat8yOT
 LACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172769; x=1792777569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/2AO/6S0iRF6Q+aQAtlg8DD5SmzyokGXscCcnLp9B7k=;
 b=s0Nh1hdQGVLKNVaA+QWfN53gNt4FEv6ihNsWDjsrK0kxJBOhK2WrvyVHcXEzOPkG6K
 IGnHE17eODJ5Chmc6VW5HzwPcYPsuYKgHJcKM9p6jPIcUkn7xwmzoHLAKp9w75HKt/3E
 vfdAi/eBGVo5nindIVl0roxv+5WO4JOISsPZ0EPE/9atyzi7Bkn2dnMvmJnGTPixcNKf
 V+MZAnnXSrOMTsJMb6wIgIeIvtCe0slNCgCy90l/CuXb+YSDZ9Vt4Y9XhS9z+qiuZR7C
 isAoMQPPPw4Wb1FLF1FzA1c4lIwTIhr3iY516dVmcQnkE0HHCRauIv1HoVB8M1gCG1LW
 eyEA==
X-Gm-Message-State: AFq9FYJwaaexziTWedfTSCWWYeQGXHUnNhQKuzpS4cWWLi1J7idf+EYw
 fCgKMkK3T59fW0qAFPpl/bRFkUTvCn0A0hwxtGZljmQ29w6YSPf6fZ8fYbtyEA==
X-Gm-Gg: AYBFou3j3bXQ6M7AzXbVQRoKL94J8RSjkbo84WSFIpfynY4ZHQLnxhbMeq4pGqKQtEE
 86SO5COU1CvzYD9b74oZpbR+lLlLQ6cI92Sa9G0oPIxYIypTgimFjc2gyg6VQu3Bv53aaTzKd0/
 fLBDdYMY+1obvYWXwFqnRK8TiDusTRxcaypsRjlB8LHPr2qkv2Olp6SsAjQIr33oGVMsIYt8xJd
 OzFCRDg5J/Mx/jvimDM8zmc1Qhk1XotqkHI6lvrn83x3kGDih/tjL7JR86yi9Pt6r2wgh4Rcaft
 y8QOWktx7EKAwCgG4PsFv8YyK6SZ5OqmOX9w5n4ktTAdmZtAks9X5P7hmTLVa+XMDHEv21lQBBV
 toP/KbFEaDheX+eJqUFU/XNn325H9ic0+QFmjeFFJAH8+BCBPwEU/N1kPVMxIB67OZIcM9l/bDD
 OqQgOZyhTLEmxolBo+ZWLsrsETxpT+RtXcidXKYfmySvRbI/IxMgzJW+i6MT4dYueP38An2auKs
 DdQ0tR6FJc=
X-Received: by 2002:a05:7022:158a:b0:15b:1439:1fcb with SMTP id
 a92af1059eb24-185106a0502mr995513c88.10.1792172768766; 
 Fri, 16 Oct 2026 10:46:08 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:46:08 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH v4 05/10] net/gve: add cacheline overlap margin to DQO Tx ring
Date: Fri, 16 Oct 2026 17:45:40 +0000
Message-ID: <eb6971273d161a08e9ae6774cb396d2048ce0fbf.1792170902.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792170902.git.tathagat.dpdk@gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:47:02 +0200
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

The GVNIC DQO hardware DMA engine prefetches descriptors in cacheline
units (64 bytes = 4 descriptors of 16 bytes each). When producer tail
and consumer head indices share a cacheline, CPU and device DMA memory
collisions can occur.

Align with the Linux driver (gve_has_tx_slots_available()) by requiring
GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) headroom when
checking descriptor availability before enqueueing packets.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 55187fec71..637632ce4d 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -256,6 +256,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct gve_tx_pkt *pkts;
 	struct rte_mbuf *tx_pkt;
 	uint16_t compl_tag;
+	uint16_t req_descs;
 	const char *reason;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
@@ -288,14 +289,17 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
-		/* Clean if there aren't enough descriptors to send the packet. */
-		if (unlikely(!gve_can_tx(txq, nb_descs, 1))) {
+		/* Clean if there aren't enough descriptors to send the packet
+		 * while maintaining the cacheline overlap margin.
+		 */
+		if (unlikely(!gve_can_tx(txq, req_descs, 1))) {
 			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
-						  nb_descs);
+						  (int)req_descs);
 
 			gve_tx_clean_descs_dqo(txq, nb_to_clean);
-			if (!gve_can_tx(txq, nb_descs, 1))
+			if (!gve_can_tx(txq, req_descs, 1))
 				break;
 		}
 
-- 
2.43.0

