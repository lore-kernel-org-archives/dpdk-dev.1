Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E1606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5954060C;
	Thu, 26 Nov 2026 08:34:44 +0100 (CET)
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com
 [115.124.28.99])
 by mails.dpdk.org (Postfix) with ESMTPS id A01DB402B2
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:41 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1361285|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0727828-0.00325142-0.923966;
 FP=16884529481747445392|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033024148021; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=2; RT=2; SR=0; TI=SMTPD_---.kAe1Yok_1795678475; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Yok_1795678475 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:37 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 00/11] net/nbl: add Draco support
Date: Thu, 26 Nov 2026 15:34:17 +0800
Message-ID: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for Nebulamatrix Draco adapters to the NBL PMD.

Dimon Zhao (11):
  net/nbl: prepare common interfaces for draco
  net/nbl: add draco HW layer
  net/nbl: add draco channel layer
  net/nbl: add draco resource layer
  net/nbl: add draco dispatch layer
  net/nbl: add draco device layer
  net/nbl: support draco queue setup and release
  net/nbl: support draco Tx and Rx burst
  net/nbl: support draco stats and xstats
  net/nbl: support draco hardware VLAN offload
  doc: update nbl driver guide for draco

 doc/guides/nics/nbl.rst                       |   8 +
 drivers/net/nbl/meson.build                   |   2 +
 drivers/net/nbl/nbl_core.c                    |  19 +-
 drivers/net/nbl/nbl_core.h                    |  10 +
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  85 +++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   5 +-
 drivers/net/nbl/nbl_dispatch.c                | 170 ++++++++---
 drivers/net/nbl/nbl_dispatch.h                |   1 +
 drivers/net/nbl/nbl_ethdev.c                  |   9 +
 drivers/net/nbl/nbl_hw/nbl_channel.c          | 135 ++++-----
 drivers/net/nbl/nbl_hw/nbl_channel.h          |  91 ++++--
 drivers/net/nbl/nbl_hw/nbl_hw.h               |   4 +
 .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c   | 244 ++++++++++++++++
 .../nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h   |  62 ++++
 .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c   | 274 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h   |  10 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 181 ++++++------
 drivers/net/nbl/nbl_hw/nbl_resource.h         |  80 +++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  74 ++++-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  10 +-
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   2 +
 drivers/net/nbl/nbl_include/nbl_def_hw.h      |   5 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   5 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  10 +
 24 files changed, 1247 insertions(+), 249 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_hw_draco_snic.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_draco/nbl_res_draco.h

-- 
2.53.0

