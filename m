Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386BCCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:39:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 841EB40687;
	Fri, 16 Oct 2026 13:39:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C6ADD40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:39:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792150775; x=1823686775;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yruE2Jfc3F0KYfe332ZItPW27Lp8wv1pBHCeOjl5ahw=;
 b=fI1+Ctrmmvpkfi1VF/L0L23XIRXrUl0RGJRmM3RukHcP1u3XAIC5k4i4
 y2FUXUkL8VmrXNsGKTavUSfwTfK9El0juqX+X+yLromZGCs6Hv60xaJAY
 dtIIfbwsG6780pw3QDj5L0LTLASn6DMuZdjeUZVlEnnH7dXYmzouqCbID
 RJOPTKGcqvIShTqj+TI7Nrhcq1RCelQ1HMYsO5t1X68VI+LtAHDVCGW8l
 hJk+9kflD7PQXlsc21iRUsooVfYG9XERtMMEucLx6NHgQrn+qF2isf0xn
 Xtn9uEcQior6PZNWr+uzzsU4A1FJ3U2WgUkAQHY0h/Ok6kwh++CBM4E5G w==;
X-CSE-ConnectionGUID: DwEVjzaLSiW5xeuCEJ8Xmw==
X-CSE-MsgGUID: tGaIEl4ATMOXz6/ouMp5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="940158"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="940158"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:39:34 -0700
X-CSE-ConnectionGUID: XQvPiDvoQ8+qwIDQY+GKvA==
X-CSE-MsgGUID: 6I30X5+KTd+N1Wz4Qnb+xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2178431"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2026 04:39:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/2] net/i40e/base: add get wake packet AQ command
Date: Fri, 16 Oct 2026 12:39:28 +0100
Message-ID: <0302e29a143892dc9d1e60de38dd1efcec54447d.1792150724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792150724.git.anatoly.burakov@intel.com>
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

From: Oleg Akhrem <oleg.akhrem@intel.com>

Add definitions for the Get Wake Packet Admin Queue command
(opcode 0x0122), which retrieves the firmware-saved packet that
caused a Wake Up event.

Define the command opcode, the command descriptor and the maximum
response buffer size.

Signed-off-by: Oleg Akhrem <oleg.akhrem@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/base/i40e_adminq_cmd.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/intel/i40e/base/i40e_adminq_cmd.h b/drivers/net/intel/i40e/base/i40e_adminq_cmd.h
index eda19ccf32..d41a6d592a 100644
--- a/drivers/net/intel/i40e/base/i40e_adminq_cmd.h
+++ b/drivers/net/intel/i40e/base/i40e_adminq_cmd.h
@@ -138,6 +138,7 @@ enum i40e_admin_queue_opc {
 	/* WoL commands */
 	i40e_aqc_opc_set_wol_filter	= 0x0120,
 	i40e_aqc_opc_get_wake_reason	= 0x0121,
+	i40e_aqc_opc_get_wake_packet	= 0x0122,
 	i40e_aqc_opc_clear_all_wol_filters = 0x025E,
 
 	/* internal switch commands */
@@ -629,6 +630,17 @@ struct i40e_aqc_get_wake_reason_completion {
 
 I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
 
+/* Get Wake Packet (0x0122) */
+#define I40E_AQC_GET_WAKE_PACKET_BUFFER_SIZE	0x600
+
+struct i40e_aqc_get_wake_packet {
+	u8 reserved[8];
+	__le32 address_high;
+	__le32 address_low;
+};
+
+I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_packet);
+
 /* Switch configuration commands (0x02xx) */
 
 /* Used by many indirect commands that only pass an seid and a buffer in the
-- 
2.52.0

