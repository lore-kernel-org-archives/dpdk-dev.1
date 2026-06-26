Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F06CCDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8859040264;
	Fri, 26 Jun 2026 12:56:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id CAA854025F;
 Fri, 26 Jun 2026 12:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782471377; x=1814007377;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QDJPkpP+Ij6QnXO5vCELOx9eVC0qlodQpirKaTnib8k=;
 b=myS/T+rELrjhgZ33Oz4JNZEL5pRFUGEqh7A3JXBwsKfSkOZrE9w0b81G
 /ttR3CgpwDEweSEbAZprvDS/HWtMBYvbWZWp3dvuGzmuSxPyk9tJRdHOT
 LDbkSP841XyLbOJFlNYQHGmeZBriMGO55ym2RUd8So+JftQ6y4UwQJGTj
 wy3tKI6qLzcW3HoM1PRiKCDIE5irgot0l00MasN1/B7X6BadUdSRCjNK2
 k30e3jTZ75D7Kq1aNPmnoVr4kXGqA1BZqFJ/PZqNKkzl5RFXqbwwWNYd3
 Vre1HMUgh8WqhL8CbEdgRaiYluytyOIDTRwgBscj1/xv0VBMfCqGdwwgA w==;
X-CSE-ConnectionGUID: 7aM1BxbGRKy2yobFETU9BA==
X-CSE-MsgGUID: 5ABXugCSQOSnniY6V1ZuoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83142722"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="83142722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:56:16 -0700
X-CSE-ConnectionGUID: a6K5+XHISlKrgvZ7qP2EKQ==
X-CSE-MsgGUID: 7Ob9pCadQYKM+fKpns6nEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244904722"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 26 Jun 2026 03:56:14 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Radu Nicolau <radu.nicolau@intel.com>,
 stable@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2] vhost/crypto: fix segfault
Date: Fri, 26 Jun 2026 10:55:39 +0000
Message-ID: <20260626105611.1563794-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260624142023.1525497-1-radu.nicolau@intel.com>
References: <20260624142023.1525497-1-radu.nicolau@intel.com>
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

Fix potential call with dev->mem uninitialized, one common usecase
example being running the autotest with more than one device.

Fixes: 3bb595ecd682 ("vhost/crypto: add request handler")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
v2: removed unncessary ()

 lib/vhost/vhost_crypto.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vhost/vhost_crypto.c b/lib/vhost/vhost_crypto.c
index 648e2d731b..a19cdd61cc 100644
--- a/lib/vhost/vhost_crypto.c
+++ b/lib/vhost/vhost_crypto.c
@@ -1512,6 +1512,10 @@ vhost_crypto_process_one_req(struct vhost_crypto *vcrypto,
 		VC_LOG_ERR("Invalid descriptor");
 		return -1;
 	}
+	if (unlikely(vc_req->dev->mem == NULL)) {
+		VC_LOG_ERR("Uninitialized vhost device");
+		return -1;
+	}
 
 	dlen = head->len;
 	src_desc = IOVA_TO_VVA(struct vring_desc *, vc_req->dev, vq,
-- 
2.52.0

