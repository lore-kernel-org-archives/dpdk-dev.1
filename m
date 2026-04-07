Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38695FF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7434340B99;
	Tue,  7 Apr 2026 17:18:40 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 1BCA440BA0
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:39 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so3493251a91.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575118;
 x=1776179918; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ak1H4zpe9lZLCLLYhVqUvyRYxwINkMYRqasi/dy1P7g=;
 b=xzZMQo9+gIvGUCvM9KbtXbEv7ejguzwJqpfTEeNiu4ddf5ER9umMcEpjcI+7EDCx7M
 3JQFebVTzYPeyKzOpZluZa+1QPMm4HdfA7Cn95m0rR8dgPSbTWKu+od9OrpTUR7cXVfw
 /6uXaNBxqfZ1LlWiUP/7oMsL/hqhA9Vw2yq5X9DtFGSfMyZLiHIuqC1OmgTIS7SmNhUV
 wcfTQV45htbp6IQcjj6wpFdOwQKjr4/2k3DNj8Ef7dAREjSlNI+Hg5lR5CEiIFytUxih
 78Z7xwsP2REFOGQ9W4GBgsxXtDGpZSjQuByQeEUrt3M18SXNUj6LofRWZ9xoBvn/hfGi
 sV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575118; x=1776179918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ak1H4zpe9lZLCLLYhVqUvyRYxwINkMYRqasi/dy1P7g=;
 b=eaEnNSEO48Eh+DqiCHICdAeBqWs1sNe1AM+4/6LpatQMWU30fpTzwSDR9QqHdT6eCf
 w0G/S6ISK40UM2/okCNFBNQf+IVhLF/lAF/LEbzR7FFGNeXa6zJBDOZXXNW9ufUhtfD2
 fULQTHvcAW+xfhX6N1fez2GejKCytsylw+jfPgrRxXdmRc5lt7zp3NVpdO3X9n5ZEqqA
 RNF/JFG3y159qyhjQEKC6eVTHLo2dUKtG3oQcT7Fapd2QRGFPFiEWjZagxaPDSMS/Fl/
 EEIYJIXHT6Pjp23Zj3E35D/8g5SIkD9el5V0VoavIJGGGd4Ez9KmSx8AP9AYp/cDK7Qi
 I4MQ==
X-Gm-Message-State: AOJu0Yyb5fluaxiqFA95+HkqnCd/6pQvX819B3hc1qDDOUNGd53p/gKc
 ZxVWPS1l9Km6NCBEQ/Hf7ibUW9atey8n0eFZ1MIxNQ+P4qbAruIjGmcYU/l9GBwTFDqvFQpi99k
 rsg7b
X-Gm-Gg: AeBDietdWKlFde2RsqvIhMWVBUe9OrDSt6ZGiKQfh6u/UgjO5mEyYLzzw/cx6uCTMJV
 W7rqJJuU7TR8fCUkymOTYNQrRDHkdyYqKeK4HWcDRxOD01Jl5Vx4XSfKkHHAtIzXG91j1OnqHO4
 PWUCSMXk7F0VG4XL+1TB83bGsXfCrA+DontAKUA53XoJVM7Pxljb6FTasDikT8wwlnOfmBXRVlk
 EjNfhDu2yUc2F0NRtAL4TB5IMa7k3521+ez9em4Yfrxuy+nUaCEx2ecRDj5XbXr6FvVgOuZu4ll
 nTUluwg3tAppqFlazGQSpe//2JAgBefutPy9mGb84CTcuovJVpD2bxsPY8WHUBqL/eehBjrCfqE
 TgRvCHcOPIK822LWxaO20w8b3Ul5fu/OxeltCNztP7cXGX/7yR9Zk7BcKlTVDZt3Q0Z0BUkB1QN
 BLqp7zeckpd7YdZjwYv9bdPXpGu2+qM4lD
X-Received: by 2002:a17:90b:1dc6:b0:35d:a843:6b1f with SMTP id
 98e67ed59e1d1-35de6899ce5mr16642397a91.11.1775575118043; 
 Tue, 07 Apr 2026 08:18:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 17/23] examples/l2fwd-jobstats: resolve shadowed variable
Date: Tue,  7 Apr 2026 08:16:13 -0700
Message-ID: <20260407151732.272195-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

The inner loop across ports was shadowing other definition
of variable i.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-jobstats/main.c      | 6 +++---
 examples/l2fwd-jobstats/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index 036bd4f951..f2c284cebb 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -515,7 +515,6 @@ l2fwd_main_loop(void)
 			uint64_t repeats = 0;
 
 			do {
-				uint8_t i;
 				uint64_t now = rte_get_timer_cycles();
 
 				repeats++;
@@ -526,8 +525,9 @@ l2fwd_main_loop(void)
 					rte_memory_order_relaxed);
 				need_manage |= stats_read_pending;
 
-				for (i = 0; i < qconf->n_rx_port && !need_manage; i++)
-					need_manage = qconf->rx_timers[i].expire < now;
+				for (uint16_t port_id = 0;
+				     port_id < qconf->n_rx_port && !need_manage; port_id++)
+					need_manage = qconf->rx_timers[port_id].expire < now;
 
 			} while (!need_manage);
 
diff --git a/examples/l2fwd-jobstats/meson.build b/examples/l2fwd-jobstats/meson.build
index 51da6e277e..d59d3d6555 100644
--- a/examples/l2fwd-jobstats/meson.build
+++ b/examples/l2fwd-jobstats/meson.build
@@ -12,4 +12,3 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

