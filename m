Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF59606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MxOnckJM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EBF140265;
	Mon,  9 Nov 2026 20:43:37 +0100 (CET)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mails.dpdk.org (Postfix) with ESMTPS id AD8B6400EF
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:43:35 +0100 (CET)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-567ac848d83so1646303b6e.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794253414; x=1794858214; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rqzM1XCy7C24QMd2I7WQ5tgaGFTvSPZ/6zSSZbu+RfQ=;
 b=MxOnckJMCsGPSn9BAwEJNs+mpf1KwWKepxbluiCGZVEUYVZM8twLwVMzscmvT2aM20
 z/Hh5Tt8eTBmGI5wxdyV4VJ9C1CW7Kyq/H+Lvj1y7SQ5H085sL4WFLC5IIUOQPl0MiiZ
 imfJoDfKjvclCjFuxedos+2OgY+fBmVGtmNmgKmvuSTohykhyX83MGVaNHk7FgOyqq3J
 k8GxZOrVHVhlcztelQfx0Pe8+XVyh0J9tzrvKrK0fKvSUb6rfVHU6eE4v4uk2q/XcEBS
 cpn6ihano+fWgikWAGUuDKv+V/zCihO+rSTWj4OGMVbSo8HJwAgfJ9cIAFHoOhEzIOrw
 a+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253414; x=1794858214;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqzM1XCy7C24QMd2I7WQ5tgaGFTvSPZ/6zSSZbu+RfQ=;
 b=ZXjqhoskJ3IECjDPXzcH/YPES/3avOdnKvI3KVu/bBpMCOclsw+Cu87+2XKfoErQzU
 k23lmclmQ3lwhF6/ttklDoMtlGRodXwB5KaaLkXiAtVYYXWGHuR9/a2clDNjZunoMMU+
 gz1grcNhHfYrA4n6vYCxtg2SCqGWPzLst1dZXCrLvalxYEpoYrdn7HL+MJCOJbyuHYsk
 jMW2O9eSpqyBIlhpFDxroNs/3IuoEMac7dW219vZ6VbemzxoQ7SWDOW3dAR290BlA5By
 J5L6oVjrTSwwQIvnJqkT53MZL9SldYj4HPbJyLS2rEbCqyVcoae76ORJeW6fsgfACD9j
 rZ1A==
X-Gm-Message-State: APuU4Z+AtmZ5u4Yz81qaEi53weM+WNu3Kozp0l/nBGWAanAE/oTDSzYi
 RyAFG3wFKkWKtK+W799WfcVmjLiE4HHD/eSMpC8xIVLqklMvl4q6AU/OMryEmA7EOeeqbUmpQud
 25n5BzaFG7UVxza5cLASCYCzfiDi81xup8Y1mZbxU3bNyHyly3/qTBb/sErLIZUeVUGYElD1DIC
 IsKUB5fEhVNd++p5ThAXe3MU9R+zIy/8Aceg==
X-Received: from jabdk32.prod.google.com
 ([2002:a05:6638:4be0:b0:619:d328:c89e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:120c:b0:4e6:e72a:1ba0 with SMTP id
 5614622812f47-5683cbf0072mr540611b6e.12.1794253413567; 
 Mon, 09 Nov 2026 11:43:33 -0800 (PST)
Date: Mon,  9 Nov 2026 11:43:28 -0800
In-Reply-To: <20261103181442.381856-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103181442.381856-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109194331.393364-1-joshwash@google.com>
Subject: [PATCH v4 0/3] net/gve: TSO descriptor count fixes for GVE DQO
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

Changes in v4:
- Remove unnecessary checksum check when TSO is enabled.

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
 drivers/net/gve/gve_ethdev.h        |  3 ++
 drivers/net/gve/gve_tx_dqo.c        | 84 +++++++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 5 deletions(-)

-- 
2.56.0.542.g3ef89b7020-goog

