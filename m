Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF86606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BAiGKsCd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD1EC40E64;
	Tue, 10 Nov 2026 15:29:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 1889340281;
 Tue, 10 Nov 2026 15:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794320940; x=1825856940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1f2bRTzeS6DONWUuJ7xqee6rtr9dV+vN04BUqhL4IHY=;
 b=BAiGKsCdVHn68CZmJXzmALHBbe08V+RqjIOmskiHHjusDx0z30MbQhxz
 VuPUBYvPqUZlOyCBj/ez/ZZIQXRDx0fQg6f4aVVq5bMr9+tBOsFe4kjWJ
 EMJuIMyq9TJUts3SVuNx3EoFFP9o1gyW70z24qThKgbtSISH8fOU9AVzr
 I5xzrTI8jhwuviNyOSt0L0HREgoWhPAevpzBJ1wD9iR942q+ssBZchqfi
 tcMr+F2A+H2iz+pwTt1NYsjIY0yNOiOwT99BgozI44YBZC0lGSNtJTxyh
 7uiaIiQfcHEJIdjvPJFdc9FQo4HQdXTT8yE8ae4xMqGwLWvoqsThlf+mv A==;
X-CSE-ConnectionGUID: +kkGK8eNRSaBLid46eodUw==
X-CSE-MsgGUID: YcYloSLyQOWONy0mnS0bBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2966603"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2966603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 06:28:52 -0800
X-CSE-ConnectionGUID: TWOWCfXpRFGa60SlICWU8Q==
X-CSE-MsgGUID: XMRHueVvS8mrF5CP7ZIHQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8034246"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by orviesa005.jf.intel.com with ESMTP; 10 Nov 2026 06:28:51 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] doc: fix igb NIC speed
Date: Tue, 10 Nov 2026 21:31:03 +0000
Message-Id: <20261110213103.151490-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The listed 82576 and 82580 controllers are 1GbE, not 10GbE.

Fixes: d2bc8f4d45d7 ("doc: add igb guide")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/igb.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/igb.rst b/doc/guides/nics/igb.rst
index 3f7a4156ff..9bf0b67919 100644
--- a/doc/guides/nics/igb.rst
+++ b/doc/guides/nics/igb.rst
@@ -10,9 +10,9 @@ support for Intel 1GbE nics.
 Supported Chipsets and NICs
 ---------------------------
 
-- Intel 82576EB 10 Gigabit Ethernet Controller
-- Intel 82580EB 10 Gigabit Ethernet Controller
-- Intel 82580DB 10 Gigabit Ethernet Controller
+- Intel 82576EB Gigabit Ethernet Controller
+- Intel 82580EB Gigabit Ethernet Controller
+- Intel 82580DB Gigabit Ethernet Controller
 - Intel Ethernet Controller I210
 - Intel Ethernet Controller I350
 
-- 
2.34.1

