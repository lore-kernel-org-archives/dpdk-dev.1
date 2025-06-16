Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BFAC7115A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA17940B8D;
	Mon, 16 Jun 2025 08:54:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2E47C4027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:54:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNVXl9027566;
 Sun, 15 Jun 2025 23:54:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=gXZOBXCUVS3yQQrOy
 mF2FQl+PdPXhdGOlAFlckW1VqdE5wKY1NVU9FpBpH6jAtN0DmjmYZ/9N7Z5Z6pgp
 AVOIthMu8L79bjD2vrK5VWDi8d59KZTsmnQfFdf20LpTMpsuOuqrf8ap6fOLKOgq
 Cg37tpzE2bGQ1eqeJYurOr/fPC2o1zCcv+bhlBCZxlS6ohGGVS9h2oar0ampE568
 1nl7aW0DGiTca/AK6M9g2WoVJrlfE++fut26MwRwO6LMLK+N2ib8mCA7OFb9oHi2
 +sYsQ8CmWnfma/16XluHc88pO2MQQDgrgKeanM3rYf9SvAtJPj7IAeNNRcy/eKAY
 S6h/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7wt0ky9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:54:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:54:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:54:01 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 71D765E6875;
 Sun, 15 Jun 2025 23:53:59 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
Subject: [PATCH 2/6] lib/pmu: export only necessary arch headers
Date: Mon, 16 Jun 2025 08:53:37 +0200
Message-ID: <20250616065341.3233106-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX4rLHAnOHbiI7
 Jqu8+si+9N7bZc7YoRZ6t+0bEB4eRdKzyFQCFItFGldsTHz73zUmBysxzJeSSwfxF2BgcRcz8y3
 MCMl69ejpth2bec2hGUauoOb9zspG0LBFjb9N9omOfU7iZHHYX0jTIsmdmrHqppZHzfpkjnh/gF
 dDXt6pSEYoC/1f6EBD6jzQpwHT4ZO1yoFP897IsDnQPGJ5oBevsxiQ+hhw6X780q0tsIKJJipBc
 pBgCXsC8iX44vz8v9iIvUKhUFaVsVcJehAClqhghwr0PNjWBEg9Ex+E+aAJaPqQFQWW2LnU9VY4
 DIoc0o8zsVV02aHQephtkxnVMqzy0TLCdTeJOXcpnF+1jZ18nQ1AUqhSIV+rqhL4lOpdXAPDcmK
 HH4QM83VvGdv0NRcTqCN18W25ezCMZe/3sginSXekaixWoUo84rSuxwjp7ozZdYvaHEeNRlP
X-Proofpoint-ORIG-GUID: AFYSKObNwUaXvBEoRaXMoWGSFawP6EeV
X-Proofpoint-GUID: AFYSKObNwUaXvBEoRaXMoWGSFawP6EeV
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=684fbf8a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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

Install only architecture specific headers to avoid header pollution.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/pmu/meson.build b/lib/pmu/meson.build
index bcb6d10f1a..53013d0ed6 100644
--- a/lib/pmu/meson.build
+++ b/lib/pmu/meson.build
@@ -10,13 +10,13 @@ endif
 headers = files('rte_pmu.h')
 sources = files('pmu.c')
 
-indirect_headers += files(
-        'rte_pmu_pmc_arm64.h',
-        'rte_pmu_pmc_x86_64.h',
-)
-
 if dpdk_conf.has('RTE_ARCH_ARM64')
+    indirect_headers += files('rte_pmu_pmc_arm64.h')
     sources += files('pmu_arm64.c')
 endif
 
+if dpdk_conf.has('RTE_ARCH_X86_64')
+    indirect_headers += files('rte_pmu_pmc_x86_64.h')
+endif
+
 deps += ['log']
-- 
2.34.1

