Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13989C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E060940283;
	Tue, 22 Jul 2025 14:00:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A4A5E40265
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:00:48 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MBhGt7006817;
 Tue, 22 Jul 2025 05:00:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 rzdtGw/INutPvRf2Rs4VUsGLgWuuFrZVCfzs6YTPbQ=; b=I70xImOn7b2O74P3E
 roIm9TBqg0glVSIWDIMQjC+DWsST0mE9z41anafnTka7fQMz6Qy30CbYD8nO/kJr
 Dje4ycziCspzijsannZw1R+CSnUXfk1uKPCe81yvU0a+uXlyZdlRkQPwSbO/vZWs
 qAaaHp2jEnCQueuvmkeTyAPXWVuf6wp6/UaRfgjjN+cQoOfK4QzN3qnZGX0C6okf
 4f9reruAyxWXWoSWvYxrLlcvAlAVI+xvJj/nnrGLxOfAHKYobw1ZLRNaQaoY/wKB
 ALQagi+XG9P50T294SuZO1tvq07CsvFoDQMNNnqdNsCHiJE02Tsx95jo9cuPfJyy
 0d76A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482a0600tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:00:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:00:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:00:46 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 120E63F7045;
 Tue, 22 Jul 2025 05:00:43 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 0/8] lib/pmu: cleanups and trace integration
Date: Tue, 22 Jul 2025 14:00:33 +0200
Message-ID: <20250722120041.2718227-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=M6lNKzws c=1 sm=1 tr=0 ts=687f7d6f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=iR-xy-VhiHNNf1baXf0A:9
X-Proofpoint-GUID: _V_x_FlI8am_l1xMiqSvB7trB3OiFLWP
X-Proofpoint-ORIG-GUID: _V_x_FlI8am_l1xMiqSvB7trB3OiFLWP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfX9j5fj8qfs+Wg
 +5e8sKNIvngdwVy57T2Yy4VQKzm9lXv/C6RRh2EcKTU5+8FSi7zcP/NpzJ7QTO7ytN1bKNwiPKI
 Pga7JYG3sVo8PHb3X39wKW2n1WiEcXGfwZMmE+VDWn4Lwt5UinoZlRUS57T9ZKK9AcnGmXZWrG0
 wSoeo/BtmDCiDC3IXImMFfijwPqDV3Je08LbLMpHJPpM1zJgkXKA9K1ccI5fWehBRxd/Y67AdlC
 zFN7U+0I7J83+fkzac3nyTsbMu4YYt+HTucPyMH5Kl2Kem7WHc8N6PjY8eclgkMBzhmqZ8oWZQ/
 HThvbkUvL0ZssvWgziR++lSYsW+fH4OvD6lW6H+W+RBWHvQuk/Ikhweaz/FxXYwDyBcy2pnI4nD
 oTol+XwG6fEwL1RzKJBkwaMot2ADwOu87N9nZCb99Rp7IG8ENpLIvTz90cvJ5OPIXT9qG6Sj
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

This series does some cleanup and refactoring around the rc1 code like: trimming unused headers,
switching to callbacks for per-arch handling, and adding trace support. It also re-enables existing
base test to help catch reported issues on some architectures.

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
 doc/guides/rel_notes/release_25_07.rst     |  2 +
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
 21 files changed, 370 insertions(+), 83 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

