Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32508C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E49E40A6F;
	Mon, 14 Sep 2026 12:49:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4804940144
 for <dev@dpdk.org>; Mon, 14 Sep 2026 12:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789382946; x=1820918946;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2n6Zpq0NtrJ/3jQ4AC7cWKXRsPFuo+cNcDLVrSdIa7s=;
 b=HrE4r31qeo/rx+HtbWtAk0qbLcrmJXjcpEJuGFyIQkRqoZZzs0oHd+pH
 5gFSDAMTSoeYBy91q5GXe/MN0AQOZAqDOKgwSqD7K9qBmLovrOmkwjnna
 iyeVdFJTmvUrZf0XA/bvG5Bii6aeyq7+4j48xtUBd3xsaeFpIQcQXC6Gv
 aAwuC27zxjwfJRK1LM51CI7HUbmnCZiIPg9juBRVUKjs3/znlrlMTxe25
 eeza0z1G5gbJI4G5Ftnlok7XJonviqUaEuyvtHBuzT1ATXNB2YADUC8bD
 6eIB8tMw+dARv0GENI3f0E/b1e9BRa3IxHS3kcOBi47k2VtFzvGVw8FOb g==;
X-CSE-ConnectionGUID: Vyorpu1USwOLX4aXwoM8Cg==
X-CSE-MsgGUID: 5kwyz4mlSiW/mOYVxXGKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="101250124"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="101250124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:49:04 -0700
X-CSE-ConnectionGUID: CPurxz8eQhCmlMtXZEHIfQ==
X-CSE-MsgGUID: alX0omioRL+D5KeuKmYa4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="269975652"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 14 Sep 2026 03:49:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>
Subject: [PATCH v1 1/1] net/iavf: fix memory leak on IPsec SP delete
Date: Mon, 14 Sep 2026 11:49:01 +0100
Message-ID: <d722699838f742d88098fd31cabac1101b5dc429.1789382934.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

When deleting IPsec SP, we return status response without freeing the
request/response buffers. Do not return and proceed to freeing instead.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 9c8f694de52..06b51b5e622 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -941,7 +941,7 @@ iavf_ipsec_crypto_security_policy_delete(struct iavf_adapter *adapter,
 		response->req_id != request->req_id)
 		rc = -EFAULT;
 	else
-		return response->ipsec_data.ipsec_status->status;
+		rc = response->ipsec_data.ipsec_status->status;
 
 update_cleanup:
 	free(request);
-- 
2.52.0

