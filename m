Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02C6CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 11:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BE7740687;
	Mon, 19 Oct 2026 13:47:04 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id BDC3B4026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 19:45:56 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so172999c88.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172756; x=1792777556; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOYb1oX5kFovbsAJhxbr7KLUzrYCPCeK/eNL64v4IB4=;
 b=ksoTwWkS1TK8LIgS2a6qTsRDkmVD7sz9tUopvhQ/Dj067AnN0ZzNhX/I2h9nMvL7Ut
 rWoVOuhnBfQtyqqlysnvSAwu6rtVulT2xx0r+7RxgJa2WdlYp8i/B7STj81lES4dLRix
 xT7C2jaMwQqFKZ7CCYS0IMOXjvVRpfViy1a3AowQ/uE4YULZGp7OEmy4I02RB9ZG+HsG
 QuKfOSC2+ArcyOQ9teWsvnFv5ci/iU5U5GWQny0phPigmPoFt4qPe1BabIUg9p8PDLJw
 sVr2R+F0Rc91XGY3cPEqG1U4aBRVCGtB+T2Ai/+bR5t0Qaz5TLHhlfKzo0IYa03KBBOL
 GJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172756; x=1792777556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UOYb1oX5kFovbsAJhxbr7KLUzrYCPCeK/eNL64v4IB4=;
 b=yDAERimAT+IDAEpbPo/KWKcqo1nQNVxumTHla7kCtJBxShFjJu2LAz5nLEgTB13uXF
 orpmgrfp9UvLHe1xHMQyEnd/k6BPzy0YpkeJY8laIckJZp2NHdRD3LHVoqSuv+mTr9Aq
 aZ758wCs+AuibryFYCOuA9wNzu7hkcbg2UjY03fD7AN4dT2y2uxi0492Sb/46J37xuQa
 AHlK25InZRNMEU3EzSLeOKv1WykjUU4QB6qRCEv1TcxOgcB7VzKaNqQVXM+zXV+SG39T
 Dnzb5EnpCSztfDKVRxXQG5zf5xVo9ewMoMM3LkY8ZD2Ssodvm09F+apQdZl3PJPCz7Ol
 Sz5A==
X-Gm-Message-State: AFq9FYLnywLJ03pV92Pv7irO3vFvCnEa7bkfgdIcAqckpZWPb3hz4/IT
 p2eknvWc3Ct7dw29L4kCC2jDmxM6JyP8OwcLd+t5T9cOBHUmhyE9eyCUostSrQ==
X-Gm-Gg: AYBFou2YF3CWDUmD1mhlcMnjSiXWzvT0qEXwgmp7+72oWpsidlnZdsgXEWsCTd9Cu+0
 zNJJ3A6CTOHvEhk5SpYQrROT7CBKuZXDK6Ki8EqquPsYT5dZ5H076Pl4wNMEgj9TwFxrilChyaV
 nxIQmYw9UetH/aVkBQUia4KtDaenQteJLo1qpRgUOoVqH9uk/Y/zL+T0QsJcWNuFPUUc75Yg1wC
 Mv5bmK9anuEtHNpwtvEDXl7I9DldaAwAb82YewDIPmE6FYsDrMlhgRWMAkigPTFUfxJZASWPIU3
 qEQ3hFtWCe93cutQ2d86bDFyuzn+C0aefRv6TwWSJjRRfccwb9pCubMXtu9n+f9Jyr0kvwLyB9S
 b+NUJa/JGn8DpNq05rZ0/vcmUc6yon9EyyDcXUF1zm76A1MO9P12pUjDFkx9bfkxbfoP/rNWXin
 SnVUFTJ11ibBVPAtvGQJtJoBqrFoL1myVuFrrITyjn2AuJfnAew+xbN5vxIt/X39TTO14FG/kFG
 O9NcEsxQmja8xth8iRBaVBd5LT1BkMy+eR9U90L7cwnbXQiqvtbGrW6bA==
X-Received: by 2002:a05:7023:a87:b0:166:847c:f162 with SMTP id
 a92af1059eb24-18514b00c6cmr730568c88.45.1792172755628; 
 Fri, 16 Oct 2026 10:45:55 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314ef8ed8sm7099936c88.3.2026.10.16.10.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:45:55 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: Joshua Washington <joshwash@google.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: [PATCH v4 01/10] net/gve: fix DQO descriptor cleaning loop bound
Date: Fri, 16 Oct 2026 17:45:36 +0000
Message-ID: <1938d978f6fbc94bd1593cf59b20196aab5b1a71.1792170902.git.tathagat.dpdk@gmail.com>
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

gve_tx_clean_descs_dqo() loops on "while (--nb_descs)", which
processes one completion fewer than requested, and none when asked
for one.

Use a post-decrement so exactly nb_descs completions are processed.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 901c6ca749..7e12da68e6 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -119,7 +119,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 static inline void
 gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
-	while (--nb_descs)
+	while (nb_descs--)
 		gve_tx_clean_dqo(txq);
 }
 
-- 
2.43.0

