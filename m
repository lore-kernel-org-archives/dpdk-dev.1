Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAFFCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6BE4026A;
	Thu, 14 Aug 2025 23:29:15 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 193C540269
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:14 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b004a31so9703615e9.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206954;
 x=1755811754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sK5Nnp94/kqmdfJA3Pye5hCYiklpfXFmL1R/SXnlRxs=;
 b=kcFvbRzzLFWd4JEZyPFosGa2pgzVcAxqsxwb1A5tykImHvfNCJaexUICozscXAdlSU
 Y8KK6bl2j50slLGXN/fNyRisDA0OZytsJu1Y/4mMzsl6zk4NX//RWqWiTjcOJ/ESM9uS
 3y1YKtpKoRsdmp7TclY8UdQ5Gx25/wCzewSGeqvaLug1HZFbo/55Rrem7+vnIK5jbTUD
 yStS8tCeDcGawpdCmPjdmj4aBfQxg8MSSa+8yybxekqf1Aa65427DFOLxZnQsaSoFj7r
 KAsbFbwveTC4D7hF7RHMYdeMl+ujnU1uX0wpppZMpVPKNEu87aXBoP7WJOrfXj2DfnkB
 jBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206954; x=1755811754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sK5Nnp94/kqmdfJA3Pye5hCYiklpfXFmL1R/SXnlRxs=;
 b=wqCLpsd3eyTRb7eS4ppKniRxOpeP1iij+yvGcoocMQt2APvSCYiPMyfXe2NwFWKwv/
 eHipkPE+j/RbgM3bp2MfQHrAcn7pjN3K5ooGZAFqkce46cYYZJSQCZtz6btPUIwQz3sQ
 bja2jfQ6pDnKgIL2HhiJYB+6CGC04Rcv3vT3oMD7XiawHn7kyjVGxKhSbSK9TSs8IEh4
 tZY73AYO0HGKbwev7ZpcPk48qKX5bYJvN/R/JYLPciT5tE4rAYD1bggXiXVdaiqWdcd3
 Nee5euTBtg1+TFeyuz+aqIdiCN/dPButuMNEgFsIlf55hzD0s+VfLAPYcZ4TsdB6NJEr
 tpLQ==
X-Gm-Message-State: AOJu0YwUFM4EA79wS1RBv9I6hPhIG+CIk2di6Yw0hJbQoEi3DzwG/Ze5
 HC3mjTTwIxh5vpaTzwZqqw179h0OEi4GpTOUYxRABg25Ekmi6r5bU3nEzaQGh7mWCop/Xv8QrIX
 rP3or
X-Gm-Gg: ASbGncukdfAujGp2lgNpRslQ9sUUFLs9W+uJfb6liu8wy5RXY3+oDwz4rcCpsJTWo8o
 VvkeIOpoEw6TWoObn0CxYCnxtYyK7sZpn6qGr3QcPuC4CUtjxQjKnwZmdSvxNlobvhlJSy58y6J
 QSkf8SKZp7UnvccGZ9AjL1q55NubTahFFr/hRVYrsZGxx7h1wHG1nRuykRBnB0GPLIEJeQ96oti
 Ah8ZEZb0AfgkbBZNNS44HY9udgB9unoCFeAOnK+mZiJlIT2kGbwQ0qKDVwFcO2TEOt1XP51/yJj
 1qB8iSGcCfMR1sdVfxoWatCiCEmSKNoPUg9hk7v/p4yjQ37TW6Gx1Zx9OFTQi+gVTTE/+oxwyeI
 r/OOkoUOMf23VG+db6skzILn0jEqRbpSeTfVT0wJ6SskFahUcMbMxgdGAEn18Pi1OsXPSK0wYl9
 biM1rZp44=
X-Google-Smtp-Source: AGHT+IF61Rixy9Af6W8eR9trcpY9oVa+ZacrW+KqH0BFHvW1LeUW0h+0VtfEQkbANRqEKWCCsWcgOw==
X-Received: by 2002:a05:6000:18ad:b0:3b4:9721:2b2b with SMTP id
 ffacd0b85a97d-3b9e415b2c7mr4366950f8f.12.1755206953648; 
 Thu, 14 Aug 2025 14:29:13 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 1/6] eal: replace unnecessary comma operator
Date: Thu, 14 Aug 2025 14:28:47 -0700
Message-ID: <20250814212901.88863-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_malloc.c | 4 ++--
 lib/eal/linux/eal_alarm.c   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 3a86c19490..388e5a63b6 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -202,8 +202,8 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	}
 
 	user_size = size;
-
-	size = RTE_CACHE_LINE_ROUNDUP(size), align = RTE_CACHE_LINE_ROUNDUP(align);
+	size = RTE_CACHE_LINE_ROUNDUP(size);
+	align = RTE_CACHE_LINE_ROUNDUP(align);
 
 	/* check requested socket id and alignment matches first, and if ok,
 	 * see if we can resize block
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index eb6a21d4f0..a1433eb867 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -125,8 +125,10 @@ eal_alarm_callback(void *arg __rte_unused)
 		atime.it_value.tv_sec = ap->time.tv_sec;
 		atime.it_value.tv_nsec = ap->time.tv_usec * NS_PER_US;
 		/* perform borrow for subtraction if necessary */
-		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US))
-			atime.it_value.tv_sec--, atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US)) {
+			atime.it_value.tv_sec--;
+			atime.it_value.tv_nsec += US_PER_S * NS_PER_US;
+		}
 
 		atime.it_value.tv_sec -= now.tv_sec;
 		atime.it_value.tv_nsec -= now.tv_nsec;
-- 
2.47.2

