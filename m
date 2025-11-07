Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD79CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B4AC40EDF;
	Fri,  7 Nov 2025 16:51:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B2E144066B
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530702; x=1794066702;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0OWp4ueEp9diLgYv6U8tGejITrTBrAe/wtruU82fYfk=;
 b=SkctixKX2iwgO5PtU3sJC1dhqiVwO6kdRySYsDVpq7WU6JUyr09cffYR
 d5+fdHqkWpgqgE5Ov/8h7OWc18EoAag3M01LWVZjnR+5eEQLJIPmnASOI
 ddOTU+lnIIaSLCj9Yk3A5ObRnpVaU7sqRTdXAJIMUsip9F6TWhJZz0scf
 tZg4EIo+ekyzpkEsrliVx3M55Z5YfiH9lR1o50FsJzGzM+XeN5+ZHJk7O
 elCF/lkFQn5amyL125zWkf6nduBB9gpN3yASzyrzsXuzFEL9VzSLrJime
 i7nCHU3vUB7w0y0BNCEom08I93G9n/BFM/1J3GuAEiuGbqsgvz/iBsqLZ g==;
X-CSE-ConnectionGUID: Wta8Xh4EQ/eaHAqyv65FcA==
X-CSE-MsgGUID: zJq50QSRSW6VKiUyoLrbrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151892"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151892"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:41 -0800
X-CSE-ConnectionGUID: ks7QfjH9QneXQMnO3u+SXA==
X-CSE-MsgGUID: hEMOBrI1T9u9DHDwHU2vqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321790"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [RFC PATCH v2 29/33] app/test-pipeline: remove unnecessary variable
Date: Fri,  7 Nov 2025 15:50:25 +0000
Message-ID: <20251107155034.436809-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

The second definition of a variable called "ret" in the main function is
unnecessary and causes variable shadowing warnings, so just eliminate
it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pipeline/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index 4cc098d7ac..e5efafdf28 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -89,7 +89,6 @@ main(int argc, char **argv)
 	/* Close ports */
 	for (i = 0; i < app.n_ports; i++) {
 		uint16_t port;
-		int ret;
 
 		port = app.ports[i];
 		printf("Closing port %d...", port);
-- 
2.48.1

