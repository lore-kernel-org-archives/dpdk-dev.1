Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F6C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F9CD40657;
	Fri,  9 May 2025 06:24:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9AC634026C
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764654; x=1778300654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AdvCVK3O7BmDp2yOZVGOFBSmqo/480rbvzcvEl4jGNg=;
 b=lC1duiwReTgf0ANdA88cs4qL6CkvCGejigeTDLoi+JtDwZMoSbOhFZ3j
 QPMFz57hByW0DdreOtLNbAkEU1HBeVyd9Ypa0wgDM/lDx10e89KI5efMo
 qn3+RlcIZkc3lYaiKmz+T+A90I4GFD0vWY8vx0MAie4jcl9J1UnOQvZOc
 wqhzXt800s53VyrHny9sDiwxwXxn7356LifzgFzQHuLB7eGUz0iCm7Gxv
 iDLWmem14xrCGRpzsQyK/rHJYtBukH/HRoTVy94ie4lEBi/vN4isg096u
 oKqcU/BtV8cnECcdE476FL2wQhjESpcXJwiUE82YMjRBRCI+xNEtoPpBQ w==;
X-CSE-ConnectionGUID: aeqnpPkoQtWEKAEGw/5+rA==
X-CSE-MsgGUID: yn2h5LVCSpu+3Ni11Bla2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692444"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692444"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:12 -0700
X-CSE-ConnectionGUID: JULFC8amTruBXk1AkQwP+w==
X-CSE-MsgGUID: RzGUZhnGR4+IkMWL4/pRAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388869"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:12 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1 5/7] event/dlb2: avoid credit release race condition
Date: Thu,  8 May 2025 23:23:59 -0500
Message-Id: <20250509042401.2634765-6-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509042401.2634765-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
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

While unlinking ports, all associated credits should be released.
This commit avoids race condition when main thread is unlinking
while workers are running.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index cd843bb9d0..5f3b816665 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -2664,7 +2664,7 @@ dlb2_eventdev_port_unlink(struct rte_eventdev *dev, void *event_port,
 		DLB2_LOG_LINE_DBG("dlb2: ignore unlink from dir port %d",
 			     ev_port->id);
 		rte_errno = 0;
-		return nb_unlinks; /* as if success */
+		goto ret_credits;
 	}
 
 	dlb2 = ev_port->dlb2;
-- 
2.25.1

