Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125ACEE339
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:29:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40B554027A;
	Tue, 18 Nov 2025 17:29:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 589E24027A
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483369; x=1795019369;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yknjs5a1TkdVRwvzvLFRHmvyIm2dUVNfMkm/dqI2PG4=;
 b=Ri1ZFQM1DJ4Wv4hSuGhOfTqBlP7nRHYxpW/Lc9MVOqyGcLAEIIag8Pb/
 +GrCrzayVIAnySLwHFvvUyPLFDdrbCDXB+DbJsK3f9rU9BgdDWdpTiHQ3
 wjR172MhGhW0AMb4zMk7ggwhUoPXLe8lMzmwF8GKFkaUVYMLfO0JKyu+0
 8oXt+iGc2vct5w2sxtR1uTowdPWKrQWRuNTzVxehdR4xG4fs6bL1AhXZF
 qBI2xxfrB3t0LFwl9adgGvxxRjH7DBcn3FIWIzNrXNwYdoxk/Kdpwtmnr
 obtbsNWEjbemqFdNAPISU7ktFvOqLslSZVxXc9aNuUO/wpqfyAUNNr5pX Q==;
X-CSE-ConnectionGUID: P8pR4XjARDq2FimrEXKk8Q==
X-CSE-MsgGUID: wvDPF2hcSsCGiFRX8Y6QHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550581"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550581"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:28 -0800
X-CSE-ConnectionGUID: 794tqFU7SqOJX5LoVK/QSw==
X-CSE-MsgGUID: +Z7YiZQvSCiH3v9c3ZcoKA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 01/20] doc: add deprecation notice for VFIO API
Date: Tue, 18 Nov 2025 16:29:02 +0000
Message-ID: <026ae788e873217f0eb0fa2966b492185326d4d7.1763483253.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
References: 
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

The entirety of VFIO API will be either made internal and only available to
drivers, or will be removed. Add upcoming changes to deprecation notices.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 1e60ac4e82..5e3df71048 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,7 @@ Deprecation Notices
   without relying on flow API.
   Currently there is no alternative API
   providing the same functionality as with ``repr_matching_en`` set to 0.
+
+* eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
+  Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
+  This change will be made in 26.11 release.
-- 
2.47.3

