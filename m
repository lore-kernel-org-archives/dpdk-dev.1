Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85156606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NAqkwptB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E437A40297;
	Wed, 11 Nov 2026 12:14:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 505D24026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 12:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794395672; x=1825931672;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wB1XQy/2+sFKa9s1HLK35iVJqVLwBpHVYMJ/bTV0UJ4=;
 b=NAqkwptB4MBLJsGfJ9lRIy8SghvNN/8b3RIpc9RwJlDVjrnKCWO7Fd1j
 r2dRt/J5Kd1/pQCh3QtsuumqJLxlT+0FAFZ0VcAa7TzQ9FuSu1BHXf2d5
 6i7PWSx2OqbnBMQ/FhsD46Sf7bNysUfar8vAaIWORcFae7tWbt17CdBaD
 fn3KupCAj+3kW6+hYT+8Ra161W8Y+giTZZG4a4Zsm3hB+v0o7m6CSTm/K
 DNgTPJfE6bFikXMMqaMqOXBvqIWqrhEhq6fZH6UHza2X30ylDc+O/uYW/
 TKuZsKTBAssunCXjf+qSF/XorSrP82DnPw5r46/UKX//XUTNyZ/4O1sl1 w==;
X-CSE-ConnectionGUID: XDZBDQAbQuiXk2cJ+AoWCg==
X-CSE-MsgGUID: Vzq2gdQTRIiEcRJ0a5bPWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3208986"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3208986"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 03:14:29 -0800
X-CSE-ConnectionGUID: /2HUf4/mQeCyCJ6MhhLXPA==
X-CSE-MsgGUID: lU3WzSzcTGaIHHDc7tVssQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; d="scan'208";a="10186534"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa011.fm.intel.com with ESMTP; 11 Nov 2026 03:14:27 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] test/crypto: add check for device capability flag
Date: Wed, 11 Nov 2026 11:14:12 +0000
Message-ID: <20261111111412.3031042-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

Test cryptodev feature flags for operation chaining support.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index d8c64a13ae..5051ee7fae 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -8360,6 +8360,10 @@ test_mixed_auth_cipher(const struct mixed_cipher_auth_test_data *tdata,
 
 	uint64_t feat_flags = dev_info.feature_flags;
 
+	if (!(feat_flags & RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING)) {
+		printf("Device doesn't support operation chaining.\n");
+		return TEST_SKIPPED;
+	}
 	if (!(feat_flags & RTE_CRYPTODEV_FF_DIGEST_ENCRYPTED)) {
 		printf("Device doesn't support digest encrypted.\n");
 		return TEST_SKIPPED;
-- 
2.52.0

