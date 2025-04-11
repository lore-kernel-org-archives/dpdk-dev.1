Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D8C369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45FA940E27;
	Sat, 12 Apr 2025 01:49:51 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id D529440DDB
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:45 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso27958625ad.2
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415385;
 x=1745020185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLZ/A3RY0kK1fNmddGSUh8Vyrw1cp/0HYfVwBIrqHkI=;
 b=BUuAaYSVUjBn4kpdJ6MIuG1cfUeRfWcDpJ4QQkr5e+ea5uNXe+pz/N66SC3BLIya0o
 iLuiXhkSJfvXbHOL9K4pKfWTJudDsuwOaj2k9zbxfWwkTOTFgdr+sE73/n6gpIN75Aw/
 KJdDGnsCD5R/XzJEt7hxHDbJDMVIVtOeOd+SrIfaNG5Dri5WTHj2DWQDia2c0D+Mt/ej
 /wg/2/D6q8j9hTGR6NdOGGQfRhL9SeUtDxYZliTuwpC4DdWJrYSwiBLwl0A4YrAOOUDE
 KNRFFpeoQlkr9nuwDjcXAGZ008k3x+/jBO2SpnPCiyv1rEcjM3DClSw7IOfUB3JgDtLO
 Dhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415385; x=1745020185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLZ/A3RY0kK1fNmddGSUh8Vyrw1cp/0HYfVwBIrqHkI=;
 b=sCEl7QH3Ti0pfCE0676rKMVBcD0IUsqnfrwtytN4sciS2Q+KA7IXykafLGELQ+OpZb
 +TnTICLTLzhfRHhSUSZVBFFwgp5NZ4DRW7TqgIyA47YxTz/OqeAxWQv64DwHihyRwagW
 lUNukHyRjzwXdEgHtveqAVUPmHUuTLeQu7LOg0XTMwGIagA79qd1AjZ0jHnVm7wB0BrX
 aiOY6mPvIbFxe+cqQj1Ap1Vhg3LE7QGxj1KDPrP7f7JyRehE8mWOF4yOUcVVrigp4SpZ
 93DGPHSNEqtGW3luxd6gHF2gFiMFwgoQrcguiNILjHCCL05mFXtRLw/mLd0TVo+p+7X3
 Ky/g==
X-Gm-Message-State: AOJu0Yynyod72FUUbsCHGDk6i4NSB4HdbC0ckIYqd4TT58sj+nryCd+R
 wVKZqLP+RuKmy/SOhVMRYuTHF7w/3mCU3czUKVGbQXHPbu/4UPLJ9EL2M8sUngfyQ4LODOhm4CR
 q
X-Gm-Gg: ASbGncvc2ihL/7V/oVrGhJBtMNhTPllHbS7VynhN+PqP7A2NZjjQnfvJRrCoS5xwjag
 3WqjhaXnd9AElsUffGQIS1aUjMc1lQxS6hTCWqfTye55exuuANmXY5dCM3e30lCISPHI/4Ci9qL
 3OUyxtBNpOGPOUYoAPYyCbccUisgQ+iZnrgo0qHb0+1NXGkwTXlQJAL4VTEsZ8utNX5ZQivMb17
 uGCGnmnKq8XgYlT92W4kVp8rv0n5YgawxmqmK8nCPysZglooXMD2L38xWPPe1sL/g3UgXyzWpwh
 5SIw8l5fQjDYzgg8q5f4xD/JwJGBs2sTnKhgdTSv/nqscev8Y4wk+brDsrZR4MymSeGuF+QweJ2
 VGZQb88x2JF0OKARR
X-Google-Smtp-Source: AGHT+IHBAmlIJBS4hwNBXT7vO/uNtckk/ubW40/C4gsBy3A4B34gmUITVcD+CfDX20vF0rLn7+fmyg==
X-Received: by 2002:a17:902:d4c5:b0:223:6657:5003 with SMTP id
 d9443c01a7336-22bea5013cemr63149315ad.32.1744415384753; 
 Fri, 11 Apr 2025 16:49:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [RFC 07/13] net/null: all lockfree transmit
Date: Fri, 11 Apr 2025 16:44:44 -0700
Message-ID: <20250411234927.114568-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

For testing mirror, useful if this device allows lockfree Tx.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 6764cf2ec1..d9210d867f 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -314,6 +314,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
 	dev_info->hash_key_size = sizeof(internals->rss_key);
-- 
2.47.2

