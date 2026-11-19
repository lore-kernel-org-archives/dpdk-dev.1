Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378D606A334
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g2e8C8rR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87225402F2;
	Thu, 19 Nov 2026 11:41:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 80D79402EA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 11:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795084906; x=1826620906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j0fkFW29aKjV2w2Sws/9gpXpZpgY4e52Nex2sC1ft6g=;
 b=g2e8C8rR8ZFdw0n+zD5hTqcdqpqetHK0ZGmHB4W/uPDBfbkVgoKfW/BR
 E01uIxjnw359ndk8GhxxtygMbP3xfkrmpMS0MPLJCYEVfNpUxOqwB5chD
 DFaOS0MXH8Da2VAMhyCH64p5XtYBA9/gwCko9fe6j7ruwBAQHC8+JrC39
 o1Sct7DaRVgdZA7f7kfMXUUGEQMAXNj7i26DQxQN3Xfy/r9r56d5v6jZQ
 lHM2yiSjowhnOCqGzdQBAANQctTBURfGA13SQC9t3EvwH2U3mzFk13vd/
 6udPGdNqCRgBgwxRu67n3d3tdX14rx7zW2TcyoYbGYI1XKe5Asnn4VjLX A==;
X-CSE-ConnectionGUID: +wpLsO+sRhWKd/opPYbq2g==
X-CSE-MsgGUID: mTdKpV16SCSj4kNZvjFGWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3825092"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3825092"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:45 -0800
X-CSE-ConnectionGUID: SqkXhWTTT4G3XrNd2oXbOg==
X-CSE-MsgGUID: p4JkCMwqQR6oX1N9Lkejnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10208881"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:41:44 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 2/3] updated ice latest recommended matching list
Date: Thu, 19 Nov 2026 18:34:07 +0800
Message-ID: <20261119103408.289005-3-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119103408.289005-1-hailinx.xu@intel.com>
References: <20261119103408.289005-1-hailinx.xu@intel.com>
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

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 5589ce934f..57e2c65169 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -61,6 +61,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 =====  =============  ===========  =========  ============  =======  =======
 DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830 FW
 =====  =============  ===========  =========  ============  =======  =======
+26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
 26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
 25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
 24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
-- 
2.34.1

