Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E3C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A4A340655;
	Wed, 25 Jun 2025 06:47:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 06F3F4060A
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:36 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OLKwTo031361;
 Tue, 24 Jun 2025 21:47:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 36prPWQ5eEbFbfcWLtvPz9NVibEp62I+mTY3Pu/4PA=; b=NqniTbNnHGPA3c9fW
 0VwBkiagS3OF4VD0nKppci6yojgW0V+7gMT3gMQxljZ70WU4mqPis0V1CPT7z6AI
 SJbnoA99MRdk5kWnCVY7PW8RJS9ggomjyClqnDZm40rMwc538VOoy0y3A9rh4XZQ
 k0luAt/BPX+1Xq9urpS3s/3KghCw0nrzStNVCqNyJ8ItQZ/0hXAU/9s9xRcGXbBB
 va5XsEQmLeLqkuJhBdpWuZyL4jOUQddAjYQUGLPTj3gNTfOl7iahMay1+MTsCL0d
 7hujmsUgzOE+oW6PPXirp53wxluxJY6chLXDYEGhdA9IRTQ/fTcOAV09Ghwnv6/7
 Zx7FA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g3ungrg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:35 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id CECEA3F705C;
 Tue, 24 Jun 2025 21:47:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 0/8] lib/pmu: cleanups and trace integration
Date: Wed, 25 Jun 2025 06:47:22 +0200
Message-ID: <20250625044730.2435526-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624122930.1783177-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=efU9f6EH c=1 sm=1 tr=0 ts=685b7f67 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=iR-xy-VhiHNNf1baXf0A:9
X-Proofpoint-ORIG-GUID: b6fMOOJvWMlbsDjbMipl7sF_uYe6wOdy
X-Proofpoint-GUID: b6fMOOJvWMlbsDjbMipl7sF_uYe6wOdy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfX2relIn2aCFak
 QzkAQjMrLunBZJsU9m2MWlu17K6d8Wks+xWI23lyGReE8c/rSW0O2uu6TQgjyoYUWImLiPKOKJN
 N57WPecKuVjQloAQak5eEtvACz7iKtZ+jBfpuANoA4ixvIjGhadtqtSiFw1pjiRjmy3md0OXlJ5
 AFL8G5bgHhYbsiB1yVRMwlnml5MO5gak1ESEn0FvCVoBBETp0OE5tYaRy2ejDVCDtuR+DcWKRyd
 Lf1u2J0JviNa70OlYUzoOh32+gQR6aPZoJALpNBB+mIN92CmpaLBk5vE6bV2NaK/lPnQvdWnit6
 8IYbumxCDtL4I3MuRz/Bqflhj1Ggdtd7TxIHYw6bj3f21lgoBWNLvNmDwVP/5bIPOqvmiu+YF63
 ALtRhkG7oPlWjYj9nRJZp0s+OK8aK+hQPhYQdmuYTp7k8Kaj+nBzZGTn049CzJ0DwMEB/zmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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
  test/pmu: enable fast test
  trace: add PMU
  lib/pmu: fix out-of-bound access

 MAINTAINERS                                |  1 +
 app/test/test_pmu.c                        | 51 +++++++++++-
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
 21 files changed, 360 insertions(+), 81 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

