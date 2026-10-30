Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446A606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vo56XsxW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D23EC40289;
	Fri, 30 Oct 2026 19:43:08 +0100 (CET)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mails.dpdk.org (Postfix) with ESMTPS id CAA4940288
 for <dev@dpdk.org>; Fri, 30 Oct 2026 19:43:07 +0100 (CET)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so1550921a91.1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793385786; x=1793990586; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:mime-version:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BQpG4BgA9zEoBWqcShFA8KL+R66v55HlyPzNHshnu7s=;
 b=Vo56XsxWJZJ1yfgvPpAdHCEM/CfIlKKHNVfUX/52uwGccPEQxxFw+piw0g1D70r12i
 tlcaDFC5w3IJXlMyXXmgcY1RfYkMdCjNJ8mUiC8RmObkXyR8k/f4rZaTJn3durTuT9zU
 DSXVgtWC8ixshSVaHCxCRsz3+ODJoUKAVKIgT04xNEMZ/rxDtGDoQfGPp3rgVCmWHNci
 r0sCoifm+beaSXOLpbqqr9G7Jq5bf4jUb7nNBC+wIzjJue0UzsyTy+Epjeu2SPmpYYDt
 IiPlmqsE4JqnS28quH8uv2/wVIJT5bRqi5a6tdce4qphr0oH2hTWJ2F8bg0fbirEhUFX
 xE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385786; x=1793990586;
 h=content-type:cc:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQpG4BgA9zEoBWqcShFA8KL+R66v55HlyPzNHshnu7s=;
 b=pXOsCgYVVy7llnswtdvpG4uK/kc3MWCSTccBL7RLwMY7NDPtZxrK26gYdyYS+vsRLR
 n2aLeW0dNVNIGQsUFxPUd5QqI6T4tlE1ujyLiM1LQkUi5zubeY3oZkPo8IebjZJlbsVa
 SV62Xk7H4dbIfkNWYDPqyy2DAdUrt7k454I5EH2Buo5ehs/3qOIIrv/Rx2fiqvz3+JFM
 hfgnUfKUgjP48w/sBSRkTIyzqQyFnDXK8ASD1XNIr5to/hJr374YrXY2WtP/q1YuWlW/
 dUn8hFvGoWTXl1+faPxQFFWOpTrUdKLP7wkks2D5FrFN8weg00CulzffIX7tng7HxEWZ
 gzIw==
X-Gm-Message-State: AFq9FYJbs4HqBzh9gw8Th7TkQrxVaNiEynRJIiWmLA00+E8PvrWoAvSg
 S8/4IN2uQLX5JEaF+Joy1+drnksbx+ghHbBYwIOmp6oFQbK1mvYxrAHg2orrXMm92HZwlzoUsgy
 HgNBk1LJsuaASH99pv8ZFlVQv79J7jANHw+O16gyI8KTS7DgvmGp86B0SwzcU+6DVdSC32VWzs+
 C1PlxIpBv/83I2ZbJXIaju/0ln/M9yLinJJQ==
X-Received: from pgr21.prod.google.com ([2002:a63:1155:0:b0:cc7:d4f0:846d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id
 98e67ed59e1d1-3ae8980ed36mr2676333a91.36.1793385785791; 
 Fri, 30 Oct 2026 11:43:05 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:42:59 -0700
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030184304.508282-1-joshwash@google.com>
Subject: [PATCH v2 0/4] net/gve: TSO descriptor count fixes for GVE DQO
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

Changes in v2:
- Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
  precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
  if that optimization fails.
- Only call rte_net_intel_cksum_preapre on TSO packets that request
  checksum offloading. This enforces the additional requirement that
  headers are all in the same mbuf segment.
- Introduce new patch to validate minimum header length.

Joshua Washington (4):
  net/gve: fix TSO segment offset calculation
  net/gve: account for multi-mbuf headers when validating TSO
  net/gve: introduce Tx packet preparation for DQO format
  net/gve: validate minimum header length for TSO packets

 drivers/net/gve/base/gve_desc_dqo.h |   2 +
 drivers/net/gve/gve_ethdev.h        |   3 +
 drivers/net/gve/gve_tx_dqo.c        | 121 +++++++++++++++++++++++++---
 3 files changed, 113 insertions(+), 13 deletions(-)

-- 
2.56.0.317.g454f8302e1-goog

