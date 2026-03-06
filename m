Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D108F01821
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0EB140BA2;
	Fri,  6 Mar 2026 11:58:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4A65540278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794711; x=1804330711;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=qbBdgSw3hC7qNkejELXb898IpSOm/1u4M4IfgAXQiDw=;
 b=kQJH/Wah9WOQlpM/raiRkVOaRD2tyRzuqHlWVKdUX13HbEa4z6T20noU
 S3aptU702LW5UKS03jxPvNrcg39mCyeZG5XQPBWCi4xCi9LExlcMKTqUR
 xSeocS5+GYlEUzIPJRV2Xf9VKSYQlzmjlIfK9ClP1E+E9F9/D84JEYMsp
 s0QsXGLEqE10e3GrCxhO4PDlBNySTQ+N4jXvgZBPscdnMxdHEeUgFHYiH
 FVpBGfxsLaawWvZ9MPb7i4QNedxB2qiz4yT4o1lo/TQwPXSWcUYeUoHqf
 RAaK6kGgtIvn+wG4zy0Mw3fIcxjujIMOxeLABjbkoWNeXKNrw8ashHFGF g==;
X-CSE-ConnectionGUID: Nbd1mrm/QlafOyB4a05zrA==
X-CSE-MsgGUID: dwgMSbRTQLqVC94LI4OpYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984545"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:30 -0800
X-CSE-ConnectionGUID: BMmLSRe6Qxi7WvZt8SovDQ==
X-CSE-MsgGUID: kmXw7jUwRgCLd/CT2GmNsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678385"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 2/8] net/iavf: add a variable for hena
Date: Fri,  6 Mar 2026 10:58:18 +0000
Message-ID: <d154dbf59c477c626feb0154330da9441cc20f22.1772794442.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772794442.git.anatoly.burakov@intel.com>
 <cover.1772794442.git.anatoly.burakov@intel.com>
References: 
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

Currently, we read RSS hena value directly from output buffer using an in
place pointer cast. Use a variable instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index a1dc573841..d97bdf0dc1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1933,6 +1933,7 @@ int
 iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	struct virtchnl_rss_hena *hena;
 	struct iavf_cmd_info args;
 	int err;
 
@@ -1949,7 +1950,8 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 		return err;
 	}
 
-	*caps = ((struct virtchnl_rss_hena *)args.out_buffer)->hena;
+	hena = (struct virtchnl_rss_hena *)args.out_buffer;
+	*caps = hena->hena;
 	return 0;
 }
 
-- 
2.47.3

