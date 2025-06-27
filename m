Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B8C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 023624026B;
	Fri, 27 Jun 2025 12:57:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C2DB64025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:57:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R1wHfl026882;
 Fri, 27 Jun 2025 03:57:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 1M4ZuuCE2AZl6rpOtAXoqAfeyCn8ETE+NblSXzoBcE=; b=dCAhWkrv8No1Tv94l
 QYHMiBIcW5KL08WiZJadKf7byupC9vejpTwZZdx1pHTVVHw2JCaZ/bNv+uJRaMAB
 4vX+iI74cnl4J7862STcXpXCV3ODfmRJlIsOckBfFjUw2EkT+O/OzCxDknd9/PrH
 GsRsdURA+EkY95MbnHVozo8I6eWjRVMaRhz2yfw8QSnMPWLeaymOj9zdQUCTzVlE
 Cfm4AyeD/p4Zfj+X0MDoUxEuygVB/meqN3Kz0fRkeEvv1rfxGn6ioB3psTHssSqI
 A3BkmsRrESiuoCOQe2pTprZqbUZff6Sf1ZUnOhVpKjukvXxMYKaFqglbqXc1zFPv
 LZU5w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hfxph710-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:57:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:57:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:57:45 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 998E75C68E3;
 Fri, 27 Jun 2025 03:57:42 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 0/8] lib/pmu: cleanups and trace integration
Date: Fri, 27 Jun 2025 12:57:32 +0200
Message-ID: <20250627105740.3388237-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX04rFXyjvBWsg
 4Thu4BYOBmktaO6OonJwfe4UpwS3653qtbh6yrZJTN5EUEGfe2PfNBDjh0cWWHUDLQdei3YAGhR
 XI0hCQOnyk84v222ilsUVZNa4oHEqj3nPGytUifHxupglWXMgr/Qb9R3tMingeDD/oqWs7+OX/E
 GH27w7RyN0OrPzpwQ9Wn5QMwQRDca0qwK7Y4xIasCRFrV10+a97Hqkbvk+Ff3q7EXoclJ8mAsSH
 /8WaafOQ72o0SkCmFkuEmR/orNe1KX9djPYoIiMYhGJqOD5a0QX5FIWjGU9yxfIV3JFkYj3K3JG
 N+FAymZmddkjWFQNTQ/ANZcw/GNXamxD4GjWZ2faVafNFeWlofDizHNWHDDqx1mWv6WVNJSAcFq
 jenwiDPynNlUG/qhiZVJPnRaedYZiZCGXn27txvIl+hJ9j60kjQZIaV82P9UhgTDBRbawlDY
X-Proofpoint-GUID: 11xNikjb18p5fxl7xE9QDQMO9bu1Wsus
X-Proofpoint-ORIG-GUID: 11xNikjb18p5fxl7xE9QDQMO9bu1Wsus
X-Authority-Analysis: v=2.4 cv=D/BHKuRj c=1 sm=1 tr=0 ts=685e792a cx=c_pps
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
 app/test/test_pmu.c                        | 58 ++++++++++++--
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
 21 files changed, 366 insertions(+), 82 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

