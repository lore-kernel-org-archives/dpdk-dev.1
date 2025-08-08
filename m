Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0DEC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 17:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FCA240B8F;
	Fri,  8 Aug 2025 18:59:14 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 40AE04067B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:13 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso16451665e9.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672353;
 x=1755277153; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=v127WQFowCKMiQbvT7v6oEUMwXYwyJ/3lKKx/f9iilOgvM1NsWjvtzbAb70Mpsf71V
 0BflgkKQscfp8+6AUKZvCx2VPSCsuXpwBIn5IajvD59OB7Z47J3WnXQ7nvBCmprikhdZ
 6P9GTw4XwCcoqjrD7yrUh8JkKoUyimwCUfItngdjpZFnejwkvIcBbO8bVcBxED8sXMGE
 ry4uy+kj3Bhs3unqz/HyFg8aoxx/tXxLw4zAJwXSvbD+agydJah5VjRvVEeg7l/hDV+e
 Q6tWU7PfJggK6v/jJczM42apUQnZf0IWswV21/uj+Nxiy7NCBB5DGirzgHo4xOc/gm20
 ujfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672353; x=1755277153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=I0dalx5rZd0YpVqhCbs49fZD3wigvTzUrMyvSY1LxMBwa5EDCKWbpfUUwZypTxHGim
 YswwS/dJsDhzSRf5rnp8z7xr1IdiwVl5hWu9fxUZz5j2KhjgVy/7NOP+TJ/cOAI5PDUR
 07lsCkblDKN49g+iwr++eacyyDdE8jJVPW8x02Bfd4HKgefBbHUd4T3beh3j4z0bF9ZD
 tIb/XObdutbWNl/7PcJs9Cv7pPmsyEx+j7BN1j6tfVfYzbiUcuWDR4kK7ooDqIbXac8E
 8acfLda7w9qbi1Q6AewNv8NwQTfxspzn9vJzs76ncTrNTppJvwEsRPq8IlI/BXEhAtxl
 NoVw==
X-Gm-Message-State: AOJu0YyOvcjaXFwNtIpyOdbU8WVg+Gxwu2V4+WAGYfPb1avjNy+PwfZz
 8wfMp7YRtdIujjQcgaUmu++QjCW14ely9utRDbgLIvc+7SaLigo2TNGib+o4h+OtaFl4Yc2u0FF
 d5MpJ
X-Gm-Gg: ASbGncsVM2oegW9FpnIu2QXzdzRzfYNcAGV0Ho981pulRVB8k2F85NiFsWkOHD3dSER
 xkoR8tLfFwx4+Qy+F1K1otY7dAz3rQn1NZ3/NI4VgFYUY9dA2KM4eWok2C/uWXDD3uGPavBpKxl
 bX+ovzODDCxXJsIm9zvPxbLufI+Fy+oZkU7zoW45VWFtA4hrMrKuaQO1zzgkM+wv/urNBaCcQ09
 tHp94oeexM5Dp4Q6N3OTu/g0ka/oB9eKdbnOVi8N5VtQEGuAO80l6C8y3tTsQLN9c9vxpbmyVvQ
 UQb4V+UXXv3T+gVa9DWTXqEUqle7TnGQYPG+n9rMEncAaWAmcQ7U3fjyYBe3lfAviU7mZLcm2HO
 3L/bRCKzvNjsJDvATS6yYG8D92HkqmfIKDLphHCLTJ6WtWGqVfKXBBZN10iRTkVGFVkST06ud
X-Google-Smtp-Source: AGHT+IHK4YZ5EO0bLozac1SNB/FRnAXn3q5Y6Sr5WSSaUrVLx3glqbaGYSzMs3tVhCiccTvhLSlXQQ==
X-Received: by 2002:a05:600c:5490:b0:458:bb0e:4181 with SMTP id
 5b1f17b1804b1-459f4eb19d7mr38516075e9.10.1754672352769; 
 Fri, 08 Aug 2025 09:59:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v11 12/14] pcapng: make queue optional
Date: Fri,  8 Aug 2025 09:55:50 -0700
Message-ID: <20250808165843.39075-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

The queue field is optional in pcapng received packet.
Use UINT16_MAX as flag value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 7 ++++---
 lib/pcapng/rte_pcapng.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 6db5d4da50..c27cb9b48e 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -500,8 +500,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 
 	uint16_t optlen = pcapng_optlen(sizeof(flags));
 
-	/* make queue optional? */
-	optlen += pcapng_optlen(sizeof(queue));
+	if (queue != UINT16_MAX)
+		optlen += pcapng_optlen(sizeof(queue));
 
 	/* does packet have valid RSS hash to include */
 	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
@@ -531,7 +531,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
-	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
+	if (queue != UINT16_MAX)
+		opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
 
 	if (rss_hash) {
 		uint8_t hash_opt[5];
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 4914ac9622..48aaab365c 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -135,8 +135,8 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
  * @param m
  *   The mbuf to modify.
  * @param queue
- *   The queue on the Ethernet port where packet was received
- *   or is going to be transmitted.
+ *   The queue on the Ethernet port where packet was received or is going to be transmitted.
+ *   Optional: use UINT16_MAX if not specified.
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param orig_len
-- 
2.47.2

