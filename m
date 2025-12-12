Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2017D44166
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2D4A40E41;
	Fri, 12 Dec 2025 11:33:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5C2DF4026F;
 Fri, 12 Dec 2025 11:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535620; x=1797071620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pEZS93UgnNITXxHhp6T2erx6mmHtayOQme4rX1vZxV8=;
 b=Mmdcmhg/RmBX2d+SakzlLSr5tbYi3/bUxAF3p2DQZyYZpzOEgDqfw40f
 11GjFFJTtxDPSF8hOc1c0NsE/l89bDHVowq/+6s/PB0wQNFNKVaIVEl1c
 w0GJV5sUdVHqgXPA8RweQM4vbJBT6Bgl5YoAOy9qnQZIuh1dWms4krPgs
 nACLUTq4+s/6vdnybizObk3U4J+5vwGHYZVyeGvo5qaoalNVUoFrOBfSd
 Yzu1/0QNSIx+tOE8lGRT6r3sT8w7mW1f6e0OPju2mBksD23hs/45Aly1W
 UzR+ZoydLvaWjX8v3QZcycui/+AUnk9graYJ2evb6mnXdikZGRMPefgi8 g==;
X-CSE-ConnectionGUID: tQTvfVfATziZT5pMAn1xIA==
X-CSE-MsgGUID: XruxLVWZReOPaYm8tlaUXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522888"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:39 -0800
X-CSE-ConnectionGUID: dYvKa2epQsSO0DgAehCOSg==
X-CSE-MsgGUID: Vm8vpAE6RHqsc59wsGzDLw==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:38 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 09/10] docs: fix inline crypto feature status in iavf
 driver doc
Date: Fri, 12 Dec 2025 10:33:22 +0000
Message-ID: <20251212103323.1481307-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212103323.1481307-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251212103323.1481307-1-ciara.loftus@intel.com>
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

inline crypto is only supported on the scalar path so change its status
to partially supported.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/iavf.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 6c9e97594f..0ba6f7dfd7 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -27,7 +27,7 @@ RSS key update       = Y
 RSS reta update      = Y
 VLAN filter          = Y
 Traffic manager      = Y
-Inline crypto        = Y
+Inline crypto        = P
 CRC offload          = Y
 VLAN offload         = P
 QinQ offload         = P
-- 
2.43.0

