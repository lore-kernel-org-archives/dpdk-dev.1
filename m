Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC72CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDA664026F;
	Thu, 30 Oct 2025 18:56:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 30C1640150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761846967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJrt5iuL4WiJYrXr9vv9OKKm2Fr8bQzElxXVKDmNqnY=;
 b=ZurzDdrWS84RAYiWbuZm3jfPA+Zmd0TTKR98HH/0otrbydgGpcGKytBo4qSpfh+Mb4gnrV
 09jrYY7l5FpJPddLoetUfKFj5VF2FVfoD3UpIQhdFYJzhfgua+ahRASFhEGUm2G7xu3NJf
 KFDY5lx8zzuYZ8ABGROPvej8dn/+OLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-qaK6mVNSPD6WiH0FvEHwAw-1; Thu,
 30 Oct 2025 13:56:06 -0400
X-MC-Unique: qaK6mVNSPD6WiH0FvEHwAw-1
X-Mimecast-MFC-AGG-ID: qaK6mVNSPD6WiH0FvEHwAw_1761846965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D81B1800D8C
 for <dev@dpdk.org>; Thu, 30 Oct 2025 17:56:05 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 243EB19560A2; Thu, 30 Oct 2025 17:56:03 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v4 0/4] net/tap: add network namespace support
Date: Thu, 30 Oct 2025 18:55:39 +0100
Message-ID: <20251030175537.219641-7-rjarry@redhat.com>
In-Reply-To: <20251027153750.445275-6-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NUi_nZdR8yuVlzzEch6XLBgm5kdE8x13ZdjVvJz9t1I_1761846965
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

Tested by moving TAP interfaces between namespaces while running
testpmd. All link operations continue to work transparently after
namespace changes.

v4: added TUNSETCARRIER support after moving to another netns

v3: added release notes

v2: completely removed ioctl-based implementation

Robin Jarry (4):
  net/tap: add netlink helpers
  net/tap: replace ioctl with netlink
  net/tap: detect namespace change
  net/tap: configure link carrier

 doc/guides/rel_notes/release_25_11.rst |   7 +
 drivers/net/tap/rte_eth_tap.c          | 437 +++++++++++++++----------
 drivers/net/tap/rte_eth_tap.h          |   5 +-
 drivers/net/tap/tap_netlink.c          | 291 ++++++++++++++++
 drivers/net/tap/tap_netlink.h          |  10 +-
 5 files changed, 566 insertions(+), 184 deletions(-)

-- 
2.51.1

