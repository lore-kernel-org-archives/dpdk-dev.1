Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D943CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 472944042C;
	Mon, 12 Oct 2026 22:38:42 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 23ED44026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:50:32 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-33fb4680717so2808818eec.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802231; x=1792407031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eup7dOVojxxE9BHHwol6STNKtPN/NNXUeGt24sR3RdI=;
 b=NyefZGSRBA0Otyd65gzFyvnze7pjBk5QB3jgYK3pYaBocSg2JkpSpLN6/hVmZGu0kk
 s7YZWKG3PZM3B5nje+00Awa7U+V0dx093Puj3sas5Nj/6lwLQdq0pGxwgoWsqoVCffRy
 6Gd8ldtoZH9xvZ2ZV4KIcIDZiXu0e5NTZIzViafKw0ZtR3Y46OQRvIHGe+klWtWP91SS
 75z/Xe3i8OvmZbnxNYa8qustZKOL3kmPWMy8hpYQGy8U6MvE8XupllxhJSXqD9ugSTfO
 dxnn25KtfDXl05aQfKcRg3U2lvUJKYnzSMtqYfAe6kH6olXVDR+4XLtnVMHvAbUuvf1M
 35FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802231; x=1792407031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eup7dOVojxxE9BHHwol6STNKtPN/NNXUeGt24sR3RdI=;
 b=Oe0EEtWghc4+Hqdby6YRIFMW55PrwCM35GxnQ4UbO4pDb2bq4QNo1oRmZBPqYkfELN
 IhlAmAeUbKYPqwXMxwbkbcCYl5ZeU5c/GpGh3sf81aVvOv7dxkl6mkt+nfptdJPjv/FH
 aclmg17qTld/o4VHu4QgF9D5AgSTMTAmxjoVcRymRrc+ciiisXcDCGZUypB5rnpoQVQ4
 CLIW8cSh9e8oD4Bumc8AQ2VXBjpdF0+p5pU+y/bpQKxIEXXTX4bIFBNdqEkfu3PDSj02
 8UT2TtnJU33rossHVer2ZP/r6pTnu6UiSX1UhK0RvzeaSPu4Nhg55r3YG546Y6IYUjYi
 m59g==
X-Gm-Message-State: AFq9FYIwZuRX/R0hvMnO+mPWb4pWjqcSyQ9NPM4/LmujXpCAK6yfPZNq
 ArFGNpUtmS83u1Q0Tgapy2vlMJvCm30UcF2VdkpFvUlfetVxRz2ki1F1nqhy/w==
X-Gm-Gg: AYBFou1Xk4CZeYUVj0Zmq9z795kF8tzBXsmk8dl55EqiFpxCWHUCf5XQ2tvRa/Hxfxm
 xPnCS3gOX5SUuOAnZcIJaYr8ZQ9zPmm5bMNfFMq1IcSL6ZWYq6ZlUywxCd6lJnSHdbcbaaQH6et
 qK1LRUfHUu47LqOu3u806yWzxZSXmvwGwK9xaX7sAOlcFsv0RJM344BoIvjw1Vm6a/N6++DMDnl
 vrPtjO9T3JFHarTAwZqqoM5R373k4hr+iMH9F94hbuZ32iTK1ZbGE8D5c27JUN6aA9fANY0OjB3
 1GGy4vbQ3/VI3Sbxxs48iksOOP9/j2GgIrX+xuX3ZvGFx3jGwc2zES6caTSKrCsBP6cIN+5Ccet
 kgEEJI1sVTpqR8h/zXUg4lB/xkpA+Bu8DYOQbcJVi0MQGHED+hZAPGY8NPlusofW2UkAC7odZJs
 e1dJlikMMr7VCI9fWBP3/OT6J4/76rP5wh6kxd6LPfG8fMoQzRzulv+Z1PyEIK8DLFcQshFabV
X-Received: by 2002:a05:693c:69c3:b0:358:3426:d606 with SMTP id
 5a478bee46e88-3583426df51mr10116172eec.32.1791802230908; 
 Mon, 12 Oct 2026 03:50:30 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm36875760eec.17.2026.10.12.03.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:50:30 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stable@dpdk.org
Subject: [PATCH 1/4] net/gve: fix DQO descriptor cleaning loop bound
Date: Mon, 12 Oct 2026 10:50:20 +0000
Message-ID: <20261012105023.669486-2-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
References: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
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

In gve_tx_clean_descs_dqo(), the loop condition "while (--nb_descs)"
causes an off-by-one error:
- When nb_descs == 1, --nb_descs decrements to 0 on the first check,
  executing 0 iterations instead of 1.
- When nb_descs == 0, --nb_descs underflows uint16_t to 65535,
  executing 65535 iterations.

Change the condition to "while (nb_descs--)" so that exactly nb_descs
iterations are executed for any input value.

Additionally, in gve_tx_clean_dqo(), handle unrecognized completion
types by breaking from the switch rather than returning immediately,
allowing complq_tail to advance past unknown descriptors rather than
stalling the completion ring at the same entry.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Acked-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 drivers/net/gve/gve_tx_dqo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 5c03d3d1a2..c864d722d9 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -108,8 +108,8 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
 		break;
 	default:
-		PMD_DRV_DP_LOG(ERR, "unknown completion type.");
-		return;
+		PMD_DRV_DP_LOG(ERR, "unknown completion type %u", compl_desc->type);
+		break;
 	}
 
 	next++;
@@ -122,7 +122,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 static inline void
 gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
-	while (--nb_descs)
+	while (nb_descs--)
 		gve_tx_clean_dqo(txq);
 }
 
-- 
2.43.0

