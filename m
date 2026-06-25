Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D14CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E8F40DCA;
	Thu, 25 Jun 2026 16:02:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2FBC140A6E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396117; x=1813932117;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ztupEDXUMPOUhgDXkb4NmHoOgGx4KQ0FPkh7VC2kAsM=;
 b=A/DsHUyTR6qMM9XBRb+IivSRcoGI20xN9ekh4SyAosrNncIREujcZjT+
 zhX1bNOzoGmZRoF3Zp/URlD5fNpyGIr3kJMJPevE5i/82uq7vxsBIKVLq
 NagkKHFfRHdxxEIDEwmJDXuijuOs8EeraAe3QUwSwRNq7Lu3IS1AQwIlf
 /ltWV6O0EVFrTdO90O4h6/tz4RxNYIvnnEHBh2vok7g/Doc7WGyaWZcEs
 6Ubb7nLNZPNfo/H5iyHH5y5BdD1c97shmSwmug5gXbFrtQU/o9apidKta
 OiI7FJcytCT3/eyQyi5BWlUMY1N/+E64TAU/qNDNTgMFM84XVdXKloQE6 A==;
X-CSE-ConnectionGUID: TCfm91YxTzeC0GPgFr+eRQ==
X-CSE-MsgGUID: u1RyKZDPSzyFxs3OwU63Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225268"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225268"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:57 -0700
X-CSE-ConnectionGUID: 3xSBYJ/HRNmuaXtz9iVUAg==
X-CSE-MsgGUID: zS9xz1TAQpuHcVz1c1d+eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908119"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v6 5/6] eal: fix memory leak in async IPC secondary path
Date: Thu, 25 Jun 2026 15:01:47 +0100
Message-ID: <adb3091e924c3a1e7c441aa8f2be8b1564e6c68e.1782395581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782395581.git.anatoly.burakov@intel.com>
 <cover.1782395581.git.anatoly.burakov@intel.com>
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
index 5cd1bb8d13..235687ab84 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1209,6 +1209,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

