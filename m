Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57994CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B3940264;
	Fri,  7 Nov 2025 08:35:10 +0100 (CET)
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com
 [115.124.28.100])
 by mails.dpdk.org (Postfix) with ESMTP id 4ED384021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:35:07 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fH1I0G3_1762500901 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 07 Nov 2025 15:35:04 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/4] NBL add new features
Date: Thu,  6 Nov 2025 23:34:55 -0800
Message-Id: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
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

Add support for Tx and Rx VLAN offload.
Add support for imissed stats.

Dimon Zhao (4):
  net/nbl: change default Rx extension header size to 12 bytes
  net/nbl: add support for Tx and Rx VLAN offload
  net/nbl: add support for imissed stats
  net/nbl: update documentation and maintainers

 .mailmap                                      |   2 +-
 MAINTAINERS                                   |   2 +-
 doc/guides/nics/features/nbl.ini              |   1 +
 doc/guides/nics/nbl.rst                       |   7 +
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 222 +++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  10 +
 drivers/net/nbl/nbl_dispatch.c                |  65 +++++
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  53 ++++-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |   5 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   4 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   4 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   9 +-
 13 files changed, 377 insertions(+), 8 deletions(-)

-- 
2.34.1

