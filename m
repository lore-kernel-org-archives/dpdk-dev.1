Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F4C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 16:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5908D40615;
	Sun, 18 Jan 2026 17:51:51 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id B743440430
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:51:46 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso6221653a12.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755106;
 x=1769359906; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=nGyOQZJfdwpOncxJTQIwmWKUni0e1RJew8w9PKwsygTWEXBpRDLS4ovVuKZegAg+IA
 evI+e7HyoG51qKIzXaRox2Kn99geqoHKvMLfN0vF98kr0O4cxJJxUyVKwrh8H2u3NHeg
 vJsA+UOyfzPcaPvEDh73w1N/Fo6r/9lPe+r5x8vvakrldogXj9RcVBtYiaAjZ5keyNOT
 4l0e2uakV6zCndn+eHoUFHuE4VyJ+EZw+qJsRgXF+tbwg650zYHXzhDdBFvzsALrRcpK
 nu+JL3quaqgwObeRn2jFM0jSTcdbsznUqh7ua7QGpgLx/wNRyxazWzijM8STJEoPu2iA
 WZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755106; x=1769359906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=IgT5/Pf0OZ6UD1xsvmim6TNXKRN/WIPS4roQhdwBxYXfuJDoSj/xSL/BEOlJm0S+W5
 yO5pdZGw5jyRG9ns8Z7eeW0by5lYMI9lLgssurMHSe9jPzQ6Jwu5eebXItqg5iFzSuRT
 8y876nGQYzaXL6vjw8728Cxj+S+/olprdYQPyKzTIyTtxZZd4aZF7IKlHFrJRlW5n+UC
 p+cQWvT52hHjESNIop13hlMxiWmE8ysKNETw8hXZEGwbebYVLzIIQvHssTUVNlk+fB79
 UenOoFd3AuBZF94Z+CibwU27hEh9s2wHMLwm9BWcXJj5WASSbwA1blHfz1edQhc4CG3P
 9mHA==
X-Gm-Message-State: AOJu0YytUSZUZFYf5mZgSrF10+2BDPQa9gquwyMecBNDchFhuqc9eTOQ
 PQ5DMfQPlQs6t8AH1zL1sEqx0g3dr7DR+0r6WfqnXIxUYGwqB6v4jE9nfAlSrxkep7X5p1z8O8U
 eqUzB
X-Gm-Gg: AY/fxX7iOS+EtvI7Wus1G7raenTTvkbD5meTwNDgVnpqNOZ31Hzr1qa9IaIJVCdGdle
 ksIxLiHTs4muCvkGOkvN3I/BizEV3wxXTxaos9ovO4XiFHszZ0nu6z5xYfvuRYpEBVgkmShEHc4
 jVURosCup5fiLXxHk2NhZU0k5Nlvz310w2apCg8fgem5EkJ6pHnqE3jEsYEXvql+SdVdQfdpO+J
 xqzFf73C8jWr8hDWwBW7s/jvmEc7OdycmeifAUe/A3M/L7rI7g/fRJGuFTHzLgha5aqsV3qO4WE
 Pdv4HcmiChHGgHYpfMiKS+zkxLvOrsI9XBGUbWMIV0u4x192S4HNlaQIyderfntauyVeiGl/dGd
 jTGJx3mKh0V4kJSoLCbZcjpXH46jp+IlFJDfL61q/xc1hesn7g9CEOyjfOOrEuMJlh39Vl4KbYe
 a8fuVk+yTq+mWWU7aPhTXauFBtKXtxgPI0DGR8u/o52azNTtWkUQ==
X-Received: by 2002:a05:6402:33d6:b0:651:1095:4129 with SMTP id
 4fb4d7f45d1cf-65412f24596mr7450291a12.6.1768755105747; 
 Sun, 18 Jan 2026 08:51:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0b8sm8045946a12.12.2026.01.18.08.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:51:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v6 1/3] net/null: cleanup info response
Date: Sun, 18 Jan 2026 08:50:43 -0800
Message-ID: <20260118165138.37730-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165138.37730-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260118165138.37730-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..3e743a23a9 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,17 +298,12 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

