Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB3CD3447
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 13:20:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E12614025E;
	Fri,  8 May 2026 15:20:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 66F8A4013F
 for <dev@dpdk.org>; Fri,  8 May 2026 15:20:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778246404; x=1809782404;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R4PizEDW4jFSfcQvsUwyBWb8c3tWnEdzPpLu+rIT0xQ=;
 b=A0pwDz8tD0sFargctKR8Pi2wR+dQCYr4JsLO5rDo1K6tqtZiMuC2rZ+2
 oZxfTSMojOEhqW8XUBexA6nicW6eIJxBjwxR4eNBc1DXT2BfZQ36id+JG
 IOQUlrZSO19/M3b53ZKgxg0gdei9eVTMWuOkTAc/HV8oGdpbld01AgsE4
 Ieey5LX82FgB0IKgeCe3qtY/iuT5f9h3w7Oe/Jy3wnU2tXrckKJnDxEBL
 rIi64ZAcAHKtfPnAycC1MOzm2cXeQ3Byp3r4WY7ZWHpcrQO6L0lUsVyZO
 m3FZbWfJMx9oI7T9Tm2PLz7jTW+7PiTRhQpqFqlVXJxeXOedO4x4RIb9L A==;
X-CSE-ConnectionGUID: 6omJcj9yRvuVD7lWl3PPTg==
X-CSE-MsgGUID: YDPmxjbTQnaG7RrwFImmWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82833588"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="82833588"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 06:20:03 -0700
X-CSE-ConnectionGUID: sx5oxFvQRdSHT67kgNHD/g==
X-CSE-MsgGUID: 1tTIdS9NQFO0sxfhnACJnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241110487"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 08 May 2026 06:20:01 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Subject: [PATCH v1 0/2] Update IDPF Base Code
Date: Fri,  8 May 2026 21:54:06 -0400
Message-ID: <20260509015408.29188-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
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

Update idpf base code with compatible configuration on MEV.

Christopher Pau (1):
  net/idpf/base: add MMG device IDs

Soumyadeep Hore (1):
  doc: update recommended matching versions for cpfl and idpf

 doc/guides/nics/cpfl.rst                  | 2 ++
 doc/guides/nics/idpf.rst                  | 2 ++
 drivers/net/intel/idpf/base/idpf_devids.h | 3 +++
 3 files changed, 7 insertions(+)

-- 
2.47.1

