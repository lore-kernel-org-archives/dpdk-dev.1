Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B9C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:40:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6536E427B5;
	Thu, 10 Sep 2026 15:40:02 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id C889140274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:40:00 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so7042818a91.2
 for <dev@dpdk.org>; Thu, 10 Sep 2026 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789047600; x=1789652400; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=spmEKKJy9ZyBbahSVY1Ga6Z8O2mOJoF49UOglvocy4A=;
 b=OVRyY7WWQEkP8rumy7+fUt0MRNc5FaBk4DgptSWMU/hnXs/x5fdsIDYWIlMrx3JZw1
 cOqX5IdCnac23HY4SsopR9YQjgJ2dlEK19v80dQldvHSoZTrv80mXUXa2Jv6LxrJ0G+E
 Z7ozzlPBsabgKOs4leWTVhlNRNndWetbh34cpOm0kJo/0R1dmdAKH/BYWDPu9KhE25sb
 JJ0D0kqMilmlzLlhaxbe24aShw5aP3+XykbrGndqPSSbNUST1bK89z77H67QKH+LAZyT
 z7HYL6j+XLLjE5ptv27rHUUPR84fzFqhSGTSRBf0556IOtS6Wf6OZDzoGdGPsz1Pj0wv
 9KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789047600; x=1789652400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=spmEKKJy9ZyBbahSVY1Ga6Z8O2mOJoF49UOglvocy4A=;
 b=re89d9+PoRl5Vbj5E4brPzaLjmSAZy7jMH+ZWqP6+RzLYuMWG5IoUXEUgUvrhQTCOU
 qeSzxRsX+gNqLnAO95GA6sccPDI6nVpC0d68KQ2UAL07R/WbEUEnIZ5Vvc1fZvNO+HKv
 AYuYwS6CYfSIR4vXi8j8AmoOROZzwyUziuyw9seus4xNxj+Y6ND6he5/KW61b/o3104U
 AoSvUzWVvFdI+MAEp4jS97j3+72HzoEAiVK1XbOZw6b0SHFRe/XQlPzsFNrItq0M368a
 SIbiImPUZ1CZ36Is1186GMklFJfIjeRzHGaakeala6wZwm/MrY9/E+JdwT7pmJNzHIJJ
 MmDA==
X-Gm-Message-State: AFuF++mlfQtjsyKhsJEfKkf3unT6d5n3E71Ppa/uAUbp1O4Q/xaiFg3N
 OLywLz24XR6bTMip16d5lxeGeExZs7kbhqNIlKG8mGkDZ8ik8HzzLnJ9
X-Gm-Gg: AYBFou31dXVwWCRFEXwHT/HVjfpxoT/kFv5gtmhCLG+bnkKYc6fmUV3aW5tLxvwLWC8
 8Y1bZAZCIOgavLvZ7MbgUHrTdPJCrPKrGy0JOasGX7OV6Guyc6coFPJPeeBIpT7gACyWAorUK0Q
 e9D2Q+7xcUm73cfd821vc7D1Q0TSN4oj9ZR6Wev3ATodB7qeAIGk1PW0CCwf1hTZ81hZJ1isfg/
 dOGwrq9MZNNed8g196T9Dco2bo5SGEqWi6zpEW3aq3xKxh0OQD1JBCKtzH0y2JoV48Xosu2l8aH
 N/kcLrb0o3UFECf3PpbLV+KPCYAiLFQkLce0IYar9aBOkQxtfK5cwEtsm15RZhrVRyPdBqjs91f
 DAsavx+F153zWIY7CQHgNFg1FSHYIIgIAP50xxPw1v2gT6O+LO4Ewx+Dvo0zB7NROaIV9pMT7JM
 t1i8RYAXHjBD7VjyehKkiLi/qI+/q7/6Ksauu29M4YINKpitHl/PoVoL5D8FYhTOLeNFP/M5qoC
 pEa
X-Received: by 2002:a17:90a:15cf:b0:39b:57c6:e280 with SMTP id
 98e67ed59e1d1-39b57c6e283mr26270104a91.7.1789047599665; 
 Thu, 10 Sep 2026 06:39:59 -0700 (PDT)
Received: from fedora (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e89b8edsm5408357a91.13.2026.09.10.06.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:39:59 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH] net/txgbe: fix use-after-free in flow destroy
Date: Thu, 10 Sep 2026 21:39:41 +0800
Message-ID: <20260910133941.77565-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

TAILQ_FOREACH advances via the current node's next pointer. Removing
and freeing that node inside the loop reads freed memory on the next
iteration.

Find the matching entry first, then remove it after the loop.

Fixes: e342da2d438f ("net/txgbe: support destroying consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 1bb0d3978c..eaeb973c91 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3667,11 +3667,13 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	TAILQ_FOREACH(txgbe_flow_mem_ptr, &txgbe_flow_list, entries) {
-		if (txgbe_flow_mem_ptr->flow == pmd_flow) {
-			TAILQ_REMOVE(&txgbe_flow_list,
-				txgbe_flow_mem_ptr, entries);
-			rte_free(txgbe_flow_mem_ptr);
-		}
+		if (txgbe_flow_mem_ptr->flow == pmd_flow)
+			break;
+	}
+	if (txgbe_flow_mem_ptr != NULL) {
+		TAILQ_REMOVE(&txgbe_flow_list,
+			txgbe_flow_mem_ptr, entries);
+		rte_free(txgbe_flow_mem_ptr);
 	}
 	rte_free(flow);
 
-- 
2.55.0

