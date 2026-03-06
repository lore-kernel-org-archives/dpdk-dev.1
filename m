Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F9FF0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A11C410D4;
	Fri,  6 Mar 2026 14:30:48 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id B3F5240E4C
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:47 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so3116661f8f.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803847; x=1773408647; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vt8PICzTXkD6tqnZ9Uj/2dpldyb3jBsCGizuoHJd/A=;
 b=kWwFGBl/AtHFwYpwu8NvOymSlBaoYJC+ehC94WLvDyJFTt34gUPgbwUZTFhZRx6sRo
 GpGI52K2+QFJ/9IvOMaluhka4XGHtNxyu0A1iLtPe3hsM2Kjv2TnL3PXWyaJ7g0n9Ei7
 gOzONb8Qcypql+yhM0Cv7QDwQUB+7YDDcEJWzPMB8iL5LUcnUziSOLD8xoTf1FoZ6ZXT
 l3gQ0Kgr/dpVcbDKH9VIHPnpscNHk0hsRuXdZxD/yfdA8xb/FScED+0p+uz6gggKtQYT
 3/qgwRGNCw/J6VBCSZdlXrQwbVComkqILgGzMRKvE2eB9si9qBM/wIdYZ/LcutKcZbi4
 9pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803847; x=1773408647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vt8PICzTXkD6tqnZ9Uj/2dpldyb3jBsCGizuoHJd/A=;
 b=eaSv3J0ADQKJikgZzlyhUgit7OfDASEGY2fgky6wh7nRGoWI1K1Xu3awCwWAQljPtC
 kBYi4+pFx2oLoabMDLDlQWNw3eSEpExouHF3mOU5l3dApnb7qGa0AeQxLLIUzGQm1yQB
 3ZHaFDPjdbx/GpOoa33K7StwNZ+939jqX7qOK3UYhaQPwGIhUFeZiYSL4ITCRK4rV6hO
 hCI60mmFGGSjtotbc98ks/ICWszH6XfxBf4/Hud0IoLE51y6TCOjwRLMaBMMxrGHZ12D
 4oAqFlQWn5kMRvDfYukHf+vRpQNUzl4WgwxfrNoPY28gjMqcfNwSca1G/eTaO0uIM+6v
 508g==
X-Gm-Message-State: AOJu0YygFjomANaSfropfJsilM8mcPgAnClWr8DNcF0QTalqRg0/V7CU
 Rw8McmffERKYuYxBE/seH6QTeU/KeyT3NlaDCEq3QmiMuswa3BKR+BBa6yfsXL6V
X-Gm-Gg: ATEYQzyP6VdVN2n5tK5KcyZG1UspJCapXZIgHaJm0QT5d9VLA5mu/mLeQXkCmTKng4e
 4iwDYHTTzo/Cwd5hueRelmhBb5ZEntp3PTkjsr27GNY7o5DVGsoNISEUpG/HfrV+QmNotVSYnkz
 8WJ1A24qigG3ZyhLvEjN+Md3rfActYs1Y+ZzXaN7QPoUdiPZEAlQUFht3RUXuLJL4sSc4qqazkd
 aSbHA2dRI6DeWofRlEVW3zpLlsTJbe5WrfaVvQtS7WotanvU139wU7yxvGQB3sfvW/pDVqQyEuL
 GtHypoBr5KFz0Ghe/qw4vyMwHAxgyeK5H24fs6yA3TkPkgZUOjg7BA0+CDgBZS7yyXuxexLdkCC
 UHEQdq0McHmsXJ1WrrwuLMbRO3OjqlRPa3HOPbL2xtZZRWTMyICPgXT9Wcjatxlc9ZwExXrobtF
 E+M0EluvquK7EhVt0aFzXKbTiN2iM=
X-Received: by 2002:a05:600c:8115:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-485268bd69fmr37546775e9.0.1772803847064; 
 Fri, 06 Mar 2026 05:30:47 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686fa9sm44025805e9.8.2026.03.06.05.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:46 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 02/17] net/dpaa2: fix Rx error queue memory leaks
Date: Fri,  6 Mar 2026 14:30:20 +0100
Message-ID: <20260306133035.179709-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The rx_err_vq is allocated separately with rte_zmalloc() in
dpaa2_alloc_rx_tx_queues(), but is never properly freed in two paths:

1. On port close: dpaa2_free_rx_tx_queues() only frees the q_storage
contents via dpaa2_queue_storage_free() — the dpaa2_queue struct itself
is never freed, leaking memory on every port close.

2. On allocation error: the fail: path frees the error queue's
   q_storage but never frees the rx_err_vq struct itself, which was
   separately allocated with rte_zmalloc(). This has been missing
   since the error queue was first introduced.

Add the missing rte_free() calls and NULL assignments in both paths.

Also replace the DPAAX_RX_ERROR_QUEUE_FLAG check with a direct
priv->rx_err_vq NULL check, which is safe because rx_err_vq is
zero-initialized and only set when the flag is active. This avoids a
NULL dereference if rx_err_vq allocation itself fails and also
simplifies the cleanup in dpaa2_free_rx_tx_queues() for consistency.

As a defensive measure, also add a NULL guard to the
dpaa2_queue_storage_free() macro to prevent NULL pointer dereference
from callers in error paths.

Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 16 +++++++++-------
 drivers/net/dpaa2/dpaa2_ethdev.c        |  8 ++++++--
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 10bc191645..e625a5c035 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -223,13 +223,15 @@ struct swp_active_dqs {
 
 #define dpaa2_queue_storage_free(q, num) \
 ({ \
-	int i; \
-	\
-	for (i = 0; i < (num); i++) { \
-		if ((q)->q_storage[i]) { \
-			dpaa2_free_dq_storage((q)->q_storage[i]); \
-			rte_free((q)->q_storage[i]); \
-			(q)->q_storage[i] = NULL; \
+	if (q) { \
+		int i; \
+		\
+		for (i = 0; i < (num); i++) { \
+			if ((q)->q_storage[i]) { \
+				dpaa2_free_dq_storage((q)->q_storage[i]); \
+				rte_free((q)->q_storage[i]); \
+				(q)->q_storage[i] = NULL; \
+			} \
 		} \
 	} \
 })
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cef819650b..eb8333458e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -620,9 +620,11 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		priv->rx_vq[i--] = NULL;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->rx_err_vq) {
 		dpaa2_q = priv->rx_err_vq;
 		dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+		rte_free(dpaa2_q);
+		priv->rx_err_vq = NULL;
 	}
 
 	rte_free(mc_q);
@@ -688,9 +690,11 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				priv->tx_conf_vq[i] = NULL;
 			}
 		}
-		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+		if (priv->rx_err_vq) {
 			dpaa2_q = priv->rx_err_vq;
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+			rte_free(dpaa2_q);
+			priv->rx_err_vq = NULL;
 		}
 
 		/*free memory for all queues (RX+TX) */
-- 
2.43.0

