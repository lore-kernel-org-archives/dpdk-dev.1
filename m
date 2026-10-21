Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA5606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XEuS8qnq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F8DD4068A;
	Wed, 21 Oct 2026 12:30:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D0B2940041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W07BNlXAqkrZ29QYwnkJY/5IHcLOslZ7rlu8glRw1IA=;
 b=XEuS8qnqOot9cMGuOZqs54nK5f5Jg6ALJAh6R0jdL2YN5ur6n1tFqZTi6L6R9fFCFN3SNq
 FtFYNrMC5ONkWSjxqSyRoDZXqNhMPY/Mh5DW6yakeOGzKsSUw1lQZs82dWInc0P3sLwcrH
 KctMMaCr0UfOykLK5kTe7A/GdmsKcWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-OJEZdfk9NUiNS4p_VnWtmw-1; Wed,
 21 Oct 2026 06:30:32 -0400
X-MC-Unique: OJEZdfk9NUiNS4p_VnWtmw-1
X-Mimecast-MFC-AGG-ID: OJEZdfk9NUiNS4p_VnWtmw_1792578632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92671800840; Wed, 21 Oct 2026 10:30:31 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE7FB1956087; Wed, 21 Oct 2026 10:30:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net
Subject: [PATCH v2 00/12] Validate multiqueue configuration in ethdev
Date: Wed, 21 Oct 2026 12:30:14 +0200
Message-ID: <20261021103027.2050351-1-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5nO4u3q9mMC4UkHFwhO67pYfnHa6OPXTlqkU4CGJAgI_1792578632
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We have various checks in drivers about Rx and Tx multiqueue
configuration.
This series is a followup of the VMDq cleanup, finishing the job with
DCB and RSS, and then rejecting invalid multiqueue configuration (useful
from an ABI point of view).

Some drivers misreported their capabilities.
It is important drivers maintainers review carefully those changes.


-- 
David Marchand

Changes since v1:
- fixed handling of drivers/net/intel (and fixed related rte_flow
  issues),
- fixed handling of multiple drivers in one driver sources,
- finished bnxt cleanup,
- fixed various inconsistencies in drivers code and doc,
- updated all applications and examples and relaxed check on RSS
  (now allowed with nb_rxq == 1 for drivers that have no RSS support),


David Marchand (12):
  devtools: fix matching in doc check
  doc: fix L2TPv2 and PPP matching support for ICE
  devtools: handle multiple drivers in doc check
  net/bnxt: remove leftover VMDq code in MAC helpers
  drivers/net: fix reported VMDq capability
  drivers/net: remove check on VMDq modes
  devtools: check VMDq capability
  doc: fix DCB capability for some Intel drivers
  ethdev: check DCB availability
  drivers/net: fix reported RSS capability
  ethdev: check RSS availability
  ethdev: check unknown Rx/Tx multi-queue modes

 MAINTAINERS                                   |   2 +-
 app/graph/ethdev.c                            |   7 +-
 app/test-eventdev/test_perf_common.c          |   2 +
 app/test-eventdev/test_pipeline_common.c      |   2 +
 devtools/check-doc-vs-code.sh                 | 146 +++++++++++++++++-
 .../features/{afpacket.ini => af_packet.ini}  |   2 +-
 .../features/{cxgbevf.ini => cxgbe_vf.ini}    |   2 +-
 doc/guides/nics/features/failsafe.ini         |   2 +
 doc/guides/nics/features/ice.ini              |   2 +
 doc/guides/nics/features/igb.ini              |   1 -
 doc/guides/nics/features/ipn3ke.ini           |   5 -
 doc/guides/nics/features/nbl.ini              |   1 +
 doc/guides/nics/features/netvsc.ini           |   1 +
 doc/guides/rel_notes/release_26_11.rst        |  14 +-
 drivers/net/atlantic/atl_ethdev.c             |   2 -
 drivers/net/axgbe/axgbe_ethdev.c              |  21 +--
 drivers/net/bnxt/bnxt_ethdev.c                |  90 +++--------
 drivers/net/bnxt/bnxt_rxq.c                   |  14 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  11 --
 drivers/net/cnxk/cnxk_rep_ops.c               |  33 +---
 drivers/net/cxgbe/cxgbe_ethdev.c              |   1 -
 drivers/net/dpaa/dpaa_ethdev.c                |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              |   1 -
 drivers/net/hns3/hns3_dcb.c                   |   9 --
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  25 +--
 drivers/net/intel/cpfl/cpfl_representor.c     |   4 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  21 +--
 drivers/net/intel/e1000/igb_rxtx.c            |  39 -----
 drivers/net/intel/e1000/igc_ethdev.c          |  19 ---
 drivers/net/intel/e1000/igc_txrx.c            |  19 +--
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  14 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |   5 -
 drivers/net/intel/idpf/idpf_ethdev.c          |  15 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   4 -
 drivers/net/mvneta/mvneta_ethdev.c            |   7 -
 drivers/net/mvpp2/mrvl_ethdev.c               |   7 -
 drivers/net/nbl/nbl_dev/nbl_dev.c             |   6 -
 drivers/net/nfp/nfp_net_common.c              |  15 --
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   1 -
 drivers/net/octeontx/octeontx_ethdev.c        |  11 --
 drivers/net/qede/qede_ethdev.c                |   5 -
 drivers/net/sfc/sfc_repr.c                    |  41 +----
 drivers/net/sfc/sfc_rx.c                      |  29 +---
 drivers/net/sfc/sfc_tx.c                      |   9 --
 drivers/net/thunderx/nicvf_ethdev.c           |  20 +--
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   1 -
 drivers/net/virtio/virtio_ethdev.c            |  14 --
 drivers/net/xsc/xsc_ethdev.c                  |   4 +
 drivers/net/zxdh/zxdh_ethdev.c                |  19 ---
 examples/distributor/main.c                   |   2 +
 examples/dma/dmafwd.c                         |   2 +
 .../pipeline_worker_generic.c                 |   2 +
 .../eventdev_pipeline/pipeline_worker_tx.c    |   2 +
 examples/ip_reassembly/main.c                 |   2 +
 examples/ipsec-secgw/ipsec-secgw.c            |   2 +
 examples/l2fwd-event/l2fwd_common.c           |   2 +
 examples/l3fwd-graph/main.c                   |   2 +
 examples/l3fwd/main.c                         |   3 +-
 .../client_server_mp/mp_server/init.c         |  10 +-
 examples/multi_process/symmetric_mp/main.c    |   2 +
 examples/ntb/ntb_fwd.c                        |   2 +
 examples/pipeline/obj.c                       |   7 +-
 examples/qos_meter/main.c                     |   4 +
 examples/server_node_efd/efd_server/init.c    |   3 +
 lib/ethdev/rte_ethdev.c                       |  46 ++++++
 65 files changed, 317 insertions(+), 502 deletions(-)
 rename doc/guides/nics/features/{afpacket.ini => af_packet.ini} (70%)
 rename doc/guides/nics/features/{cxgbevf.ini => cxgbe_vf.ini} (90%)

-- 
2.54.0

