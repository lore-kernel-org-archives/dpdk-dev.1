Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260E606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HILpJvh9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37622427C3;
	Tue,  3 Nov 2026 18:30:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 1811C40265;
 Tue,  3 Nov 2026 18:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727049; x=1825263049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=riGTM+hocOvtCnC7cLQBBQRTm6MjXRlczWzEtLTZDTg=;
 b=HILpJvh9uVUCkujGJ+2Izg8G7dW1ZiARVE8RBWVchvTdzawt2Up1EtZ3
 JVYfCA0b6WzkDQbm6OlmkBqkThg+b/YOT5StUAezdyq7CU4QSIBT2bbtw
 37Ev6EAZdWFKDNpUtbFUje6mvozzvmgNpOeIynjiBGmJKKehwM2v95MNe
 vIkVvjdR5Wo5nC3gfgiY0Vza6jYsLhOk2AmhlG75fYuozYZoe/0vS32Qk
 lR9apQYTaly1b5WORSQJg/Yp4zvGI7T73hNpdNNzB4zGyjbMBOBTJb8eW
 TeDKUdPmRi9MMA6S3RcDnRDZSBSo0SfwDeGMmC6tQU+GffslMDk0lwupO w==;
X-CSE-ConnectionGUID: +OquYFinT8+8PqRQyShlCQ==
X-CSE-MsgGUID: 3CgyEWOATdKFxVwwiv/1Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553287"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:29:00 -0800
X-CSE-ConnectionGUID: vnv7Be4CRmGYvEAQ7MbKzg==
X-CSE-MsgGUID: YlBhqz+PSqevIbjc/MCziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495719"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:59 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>, stable@dpdk.org
Subject: [PATCH v1 5/5] baseband/acc: fix bug when alternating TB mode
Date: Tue,  3 Nov 2026 09:29:02 -0800
Message-Id: <20261103172902.4152956-6-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103172902.4152956-1-hernan.vargas@intel.com>
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Part of the FCW needs to be explicit set to zero when alternating
between TB mode.

Fixes: 32e8b7ea35dd ("baseband/acc100: refactor to segregate common code")
Cc: stable@dpdk.org

Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
---
 drivers/baseband/acc/acc_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/baseband/acc/acc_common.h b/drivers/baseband/acc/acc_common.h
index 255e0971b8..d70a14dcbe 100644
--- a/drivers/baseband/acc/acc_common.h
+++ b/drivers/baseband/acc/acc_common.h
@@ -1082,6 +1082,9 @@ acc_fcw_le_fill(const struct rte_bbdev_enc_op *op,
 	fcw->k0 = get_k0(fcw->ncb, fcw->Zc, op->ldpc_enc.basegraph,
 			op->ldpc_enc.rv_index, 0);
 	fcw->rm_e = (default_e == 0) ? op->ldpc_enc.cb_params.e : default_e;
+	fcw->rm_e_b = 0;
+	fcw->C = 0;
+	fcw->Cab = 0;
 	fcw->crc_select = check_bit(op->ldpc_enc.op_flags,
 			RTE_BBDEV_LDPC_CRC_24B_ATTACH);
 	fcw->bypass_intlv = check_bit(op->ldpc_enc.op_flags,
-- 
2.34.1

