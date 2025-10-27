Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6DCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 15:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A0504028B;
	Mon, 27 Oct 2025 16:38:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6EEDA4026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 16:38:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761579488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WXYsAJ/wYwNL559NVGfQGL/S2vObXPe+IbWgFdTAuWs=;
 b=M2XLg/Ok+KzBE5MLqi2tMBjx4SONlhMwJw9wVPfZMiGDzCNJ9vEzlEn23fFMWqH7G2iXyw
 mRRWWxa/dhd2wmbT+HPe6BCoG4aF4xuXjSiDRENVy59MQVgJsVO22hIwAzZnWWJTqwUVb9
 ruezlAO3Ijl89T3pV5KXYpImYfpWOYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-jyUdmyPMNniwFzw7tL7zew-1; Mon,
 27 Oct 2025 11:38:07 -0400
X-MC-Unique: jyUdmyPMNniwFzw7tL7zew-1
X-Mimecast-MFC-AGG-ID: jyUdmyPMNniwFzw7tL7zew_1761579486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51FC519540E2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 15:38:06 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.145])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01485180057E; Mon, 27 Oct 2025 15:38:04 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 0/4] net/tap: add network namespace support
Date: Mon, 27 Oct 2025 16:37:51 +0100
Message-ID: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vzMqZhqF7GUcTETaEYL91KIKFzNHBnzzn4wngRBZ_wc_1761579486
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

The TAP driver currently uses ioctl operations which are name-based and
namespace-unaware. When an interface is moved to another namespace, the
driver loses control and cannot track the device.

This series migrates to netlink-based interface control using ifindex
instead of names, making operations namespace-safe. When an interface
moves to another namespace, the driver detects RTM_DELLINK, queries the
new namespace using TUNGETDEVNETNS, and recreates netlink sockets in
that namespace to maintain control.

The implementation falls back to ioctl when netlink is unavailable,
preserving compatibility with older kernels.

Tested by moving TAP interfaces between namespaces while running
testpmd. All link operations continue to work transparently after
namespace changes.

Robin Jarry (4):
  net/tap: add netlink helpers
  net/tap: rename internal ioctl wrapper
  net/tap: use netlink if possible
  net/tap: detect namespace change

 drivers/net/tap/rte_eth_tap.c | 316 ++++++++++++++++++++++++++++------
 drivers/net/tap/rte_eth_tap.h |   2 +-
 drivers/net/tap/tap_netlink.c | 291 +++++++++++++++++++++++++++++++
 drivers/net/tap/tap_netlink.h |  10 +-
 4 files changed, 565 insertions(+), 54 deletions(-)

-- 
2.51.0

