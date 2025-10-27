Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D21CCF9EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 18:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB4D4028C;
	Mon, 27 Oct 2025 19:19:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5ED7C4021E
 for <dev@dpdk.org>; Mon, 27 Oct 2025 19:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761589187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYCcnpgyf+6WqD1hPOZVbb6eEzhtpawa1Wpoo6DVbOQ=;
 b=Lo5ZyKqbQTLFson1frcrsRRRQkiGXgguPtvGVfhikei7u/uc7jV4uKuOi9d/hNfeiQcVeg
 qBwVYJNB5jSXPQ5xKEzNNLUPbLwlz2O9Gpr1HRyhw3mBU6+zymopZJrPseqthMUdP/rByt
 +sPopAjx8yMvCy3RTv32vHR5qcTih6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-mBBO6fjFO02dV_WUL_jcpA-1; Mon,
 27 Oct 2025 14:19:46 -0400
X-MC-Unique: mBBO6fjFO02dV_WUL_jcpA-1
X-Mimecast-MFC-AGG-ID: mBBO6fjFO02dV_WUL_jcpA_1761589185
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5624A1800744
 for <dev@dpdk.org>; Mon, 27 Oct 2025 18:19:45 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E1F21955F1B; Mon, 27 Oct 2025 18:19:43 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v2 0/3] net/tap: add network namespace support
Date: Mon, 27 Oct 2025 19:19:27 +0100
Message-ID: <20251027181926.489642-5-rjarry@redhat.com>
In-Reply-To: <20251027153750.445275-6-rjarry@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C2PLfV2JSl95_FwlYMMIf-tOqbhXpJYj_aRT0LYLokc_1761589185
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

v2: completely removed ioctl-based implementation

Robin Jarry (3):
  net/tap: add netlink helpers
  net/tap: replace ioctl with netlink
  net/tap: detect namespace change

 drivers/net/tap/rte_eth_tap.c | 412 +++++++++++++++++++---------------
 drivers/net/tap/rte_eth_tap.h |   5 +-
 drivers/net/tap/tap_netlink.c | 291 ++++++++++++++++++++++++
 drivers/net/tap/tap_netlink.h |  10 +-
 4 files changed, 534 insertions(+), 184 deletions(-)

-- 
2.51.0

