Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE70E7E345
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19BE640296;
	Fri,  3 Apr 2026 11:18:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 504974028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 11:18:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775207924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JrETdeP+32Nq2+2Nn76GfUpFLSKBjLrVhIVUOuHL4mc=;
 b=P1U2WhBYGwq1G8osJPFn0/sUVSQsmPgvF+BIZxhEF9OMjzqPrlTOBBtbwD6R4JmDUuPCTu
 4rLj7swCDqm38MRE/IVUMFmjgPEbdU4ND9pmghahAn/SG91gzt8byFxy/AzfKmAU8P8J/o
 5X2WTkztN6VzfWJel+fjv7ANaxsqSCM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-crwfvboRMMaCSqQ-6QCc1w-1; Fri,
 03 Apr 2026 05:18:43 -0400
X-MC-Unique: crwfvboRMMaCSqQ-6QCc1w-1
X-Mimecast-MFC-AGG-ID: crwfvboRMMaCSqQ-6QCc1w_1775207922
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D1D019560B2
 for <dev@dpdk.org>; Fri,  3 Apr 2026 09:18:42 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C7671955D6C; Fri,  3 Apr 2026 09:18:41 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	cfontain@redhat.com
Subject: [PATCH 0/4] Remove limitations coming from legacy VMDq
Date: Fri,  3 Apr 2026 11:18:31 +0200
Message-ID: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4NahsLGWDBtB-TW1h0LbNIwd5w94_K_anDCV8qpZL9k_1775207922
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

This series proposes to flag drivers that support the feature, and
remove the limit of number of mac addresses for others.

Next step could be to remove the VMDq pool notion from the generic API.
However I have some concern about this, as changing the quite stable
mac_addr_add/del API now seems a lot of noise for not much benefit.


-- 
David Marchand

David Marchand (4):
  ethdev: skip VMDq pools unless configured
  ethdev: announce VMDq capability
  ethdev: hide VMDq internal sizes
  net/iavf: accept up to 32k unicast MAC addresses

 drivers/net/bnxt/bnxt_ethdev.c                |  3 +-
 drivers/net/bnxt/bnxt_reps.c                  |  1 +
 drivers/net/cnxk/cnxk_ethdev_ops.c            |  1 -
 drivers/net/intel/e1000/em_ethdev.c           |  1 +
 drivers/net/intel/e1000/igb_ethdev.c          |  1 +
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  1 +
 drivers/net/intel/i40e/i40e_ethdev.c          |  3 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |  1 +
 drivers/net/intel/iavf/iavf.h                 |  5 ++-
 drivers/net/intel/iavf/iavf_ethdev.c          | 10 ++---
 drivers/net/intel/iavf/iavf_vchnl.c           |  6 +--
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  3 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 +
 drivers/net/txgbe/txgbe_ethdev.c              |  1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c           |  1 +
 lib/ethdev/ethdev_driver.h                    |  8 +++-
 lib/ethdev/rte_ethdev.c                       | 45 ++++++++++++++++---
 lib/ethdev/rte_ethdev.h                       |  8 +---
 18 files changed, 73 insertions(+), 28 deletions(-)

-- 
2.53.0

