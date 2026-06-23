Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A969CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 655EB40B9C;
	Tue, 23 Jun 2026 18:52:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DEC86402AD;
 Tue, 23 Jun 2026 18:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233545; x=1813769545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+NnFXD2cDEEQ9EnWoXbmbt6lB8agaeqYTgwXHuN0eCQ=;
 b=QwcjbwaYRJVOTgX2pRuq0D7Gfp3OOpBFr5VLmNpYfR7VPWHDU6v+pEsn
 4LvGEqMKGmluKPK5Z/+jzAbRSHJNWVOEl20g393OWlk5OaZVOGqzR1fR9
 GcM5CMjDNs1ZOMeXRhN38yFSIQqpBewF1Godx2z5UQRXGh5JISY1Ke656
 YB8CfISR7YIS/qSOy2ZLRI4azdSUuLDq+nDLTb5oColUcBfjeB9xD7LJN
 DQSkHJ3wCsKg1hjjuwaXwThQimWg5vz+8oF22igq3BifVG2cdbuDgxHBM
 ZP68e9SoJk238dZZT7UFc1DOn3Qjz5r3b6RFpSEoscgd5X7uLv2ScZHPl A==;
X-CSE-ConnectionGUID: JDuFht9lTQiTGC9Dj7+RyA==
X-CSE-MsgGUID: NInMSBMcSbu6WzWEofCOKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534687"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534687"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:25 -0700
X-CSE-ConnectionGUID: gc7HHy3kTTWgrxtkdsuwTA==
X-CSE-MsgGUID: jKoT4tPrRgWApOq8fGcpeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928395"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH 17/17] net/virtio: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:47 +0100
Message-ID: <20260623165150.765443-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

