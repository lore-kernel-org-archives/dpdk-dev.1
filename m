Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89438606A337
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H1B8z9ZJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AEA24060F;
	Tue,  3 Nov 2026 19:14:48 +0100 (CET)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mails.dpdk.org (Postfix) with ESMTPS id 8A104400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:14:46 +0100 (CET)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdaf3f2a58aso575139a12.1
 for <dev@dpdk.org>; Tue, 03 Nov 2026 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793729685; x=1794334485; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7lGkPOYaM6MQrmfsskWJgqDQ2b5nd9sOLwUE9gUztrE=;
 b=H1B8z9ZJP+Ez3olknwe+qTfRz1oSrIELt+4B4hpJMPK59hwdw1dYjhOWxJAwVokGK5
 SfdQ7pD+FFTAmoLj/mghlL0JFc/hKvyiULyjCSgFGgaKW5v3WkmkTWV7mzqK+xI39G0c
 R/31XWPuRgHQ+VyWGdyqGDDYgby5wIDqAdSNoHHiTKzkpIhhFycHsMIVsOgaMAAOxwwz
 vP9cq0zMyQwa/MFb6OgdLfPYRM3+OplyDSHQhtzb4x4+whvNzRHMAZd95Kc2E+ZVhr4y
 /W84QfDViegiisPUP8xkaLR/OreBoA1pq+0XXOoYzjzPKTQDEbkGw4abu3+Imqn/YwNj
 ZGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729685; x=1794334485;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lGkPOYaM6MQrmfsskWJgqDQ2b5nd9sOLwUE9gUztrE=;
 b=TPCzAqH53CPVMb3kEKPDMmxl2tfHs5gh5lFFjjBGpg0GePKy4n1jXeiWkorUoAOuaZ
 TQBwQ/zjQ535HIIPCWx8/2s7GTnWycMTDEpa5U9M37zFbp7MnIeusC/kfPAn1EkMdceI
 SrbJ5dxpEqOcS6tdfgc73PHLBzz0iGlxwt8FDmBnUVkbXtKLALpusuSIVtJU6EaiIOIy
 TFQZ6hd5+iQuRoyrQe/8NOD8u/PBClXxVAucX0SdaNFYhQc+0EeYslKo8McRA4pqvwee
 2dq8ARShNMGp2ZhUI5ul5MVlidlbAgaxO5ng/EpaYUdkPBr7HiEG6rFxOURJxy6OsfaS
 a5Tw==
X-Gm-Message-State: APuU4Z9k7uftl1VkQXvy3hMvgWvPpWjc4cQmyIgmI6GR+ytAsD2Qn5zl
 h0sSYvkfBdj2rFbq3jb41jebUwy9zAJqfd/7TS8FsSIiq0jaqeWqqcFyw4K9eybo0PBemESMd6E
 nM2AiBC5/TxVdJ47t9LvviQF3bb+dM/3YR6dasIKz1t/CJ4zwX8LgtBqyTc/YvJ7cgYtLOTymm8
 RqATnNX9OMmoBfuXF1h396+7G7OHqMcwk9mw==
X-Received: from pjbds6.prod.google.com ([2002:a17:90b:8c6:b0:3ac:3bb4:e960])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5250:b0:3a8:786a:cfed with SMTP id
 98e67ed59e1d1-3ae897bfdd8mr7251234a91.37.1793729684467; 
 Tue, 03 Nov 2026 10:14:44 -0800 (PST)
Date: Tue,  3 Nov 2026 10:14:39 -0800
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103181442.381856-1-joshwash@google.com>
Subject: [PATCH v3 0/3] net/gve: TSO descriptor count fixes for GVE DQO
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://inbox.dpdk.org/dev/20250707231812.1937260-7-joshwash@google.com/
introduced descriptor limit checks for TSO packets in DPDK.
Unfortunately, a couple of bugs have been found in the implementation.

This patch series introduces fixes for those bugs and adds support for
the tx_pkt_prepare callback to reject potentially invalid packets before
they are dropped in the transmission path. Before a recently introduced
patch, the GVE behavior was to stop transmitting at the first invalid
packet, which would allow the application to do any necessary
linearization or packet modification before attempting to transmit
again. It turns out that that behavior is considered incorrect, so offer
tx_pkt_prepare as an alternative.

Changes in v3:
- Remove extraneous Fixes tags.
- Drop patch 2 allowing multi-segment HEADERS, since that conflicts with
  tx_pkt_prepare.

Changes in v2:
- Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
  precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
  if that optimization fails.
- Only call rte_net_intel_cksum_preapre on TSO packets that request
  checksum offloading. This enforces the additional requirement that
  headers are all in the same mbuf segment.
- Introduce new patch to validate minimum header length

Joshua Washington (3):
  net/gve: fix TSO segment offset calculation
  net/gve: introduce Tx packet preparation for DQO format
  net/gve: validate minimum header length for TSO packets

 drivers/net/gve/base/gve_desc_dqo.h |  1 +
 drivers/net/gve/gve_ethdev.h        |  3 +
 drivers/net/gve/gve_tx_dqo.c        | 86 +++++++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

