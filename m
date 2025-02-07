Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C7C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B23B427A7;
	Fri,  7 Feb 2025 09:33:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D58C402C9
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BdQSJBKPeCoZlmdDZCH0PYdvREnoynGdR4ikoVe5baU=;
 b=b23wSaKzyt5JQQk5tGUpl16uPRbMJ4TwpXz77Bz3E3Z4peX0VO4NCmoJ0KmMi2F6rOeP2t
 BJrCcGVrnPgFsWtcl6ChbtM5Ia6++YkBEl4Ek5y+QRrAqamSX3I/LKP8F3whqMD5acBZ1L
 6J81kxinHcYznQ7De0Vs4FHELUU1eHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-X5pu2vs-M02VJOA-4a-Ftw-1; Fri,
 07 Feb 2025 03:32:58 -0500
X-MC-Unique: X5pu2vs-M02VJOA-4a-Ftw-1
X-Mimecast-MFC-AGG-ID: X5pu2vs-M02VJOA-4a-Ftw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05763180087E; Fri,  7 Feb 2025 08:32:57 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 288C530001AB; Fri,  7 Feb 2025 08:32:54 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC 00/10] Remove weak symbols
Date: Fri,  7 Feb 2025 09:32:40 +0100
Message-ID: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RxmSLA55ql39lpB6fkrVR-CYWYfNQThVg-Kd6Zkf38A_1738917177
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

