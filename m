Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AC7C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A954B40144;
	Tue, 27 May 2025 13:02:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EAFAA400D5
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:10 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6t7S2019590
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rmPgjuA9WPmVn4Lcp+pq/Nm
 A2KZhJDXkAf0Y0kbVk30=; b=MDvoTpRsiCVaP8ryMhl0mU4RRmb5iQUNlDH5KnH
 C0iPhMBmL7pvI24yLlGbe91u7TDNUbUBjP1PyqtAc6+DA4xDStqYbneYL6yhjZJF
 0CtjUFY6kPYi2CJOMhDkNEICa1oMzlRtMJYqW7y5MRra41WdL8iQIOcYWUv9uUUf
 iRbV20cqq0HD8/g5imfHGL1f7zZBu5VBl2d+tMMYi5x+Kwmh4lAne/mO3pigCiZc
 T9xjiYSyxF+lrhlmrd6FB/bukNG76UHZNA81UViZzc+2lWIK07K4atbsAVXWdNOx
 /BVIHCGvnFzHWxaI7wQLA/53T7H4v30RsNgv2sMrB5xtqqA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8hq8djd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:08 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 9601B3F707A;
 Tue, 27 May 2025 04:02:06 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 00/25] add CN20K support to cnxk crypto PMD
Date: Tue, 27 May 2025 16:31:40 +0530
Message-ID: <20250527110205.2300800-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX8UFXX4n5p/9z
 QOx07xzIWM5wX2g5KShbSRLFFeiH3mJES6Gde0W7fZ10U0p7E5FMW6d5H96ktkrhkazazXRbnzR
 ojiIYBWgppDRYzuK87Iyz0pHYHkUKiibZga2XkfrJccLYq7kfcwJXhOTURF3+8rNw6LKoFgJ4BV
 X+7V840WYCWFTOvLIIgViRQlVqO9ASQnG26FzihnM96KoXXLtWTibDM4+cdxWnwu8C1oYgVRcOa
 qr97gqRxLwitf5KxMJOARQvcS70BwbqHVB4n62CuHyMTS0Z9qz8n+QhySHbtlDaIIYwsGci2dzN
 mJCCHMi23AHGob0nEKqLoVhcws6wqDzmI6HQfvYDA4676j5fKlEdVIfYEBDn25C6Z8HxYJXTDh/
 vee3m0KxfHkNgD8lA8KlrCjMKB9lO5V0807NyzJKUQS86G10DfPfjrl1OtizkoT5U+onebuL
X-Authority-Analysis: v=2.4 cv=D89HKuRj c=1 sm=1 tr=0 ts=68359bb1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=Ov6ESQcs1Ole_dG7abYA:9
X-Proofpoint-GUID: Nase4qw9x8dNKL9ZiG7-0NrCQ5sE0qkA
X-Proofpoint-ORIG-GUID: Nase4qw9x8dNKL9ZiG7-0NrCQ5sE0qkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

This series adds CN20K support to cnxk crypto PMD.

Tejasree Kondoj (3):
  crypto/cnxk: move debug dumps to common
  crypto/cnxk: add Rx inject in security lookaside
  doc: update CN20K CPT documentation

Vidya Sagar Velumuri (22):
  crypto/cnxk: add probe for cn20k crypto device
  crypto/cnxk: add ops skeleton for cn20k
  crypto/cnxk: add dev info get
  crypto/cnxk: add skeletion for enq deq functions
  crypto/cnxk: add lmtst routines for cn20k
  crypto/cnxk: add enqueue function support
  crypto/cnxk: add cryptodev dequeue support for cn20k
  crypto/cnxk: add rte security skeletion for cn20k
  crypto/cnxk: add security session creation
  crypto/cnxk: add security session destroy
  crypto/cnxk: move code to common
  crypto/cnxk: add rte sec session update
  crypto/cnxk: add rte security datapath handling
  crypto/cnxk: add skeleton for tls
  crypto/cnxk: add tls write session creation
  crypto/cnxk: add tls read session creation
  crypto/cnxk: add tls session destroy
  crypto/cnxk: add enq and dequeue support for TLS
  crypto/cnxk: tls post process
  crypto/cnxk: add tls session update
  crypto/cnxk: support raw API for cn20k
  crypto/cnxk: add model check for cn20k

 doc/guides/cryptodevs/cnxk.rst                |   26 +-
 doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
 drivers/common/cnxk/roc_cpt.h                 |    7 +-
 drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
 drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  125 +-
 drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
 drivers/crypto/cnxk/cn10k_ipsec.c             |    4 +-
 drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
 drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1278 +++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   85 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c     |  137 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h     |   64 +
 drivers/crypto/cnxk/cn20k_ipsec.c             |  378 +++++
 drivers/crypto/cnxk/cn20k_ipsec.h             |   41 +
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h      |  199 +++
 drivers/crypto/cnxk/cn20k_tls.c               |  917 ++++++++++++
 drivers/crypto/cnxk/cn20k_tls.h               |   40 +
 drivers/crypto/cnxk/cn20k_tls_ops.h           |  250 ++++
 drivers/crypto/cnxk/cnxk_cryptodev.c          |   14 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   10 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  119 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   34 +-
 drivers/crypto/cnxk/cnxk_ipsec.h              |    2 +
 drivers/crypto/cnxk/meson.build               |    5 +
 27 files changed, 4117 insertions(+), 165 deletions(-)
 create mode 100644 doc/guides/cryptodevs/features/cn20k.ini
 create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h

-- 
2.25.1

