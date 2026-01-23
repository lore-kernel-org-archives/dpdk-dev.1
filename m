Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC12D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0333C4042E;
	Fri, 23 Jan 2026 05:30:14 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id A48B54065D
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:12 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so12138555e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142612;
 x=1769747412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=0hdMQikrsoFS6/VFQ0UUXlYT8HxL9tyMXr444mnIxIAG3P9aynWiqZiSqTjJxvi7vL
 E/tzuyLAvAAfYIrwmgXHalA5aEZZ9azNCJHjakMhmL+EN4qUq15XwuveHjLyb1sS/k17
 X2l1N6iU4UJW45B8X9apNZSXwfSR5eLoKmE3fooyOONe+oIAb98i3CQhVKWXrNs3439G
 kXIxR32m2kV/08GUtcqm3UzttaAFbYDdkeyNKeum6kREtbveF15fKNOwgZgGBb4ZGk1M
 Vb+V8m4orPbYdkJA+mSE7lKdqbryfdIA4vFyeVJBMp9IeOZuNRRxIx+zQ1uEmbkpTZTB
 Hbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142612; x=1769747412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=wgow54tsBhj1OhIgzZu3LrKErYMx36swPXEbEgVDknLhnkTevN3Qz1xK1Cs7DmOihR
 lHiOx3tEt+nyuRwit+JCCXndRPHZly6Ep82X0EsOhNg5v9UdGvzCaQaUeM1TMJaH5ypu
 7U5haWZybsn0W12rcJ4jafjWBMTZCn8Wsk2XHwnZLpl3c/D+Voj/TPtIWLamqCd07u3n
 xA773T9Dlvyuq335a5gndGrdccSIw9+CWY02m2HtiacaPxe9M/Onm3Ovm4JyO7bJ8rMW
 qfeAl0qWBsmc/BxPBwbnyRDMkxRwK75EhL3F8tgm6RTPFaPZ4pkSYWKE5naW0eRMpo/7
 WhBg==
X-Gm-Message-State: AOJu0YxMzPCTnnmmwfqpPuksO0qfacuhFxXOGNYSAAHmlXOch+TuaAh/
 f3JKIMuoFOsrU/ojsU2VHPEigIuSPghAP6QUy21FMsrRIcOeH9Lf8nj/hWVDMQ3Ay/OsXEOXNCS
 aUUog
X-Gm-Gg: AZuq6aLOOlaDa1DuQNuu8cQLC7HnYxFGug2BAWSLKKuEY7tcsh9VYBQ00m5kmH+WxVp
 LYHHRuslk1RUrQRlgOz/zU/5OjUNJT7rLvD4XcPjAl3ddmkczx0An01AiiuzIZLdJN9A0Gzvpw/
 0uEx9iccobz0VlVXumZUgqmEvJd5yDWcbUrz+8LwjN/ZcvVl5Yk6IqpCIISd4sO9q82H4zNAOxc
 zraPLhXYaFVhpQqXD/XmdpKgMwWILQegJiM4FA1lx6rYDGCNKFxwtAtKkICLSsG8xv4BIBjNLD1
 b7cTg9sVZnIW4ku7UNE2cz/K2qO4NFoUDXNZMZOwKiz8C/xZFcqYyxVlmKIOWnPPWBnFf5eqiKn
 3nr13LSd8K4A23xcIzxCSa4FH+kXl5zD30px87Fvqk+9MPLuVq2SvbbF0X3aY806ZIESGeJVcpR
 kr/NVVKubpwnpLX7i479tWCw518NqVXlfa7XPhtDoAofwDzeXGDLIj/SCT3MG+
X-Received: by 2002:a05:600c:8b02:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-4804c8e758dmr24593555e9.0.1769142612211; 
 Thu, 22 Jan 2026 20:30:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v11 09/18] eal: avoid format overflow when handling addresses
Date: Thu, 22 Jan 2026 20:28:07 -0800
Message-ID: <20260123042945.159075-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..dccf9406c5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,8 +1153,9 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
 
+/* Address string is "0x" prefix + 16 hex digits + null */
+#define ADDR_STR			20
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
 static int
-- 
2.51.0

