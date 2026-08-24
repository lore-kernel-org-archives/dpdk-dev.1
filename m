Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20469C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C654D4028B;
	Mon, 24 Aug 2026 13:42:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D17314027C
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787571746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7v/APkJnINfmU5QqaCZ9L5dcOxoRn4o7rtmLTndlSjI=;
 b=Y9O0vBljLToGG4Pycezywv8RK+pygjKWnyQptqrBGmi9V8HKxxC0c6wYaF2Ygmy6fBptuB
 /MPdutiDYiM3jzA0d1r29Od+ujpZvrQJbWfn0hBOgFhrUvTLYTTZ3jz7qf04tMP9VceTK5
 NX2SgucRa/1+iB0zK/ssCMA0nmuYBcQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-WToVAXbFPxi7bqiWgCTi6w-1; Mon,
 24 Aug 2026 07:42:24 -0400
X-MC-Unique: WToVAXbFPxi7bqiWgCTi6w-1
X-Mimecast-MFC-AGG-ID: WToVAXbFPxi7bqiWgCTi6w_1787571744
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F28FB195DE79
 for <dev@dpdk.org>; Mon, 24 Aug 2026 11:42:23 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4CDE18005BD; Mon, 24 Aug 2026 11:42:22 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v6 0/3] Remove limitations coming from legacy VMDq
Date: Mon, 24 Aug 2026 13:42:04 +0200
Message-ID: <20260824114207.312513-1-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jJshIWPwitWlievpmX5MedQud5RsgwRUi5jYoFuZPbE_1787571744
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

Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
VMDq has been imposing a maximum number of mac addresses in the
mac_addr_add/del API.

Nowadays, new Intel drivers do not support the feature and few other
drivers implement this feature.

This series enforces that the driver announces VMDq pools before
using VMDq related features, then remove the limit of number of
mac addresses for others.

Next step could be to remove the VMDq pool notion from the generic API.
However I have some concern about this, as changing the quite stable
mac_addr_add/del API now seems a lot of noise for not much benefit.


-- 
David Marchand

Changes since v5:
- no change, simply split out (intel and mlx) drivers update in
  separate series,

Changes since v4:
- rebased,
- moved mac restoration in dedicated IAVF reset helper,
- fixed inverted arguments when calling mlx5 mac sync,

Changes since v3:
- rebased (this series is too late for 26.07),
- update some doxygen comments,
- added mlx5 changes,

Changes since v2:
- changed approach: did not introduce a new device capability,
  relied on already existing dev_info->max_vmdq_pools,
- fixed duplicate mac addition without VMDq,
- updated documentation,

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,
- fixed buffer overflow on mailbox messages during port restart/VF reset,
- fixed duplicate MAC address installation on port start/restart,

David Marchand (3):
  ethdev: check VMDq availability
  ethdev: skip VMDq pools unless configured
  ethdev: hide VMDq internal sizes

 doc/guides/rel_notes/release_26_11.rst | 11 +++++
 drivers/net/cnxk/cnxk_ethdev_ops.c     |  1 -
 lib/ethdev/ethdev_driver.h             |  8 ++-
 lib/ethdev/rte_ethdev.c                | 68 ++++++++++++++++++++------
 lib/ethdev/rte_ethdev.h                |  8 +--
 5 files changed, 71 insertions(+), 25 deletions(-)

-- 
2.54.0

