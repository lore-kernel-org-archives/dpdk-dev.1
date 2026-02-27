Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2EFD9E2D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0BDC4028E;
	Fri, 27 Feb 2026 03:57:57 +0100 (CET)
Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com
 [115.124.28.100])
 by mails.dpdk.org (Postfix) with ESMTP id EAB9E40265
 for <dev@dpdk.org>; Fri, 27 Feb 2026 03:57:54 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gfuCFhN_1772161069 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 27 Feb 2026 10:57:51 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v4 0/1] NBL add probe checks for unsupported UIO drivers
Date: Thu, 26 Feb 2026 18:57:32 -0800
Message-Id: <20260227025734.46870-1-dimon.zhao@nebula-matrix.com>
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

The NBL PMD does not support igb_uio (deprecated) or uio_pci_generic
(lacks MSI-X support). Add explicit checks in probe to reject devices
bound to these drivers with clear error messages.
Update documentation to reflect these limitations.

Dimon Zhao (1):
  net/nbl: add probe checks for unsupported UIO drivers

 doc/guides/nics/nbl.rst      | 14 ++++++++++++++
 drivers/net/nbl/nbl_core.c   |  2 ++
 drivers/net/nbl/nbl_ethdev.c | 11 +++++++++++
 3 files changed, 27 insertions(+)

-- 
2.34.1

