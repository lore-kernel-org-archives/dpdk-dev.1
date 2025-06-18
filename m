Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05360C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 099D2427A8;
	Wed, 18 Jun 2025 08:56:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 52D6440E0F
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:56:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNXM9g023306;
 Tue, 17 Jun 2025 23:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 Fc4ZRR5WeISUzliRgCMPXsYXREggvndxc4mFADthDw=; b=RS/qpbn8WfhgyqUno
 9g34+bAaXRj3JCIesMW3dv1jJc4BDRrOhqie6WxI3pE5sutMpmZq8kzrKb4Z9c0B
 fTde8m/KoFMflfERUpVYh1fr1nTNH+3Jmzn6fAeHR8uLZ2FW8uyr7ZED08GG6wn9
 esd5huqLZSbfg7ktEJwLki41LER+sJZQnsOmCMAUjB9U5JVpTk1PW+bEzYjRWY/c
 WFnjrtPb2UuopTnk3bWQLKl/GXXRy9TrnUHiBjqhalpGzNcb+kRKOOWN129AlLOa
 ON8FW+GnJdJihf468Dk06EAFyAGb8Xy01Q4lPWWbmuw/cb4InWgH4AgO1ARmhWVB
 +oT5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xrq5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 23:56:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:56:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:56:23 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 5DA463F7043;
 Tue, 17 Jun 2025 23:56:21 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 0/6] lib/pmu: cleanups and trace integration
Date: Wed, 18 Jun 2025 08:56:12 +0200
Message-ID: <20250618065618.4045910-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=68526318 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=QrosmFFJ1KrBhTjf9f0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfX1OsLI/NFqGjM
 5X1nxNTOnBNc3R5azkan1mxdzaEWkPO6zd6x8AYZemHFBa0JCGWlUtf3LQPlhQ6VYC42aIzeoTH
 LXzOj31Sa0X5ya0T062hQhkZsekFT9I2oqE6vK82h5YIDLAxmiu6/6oYtu2uugd4Yc7i5BtFSOA
 4JB1yBUb/oah8jj6FGNO//+t0tTUb1h9P1bCbl2nGGiAzALZiMo/64hFiMjOMZ+xr0CbaBth9t4
 H8NLn0l8RPWd1j5lV4gX7s5iw2ody087WKPnk3o1S50GBQBnFCHAvpFpHWfNmlJtNFzs6DRWcl2
 i5lL0acEafu9AD/HAvjdZXMz0iQSRZ+C79OxVWgf/OFut14XLMg0JH9EiKdrbLvtlZTy0HNBpVc
 zhfO/iXJdfLJxMeE+2lMwEm+6+2dc4gg7b2PsmtoTpGNuaSsWDXL0Cokb0uv1JXqMd78rpUN
X-Proofpoint-GUID: l1-xXHK17iCex_BhyxalQCiTCDIRRcf9
X-Proofpoint-ORIG-GUID: l1-xXHK17iCex_BhyxalQCiTCDIRRcf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
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

v2:
- explicitly check against NULL
- make pmu lib optional by checking if dpdk config has RTE_LIB_PMU

Tomasz Duszynski (6):
  lib/pmu: quiesce rte_pmu_read deprecation warning in chkincs
  lib/pmu: export only necessary arch headers
  lib/pmu: reimplement per-arch ops as callbacks
  lib/pmu: use build system defined RTE_LIB_PMU macro
  test/pmu: enable fast test
  trace: add PMU

 MAINTAINERS                                |  1 +
 app/test/test_pmu.c                        |  4 +-
 app/test/test_trace_perf.c                 | 10 +++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++
 doc/guides/rel_notes/release_25_07.rst     |  2 +
 lib/eal/common/eal_common_trace.c          |  5 +-
 lib/eal/common/eal_common_trace_pmu.c      | 38 ++++++++++
 lib/eal/common/eal_common_trace_points.c   |  6 ++
 lib/eal/common/eal_trace.h                 |  4 +
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 16 ++++
 lib/eal/include/rte_trace_point.h          |  7 ++
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 86 +++++++++++++++++-----
 lib/pmu/pmu_arm64.c                        | 19 +++--
 lib/pmu/pmu_private.h                      | 43 +++++++++--
 lib/pmu/rte_pmu.h                          | 31 +++++++-
 21 files changed, 283 insertions(+), 43 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

