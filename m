Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E32CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 22:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D351C4028C;
	Mon, 27 Oct 2025 23:17:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8F59E4021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 23:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761603463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t3KmoinnM6EtW6gFgFcTgDaFl2inirMlyViMEDH8MQ=;
 b=YMFdYLvoxuZ92H+oZyEl9mWIRGiWg6uZgfk7iq5kgFJXgNOlumwxwK5IXQD8qEfLo4Kbzz
 rha9pIT8+WZcjaWVtGaa715SUEq5fQkC5zM1rAGH/YOo5xteu2LXBvgqhhvyPEkmDMJujf
 8rUktAmGpl5WokpSlsnrEomnpFmfxOQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-V9vdIeI2NCab59ITMCZvuQ-1; Mon,
 27 Oct 2025 18:17:41 -0400
X-MC-Unique: V9vdIeI2NCab59ITMCZvuQ-1
X-Mimecast-MFC-AGG-ID: V9vdIeI2NCab59ITMCZvuQ_1761603460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 669A81800378
 for <dev@dpdk.org>; Mon, 27 Oct 2025 22:17:40 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26A2F30001A7; Mon, 27 Oct 2025 22:17:38 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v3 0/3] net/tap: add network namespace support
Date: Mon, 27 Oct 2025 23:16:22 +0100
Message-ID: <20251027221622.494080-5-rjarry@redhat.com>
In-Reply-To: <20251027153750.445275-6-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W2ThTOGrFUSx1Nc6uBGqFYI_GE7nACWvbRs5FPGARbs_1761603460
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

v3: added release notes

v2: completely removed ioctl-based implementation

Robin Jarry (3):
  net/tap: add netlink helpers
  net/tap: replace ioctl with netlink
  net/tap: detect namespace change

 doc/guides/rel_notes/release_25_11.rst |   6 +
 drivers/net/tap/rte_eth_tap.c          | 412 ++++++++++++++-----------
 drivers/net/tap/rte_eth_tap.h          |   5 +-
 drivers/net/tap/tap_netlink.c          | 291 +++++++++++++++++
 drivers/net/tap/tap_netlink.h          |  10 +-
 5 files changed, 540 insertions(+), 184 deletions(-)

-- 
2.51.0

