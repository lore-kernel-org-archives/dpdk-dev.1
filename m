Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4950ACCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC6440291;
	Fri, 16 Oct 2026 15:06:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7F9FC400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792155963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QQC8wOKUH1K65bbvlO2rLfvHg0a4cXVERjaxH4uw8qs=;
 b=McbeB8d75R/NvqX1iKzk80Gu8eCejEesCimhYy74LdBn4mYrzRuCdNc3uNBL7IzAVnxN8W
 z+Q7+DQe3+52dpehhFN555ZC8X9SOKzapdKOEFhjKgPRgZWGk0ptuYRT4kZ/WmayO+5YvA
 e5iGI+1JNoWa1Ld1RNO7ASvfvYQ5tE4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-kN0n42ZKOzG7RQ4M5dxpsQ-1; Fri,
 16 Oct 2026 13:06:00 +0000
X-MC-Unique: kN0n42ZKOzG7RQ4M5dxpsQ-1
X-Mimecast-MFC-AGG-ID: kN0n42ZKOzG7RQ4M5dxpsQ_1792155959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4771218011FD; Fri, 16 Oct 2026 13:05:59 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D41018005AD; Fri, 16 Oct 2026 13:05:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH 0/8] Validate multiqueue configuration in ethdev
Date: Fri, 16 Oct 2026 15:05:46 +0200
Message-ID: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: emHWmkfteeayV6B6_jFZwD3WA6NGm8rwckhjO0kMcnY_1792155959
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

We have various checks in drivers about Rx and Tx multiqueue
configuration.
This series is a followup of the VMDq cleanup, finishing the job with
DCB and RSS, and then rejecting invalid multiqueue configuration (useful
from an ABI point of view).

Some drivers misreported their capabilities.
It is important drivers maintainers review carefully those changes.


-- 
David Marchand

David Marchand (8):
  net/bnxt: remove leftover VMDq code in MAC helpers
  drivers/net: fix reported VMDq capability
  drivers/net: remove check on VMDq modes
  devtools: check VMDq capability
  ethdev: check DCB availability
  drivers/net: fix reported RSS capability
  ethdev: check RSS availability
  ethdev: check unknown Rx/Tx multi-queue modes

 devtools/check-doc-vs-code.sh             | 70 ++++++++++++++++++++++-
 doc/guides/nics/features/failsafe.ini     |  2 +
 doc/guides/nics/features/nbl.ini          |  1 +
 doc/guides/nics/features/netvsc.ini       |  1 +
 doc/guides/rel_notes/release_26_11.rst    | 14 ++++-
 drivers/net/atlantic/atl_ethdev.c         |  2 -
 drivers/net/bnxt/bnxt_ethdev.c            | 65 +++++----------------
 drivers/net/bnxt/bnxt_rxq.c               | 14 +----
 drivers/net/cnxk/cnxk_ethdev.c            | 11 ----
 drivers/net/cnxk/cnxk_rep_ops.c           | 16 +-----
 drivers/net/cxgbe/cxgbe_ethdev.c          |  1 -
 drivers/net/dpaa/dpaa_ethdev.c            |  1 -
 drivers/net/dpaa2/dpaa2_ethdev.c          |  1 -
 drivers/net/hns3/hns3_dcb.c               |  9 ---
 drivers/net/intel/cpfl/cpfl_ethdev.c      | 19 +-----
 drivers/net/intel/cpfl/cpfl_representor.c |  4 +-
 drivers/net/intel/e1000/igb_ethdev.c      | 21 +------
 drivers/net/intel/e1000/igb_rxtx.c        | 39 -------------
 drivers/net/intel/e1000/igc_ethdev.c      | 19 ------
 drivers/net/intel/fm10k/fm10k_ethdev.c    | 14 +----
 drivers/net/intel/i40e/i40e_ethdev.c      |  5 --
 drivers/net/intel/idpf/idpf_ethdev.c      |  9 +--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |  4 --
 drivers/net/mvneta/mvneta_ethdev.c        |  7 ---
 drivers/net/mvpp2/mrvl_ethdev.c           |  7 ---
 drivers/net/nbl/nbl_dev/nbl_dev.c         |  6 --
 drivers/net/nfp/nfp_net_common.c          | 15 -----
 drivers/net/ngbe/ngbe_ethdev_vf.c         |  1 -
 drivers/net/octeontx/octeontx_ethdev.c    | 11 ----
 drivers/net/qede/qede_ethdev.c            |  5 --
 drivers/net/sfc/sfc_repr.c                | 16 +-----
 drivers/net/sfc/sfc_rx.c                  | 21 +------
 drivers/net/sfc/sfc_tx.c                  |  9 ---
 drivers/net/thunderx/nicvf_ethdev.c       | 12 ----
 drivers/net/txgbe/txgbe_ethdev_vf.c       |  1 -
 drivers/net/virtio/virtio_ethdev.c        | 14 -----
 drivers/net/xsc/xsc_ethdev.c              |  2 +
 drivers/net/zxdh/zxdh_ethdev.c            | 19 ------
 lib/ethdev/rte_ethdev.c                   | 41 +++++++++++++
 39 files changed, 155 insertions(+), 374 deletions(-)

-- 
2.54.0

