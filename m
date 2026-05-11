Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE0CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:18:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 549FA4066A;
	Mon, 11 May 2026 11:17:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 47015402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491075; x=1810027075;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WMUZyDeJILe4g0Q7Dxm/UWN7BeL8/IlTiQmxfiOYU/c=;
 b=EGVFlI4QqP+cMglf80nqkhwXSUaXRDH2X8nYAmkp4fEjHRg845a5ZYeM
 0xwpmNUGTb9VdxlyZrX0xOWd04Cqq12XgKYKsSiv0rdm+R9rpf++9bDOo
 Hrrp6UXBJQItY6TpnHUKTADXYPgJB5ht82vSpF+L57MsMNzXEoRzQWQcB
 eNw4g5VlfmgBWyzXSIuUoiThOcx8XICWIWF2/Tfx6C2XHSxISbXrEzyfD
 eUrMYx5pAOR4ADjfyIjpdyu4QY3MoVzKMJjeodHLey0foPy+r3RyrhtZj
 HsMeypNRUx4F0YC+FztFYNtXY/28oHdOLudi2nJj9kuW08onnV5Vg9dtf A==;
X-CSE-ConnectionGUID: Wmr7aHlqQhiuuR/c5wbIyQ==
X-CSE-MsgGUID: 4mWDfGi2QuuUkWD8lbANSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937073"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937073"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:55 -0700
X-CSE-ConnectionGUID: zotuvgLmSDyI+GDJgPyWiw==
X-CSE-MsgGUID: G1u6rr5RQMO60WGSjmChUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739687"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:54 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 4/6] net/idpf: fix ptype insert position in split queue AVX2 Rx
Date: Mon, 11 May 2026 14:39:33 +0530
Message-ID: <20260511090935.2288837-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
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

The __m256i register mb10 holds rearm data for two mbufs: mbuf 0 in
the low 128-bit lane (dwords 0-3) and mbuf 1 in the high 128-bit
lane (dwords 4-7).  The packet_type field sits at dword 0 within
each mbuf's rearm_data layout.

For mbuf 1 (high lane), the packet_type must be inserted at
_mm256_insert_epi32 index 4 (first dword of the high 128-bit lane).
Index 2 is the third dword of the low lane, which overwrites the
wrong mbuf's data.  The same applies to mb32 for mbuf 3.

Fixes: 1f065f9d75ff ("net/idpf: add AVX2 Rx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index d3a8e17778..e66dcc7a14 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -570,9 +570,9 @@ idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_
 		ptype2 = (uint16_t)_mm256_extract_epi16(pt32, 1);
 		ptype3 = (uint16_t)_mm256_extract_epi16(pt32, 9);
 
-		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 2);
+		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 4);
 		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype0], 0);
-		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 2);
+		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 4);
 		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype2], 0);
 
 		/* Build rearm data for each mbuf */
-- 
2.34.1

