Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D6DCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03D1D402CE;
	Mon, 25 Aug 2025 05:42:58 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id C4AA140B95
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:50 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c6abcfd142so755402f8f.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093370;
 x=1756698170; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7wb05JeYMzAvzhfRwDSHkBtUVz3OSPUmQzpRN6Mutg=;
 b=Le5P1BCXP9EN4lJ9Lqzid1wnyErJyKeTarC8RN3XtXQMqZ9gZLzkFkFxfcKJ3WHX3n
 LMi1ZdAXhpKuWv6zqhGwJBE+Wt1SNehfsWBwLfwnKDt6QM3fOYxFncuuNYf1dBdMH4+N
 7vcNijB5IsBnx60RKpM+unseSSXHsfugAqpVEelWqYK64Fl82xgUIUgLTXiGocjTbH1N
 pqVTzaN+LrT5yx2GXwmFo8z7YYVirAjDG/aM79TrH4WLG3ZspfzaV7AwIt3+Y4tnBM8c
 opIQ366DnLTsHn3TIWl16vQ3deSi3Vx6480hlXeTlH9dgrtY7tDTeTufZ1T2Iw8LYU2E
 6BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093370; x=1756698170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7wb05JeYMzAvzhfRwDSHkBtUVz3OSPUmQzpRN6Mutg=;
 b=D5S8qaEkqiVmE7Db2sMNpUR6MPBZcSYrPfguPMOyjGdEypm7NMFOYdWeC6HKPL07W6
 HZj0buGFEM+1XkrwTmNk8qa/bpiPIPN8/3aV2OrvlIK3Zdw59vI0tTZHxlLUgTsqnf5h
 4kBiZAk9RNldd+iffnYS3eSNFkFEbhVXYBG0eciVaXuweA19zxqBcdwGpEkGqH1JEW4D
 /CqLzpgnqmK2HKtnz1X7jOQ2vD4eTjMOS4BdTvvaZJty41xYoJ+2BpaWpE1g4mUAiA+k
 k492V136PIe5NDL7VfYax/YZGA6HAeuYre+sUoKZxYAiI6u3hiJUOG8f6ojRzTBy4qYq
 /9sQ==
X-Gm-Message-State: AOJu0YzjNKQW1zWkmRiRb2PkoivsGff9cs+Gg/ArhffwEHdVlX0TWjKe
 G8Ou1MVA5vxq7Q7G4T92jwHc8CiPf5eKtku37nj9RZUjuwkylkvLA4da/fWPok6/6Hcz4dGI8Fs
 WfhhG
X-Gm-Gg: ASbGncuJZ3cWsyylqkl9pU4/z0f2MelotNmJ037AaY7yQzj37Rl9UM4lpCkW6OaW7do
 yjXlNbjWUtsLlWF0dJdcz+EqPQs7e6eMH7L5kKE8u1aiRobGbCcmJgJkYLq0WvUFwAbJHUgSrmu
 x5CWHqtaLsONtxLLKZSA7HXbiVz1qo4X5nxdFQlmSIgZzPYOzqK5AQyzp3lXE7oMuUg3dRpeBYN
 sRtb5TZd9LY31Xig0tcTxQS+GPgAF5AIM+wBr4LHLFyBrokQKoST3EEvRGPjP8Br8ugRNtixQAr
 XjFvV26GMohtBMk3wIvHkSyU/OU2oFL75h2gQlxrAiub5jl0rgRjogsr7epNcwylVRfb4mLkg3G
 Kw9Krac9Kv5d1o7sgCXDvMyngTYLDnUE/uSSD4gRWMKWGfi+sg3zYIw1vH8Mk0rt+2M3k+KQP
X-Google-Smtp-Source: AGHT+IHsA98+7PAvn9CObOx+revzISDEL6i4vllhlkeNY87iyU7apPE/u/LCDO6uqEbCkb6Czax1yA==
X-Received: by 2002:a05:6000:25ee:b0:3c7:44eb:dd77 with SMTP id
 ffacd0b85a97d-3c744ebe211mr5306524f8f.12.1756093370416; 
 Sun, 24 Aug 2025 20:42:50 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 30/43] net/softnic: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:43 -0700
Message-ID: <20250825034126.12046-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/softnic/rte_eth_softnic_internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/softnic/rte_eth_softnic_internals.h b/drivers/net/softnic/rte_eth_softnic_internals.h
index d3975dad10..5b4361bad0 100644
--- a/drivers/net/softnic/rte_eth_softnic_internals.h
+++ b/drivers/net/softnic/rte_eth_softnic_internals.h
@@ -7,7 +7,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.47.2

