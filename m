Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E9D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7365540E24;
	Tue, 20 Jan 2026 12:26:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 234E440E27
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768908386; x=1800444386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rzZLq3Ysq1uhCUuuf4bVFFqDyuVsbuma6lWYDxvzl1Y=;
 b=KhSWi+/1OBWBmr/XeL6JIR4fpEL/sR0znY+hFKDh/tMAU1/7UOtUnoaH
 kNMFjyrb1pICHMb7zyHuUMr8rMAeBe/p9rd1hNsIogMHedx9bP6NGzCis
 yrHwRnMNHmHJU0TfXSPGlRSPDFX/Eh73g1NLeYYA90r2L0OBTGeFhGar2
 KEFLcUKxO3NRy9wSCcZ8jdzG8xAdDDs0D+PwLU+31oi+XF5vML1GhsXr8
 sPrdwrhyUn2pYS+qnNTFQgV4KUyL0zFpztoydZLdazxfOGwuqzW1TPviF
 26ZMsxZPgyr/6AY50D1gXXcljBnXU85tGpvlG4k85/JYKPEyss0YDznjN Q==;
X-CSE-ConnectionGUID: 0ZPsrz77Qymnz9HCpUiXDA==
X-CSE-MsgGUID: P79Qz9SuREe5GbeExgpjnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69314497"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="69314497"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 03:26:26 -0800
X-CSE-ConnectionGUID: LLVOXqnlQQeN+3ebENVdzA==
X-CSE-MsgGUID: bu1toGuRSK2E9ijc/jkPnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205253411"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 20 Jan 2026 03:26:25 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] test/eal_flags: add extra logging for file prefix tests
Date: Tue, 20 Jan 2026 11:25:52 +0000
Message-ID: <20260120112552.921243-4-bruce.richardson@intel.com>
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

Add some additional logging about what files are being matched, locked
or deleted as part of the unit tests. This could help with debugging any
issues with the tests.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_flags.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index aa70f11434..f54b770ae3 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -214,6 +214,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 			case HUGEPAGE_CHECK_EXISTS:
 				{
 					/* file exists, return */
+					printf("Hugepage file %s/%s exists, matching prefix %s\n",
+							hugedir, dirent->d_name, hugefile_prefix);
 					closedir(hugepage_dir);
 					result = 1;
 					goto end;
@@ -236,6 +238,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 						result = -1;
 						goto end;
 					}
+					printf("Deleted hugepage file %s\n", file_path);
 					result = 1;
 				}
 				break;
@@ -269,6 +272,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 						goto end;
 					}
 					result = 1;
+					printf("Hugepage file %s/%s is locked\n",
+						hugedir, dirent->d_name);
 					close(fd);
 				}
 				break;
-- 
2.51.0

