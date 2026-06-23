Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B88ACD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C340A40B90;
	Tue, 23 Jun 2026 18:52:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F0F3440A81;
 Tue, 23 Jun 2026 18:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233542; x=1813769542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R09VwkDK0WVxJiKiLWhQ40BTbP2gHTDGPNON2RFtFIo=;
 b=B1/23TBxmZAzf7en4Y3093KyLOJbsRnstMfmjWJexVVFR8TSfbN5xAXI
 QqMUlhCF6hNph6YA67Tz8er9p00JD4m+Ili1/Iq+7BbqaVnY28bGYl7CJ
 Pv8CL5kRLtnj3tjlLbsagyw7nkJ3uAJttI5tOVLIPOSsudNN6HIRw1X9J
 TiXn0BCGc2zhrVpyQgGJ0UGVY3ug0cnz6P8MVPIaUYkDih43BU9YOFMab
 iZLUyoQdGZMvzFBPKz1Ok2RbwdcZwLN9DFVUEScUdPZx7Uc/eTGDMmpNq
 CFyYbow5KIJpVmIm95hb2DyX0dGV3OSOCoG8qZyTfaBxTlhx1wLuZkopI w==;
X-CSE-ConnectionGUID: bgSxCRhJRKiiVIjSYOuWmg==
X-CSE-MsgGUID: xIBSxRzfQoa9VKkVHZKw3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534682"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:22 -0700
X-CSE-ConnectionGUID: dzig/ynQRNeL1DxDh44y0A==
X-CSE-MsgGUID: IM/YaCIYTv+/cSCqaQlTTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928387"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH 15/17] net/softnic: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:45 +0100
Message-ID: <20260623165150.765443-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 7709a63bf178 ("net/softnic: add connection agent")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/softnic/conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/softnic/conn.c b/drivers/net/softnic/conn.c
index 5b031358d5..d34030ce63 100644
--- a/drivers/net/softnic/conn.c
+++ b/drivers/net/softnic/conn.c
@@ -116,8 +116,8 @@ softnic_conn_init(struct softnic_conn_params *p)
 	}
 
 	/* Fill in */
-	strncpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX);
-	strncpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX);
+	strlcpy(conn->welcome, p->welcome, CONN_WELCOME_LEN_MAX + 1);
+	strlcpy(conn->prompt, p->prompt, CONN_PROMPT_LEN_MAX + 1);
 	conn->buf_size = p->buf_size;
 	conn->msg_in_len_max = p->msg_in_len_max;
 	conn->msg_out_len_max = p->msg_out_len_max;
-- 
2.53.0

