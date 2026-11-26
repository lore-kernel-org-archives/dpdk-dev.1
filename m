Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D20606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G+PVh46W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9BD40615;
	Thu, 26 Nov 2026 17:03:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D37C402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709004; x=1827245004;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ics8rgH0fEBwU0e4puJxnRbZ10GTXLTY8GG1TKiOnn8=;
 b=G+PVh46WhHgTPSuwTxlAoDxHaNArcLT39izPzccsTnn8LxSai7UPbbAl
 X9QXOaC7+N83eKMJcjdBZ34cePDEK6bddgEn/noU/A0HRi6uyEeV024Aj
 0XOSEkriD6xzplirO60GNBYVenPlXSYwscoJjE0ZCpIznzE/fCcC4YLIP
 Egj0ajTd9fHk2khAq/NWq5UsT2scYeC46vwCYgI7DWQieO5jCsN8LRQL5
 Ctj7BBtf2/Vh3ehISHWlDDTixcKY3G68hsc8GZi8kJysvrOZLf2/nMRiB
 OR5HyG32oXx4vl+xu7z8QuXQn6S+6fFF9nzxyAcNQl6BZWgY4uRV6/uTy A==;
X-CSE-ConnectionGUID: Sh5oKFfpQOad2PJfhpZGgA==
X-CSE-MsgGUID: XvqOs2bgRXGlanVLBdCPwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519722"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:23 -0800
X-CSE-ConnectionGUID: ciiOj0rTR3CJLU5eMzllJQ==
X-CSE-MsgGUID: Ea4UW2ImQ/WmwbXCYk2OIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236585"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v1 01/11] bus/cdx: fix error check when enabling bus master
Date: Thu, 26 Nov 2026 16:03:07 +0000
Message-ID: <d5a44a0a8300015d48cde15dbdc75659063f40e6.1795708917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795708917.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, when setting up a CDX device, we attempt to enable bus
mastering, and we are meant to tolerate devices that do not support
configuring it, which is reported as ENOTTY. However, the check compares
errno against -ENOTTY, so the comparison can never match, and any failure
to enable bus mastering fails device setup.

Fix it by comparing against positive ENOTTY.

Fixes: 2284d67261ec ("bus/cdx: add bus master enable/disable API")
Cc: shubham.rohila@amd.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/cdx/cdx_vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 7a554472c24..7e1f30c3764 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -268,7 +268,7 @@ cdx_vfio_setup_device(struct rte_cdx_device *dev, int vfio_dev_fd,
 	 * Enable Bus mastering for the device. errno is set as ENOTTY if
 	 * device does not support configuring bus master.
 	 */
-	if (rte_cdx_vfio_bm_enable(dev) && (errno != -ENOTTY)) {
+	if (rte_cdx_vfio_bm_enable(dev) && (errno != ENOTTY)) {
 		CDX_BUS_ERR("Bus master enable failure! Error: %d (%s)", errno,
 			strerror(errno));
 		return -1;
-- 
2.52.0

