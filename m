Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7ACCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 09:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8F040267;
	Fri, 24 Oct 2025 11:53:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E86F740156;
 Fri, 24 Oct 2025 11:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761299594; x=1792835594;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gO8YBiimJxHrb4RSSYt2yzziRnYSvbdHJOZ9nGvSX48=;
 b=mPU1GetoGkF0t/weF2H960qm5W+mS0EtkKhiBdcfhNvvfHfypM6EVH8t
 h1rgScuICOI/eprGONW6IphiDN1z/0uP7wB5DZt+aj07EktsJuUq/cvkw
 wDU/yQNOoDMZYQZdO6OkFb08R764k0G2qw6dfHvJthsFFlq92BcqJRKvk
 ZWSGo/kOUcJwcdlGNtjjw+SLtQD3rycnBJclx0NPlRlQmwpxFRykg2h8M
 ay9ktpczJSz926XJ2gKELTtPqg9CUnkhwG/6O0KEw5DuClhV5EzAcaMw4
 nt0ckkcYyUtOQWn5U3buRJ2xbHLWi009gr5t0asAIAtofWnGKGG2+UdQP w==;
X-CSE-ConnectionGUID: JexInY3BS66tV7MFDKAYlA==
X-CSE-MsgGUID: nPj5OW0bRKqwnBTe3ZcaOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66096023"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="66096023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:53:13 -0700
X-CSE-ConnectionGUID: vct8CHgEQTSqG0XPqjElyQ==
X-CSE-MsgGUID: sSz08ZWXRY6Hrl1ApQq4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="185166226"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2025 02:53:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 1/2] bus/cdx: fix empty device string in error message
Date: Fri, 24 Oct 2025 10:53:09 +0100
Message-ID: <7e4985db2bbf29515f8cd6a4ab510d71f8a636a3.1761299581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

The variable cdx_addr is a stack-allocated zero-initialized char array, but
it is never used anywhere, except as part of error message out. The
intention is to display device name, so fix the code to reflect that.

Fixes: 45ef232af515 ("bus/cdx: introduce AMD CDX bus")
Cc: nipun.gupta@amd.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index c03bc01df7..a3cf53b6a6 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -389,7 +389,6 @@ static int
 cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 {
 	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
-	char cdx_addr[PATH_MAX] = {0};
 	static void *cdx_map_addr;
 	struct mapped_cdx_resource *vfio_res = NULL;
 	struct mapped_cdx_res_list *vfio_res_list =
@@ -455,7 +454,7 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 		ret = cdx_vfio_mmap_resource(vfio_dev_fd, vfio_res, i, 0);
 		if (ret < 0) {
 			CDX_BUS_ERR("%s mapping region %i failed: %s",
-				cdx_addr, i, strerror(errno));
+				dev_name, i, strerror(errno));
 			free(reg);
 			goto err_vfio_res;
 		}
-- 
2.47.3

