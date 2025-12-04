Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F624D1F9C2
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 11:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C12840659;
	Thu,  4 Dec 2025 12:29:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A1CA840144;
 Thu,  4 Dec 2025 12:29:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764847758; x=1796383758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZUw38NoB5imbO95iUKOcqenA7hVJQNcmdehbtCT1i8g=;
 b=kQ7yOhmBqWkv5NXpXZ1oFgGvJyUlzt/HFE/ZNbNnCI2eS7ECb9qpxf54
 xjQi7YaEDqLvRfEkmuZsQsmBTA/y9hZx3LxAlCU/dlUhdDdfclgipcvS1
 dbdWhtvJ6DpU/wJFlNQZwiTJ9Eu9BryKXS9AeQYM0JacbIvVAPw2eRQNY
 YNtmUsK8mjeZ+AGWZVIpF6IWCDR/bMIxY05MsqSzUL9IbOM43EeIDNptk
 txrJc60Pnfnra/rIZyDITNCiC/1PeExxN07k7LMGbAWNlQtDCc2/jAkMe
 Pp380Wo0U1EAnl0NnSLTWSXKNWuyiDNbjFMOf6cGgC1BkEExBosmpgysj g==;
X-CSE-ConnectionGUID: 9769c4veTVeERnqRtdW+Ew==
X-CSE-MsgGUID: DGw4Rs3CSyiJFMN8272VHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="78330218"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="78330218"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 03:29:11 -0800
X-CSE-ConnectionGUID: ZYVtsr8TQdGc9Q9IVlGEOQ==
X-CSE-MsgGUID: 64iT9C0iSyyhHi6o7Qc6RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="195370582"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2025 03:29:08 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ola Liljedahl <ola.liljedahl@arm.com>, Gavin Hu <gahu@nvidia.com>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 1/2] rcu: fix warning on Windows builds
Date: Thu,  4 Dec 2025 11:29:02 +0000
Message-ID: <20251204112904.2869502-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204112904.2869502-1-bruce.richardson@intel.com>
References: <20251204112904.2869502-1-bruce.richardson@intel.com>
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

Within github actions, the following error can be reported:

...\rte_rcu_qsbr.h(566): error C2220: the following warning is treated as an error
...\rte_rcu_qsbr.h(566): warning C4319: '~': zero extending 'unsigned long' to 'uint64_t' of greater size

To fix this, replace the "1UL" with RTE_BIT64 to force a 64-bit value on
all platforms.

Fixes: 64994b56cfd7 ("rcu: add RCU library supporting QSBR mechanism")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/rcu/rte_rcu_qsbr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rcu/rte_rcu_qsbr.h b/lib/rcu/rte_rcu_qsbr.h
index 550fadf56a..d89a43c186 100644
--- a/lib/rcu/rte_rcu_qsbr.h
+++ b/lib/rcu/rte_rcu_qsbr.h
@@ -563,7 +563,7 @@ __rte_rcu_qsbr_check_selective(struct rte_rcu_qsbr *v, uint64_t t, bool wait)
 			if (c != __RTE_QSBR_CNT_THR_OFFLINE && acked_token > c)
 				acked_token = c;
 
-			bmap &= ~(1UL << j);
+			bmap &= ~RTE_BIT64(j);
 		}
 	}
 
-- 
2.51.0

