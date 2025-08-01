Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C32C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCEE24065B;
	Fri,  1 Aug 2025 12:21:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1824440156
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:18 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719XmF1006490;
 Fri, 1 Aug 2025 03:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 RSJPzHVinwvmRge586TLZc+sRi51kTWjP1PIBOv+ng=; b=BzWoYopU43FMpV4CK
 KeWuliRN+oiVnXjh3PSgPx/THPPnzslchr/msQGGJmyMihYGO5Pa0GE7nN4fSToC
 a/HKUzimslFcamdRIcky1sQF7EgRijWG5/M0TM5SyIOu1TxVafJhfDhIiCGnqJnv
 67TpGbF81Fh/dOMDhoz2j7/w+VHMVWvNTCtB6SP/NdaYtj3jfv/iWtfklJ0sWbBu
 +fEHogfnHdp748Vp4XCWXgbAjWOiEiA0B0h3eF70UdKqWev/P0ZYC0Npz9qVKlYZ
 ZWkAjQqAm4zh1Yq1nTP4oRjp3l2YeBnpGxJWBF4VRYrdVB5U6NLomr70BE1pZ3FP
 iuDTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488u2cr2te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:17 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 0B7113F7093;
 Fri,  1 Aug 2025 03:21:12 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 00/10] lib/pmu: cleanups and trace integration
Date: Fri, 1 Aug 2025 12:20:59 +0200
Message-ID: <20250801102109.3544901-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=688c951e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=CSfjQSgXBbJDMoaxdqIA:9
X-Proofpoint-GUID: DxtepqyqEV28ohLByqo0S6TY8YgBTKO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfX3TSmHCUxvgE0
 XqqoQOd7WiCYY2WBXxUxpYLEZ+jg37nK738GnCmlKohSc4YhtKJUgRbrrJg/vZ817utBodRc1iP
 iDgNw6jNVjnlo7yyXyq/YWUbgz1nbNx9ThLCfQmgXiTyPMC8JAQjDLLLQkBDLf3stB2ayaOf4yG
 Dep0U8HVcsjrfQDj+0MDmWvWUaLysBjVqE0bxFRHxUwt8T7msw65qiHBAENCKXhQ8KulrGHakhy
 W7pYrYuXQJ9gJ2zH/jJ0JFVLXxf8v4Hl4JxLw8JiOMlEXJvq9n7tC0o6oYgJP3HbMhRs/BPYyEs
 wWpfFB1iAsiitlZwAJmqUb8iVRE0E49vwkCXYPnAaatDDQ2UBMHtzzAZMAygGtsHkVIeJdacaWf
 Os3eOLMf+u/7oF1nERfKgKykkU1j9Z+SW/+TJB1YBEcojYhs2wCJjrjj29mGXpPwJztVjDYE
X-Proofpoint-ORIG-GUID: DxtepqyqEV28ohLByqo0S6TY8YgBTKO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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

v10:
- fix build without ALLOW_EXPERIMENTAL_API
- move rte_pmu_tread_read() registration to avoid MSVC linker issues
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

Tomasz Duszynski (10):
  trace: change scope of conditional block
  lib/pmu: fix build error if ALLOW_EXPERIMENAL_API is undefined
  lib/pmu: quiesce rte_pmu_read deprecation warning in chkincs
  lib/pmu: export only necessary arch headers
  lib/pmu: reimplement per-arch ops as callbacks
  lib/pmu: do not try enabling perf counter access on arm64
  lib/pmu: use build system defined RTE_LIB_PMU macro
  test/pmu: enable test
  trace: add PMU
  lib/pmu: fix out-of-bound access

 MAINTAINERS                                |  1 +
 app/test/test_pmu.c                        | 60 +++++++++++--
 app/test/test_trace_perf.c                 | 10 +++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 +++++++
 lib/eal/common/eal_common_trace.c          |  6 +-
 lib/eal/common/eal_common_trace_pmu.c      | 45 ++++++++++
 lib/eal/common/eal_trace_pmu.h             | 12 +++
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 16 ++++
 lib/eal/include/rte_trace_point.h          | 10 ++-
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 97 +++++++++++++++++-----
 lib/pmu/pmu_arm64.c                        | 59 +++++--------
 lib/pmu/pmu_private.h                      | 51 ++++++++++--
 lib/pmu/rte_pmu.h                          | 32 ++++++-
 19 files changed, 369 insertions(+), 84 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c
 create mode 100644 lib/eal/common/eal_trace_pmu.h

--
2.34.1

