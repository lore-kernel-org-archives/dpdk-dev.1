Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26362FD063C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 06:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F32F74067C;
	Wed, 11 Mar 2026 07:55:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F42F40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 07:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773212150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wujKqScV2AYIkU+eqKdvoapb2zuRGdOGad/DBuR6KFo=;
 b=jE7rODvMAm5ka8WZ3Zk5NOlX1iMx3y7cEizWSiuzb/2kLSeRulhFf5tyDueWj/LnyqvLsv
 LQQQZlJwKujY/kphxhoFo/lvSU66v6WCl48sACkF0eBxx4dIRYH7fyBJDbqu69PRE/eFhm
 rOd7qQvdeD+iyRgFrVq1z/N5RNxUEJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-X2ei6QGTMGSXkqEXvSUo9w-1; Wed,
 11 Mar 2026 02:55:49 -0400
X-MC-Unique: X2ei6QGTMGSXkqEXvSUo9w-1
X-Mimecast-MFC-AGG-ID: X2ei6QGTMGSXkqEXvSUo9w_1773212148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC6B31956089; Wed, 11 Mar 2026 06:55:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.190])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A75B119560A6; Wed, 11 Mar 2026 06:55:44 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: chenbox@nvidia.com, jasowang@redhat.com, david.marchand@redhat.com,
 dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com
Subject: [RFC v3 00/10] Add vduse live migration features
Date: Wed, 11 Mar 2026 07:55:33 +0100
Message-ID: <20260311065543.1354037-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O4NhzyL2cj1hWJxjsDxyNOTKRmmX4IzWKyL_1lPAny0_1773212148
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

v3:
* Replace incorrect '%lx' DEBUG print format specifier with PRIx64

v2:
* Following latest comments on kernel series about VDUSE features, not checking
  API version but only check if VDUSE_GET_FEATURES success.
* Move the start and last declarations in the braces as gcc 8 does not like
  them interleaved with statements. Actually, I think the move was a mistake in
  the first version.
  https://mails.dpdk.org/archives/test-report/2026-February/958175.html

Eugenio Pérez (1):
  uapi: align VDUSE header for ASID

Maxime Coquelin (6):
  vhost: introduce ASID support
  vhost: add VDUSE API version negotiation
  vhost: add virtqueues groups support to VDUSE
  vhost: add ASID support to VDUSE IOTLB operations
  vhost: claim VDUSE support for API version 1
  vhost: add net status feature to VDUSE

Super User (3):
  uapi: Align vduse.h for enable and suspend VDUSE messages
  vhost: Support VDUSE QUEUE_READY feature
  vhost: Support vduse suspend feature

 kernel/linux/uapi/linux/vduse.h | 114 +++++++++++++++-
 lib/vhost/iotlb.c               | 226 ++++++++++++++++++++------------
 lib/vhost/iotlb.h               |  14 +-
 lib/vhost/vduse.c               | 197 +++++++++++++++++++++++++---
 lib/vhost/vduse.h               |   3 +-
 lib/vhost/vhost.c               |  16 +--
 lib/vhost/vhost.h               |  16 +--
 lib/vhost/vhost_user.c          |  11 +-
 8 files changed, 460 insertions(+), 137 deletions(-)

-- 
2.53.0

