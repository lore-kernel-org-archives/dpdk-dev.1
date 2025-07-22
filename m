Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FDC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E3240657;
	Tue, 22 Jul 2025 14:00:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E262A40657
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:00:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LNTaJs007825;
 Tue, 22 Jul 2025 05:00:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 r8mi1rLW3fYtAeiulfgmcrjLRT0h6fRlQX/n1nKpDI=; b=ibLiMmVOaeHuAxqkB
 X37Hy0ueKLt8GydvsFVADZWjUwLNxJ/znDMpnxwjIlJIWAXWI8fhpAEvFI3ZQQzM
 vfnIVw5WNwufDMpdhyyLkXV94h9kkQOyj+x9u/kmcZ69Xc8AN8E+nt+UInR9Pawr
 Z6HADOA60jqnrnKIaCfkNpBDOuezaSyYIj3VWbO1ihvM/JPByYVlEjOKv7OV5hVm
 PSRpR/Iba1LwU7jbqe0ATQXey3NdGZeY3oSfsTgRzGiz0vZdVHu8tluywvL6AtkG
 ny5OcqQ+3PSukku3kIIAQJNTXOnyKDdWffZvFtue4CTZB0WoTDt+ln8spEKemxd3
 jmAkg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 481y91sbcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:00:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:00:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:00:49 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id E42C05B6921;
 Tue, 22 Jul 2025 05:00:46 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 1/8] lib/pmu: quiesce rte_pmu_read deprecation warning in
 chkincs
Date: Tue, 22 Jul 2025 14:00:34 +0200
Message-ID: <20250722120041.2718227-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfX35Exdm00EtBp
 YPVuxS2zrescVN4fY7wLagymUdWsQ/MAFGkk4LewOzQlhuHV6Zb2jLqy0oDGyOci0MYSE7srDPY
 /V6Db9vuBP0et5MPVuqzUwEGvSf1qGHW5kqUmvi7AexVlPP9Bca7SDMr+Mfh/nkYLSUunYcaXwP
 AWnJOWOPSdKpbpfgxLkA4e69pextSIXCfFvUMeD457e12IoWc9xawWKdgrWqbur7iuCC3XQSGpk
 zVC6UO1pQM/NBsU6mhhJb+FrU0topld3pOtsowwFhRODPqSpVExK+RuHAcUkMHb1AOw5mpwmGwY
 /V0wiXPoLwa/4oPNSMNFhVHp4VXbtoTybye3+L6ibiot0pIAOyIc1BVWZxpW4qzSIvRJ27vAf/p
 DtCOoEvo5wpZ8QfCUtXTvxWUl9UumidmdAT3NOpC/1A7/HJaaTjXH6hcVpu7d5RNcgY8kzi2
X-Proofpoint-ORIG-GUID: NmOX1UuXFi8Ly0KcEzPToRtv-Lwn-zBH
X-Proofpoint-GUID: NmOX1UuXFi8Ly0KcEzPToRtv-Lwn-zBH
X-Authority-Analysis: v=2.4 cv=RfGQC0tv c=1 sm=1 tr=0 ts=687f7d72 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=k08xvbexF9gBptdmJXAA:9 a=0lgtpPvCYYIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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

Add a dummy rte_pmu_read() definition for chkincs when
ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
use of experimental APIs in tracepoints.

Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 57b634ecd8..84a5d522d1 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
 
 	return __rte_pmu_read_userpage(group->mmap_pages[index]);
 }
+/* quiesce warnings produced by chkincs */
+#ifndef ALLOW_EXPERIMENTAL_API
+#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
+#endif
 
 #ifdef __cplusplus
 }
-- 
2.34.1

