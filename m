Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B0FC5901
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 06:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F0F4064F;
	Thu, 26 Feb 2026 07:56:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 97D09402E4
 for <dev@dpdk.org>; Thu, 26 Feb 2026 07:56:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772088963; x=1803624963;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nFyefTlaRAU1GnBcAOo+tvD1ERX45eVKLfU+oH4YVhU=;
 b=hE5laRNfq3RnDnv0gnd2AmhSK06kdxeZf9aR+9+GRZ52MADRE+VHBycS
 PVySj+kj4YYIbwV9lg/q/bYsmrI0Lx0qAtJb2BCqbQXsj3LMYrlbP4Fa8
 NUbxQD2XFyhPMuJ6KtsyrrUyDGLCKoiuNSZ/2vOyVcng817jMM/8UDiJL
 EoPg03PWBjVt9O7+AY1n5vi4agihU4i79RnaWCAiVIQyvEg0mGhBk//5G
 YZkXj2WtuRZKC4FgKwf/k0pSgHBUKir5Mid8FpEwJFKW0GTQPve3Udu4i
 YX6FT3LQijN9Lnx9KwvpdKewHGywd28Ca4Bu1bAqXhWUdLf0l8o3sy+dZ g==;
X-CSE-ConnectionGUID: VoNpgS+HQ0qp7KNX+/GUaQ==
X-CSE-MsgGUID: WBA5VtfSTeqxPisS2N8x4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73322800"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="73322800"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:56:02 -0800
X-CSE-ConnectionGUID: tQ7LtghORn2QDIspTOCkmg==
X-CSE-MsgGUID: UV02mMKISiOE9T5lwWIJeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="214723487"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2026 22:56:01 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v13 3/3] doc: add note on unsupported completion queue sharing
Date: Thu, 26 Feb 2026 12:22:33 +0530
Message-Id: <20260226065233.917107-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226065233.917107-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260226065233.917107-1-shaiq.wani@intel.com>
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

Added a note in the IDPF Poll Mode Driver documentation
to clarify that sharing a completion queue among multiple
TX queues serviced by different CPU cores is not supported
in split queue mode.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..47e38fcb13 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -79,6 +79,11 @@ Runtime Configuration
   Then the PMD will configure Tx queue with single queue mode.
   Otherwise, split queue mode is chosen by default.
 
+.. note::
+
+  In split queue mode, sharing a completion queue among multiple TX queues that are
+  serviced by different CPU cores is not supported.
+
 
 Driver compilation and testing
 ------------------------------
-- 
2.34.1

