Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A8FCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A303F40151;
	Sat, 25 Oct 2025 00:47:23 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 1607D4014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:47:22 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-781206cce18so2736949b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761346041;
 x=1761950841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qRuzj60eJTCLL5+5Fsaa9Ga/o58s9x7/ohyFbkVjWzg=;
 b=IPxh0tGMulSexbV54w+jR9wZG7BEw5hQBDNvY44LnsxjAXuk805KKyCjarFp8+b6wS
 37Sh7PNPNg0p1JNCVH2MZSb32D3ltpYMdwT9VbrV0jNRdx0bw2MAgwJm3bKrl2ZtqBjl
 6rJUF4UCgA+FK6PO0mk8ykpxWcOGDpek6Ycvht55mYWWFB0anFCfChBr6r7T2LGtzSPy
 Tn6mJRuWLDKSXVSbUS360dW4dkK7Mz0DVdcxXLsfockD7cJDhnTBzkJ/r4x+m1s3JysM
 t3m+R2pi0jQ7Yxl+0k99x818xwhLPbUpagRbDcLkSKI7wNfCLAxebQZ40bsPLgiWqIR4
 /Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761346041; x=1761950841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qRuzj60eJTCLL5+5Fsaa9Ga/o58s9x7/ohyFbkVjWzg=;
 b=Pxhnb1HZzVf+WtZCXwLuqUvz9N9oh1M/yFuXEgdji8nh41oo8SBuOBL3Wc4v9MlrmI
 FuSsF7oyQGle9Pe3JJaVE15cRxre7eCgLzenc3fgbdgRz32GznXij4Zwikrb0uBNXbS4
 +B9xXit05b2s6yPoe7j7f3jBddxVmo8sJ5LXA3VtaFONVALuPWJAtjdyRqwqNUH/FUSO
 L+W2Fd9thwq59THwB66OkRgpsucnK2LOojCSU1Me0xrIcSPjQV/5UC2WbYTJB88y/HD1
 1g6C4ghdzyBBWjdUahZDr3v1yBB7LaLI9zawnymMHg50h+AZiAgfjBnHDiAEXGLhP2Bw
 2r2Q==
X-Gm-Message-State: AOJu0Yx1UpFOkzkGwItha8gQD+x8d8ezyu+L1smM7MIMic5bqU6xP7J7
 7JwjpUEsjuu9Nv7Rm4pa48sX1JfzraAU6JcXtUS22Ac6FxqL/NsxvW7G/hF+D53VBqHztZPXl4R
 c5Eac
X-Gm-Gg: ASbGnctReA50bt87CNHp46uX1hwnYQsBKWhlzJOU6W7YTnHk74Pa4wrHekUeTYuuZe9
 Nla6zRmDNzLlUd7f2Gq3Vkt9H/+zjYY7kO69s2jENHj6K9MtQEaDQDiLPkinmVpNvaar+hgkOTr
 RmWr/3ntqQkIRrT97J71iKgJAgt8jwfZ3arkn2k9RnQ3Cwk48hh6LJ7o9KBCIKFX/ue+HrhiuSN
 7C1B+jSk/233uEIAm8kNPAEdkDTiJF+Osw5qdM71S8tNtfV8xNP0yyK3Lj1qabqhtm2kl/pzqZG
 AICCk8VaQqVdCn14VN7sM/9KRvytLt32toOSqX4INzMb1M0hHmqHsCPOyOeIZ37OwtMNCVKYNug
 262yrTaic8AAw4d0h+vvcnFv6RSrLex4jPrGe3B1pB5l7yk6y/WYvM+Iu1DCXyFsqDG/VFrrqNa
 +FxCiFahHaVsgB2aNGwbQtWHhIVOelkkXnp0bp0WreX+KorpdMXw==
X-Google-Smtp-Source: AGHT+IErv3iH4qvHA2oAlBThlzU0pq320ScbfwJkGBdRpR7nUfYR+Q2zga/E+8Ddxnz0xIP4nOIzAA==
X-Received: by 2002:a05:6a00:228e:b0:7a2:7f45:5898 with SMTP id
 d2e1a72fcca58-7a284c7fca5mr4937059b3a.3.1761346041122; 
 Fri, 24 Oct 2025 15:47:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012bcesm339844b3a.8.2025.10.24.15.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:47:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: linville@tuxdriver.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: update feature matrix for af packet
Date: Fri, 24 Oct 2025 15:47:19 -0700
Message-ID: <20251024224719.343852-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This driver does have basic functionality which is missing
in feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/afpacket.ini | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/features/afpacket.ini b/doc/guides/nics/features/afpacket.ini
index 99f87ab6ed..391f79b173 100644
--- a/doc/guides/nics/features/afpacket.ini
+++ b/doc/guides/nics/features/afpacket.ini
@@ -4,3 +4,8 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Promiscuous mode     = Y
+MTU update           = Y
+Basic stats          = Y
+Stats per queue      = Y
-- 
2.51.0

