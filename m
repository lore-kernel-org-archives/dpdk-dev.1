Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AD0CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BA6E402C4;
	Mon, 12 Oct 2026 22:38:39 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 522EF40041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:36:37 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so2214953c88.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791790596; x=1792395396; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1gEXOqpeY3ZRgkGBUwk7Y55wjnSJVmU1Q/28USp1cY=;
 b=Kowyqdhk8OKflaoEXt0cPDMxbGjNniubThOVejwLgtksiCyBP55ong4NVUIPCtSFSa
 683/r9gae2GyWVcc2ZEkoQcRrRHUeLOayus9D3ChgTzrbYm27VP9nWslSVm9yP6ZtaCp
 AZPM+XeaF1B+GWaJIDPcsO92Ccqfh4ZDJpN/ja+pkLDMzZJAJSw5TCZ9qfuHylSKGxz/
 OkSj5jPkUsEbgHLmsfpyM2CiBTUhF8Nq2DEJfyd0fI1HbWf7/qqT0p1lZeEohrUmhaIs
 ukhMcIyN3JHlJFJvKSN6/EXocuhl5zkBvdMb8FmqXPLK2qZCRhjKM7Bneq6C7oMk0XbE
 ITmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790596; x=1792395396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L1gEXOqpeY3ZRgkGBUwk7Y55wjnSJVmU1Q/28USp1cY=;
 b=BR4lB2ZOf7moXHLYe3Ah/NoZ3KStJFIbNaz9y4v7n+FXuXqaPLeKMIuRJEC7mxlqqI
 NY/kv3dbtmkJT3BDOw5Lp//2Ic/n7SagNF97hgLln+7WEGYO3cGTgNsRK0PqZaC/Hc+3
 e35GlcOqPM27YIFJujF9RZwks28BQItn/UoyPoY0M6NsG7YkH7sJqe/elMCtrX65FoMV
 H7iRx0r3rKw52HCVmyAoRRBa/gTAbCKoxyE3NnKxIYIKiir+hbWjzYnqhBvxXuIFt6a9
 WwI0b0sLtq7kmc1lJxhvkJXDmK0vgtN7uvAVWK/7pfoIlFd5ayNcvaiN7IYyxRgWWEup
 v5Yg==
X-Gm-Message-State: AFq9FYIgdcVVgJoPIG27ci2mSfvAW3XZ1Bzcm3dYVD9mmFX4xCW9uIjR
 IgTbGKEZ7YGB07786nS8eHDyNsJ0R12GHM8stwcR3Ox9VvQYPHO5Tt7098+lcw==
X-Gm-Gg: AYBFou39wRtaiV5n7IKbynT6MKdAtEPx7gA0oWlCAgvhgPRpM7xkq0PjS7+cdj+6x1o
 l8rJBPxZdxEC9Eu3vLW0MQKw/R53tCE9HqF4XEPDDNF+iZoQwOU2xXvOAE3k5PxlqIEsIkkttnm
 Yr9pDLD/t2dGWFGGtynu/cBi0PbGM/XNF5HSxri2UUx/Op+kPNvx1zVS2s51dT/QotCG1ou67UR
 oTDPj8you0wx7LBy5ohZ1IInWGfXHjNH5oebYTNjsdJucnBpeVXx9jVzzO1XMxs53/UG9JDhdn/
 6BxQvzDn2JN4l5cVGbt5MV+g3HkXx67UeoDDE1Xj/hVioIXU4z7p8xUbqylc4N8+iL4L0qycgYJ
 /QOsabrGW5zwlsDNzyBa4GuU+1cnrZSo+iAfDYdAotG6WxVXe2/eGzU4dkDFGDtSY23vYbK8k+v
 IGq2jRYsWTpCrQEuKMkwaAH0cMBSTjl7ij+tYYKY6zyZoyquQpnTSCrBd+pzXdek8wgBsmpUCX
X-Received: by 2002:a05:7022:3a88:b0:143:3c9f:109e with SMTP id
 a92af1059eb24-16a61d5bd6amr16471474c88.41.1791790595988; 
 Mon, 12 Oct 2026 00:36:35 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becb11sm25558463c88.4.2026.10.12.00.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:36:35 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>, stable@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: [PATCH 1/2] net/mana: fix transmit burst error handling
Date: Mon, 12 Oct 2026 07:36:25 +0000
Message-ID: <20261012073626.642397-2-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

When a packet exceeds max_send_sge or when populating SGL segments fails,
mana_tx_burst() skipped the failed packet using continue.

Under the DPDK rte_eth_tx_burst() API contract, callers assume that the
returned count represents a contiguous prefix of transmitted packets
(tx_pkts[0 .. nb_tx - 1]). Skipping a packet in the middle of a burst
causes subsequent packets to be transmitted while the caller treats them
as unsent and frees them. When hardware later generates CQEs for those
transmitted packets, they are freed a second time, corrupting mbuf pools
and free caches.

Fix this by terminating the burst loop with break upon packet errors so
that pkt_sent accurately reflects the contiguous prefix sent.

Fixes: 7f322844f427 ("net/mana: send packets")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/mana/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 10f2212b5d..d35030cbe5 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -281,7 +281,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (m_pkt->nb_segs > priv->max_send_sge) {
 			DP_LOG(ERR, "send packet segments %d exceeding max",
 			       m_pkt->nb_segs);
-			continue;
+			break;
 		}
 
 		/* Fill in the oob */
@@ -432,7 +432,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Skip this packet if we can't populate all segments */
 		if (seg_idx != m_pkt->nb_segs)
-			continue;
+			break;
 
 		/* If we can at least queue post two WQEs and there are at
 		 * least two packets to send, use TX CQE suppression for the
-- 
2.43.0

