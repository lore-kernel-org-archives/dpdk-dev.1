Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E7F36C2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 06:36:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C3134028D;
	Mon, 20 Apr 2026 08:36:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DC2144026E
 for <dev@dpdk.org>; Mon, 20 Apr 2026 08:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776667010; x=1808203010;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8nfLyTdVV4iad0+veWAtSz4+x5EB34t227GXLlXlsUw=;
 b=LlB0VMJvV2n+ZgwycFj8NXn1/rb2pAsDhdM+ey8uSzHMnQdg0GWBfYJi
 DnE53Yee8JFSBOBd9YIK72QgO3f+YMNjCXr7vy3URnWbuef1TInBfj4/r
 tcSdORcdEOPaX1PSmfeKw/SlEbi0HKdkB7MqNIe1Res8EDh4Ed6bIdBI5
 tei+gXcN7kLq8sPLFML+3sZ+O7tBhZLcQl1oJTX7oVOQDyGS88VF7Tui5
 Sy86ojo38r3/vgVcopZQoNobAkCit0a0LdMOh3DnIERMRLTpPxMFy880u
 U8X6oWhIZ0R0heSPZfG5sozWWcwrraQWrWkzOXxlBfm/5Wgg2FkRwCAaN Q==;
X-CSE-ConnectionGUID: 4vUgGVgySIiP0tMMPybUWQ==
X-CSE-MsgGUID: qDda1JjJQca6MGw0wbYFKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89042548"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89042548"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 23:36:48 -0700
X-CSE-ConnectionGUID: Vm5mKhylQnWn/alngwJ9Fw==
X-CSE-MsgGUID: IeyYhLaHQjqHbf7tNgYReQ==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Apr 2026 23:36:46 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 0/4] net/intel: demote path selection logs from NOTICE to DEBUG
Date: Mon, 20 Apr 2026 11:57:42 +0530
Message-ID: <20260420062746.178145-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
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

Demote Rx/Tx path selection messages from NOTICE to DEBUG level
to reduce noise across ice, iavf, idpf and cpfl drivers.

Shaiq Wani (4):
  net/ice: demote path selection logs from NOTICE to DEBUG
  net/iavf: demote path selection logs from NOTICE to DEBUG
  net/idpf: demote path selection logs from NOTICE to DEBUG
  net/cpfl: demote path selection logs from NOTICE to DEBUG

 drivers/net/intel/cpfl/cpfl_rxtx.c | 4 ++--
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 drivers/net/intel/ice/ice_rxtx.c   | 4 ++--
 drivers/net/intel/idpf/idpf_rxtx.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.0

