Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFDC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45DF740261;
	Tue, 18 Feb 2025 16:37:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D4784014F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5fsKkQWxd4NUQpsV3oY6+BwUlgkWzMM7bAxfzegaOM=;
 b=VFAPfTROcuP2NFkYZNnZYDVAIyHHYLA4b1xo1Lls29imrkYvI1bRobI5Su6/uCosXAEb9q
 ArYeKer7mA+7sfu4SaVeSNnm5F9R7JqqsmNo5b8DfGGJeOowBO/ucroYX6d1VF8irTafY4
 2ZydINrxO7UpkFFSXlX0u+I1ouf9u5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-kJdqgU9ANxuu5mBiGpEaqA-1; Tue,
 18 Feb 2025 10:37:36 -0500
X-MC-Unique: kJdqgU9ANxuu5mBiGpEaqA-1
X-Mimecast-MFC-AGG-ID: kJdqgU9ANxuu5mBiGpEaqA_1739893055
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF2261800360; Tue, 18 Feb 2025 15:37:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A0861800368; Tue, 18 Feb 2025 15:37:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v3 00/10] Remove weak symbols
Date: Tue, 18 Feb 2025 16:37:14 +0100
Message-ID: <20250218153730.773836-1-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zbkT1T-78yTU8vSI_fox_Wqz10a_2CTNOXL3R57kQ5Y_1739893055
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

Changes since v2:
- rebased,

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

