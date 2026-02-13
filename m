Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75466EDF155
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 11:21:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE7C402F1;
	Fri, 13 Feb 2026 12:21:58 +0100 (CET)
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51]) by mails.dpdk.org (Postfix) with ESMTP id 3ADAA40287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 12:21:55 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gWYaBmL_1770981709 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 13 Feb 2026 19:21:52 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/1] support igb uio driver for VF devices
Date: Fri, 13 Feb 2026 03:21:29 -0800
Message-Id: <20260213112130.49185-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Due to a chip design limitation, only the VF
supports the igb_uio driver. The PF does not.

Dimon Zhao (1):
  net/nbl: add igb uio support for NBL VF devices

 doc/guides/nics/nbl.rst                       | 12 +++++
 doc/guides/rel_notes/release_26_03.rst        |  4 ++
 drivers/net/nbl/nbl_core.c                    |  5 ++
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 28 +++++++++--
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  3 ++
 drivers/net/nbl/nbl_dispatch.c                | 49 +++++++++++++++++++
 drivers/net/nbl/nbl_ethdev.c                  | 13 +++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c | 14 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |  9 ++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 10 ++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  5 ++
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |  3 ++
 drivers/net/nbl/nbl_include/nbl_def_hw.h      |  3 ++
 .../net/nbl/nbl_include/nbl_def_resource.h    |  3 ++
 14 files changed, 157 insertions(+), 4 deletions(-)

-- 
2.34.1

