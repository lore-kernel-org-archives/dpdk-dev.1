Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA26C88E4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 22:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 329664027A;
	Sat, 12 Sep 2026 00:58:55 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id C965B40275
 for <dev@dpdk.org>; Sat, 12 Sep 2026 00:58:53 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc4d03f95dfso763219a12.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789167533;
 x=1789772333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=enqAzNYEFf/5V5MaRW332cKsnSp02HNDlCKyoq8iw10=;
 b=dZ/devtsAoUMK+lKOv/paWFNn1FL6rFs4XQJmoTKPo6h/YQQfqG04pDH/RW4MXpDLH
 GSxMuUQjPUTX3It6KfFcEQsE+CiGiC3LASDb6aDJUxkNsZITIN9JTAOoLIx1V13YGpgy
 3sG7up7tQMP5MuAI6369eRYGRjh+Nk5p7weis1JZ88VlryWOYuF4RZWij2/b5sQ1jOUK
 0dbKT67AWzdU9RURwJJR5n1NNTO01BqZL4jq+tM3v/lW5OzzVcOANLV/1C8CxhWSJcnT
 aAIsLyKlnxkFQooNzMW/DS7vx1Vk8iSbe8tUME+3wQcMSD0rGpHtTmLz9S03raC0Emtc
 FsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789167533; x=1789772333;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=enqAzNYEFf/5V5MaRW332cKsnSp02HNDlCKyoq8iw10=;
 b=qBL0dzsIV1SL+Ovrtp1SmfWuWWZQaUhwsieGeNlqQcMej9oLONJ7nwgTjdXh8DX6Yy
 FVg1vfx6R7m3KHPuAChCj91K1CRZrqf6miD6kOq4+AZpVDgqWrWhjvsFlwkm0TFBDxkh
 JPZkIE2OZmGpwn/y7YVL2sHegc7/gtrSntfg1w61A4RLcXv5qUyWgo0qub5a2uoE2kFM
 Kp2yKpr6jEYEh1R9R6OAq9CmZXhmJ3RFWn1XS0WRgqBJ5+RaHnCfjqkqp4LCw3LiivMU
 JcTUMJQ+Iz/zt8fm0nImVSaoZRP75g2/o0q0J8PNyJgiJN4sfrsCfCQr7JVb3vvLQrAW
 9x8g==
X-Gm-Message-State: AFuF++m+OV6dwjh6XZLcaW6H3kClHvPB6DkzXWS1nKSz2l8AaLr1XL7q
 TY/dCfOFHbAyA5hYxp2Tek9+kdt3caGFpU6zdT5kGN1/dgLat0zxA6F2oVeKAMSN8dOvFmEfwlY
 9Dbn3
X-Gm-Gg: AYBFou2aTZNO9F9dYEkLROyS6ZXdGXridH6f1L956wqhECcZMtX8DuIRFKGRyRVnqCX
 xlPq+2YaIUFyBRITUEyThf8+Azs1dV7Dp8rGEb6eUr0KYyZVZnJwLQeMdBQuRGjTALecVd5Gwtl
 8IhOXH0suekPRcRpK/G74S/EUU0twZP6bIaY19RQFCeZkSGMBsjNTxcFTkJCaYGOGDsSmZZPYpN
 998vrftZ3PriTEIFJbOgNsBgQRFenMmfQEEsvmDMnABTJXhEhbJBHuwi8KixxKsfvSO1d28e54s
 mW/nMyclk/+ytjdS1ek8DQWPqULbDoPrkCgUM3LHMl2meUXMS89HV/O+JtP7i1WcNy8AdnpZgWz
 EtDaIh676Cxxg1fNEoVdYv3plvpxPOq163kGwNqEeTFQ2XHGl9UieoPsgkqjIkbg2vUdhWt7/nF
 HrUsWR1rzKfLisKwdgGmeu+82C5kFftSv2X1zHovwOkvqEgC6jq9oc6QOv7W1bNvqfBMoZuY2Kc
 0HP0zcpkxMhzsJgVQDL0XCaESQ9mUCkq/+Kyw==
X-Received: by 2002:a17:90b:3e50:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39d9c1d8f30mr11863473a91.16.1789167532568; 
 Fri, 11 Sep 2026 15:58:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95713602sm7032434a91.11.2026.09.11.15.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:58:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC] eal: allow setting random number generator seed
Date: Fri, 11 Sep 2026 15:58:45 -0700
Message-ID: <20260911225845.3168061-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Many performance tests use rte_rand() and the random number
can perturb the results. Add an ability to overide the automatic
random seed on DPDK startup.

This is not a security problem since rte_rand() is documented
as not being cryptographically secure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_random.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 576a32a46c..cdad60049b 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -247,7 +247,18 @@ eal_rand_init(void)
 
 	RTE_LCORE_VAR_ALLOC(rand_state);
 
-	seed = __rte_random_initial_seed();
+	const char *env = getenv("DPDK_RANDOM_SEED");
+	if (env != NULL && *env != '\0') {
+		char *end;
+
+		errno = 0;
+		seed = strtoull(env, &end, 0);
+		if (errno != 0 || *end != '\0')
+			rte_exit(EXIT_FAILURE,
+				 "invalid DPDK_RANDOM_SEED: %s\n", env);
+	} else {
+		seed = __rte_random_initial_seed();
+	}
 
 	rte_srand(seed);
 }
-- 
2.53.0

