Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F3D0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A74E540BA4;
	Tue, 25 Nov 2025 16:22:42 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 363A3402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:38 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-298250d7769so42130685ad.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084157;
 x=1764688957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=YXzNTdHCprSlOkccJd9+tOxB2/acsqgqQWyfFRaC+KREj6E6sqUG4GK8gS0OT83Do2
 2y8LeJFpib/t7U0NwNAjRnW8YqEt99eYyIMRxZ+RYQ28ElDEDnz+kvSEVSEnd1/KjM5a
 22zh+oFLFdZoeXktcox2PJDNw0YWxYrmA1ADSsDQuYmHa5qLnBdzoPduzokU++ds5Zkb
 Hdmg4MJSOs1+4HM/FS/AkglY8dA3yt7GMUXASCsShBRdjQ3vYlQVnDarWjwuYmtjSLpJ
 4ajMSKp3tE9r/Jwd1L68ZJabvsSP3NZgmA3JsCRf2bUGi4UCkJZuXXEsC7pxOlm72bYx
 69SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084157; x=1764688957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=ffe4E0pjLXzzAaxqrDvsK/zOra7f32U9e4ZV/3d+gNzpr663JGkHq2lB2ROwKJhuk/
 CiOnSe2ZlDduZCxEswWvRmY9JixnGZioLDJ7JvWc1RUYCXgH2SGWMjdErcGglH1/xG6i
 58bxlhF6g21vmKC+q+azKifKvi3jstLLko67XcXjDhYkw8ixAVpmKx6U0KPupo7LggBv
 gNvOFm6p0+/pIJWGDCLlyCygtkJm9+Ai7EhnGj8C7VdiSW0Ri+a3zNrhaW1kx1D8NXv0
 DyCUVaxr7zTJZhRSguo/Be6Y5lUJAVeQdoWKyi7gietNZkE5b3ENirKt1ZoTiQFN8oU3
 yPiw==
X-Gm-Message-State: AOJu0YxWwHwpLDBGsggbxNvGCiRNaYxwSQHEsxHNJtwXZ4QD6gByy6Xu
 EXv5RBlhtVJw5FOR2F7IRSPyjpPy17P9M3SDv6n6LSq9o5mgiWB7gkhct8GmamHAV78gQO+j65k
 VFQaa
X-Gm-Gg: ASbGncs+QkosCUxDsZv4qQESjIdhOjgKp6He5FBceJk5KMBF3oKiZJ09lnHzBKMbeSW
 OaoqlspeHyIXNxrfOkszQS5zp0cXVLCGAjirlHHrBVpKi1N3mR5XpKoxAoZEf9Ho54bp/Bo8ZNq
 01iuW5dk+4lreCeFkAMYAKXITVnVdo9eZIEMpR7AZcKpwwfE9nOFj6EhkhX3/bWz7OJA20IkoDG
 yW3q60x/IeEjPEyOx02X1fjnoLXY+yRRDZR5jQeuGfqFhyhxE4eAiKSO3FUzVB49xi5o2xXUsWz
 cxnmNIK4p3dMd+bRWpx1L/L3ObSbs7K8dhxp7GZF7/FlLnfiXxfC0hTDxRXf6SKGHA9mjeNoJ25
 hcSNCPe2C+fwRbsWeucpqChrnZufhaID4PCGhMER8o2oqSqBCvGL7xZ+RBHhDsAZAjc11pv0xCd
 orcJVbTff37xAa6sVU2a991sIx3D31bswcAErWyNPO98w3VCnZis6uToSIP0+c
X-Google-Smtp-Source: AGHT+IHZhe7X9fce+b70xVRgvfHIjCoiqauhm0ICoF8wWiaWbEoMzdipYnhKrMd4kJ4Kd2xerO1Fqg==
X-Received: by 2002:a17:902:f547:b0:294:ccc6:ccfd with SMTP id
 d9443c01a7336-29b6c50c6eamr196487385ad.24.1764084157331; 
 Tue, 25 Nov 2025 07:22:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 01/10] test: increase size of memzone name
Date: Tue, 25 Nov 2025 07:20:51 -0800
Message-ID: <20251125152232.73528-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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

