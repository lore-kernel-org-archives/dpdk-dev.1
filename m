Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A3C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF90A40DCA;
	Fri, 21 Aug 2026 21:31:52 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id DD9FC410FC
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:43 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1429464b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340703;
 x=1787945503; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFRQbyNRWDFITaJcIYqpJT+wSPrz/v1KRwdJcK1POMg=;
 b=U2LMUqg10nByYJfp1elyWPRikm7rRLOUaZt+JO9lE5+kIFker/cSf0fA+WFNRrWdtf
 B7fPVAUKCB7exlhwGkdbMO9aIQlp1lhXQF7qOPaZbk70gUhdqxEyZq9rklPEmApM/QNk
 ut676QSJh1/djmNU8a4jlYweam/KGQQ2MMYdqpT+Azx8jfJJRk/MvDBdEE+ileck+VHt
 OhiJX5b7Die5ZkkDZfxHgIj3l1q+OGiqdQjHYN5r8pmbhvqxnbyAczPDOyHJph38F7hc
 9kZJYykrCohFS/8PR5LFqWdWJHXfaNRTnSiGzY21zrybR4FUlhrByiN1NIxsfHj1M0Mw
 j/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340703; x=1787945503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZFRQbyNRWDFITaJcIYqpJT+wSPrz/v1KRwdJcK1POMg=;
 b=hdLSCzH75i9OXYGqroRf2gaRR4j9r35T2ez8VAZLvPsO6sip8l57tb3XSfdSG/gIGh
 QQrZ4VzlnbcxhfqlhiyrKlI0r6rFZmTNAb988O6YRbyOkFuDuyZ8SPBAL6gEZi9RWjI5
 oghNwkmWmKA9aN3OL3UvCb2ZOYPIbv/1FkhaWCzYwlL+NBhrfBjkFXc1/42n6/dbud8I
 88GuorHG0PuWO38VXeKjp1SPe/dG1uZKUO+KP1Lz5znjSzcY4IOyp2KMq8EEDR4AFQ8s
 7BcEKmTd7KTmwDsVbI+yehBE/z7TKstBRIakxHIlh3GfVQisxd7q8kYnJN79TcTHshPf
 CwvA==
X-Gm-Message-State: AFuF++kCdwvncFm5H+LeHCeZAGHgy66OIgKmOY7KKDU1VjOptz32SAN/
 Q9fSZLZ8IjkX44g2Che2XrPbd+Ha6heo4B+KmQposZqMhnD9r8rGbitgLqPx0h0vAnSlw6laNE2
 N9D3knyA=
X-Gm-Gg: AR+sD13HksK71FZUjT2hFEtGgxUqytKzy0ZqJVwW150LINkA7n4EzPLX424oEmiaFH3
 kfbUgBZkI4IoSfBxpQ8z/jbjLGOpeN1DwvNP6rDfBG4y5sJdReqaqP/2kPr9SO8j1xEunIZthQY
 kDEODwa/x6sNybnZWjxuOo2fXymlkyZ7oFjUljwgGwhCo0+Q7rbEgPDe5y0HGfiRThkF4jy7hTE
 UfgS87D06brGW1iX9DszlDlKapwjk6/mTJOSbTun3oKMplhQZ8TIJoENGzt9b7ytEL94S852vtO
 nCi8bPp3u7/eDYTgmXSd0A6yBoj+jDog776Tm2su25tnywXR6LpiFOqb9bpd0Y7aaZv1bfiOIZ0
 fswnB5Pmox01NcO1SxH/ZzuJXIFjZPWKqnqx5ZDviOh0bbRcH+OgxbGOl/jbchm1vU/2lOafvzj
 UaiSagpBit3qeVS0AGhSU2TJ7WCu5KepBrD9Nmn3UhuPr+Z7GGsSiLiSlnRD7A32ThZwK+VK843
 J5NxgVDYf2Lhz18uhq5tCpjDHw=
X-Received: by 2002:a05:6a20:43ab:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3cd4ba4e428mr2167804637.8.1787340703077; 
 Fri, 21 Aug 2026 12:31:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 64/68] pcapng: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:59 -0700
Message-ID: <20260821192646.146382-65-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The rte_memcpy is only in the wrapper for Windows where
writev() is not present. Using memcpy is safer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..4c84e855cf 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -95,7 +95,7 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 
 	ptr = tmp_buf;
 	for (i = 0; i < iovcnt; i++) {
-		rte_memcpy(ptr, iov[i].iov_base, iov[i].iov_len);
+		memcpy(ptr, iov[i].iov_base, iov[i].iov_len);
 		ptr += iov[i].iov_len;
 	}
 
-- 
2.53.0

