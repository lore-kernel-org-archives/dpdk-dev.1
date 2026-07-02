Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FA1C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1B340684;
	Thu,  2 Jul 2026 18:12:54 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 305BA406A2
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:12:53 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c7c61b5292so23713205ad.0
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783008772;
 x=1783613572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mFso13ND9fHjRnH27iYWlkKXExKal7zy8etzpf8wuUU=;
 b=FCDvgplkPajcUe3OkvCwy1n9yR9jCNl9a2Z7F2XEVdrJfMCIDhm/OYb5C0EaPqmL4D
 f3vs+a61YAHQjgPFSpCSZiEFg7oSR93wZfmsLRQkCTH7X8U2iPclpwhuh3dGpAnGtiYw
 J79MWa/vC31qhVz50c+wzsuMGXN2/StH50O/R4BbrUgDDLiSEC9m54r0FFgAWYvBX06C
 3Y3hzdn+/N1NNjE2N/Clr5vJi6EgTrOH8upNNXZ+7NruKlKP2GsmTRNtow3KbRCaKY2r
 VO9QXJpDoG029Qz+dZQ1e8vG/4gIzyQ16RgURJcPgmjR9dcvwBR9JHaIPsi/rE740XWQ
 haVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008772; x=1783613572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mFso13ND9fHjRnH27iYWlkKXExKal7zy8etzpf8wuUU=;
 b=Oaxpx4lh1AQEdrmI6WNMUbimnh7MCZT2umr1gPcvQA+GDg5E1Zq2jy1oMqXLi7S4m6
 D/SOT4c+uJfsnnwH4H0dWKMrUAnHRjONwpB9d/xeQTVrhogM7hIVwWoqSIu63jNchUwC
 /8JYP34jxZ7vp156DgoiMn7IpQ7Xfkh0duSFWjmNlS0hFhZcXmqzHS4iPhhqjh4UOPxO
 CEeoEgiWpAWh2S6IUDvJcYiRH9Wt+GYHXa89oWCSy3jjfHPLpw7eSKFa6pG6FK12Hx5Z
 r/3aaC11HcVHeRdWy5y5gF/ZvXi42qMslFyvxSwmB7krU/Oy8oQafx2GayvxwdM4htH7
 NG7Q==
X-Gm-Message-State: AOJu0YyrauIO0noZ2yIkyBW7z5pX32v/5ehzjlVjiK6EKPMURpsiQC6W
 J/EmurBKNzX+NYhXuAk2hBsEN/pfyIopLSE7riC/TaoMSwthK/4xhDAU6J/zFfcQ1Z9K2TYukIo
 YHeRB
X-Gm-Gg: AfdE7ckD3DMjwI9LGM65geWnInA4wfjVAQJRbw7gnC7Qf74bmyDyrldEkYwk+3Xvw71
 VQIWiKrTkaISR232PvZmgka+GzXchW5Rj5eInmk4nxp+Nu1afuezbFl5ZtdqjdsofNOj1A/qesu
 tziXScJmm7ZJvhl5q2TtkQXTyl0kxdhW7oRItT0GgOjPUPoLqxk0uWrA2eanCqnM1aHlZjFDtKY
 KlAxyibGXLHMLrHmrlGjCJfgMGULQhz+l+qAT5OmaQQBUOqFG8GDmXoAbACggC3tsDkP8ZBM8r+
 6gDIYzi9gsTdf+mUJEx56y0ZKxjsXHP37JDg2iromkzdtveOm3x0TWNoRwirjtIHJ+yqRNonwSq
 DXngi632wpPvWozz/66skCjCcTIIAjfJ17MNN8Zxj83zCn2U17R9dTx/qaiyzLYBx79F4NB8z+6
 cpjYiKzOgLPHmZ+Z065LryKccfknj9346YbVCV5lZJnV3N23c7rMA+aK8sipZQaQ==
X-Received: by 2002:a17:902:f64b:b0:2c6:f3ae:2386 with SMTP id
 d9443c01a7336-2ca91114c0dmr60577385ad.7.1783008772292; 
 Thu, 02 Jul 2026 09:12:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm9849304c88.4.2026.07.02.09.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:12:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 4/4] app/testpmd: report reason when queue setup command fails
Date: Thu,  2 Jul 2026 09:10:14 -0700
Message-ID: <20260702161244.363233-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702161244.363233-1-stephen@networkplumber.org>
References: <20260702130729.26577-1-mkashani@nvidia.com>
 <20260702161244.363233-1-stephen@networkplumber.org>
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

The interactive "port <id> rxq|txq <id> setup" command printed a
bare failure message. rte_eth_rx/tx_queue_setup() can fail with
-EBUSY without logging anything, for example when the port is
started and the PMD does not support runtime queue setup, leaving
the user with no clue:

  testpmd> port 0 rxq 0 setup
  Failed to setup RX queue

Print the error string:

  Failed to setup RX queue: Device or resource busy

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index bb62778a26..e0dcdc1193 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3092,7 +3092,8 @@ cmd_setup_rxtx_queue_parsed(
 				     &port->rxq[res->qid].conf,
 				     mp);
 		if (ret)
-			fprintf(stderr, "Failed to setup RX queue\n");
+			fprintf(stderr, "Failed to setup RX queue: %s\n",
+				rte_strerror(-ret));
 	} else {
 		socket_id = txring_numa[res->portid];
 		if (!numa_support || socket_id == NUMA_NO_CONFIG)
@@ -3109,7 +3110,8 @@ cmd_setup_rxtx_queue_parsed(
 					     socket_id,
 					     &port->txq[res->qid].conf);
 		if (ret)
-			fprintf(stderr, "Failed to setup TX queue\n");
+			fprintf(stderr, "Failed to setup TX queue: %s\n",
+				rte_strerror(-ret));
 	}
 }
 
-- 
2.53.0

