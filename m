Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB583606A5B3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=ODOBESTV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91923402E3;
	Mon,  2 Nov 2026 17:01:39 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 75FC14028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 17:01:37 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DrQOM2464853; Mon, 2 Nov 2026 08:01:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 rO5XpQHisAnpiAYoQ4s/4s++BUh20VA4yiWS94vrhs=; b=ODOBESTVlqx6YxSI7
 nfnyZ3XaLmGqvSOEhVluunk5lekpIMcyJeJ5ZFt8TgpmDfvPdHmh7H40hgEFSOTz
 j2EZKTJ2nP+VcKZZ/2iFo1+aUljPor4nrzjZAgBsQEW3K7YVLmY/CdrmccHkiMFc
 w+RHzDnUI67/Mt7EnlkZEuvV0W/bBkWyRUwOxkTR2KYjYAsbSmbjCzaFMoHQcCUU
 ks3NeTM4vTet2z6HgtPZq+FIZB/0sSHQoBkENXVouorMULV1FuDs6RtqIFq3LHqR
 peH/0lil5VWE4mpcgrDBBp6bIx2cyKMrahM+oVxxwubYnBI4PJ6QK1JYqYnzAS7b
 kYxfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hndpmpr7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 08:01:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 08:01:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 08:01:30 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.161.76])
 by maili.marvell.com (Postfix) with ESMTP id 8F38B3F708F;
 Mon,  2 Nov 2026 08:01:28 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: [PATCH v2] config/arm: add Marvell CN20k
Date: Mon, 2 Nov 2026 21:31:24 +0530
Message-ID: <20261102160124.64412-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102155754.63324-1-pbhagavatula@marvell.com>
References: <20261102155754.63324-1-pbhagavatula@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VOZIDNPX c=1 sm=1 tr=0 ts=6ae8b3db cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=tgQZ_KMhYXhzlC5eCc8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX2bsZ3kuoZfvF
 rXIN6JXvpuDUpkO6FMadrbLHvE85S+FoppiwfwPd/JcyIHgmaUd2GyN6gpHQU8GOiZJ/1qzJT3K
 A82RZzRxYBuafxIJDPesZN8oZLLVzsk=
X-Proofpoint-ORIG-GUID: 11SEuyy7E3umacx1g4O0HZHTz6JQf06q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MyBTYWx0ZWRfX/MuvtwDnrpMC
 91g2y/0yw15zhUSWbTgGnJAnOA0N+dVl42TmsmPUxJfacMttkwbu+43vqGtBehlhSxywFuldwlw
 0kyzIZpZTuYP+g6kUE/oSsyPXuAeyj84UpaKnDVzuyPDy+L9jMYyehxiQ79zFfxB+1NbPIjJKTj
 nrqqf3C9tMvpWSYPd3LBwoY0mwibWnJTLWU3qaZTO3JHK+vKMO03R1jf0UPSlU1DG/DVFgmi+n5
 AwFcWqIC+bGAnLFuo0n60IGPq1c21NOg5eI+4CDELNVIkY4I5KALgJ+BhYhPbjKV5ANyxXzfvom
 mUrdShdr1s+PN1KcPMBFqyzUhtGFBFdJAdlNb9fCYgocFAsqcbEX8z2mKmFawNvuEfi8GZpwgEd
 IaTr2TUPqET3VPLSkXea6qSwKaZyjHVV1Ke2R80IFLsMH9m4QYob0BVFzMUM/eyO0bwfYK08RSz
 +znfxD3BazpaPPU/iAw==
X-Proofpoint-GUID: 11SEuyy7E3umacx1g4O0HZHTz6JQf06q
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
Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 config/arm/arm64_cn20k_linux_gcc | 18 ++++++++++++++++++
 config/arm/meson.build           | 12 ++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 config/arm/arm64_cn20k_linux_gcc

diff --git a/config/arm/arm64_cn20k_linux_gcc b/config/arm/arm64_cn20k_linux_gcc
new file mode 100644
index 000000000000..a26ce1b879e2
--- /dev/null
+++ b/config/arm/arm64_cn20k_linux_gcc
@@ -0,0 +1,18 @@
+[binaries]
+c = ['ccache', 'aarch64-linux-gnu-gcc']
+cpp = ['ccache', 'aarch64-linux-gnu-g++']
+ar = 'aarch64-linux-gnu-gcc-ar'
+strip = 'aarch64-linux-gnu-strip'
+pkgconfig = 'aarch64-linux-gnu-pkg-config'
+pkg-config = 'aarch64-linux-gnu-pkg-config'
+pcap-config = ''
+cmake = 'cmake'
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv9.2-a'
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

