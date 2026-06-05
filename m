Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0141CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5657240651;
	Fri,  5 Jun 2026 16:29:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C43774026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780669770; x=1812205770;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yOcPuhiswHU/HYoIge0qq8nFjhf14x6CjTjrrp6oTQU=;
 b=VGNY/xnqpR6q53XTnw8IXHl1DkSLLVlKKLK2h7b5N1ETi7/Ov5davmgG
 6Nz++7xWB+nzKwCU9oYgHj4+pp4Y5B9hAJJaVbnwlljO8vw3QO5V/HIpW
 BSzaSWD4RBEc5qe7WcUrSjnYDBVRAwvN0+mzLH/1GDnUhquOznd63jrHw
 yehHlkO69uRI2qmsHfwWuvhXQxKiZtFsHZyB4yJyX23E99y7t3WWe3ExX
 EhxuVlr4AnTDtU8pwW3WHwyxMVehX5XNCmJx4ZAbnD33/kf2v7nD3aGRE
 a6f3BQAD2XICQKksb+j/7FZbLzmlWZVHjoeI1ckgzCHkWq5xJLbxZsyAt g==;
X-CSE-ConnectionGUID: JJqkV59GSg+ou3tP/s/bNQ==
X-CSE-MsgGUID: M0AWD1F8QN+1Fr/MNrTlFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81482616"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81482616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:29:29 -0700
X-CSE-ConnectionGUID: DndZAevsRK2U2kigOS9fbw==
X-CSE-MsgGUID: TSjbSUDMRc2IkIXPC71rJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="242383079"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2026 07:29:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v4 3/5] eal: fix memory leak in async IPC secondary path
Date: Fri,  5 Jun 2026 15:29:22 +0100
Message-ID: <d38f281bb9637545a3fc2dc166e4223f9f54e978.1780669755.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780669755.git.anatoly.burakov@intel.com>
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

When rte_mp_request_async() succeeds on the secondary process path, the
dummy request is freed only if it was inserted into the queue. However,
when the actual request was sent successfully (nb_sent > 0), the dummy is
not used and the function returns without freeing it.

Free dummy before returning on the success path when it was not inserted
into the queue.

Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 2f4a939c68..c8e59967d9 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1210,6 +1210,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

