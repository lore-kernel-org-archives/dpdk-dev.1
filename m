Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7597C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF78940292;
	Mon, 16 Jun 2025 08:53:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 622BC4027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:53:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNWVtn030507;
 Sun, 15 Jun 2025 23:53:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1BJDVaEfJSQKtBLuCdd2t+l
 52c2VKmTul4U4adIfx7I=; b=dHl/Na9g8Kez6mXCfs3LBXm2CeCN4oNvkth//FE
 1B/nuDO2qCVECX9EMTJP42Lkk/pYlK9YUPvIcWGOZKptLBwRtFM3iSncd/baGOd3
 Xxuoiz3KQl5nI5GlQTsC+UELo4rwNnHnzHt+oGLQ6mm7KUOWDsSfmA3Q3V6ecAYN
 eu12XRHU688bGTpOSQ+FETzlyeT8JNK6yGPtaqEtqaNVQ0fUin7W+WfHCbiLxM4w
 SodESH9jHTOCTsyPRZh6aa0cyUWQpXCb7n//xwt/E5TnRJHzvnypcVHkz2ADMyZC
 xbA5lybALTPuZsOpEN9KHoK0ySIq7szVfeo7jQXFL6A6dMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70m9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:53:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:53:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:53:56 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id BB55B5E6875;
 Sun, 15 Jun 2025 23:53:54 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>, Tomasz Duszynski
 <tduszynski@marvell.com>
Subject: [PATCH 0/6] lib/pmu: cleanups and trace integration
Date: Mon, 16 Jun 2025 08:53:35 +0200
Message-ID: <20250616065341.3233106-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fbf85 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=QrosmFFJ1KrBhTjf9f0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfXxaAAXEK/KEvH
 UOBCNeWjMI5Lc/JleUtVH3DhjIzhKjr0nrYqsJMRaBAJz9Ursxlzrf7sjeYexpIQKpetcm0EGjQ
 1ka3ikPoxVvkuExT8PtmZ2roGLOqXnuVXoitxPia2QY/R2pm/kTfIQ2wn1s0Arwf2GfCg3ojsze
 0nRjDZ2/bHSN8TTkdtcbwmkKRLIRVQnlAKC+ic61RFgSVjH0aKQi2pgOglpD66zjaS30dMXLPpj
 /OrXnAI039iboc5VOD/L92UOMzTCD7/m9k+od+TByqQLRV84FP1xFOKDd4mCdXEFRZj9fjhQ2aM
 MrJH+5iQgi6i/+Sj8MmaN6x0/CF0ELdxJfQKRmX3Ks/jlJ0UF7n8a0Oi4dZvKUcQMbH5spdZnwc
 MHiEamLKsUrXl8jJko23+o+swvG17JTCbtvm/BXFq2hy9K4raIc8QGVnsLMx8j/TMcAcoq4V
X-Proofpoint-ORIG-GUID: Y1tBlvvS4Wj4SstvrisVExSaG0fdx8vM
X-Proofpoint-GUID: Y1tBlvvS4Wj4SstvrisVExSaG0fdx8vM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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
 lib/meson.build                            |  3 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 86 +++++++++++++++++-----
 lib/pmu/pmu_arm64.c                        | 19 +++--
 lib/pmu/pmu_private.h                      | 43 +++++++++--
 lib/pmu/rte_pmu.h                          | 31 +++++++-
 21 files changed, 284 insertions(+), 43 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

