Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20676C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44AEC402CA;
	Wed, 23 Jul 2025 06:41:28 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D6A104026D
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:25 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNSjsG023671;
 Tue, 22 Jul 2025 21:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 XN5X5UdV2L9msHhQOHTXaiywooX0zqTQuKNB8wgDkE=; b=HBB9DfLagqMyFvtTT
 OHeWbGXgU4uj1I3hFzC8u94jjFu7+1tLMDzraVh+ewqI0QZ5YvsJTgU5FQ0kj7TT
 GHUY7vWau44SJZuJktyv1iz+32ePjkxffyKc/4dE5fLu5/U114yBKrO/v0jIZwMW
 KL3gsQkdIhnx6bMfMckopwGyJO2BtVZkDN/4W+/GccV7iQWM43F9Pp6Ev23Esovp
 8VosY/1HAtwzrYDJ2RM/4+DszqDTQgjDMMMCeThTsiv90M3kHtRBfLgswAGPyx0E
 Q17Xp9c7lxgM0s0l54hKsJw7LUxeBoQbvMLgif6JEHi0EznFx4o8p0+nckvJe6BP
 CPLSg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482mbpghw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:24 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 18AFB3F707E;
 Tue, 22 Jul 2025 21:41:20 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 0/8] lib/pmu: cleanups and trace integration
Date: Wed, 23 Jul 2025 06:41:10 +0200
Message-ID: <20250723044118.2962318-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3iPNjcaWVNDuUD-DMmse3LJRPzI7Xfm9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfXz3otsndBqk6T
 ql2j3PQ5HqvXGYfBVT0plfSEbZUaqiM49hgMcVlV1eBFFhgRfUvRPzpe3UDtzHKNlAYdF21B8Vh
 EAd+WwulMuxGohyjuY5R6Hb0h/epgQZOYCgkn71wEWq8zb8ivpvf88d1B4BQNYRJ3vTlxUISxfu
 /imGzEqwVB1s+5m7L6A9Y3LwjVgCt6kRIbwzMvbdKegylvjFye1ZijsenKTn4PX8kdtm2VsAigS
 o8Ju1bxigDvmm+QKkk8dJoACRyhxkCsloSadkB81/aTbMLuT6GmTHQ+Pj4kX7SfFicbZ0dlSjPd
 5+SCMIsfr+HioEaxKQjQnEoc6Ha3CdtI6IxM8nQq+kNcpCgvVjIGuJW5/uJFVq4wv/S+PtNwDpF
 vqbaWPBsnVUbJjpNOmA+mKEa5k5OcjoeiJuQ5dZ/VqO396BNOl0EqqA5xmTrYbQPfrDWe/5k
X-Authority-Analysis: v=2.4 cv=dYKA3WXe c=1 sm=1 tr=0 ts=688067f4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=iR-xy-VhiHNNf1baXf0A:9
X-Proofpoint-GUID: 3iPNjcaWVNDuUD-DMmse3LJRPzI7Xfm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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

v9:
- properly rebase patch integrating pmu and trace
v8:
- export __rte_pmu_trace_read from library itself to avoid build issues
  with msvc linker
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
 lib/eal/common/eal_common_trace.c          |  5 +-
 lib/eal/common/eal_common_trace_pmu.c      | 38 +++++++++
 lib/eal/common/eal_common_trace_points.c   |  5 ++
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
 lib/pmu/rte_pmu.h                          | 49 +++++++++++-
 20 files changed, 368 insertions(+), 83 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

