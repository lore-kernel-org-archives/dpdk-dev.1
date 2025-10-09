Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20646CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:01:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56B834065A;
	Thu,  9 Oct 2025 15:01:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E1DCC40267;
 Thu,  9 Oct 2025 15:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014870; x=1791550870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=erZ0eyXOnPv7evwiThB/sN+SIijR/RP5Veyfshy4UfE=;
 b=kahhuZ2yAqpsxZRqZWsZ+oZM7sCRrBr5f5f0fRD1BqfwJ2UfluRNP14y
 maVZCR0JzRiHljCvjwKv5Huo7Bs6nZGZnnx8OwpzFBbSMtbJH8QTG05Mx
 SgAQQ225ARziQ/6h2KnKKb2qqwVXUrgI+SklGeT4oCCUxovGycKpndqWF
 O6ntbTflBc3xMrilkVnMSdVWfUhg353fTACw31GQLtEj7KgYu1SZPCL9U
 qUhXeJuC3qRDblEtIpee3yphc31gqq3qLrxnOMnfUpjsXhmYhuqQpMgjX
 aQqxFZM0rwWH51uDTGEKjwZvnhJxS77EWX2zTh9xIvpCYbd+pcey+8/qC w==;
X-CSE-ConnectionGUID: EWzLAFYcSTGXswk31RAbIQ==
X-CSE-MsgGUID: GfSAMYqHQMu7F6ujrLdavA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663047"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663047"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:09 -0700
X-CSE-ConnectionGUID: 43lbODACTlKn3E9MWAJ4rQ==
X-CSE-MsgGUID: 4LXO53gzRWCRVZHJE5eEPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951571"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v11 02/21] test/func_reentrancy: fix args to EAL init call
Date: Thu,  9 Oct 2025 14:00:37 +0100
Message-ID: <20251009130056.2630343-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

The unit test for EAL init was passing in a NULL argv[0] value which is
invalid. Update to have a valid string for argv[0].

Fixes: 104a92bd026f ("app: add reentrancy tests")
Fixes: 978ead0144c1 ("test/func_reentrancy: fix EAL init call")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_func_reentrancy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index f4c6cbc548..51e3069611 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -66,10 +66,11 @@ static RTE_ATOMIC(uint32_t) synchro;
  * rte_eal_init only init once
  */
 static int
-test_eal_init_once(void *arg)
+test_eal_init_once(__rte_unused void *arg)
 {
+	char appname[] = __FILE__;
 	unsigned lcore_self =  rte_lcore_id();
-	char *argv[] = { arg, NULL };
+	char *argv[] = { appname, NULL };
 
 	WAIT_SYNCHRO_FOR_WORKERS();
 
-- 
2.48.1

