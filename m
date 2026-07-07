Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53548C44500
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D9C40264;
	Tue,  7 Jul 2026 14:45:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7A7B84025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eU0mJAAUQ0xznikFSiX0jgNQ0Eq+hfYHeUYC3IvcOWQ=;
 b=e7qkbMZQKI/0XtNCPwUYCRMftru3xp5HM2h9fUchpPl7R0b5p3HJ1sslVujS7rMhoc+wUw
 2SWNhUgh5zhwfbEYmWo5NTVgxZ7INI6x+9nXD9zuuI0isOuZocsgM0ebMjsCKtBztVgPVJ
 +enKsHkBG/CHMgSTNVzGNU/jDMiEmSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Zub5F5toPbeJTOX1pLcocA-1; Tue,
 07 Jul 2026 08:45:13 -0400
X-MC-Unique: Zub5F5toPbeJTOX1pLcocA-1
X-Mimecast-MFC-AGG-ID: Zub5F5toPbeJTOX1pLcocA_1783428312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C552195399E; Tue,  7 Jul 2026 12:45:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 578AE18005B5; Tue,  7 Jul 2026 12:45:08 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, david.marchand@redhat.com,
 dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com
Subject: [RFC v4 00/11] Add vduse live migration features
Date: Tue,  7 Jul 2026 14:44:56 +0200
Message-ID: <20260707124507.251729-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xjOwk24RvThTegdUW523YudBtGBsivp6Ce7prpWNUjU_1783428312
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

Furthermore, enabling Live Migration for devices with control virtqueue needs
two additional features.  Both of them are included in this series.

* Address Spaces (ASID) support: This allows QEMU to isolate and intercept the
  device's CVQ. By doing so, QEMU is able to migrate the device status
  transparently, without requiring the device to support state save and
  restore.
* QUEUE_ENABLE: This allows QEMU to control when the dataplane virtqueues are
  enabled.  This ensures the dataplane is started after the device
  configuration has been fully restores via the CVQ.

Last but not least, it enables the VIRTIO_NET_F_STATUS feature.  This allows the
device to signal the driver that it needs to send gratuitous ARP with
VIRTIO_NET_S_ANNOUNCE, reducing the Live Migration downtime.

v4:
* Sync headers with Linux's latest existing and proposed UAPI.  Both
  files constants and new ioctl VDUSE_SET_FEATURES.
* Check for more error conditions and clarified some error messages in
  ready message processing.
* Add relevant release notes.
* Fix cosmetic whitespaces & checkpath errors.
* Fix error path of vhost_user_iotlb_init and vhost_user_iotlb_init_one.
* Fix commits author.

v3:
* Replace incorrect '%lx' DEBUG print format specifier with PRIx64

v2:
* Following latest comments on kernel series about VDUSE features, not checking
  API version but only check if VDUSE_GET_FEATURES success.
* Move the start and last declarations in the braces as gcc 8 does not like
  them interleaved with statements. Actually, I think the move was a mistake in
  the first version.
  https://mails.dpdk.org/archives/test-report/2026-February/958175.html

Eugenio Pérez (4):
  uapi: align VDUSE header for ASID
  vhost: Support VDUSE QUEUE_READY feature
  vhost: Support vduse suspend feature
  doc: add release notes for VDUSE live migration support

Maxime Coquelin (7):
  vhost: introduce ASID support
  vhost: add VDUSE API version negotiation
  vhost: add virtqueues groups support to VDUSE
  vhost: add ASID support to VDUSE IOTLB operations
  vhost: claim VDUSE support for API version 1
  vhost: add net status feature to VDUSE
  uapi: Align vduse.h for enable and suspend VDUSE messages

 doc/guides/rel_notes/release_26_07.rst |  17 ++
 kernel/linux/uapi/linux/vduse.h        | 121 ++++++++++++-
 lib/vhost/iotlb.c                      | 233 +++++++++++++++----------
 lib/vhost/iotlb.h                      |  14 +-
 lib/vhost/vduse.c                      | 212 ++++++++++++++++++++--
 lib/vhost/vduse.h                      |   3 +-
 lib/vhost/vhost.c                      |  16 +-
 lib/vhost/vhost.h                      |  16 +-
 lib/vhost/vhost_user.c                 |  13 +-
 9 files changed, 503 insertions(+), 142 deletions(-)

-- 
2.55.0

