Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B2CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 12:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADFAD4027E;
	Wed,  6 May 2026 14:36:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE7540275
 for <dev@dpdk.org>; Wed,  6 May 2026 14:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5rO3R0FE2lPVE8tmJ1Ls7QatypFFcVighGSxPWvmPY=;
 b=FtHz6fHHEfdTv1Po7bsDXkbNWmS52fdFLn3+L1Acr7xEHprmFhzxfn/dCIhuCLDJ3xtFEo
 pHLkc/RblbMVzArBFwhLd8cBagcmgk8tst2jdAx1bS/3ul+4XG3gl5eTbM5cgqJWzs09v0
 XUrccHL+EFxO3hUNh9lScJcZTM3SQao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-CvhkyKPFPoOy2234EzgVcA-1; Wed,
 06 May 2026 08:36:03 -0400
X-MC-Unique: CvhkyKPFPoOy2234EzgVcA-1
X-Mimecast-MFC-AGG-ID: CvhkyKPFPoOy2234EzgVcA_1778070962
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96A2E19560B9
 for <dev@dpdk.org>; Wed,  6 May 2026 12:36:02 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEF1B1801A63
 for <dev@dpdk.org>; Wed,  6 May 2026 12:36:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH v2 0/5] Remove limitations coming from legacy VMDq
Date: Wed,  6 May 2026 14:35:48 +0200
Message-ID: <20260506123554.2524136-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XrXVdCXZZ-yAKpYf3pBwkoLsowpd95AcPM46jSa4lQA_1778070962
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

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,
- fixed buffer overflow on mailbox messages during port restart/VF reset,
- fixed duplicate MAC address installation on port start/restart,


David Marchand (5):
  ethdev: skip VMDq pools unless configured
  ethdev: announce VMDq capability
  ethdev: hide VMDq internal sizes
  net/iavf: accept up to 32k unicast MAC addresses
  net/iavf: fix duplicate MAC addresses install

 drivers/net/bnxt/bnxt_ethdev.c         |   3 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c     |   1 -
 drivers/net/intel/e1000/igb_ethdev.c   |   1 +
 drivers/net/intel/fm10k/fm10k_ethdev.c |   1 +
 drivers/net/intel/i40e/i40e_ethdev.c   |   3 +-
 drivers/net/intel/iavf/iavf.h          |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |  41 ++++++---
 drivers/net/intel/iavf/iavf_vchnl.c    | 117 ++++++++++++++++++-------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c |   2 +
 drivers/net/txgbe/txgbe_ethdev.c       |   1 +
 drivers/net/txgbe/txgbe_ethdev_vf.c    |   1 +
 lib/ethdev/ethdev_driver.h             |   8 +-
 lib/ethdev/rte_ethdev.c                |  45 ++++++++--
 lib/ethdev/rte_ethdev.h                |   8 +-
 14 files changed, 172 insertions(+), 65 deletions(-)

-- 
2.53.0

