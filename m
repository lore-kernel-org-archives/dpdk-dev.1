Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F766FD5323
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:49:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B5B540691;
	Fri, 27 Feb 2026 10:49:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 882CE4027F;
 Fri, 27 Feb 2026 10:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772185752; x=1803721752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6hTJzRozBdStHEYXPvQ3sOMgmpZ0FZkc9H78LO5SJsk=;
 b=UcCqAgX3A22SoZKodyCPvqATjduw5qWf3u0nd6TWFgD0S3Flc9fOjGeU
 HPkV+K1er0lJrajnXS0aUQQwWK+RzAud3GF2Tzrj9ZRyinp9KZyhP4dzn
 bpJPQQOmV2PNbJzQerwO7tMTsoHzhTPpSJS28NLXhabfSlFQCo6oP25dk
 8bvlCgsS2GCKW1HK41D/fhg6rYtOPzOwWzls1rdZdTO2lF/dkoBION8iI
 YQY1XpTXR/85KbPCN+wFbE3dT+a+3Qrr4jl1OvOuXvuPaDZi8veuooq91
 m68J/c66zLUIsU2GrB8PwfHuQ3e6aMEo+9gN4Nehm8+7vAcKXKptVnxkC Q==;
X-CSE-ConnectionGUID: bPRfpCbzRneRp91gvQCCAg==
X-CSE-MsgGUID: EJBB4MsjR0+fV0ghEz+z9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73137866"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="73137866"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 01:49:11 -0800
X-CSE-ConnectionGUID: 6aESsDEMQ02sNV8NeoSG+Q==
X-CSE-MsgGUID: SThy6WqFQYW5ulk/OupdOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="247372292"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa002.jf.intel.com with ESMTP; 27 Feb 2026 01:49:08 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: marat.khalili@huawei.com, Radu Nicolau <radu.nicolau@intel.com>,
 stable@dpdk.org, stephen@networkplumber.org,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Yerden Zhumabekov <e_zhumabekov@sts.kz>
Subject: [PATCH v2] hash: fix pointer alignment
Date: Fri, 27 Feb 2026 09:48:09 +0000
Message-ID: <20260227094852.960180-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226142206.860737-1-radu.nicolau@intel.com>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
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

rte_hash_crc assumes input pointer address is 8 byte aligned
which may not be always the case.
This fix aligns the input pointer before proceeding to process it
in 8 byte chunks.

Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
v2: reverse the order of alignment adjustment calls

 lib/hash/rte_hash_crc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
index fa07c97685..d61420868a 100644
--- a/lib/hash/rte_hash_crc.h
+++ b/lib/hash/rte_hash_crc.h
@@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
 	unsigned i;
 	uintptr_t pd = (uintptr_t) data;
 
+	/* align input to 8 byte boundary if needed */
+	if ((pd & 0x7) && data_len >= 8) {
+		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
+		data_len -= unaligned_bytes;
+		if (unaligned_bytes & 0x1) {
+			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
+			pd += 1;
+		}
+		if (unaligned_bytes & 0x2) {
+			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
+			pd += 2;
+		}
+		if (unaligned_bytes & 0x4) {
+			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
+			pd += 4;
+		}
+	}
+
 	for (i = 0; i < data_len / 8; i++) {
 		init_val = rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
 		pd += 8;
-- 
2.52.0

