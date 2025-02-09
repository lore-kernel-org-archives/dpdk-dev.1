Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983BBC0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74ADB40647;
	Sun,  9 Feb 2025 18:28:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 849CB402B7
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU0DFDarKoc6u6JBeak2cCZw9YqLoScRwTnCQa3g4BY=;
 b=NQR5hZpcgczWLpelVRdgpppTAPF/S6oNtnm8rnx3OfCZrLx7mrE8SZoDzLiGhgtYRsIoL3
 dG0Ke652Ycnsckc8rDDOocGz6jNhk8mer50eTY2NPmkvgqMFU3n/3eePzbp8Wp4yyNePec
 ig427MVuRfnEFqL4A/pc64P5PmwH2pg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-uTpZPZaKPEiBC-9fYI9wtA-1; Sun,
 09 Feb 2025 12:28:56 -0500
X-MC-Unique: uTpZPZaKPEiBC-9fYI9wtA-1
X-Mimecast-MFC-AGG-ID: uTpZPZaKPEiBC-9fYI9wtA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A061800268; Sun,  9 Feb 2025 17:28:54 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4ED31956094; Sun,  9 Feb 2025 17:28:52 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC v2 00/10] Remove weak symbols
Date: Sun,  9 Feb 2025 18:28:38 +0100
Message-ID: <20250209172850.2429075-1-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tziJGSfR7tulEMZwqI2KAF_cPt3FsmwesufUPeAeqow_1739122135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This is an alternative to André series:
https://inbox.dpdk.org/dev/1735009552-31906-1-git-send-email-andremue@linux.microsoft.com/

Weak symbols can be easily replaced with some linking updates, and make
it clearer which symbols are actually ending up in the final binary.


-- 
David Marchand

Changes since v1:
- fix net/hns3 build for Arm64 without SVE,


David Marchand (10):
  bus/auxiliary: remove weak symbols
  common/qat: remove weak symbols
  drivers: remove weak symbols in Nitrox drivers
  net/enic: remove weak symbols
  net/hns3: remove weak symbols
  net/fm10k: remove weak symbols
  net/nfp: remove weak symbols
  net/virtio: remove weak symbols
  app/compress-perf: remove weak symbols
  eal: deprecate weak symbols

 app/test-compress-perf/main.c            | 62 --------------------
 doc/guides/rel_notes/release_25_03.rst   |  2 +
 drivers/bus/auxiliary/auxiliary_common.c |  6 +-
 drivers/bus/auxiliary/meson.build        |  1 +
 drivers/common/nitrox/meson.build        |  3 -
 drivers/common/nitrox/nitrox_device.c    | 75 +++++++++---------------
 drivers/common/nitrox/nitrox_device.h    | 16 +++++
 drivers/common/nitrox/version.map        |  1 +
 drivers/common/qat/qat_qp.c              |  8 ---
 drivers/common/qat/qat_qp.h              |  5 --
 drivers/compress/nitrox/meson.build      |  2 -
 drivers/compress/nitrox/nitrox_comp.c    |  6 ++
 drivers/crypto/nitrox/meson.build        |  2 -
 drivers/crypto/nitrox/nitrox_sym.c       |  6 ++
 drivers/net/enic/enic_main.c             |  8 +--
 drivers/net/enic/meson.build             |  1 +
 drivers/net/hns3/hns3_rxtx.c             | 22 ++++---
 drivers/net/intel/fm10k/fm10k_ethdev.c   | 20 ++++---
 drivers/net/nfp/meson.build              |  7 ++-
 drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c |  2 +-
 drivers/net/nfp/nfp_rxtx_vec_stub.c      |  4 +-
 drivers/net/virtio/meson.build           |  5 ++
 drivers/net/virtio/virtio_rxtx.c         |  6 +-
 drivers/net/virtio/virtio_rxtx_simple.c  |  4 +-
 lib/eal/include/rte_common.h             |  6 +-
 25 files changed, 119 insertions(+), 161 deletions(-)

-- 
2.48.1

