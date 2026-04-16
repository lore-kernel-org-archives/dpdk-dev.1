Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BCFB44C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D5940650;
	Fri, 24 Apr 2026 09:05:50 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 6520840144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 13:14:45 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso128689055e9.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776338085; x=1776942885; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Da8JNQKc/HItfX0QACykx0Q4t5I+k3pF8ypRNlb7hDE=;
 b=BM4hATcEhg2COojv4NC/3mVb2CPqrUA0vBsVmRopuLiGTz8RXpAKfXsW3jhFI2zShe
 W1GfPHnngJuP+i0BYO6AjIynZzSY+vkWxOtPv/tgV8OSuKsm5DnqgAdbv1lRYnnF0p53
 K69U2SrzgmKiMQYtXiOfYe566mRAswNFgcZ2LlbHT1O5YDXeaCWRd5c4aKuCuk87Nr5q
 EbaAjQVHJsPxI4Npg8TJZwC6aqsfa91duvzXiPBCFCM+dB+d1ajoPLRg1XqBejQZg4Pi
 thkOwSYcdBDYw8q8uIVKYI/Kc0yLXjL/iLpqgAFnWGVnM98fgpfTt+EkUOTcgxwRVoWK
 yT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776338085; x=1776942885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da8JNQKc/HItfX0QACykx0Q4t5I+k3pF8ypRNlb7hDE=;
 b=bU8+nLBggACcGGlFgRMI6NzynFioW9FRFuDUMhvaisGCSlU1ETBd+LxEAqa+aorQLL
 GtMU2abnOXRo9vHddtcxCBavu9RuPs4fojwm0cJqWNjWZwre5T6MxpJI/DDGHx3w4776
 U/1fIsEg1DrLBkwWCdzEfUw451d3Sa/wia003X2dKo0x1EOnjN+cqK9G7FHnEPKaabX9
 2Sraeddf+WGo67O8idrgeKgokAQzeZ66xvIkP2aqxzRUTVv3AAP41wwtBzfHd+63Xuu0
 7JfxT0ntx2KNgeYE9UXUgjIJn+Cs3YTipyP2YVXr8TUfMOt9cQlscEXWTVRzi8UPEm38
 wxYw==
X-Gm-Message-State: AOJu0YxnJAcNdRkUQeFHyBKF86EqIaNeXkxDYzYoGSfuMilEJW6FpG9P
 mskkX+nBdtiGjs5XlT2chgkssl8zsypmlKf6SdpnRBNFCqCl0+jx+6uc
X-Gm-Gg: AeBDieugTIS63U8hL0WSAqutFTUbNaz9NadGW7hWUIg+FG2FeCZVNR2Ca2opt1vD7sd
 bf61ITQXVGzWwqDJu2wbid6qPql1duVefGWnCKWjXmK4MUAA0QDL5kwLZuRssQt2PLRW2Ll2Tt+
 m3K9H6dRvIppJnlQjguh/PsaoAb1tVbmpLHOc/Ouew+wNEbLjoyFnBKMpi9Fyw93va6of0BzgpS
 DMi03NQQUTj6E2WvxHogc5DWPOZGdsjdllYg7/RCnG2g1ls/PcrwRBpGORlNY4vq9BAYJqoGlIx
 5HmecBZYUb140uaT4YXYB0llMwmZ++fY3ShO42+B20fqncHqHwR/hRBoHypNlGwErU9Kx708wkM
 kUc9sislM/zFntjGzEZfMi5vGyq/3KR+EQh8o0kKh0LEHqmjpFMPL0R6qdG2cE8Z/AF7VN2Yzz/
 tg2c7W+sBLIk+MJ6HNLQFe/Kct/jJOxRfoPbeCHDPyoRLwag==
X-Received: by 2002:a05:6000:144b:b0:43d:7531:5ca7 with SMTP id
 ffacd0b85a97d-43d75315de3mr27160214f8f.38.1776338084706; 
 Thu, 16 Apr 2026 04:14:44 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead35c026sm12743886f8f.15.2026.04.16.04.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:14:44 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] power: fix off-by-one in uncore env bounds check
Date: Thu, 16 Apr 2026 14:11:56 +0300
Message-ID: <20260416111156.53750-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

