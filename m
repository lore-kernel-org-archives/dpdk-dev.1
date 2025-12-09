Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343FCD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB5EE40E0F;
	Tue,  9 Dec 2025 12:27:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 65A0740BA0;
 Tue,  9 Dec 2025 12:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279639; x=1796815639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UwI5XHQontRuD0Yk7YFJEzs3fdV7fpTQx3UwMrcDWA4=;
 b=QXHWV4Us1jhUvdWYo4CXOP8p0cOuMflPaN87tVihYrBMOc5y4xcTirQA
 AjvArESxpp0X5t6uO5y8XnW2tHhcqaKkcmWcChpjmOTL8uBZ5H5pt66gu
 SM/IVzO76T7T/5ONt5/2iZauzhCQ+mb4W8qXi/EkKF7puNA+96Wg847kA
 9mlnBm6jxIRS2oktWtQU6JOHqQbvVpZVUo1yCmYYVhQOESfBARTbCigui
 sBm455KqUsq7cSNj6bzaF0Bgw+k0wU6uQ/R4gmy8/+/yI07PCOA0HcuAn
 TuU0ker3mW7EcxrV/07FZylijtmbCA5HVt6VSyQy4lJEsktWie20gh12V g==;
X-CSE-ConnectionGUID: DMLaB9FrRp+wgfDvtqG7JQ==
X-CSE-MsgGUID: XKBxqaNPROu/wBgaMTzwog==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117052"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:18 -0800
X-CSE-ConnectionGUID: fVwrHJCtRai+99Z4CQ45rg==
X-CSE-MsgGUID: ATQXdpj5RYCLBnP4fS3BSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270243"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:17 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 12/13] docs: fix inline crypto feature status in iavf driver
 doc
Date: Tue,  9 Dec 2025 11:26:51 +0000
Message-ID: <20251209112652.963981-13-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

