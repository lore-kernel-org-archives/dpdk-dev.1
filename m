Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3F4CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F079940A6E;
	Mon, 25 Aug 2025 05:42:43 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 38CA14065D
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:31 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c980bd5f48so381237f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093351;
 x=1756698151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/7HLl24/edRDB7QC4ieAYE9TycHiOP7NwzbNbg7pU4=;
 b=TH/LVbILp39t1S+8V1CccVEZlNrQVDyykRwhmLyB8H9Wet85sxw6pqHSL9uWGJKTob
 JWkVrU6lHa9FCu3tG97c/Q+T6N6uv8UHeBDEVVitv41K1h5Vb+iganQ/CTFw0yMwT2yZ
 MOxoJeC2NBxAoO2P2C83s88txrDehGEl3rTdCe9ZlXjsaHcuBnWlIJZUGN7CA/1rLU/G
 RjkmN7AJZdHL+JqjOVilp+R3oLGemscPPcHuukUixtT98BOEukdYmCWufpakAYtbQzg3
 +uzTIOwR0A9o8xlNknGvXyDx4kUqjUBNH/ZDCitqxW+GdTJZuU++QbOQex653PB+q4v7
 ycnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093351; x=1756698151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/7HLl24/edRDB7QC4ieAYE9TycHiOP7NwzbNbg7pU4=;
 b=NaRm/TvrR8ryRSpnRMjhkvrUgW+JUX+LB2OXiBVwIDrYvSbzU1G74r5ESDJgkY8FEZ
 +4npb6TDhIlR3Rjy00tCOmlQxlS6Na03m9x63AGGQYz3VuDE1eg6LqcOd1qdqHUJzSTH
 GpjpTP8R2CXN8XOqCPXsTnPqrI7QyXKU/I+yyZwn35bhn7QjfEKV9djDgcPyqxxeWU44
 +JcQ1Xxh9nZU9wryuTt9/bFgW4jCbIQ7sXgMtDs88lLeGtdDqvVXFVRqsdyHbG8nAC0S
 xtiEhcC9ixKuB59e6FeUUmHqxJMGLlEKHH41f40FvrcqPJoQ737ncLJtc9FHgUWVBxjV
 ImQg==
X-Gm-Message-State: AOJu0YwGAgxpOOhaeXspk7L3Zm2lRDFvBxxbEF00sU6L6wfrekD8aqEu
 8P5QmOvf7K+iNBwi0e2OUhfzXiG5rQ1YGk3ILJvgko/54lExQva1P2rOoQOLEpiDJyiADKdvgjC
 uPwU0
X-Gm-Gg: ASbGncvDvUIkPRt9cvPvfBwcR78ioUP4F5osDm05KG4slDbwpe6PwUKhp2AUJZq5+Mz
 gxpbOvUtIj09br1QM0mMlctw5tAu5/obEY2RmjPcenDIxbYvrxoXSIo9TX3wkOGgr4nlcbCcBa7
 8d+N/lzGEzyn6tDVWRVpVAPL6JbiGNHm8L8X2FbLFQ8w75Z8t+0QibQf+Jdq2V9QNwKe5r1DlLN
 ui6bGZH7NlkVC5zsM0R+xj4gGb9aOQwvIsswQd8uVG9Uw13r1LXW0KI/tCvmEV5MtUm35jDz0Oz
 eesin+fnUXa4oqopfJxeznlHrcM9r/TXc4mDZNu01dH6s8yUrh5s0MpCm+q7shlqrYSXUgUXI4e
 VDY06i1C5TwVinxzF2pGuFJBarAuJLguvBcohHKZ8CwU6TriizwALW+KIEZPopzNn/12YCrZu
X-Google-Smtp-Source: AGHT+IHMeiq3+ywhRvSbYnFQWcqBy3WJLvwjIWs6Bh0kJKWT8Vjttpi+8edfBgUcREsqTgzUoLhf1A==
X-Received: by 2002:a05:6000:230e:b0:3ca:15a3:43d5 with SMTP id
 ffacd0b85a97d-3ca15a3511emr341222f8f.12.1756093350794; 
 Sun, 24 Aug 2025 20:42:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH v2 20/43] net/axgbe: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:33 -0700
Message-ID: <20250825034126.12046-21-stephen@networkplumber.org>
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
 drivers/net/axgbe/axgbe_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 93e6c177b6..e882842e39 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -10,7 +10,6 @@
 
 #include <stdbool.h>
 #include <limits.h>
-#include <sys/queue.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.47.2

