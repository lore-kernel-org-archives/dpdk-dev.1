Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA35AC531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85F564028A;
	Thu, 23 Jul 2026 14:42:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6D3C440274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 14:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784810528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xslb2BsALQWUC+2PwjRnCQY2+jb0O0NHiA2TJYryrTE=;
 b=hAIiZZI/1mGG9CECkQR+ISqx3iC3J6zVatSWGlnlaBuY7zLbC/MWzp5pGxh4JVYZEnv8bw
 bFGiYZ1OThdvv6CuDJHQ3pl+nD6UMAZZRHjqZ/XfYOEFZwIryHZD0lV3Yr9vO7ynM0r6uo
 siTyyOxQZ6bLvoqgM0QpRyiCqJNXG3s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Jl2-0JMPPO6kIyL88CQ86w-1; Thu,
 23 Jul 2026 08:42:07 -0400
X-MC-Unique: Jl2-0JMPPO6kIyL88CQ86w-1
X-Mimecast-MFC-AGG-ID: Jl2-0JMPPO6kIyL88CQ86w_1784810526
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC33919540FC
 for <dev@dpdk.org>; Thu, 23 Jul 2026 12:42:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80EC3D73; Thu, 23 Jul 2026 12:42:05 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v5 00/10] Remove limitations coming from legacy VMDq
Date: Thu, 23 Jul 2026 14:41:46 +0200
Message-ID: <20260723124200.3069410-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1O9O1hiQNXPoa5b_W_02SRSYPIRpVDTz6lNR3ZjomBA_1784810526
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

Changes since v4:
- rebased,
- moved mac restoration in dedicated IAVF reset helper,
- fixed inverted arguments when calling mlx5 mac sync,

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

 doc/guides/rel_notes/release_26_11.rst |  21 +++++
 drivers/common/mlx5/linux/mlx5_nl.c    |  90 +++++---------------
 drivers/common/mlx5/linux/mlx5_nl.h    |  11 +--
 drivers/common/mlx5/mlx5_common.h      |  24 ------
 drivers/common/mlx5/mlx5_devx_cmds.c   |   4 +
 drivers/common/mlx5/mlx5_devx_cmds.h   |   2 +
 drivers/net/cnxk/cnxk_ethdev_ops.c     |   1 -
 drivers/net/intel/iavf/iavf.h          |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |  44 ++++++----
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
 20 files changed, 346 insertions(+), 224 deletions(-)

-- 
2.54.0

