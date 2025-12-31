Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2ABEEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B7D94042E;
	Wed, 31 Dec 2025 19:58:15 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id DA8BC402C2
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:58:13 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso18525383a12.1
 for <dev@dpdk.org>; Wed, 31 Dec 2025 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767207493;
 x=1767812293; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/37C5NYix4W5Wj/bIyPv/25fiU5pzAa582eqLLMnik=;
 b=oXQKhtqw+NalwPJzRK9K5GbVD1HcYcXT5VJqtWj/QzwF7mN7wCgB49W3Avfbfgo8XQ
 e9QTN+hOj9NH8r/AQ9/zO8ZEdSmnyKmaEOFKyr2W2AMIEibX9dpNL4gh9ujh6QP+BlIC
 GkF7b7cZCTmxwvCWvJ3x8NisCX8WQ/2s+239ijSHZlDhKpO9FoNIBTdHm53uCZL02Pwu
 d1hGVGhbarf4KAleAaYmTs4UJEKBt94milkWRMOlfQQ1SUzJfJwU/mMO1xLVR+MF/NVI
 mNzSMRHzP0OahIH4YdMZIW516rlOLJwKSnadnZO6BiQsu0dhPZmwHtaFU+JskLOrZ6LD
 1ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767207493; x=1767812293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+/37C5NYix4W5Wj/bIyPv/25fiU5pzAa582eqLLMnik=;
 b=TIMuPXuecmqIhrcRYsAsc45jYuqmnS28WShrHTjpxGgsOMbgkNME9SuAWq3I3EkQrT
 nEH/jVZ6ay5Q2KWj5k5B3l7I9SiRVlbqE/t6MmW14nDOnFL1+VLsEqVD1llKEcXyDPok
 IG1SdZLiWYWE1Mi0Hl6kn89ZZrVwleaFdumtSYRu4k5kqJ2lxku0mHEAPqkYC0aWI+VA
 5AaWT+fsayWfGTYtSgcpMxsYD2OSdtRP1vwGfzt6nf5Q40AoCZg8a8sgBsbAtUBobzYv
 1sjF+bPJ+2jTK2Nh5MhnW7MwcmYus4K6/aNehh6+njGtoOyaowOGvb+VbwSXa41MPR9e
 PIPA==
X-Gm-Message-State: AOJu0Yw3B5ZkLpeBZgf6N69pwflVkq/XdgElFStOI0sqL7Bu4SwEgRyN
 e7a9P6Oi0YOn3w5U4yLLHrPiu8rY09MGfyMaFJlvpcStm+g7MFJEW0PF2ovII9hEJasgCuv+PSB
 kFeLKIYM=
X-Gm-Gg: AY/fxX7fQQlfIkvw9+rpZIQUqfDzh793bEvWOgX0PEVHhFNCgvt+lGJhZDeeBg3Kvu0
 cXCYMZ1uvtw+/kfyBSM3+tpWD/DSOQDdCPOK+IV22+4USa0+jMHeuFWCh5w33mGtYTrc10Oc/sx
 Etvae+s7v9ctebcXFP9Im1N7y+KbTHNxu7+vi5PpwPb7XkvNAgAzK+G4B45T4CI1DI4ljla0Tom
 M75GG2pvaN6iyYpBdi0xUmn7sscUJ8taVRBpgiJgaLN/eluTh5VVJgP1cNrj4p+DQQ0DToG+xpC
 cg9HD5zXPYMTjJCC3hf0QpScwwWrtZ9GuIN6zYDLk+zVqS6lfRA0UDm4QUirypjWjGepXJyQ/zF
 wLq3xKsrfR7Bx4WgHnF7nsdQoFLNxeDWK/sPvGa4G9A1hHDxvHxns0Cskv/A0Bb70uMpBf5D30Z
 WOlZu+M4Us3tbwmQhFCGaPsaCHyj8Uni4PZCJK/8TJ/AWizs6ZTIl4sXMusJWX
X-Google-Smtp-Source: AGHT+IF3jYp9rLewGo8XsqzgnjOWWk0jIfIPSQBxJnev/7mthp4HZQSCNNGhG7FlZ1f1A4pPlmwbdA==
X-Received: by 2002:a05:6402:40d2:b0:64c:e9b6:14bb with SMTP id
 4fb4d7f45d1cf-64ce9b61833mr34492799a12.28.1767207493317; 
 Wed, 31 Dec 2025 10:58:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494dd3sm39000103a12.21.2025.12.31.10.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 10:58:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [RFC 1/4] net/af_xdp: replace /tmp with /run/dpdk
Date: Wed, 31 Dec 2025 10:56:25 -0800
Message-ID: <20251231185803.90528-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231185803.90528-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
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

Applications should not use /tmp to store unix domain sockets.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index f2a8fb95d1..74ffb3ba57 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -83,7 +83,7 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 
 #define ETH_AF_XDP_MP_KEY "afxdp_mp_send_fds"
 
-#define DP_BASE_PATH			"/tmp/afxdp_dp"
+#define DP_BASE_PATH			"/run/dpdk/afxdp"
 #define DP_UDS_SOCK             "afxdp.sock"
 #define DP_XSK_MAP				"xsks_map"
 #define MAX_LONG_OPT_SZ			64
-- 
2.51.0

