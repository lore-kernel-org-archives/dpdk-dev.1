Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A26C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89E1D42E8B;
	Thu, 13 Aug 2026 20:04:57 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id B1C0E42E89
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:56 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so92059a12.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644296;
 x=1787249096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJnzJGD7o62kHjLlXNyobGT5RHdeN6M1yGuq52c6nNQ=;
 b=tbSSBBRJEca3USijEaKeW2Ta3pEStfpfrNCTilHnmxQscuWuicaiWWgBcZbp1OjIVP
 3++B061m11xa7w7Y981SSj9fKfjEn8+TTGYHH0SfuDthZw4cWJoyqu5aUOcfQlLwDGJz
 AxZVtlgm/6rrMjD/pgVPI7OB5N7v4m8RPLFJi7VWhVgl9SDijgfouIbLlkYi87RDPq2x
 IjP6j0IxLepRWVc+/P1FiEeTpmAXWgKNuEN65Ge3F2TOqjgZTvTj9Qkr78+onVTayYoU
 p5YhGW5N5MSw7Kj/5DCKLNz069sC5PPZ8NzYED/SMDUIvgBVfmqNfNiC9dxG3NCJjaQQ
 y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644296; x=1787249096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJnzJGD7o62kHjLlXNyobGT5RHdeN6M1yGuq52c6nNQ=;
 b=sJLfsFsB6dRgfSYIX8uvoLqphZcWaKr3kR8L04yZx6Jt1UubkM66Tz/GkQNJngEOJo
 PUULRF+01t+jMc/39S3aECK89wMI+UyqTKpvnbWMX8vCSE8+CyBisRmNBsDddfaMzVnh
 ktbzI1h+tOJEXdZgB0KNfFSsOO+JmzDmQn4gcNYdVpIAjn2xaeXUQDjUndikuMC/yqrA
 O+jPGO2hT+5urBofGtQjHj4Q+hXhAmkmsppiEPhFNY+kIR7xGgSmZUckMCkZjz4Z2uCe
 he3Arull9r6bpuct7XXH7++JmGKefz3MgjGwI4qmi2xnHpOd9V2QVwwLmWUNxzBCmsY9
 NXMg==
X-Gm-Message-State: AOJu0YxK1KDJ/nStU6v99wSeaxFifMfnkZVItiOoOPR1CEjdZ61T542/
 GjQndruqN/Wa0mz0N/Sf037sgCJwOzQyqlevwFR2l208VQzgjtpARf2uFA5IbFVy0ih2WuJmDCy
 xnTau
X-Gm-Gg: AR+sD13lh0YnzL7sDu+Lqz0RGj0h+Nw4ObFG3npBQSgM0qfjcf4Wh4C3dBK2IM6Yf/v
 GOKHBsYt5HmEjFYryiY4cgVEsXSkKbvo+MRHr2N8emuBztUBp/JziwZG6iCo1yWWWc2q8+XnfMS
 gq+EEOGiC3mgKjym5ZmauagzE30aiPGb7iaj6pcA4GuMKRJO1Wc34QWodbVQlotVgqXSb8jL+rb
 RsY8cBWfRd65zN9aMWdZRZHyoPMcR8DzWTP6AJdqoVSZNl9xf5OuYnsXhTwe9bv9RSo3RHiXVRK
 hpCUexPJLpK1QzxJra5AQwV5kiuB2y41UhLzRMyvxMhWzpCsD5FgozQvq2+YcqiPQK+l7EXTyEd
 nPgeHLJXaaTpPBgvE1vfVxP5plalDBqslyDxRfJRXB1451t4ZKzHFZp2VEowBzn9ne7/DJu9yW/
 jXIWdUR9LMWj1pDEr7YGbsRQIbnwyAIkcj5aXrR9fJNG340Z06qLuN3RHRbFJVSkVjHG38z9lyP
 qi649Zz5w9fa6747gMTmU5ACol9oc8Tje1D4Q==
X-Received: by 2002:a05:6a21:4cc3:b0:3c4:147e:98f1 with SMTP id
 adf61e73a8af0-3cc5547c55dmr11004978637.31.1786644295939; 
 Thu, 13 Aug 2026 11:04:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Liron Himi <lironh@marvell.com>, Jacek Siuda <jck@semihalf.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v3 12/16] net/mvpp2: fix out of range Tx queue stats write
Date: Thu, 13 Aug 2026 10:55:11 -0700
Message-ID: <20260813180402.622784-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

The Tx queue stats loop logs an error when the queue index is out of
range, then writes q_opackets[idx] and q_obytes[idx] anyway. The Rx loop
skips the queue in this case.

Add the missing continue. Latent today since MRVL_PP2_TXQ_MAX (8) is
below RTE_ETHDEV_QUEUE_STAT_CNTRS (16), but the check is wrong.

Fixes: bdffe0c70a0b ("net/mrvl: support basic stats")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 1074092d43..bc947ff52e 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -1546,6 +1546,7 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			MRVL_LOG(ERR,
 				"tx queue %d stats out of range (0 - %d)",
 				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
+			continue;
 		}
 
 		ret = pp2_ppio_outq_get_statistics(priv->ppio, idx,
-- 
2.53.0

