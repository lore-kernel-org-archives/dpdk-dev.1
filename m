Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D0CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50D1C4067A;
	Fri, 29 May 2026 19:14:28 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id EE36340672
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:25 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-137335bc3caso5681425c88.0
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074865;
 x=1780679665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NqXynDJa2q0wrHPGcOPdFvaSk0p4kN6lqT8YZ2RAvM=;
 b=HD8w9ugwk5lTB4nguEJAr2zWGEyVPvdnDAHebzRtdZYr8hASXlD04gkD+ARZC4rVvA
 qEJl3mqqo18m0EqhLlMZsu7E7PnJOdYHARgDcNKlf574Q51ILEnf48VD19Ye1XUixZLp
 tS2vUMG7Cc2YTSOTU4m+i38PcNYTTuvom/M9nd9qEXHq1sQiW3BKFCzzHaZEZDQbUAyn
 MSm8i1FDQfZnOXEbr1Ocll3fS+itcj8ywyZLWnWzSoX9WQgS2+oSSxKiMWDXWh+HgEWw
 NJppyvwkbGP8RXrxvrPO3FXt0BCMeFfknG+YjWfxlGMhT6qu8Nlr9iBFvP9TMfL4RG/Q
 duHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074865; x=1780679665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1NqXynDJa2q0wrHPGcOPdFvaSk0p4kN6lqT8YZ2RAvM=;
 b=MQnZBVYSlSb0Y3Cm1jK3GUbBGnFZKjGgFKR1vaBfTptYa917rSbvmAwY19Inq+dLC4
 2IfbyDKieOCp5iOPuC0COZYW3GPC8Oa8aj+ra6LWQCxbJPSnhk4yJ+XsW9yv+9y8DurY
 4Az6klNUkbTD842711eP//5hphSAFn/JwZZRnUnohgr4hFpjUlC2ICkX8dtslhZ2+yrI
 YIifbRHmYuIuaNc4nKlZw66Wu/vwcKXTi/s5PFTZBXEwZeTDvaqYFl6U9wrUQ6e2mQUK
 yyxV/oMMWi/2YilHZ2hlfBmYmgdGgBHDvXSXte1lQacHaMs9u2Yzz3tnk+k0lBIyhNXX
 6N1Q==
X-Gm-Message-State: AOJu0YxL9fc9mTwMigzfz6nEWJW7VDoxZhgzALMtXBGrAumWLkxtamg3
 izOkt1CYr8FfVRKDsMw0OMDOiVN0uAAtaCiSdzY4a1Ab9qPb9ifBxpz2S7Ab9B5O9sd04l0cdFe
 2ohx5
X-Gm-Gg: Acq92OFvZYfusDHj0pa+wrLSFGdPi+cIbryms9hnPDOfdVFuk7oJ6uVxYFeyjT6XSF3
 etQw9UDP2RFxZLvkYKD8dIH5W5OLySdRY/eWgj/FFozinH9LOtqWwQAX6nTvjOKy6BBVYr2iOLW
 o9WI7HUNu4z6uGsh1J51WhEuhKMD8gnKELssHt9p9x9RBnRy5nvZh0Z27oxWq4RySZurARYP2PF
 h9k/4eFa5aQdCcqlJH2PhHVwMj6a9dQgBWMUPOxoIxutMjaHCdQpFAlDayxWs8dUQSV3UAGNh0Z
 3+qBZPRhwrGSWSu4PzdJnthiOcys77ppS+pb6AMzA+uNA3cakJmVJ9Df3yRygrIsLB6ulRJhfdn
 D6aydfcOyTQYCqeVFZjU89JdevciEbR7uHPtwsTev4ZAZbQXaI3lhbq5wD7V9YYMeAyc4BRjsK+
 +2/e8Lw4QvkSj6nLLg2L8jkkaoSgrOpHrrWkFQN8SSQo5QEGf32TbCCDbtd/Nz/czO555GHGIs
X-Received: by 2002:a05:7300:2d09:b0:304:ccdd:594a with SMTP id
 5a478bee46e88-304fa4b7e6dmr371670eec.5.1780074864847; 
 Fri, 29 May 2026 10:14:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 4/7] app/test/mempool_perf: drop constant-values replay
Date: Fri, 29 May 2026 10:10:57 -0700
Message-ID: <20260529171417.526892-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

The second nested matrix replays each (n_get_bulk == n_put_bulk)
point with use_constant_values=1 to exercise the compile-time
constant bulk-size paths in test_loop().  This roughly doubles the
work for the get/put diagonal at every n_keep without adding new
signal: the cycles/op result for a constant bulk is interesting in
isolated inlining studies, not in routine regression sweeps.

Drop the replay.  The use_constant_values switch and its branches
in test_loop() are retained for now since they are exercised by
hand in any local benchmarking.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mempool_perf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index 19591ad0c9..dd2f0bbaca 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -423,14 +423,6 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 				ret = launch_cores(mp, cores);
 				if (ret < 0)
 					return -1;
-
-				/* replay test with constant values */
-				if (n_get_bulk == n_put_bulk) {
-					use_constant_values = 1;
-					ret = launch_cores(mp, cores);
-					if (ret < 0)
-						return -1;
-				}
 			}
 		}
 	}
-- 
2.53.0

