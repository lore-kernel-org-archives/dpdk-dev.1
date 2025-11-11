Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D3CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33FD4026A;
	Tue, 11 Nov 2025 12:32:02 +0100 (CET)
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
 by mails.dpdk.org (Postfix) with ESMTP id 45E2740144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:32:00 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fJvT83V_1762860714 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 11 Nov 2025 19:31:57 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v2 0/4] NBL add new features
Date: Tue, 11 Nov 2025 03:31:39 -0800
Message-Id: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
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
Add IOVA mode check in Coexistence.

Dimon Zhao (4):
  net/nbl: change default Rx extension header size to 12 bytes
  net/nbl: add support for Tx and Rx VLAN offload
  net/nbl: add support for imissed stats
  net/nbl: add IOVA mode check in Coexistence

 .mailmap                                      |   2 +-
 MAINTAINERS                                   |   2 +-
 doc/guides/nics/features/nbl.ini              |   1 +
 doc/guides/nics/nbl.rst                       |   7 +
 drivers/net/nbl/nbl_common/nbl_userdev.c      |  15 +-
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 217 +++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   9 +
 drivers/net/nbl/nbl_dispatch.c                |  65 ++++++
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   2 -
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  46 ++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |   5 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   4 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   4 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   6 +
 14 files changed, 373 insertions(+), 12 deletions(-)

-- 
2.34.1

