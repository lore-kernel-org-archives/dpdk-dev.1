Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D5FEFB4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB6A406BC;
	Fri, 27 Feb 2026 15:01:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id ABC5E4027F;
 Fri, 27 Feb 2026 15:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772200895; x=1803736895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZBWiiT9HzEKCJhiEo5QU4H82zQn5+qDZOkrzC1dy7kk=;
 b=PvPPnSebHbzoe81JHIRU/5+DtZSoVv//kY79OdwDKm5fQCExWoyhftZ6
 JEZbVvLiVfkV4vfDWHTcKsNjb3jJ3hASKbQzY1a54RFtwll4zCT/cb9D1
 VS9lrfIL+0Z2Ksi7WJXvkAkYPwu3CRNcPA6QGIb/KR2MSHr4ayHEgLYv8
 /vFR4Ni80saNczGGcfGqX2TzX9qpgTVc95bb4uT8MyB8Y/JYzF+KIU488
 d9a+/qvvCp8Fc2dNTUvwort5MjCpvy9HOIPxcrOxZ0TOxY+CFYcR3XFg8
 HDdeII9uzihKuAxJxCzi5cSIe0gIzlTO22L7jLvqNIZKxMXPxd+7sX1u8 A==;
X-CSE-ConnectionGUID: /cB7Q1N8QmeQims22xZnpw==
X-CSE-MsgGUID: yT1zw0SASSW3udCWkzSd4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73326514"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="73326514"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 06:01:33 -0800
X-CSE-ConnectionGUID: 1C47ue1eTYO2tGaZp6FwZA==
X-CSE-MsgGUID: TNgtz7CWQze2udy1B2Jtcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="216144355"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa010.jf.intel.com with ESMTP; 27 Feb 2026 06:01:31 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: marat.khalili@huawei.com, Radu Nicolau <radu.nicolau@intel.com>,
 stable@dpdk.org, stephen@networkplumber.org,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yerden Zhumabekov <e_zhumabekov@sts.kz>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v3] hash: fix pointer alignment
Date: Fri, 27 Feb 2026 13:59:32 +0000
Message-ID: <20260227140128.1083814-1-radu.nicolau@intel.com>
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

Bugzilla ID: 1892
Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
v3: revert alignment code to simple loop, it was getting too complex for a corner case


 lib/hash/rte_hash_crc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
index fa07c97685..f60f4598d8 100644
--- a/lib/hash/rte_hash_crc.h
+++ b/lib/hash/rte_hash_crc.h
@@ -127,6 +127,16 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
 	unsigned i;
 	uintptr_t pd = (uintptr_t) data;
 
+	/* align input to 8 byte boundary if needed */
+	if (pd & 0x7) {
+		unsigned int unaligned_bytes = RTE_MIN(8 - (pd & 0x7), data_len);
+		for (i = 0; i < unaligned_bytes; i++) {
+			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
+			pd++;
+			data_len--;
+		}
+	}
+
 	for (i = 0; i < data_len / 8; i++) {
 		init_val = rte_hash_crc_8byte(*(const uint64_t *)pd, init_val);
 		pd += 8;
-- 
2.52.0

