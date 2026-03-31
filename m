Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D3109B461
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC9D40A79;
	Tue, 31 Mar 2026 15:02:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AA870402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774962142; x=1806498142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0P4MfV06Fhfp37I+LdH5vwsTtxO4V63aHUhGIMAaUvg=;
 b=gHjQw+nm7lQxlElHmtKNm9tQkYsHSFJy8ooOvSslUnS+DgLMJkec63Hj
 ieeSdhEAe7EkHg6SxTLBu07wK3WfVww2zfqSNirk/LfJ/WEYWvQRkTMUU
 xraSGqNKPs2hVbf/eCxKbHpQSFiV6XH2gof1UvwPUR06Zw8VXvBrF5U6z
 IUbCDmYpbNbTvznm0QMHnFv9PPZjMYcWlAjzY6zdYHG0fyS+KKp+7fT4/
 ONTu3UKBC+iRIhuhyP+scLbfo/VmjYA4KDHYq3wIjcresC6gOV4hf3pcW
 zqZYM8vZJHMSgL/It692AhXlCUpz8Pg63erY7Ol21IfXpqRjK6gKcaAkA w==;
X-CSE-ConnectionGUID: 28L9oJ5GTOaxWZkGrHHmFA==
X-CSE-MsgGUID: j4LLZMBdRyiaMBBX/nlBTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75868424"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="75868424"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 06:02:21 -0700
X-CSE-ConnectionGUID: B2v9GmhNRfiBYEKNAQg/Sg==
X-CSE-MsgGUID: bfMkU05uTS+glwUoUwSNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="223481781"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 31 Mar 2026 06:02:20 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/4] net/iavf: enable auto reset by default
Date: Tue, 31 Mar 2026 13:01:18 +0000
Message-ID: <20260331130120.2471971-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331130120.2471971-1-ciara.loftus@intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
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

Previously, VF automatic recovery after a PF-initiated reset required
the user to enable the auto_reset devarg. Without this, recovery was not
attempted by the driver, leaving the VF not fully functional. Enable
auto_reset by default so VFs transparently recover without requiring any
user action.

Since auto_reset requires no-poll-on-link-down to function correctly,
no-poll-on-link-down is also enabled by default. If the user tries to
disable no-poll-on-link-down when auto_reset is enabled, a warning is
emitted and no-poll-on-link-down will remain enabled.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst         | 11 +++++++----
 drivers/net/intel/iavf/iavf_ethdev.c |  8 +++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index bc600e4b58..aec7f11b84 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -100,12 +100,15 @@ IAVF PMD parameters
     for example, ``-a 18:01.0,watchdog_period=5000`` or ``-a 18:01.0,watchdog_period=0``.
 
 ``auto_reset``
-    Enable VF auto-reset by setting the devargs parameter,
-    for example ``-a 18:01.0,auto_reset=1``,
+    VF auto-reset is enabled by default, meaning the driver will attempt to bring the VF back up
+    transparently after a reset event, rather than relying on the application to do so. To disable
+    this functionality, set the ``auto_reset`` devarg to zero: ``-a 18:01.0,auto_reset=0``
 
 ``no-poll-on-link-down``
-    Stop polling Rx/Tx hardware queue when link is down
-    by setting the ``devargs`` parameter like ``-a 18:01.0,no-poll-on-link-down=1``.
+    Stop polling Rx/Tx hardware queue when link is down. This is enabled by default because it is
+    required when ``auto_reset`` is enabled which it is by default. To disable it, you must disable
+    both ``auto_reset`` and ``no-poll-on-link-down``, for example,
+    ``-a 18:01.0,auto_reset=0,no-poll-on-link-down=0``.
 
 ``mbuf_check``
     Set the ``devargs`` parameter ``mbuf_check`` to enable Tx diagnostics.
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 2858cd4cb5..b5abfb1316 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2373,6 +2373,9 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	int ret;
 	int watchdog_period = -1;
 
+	ad->devargs.auto_reset = 1;
+	ad->devargs.no_poll_on_link_down = 1;
+
 	if (!devargs)
 		return 0;
 
@@ -2428,8 +2431,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	if (ad->devargs.auto_reset != 0)
+	if (ad->devargs.auto_reset != 0 && ad->devargs.no_poll_on_link_down == 0) {
+		PMD_INIT_LOG(WARNING,
+			"no-poll-on-link-down=0 is incompatible with auto_reset=1, ignoring");
 		ad->devargs.no_poll_on_link_down = 1;
+	}
 
 bail:
 	rte_kvargs_free(kvlist);
-- 
2.43.0

