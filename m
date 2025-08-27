Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B211C8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 09:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97CD8402C6;
	Wed, 27 Aug 2025 11:43:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D55F340298
 for <dev@dpdk.org>; Wed, 27 Aug 2025 11:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756287823; x=1787823823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Yu+Y+glDftLo6BHPx3rL2Oez7Be3An83ZHeupl7J2A=;
 b=eAtRXNYSHpIpDuTSLYD8bysZQo5FKv7rCt6lVcQNCbX0i9BroHgdEG0w
 QojOQQ7tb+6VmleXY+zOB+dxXfwD7mAQRsPL5KbvCcgi15z4zGgDlgl/J
 +Z97J2vUO0MfVBJsLX40SNKxXUuoHv06ABINyzPo4Js0xQDfRC5qegPqU
 2pyzLifyjgfHHSMjN6sDgyhmNKDBipCnau+J+HtHmY7ZFHMt2QOy4OE0C
 mLcs9rAtUcS8zdJG3Y/XCKxsg9ILTJXnSFmKwUnWYwUm3sgYh4j9+FQJv
 WNNvJ7C3ABHYJDKBdUEzONWYHEvpCBxTBOdBmA+khotLxIgduyjWb9x+M Q==;
X-CSE-ConnectionGUID: dz0FdAzmSmahm3qigSsjkQ==
X-CSE-MsgGUID: 3WxIwqOtSIKEDSzTXWHrbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62181527"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="62181527"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 02:43:41 -0700
X-CSE-ConnectionGUID: ejaB8/HnSGKp6J4GYLDJRQ==
X-CSE-MsgGUID: FfNS3QrWR5mQRZM9zzYL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169740833"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by fmviesa006.fm.intel.com with ESMTP; 27 Aug 2025 02:43:40 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [RFC] lib/cryptodev: update API documentation for aux_flags
Date: Wed, 27 Aug 2025 09:43:37 +0000
Message-ID: <20250827094338.767062-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
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

Update the API documentation description of rte_crypto_op field
aux_flags as to allow PMDs to define driver-specific flags.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/cryptodev/rte_crypto.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cryptodev/rte_crypto.h b/lib/cryptodev/rte_crypto.h
index dcf4a36fb2..38c8acbf4c 100644
--- a/lib/cryptodev/rte_crypto.h
+++ b/lib/cryptodev/rte_crypto.h
@@ -116,6 +116,10 @@ struct rte_crypto_op {
 			 * the status is RTE_CRYPTO_OP_STATUS_SUCCESS.
 			 * In case of errors, the value of this field is undefined.
 			 *
+			 * In addition to RTE_CRYPTO_OP_AUX_FLAGS_* the PMDs can define
+			 * their own optional auxiliary flags as needed, set by the
+			 * application and to be used for driver-specific purposes.
+			 *
 			 * With TLS record offload (RTE_SECURITY_PROTOCOL_TLS_RECORD),
 			 * application may provide the extra padding required for the plaintext
 			 * provided. This field can be used for passing the same in units of 8B.
-- 
2.50.1

