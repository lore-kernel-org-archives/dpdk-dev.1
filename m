Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1096AF01826
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 10:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAB1B40ED0;
	Fri,  6 Mar 2026 11:58:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6D44D40E15
 for <dev@dpdk.org>; Fri,  6 Mar 2026 11:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772794715; x=1804330715;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=01yO6zUs3l9N7+w2UO6PZP7I+LILCdUMqQtppeuxQkI=;
 b=UblupNn2pYo0NwsrnozE45uOWmyZ/qpu+vQAoaniWiYCdgYxRVdKJeAX
 pWFs4JT9E7DEegn6YD4tfYI6o8FuKNWNOLb5T6fPnBxDNMZtkF2H0byJf
 IdC2I3ee1mAr/MU1gyQrROz6HVo1+9wpqtcHfqzpZGn/fj31i4YjrxuQb
 ZiDoD1w39hu2shpAZwWbUDCdB9tiwpNOjY5tQ58vwPh44aBJaptxG2GP4
 yG1NoK2hxUanmEQHpQMLIV6EPja9W0xLsAbPAcIlcquPogrBMI0vbkEmJ
 /wDc+wr0NpmDICtxjRIOvompg1WjkOavZl45sC5WgxPoADcjjz0aEl8R3 w==;
X-CSE-ConnectionGUID: ECEy9ldORY2MrP6mLTNtfA==
X-CSE-MsgGUID: VXvf90m9SwGCjxm/e9Cmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84984557"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84984557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 02:58:34 -0800
X-CSE-ConnectionGUID: rOre7/o+SAupO+FNfpe/Ag==
X-CSE-MsgGUID: lY8b0ypcRC+oRT0g4GUcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215678405"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 06 Mar 2026 02:58:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 6/8] net/iavf: respect output buffer in virtchnl
Date: Fri,  6 Mar 2026 10:58:22 +0000
Message-ID: <879969557ba349bc2e95506d6e9fe1d256927e41.1772794442.git.anatoly.burakov@intel.com>
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

Currently, in asynchronous case for virtchnl messages, we only store the
command response data inside the global buffer. This is correct, because we
populate the response in a different thread from the caller context, but
this results in caller's `out_buffer` value being ignored. Correct it by
populating caller's response buffer with data from response even in cases
where the messages arrive asynchronously.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 3f6ce0dd89..250816c24a 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -449,6 +449,13 @@ iavf_execute_vf_cmd(struct iavf_adapter *adapter, struct iavf_cmd_info *args)
 
 	err = iavf_wait_for_msg(adapter, args, poll);
 
+	/*
+	 * messages received through interrupts store their response in global
+	 * buffer, so we need to copy it if we received the message.
+	 */
+	if (!poll && err == 0)
+		memcpy(args->out_buffer, vf->aq_resp, args->out_size);
+
 	/* in interrupt success case, pending cmd is cleared by intr thread */
 	if (err != 0 || poll)
 		goto clear_cmd;
-- 
2.47.3

