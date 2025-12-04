Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D313DD29FAB
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97CE240A6B;
	Thu,  4 Dec 2025 19:21:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A986740697
 for <dev@dpdk.org>; Thu,  4 Dec 2025 19:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872468; x=1796408468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w/7zeUoZ7mCFB1NxfN987xebHZYmo2YGUzh06uRCiPs=;
 b=K8to+BVRqCuEdKr5VTCxamCoCPJGKAeBmh4vEO1dMoHeL2W2HHm2STjr
 CDGkCXaBEvhDEXl85lp8TbpEKQ/ZlhfycBikTGaZdQXRivTkIMcieeUb3
 72V+XL8ME/Vd5t7azC7sNfDpjYoLS/Uf+ANiQhTPm48b9Ka86Z1tuMWx6
 C7BEg8eg/jXR8nzGykvkmhJNf2czdpakJCrS3lpX3c/KX8BnX8L7J9UKq
 VOiYXDWy1hJSYyDoZR0wH53YydUFYtIceF66vj9cZcjrEaOa1DD13nx4k
 OeyjrSINMxWzxvIjExJpaW1jlarXQKF+bhGE0H0mbOefQ9XxvugGWSE4I Q==;
X-CSE-ConnectionGUID: ZblycHz+TzCC+FOk1N3oJw==
X-CSE-MsgGUID: fQmJOAL2QP2aDZzKL8Nwew==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013031"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:07 -0800
X-CSE-ConnectionGUID: ZWBATtaBSLekXWzjX/QoBw==
X-CSE-MsgGUID: 6bAGeVu5QGOEb79oAAnlqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423187"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 07/10] app/test: skip power capabilities test if unsupported
Date: Thu,  4 Dec 2025 18:20:44 +0000
Message-ID: <20251204182047.3154429-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

If the power subsystem cannot be initialized e.g. due to not being root,
skip the capabilities test, rather than failing it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_power_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 96de255f27..1d37b18fed 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -661,7 +661,7 @@ test_power_caps(void)
 			"correctly(APCI cpufreq) or operating in another valid "
 			"Power management environment\n", TEST_POWER_LCORE_ID);
 		rte_power_unset_env();
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	ret = rte_power_get_capabilities(TEST_POWER_LCORE_ID, &caps);
-- 
2.51.0

