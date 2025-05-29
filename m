Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD88C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 11:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC0F402C1;
	Thu, 29 May 2025 13:46:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B2A1A4021F;
 Thu, 29 May 2025 13:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748519174; x=1780055174;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m/fCXe+ihgdllJV6uEBrgpvmQ3O8SGZJ5Y744QMfpqg=;
 b=apNnaBeQVg8Y0dJYREy2TeqoTHsvi0hJG498SCzLTBcMnLSNmqBYIQOW
 o2IT06jgIC8XVQmIbkCWI/7VRQ8O+0QAfJsdoNIeTaC6Jy7KLVMWfU5/F
 Gzxq1gzuuNdlHbUgrfz2lvdb57wHMt80kKDzmvOr36xF/h5O+cYJKxr9H
 7g5/BJ7zMs9FqCPEExBxiq/bq3Y6XVuk4zYQdM5rYWJQDsp/URI/WZuAs
 RjkN11yyiaeaAR8fkvywbmflaESFnzjYaaqDMxcIj/WZvN+RpiHXJueWj
 C57Ya5voNk0dKIHAR8PsG675y6veob0vUJtnzFXcZcZUzVhD37sWIvxxE Q==;
X-CSE-ConnectionGUID: CpmRgHWITP65sc3RRPp3uA==
X-CSE-MsgGUID: 4lfk7MkDRnqO6c1ZuMz+eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50459764"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; d="scan'208";a="50459764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 04:46:12 -0700
X-CSE-ConnectionGUID: BO+KQsTAS6+1++xfVGT4Ag==
X-CSE-MsgGUID: Ya3TEeslSgqh3iYoO8F+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; d="scan'208";a="166710680"
Received: from unknown (HELO silpixa00401749.ger.corp.intel.com)
 ([10.237.222.190])
 by fmviesa002.fm.intel.com with ESMTP; 29 May 2025 04:46:10 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Jay Zhou <jianjay.zhou@huawei.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	Radu Nicolau <radu.nicolau@intel.com>,
	stable@dpdk.org
Subject: [PATCH] crypto/virtio: fix PMD cleanup
Date: Thu, 29 May 2025 11:45:53 +0000
Message-ID: <20250529114554.35750-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
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

Improper cleanup resulted in a segfault when more
than 1 device was used

Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
Cc: jianjay.zhou@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index fa215fe528..c16b9fcc86 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -625,8 +625,7 @@ virtio_crypto_dev_uninit(struct rte_cryptodev *cryptodev)
 	cryptodev->enqueue_burst = NULL;
 	cryptodev->dequeue_burst = NULL;
 
-	rte_free(cryptodev->data);
-	cryptodev->data = NULL;
+	rte_cryptodev_pmd_release_device(cryptodev);
 
 	VIRTIO_CRYPTO_DRV_LOG_INFO("dev_uninit completed");
 
-- 
2.43.0

