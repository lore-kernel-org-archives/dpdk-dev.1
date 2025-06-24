Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD3C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 12:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0AA440612;
	Tue, 24 Jun 2025 14:29:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D71AD40264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 14:29:36 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAOBwo024510;
 Tue, 24 Jun 2025 05:29:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 8s2fBKqo4zu78ANZvBT4pOTbA0gx40RbQnydbeZV4s=; b=U6lftjmu//PaV6nYt
 3uRzkFPDQB8N5OK3MOFWxg1zfQcepUdqFdn0GbiNvyeeA++fujCITrOxEHgm6q7Y
 oePGXGOhcQgP9BI3CGkbBi4ElEW3tQjsUkp351ujjuKd1aCiNlI+P3pMShKdJd+7
 CMe9xAQQJLjyyuSHl6sJZxbeFT9KdSmfMHWiNwsrbF4mBcKdiGnJcocIIzoqjpKm
 uparZMLEB43m/r9aCYt0LD8hP9LENkEJTmpC0aAZWAnTojtPKACyczZdteWEWUKL
 H1cDlkkPv7LuSYUFHGaDiLH6SOZBnFGaO5N1LS2XfQV0XDgrYZC2QQKWt/nW5cit
 S/igg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ft7h06h1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 05:29:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 05:29:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 05:29:34 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8DCBF3F7062;
 Tue, 24 Jun 2025 05:29:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v4 0/7] lib/pmu: cleanups and trace integration
Date: Tue, 24 Jun 2025 14:29:23 +0200
Message-ID: <20250624122930.1783177-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: c6e__sB6BzzEPzyciBvwIWdu3Un2AiTk
X-Proofpoint-ORIG-GUID: c6e__sB6BzzEPzyciBvwIWdu3Un2AiTk
X-Authority-Analysis: v=2.4 cv=Nr7Rc9dJ c=1 sm=1 tr=0 ts=685a9a2f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=jD-BIjPS7U5udi5oa28A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwNSBTYWx0ZWRfXyfOf+htu+ai/
 qtwT7bA9qMSSiPgk4Hgvxtes9aruV54RoyAK+XsGWMzeFVmrAKyqqQEE41ApDzNiQap4ytXquXT
 oUc/uEMfVWOr+MOz8DiZSWft0gg0KzOoDTWsA78NqntX7A2GS06b4+/VZC7blB/stnZoxuE+WQV
 0WmIdStuw9D7iIc1NNbp96nPc8kWhr4d6ngkPH8zdCkIs2+5JgYFAnL0cY/wAi8yckN75j+QVeC
 FOnM800pP/0C+eEi4jwy2YyvN5O7lUy87p8LUNdT/CCzU6xvM4Qt8M6zrqGkmfolljsivYKmjyd
 ICsZpL76GnpwaoEyMyao6aUkExtB2kzHba8HbwFAmlpRX28/11BKNv6ND74IrSJdjBJaZNYKVHt
 Gu64V6oUtncWBBIDEXvRxDa9VY3RizSbv0a2i3yq1GaCiWneJnUfmlLCt1P49xAxESj5ZGJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
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

Tomasz Duszynski (7):
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
 lib/pmu/rte_pmu.h                          | 27 ++++++-
 21 files changed, 356 insertions(+), 81 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

