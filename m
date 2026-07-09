Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B4C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4649402CC;
	Thu,  9 Jul 2026 18:02:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39B5B40268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783612975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r+eRyJYpN9zKBfXLmZSJlxRysHOaFLepNvOVAop5n38=;
 b=Jvu3hnO5JDCbU5beUL68FAYsvbo7tutgbammtwLdt2xe2A6HxhZjaCixogDx+Q6nCd9haW
 lhNMt2n2H9Z/21Ab0087M0RV4rSfOUXMLTxMIYOCic3AdeNFJr3SBbyT/8TEhAV5As2Qc8
 8HykOBczGCZB0Oy5YKXzf32lUdcn1/E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-q1kOWkpDPvKJ6UbBMVaJaA-1; Thu,
 09 Jul 2026 12:02:53 -0400
X-MC-Unique: q1kOWkpDPvKJ6UbBMVaJaA-1
X-Mimecast-MFC-AGG-ID: q1kOWkpDPvKJ6UbBMVaJaA_1783612973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD38E1955F61
 for <dev@dpdk.org>; Thu,  9 Jul 2026 16:02:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8352A1800591; Thu,  9 Jul 2026 16:02:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v4 00/10] Remove limitations coming from legacy VMDq
Date: Thu,  9 Jul 2026 18:02:36 +0200
Message-ID: <20260709160247.1798575-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sV0gWl08v_0L9egPRg1ld5IlIJQrViMMd0u7SfILeU8_1783612973
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
VMDq has been imposing a maximum number of mac addresses in the
mac_addr_add/del API.

Nowadays, new Intel drivers do not support the feature and few other
drivers implement this feature.

This series enforces that the driver announces VMDq pools before
using VMDq related features, then remove the limit of number of
mac addresses for others.

Next step could be to remove the VMDq pool notion from the generic API.
However I have some concern about this, as changing the quite stable
mac_addr_add/del API now seems a lot of noise for not much benefit.


-- 
David Marchand

Changes since v3:
- rebased (this series is too late for 26.07),
- update some doxygen comments,
- added mlx5 changes,

Changes since v2:
- changed approach: did not introduce a new device capability,
  relied on already existing dev_info->max_vmdq_pools,
- fixed duplicate mac addition without VMDq,
- updated documentation,

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,
- fixed buffer overflow on mailbox messages during port restart/VF reset,
- fixed duplicate MAC address installation on port start/restart,

David Marchand (10):
  ethdev: check VMDq availability
  ethdev: skip VMDq pools unless configured
  ethdev: hide VMDq internal sizes
  net/iavf: accept up to 32k unicast MAC addresses
  net/iavf: fix duplicate MAC addresses install
  net/mlx5: remove MAC addresses flush helper on Linux
  net/mlx5: remove redundant MAC address index checks
  net/mlx5: pass maximum number of unicast MAC to common code
  net/mlx5: use bitset for tracking MAC addresses
  net/mlx5: accept more unicast MAC addresses

 doc/guides/rel_notes/release_26_07.rst |  16 ++++
 drivers/common/mlx5/linux/mlx5_nl.c    |  90 +++++---------------
 drivers/common/mlx5/linux/mlx5_nl.h    |  11 +--
 drivers/common/mlx5/mlx5_common.h      |  24 ------
 drivers/common/mlx5/mlx5_devx_cmds.c   |   4 +
 drivers/common/mlx5/mlx5_devx_cmds.h   |   2 +
 drivers/net/cnxk/cnxk_ethdev_ops.c     |   1 -
 drivers/net/intel/iavf/iavf.h          |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |  43 ++++++----
 drivers/net/intel/iavf/iavf_vchnl.c    | 113 ++++++++++++++++++-------
 drivers/net/mlx5/linux/mlx5_os.c       |  61 +++++++++----
 drivers/net/mlx5/mlx5.c                |   9 +-
 drivers/net/mlx5/mlx5.h                |  17 +++-
 drivers/net/mlx5/mlx5_ethdev.c         |   2 +-
 drivers/net/mlx5/mlx5_mac.c            |  22 +++--
 drivers/net/mlx5/mlx5_trigger.c        |  12 +--
 drivers/net/mlx5/windows/mlx5_os.c     |  48 ++++++++---
 lib/ethdev/ethdev_driver.h             |   8 +-
 lib/ethdev/rte_ethdev.c                |  68 +++++++++++----
 lib/ethdev/rte_ethdev.h                |   8 +-
 20 files changed, 340 insertions(+), 224 deletions(-)

-- 
2.54.0

