Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925DCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 04:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4922740431;
	Wed,  3 Jun 2026 06:22:27 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 7C6F0402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 06:22:26 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so28237925e9.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780460546; x=1781065346; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Da8JNQKc/HItfX0QACykx0Q4t5I+k3pF8ypRNlb7hDE=;
 b=A8nkwNz4Bb3zd6k6oCmJG2IcY6vXeGIIJLYGmXcU6G+xq2xSEo4cpy0KLDu41GeFSy
 p2DUyZQN0SIDdKZnMWXxc0isHJoPVUnaliNfVw1hByQyzyVyzUzLNwNnSJAuc+HAj7I1
 dwiqWsd8zSdH+gcBrheWYb9Cv3YUT2iPhcVwWyg3A5xCQkM3lwhlVtaj/tTBWWcNlX3s
 d7MphnBKEvIrmNE973OJO/Un6l8CE6t99Jn2egC2A1fwhWkNPNAdKo7rCiKkZVp8qSF5
 th6+BT7bAP8pAgVWtMRDcKxmhcNC4c4uZ9z22Q8Bujr1Wxmyhh4wNL16ZoNHizH0PZ6Q
 +Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780460546; x=1781065346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da8JNQKc/HItfX0QACykx0Q4t5I+k3pF8ypRNlb7hDE=;
 b=rKXR0BXUoUpZpF3j1nxkZevSB0G+NIGAzqd0850yCQUePPRnCH1kaFp3w0LoGXOi0r
 Uzci18hlLw822zUNIdJSxEgXo2C7XYdEsql1rbie3KI83KdLDlxrHtSNuE8eyX5/OX+s
 T+SIPiEM8c8i1tscxxM22niptAKFibLsNN3ELFfqkiIOypmk6HsqBDdnjXC090F+cSwB
 UcuCRpVueqf6SC1uFsaw4H9etsPNiAGBlo82cgYdyoj2f2dbp8o54M9xy6klWf0OoBFX
 87NP4DRYpX7Xd0HDyZdJWkLjuYLEzYCoKjuJ08cAjqLfgTw2FtOq2irdaCoNy/XYXMpY
 8ovg==
X-Gm-Message-State: AOJu0Yy2FPvKeUMrom3he4rrl4N2XAwts7a+LBKqoRHEmVy8llY+A9z2
 3jZXZiG9/sBQPviJ0KO41RIMWFaQLSjz2HFN0Ayxw1cDxZEmBPQa5tastrlnr+Sy
X-Gm-Gg: Acq92OHwu9UPg3qH/6dZii5JFIdU3yiDMgoSUYqVQS6yUdPtFh2xni8rxwBwI8maaNr
 tSCuyM7quvwprEWecB5BRpmizSQDAcbb0MM8XoIvaPFa027/wZSCY2xWeom/nSLoxPQiRSJSRoc
 Ess7upvBHN4ZO0pYPXOXIYbui97/IAJ+FAtvClpusr33vxwdZYPFnp5xj+wy/R/LIXDQgY5bamy
 ulxEuFyBeYTaOjYHtJDDNA+BV6obP7eH1hp5otLhCgxOs283Ens2neAN+8OoyyiIY8axcCJrvle
 KhudSWXQLF0XGTWNSRxu5C+4i1HG58/3R7hKfXI+iMbR6sQfuW+k/VYGUz/tghTibndZ58beFE6
 aUFhEyx9ERs6xGwPG9YSZbj+q1NZRyrtpQ3HbN70L38PI7Z0rvRXImk0zV/LDyjtk+Q4O1iDSF/
 BoY4ugtiPDjJToRnQmQ0ue6cgmFINAGcODk0vSUWjyLzy4MGg9rdYTre+C
X-Received: by 2002:a05:600c:5288:b0:490:b0f1:c27e with SMTP id
 5b1f17b1804b1-490b5ee1c64mr24199065e9.24.1780460546091; 
 Tue, 02 Jun 2026 21:22:26 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3529e0sm4406129f8f.28.2026.06.02.21.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 21:22:25 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, stable@dpdk.org,
 sdl.dpdk@linuxtesting.org, Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] power: fix off-by-one in uncore env bounds check
Date: Wed,  3 Jun 2026 07:21:53 +0300
Message-ID: <20260603042205.116191-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The condition in rte_power_set_uncore_env() uses '<=' instead of '<'
when comparing the env argument against the size of uncore_env_str[].
Since RTE_DIM(uncore_env_str) equals 4 and valid indices are 0..3,
a caller passing env=4 bypasses the guard and causes an out-of-bounds
read of uncore_env_str[4] at two sites within the same block.

Fix by replacing '<=' with '<', consistent with the correct pattern
already used in rte_power_uncore_init() in the same file.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ac1edcb6621a ("power: refactor uncore power management API")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 lib/power/rte_power_uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 25bdb113c5..b50e09a2ad 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -67,7 +67,7 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 		 */
 		env = RTE_UNCORE_PM_ENV_INTEL_UNCORE;
 
-	if (env <= RTE_DIM(uncore_env_str)) {
+	if (env < RTE_DIM(uncore_env_str)) {
 		RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
 			if (strncmp(ops->name, uncore_env_str[env],
 				RTE_POWER_UNCORE_DRIVER_NAMESZ) == 0) {
-- 
2.50.1

