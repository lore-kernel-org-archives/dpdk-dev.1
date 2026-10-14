Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9DCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9C0D40430;
	Wed, 14 Oct 2026 10:29:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 09A1940272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791966585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HTHFU7zX3kYmkW5W7oH3FfJyRP/C6dC2xb30YC+kwVE=;
 b=aPJxPxVNYE4ne5Jrx8AmWWDLnonST7U0eAtYu8c8yfTXVQjdCOzxU0Fi3TtlkeaN7FvZ5o
 hzE0Z0bg26hOqQewkL6D5L/ehiSCI7pjdGuj+4X7BoylYGIOp1dVbBF4jZauLdt6L5yj8p
 LvOsDLxCrIGRSKa02TXTgwbOp5P9SUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-kKYqW-OFMIGTQ_eqapASpw-1; Wed,
 14 Oct 2026 08:29:37 +0000
X-MC-Unique: kKYqW-OFMIGTQ_eqapASpw-1
X-Mimecast-MFC-AGG-ID: kKYqW-OFMIGTQ_eqapASpw_1791966576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93EF7195604F; Wed, 14 Oct 2026 08:29:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.174])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34A16180057F; Wed, 14 Oct 2026 08:29:31 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 chenbox@nvidia.com, david.marchand@redhat.com
Subject: [PATCH v4 0/9] Add vduse live migration features
Date: Wed, 14 Oct 2026 10:29:21 +0200
Message-ID: <20261014082930.96261-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBOjVsArZAA4tfO2XnLQK3PVbOX5fFzqXf4BcA62q2E_1791966576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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

This series introduces features to the VDUSE (vDPA Device in Userspace) driver
to support Live Migration.

Currently, DPDK does not support VDUSE devices live migration because the
driver lacks a mechanism to suspend the device and quiesce the rings to
initiate the switchover.  This series implements the suspend operation to
address this limitation.

Furthermore, enabling Live Migration for devices with control virtqueue
requires two additional features.  Both of them are included in this series.

* Address Spaces ID (ASID) support: This allows QEMU to isolate and intercept
  the device's CVQ. By doing so, QEMU is able to migrate the device status
  transparently, without requiring the device to support state save and
  restore.
* QUEUE_READY: This allows QEMU to control when the dataplane virtqueues are
  enabled.  This ensures the dataplane is started after the device
  configuration has been fully restored via the CVQ.

It also enables the VIRTIO_NET_F_STATUS feature.  This allows the device to
signal the driver that it needs to send gratuitous ARP with
VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.

Note that kernel headers are update to v7.3-rc7, not a stable version.  This
would allow to check if the patches pass the CIs while the kernel uapi is
published in 7.3.

v4:
* Rebase on top of origin/main, which already includes the __counted_by error
fix.
* Add VDUSE_SUSPEND to lib/vhost/vduse.c:vduse_reqs_str (Maxime).

v3:
* Include uapi/linux/stddef.h and revert the -D__counted_by from v2.

v2:
* Add -D__counted_by(X)= if the compiler does not support it. It is
  pulled by the kernel headers.

PATCH v1:
* Move to VDUSE_SET_FEATURES ioctl instead of config space field.
* Add a few bounds control.
* Update kernel headers to v7.3-rc3.

RFC v4:
* Sync headers with Linux's latest existing and proposed UAPI.  Both
  files constants and new ioctl VDUSE_SET_FEATURES.
* Check for more error conditions and clarified some error messages in
  ready message processing.
* Add relevant release notes.
* Fix cosmetic whitespaces & checkpath errors.
* Fix error path of vhost_user_iotlb_init and vhost_user_iotlb_init_one.
* Fix commits author.

RFC v3:
* Replace incorrect '%lx' DEBUG print format specifier with PRIx64

RFC v2:
* Following latest comments on kernel series about VDUSE features, not checking
  API version but only check if VDUSE_GET_FEATURES success.
* Move the start and last declarations in the braces as gcc 8 does not like
  them interleaved with statements. Actually, I think the move was a mistake in
  the first version.
  https://mails.dpdk.org/archives/test-report/2026-February/958175.html

Eugenio Pérez (3):
  uapi: import VDUSE and VFIO header from v7.3-rc7 kernel
  vhost: Support VDUSE QUEUE_READY feature
  vhost: Support vduse suspend feature

Maxime Coquelin (6):
  vhost: introduce ASID support
  vhost: add VDUSE API version negotiation
  vhost: add virtqueues groups support to VDUSE
  vhost: add ASID support to VDUSE IOTLB operations
  vhost: claim VDUSE support for API version 1
  vhost: add net status feature to VDUSE

 kernel/linux/uapi/linux/iommufd.h | 105 ++++++++++++-
 kernel/linux/uapi/linux/vduse.h   | 113 +++++++++++++-
 kernel/linux/uapi/linux/vfio.h    |  51 ++++++-
 kernel/linux/uapi/version         |   2 +-
 lib/vhost/iotlb.c                 | 233 ++++++++++++++++++-----------
 lib/vhost/iotlb.h                 |  14 +-
 lib/vhost/vduse.c                 | 240 ++++++++++++++++++++++++++++--
 lib/vhost/vduse.h                 |   3 +-
 lib/vhost/vhost.c                 |  16 +-
 lib/vhost/vhost.h                 |  16 +-
 lib/vhost/vhost_user.c            |  13 +-
 11 files changed, 659 insertions(+), 147 deletions(-)

-- 
2.56.0

