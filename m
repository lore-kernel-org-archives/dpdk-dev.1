Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02E606EE9C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=InD9/UDd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94B63402E3;
	Mon,  2 Nov 2026 16:58:07 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id A70CA4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:58:05 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DrZqd1073394; Mon, 2 Nov 2026 07:58:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=jaF0aOnGnkb5q57z1Doh9Xz
 /IiZhbI0XzIlNNSNA3QE=; b=InD9/UDdLoscqGV6i156xgIZXGzYLESpaaZGtw8
 K998fEoKGSdv9dfB91oJGD/APNyFpMHPrcTcoY7tCEAF6V8bNOOdfhlwcrxUTlz5
 C9p9jvrb5aCbHi9RBedv/zokx7BQVYsfe/6nTa+ejK/UMxmPy3Eo5lGyX4LvACLn
 S1jERZuBTk6HHD7+O+1BFy0uKUr5rwqyZ0XmNc9P+UGz9ujEYv5OC9PHprzjnQI6
 mD5Do3X8GFZIv4NRD6356A+B+sstv3tlZl/uOvZLKbtBP0pUOWTUQ1yNjPuVQYuy
 jM82BBsqISxShAN2IqN93MmFhiTD3YSRgOuqLZ94u33m3Eg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hp5fd4414-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 07:58:00 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 07:57:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 07:57:59 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.161.76])
 by maili.marvell.com (Postfix) with ESMTP id 281583F708F;
 Mon,  2 Nov 2026 07:57:56 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>
Subject: [PATCH] config/arm: add Marvell CN20k
Date: Mon, 2 Nov 2026 21:27:53 +0530
Message-ID: <20261102155754.63324-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXwADorEeP2IVc
 IhmBda6ZR86d06a4OkFtuxWv6faNLhLXBJqlXHb1K/wFxJlDMmPqYEKYiKra6uJbG/FP7ago1Ua
 4fWz7uXK4UY1ii/kalnstVFC+u74bucB6m7VcYBM+pavG/36jPcRGqpP9hyrTKNttrB37zL/46J
 37ijqGfuWwASGJSEW077Arij1andjSoNLImGcdgBNRFCh+Vmo7fgJBtDu6n0aVwWsUyCycpgHgX
 XiBxE8gwz0lOKqQjnKxePWTsBSSXYsklotoAAorQPhs9bDhO9/I+RqZIqC4f6itj6fjw4UIsy4N
 dtOYi+xow/iOU13wWjvlQv55eCUXKAzVdec2x1IWgjz3HRUBLrQ9ISAuWho0czSMa2YcxKBENr0
 TbtgMxSoOxh9VKPLqXtJVTn1vtdD2WhuRJ52riQ41B7ZdbZbUH+VaKBvueRi7mKra9eWAcLGiAw
 42aqk3SahbItURc4qVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfXyMQjOV4bJ4pg
 ajcwUiJ2mhP1iq5BgdIcm2Q3MGNZMGYBYTO9k3ZfJadvVT5l2xfR8iChmut9CUUPcG47yBfaBsR
 CdjXbKQfC15it41vrMmHMPKvZEq0eAo=
X-Proofpoint-GUID: l4-iSlAyIDSQeTKnS_gex6EOQGjUr2ii
X-Authority-Analysis: v=2.4 cv=bszZl0ai c=1 sm=1 tr=0 ts=6ae8b308 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=tgQZ_KMhYXhzlC5eCc8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: l4-iSlAyIDSQeTKnS_gex6EOQGjUr2ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Harman Kalra <hkalra@marvell.com>

Add config support to cross compile for Marvell CN20k SoC.
Marvell CN20k SoC is based on ARM Neoverse N3 cores.

Signed-off-by: Harman Kalra <hkalra@marvell.com>
---
 config/arm/arm64_cn20k_linux_gcc | 17 +++++++++++++++++
 config/arm/meson.build           | 12 ++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 config/arm/arm64_cn20k_linux_gcc

diff --git a/config/arm/arm64_cn20k_linux_gcc b/config/arm/arm64_cn20k_linux_gcc
new file mode 100644
index 000000000000..c8362a28c92d
--- /dev/null
+++ b/config/arm/arm64_cn20k_linux_gcc
@@ -0,0 +1,17 @@
+[binaries]
+c = ['ccache', 'aarch64-marvell-linux-gnu-gcc']
+cpp = ['ccache', 'aarch64-marvell-linux-gnu-g++']
+ar = 'aarch64-marvell-linux-gnu-gcc-ar'
+strip = 'aarch64-marvell-linux-gnu-strip'
+pkgconfig = 'aarch64-marvell-linux-gnu-pkg-config'
+pcap-config = ''
+cmake = 'cmake'
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv8.7-a'
+endian = 'little'
+
+[properties]
+platform = 'cn20k'
diff --git a/config/arm/meson.build b/config/arm/meson.build
index b84535735923..76ece0ff5169 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -494,6 +494,16 @@ soc_cobalt100 = {
     'extra_march_features': ['crypto'],
     'numa': true
 }
+soc_cn20k = {
+    'description' : 'Marvell OCTEON 20',
+    'implementer' : '0x41',
+    'flags': [
+        ['RTE_MAX_LCORE', 42],
+        ['RTE_MAX_NUMA_NODES', 1]
+    ],
+    'part_number': '0xd8e',
+    'numa': false
+}
 
 soc_dpaa = {
     'description': 'NXP DPAA',
@@ -764,6 +774,7 @@ centriq2400:     Qualcomm Centriq 2400
 cn9k:            Marvell OCTEON 9
 cn10k:           Marvell OCTEON 10
 cobalt100:       Microsoft Azure Cobalt 100
+cn20k:           Marvell OCTEON 20
 dpaa:            NXP DPAA
 elba:            AMD Pensando Elba
 emag:            Ampere eMAG
@@ -808,6 +819,7 @@ socs = {
     'cn9k': soc_cn9k,
     'cn10k' : soc_cn10k,
     'cobalt100' : soc_cobalt100,
+    'cn20k' : soc_cn20k,
     'dpaa': soc_dpaa,
     'elba': soc_elba,
     'emag': soc_emag,
-- 
2.50.1 (Apple Git-155)

