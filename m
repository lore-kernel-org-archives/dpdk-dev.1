Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A80D1038F
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B84140B99;
	Wed, 26 Nov 2025 09:24:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A2B26406BB
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:24:23 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQ55xq7079774; Wed, 26 Nov 2025 00:24:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=7rLFe0vho36AJzwaseIrtlH
 V7MCT/nycocbcSQ0QXIs=; b=FYyuB1ZpTPrD5aSDeI9Tk/cKw19esmbne11mr6d
 RUp6z41E4wclACA3V8vT+waVcZI8AhctR1GK0O0k45rmiK0bFSXR9Sxc2xDOsuTX
 URLw2DTNWGn0bBJszqT5uQSI7obxO/29DaTOP1ylpRfOpq9Jp1MjREu0iJMj9tGo
 KmjGQif/hE+9gL8r0cMCPMK637wDTkZozRmrYL3hCjR16B+AUjbguMWDsIX6g4A4
 bhisE/Eq7jcAE0B9Pk4MVnA1vJQkxnjHYCl/XAcCL+2uSD0k5cSHYlNfcqrRmPPB
 zbzsaShivt++OI7sGFmCUIz2hJU6J8BgaTJJSQ3OKgbAtXw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4an9rgakyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 00:24:19 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 26 Nov 2025 00:24:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 26 Nov 2025 00:24:31 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.21.218])
 by maili.marvell.com (Postfix) with ESMTP id AC61F3F70B5;
 Wed, 26 Nov 2025 00:24:16 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <mb@smartsharesystems.com>, <jerinj@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC 1/2] config: add optimal burst size configuration
Date: Wed, 26 Nov 2025 13:54:13 +0530
Message-ID: <20251126082414.91933-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0T9eFgavP_gcYrty1AavoveZ5TLlPSUa
X-Authority-Analysis: v=2.4 cv=ArjjHe9P c=1 sm=1 tr=0 ts=6926b933 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=boA3DbaLrGSzsQylsxkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0T9eFgavP_gcYrty1AavoveZ5TLlPSUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA2OCBTYWx0ZWRfX/C4hi5ZqMGr4
 VLUmznihUH7xZTxYwkx2QRGDbNNObi0Z45Jg/suySNFmS0HR32/rb3bFWuv4mDWHls3W4HkaMa3
 ENBSY0GlPIqS3Upq8Qh7nk6Upu8kRD16u0PjJZVtcGPRhpcYNbr+OGnxCtiYkaIlDWDAHL6fQq2
 Kary4+m6NPcsIzVK/ir0g3B5fV8+E7HiMw00KI3d1z4VZfjyuIqeVh/dx4rzcaa/NPVhuC3EDWK
 NIe/JFniUiy0fxuSBMdK96lyPF1erQbIuoDS7BCeUSEKvVf7x8SaNfVbHEZy8z5TseYcFGBGRjA
 86kO+WPwEMpWxYpW5S7H7Ac7423bpn+mXBrrnlH8oep8YTpkL6+tHMNaWvp5OH8VVSukoF/tFPK
 Om1ckRaWOdJe2hu+Jg6YqxCriIEomQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the
optimal burst size.

Set default value to 64 for soc_cn10k and 32 generally.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
This improves performance by 5% on l2fwd, other examples showed
negligible difference on CN10K.

 config/arm/meson.build | 1 +
 config/meson.build     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed50..fa64c07016b1 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -481,6 +481,7 @@ soc_cn10k = {
         ['RTE_MAX_LCORE', 24],
         ['RTE_MAX_NUMA_NODES', 1],
         ['RTE_MEMPOOL_ALIGN', 128],
+        ['RTE_OPTIMAL_BURST_SIZE', 64],
     ],
     'part_number': '0xd49',
     'extra_march_features': ['crypto'],
diff --git a/config/meson.build b/config/meson.build
index 0cb074ab95b7..95367ae88e2d 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')
     dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
 endif
 dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
+dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)

 compile_time_cpuflags = []
 subdir(arch_subdir)
--
2.50.1 (Apple Git-155)

