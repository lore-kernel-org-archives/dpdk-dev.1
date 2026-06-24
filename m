Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860CECDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E90140670;
	Wed, 24 Jun 2026 12:37:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0173140A67;
 Wed, 24 Jun 2026 12:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297451; x=1813833451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+NnFXD2cDEEQ9EnWoXbmbt6lB8agaeqYTgwXHuN0eCQ=;
 b=BHlCkW5RE0B+Ok3b1ih6gXO8rScP649DrmPTVa+N+NLwgpspr4tmhh08
 iT0jQBOh+HEvNng5UIMoEB7CLzE+Bw+6/MVy1Baqjw23DvGcSyl7VuZLX
 cAWofxxB1e2REppJM6MAovWtXr43pJk4o1mwYjDdzZ2PCp3azcEOKs11m
 AmeKzBciykMCXDzbshyEdgjtBnId1wc3WJuD3MMD4oRLUTLUyvHv68GVK
 rLlZklWvxcNjLoDv/L/6z2y2eI3DSugIkrLsOWmF3/3nLx4LcP8III/h+
 nsJi/r9xeQ5Zt5sQt6/PI9AJM9AqUqrLawReCVl4cVoKo+cHtZHIlx8pn w==;
X-CSE-ConnectionGUID: uIs90QSyQy2J6XKFIFvuZA==
X-CSE-MsgGUID: J+Wx8Gu2ThSNnM94BMZuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652396"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652396"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:31 -0700
X-CSE-ConnectionGUID: ZU391ktbRyer3++0+Fl3/A==
X-CSE-MsgGUID: pVLjOnLfTZKxd6oDprqA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460174"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH v2 17/17] net/virtio: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:56 +0100
Message-ID: <20260624103658.792750-18-bruce.richardson@intel.com>
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

Fixes: b72099be7f27 ("net/virtio-user: fix init when using existing tap")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
index 2431d00c33..da55aba505 100644
--- a/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
+++ b/drivers/net/virtio/virtio_user/vhost_kernel_tap.c
@@ -60,7 +60,7 @@ vhost_tap_open(const char *ifname, unsigned int r_flags, bool multi_queue)
 
 retry_mono_q:
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
 	ifr.ifr_flags = r_flags;
 	if (multi_queue)
 		ifr.ifr_flags |= IFF_MULTI_QUEUE;
-- 
2.53.0

