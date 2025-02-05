Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7444C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DBB740654;
	Wed,  5 Feb 2025 17:25:43 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 213BF40654
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:42 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so9474945a91.3
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772741;
 x=1739377541; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iJlTuZvQnCWDqPlQkdXuE25ei11Xp5OSkh+ZynGR4E=;
 b=ZgrWj1RNYU1FlR2YSOesF9ePUYaxAsphF20zmKIisZi2bj1LHbIUh1WUH4vdLMtyaf
 F+okwznjszMzCKqcYLPqGypX2Z8KnSAB41kSb1CoWcv+43ppyzNKaM9p6w1ZdnFPxw7A
 HNesdl+pHc5uasp3ubUKg0UV5eN6N2eUxW+rSoLezSZZnPdIVAnseZC7Vrwg8lYywFnq
 pDgBBsGklFrMwnRKCNu7qciWBAKl/IFmuBjlrKFwdO+tH3IB8Wr/YpT1B0I9JF6R+sIJ
 2Qb5SIMvYUB7uUdSE7utOUBRy5E39joll+T9Pw+hNE7EXkeUv8Wu662fkrS2rF4ci2yk
 0+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772741; x=1739377541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iJlTuZvQnCWDqPlQkdXuE25ei11Xp5OSkh+ZynGR4E=;
 b=r8nHpzI53nAR26iwaWO0naJ3DZywv918mwCoy7INI/gmJivLtVrVLMA35hQvu1rePd
 KMIREg9t3EpIkr+hwRnqUueYrEiuTvIzFXD486oxO6hePoTn9c+3RQPJdzXpKX9ESTQ7
 G8S4QOYctHdEbVNtQa4B+gF88t8eKVMBewpE3aT/z/3KX/9OuNyTbP5lPhfp3hWwRmF2
 GOy7PkjL7O7jTGcN4wGCfVKhaNyChsH0Z1WHx4rxG89Lv4/Oi0DiqsSAyBrwwZ44gBB3
 pGiXHbrYa1ZkbhmFUe0+1GBXd7KJXyCQSwJuUFiZA2jq+FlYd7g9FqoKrgr5SdsqBtJu
 TxJg==
X-Gm-Message-State: AOJu0Yx727MemDI05gZ0e4U92ezP+auJcpyConw5SOR+hoXUGbYgnvdn
 pQSwUFiVOQ8iPmB8BHb3QSiDWpWA75NJHjJcXg6a2wzrQHD7zZ5tsHkGt7rUdjn3k1CN5erPsBw
 x
X-Gm-Gg: ASbGncvkABbeLOY38gGkMPy2S+k0LtYEbO4UPS9pBDxLBuGHqWRuN7hSfzjJwJ5tLvC
 oaYODVtV/WZsyYLPOiugrUDbplr9FzQ+jdSSMk42/mJ/wNVTS4cQIE50elTv81LYBNRGASgLIRy
 xw5cAxRhkPJBGkNfqYRRq5nMYM6hmX2fP4c7wwogfd7OuKoMi6DHG+cfLl/j0k/GWM3CKKVMfkl
 huD4vJHXbbY7TytpwiblukOdzLji/QPLRAFTU66qk+2A8hff/rZH1XrUkKmL+ifHSLAUt0Byb+Z
 m5/EvkAkqQ66+F88Eehm56tP3gVK6zFUkkG6eKQhUL8Uv7OiFs5egd2B/O41zUj0yCzo
X-Google-Smtp-Source: AGHT+IEwwOU+nZK6rWdxwL/acmyEb48lb4FkIWn3I5i41J9I26v5hA3G2j6FWwX9Y3c62RU3yVG8Yw==
X-Received: by 2002:a17:90b:5289:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-2f9e0762b70mr5729264a91.9.1738772741333; 
 Wed, 05 Feb 2025 08:25:41 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, sunil.kori@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 14/19] event/dpaa: fix bitmask truncation
Date: Wed,  5 Feb 2025 08:23:15 -0800
Message-ID: <20250205162448.161161-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

More bitmask truncation from mask computation.

Fixes: 0ee17f79ebd0 ("event/dpaa: add enqueue/dequeue")
Cc: sunil.kori@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/event/dpaa/dpaa_eventdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index 853cc1ecf9..400e0ecd1c 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -102,7 +102,7 @@ dpaa_event_enqueue_burst(void *port, const struct rte_event ev[],
 			qman_dca_index(ev[i].impl_opaque, 0);
 			mbuf = DPAA_PER_LCORE_DQRR_MBUF(i);
 			*dpaa_seqn(mbuf) = DPAA_INVALID_MBUF_SEQN;
-			DPAA_PER_LCORE_DQRR_HELD &= ~(1 << i);
+			DPAA_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << i);
 			DPAA_PER_LCORE_DQRR_SIZE--;
 			break;
 		default:
@@ -199,11 +199,11 @@ dpaa_event_dequeue_burst(void *port, struct rte_event ev[],
 	/* Check if there are atomic contexts to be released */
 	i = 0;
 	while (DPAA_PER_LCORE_DQRR_SIZE) {
-		if (DPAA_PER_LCORE_DQRR_HELD & (1 << i)) {
+		if (DPAA_PER_LCORE_DQRR_HELD & (UINT64_C(1) << i)) {
 			qman_dca_index(i, 0);
 			mbuf = DPAA_PER_LCORE_DQRR_MBUF(i);
 			*dpaa_seqn(mbuf) = DPAA_INVALID_MBUF_SEQN;
-			DPAA_PER_LCORE_DQRR_HELD &= ~(1 << i);
+			DPAA_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << i);
 			DPAA_PER_LCORE_DQRR_SIZE--;
 		}
 		i++;
@@ -263,11 +263,11 @@ dpaa_event_dequeue_burst_intr(void *port, struct rte_event ev[],
 	/* Check if there are atomic contexts to be released */
 	i = 0;
 	while (DPAA_PER_LCORE_DQRR_SIZE) {
-		if (DPAA_PER_LCORE_DQRR_HELD & (1 << i)) {
+		if (DPAA_PER_LCORE_DQRR_HELD & (UINT64_C(1) << i)) {
 			qman_dca_index(i, 0);
 			mbuf = DPAA_PER_LCORE_DQRR_MBUF(i);
 			*dpaa_seqn(mbuf) = DPAA_INVALID_MBUF_SEQN;
-			DPAA_PER_LCORE_DQRR_HELD &= ~(1 << i);
+			DPAA_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << i);
 			DPAA_PER_LCORE_DQRR_SIZE--;
 		}
 		i++;
-- 
2.47.2

