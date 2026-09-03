Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A830C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 129654026C;
	Thu,  3 Sep 2026 19:37:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CB0F540144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788457069; x=1819993069;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1eYLJpq97HDmH3JoV4YnI7GiXDadc1W/tEvYccYU7MI=;
 b=H+f/cymv0i3wYEc4RC4qetpwYAqQruVkzEXUXdgPv/i0utuOyTo6gLPz
 xP3xAp3fRoIXaeYbVGh5E1Kx709xKD66OpJZ4eauEb95hdXnpaBEC5HbM
 ACDmfIrKt1KqomJr29J9s86z1smaqdxzIs9A88tFoi8jqpzQ1geFtOn88
 KkLLUhRI4MlDi9irbSZJtOs521m0ITISSNy+faTIMT4bazdIRNbG+OwxX
 lQg4jOYZfdsOt5fYl4n92hsHkxND8+Az0+KNmoAHSF/5YRvZJdIivrrB5
 afWuiPChdVl9DTmO5n2LowdeI5YpPSjY+xy+jtys9EZaY+G5fDMfcxxxB A==;
X-CSE-ConnectionGUID: YmrG48oQTfi1z+xfMRX8CQ==
X-CSE-MsgGUID: VhINnr+rQmS7jc597fb0nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99547500"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="99547500"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:37:47 -0700
X-CSE-ConnectionGUID: /uONMwTHSWuWqpi9cMsyFg==
X-CSE-MsgGUID: 69qBvJgJTL6y2SLDlBybRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="265463063"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2026 10:37:46 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] doc: fix typo in Intel VF guide
Date: Thu,  3 Sep 2026 17:40:19 +0000
Message-Id: <20260903174019.120287-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Fix "Knowing issues" typo, should be "Known issues".

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/intel_vf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 40a1dfc851..5f50694337 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -700,7 +700,7 @@ will cause such packets to be transmitted::
    The old name is no longer accepted.
 
 
-Limitations or Knowing issues
+Limitations or Known issues
 -----------------------------
 
 16 Byte RX Descriptor setting is not available
-- 
2.34.1

