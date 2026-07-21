Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841CAC44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6554040A7D;
	Tue, 21 Jul 2026 17:13:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7FB124069F
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646813; x=1816182813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yX0QW8qNtqbJ37XMkdKO2j9juDfzlGSaERyx0800YtM=;
 b=AV3vPwuSCazdmy5LVH2hZ2F2BqHQR6a92Bv9B5RtDjGGxkDNrMYai66q
 gjocSj7R9P/AOKUJ8VT4xCZ9GXI5R5QrSIU40B12+O2zlTzcMHorWfK1t
 s3/F7N4lbTZTAQuezXIPTcsfZfrx4qn/QBTUJJskug9ofF6RoD6oflADS
 O5oGvEliem+98LP9X4VrTuJI5ryN0SnwjQ4b4bKGBScgvk6+qprktWAp5
 Saco1FstlTAAWAqRMA89X+/Scyj6rTzSpL6DImP9zubxfwnCWuXtVoiTK
 N2jfVjS/r0WQNcSGqzMRVSP8MCTOYzFn0DB9GfBnHD5G6xbxbFvEhC1l7 Q==;
X-CSE-ConnectionGUID: hli2dtG8QhGBKMB3Iq5yoA==
X-CSE-MsgGUID: aEREwFsvR0eUsew3FRGMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107723"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107723"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:33 -0700
X-CSE-ConnectionGUID: ep/RCvTzSc+IHRCwyiAWug==
X-CSE-MsgGUID: FA/rDTk8TiS3CJ7tS7HweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070967"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 5/6] doc/rel_notes: fix style of API changes section
Date: Tue, 21 Jul 2026 16:13:24 +0100
Message-ID: <20260721151325.2698283-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

The format of the API section as documented does not have headings in
bold. This simpler format is also what is used for the 25.11 and
previous release notes. Update text for 26.07 to match the documented
and previously used style.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b3c23b73a1..fca135569f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -317,13 +317,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
-* **eal: promoted timing-safe memory comparison from experimental to stable.**
+* eal: Promoted ``rte_memeq_timingsafe()`` from experimental to stable.
 
-  The inline function ``rte_memeq_timingsafe()`` is no longer marked experimental.
-
-* **ethdev: promoted flow metadata API from experimental to stable.**
-
-  The following ethdev symbols are no longer marked experimental:
+* ethdev: Promoted the following flow metadata symbols from experimental to stable:
 
   - ``rte_flow_dynf_metadata_register``
   - ``rte_flow_dynf_metadata_offs``
@@ -332,16 +328,15 @@ API Changes
   - ``rte_flow_dynf_metadata_get``
   - ``rte_flow_dynf_metadata_set``
 
-* **mlx5: promoted driver event and steering management APIs from experimental to stable.**
-
-  The following mlx5 functions are no longer marked experimental:
+* mlx5: Promoted the following driver event and steering management functions
+  from experimental to stable:
 
   - ``rte_pmd_mlx5_driver_event_cb_register``
   - ``rte_pmd_mlx5_driver_event_cb_unregister``
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
-* **ip_frag: changed handling of malformed fragments.**
+* ip_frag: Changed handling of malformed fragments.
 
   - Duplicate fragments are tolerated instead of failing reassembly.
   - Overlapping fragments are rejected on arrival rather than during reassembly.
-- 
2.53.0

