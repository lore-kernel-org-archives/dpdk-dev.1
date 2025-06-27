Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE38C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61442402AE;
	Fri, 27 Jun 2025 17:41:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E7812400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:15 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RA0GKt019508;
 Fri, 27 Jun 2025 08:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 Dg3XOyNyf/Z5Rfn/vY78N9QjhBNbyFgP9p3B8mXpMw=; b=k6l4fthEMHDrb5OJg
 Ryejf9qpXIZ+JumbvplCIq4G2i4WwzIdnEDU1jTnLT2ONf9oKAt2G6XJnzVxFl49
 +m5fQNpXDGvJUddSfLDBhb+Q7TiVXjy6rCLDiDQZkVnYeERCUtGXgu8Ipwe54NvN
 c+Qs1yZ4jD3DL6D5MQ6B3bSt42peXt8EW6B8dkQh0iZaePZPmRZsr1GURZoC9gNH
 ABH3XG3TeO08MuHbZROAIi6ldZeySe7M3aX0N0ZcdWOZO7TPMhzuVrZu6a/H0qd7
 VQJRSFhLLZzaxEZEkDqv2IM0eokm63W84B8XDVIUo4pDs3SmfogIbf0+lpGSLj7f
 3XQwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c8vn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:12 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D0DDE3F705C;
 Fri, 27 Jun 2025 08:41:09 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 0/8] lib/pmu: cleanups and trace integration
Date: Fri, 27 Jun 2025 17:40:59 +0200
Message-ID: <20250627154107.3405768-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zwmJV0pF2ODWajnxDuMnZM2H9a2ZSEOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfXyaj1WBTR7V6Y
 OEDMdbyZInudZqfRbI9fdApkTPhMUAulZLzZOjzA4e1ZDjQsgeCDpABcBSVn5HHPQbq4JEQTWmD
 4L/JK4Yhm57jDiGYQX6cljvHhbNsNK85ABocuMUyH88894Afi3Uu9IoSYrFiSuPY7xbGvb6n9KM
 jQeuB8sKd6YIlpwwtFftTREVcHmY7wDPl3ZdaqVi+Gegv8rwNs9nK+yRTrdQiIj1JbzjB/zH07c
 u96f0LIaNy9CQYdwwCOCMboxWu/SoPj0e7L/skuunZ0W2XUTN4o9/RGohlKGfNxn1lLOLdt/AAh
 txEk4/gZtUMetG0Mhwb3PGnPB7EX8TP6j/1uu5nW6HsylhU+unhqNxycReG7gAGQS9YTOEKiVKv
 Mxlt7Z7PJtxcvoM5FQoE3OGzGPTG/Q17S6EVJzgJs07f3X00kMfUxFT+bSjRl0IIgfswPBpR
X-Proofpoint-GUID: zwmJV0pF2ODWajnxDuMnZM2H9a2ZSEOK
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685ebb99 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=iR-xy-VhiHNNf1baXf0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

This series does some cleanup and refactoring around the rc1 code like: trimming unused headers,
switching to callbacks for per-arch handling, and adding trace support. It also re-enables existing
base test to help catch reported issues on some architectures.

v7:
- change test return value
v6:
- add more logs to functional test
- skip test in case of setup failure, user must make sure
  system is properly configured to get valid results
v5:
- add missing patch that quiesces chincs check
v4:
- change fast test so that it won't fail on misconfigured system
- fix compilation on windows
v3:
- do not export __rte_pmu_trace_read because that breaks compilation
  on windows - script generating map files does not handle conditional
  compilation
- skip testing if paranoia is at wrong level
v2:
- explicitly check against NULL
- make pmu lib optional by checking if dpdk config has RTE_LIB_PMU

Tomasz Duszynski (8):
  lib/pmu: quiesce rte_pmu_read deprecation warning in chkincs
  lib/pmu: export only necessary arch headers
  lib/pmu: reimplement per-arch ops as callbacks
  lib/pmu: do not try enabling perf counter access on arm64
  lib/pmu: use build system defined RTE_LIB_PMU macro
  test/pmu: enable test
  trace: add PMU
  lib/pmu: fix out-of-bound access

 MAINTAINERS                                |  1 +
 app/test/test_pmu.c                        | 60 ++++++++++++--
 app/test/test_trace_perf.c                 | 10 +++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++
 doc/guides/rel_notes/release_25_07.rst     |  2 +
 lib/eal/common/eal_common_trace.c          |  5 +-
 lib/eal/common/eal_common_trace_pmu.c      | 38 +++++++++
 lib/eal/common/eal_common_trace_points.c   | 20 +++++
 lib/eal/common/eal_trace.h                 |  4 +
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 16 ++++
 lib/eal/include/rte_trace_point.h          |  7 ++
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 92 ++++++++++++++++------
 lib/pmu/pmu_arm64.c                        | 59 +++++---------
 lib/pmu/pmu_private.h                      | 51 ++++++++++--
 lib/pmu/rte_pmu.h                          | 31 +++++++-
 21 files changed, 367 insertions(+), 83 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

