Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C0D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 974A1402D2;
	Fri, 28 Nov 2025 23:44:30 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 1C403400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:26 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-880499b2bc7so23547106d6.3
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369866;
 x=1764974666; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=SE4NOOcsRBbMrKhoPNks9ylA62LlqRFKd8m0w8Mh5eZGVZm9fPAZq5xyDruaYfXM5S
 pq+Zv8Tny8GuocXoyGEppOR8C4CQZFuCoajFctbT1IT7EUN4KXdAk3T0BYq16lc43TrH
 FRoqOQC8NzUjs1d9DHB2Ze5GdyQ8pCXDh5QwLCZXz4pf8MCB7BVjZqOqhHSX3kFkYvqh
 FcTjhE8fCNqiOQowKynfoYRKOWZfQsiaIRh0loOk1Sbc+GA6Zk3FYDYzcfK3ZiTs+rM6
 3qywfGNBVfqhw7455rqLcpnmBFzm1i7VkNcbiNdf2hCznrggU7MYhF8/SRP+d3gL+Ix6
 L0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369866; x=1764974666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=oPd6Hj0bvLuGnluhTBr3rnddyhwlZbcQT7w3tXdd2GJMijKCtD9/WOKBhZctihyL+0
 XfsE9cbtLXl8tymdyNeux0zDu4skOOeD6G8lGUHD9RKfIeGpMIR93Vu6liiNj9tuiRxu
 ULCDbJkEFHYWkngxqJeHKHxGE6lJ5Ye3C5NSJBaBdYmhzWTHJyGXF1pGuGz3HWkSlnen
 CYSf75Mabt7edqtVI37eeB4WlErDQEqmtWaljhvKrkax3Q4ZFwN0cPIFe4J7bD74W4c8
 Hqr1M8ihlVuJiIfZrTRd0GaGLADod5gN7epWjxa+GIqFBlzbrRLwYJLY2mCoZKMhrJiU
 1p+g==
X-Gm-Message-State: AOJu0Yxq0jMxQJFgY7L3qKp0Fu8dHgWghkljMQAJyvJTW6FQECUbk10a
 BCTtY84z5+AqAFaaK0ewUfKMN4bS0anRdNqOktpiAi08RB5DhJwyGx1YN/vxVYqF0OVRAg2XhXa
 nu8/T
X-Gm-Gg: ASbGncuj09jQx3ciGHW2fNYHO4MuBHph9tjO+r1Ly7HceELkrP/rP4TljN4RmK+NXuk
 /ofBm9uRfTOm8e40WYFpMA3XReOS8u5scsksp7m214/7xnfChb/mXsP1pjtjYp7A1kE5vHKCSz0
 YJmTy8b/3RzSIw782XrvuETt2XHqOc9kBQ5aYBhmUJEkarkVz3WS4kZSTmR8K2Z7Va+1Q1N4Ytd
 +aGtNYIdQNBzJNldpxxEoIBE8FwymoKOMddKRGCWZKeWZ9geFG2JFeqLIfbUP0IkIyJTs4X/bnv
 4ZI3lG1y7+KHMyd7w7EQoZAOci3OOw4/v0/FQAJ5AQ1lUpSP8VbGo8AbbSO1v1DTBX3n4/mULt0
 ivZbJoEddQuYLhLA+Xogf16TkzwGNjEPOcVIpgnT4JlppdKLwnZt1kcY8fhnUluLZh10/3HX8Ri
 dEp7dGjR3N5KJP5QpLIfUwQbDp1f8iD7ZFyogOgzJN75UDGp4G9g==
X-Google-Smtp-Source: AGHT+IFVJsclDR2b3tNUrAOvgJVVthCX5pigm31N2+VxAflcsq7iTv2SMsfhf/Bbl355w6IO1u00rA==
X-Received: by 2002:a05:6214:4b10:b0:87d:c7ab:e5d0 with SMTP id
 6a1803df08f44-8863b04bc91mr275946326d6.55.1764369866383; 
 Fri, 28 Nov 2025 14:44:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 01/10] test: increase size of memzone name
Date: Fri, 28 Nov 2025 14:42:04 -0800
Message-ID: <20251128224420.195013-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The tests were using a name buffer of 20 characters which could
overflow if number of memory zones got large. The upper limit
is defined as RTE_MEMZONE_NAMESIZE so use that.

In function ‘test_memzone_free’,
    inlined from ‘test_memzone’ at ../app/test/test_memzone.c:1117:6:
../app/test/test_memzone.c:52:35: warning: ‘%u’ directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
   52 | #define TEST_MEMZONE_NAME(suffix) "MZ_TEST_" suffix
      |                                   ^~~~~~~~~~
../app/test/test_memzone.c:931:46: note: in expansion of macro ‘TEST_MEMZONE_NAME’
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                                              ^~~~~~~~~~~~~~~~~
../app/test/test_memzone.c:52:35: note: directive argument in the range [0, 2147483647]
   52 | #define TEST_MEMZONE_NAME(suffix) "MZ_TEST_" suffix
      |                                   ^~~~~~~~~~
../app/test/test_memzone.c:931:46: note: in expansion of macro ‘TEST_MEMZONE_NAME’
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                                              ^~~~~~~~~~~~~~~~~
../app/test/test_memzone.c:931:17: note: ‘snprintf’ output between 18 and 27 bytes into a destination of size 20
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  932 |                                 i);
      |

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_memzone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 506725ea41..6586dad18d 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -872,7 +872,7 @@ test_memzone_free(void)
 {
 	const struct rte_memzone **mz;
 	int i;
-	char name[20];
+	char name[RTE_MEMZONE_NAMESIZE];
 	int rc = -1;
 
 	mz = rte_calloc("memzone_test", rte_memzone_max_get() + 1,
-- 
2.51.0

