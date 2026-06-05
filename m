Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CECCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32DAA40654;
	Fri,  5 Jun 2026 22:53:01 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id DC6F540652
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:52:59 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8ccf181a52bso21254196d6.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692779;
 x=1781297579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l72OVXTsr3yDFI1F0GoBVOp8Q5Q2sIS6MdnmmSCBFrM=;
 b=W277sivk5sZmBVFKrOU59gbN7sfzTnsXwcdxs+z6jFF5qlU3IUSvAL1kEsWSgHXmYg
 0jFRHd48JdWPlA4brXWj/tZOpPj8wHJq+WQ/RHnPG8bppP6w7YmJNTbIvcAP5agPrvaq
 0rgeaTlP5nEBFusXRvLv67/bQkN5hI2yvNNSF0AQvP71UPG4zA3kmDxpw9EcyqqPsF65
 yO9ZpJHxAefoMoXZxIk2TGJ/hmu6Ia9Fj1SSELSvLbjohIeUrNcRC0vKReUNqOmwhNIO
 C2YUTW4D9ftGXMQZURdhav5U8w44eSl+fNkZ8JhbkDz5F1lCmHgEd7A2kj5S14ykxYMm
 wAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692779; x=1781297579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l72OVXTsr3yDFI1F0GoBVOp8Q5Q2sIS6MdnmmSCBFrM=;
 b=KxQlgwtl33/TwBSuUIy+w5fSEdOHLj9dz5T4qw+2WqK9sxJd0oAR3rfh5/jIb5js0j
 hf6tqb7yzDQxL2lu5tNtlZvuDFyD3Y2kj5phMoNM5gbWOEMsp0ctQ5rvSnD/NA85TYEx
 xEUqsrlZ+LmHhAdWDEJmczRsBOooV15ldPGOS9rWSjelKDQaoLNMmhPOjVGOtUMVRpnl
 xrI6yrLJtvrWitPKCykxFP97M2xDBejOIRs33cfH9SPfWTrQT4EOTXoDGI75mpc6G9bx
 heBdTxhW+GWyJO75/nlGl56Th1MDFQzl0i8xHFJ+Y3c7PBAWxNhAB+1xUCenXEB1+IME
 31rg==
X-Gm-Message-State: AOJu0YxqFgbA9XKwjwUuPsfMYqnxE6eG+lnYQU6TsjDsXiPMaF+EaqUk
 L11E2J6RLfnHT61Ht8oOndJMe2OKo/+Oqxge75SspSvdJozfFP2U6Z8UP68YIrDwQkDjujbPuJe
 zTga2
X-Gm-Gg: Acq92OEjXM4xg4sxQGtDf9aBfnnfSo2V+OapVJ3gi1UwxhvFHUpATxHNj+6F5ewzuod
 xlrfL+SbLCUkNCYBM8oe3b1Ue7n030ntqSayymZ7lqSuB8bDlFJP/D/vDOiSyl8C+p2IeETXArO
 TVIs1tFrbLX8pLVgY5xQXAKeRd4tD7sqW7Xqr9TQssmOiK2mfO0joIsUNbCrTJ/WMQjqUIyuo19
 sb1lZgXGfycpQIQSlpXK7TtP7PRK7A/k/y6DTLZtuihwUeePKK1HnB+hmLWnomze29Tm7y8IHL2
 NE0bLQDXWyq2IGJWrIwQYym7z2Or5CkV3Jx8iqlk3mky3Ys3Im4HplrTl+QK4Pk24W3fgQpcaq7
 Uq8fcP9ncSB2r3YeCG6FQTFEdAbpzBMwj4RXhrXxYuVO4PZaVXWoeW8AhFQg42dLu7IZjbdGII3
 3D7TMOg5cm04h3+GoiHDj5cAQ9F0PUh9MIqfp/g7SWi0VyfmuhOHdxAc8uwvdOorqpIq5lbAkI
X-Received: by 2002:a05:6214:4809:b0:8cc:e8f4:1636 with SMTP id
 6a1803df08f44-8cee6131695mr69069696d6.25.1780692778732; 
 Fri, 05 Jun 2026 13:52:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:52:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Power <ciara.power@intel.com>, Keith Wiles <keith.wiles@intel.com>
Subject: [PATCH 1/8] telemetry: fix thread-unsafe command parsing
Date: Fri,  5 Jun 2026 13:50:58 -0700
Message-ID: <20260605205253.520196-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

The telemetry client_handler() runs in a detached thread per connection,
and up to MAX_CONNECTIONS instances can run concurrently.
The function strtok() keeps parser state in a static variable
shared across all threads, so concurrent clients corrupt each other's
command parsing. Use strtok_r() with a local saveptr.

Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index b109d076d4..e591c1e283 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -415,8 +415,9 @@ client_handler(void *sock_id)
 	int bytes = read(s, buffer, sizeof(buffer) - 1);
 	while (bytes > 0) {
 		buffer[bytes] = 0;
-		const char *cmd = strtok(buffer, ",");
-		const char *param = strtok(NULL, "\0");
+		char *saveptr = NULL;
+		const char *cmd = strtok_r(buffer, ",", &saveptr);
+		const char *param = strtok_r(NULL, "\0", &saveptr);
 		struct cmd_callback cb = {.fn = unknown_command};
 		int i;
 
-- 
2.53.0

