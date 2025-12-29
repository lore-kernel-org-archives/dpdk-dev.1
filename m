Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D5E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4464740616;
	Mon, 29 Dec 2025 23:01:02 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 838654025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:00 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so1350168666b.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045660;
 x=1767650460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=rT6ucKqUIG0JmqfqBMotdCts5TFfX5oezC8k3sLfMeioaZ/J1gWCQ6JHADYUbCrFfM
 KOaCYt+mAdYBtE6pT4eoDdDcTklfJBLIKmrwmShJXF4qtazEQj1EWaLFAAuQ6EFBY41O
 i6n9zCnKudjgPBJUicAsVsYyy5R88ydzt9GdYOK+aQcbpvOSf9EM4/H3LFDdlwDC3scT
 PjpisRUpQeDbvwOxqbLbTQF4UQElDQcDR8A1nmWOCrAIjqiebJxzGp7+h97++QC1KAa/
 R2OUwlzOQiOcXK5P0Sm/7fGlb/DvCNtm3siLrMzXNFtfSqbDFQMcQxIZ70VuJ0HZZnjQ
 RE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045660; x=1767650460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=Nk4UzdDuZCFpQoXbt8RD+Riye7cPkbP8uQywDmXQx3JiVHCW/7UGu0Pxi5NdKaG7rQ
 9vssFMdXMcY03rd9UbBGWKU9zClW7GvibWOuXzlHyhheV5q6VhPgwe4fHgNZUwbabthz
 pv3eHTwYpAA+iKncF93EilNCMUPxq9J9rG3TSNg/kjfbvUSarYqy9vW2ZTC14uTUkMz4
 Y1Ve2Gwh8VMyRNgWGv0eKlEJ6sYiWNvxcdkfLTtxQ85VE5xuvvVfYbnwKxNfKhJ7UKm3
 yOfkhzdbjGWx4ejgMvFLdsbRXL8qETJdVLmeXenBCUwRJRztBAiEwF5XRQwjNTZXDA8C
 7qVQ==
X-Gm-Message-State: AOJu0YzsVoSi+PPYBS5nGOO8nDGff0RO8ARG2NFf2MNmM361NI9cjOg5
 wAZS8Aw0xS8YikVvdWBV7McimCoE+PF5lK7UYxouya4X8NWHNNaQzrnn7Re86gx3BGmHfHz+3Lt
 m1vxM8cw=
X-Gm-Gg: AY/fxX5BSU83sCVRDmiCkmRNQz13M8Z2pQPcg49wNunlv/USlhEyy4pX1UyTEEuWCJ0
 HBKg8b6AkmC3wqYG0E9cTT0XyntMPyoRvjwcYUCM1xqLYGn8pKaLOpv1LQFQ0IqakIb4HqXHbxX
 ZDZI7lGlNvh23Gkt9AqRg7qVXOd1be7RD5RhJxW1JFFUh4cISPi5hWcgljv3NO5oMOXiFDA2Uat
 VqrQOf+TOegVQ5W27G3t3z261pQFrf9Sy2Y+sgf34nqhJ/H3OHDDDLl4AfuRxoR0MPY40Pak/da
 eQYZDdFHLIbJv4+xFCHnXJgZ/ipMuUN0NpCMjwUcscJZwV8UTm33cyWN7PuIIEfjtVpbNDmRmFZ
 CoeCsirxML0tyObtOn2x/YKDIOZ5FuXaRfyR14cjjL4hl+EgdNlOUF0+FtLbvA5UNzfYB/a4j89
 dXpWbx/oCeTaaLVT02f6NSxTpZb//SfIU2fRiDP6iRlnuY/n6XTw==
X-Google-Smtp-Source: AGHT+IFRUvRzSzcHfxBY12E7phq1Qa1pP41d8KSJNF9lVroVOjhb73Wp5dDGoPN/enhJQPVx8kfc1g==
X-Received: by 2002:a17:907:7e85:b0:b76:4426:3a3a with SMTP id
 a640c23a62f3a-b803721e302mr2884629366b.58.1767045660069; 
 Mon, 29 Dec 2025 14:01:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:00:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v10 1/9] test: increase size of memzone name
Date: Mon, 29 Dec 2025 13:59:01 -0800
Message-ID: <20251229220053.21981-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

