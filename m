Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFFCEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C56804275C;
	Sat, 15 Nov 2025 20:38:00 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id DDC76410E7
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:37:56 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b553412a19bso2063354a12.1
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235476;
 x=1763840276; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O620v5P7WPTts3LgHtpuSTvliQv5MoIk+z7gtua/7o4=;
 b=ZWIjlyxT98nJ2mjD9vnX0KesD1y8xrH7X49sVVI8FIiFF9Owi8D5TTfAtnjs4LmvJF
 JMcxZvHGWpqWZrQRL8xT3eEsB8kF1PCkk77CD6sYQ8oYQVOmwVSUDIuvLjXiAN9R4uty
 w14Igrp7qCPlnqNpGKGh7ueB3W2rXkcr+3Ld9uYXpcfBOrwrbJBZxbcpMg4nsA9UbsQ2
 5V8jIVehV4sTxpI9tZa/42M+iV+ANveQ6dw0xBv+n0xacPSsQAHJmA0jE5CJTvtZLHcr
 7auYpUN6K7CxUMpSwWwPLQl1Cm2ZWF4H6IMOA3kkrYkNHwOKQG+VWD9Rmnuu8FaAf1dr
 cj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235476; x=1763840276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O620v5P7WPTts3LgHtpuSTvliQv5MoIk+z7gtua/7o4=;
 b=vOjwT7PnwlkNRoglRgQ1L7CSyaRbYkz9C/2Wus1EofRzPZSZGAHwASD2sw/z90s+G8
 N0av1ShttbznJCRO8PEMvQqsFu9x8vjpR20c+K9IG/YMkkzzV/cPBsluqySypV5CtZvG
 ZsZvsNnZGomDxgzVPDk9fSW6QChqQnyu0Ls2rYWoMvFBexGcb9aXswMz1idiSXYK9efh
 ERLaEynjOVSw8K9qd8XRolHPZJsS4/dOjvzwRX06WQgBoyPU+rLeba+8Wmy36NSohtBu
 yVZ6NFIW1imIUU7w2yIhDjxFQzQzUh6imTn8nB38vnkWh9HIXiEuJVV/4y0VaDhWvNpO
 c/AA==
X-Gm-Message-State: AOJu0Yxo5b3vBQrv0LIhGoS5Q9X2Vhe9GuACv+91jx3HW3/vsWS0iwkO
 Y1nWGjELMlcmxCc/eEpM6Fhhu7K8bVqUugAeTeRdmqplkR/cdQDEHjN090sOdcsCZSwKQtYXUCI
 eAypK
X-Gm-Gg: ASbGncsttcs51r5g+WhPcfm/u6FTcCBdN63XHOo4tQuvMv5WMFZpjRDUwZOrLeGX70+
 8zfqtmBw61rJEZ9CQ/GQsVUe9/VLGpNmeKMqmSWDTAg/17cX/7uUE2knP2EXYc5kzm0SpQwc4mT
 o15428E/nu9VZ1XDZm4v0ZrIgKEf6KnEVEO1cLkXt+pgwqKWMLslrpirwE+NZrqaJ4PBQnBRVV4
 8JTGCIAmbgA0EfdB59+W9IHLjpeGEUgAvPu6POT70zL4ruSqqgzkJ1STpyD/eg6plT3pEkVuigM
 Mc1Cl+AyFmhAlkD3uW1pGrITO6k1+b6L1aWaL84mPh/UlnuaT6iFe3DOVJUgCp1kB6IPRJjinJz
 NepxuvAz4yuaY449nrFazRzvS6w6aL40Mv6JSYMH1/j7h5wtki/jeIeqDP8roZoroe7N1T7MEgg
 pvEdYtZSHwemQzyxDi+LDU+CEShKaVY+XCRl7ZtQHzn1xjJZ27V5ZENe8Ci9iL
X-Google-Smtp-Source: AGHT+IGDpMu9HBVHAr0wT33Naicjr9xhT3oq69e8DW+Bczqh7JH5ob6kDlk9W6tdx19EYpw4jL624Q==
X-Received: by 2002:a05:7301:d195:b0:2a4:3593:6451 with SMTP id
 5a478bee46e88-2a4ab880e5amr2225921eec.1.1763235475916; 
 Sat, 15 Nov 2025 11:37:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm28753833eec.0.2025.11.15.11.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:37:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/4] examples/ip_reassembly: add check before formatting
 name
Date: Sat, 15 Nov 2025 11:36:38 -0800
Message-ID: <20251115193749.101355-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193749.101355-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
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

In theory, lcore and queue could be so large that mbuf pool name
could overflow. But that can never happen since lcore and queue
will be in range. Add a check so that static tools know that.
Format overflow warnings seen on older versions of Gcc only.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ip_reassembly/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..25b904dbd4 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -884,6 +884,13 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore, uint32_t queue)
 
 	nb_mbuf = RTE_MAX(nb_mbuf, (uint32_t)NB_MBUF);
 
+	/* Should never happen but check so that pool name won't be too long. */
+	if (lcore > RTE_MAX_LCORE || queue > RTE_MAX_QUEUES_PER_PORT) {
+		RTE_LOG(ERR, IP_RSMBL, "invalid lcore %u or queue %u",
+			lcore, queue);
+		return -1;
+	}
+
 	snprintf(buf, sizeof(buf), "mbuf_pool_%u_%u", lcore, queue);
 
 	rxq->pool = rte_pktmbuf_pool_create(buf, nb_mbuf, MEMPOOL_CACHE_SIZE, 0,
-- 
2.51.0

