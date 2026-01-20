Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC57D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1280E40E16;
	Tue, 20 Jan 2026 12:26:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 16A0E40E16
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768908380; x=1800444380;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m6M+SVDFRksKF7vdVEqCbLJ5EScM/IUMbgviPOj5eoU=;
 b=R8s7Fb7oQUDbfdC+fZkc7ji29U7HQC4vyv5Qqb632epizZOI3xFf8K+T
 DrqBZ9VRxxhERKlQE7AE/E/kIcCShWGxrc56cq8OPzJjLEK4mhQh0tD+h
 RL5fAYMhArhqWk7INuDRbMC4g+j4LxK5eZsJneAlWnFptXr7McA0MsB+u
 9KIwzef73yonHkQCxaSTeV3iDlWZ7AY1V9FzXhygYc3pgPOXKbvv/ifd9
 bIgFfW0M6F0Lq5Zij0tdZm/qZdjtOMNtWneh+Xhh7zCzj2YgNrzZsjrUE
 0p+3C0JCk+YldNQ8WU9KsqfQHVXwcaYNwdoRdMp129fcTeeShS2hVVoH/ g==;
X-CSE-ConnectionGUID: qy00bae8S0G2DWmPQHUfmg==
X-CSE-MsgGUID: PjCGydhRQLS9Qn7W6FkzHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69314494"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="69314494"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 03:26:20 -0800
X-CSE-ConnectionGUID: t9+z9AOcS5q8JYfQNmwoSQ==
X-CSE-MsgGUID: raJ8s8U2QdWM/5m5twn5Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205253394"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 20 Jan 2026 03:26:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] app/test: add extra logging for recursive calls
Date: Tue, 20 Jan 2026 11:25:50 +0000
Message-ID: <20260120112552.921243-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120112552.921243-1-bruce.richardson@intel.com>
References: <20260120112552.921243-1-bruce.richardson@intel.com>
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

When the test binary calls itself recursively e.g. when testing
multi-process, print out a few extra details on what is being done and
returned to help with debugging in case of any issues. As part of this,
if rte_eal_init ever fails, explicitly print out the failure code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 8a4598baee..58ef52f312 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -92,8 +92,13 @@ do_recursive_call(void)
 	if (recursive_call == NULL)
 		return -1;
 	for (i = 0; i < RTE_DIM(actions); i++) {
-		if (strcmp(actions[i].env_var, recursive_call) == 0)
-			return (actions[i].action_fn)();
+		if (strcmp(actions[i].env_var, recursive_call) == 0) {
+			printf("Calling recursive action for %s\n", recursive_call);
+			int ret = actions[i].action_fn();
+			printf("Returned from recursive action for %s with %d\n",
+					recursive_call, ret);
+			return ret;
+		}
 	}
 	printf("ERROR - missing action to take for %s\n", recursive_call);
 	return -1;
@@ -146,6 +151,7 @@ main(int argc, char **argv)
 	} else
 		ret = rte_eal_init(argc, argv);
 	if (ret < 0) {
+		printf("Error with EAL initialization, ret = %d\n", ret);
 		ret = -1;
 		goto out;
 	}
@@ -259,10 +265,14 @@ main(int argc, char **argv)
 	ret = 0;
 
 out:
+	if (recursive_call != NULL)
+		printf("Cleaning up %s recursive instance\n", argv[0]);
 #ifdef RTE_LIB_TIMER
 	rte_timer_subsystem_finalize();
 #endif
 	rte_eal_cleanup();
+	if (recursive_call != NULL)
+		printf("%s recursive instance returning %d\n", argv[0], ret);
 	return ret;
 }
 
-- 
2.51.0

