Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00695C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F8642EF0;
	Tue, 10 Jun 2025 16:14:07 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6BBD14026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:06 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d0976776dcso514558585a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564846;
 x=1750169646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYdCW+suCtSqBCcBxJmbNJAz0F0fXne+txrvYDTVPYo=;
 b=KVFm3OPgLfBZajg3yFO2ADDE61t5Q0nNfrd+GLqXXx4Egi61JJrnQnEltoiOC9LkEt
 U8MLQKJXp0KsINTE8sYTRI0djTOJf0NoKl/ld0qS/nc05KcFRidLrrbX0qxJ5Mj4GtDS
 IbyTLnFjDotpI6hacwi69TPF5UhDqyQAYc3M46eoXuCD0w76pph+NOASxxrin9Yq1q+A
 vg1auYnhNrc4W7pHw3GJLecqyOJgHxBHsrRwyIdSey/293hlPnl5rYzkxD8HqWBdmAX5
 1/atr9mEbKQzu5beQYqiMRGhWRwdME/O06bmg2bOWyFd14ya5E2EP1MSApUNIdhLGGUW
 vGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564846; x=1750169646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYdCW+suCtSqBCcBxJmbNJAz0F0fXne+txrvYDTVPYo=;
 b=s2JrZ0teAX9vXkthNcyXXryhU5vJ+xDzQtX3yHHBCCW4PqDCRfxZ7KPyrgb8JTL5np
 9a+b9nvKXW9t9Lw7AloaqkBrU3HP/nFWKt/AsqbeXAljsx1w3LQAZOzPRHebioQxi+Uj
 xrP+EacRZPxzQoIQnPqp67d3rr3iA4/Lwjshw0u+zJxezCn5YJV9YhJMWZc8Pq+fOaBl
 2XKJPbV+09GjhW1h/2Yxe4StKK57xWbjNhhGfto8chYBmv9sN58TVooAVDt5EnAitsZc
 pSjUWKFwVPoVSDoWjMrbsnUlHgazC8n+v9B8kTf6Q39iDvjeqV4JMdIHFUEueYuXa5nu
 3Ggg==
X-Gm-Message-State: AOJu0YxKpzCqkXiA0XzTMgjsesl1qVQrgH24vHEV6Da2Pt0X86fiUEtd
 5UfC2HEZjlVQkd2iHDDWmO2RBDXXkhQl+1q6Lql4BKGG4o5FPYxwBs6FBXJDfr51ow0+PdppMaN
 GOPVi
X-Gm-Gg: ASbGncsiC703xYT9cT6x6ibogimeE+2j4jM8pu5EA0ay4TR+W9Xov0gmS6wrrwH2xkW
 yM8EkhF2Jv4uRI154PdlB5auVRnnG0yjO3ib+7BiKi06OzID8/NaRGN/wqNSAPj6noX6YlsR9JJ
 n2ziyw+z43jYCzT7mdX8E1i9RuR8ne2DHh9lVux2FEb6x7iKi6s2C+VBp+FMUg5qv0fPRWtKKih
 n5BxbQzY846PtHCYhsB74x/WFq7CT7QN+/E5v7X1rJkU5N9qURT5VGnB23kOxdXMRooLh39uFNZ
 N5qfjjDqSkvb3bEdYPB0ZF3VegGm/iLgp2Dv/+457qFuVL9OGpiN4yJk0QjxaIzxzIOuMqrKItg
 UgJPkEohruPaN02Y81ZDvubRJgzhN5ckkxjuk
X-Google-Smtp-Source: AGHT+IGX7bg6zwmw9pi66B5ALveCy2U3oAcBVgIihg3aM4VhsjUO6nGjuKpevTpApcZi8CwIkB74Dw==
X-Received: by 2002:a05:620a:454e:b0:7d3:9108:2f55 with SMTP id
 af79cd13be357-7d3910831e4mr1316321585a.50.1749564845769; 
 Tue, 10 Jun 2025 07:14:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 5/7] latencystats: enforce that unused callback function is
 NULL
Date: Tue, 10 Jun 2025 07:12:44 -0700
Message-ID: <20250610141355.91759-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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

ISO C does not allow casting function pointer to void *.
Resolve by enforcing the reserved argument.
The user_cb argument for rte_latencystats_init() was not
implemented, and had to be NULL anyway.

The log type is local to this function and therefore
can be local to this file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 1e176492f8..46f1819082 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -30,7 +30,7 @@
 
 static double cycles_per_ns;
 
-RTE_LOG_REGISTER_DEFAULT(latencystat_logtype, INFO);
+static RTE_LOG_REGISTER_DEFAULT(latencystat_logtype, INFO);
 #define RTE_LOGTYPE_LATENCY_STATS latencystat_logtype
 #define LATENCY_STATS_LOG(level, ...) \
 	RTE_LOG_LINE(level, LATENCY_STATS, "" __VA_ARGS__)
@@ -248,6 +248,10 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	if (rte_memzone_lookup(MZ_RTE_LATENCY_STATS))
 		return -EEXIST;
 
+	/** Reserved for possible future use */
+	if (user_cb != NULL)
+		return -ENOTSUP;
+
 	/** Allocate stats in shared memory fo multi process support */
 	mz = rte_memzone_reserve(MZ_RTE_LATENCY_STATS, sizeof(*glob_stats),
 					rte_socket_id(), flags);
@@ -300,7 +304,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 		for (qid = 0; qid < dev_info.nb_rx_queues; qid++) {
 			cbs = &rx_cbs[pid][qid];
 			cbs->cb = rte_eth_add_first_rx_callback(pid, qid,
-					add_time_stamps, user_cb);
+					add_time_stamps, NULL);
 			if (!cbs->cb)
 				LATENCY_STATS_LOG(NOTICE,
 					"Failed to register Rx callback for pid=%u, qid=%u",
@@ -309,7 +313,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 		for (qid = 0; qid < dev_info.nb_tx_queues; qid++) {
 			cbs = &tx_cbs[pid][qid];
 			cbs->cb =  rte_eth_add_tx_callback(pid, qid,
-					calc_latency, user_cb);
+					calc_latency, NULL);
 			if (!cbs->cb)
 				LATENCY_STATS_LOG(NOTICE,
 					"Failed to register Tx callback for pid=%u, qid=%u",
-- 
2.47.2

