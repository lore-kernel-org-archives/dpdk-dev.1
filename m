Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B401606A331
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UNRXlJ+/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C51F402DE;
	Fri, 13 Nov 2026 20:44:39 +0100 (CET)
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com
 [209.85.222.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 11888402DC
 for <dev@dpdk.org>; Fri, 13 Nov 2026 20:44:38 +0100 (CET)
Received: by mail-qk1-f227.google.com with SMTP id
 af79cd13be357-9495d543b91so35844185a.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599077; x=1795203877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tqkuM9DUeRcFQmERM0sK35K+86gxvQ5tLGhBJlE7EpM=;
 b=qi+/pu+cwbC1sIz9ZFaXaiY00tgP48+9L+NM+PlAu65zfX3IEfEwlC64emDJNEfh1q
 zHyQXmb9YetxRZezPG8CUFY9RRlsMeT+VFONlEAeME3d2Rducw+/d5c/bv4irv6/6hVo
 1XCIFIMUN7F0RnBsAXzB/RXjV3MUtmiY4UQStS9ZO9HsXK/cd75hytwZZOsgWiF4thor
 TxHIAdewEuBJ/DTdLnXaQN+wmoq6LzbvgOyzI+r01uJSJAW4SVlEjGYDx/2c2NDr1iuc
 GULGX36UpMqBrBGouA0V7jGHClNrwmLwfisOn+j0wUba6UuL6B6WssNvZZiptwTFfD75
 cmNQ==
X-Gm-Message-State: APuU4Z9xYleZ5yazZfNCJuKAXeXoplafLkgzpPw/iTm368qvM4ULVRB5
 kvCYhQz5DRI13rOhle191GBi8XZWkzvyroaCcxtviuFDl1b1tpBfjvykXaNsgyWVoyfgg2tlYgR
 A9Ly5skfibEk41XjmKqz2JJE1PvkTczUiBd81USlexA+wLgSS01tJ7BhvfxxjtmSiJ9Fo1l1Xh+
 zkVpSNxDU7AbcdMsR5YXTITX38Dlj75CdLqGfWPiIRs0yAwP0pudt97MFIl4DisIHdWqM/Mc1w+
 d8KsA==
X-Gm-Gg: AYBFou0zRBGrYPvqSoyo6SAyprHBDGa5RhT3CCNzwuy4fAi809kAtatA2lNsyF5klOh
 yPr28Fpx5ZjDR31lP7avxh2dVOF26woia1qzCKP9IaTk5rxZKH/KZrjEaTmwHQxXUnGFvyMR8Dt
 h6HzSSNdVyxSTJD8sQFxoUyRI3iAUyuZFcM8jIlea0NDcGpeM0GZFE3V/HhkPWdAhGalZQmEDI3
 hxfPfpCFF97hJa64XAWpSXWRBveeZDQpyJMcem0jXaWOxCCIBFLKPWTTMYSvFVdk18CGj9pjVix
 OQqLotToOntrCCvwW8IMphfm3ZVnuxQ1fCmgZ3imUJYhq0F8lTgqdTSeDFxdSH4O/Nc+6XYs556
 PG5dpnwytdRmRXCd7ni/R95alULrhA36mCbFIShgrb8ryuNlnUKB+8ulD0Vv1wYSurbKTHiHmKw
 L5DvB7fAaIffRuNPU0Vyf3DuiF5TgGxhH2ifE2ozqadj4=
X-Received: by 2002:a05:620a:1a25:b0:93f:102:566 with SMTP id
 af79cd13be357-9494bc92986mr581523185a.67.1794599076779; 
 Fri, 13 Nov 2026 11:44:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-9494c3b5f26sm71211885a.0.2026.11.13.11.44.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 11:44:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-947a607ec40so135117685a.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794599075; x=1795203875; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tqkuM9DUeRcFQmERM0sK35K+86gxvQ5tLGhBJlE7EpM=;
 b=UNRXlJ+/2EyfW586yoUVThUa5wYVolcQTAM8j2FL+45cgacpy6lTKZv3GRGJbTqTUb
 QnEWrIH4t5YirGco0j4yMC41/cojB4RCsx21UZ6fH8ARjqu8w4thteR3QNEeZuVqwmTh
 4nZQMiEcvaeqFizgu4GhfMfOB4ZFfEpWmULrw=
X-Received: by 2002:a05:620a:2b94:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-9494bbe9de6mr602442885a.41.1794599075326; 
 Fri, 13 Nov 2026 11:44:35 -0800 (PST)
X-Received: by 2002:a05:620a:2b94:b0:93c:b33a:5ee0 with SMTP id
 af79cd13be357-9494bbe9de6mr602439585a.41.1794599074747; 
 Fri, 13 Nov 2026 11:44:34 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870f31sm257145185a.27.2026.11.13.11.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:44:33 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 2/3] app/testpmd: remove mbuf cache size limit
Date: Fri, 13 Nov 2026 14:44:27 -0500
Message-ID: <20261113194428.1954550-2-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
References: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The mempool library no longer limits the cache size to
RTE_MEMPOOL_CACHE_MAX_SIZE, but the --mbcache option still rejected
values above it.

Limit the option to the range of the variable holding the value
instead. A cache size larger than the number of mbufs in the pool is
still rejected by the mempool library when the pool is created.

Update the user guide accordingly, and correct the documented default
value, which is 250.

Fixes: b815acfdfc48 ("mempool: remove cache size limit")
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Morten Brorup <mb@smartsharesystems.com>
---
v2:
* Documented the value 65535 instead of UINT16_MAX.
* Corrected the documented default value of --mbcache to 250.

 app/test-pmd/parameters.c             | 5 ++---
 doc/guides/testpmd_app_ug/run_app.rst | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 34a4f74e636b..9967e49881c5 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1455,13 +1455,12 @@ launch_args_parse(int argc, char** argv)
 			break;
 		case TESTPMD_OPT_MBCACHE_NUM:
 			n = atoi(optarg);
-			if ((n >= 0) &&
-					(n <= RTE_MEMPOOL_CACHE_MAX_SIZE))
+			if ((n >= 0) && (n <= UINT16_MAX))
 				mb_mempool_cache = (uint16_t) n;
 			else
 				rte_exit(EXIT_FAILURE,
 					"mbcache must be >= 0 and <= %d\n",
-					RTE_MEMPOOL_CACHE_MAX_SIZE);
+					UINT16_MAX);
 			break;
 		case TESTPMD_OPT_TXFREET_NUM:
 			n = atoi(optarg);
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index e34e414ce246..7931d8082dbc 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -315,8 +315,8 @@ The command line options are:
 
 *   ``--mbcache=N``
 
-    Set the cache of mbuf memory pools to N, where 0 <= N <= 512.
-    The default value is 16.
+    Set the cache of mbuf memory pools to N, where 0 <= N <= 65535.
+    The default value is 250.
 
 *   ``--rxpt=N``
 
-- 
2.54.0

