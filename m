Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D0CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74BFC40297;
	Mon, 19 Oct 2026 15:48:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C06E84028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792417710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=niy9Kf/Np90puAY6YlzPn3p7Np01RPgYBb7C/pyBZ5Q=;
 b=bPq801lPutTdSN5e24CRRbYVyXT7gzm1o02XEZ7WPpQKyhQNPjvuqOQtZ1Fwf0TaxIkUT/
 o3Qg/++PmfL0pHb3/fgwETnUlepfUpPa+5n7UyjbgJnQMuDbAwtt6mKDcJpIM9EtPjsNfi
 JCXloZCqrroBUSpk6BZ07pY23Uy4SmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-unLirvkkNraKvVdW4p3A2A-1; Mon,
 19 Oct 2026 13:48:27 +0000
X-MC-Unique: unLirvkkNraKvVdW4p3A2A-1
X-Mimecast-MFC-AGG-ID: unLirvkkNraKvVdW4p3A2A_1792417706
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7434B1977505; Mon, 19 Oct 2026 13:48:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88ABB1803A6F; Mon, 19 Oct 2026 13:48:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com,
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 0/9] Add vduse live migration features
Date: Mon, 19 Oct 2026 15:47:59 +0200
Message-ID: <20261019134808.192525-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FpSmzikwq_LEQsyqRMTVflArNmbU-kEQDB-Q6l7h7U8_1792417706
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

v5:
* Update headers to 7.3
* Rebase on top of main, merge conflicts.

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
  uapi: import VDUSE and VFIO header from v7.3 kernel
  vhost: Support VDUSE QUEUE_READY feature
  vhost: Support vduse suspend feature

Maxime Coquelin (6):
  vhost: introduce ASID support
  vhost: add VDUSE API version negotiation
  vhost: add virtqueues groups support to VDUSE
  vhost: add ASID support to VDUSE IOTLB operations
  vhost: claim VDUSE support for API version 1
  vhost: add net status feature to VDUSE

 kernel/linux/uapi/linux/iommufd.h | 105 +++++++++++-
 kernel/linux/uapi/linux/stddef.h  |   4 +
 kernel/linux/uapi/linux/vduse.h   | 113 ++++++++++++-
 kernel/linux/uapi/linux/vfio.h    |  51 +++++-
 kernel/linux/uapi/version         |   2 +-
 lib/vhost/iotlb.c                 | 233 +++++++++++++++++----------
 lib/vhost/iotlb.h                 |  14 +-
 lib/vhost/vduse.c                 | 259 +++++++++++++++++++++++++++---
 lib/vhost/vduse.h                 |   3 +-
 lib/vhost/vhost.c                 |  16 +-
 lib/vhost/vhost.h                 |  16 +-
 lib/vhost/vhost_user.c            |  13 +-
 12 files changed, 676 insertions(+), 153 deletions(-)

-- 
2.56.0

