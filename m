Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F91CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1692740A7F;
	Wed, 24 Jun 2026 12:37:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3BFC1406BA;
 Wed, 24 Jun 2026 12:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297449; x=1813833449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fZRnzPZbLAuyzfTIVMI9d8HFfD5i5A80eq5xie14olw=;
 b=MI76hxZfrbT+u6knJVBUm33Dz7IkJqbLLhStdGmJSveDhHL7iDWRXY+J
 E8TI8m0PIumVDyRltdJbKoMqmkZcX0d3f73hsp05PmCOUx8AU9m0sOXj4
 o7YX369ELe/eYTX8kfPAK5UPQZ/lJi+KkftyReyPucUmjbLMSzrKgAEnr
 MVsTiEKs3YHI3osOoKkzmh+PtUSljiK+ER+KFmxkyD+MnZ9xs5B1GLcK0
 Ie61TUDtRebWgHnCg8/cBxLgPFFDz53xnkeXSxiAMPVSSeHLIdO176JrT
 kkmrt//+vRWzVqjQWmBhjyvA43SIBN67Nrnht01UfDEDgd6DB95hvs8np g==;
X-CSE-ConnectionGUID: DMMj75ASTrOV6+Kecu33ig==
X-CSE-MsgGUID: PVQ2xrp2Sxmf/dOPpF984g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652390"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:28 -0700
X-CSE-ConnectionGUID: ZZQ7eOUlSh+dmSyOSg08YQ==
X-CSE-MsgGUID: ErosS2fMTO6XrnWBt6WFIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460148"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v2 15/17] net/softnic: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:54 +0100
Message-ID: <20260624103658.792750-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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
 drivers/net/softnic/conn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/softnic/conn.c b/drivers/net/softnic/conn.c
index 5b031358d5..398f864d16 100644
--- a/drivers/net/softnic/conn.c
+++ b/drivers/net/softnic/conn.c
@@ -15,6 +15,8 @@
 #include <arpa/inet.h>
 #include <errno.h>
 
+#include <rte_string_fns.h>
+
 #include "conn.h"
 
 #define MSG_CMD_TOO_LONG "Command too long."
@@ -116,8 +118,8 @@ softnic_conn_init(struct softnic_conn_params *p)
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

