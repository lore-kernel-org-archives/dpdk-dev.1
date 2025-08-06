Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCB2402C6;
	Wed,  6 Aug 2025 15:38:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id BACF7400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754487523; x=1786023523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jcKCPck50GN8EtLFpxeQcPm5+QlyivbGBt0t+F5n+XA=;
 b=aZqOGeJcpDPsqCx+gst3wkmeyl5aH8OKyqQFpQU3VEeqUMUS2hWQ48kJ
 /fbXDNJLU/wlFyFFe4biXap++IImsaIq9WU3BzAVYfOAL3KNierd41e4M
 12fSrzZNk/xjbEjkBw7lH6tDKOVumWIhqWOdr5OhFHUQsQTMaFPn22xkm
 6jYdrxYjchcWWBBHemmpKegqXTtcxDs4tAIiGsKJBYBgFC+tCZScEhVVm
 H6YT9hH69IP57Gmei3GH4JwZyVEuKuKGOQH5opmYwnCWKCUtNmngK5Dlh
 TiVl8NyJvRJmBoI3NMkINYhd+b8eJWQ+UmfwCiqune1+BJCPK0FiXeqVG w==;
X-CSE-ConnectionGUID: sqxSdqGQS1yzmxdsVggPWA==
X-CSE-MsgGUID: PcSYq+TqQVOus/TmQO9JWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56769212"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="56769212"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:38:43 -0700
X-CSE-ConnectionGUID: F9GbqyUpSMWjMcUV+Uw5tA==
X-CSE-MsgGUID: 80B/Qo2lTNSRs106Qo9S1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="201942366"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 06:38:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/3] eal: use common basename function
Date: Wed,  6 Aug 2025 13:38:32 +0000
Message-ID: <20250806133833.3236170-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806133833.3236170-1-bruce.richardson@intel.com>
References: <20250806133833.3236170-1-bruce.richardson@intel.com>
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

Use the new "rte_basename" function which has common behaviour on all
supported platforms. As extra benefit, it removes the need for
recreating the socket path twice, since rte_basename guarantees not
to modify its argument.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_proc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 0dea787e38..62fd4ba88f 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -625,10 +625,7 @@ rte_mp_channel_init(void)
 
 	/* create filter path */
 	create_socket_path("*", path, sizeof(path));
-	strlcpy(mp_filter, basename(path), sizeof(mp_filter));
-
-	/* path may have been modified, so recreate it */
-	create_socket_path("*", path, sizeof(path));
+	rte_basename(path, mp_filter, sizeof(mp_filter));
 	strlcpy(mp_dir_path, dirname(path), sizeof(mp_dir_path));
 
 	/* lock the directory */
-- 
2.48.1

