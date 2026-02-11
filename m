Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2C2E9E2FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 12:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDEE402B5;
	Wed, 11 Feb 2026 13:19:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6FCAE4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 13:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770812365; x=1802348365;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TLENARFd7dDRd+G7aCF2qdnGY8QyozhOfJTT5W4q6Lw=;
 b=VjB7pu/AGl4dyX3MNZhOSMxH1HXhJ19re32nVPwii5xnlaa3TEav/eQf
 /sUe0mhdf7PTjlAKHxDwpeFH6WTg0hfjY8U2hUJzMdTT3UsrwGEu+688E
 ppDcOCLu74jDxJsoB6bSe4D0k875Yju+vxh4lZWnBo7XjRwdWK3GWyuGu
 gsiRLQ/z7L7T6ceYME0HcqAmOxBrpne/+X3LimSgUNHijoy8ifRRdzHun
 J7vss/iVvoEapQx/0+i4zXuNXon4ew2vLE+QEWDVybJj+PeDa8V+YtsYG
 IgAyC0o8jiC4qFz+4zZww423fPfz6hrrzY5NvC/3lgGjZcx+s823yikVv Q==;
X-CSE-ConnectionGUID: tDej46VET5mI4R89bIE26A==
X-CSE-MsgGUID: IhcgSLbbSEiubhSgLKO14A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83326093"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83326093"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 04:19:23 -0800
X-CSE-ConnectionGUID: YJFqaRCqS4+rJynoVy/zpw==
X-CSE-MsgGUID: 6nVyWt/GSga/yxd+FmM/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217194826"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 04:19:22 -0800
From: Emma Finn <emma.finn@intel.com>
To: 
Cc: dev@dpdk.org, gakhil@marvell.com, kai.ji@intel.com,
 Emma Finn <emma.finn@intel.com>
Subject: [PATCH] doc: deprecation of OpenSSL version 1.1.1
Date: Wed, 11 Feb 2026 12:19:16 +0000
Message-ID: <20260211121916.2598788-1-emma.finn@intel.com>
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

OpenSSL 1.1.1 reached end-of-life in September 2023. Future
releases of DPDK will require minimum of OpenSSL 3.0.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index ac667e91a6..fca556d07b 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -20,6 +20,11 @@ Deprecation Notices
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
+* cryptodev: Support for OpenSSL versions earlier than 3.0 is deprecated
+  and will be removed. OpenSSL 1.1.1 reached end-of-life in September 2023.
+  The minimum supported OpenSSL version will be 3.0,
+  and version checks for earlier OpenSSL versions will be removed from the PMD.
+
 * eal: The ``-c <coremask>`` commandline parameter is deprecated
   and will be removed in a future release.
   Use the ``-l <corelist>`` or ``--lcores=<corelist>`` parameters instead
-- 
2.43.0

