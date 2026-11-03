Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6794606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kGGFtpJd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFDAF4067D;
	Tue,  3 Nov 2026 18:46:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id AF2C3400D6;
 Tue,  3 Nov 2026 18:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727973; x=1825263973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f0nULWUx4Mtwn/5c4Bdt9euIVIfCTVdrTxsyyf4LjO8=;
 b=kGGFtpJdeVrDTE9lYSely98ziz9+d7PzaInt8XCZGxKvjQGdqLBAOXdv
 S/5cGxiRhUunMSkTLguuqf4GxtN4Gys3wRBhhwcM8TjeINR8//z6jUYlk
 s3NRKF/nwX3oq6iHUMTd0HTFbec3Aq/Ut8xOEvV0ChQl1ryaDxVFGxHfE
 z4RRpX+fUQDq8BUNzqUle6AiTz9lGb/lmVYkLm4o9ElXMWXUQ2xUhM+CG
 0VJq60hEDgwXakw45XTM8QFN/yEP8B8Gvm/vWsQPM+2th+NoTHizpmNnh
 VcyMeig5XGCDFO4sFa8jx+CiMY+7tlDZVizDK9CgvzH14rjUP3eV49j7d Q==;
X-CSE-ConnectionGUID: p5euWt/jRguDmkFf7eKROw==
X-CSE-MsgGUID: 7OwcMqQHQXqnx9F4lXwzsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2353850"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2353850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:46:12 -0800
X-CSE-ConnectionGUID: dFEFUIEzQGa8LMqbP62NMA==
X-CSE-MsgGUID: uZVl9O1ETBOk7PNWCc0rpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="7014505"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 03 Nov 2026 09:46:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] usertools/dpdk-devbind: fix interface names on FreeBSD
Date: Tue,  3 Nov 2026 17:46:01 +0000
Message-ID: <20261103174601.3757534-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The interface names on BSD were queried from ifconfig on initial device
scan. Later calls to get additional details used the non-existent linux
paths to query the interface names and so cleared the values. Fix this
by ensuring the interface name gets assigned to the extra details on
BSD.

Fixes: 06d6605f7906 ("usertools/devbind: add basic FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-devbind.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 15b19acb27..e70bdc23b4 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -380,7 +380,11 @@ def get_device_details(devices_type):
         # get additional info and add it to existing data
         devices[d] = devices[d].copy()
         # No need to probe lspci
-        devices[d].update(get_pci_device_details(d, False).items())
+        details = get_pci_device_details(d, False)
+        if is_bsd:
+            # on BSD, interface name comes from ifconfig, not sysfs
+            details["Interface"] = devices[d].get("Interface", "")
+        devices[d].update(details.items())
 
         if is_linux and devices_type == 'net':
             for _if in ssh_if:
-- 
2.55.0

