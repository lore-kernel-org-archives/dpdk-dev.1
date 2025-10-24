Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB54CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C84540268;
	Fri, 24 Oct 2025 07:48:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3267F40267
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:48:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3rFTX005012;
 Thu, 23 Oct 2025 22:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 6UDzrapIrmpIkY9w77+xLVSUji5uUN7/zm+rSnKpVw=; b=H8zXbLgKBXWQ6zB0u
 dShDWD9uKUPUvNsIISEFN5F6F2xkcktRtfz6Teaxdaob/r/BZcasl5mD2bUqfLss
 d8K+va9xOnnDugysiLSnAPrlhgvYRvFt9l0fVYniio1co1eJ3ufO4t75dQV8D5fn
 mKN4nhleG5cgCwwRclW+R9Ah0YuzLItwSnu0qyEXTIdxci9QLSounxAEzPb5u1M0
 h5Wj4Xl/giheSe3TumooenYI69hJ6spy6KwHOvEe5MRzeAkeg11WIvHxGPF7TWPS
 XW6Hlfanq92Rph3q1NjVwOISmPyE80BvOiUgAj/4yugusRV003+Op2zm/dCYpSTg
 QVrjQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a01xn84sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:48:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:48:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:48:35 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 173033F7071;
 Thu, 23 Oct 2025 22:48:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: 
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v11 0/9] lib/pmu: cleanups and trace integration
Date: Fri, 24 Oct 2025 07:48:21 +0200
Message-ID: <20251024054830.933910-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dsGpUwqLM2EGZntC7XX3ec748Y1i0EZs
X-Proofpoint-GUID: dsGpUwqLM2EGZntC7XX3ec748Y1i0EZs
X-Authority-Analysis: v=2.4 cv=JfmxbEKV c=1 sm=1 tr=0 ts=68fb1335 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CSfjQSgXBbJDMoaxdqIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDAzMSBTYWx0ZWRfX3zucfjDjs7cH
 4Hv8ClrKs+MB3JVA3mjigih5qdJ7ZFABEMmeJwPS8eS0frDCYmKjvp3Qm51flGodFx/E8w55zct
 CX7G2KlopyVlYxsrkmpjbuM2RgRM1MQnpbH26w/1b8VBjfLfhrjyz+Aq16y6vLbpaQQOAe4op7A
 SLeFbdet+36BFHrqFNhnUTAmG5GImc+CETUINthJfSEdafUjYceY4xr0hgcGOT8p/YTBPxSgXCL
 4f4LVyNCyjT99ZrfMrBd4kG/pQpZXcX54bXSNJNa2ItvT2Abs/yfhomOuSz58FFwihAfsuqt9kn
 DkdZaetYbWhzxxvImOT61B12wFevtny3r2lKqCUwTxSg5OwZnJOdwIMialUenPaSIB6CiuIn/FR
 qdiwMN7JscE7gET5mEBZVWYIJo657A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
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

v11:
- rebase series
- hide calls to experimental syms in inline helpers
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
 lib/eal/common/eal_common_trace.c          |  6 +-
 lib/eal/common/eal_common_trace_pmu.c      | 45 +++++++++++
 lib/eal/common/eal_trace_pmu.h             | 12 +++
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 23 ++++++
 lib/eal/include/rte_trace_point.h          | 10 ++-
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 93 ++++++++++++++++------
 lib/pmu/pmu_arm64.c                        | 59 +++++---------
 lib/pmu/pmu_private.h                      | 51 ++++++++++--
 lib/pmu/rte_pmu.h                          | 37 +++++++--
 19 files changed, 372 insertions(+), 89 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c
 create mode 100644 lib/eal/common/eal_trace_pmu.h

--
2.34.1

