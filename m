Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA6CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E171040EE2;
	Sat, 15 Nov 2025 20:34:16 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 14CBD40ED4
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:34:15 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-29555415c5fso35191435ad.1
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235255;
 x=1763840055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=kNtWEfz21qJRqRS4dE4ycG2HPJzIr8FOatAU5XgOzJCQym/zKS+iJmKW8YpR4TSYkT
 nVUjTeRdQ6iz3vwHaXTgEmfdDSLwWsL0p2+dVQmehaUQlpnRtDQuH0Neyh0Lj2S66FcG
 9iPDAa1LPAihkbSYBwZGUinSShW7Wub9UHQhbNztx3QXiP7GLEotRd/cgtJpizVTjpHo
 h11Q5ZrcOR4QG7e5oTu/xvh0DPexNmUsnRMGbwIgRJPlIFdVnOQ0LtHJSGQNtXzfNLXP
 Sa3LjXvk02C2777wPwbLS2fdJ5/JS0DSCeJFAQFMFRlv7b4ZEDSzjI8l8saNeSgz4k5B
 WHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235255; x=1763840055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=u1x5ESWqQmzhOdLO3PmTr/ESg0EjyexgxATEY4sMLW8dUj1ohiOx4K13W0U1OGjkNd
 nq1okQQosoZby5c1C247mVCWYN1jXRmF1p8QYFF9odmOsGwmLJzehai6q+j+zS7sn1Gf
 ftvhYhzWPFJq7l3loE89FKn9NLltL3bgUwAgDTpzlbsbnPOcALYIjBPsV73GsclJHTMA
 wpGtMWvPQANrb+GgrI2f9hW3/YahHheThnAEUQVaX/zgavISBbS2zHAwC9rrZ1ryvhzH
 /HR96TIM+7rRtlC2u5Fc+/16vDNxc4hR6papA6DYsmDlARmEF1TYCElcemn7HrgtzhkF
 Tanw==
X-Gm-Message-State: AOJu0YypkU0GtLGNH0827Gdc+wlF++pWMwxpD/bWd3P4c6zCbCi3QZfY
 pvCJqV9qAInnpbuH6Audt2DzwyV82uuTgjNsjIw7ji476T9y7gmYZBMqjijHblNIEdcAq6A240A
 vIoKN
X-Gm-Gg: ASbGncvtc9CDloGF3bdeNdz+MFZUhU0EvxEvqI0JchNXaN4RvroXuwZqO+rrJpP8ZD2
 LdjGDPzb+vA8y2t+aoXAy5FzXknhBZNMjMjVQHHAJb1EcLLbyFC4zLBp92nPsGt5Te2bVrV4HaK
 ygsqkKcINS/5V5T/aOXwj4xysbSnMWdfP4BIk7Nk8q1/5wRMPuZxyh4dKYLJhZpjbaepbzdX4kx
 fllLxkpDi7P9MLwYP991zDzrl7fS9J9V1d28accTFyv1IxMkFIA0cWbCbgProU7rx7kLZTjK1Bo
 1UdbHD8X+LsCPaI5pbvLnIvvpsONK/eO5f4E49Fywttf7AnfMY3Z5gdIP/YoCzdIvdQtyp1LZhv
 2uoOerkTCWzfr+d1uaN9H91C/wwDbLg/BGnhi/n74c5DQG8msitGqHSkijxlm6MFdtRhOw00+He
 s0G88WUcuYdbkTPO+liRPiydXbLYEZgJiteh2u3GaZw3mAIQ4f2g==
X-Google-Smtp-Source: AGHT+IHMzzYlPCMLCftHKBfAccLEckPk11DfPfnvA/zh8Pc+v2zqx1zES82sJHl8yxlv9EZZoO2kSw==
X-Received: by 2002:a05:7022:224:b0:11a:3b88:f756 with SMTP id
 a92af1059eb24-11b4131087cmr2367672c88.19.1763235254899; 
 Sat, 15 Nov 2025 11:34:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm26588644c88.7.2025.11.15.11.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:34:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 2/4] test: increase size of memzone name
Date: Sat, 15 Nov 2025 11:33:08 -0800
Message-ID: <20251115193409.99740-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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

