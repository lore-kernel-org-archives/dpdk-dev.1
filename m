Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E22CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 01:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA80740270;
	Fri, 31 Oct 2025 02:44:26 +0100 (CET)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id EA8CD4026F
 for <dev@dpdk.org>; Fri, 31 Oct 2025 02:44:24 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fBP37mx_1761875059 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 31 Oct 2025 09:44:22 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 0/1] NBL use hardware MAC addr instead of random one
Date: Thu, 30 Oct 2025 18:44:15 -0700
Message-Id: <20251031014417.3424934-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

The previous implementation used random MAC addresses for rte_eth_dev.
This change retrieves and uses the actual hardware MAC address from
the network device.

Dimon Zhao (1):
  net/nbl: use hardware MAC address instead of random one

 drivers/net/nbl/nbl_common/nbl_userdev.c      | 40 +++++++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  1 +
 drivers/net/nbl/nbl_dispatch.c                | 15 ++++++-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  1 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  4 ++
 6 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.34.1

