Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF634606A322
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OGx7LGYB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13B84025A;
	Mon, 26 Oct 2026 21:23:32 +0100 (CET)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTPS id 56A5940041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:23:31 +0100 (CET)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a01ea9e318so4833604b3a.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793046210; x=1793651010; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:mime-version:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cx90bVOVJnmmoygFu7xPBh2ycv8AkebZsTwhlG4kV+w=;
 b=OGx7LGYB/q5HUXwAiJlxhP1mmfEK/nQsaBVWDY48u6tVfVDVLbws48HyvtX8XKS24/
 Okpy/y5J9kXPi9Ao3ofX4PIvP++ZsYMaxzHry5psi3SU0Hfa79DyeecdJ8XMZJJxkORn
 EaX9XEk+G/ycM4d2fBfUzPFSEF6wdPobK/zEqtuGP0Q3ukFqslcVcKVm31lfzAgxGAAC
 n5V6AsAg1whTgZEPDN8ID879tdjk+3Eite5CpWWMsEuCpNiaigBR39swjoHW+/x151iT
 BxLN7Ylh9Sd6FJryfr7TUqFZPTIPVhCN6ZCrp2aiYO/zCt1ec3oiol4gsbb/DK/8MZ3v
 JeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793046210; x=1793651010;
 h=content-type:cc:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cx90bVOVJnmmoygFu7xPBh2ycv8AkebZsTwhlG4kV+w=;
 b=Bf/KuU1dcUfTeAnDGJpTdIwLvfsPMyCafJOhJ0Yue4syqhO4vWrvJsPyQ1wXjJk8gz
 N4Di8BKcE0ZThbmd41WHJZvVWj7d6bad6sBOI8v3bzCo4B51xsMDzbQn4zwaRejSg6ja
 SjdlhIlY2jcqCEzT3bW5JNhlaDVonmMS+yb4fnkF7IEYAfzhMCPTWp7gPQTN2nmgnzGi
 0Ul3MX7JDQChVG04h2Bv5mWu3UGyVmJD6dFDOH8p8J7wFvanqDNOc0RKp7T5iX3flEh4
 XyIMIp1xMUNLrChljKuZHTZ+XNNhY9K3iH2rPNlBMBQ0iBkNNsOo63dqhfmDpSrUofgy
 p3xg==
X-Gm-Message-State: AFq9FYINz/fgsjGWcA//48TC5LTUGzWn2+Wg/aaM/BeVy5iBAF6IfMXm
 G+Yq117mc339OOq8ZFByuplzgBFYAFdwu769galErcAOAN9GoRDrNC0ZsnwVqwhxU0shPSxOFPI
 wqn2JYbkID6n76kV8YclN3ejRfGow7Jj1ZkfRP1ZJvU81E12j0uyIKULTMjFhmZoJqnG3A5cFbo
 rHGxcIYHtRAVCPnYhICIvcYIYWkTnUl0IFbw==
X-Received: from pgbd8-n1.prod.google.com
 ([2002:a05:6a02:64c8:10b0:cd6:2052:3b68])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:49c:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3e7af814914mr5806629637.6.1793046209248; 
 Mon, 26 Oct 2026 13:23:29 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:23:24 -0700
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026202327.3897802-1-joshwash@google.com>
Subject: [PATCH 0/3] net/gve: TSO descriptor count fixes for GVE DQO
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

This patch series introduces fixes for those bugs while correcting the
overly restrictive behavior recently introduced mandating that all
headers be in the same buffer.

The final patch in the series introduces tx_pkt_prepare as an option to
ensure that there is a way to get a clear signal of when packets violate
hardware limitations. Before a recently introduced patch, the GVE
behavior was to stop transmitting at the first invalid packet, which
would allow the application to do any necessary linearization or packet
modification before attempting to transmit again. It turns out that that
behavior is considered incorrect, so offer tx_pkt_prepare as an
alternative.

Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")

Joshua Washington (3):
  net/gve: fix segment TSO segment offset calculation
  net/gve: account for multi-mbuf headers when validating TSO
  net/gve: introduce Tx packet preparation for DQO format

 drivers/net/gve/base/gve_desc_dqo.h |   1 +
 drivers/net/gve/gve_ethdev.h        |   3 +
 drivers/net/gve/gve_tx_dqo.c        | 104 ++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 12 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

