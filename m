Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB53606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5aHzTOR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1A9440151;
	Tue, 27 Oct 2026 19:55:37 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 092B9400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:55:36 +0100 (CET)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so157956a91.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127334; x=1793732134; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X1+pK2SpYIH2vGmsh/JVHC4FXYWSdc9Y8GggyX7CaY4=;
 b=T5aHzTORfPanOPoHtnj+QLWenJQBfr4PFBLP9tMF9MYYhGZOSqE/0uFQZlT4Fb0csX
 o5re27wamcjJKArfRH9Mc2z9I/PaA97S0Zv9YhmaCUMr7JKg9i06bWIXwO85N8zD05OS
 gGVvWgvN0yFSU0CWyLYW9WAr32J4ti4vvFYB1KAmo9hM38Z8ZvLRlcip4d3uRzvdqvG7
 lI5GZZwazDv24y2DfFMw7s4a0yfMj8YHfTvLy09VSYrfH97fZ1+SBJwm2NySK0lIproq
 Vw8uv1CEUtNgXDL+Qv5a1FqL5/rvmkGBWBNElGkj8x44kB1iCk8fYA87CVdsnMNRey6s
 0UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127334; x=1793732134;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1+pK2SpYIH2vGmsh/JVHC4FXYWSdc9Y8GggyX7CaY4=;
 b=WVTmXEVpSjalC1qvg4VSLLe5vEz5cS1FbglIv3ztXqAQanw6XB/jlj/s1nw3gkL+C+
 hyR1WbbRX7aEVF42+qaBMb/1kIUTCbDsrQO7/4ZvAHyb0LphVE0lJ1i0fBJZEnVWwp8i
 jXPAxIdTss7WqkYU3NX/lVwbXtaj24pwgvhmae1DqGlvk2M+lX81dvxBfVWsaLcZ2bau
 F4NCvcwEwEth7v98YsCal5iMJjuX97qSeH0IJdEz25pMfOONEa24mXWYZwLGrPf9IjN6
 duH4BIeicCgb13k9AGMGNOd7nJaMxox6DLl506NMa1L9Do1wKXMFjzhLTKsIeXjsRWXU
 JRXg==
X-Gm-Message-State: AFq9FYJZE8XctqdM6sxTaR1XG8LtSeF2XbITbrc9ZwhZ/u4AJq2m6olV
 abR+FxN/dempa6Ja1AIE9ANnTMeq4KaWqykviWeI8zpb9WaH/iW48LLZqa6my6AzQ2KbxPOvtII
 dgTBxAEtZzzQEemxPXfPcq6MQATnkZSL02e57NK7Y1Fhy09gIKa/S74TCA4Ne7NSvAbkUAppXmb
 8DmtIynMyXp8NgYp9SGU7C4Wccv9nb937+tNdhSPs5X3nudCWd3g==
X-Received: from pjyp7.prod.google.com ([2002:a17:90a:e707:b0:3ab:c373:bf62])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2891:b0:3ac:9706:7735 with SMTP id
 98e67ed59e1d1-3ae57e0775emr7197a91.5.1793127334176; 
 Tue, 27 Oct 2026 11:55:34 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:09 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-1-jtranoleary@google.com>
Subject: [PATCH 0/9] net/gve: support proactive device reset
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org
Cc: "Jasper Tran O'Leary" <jtranoleary@google.com>
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for proactive device reset
(RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE) to the GVE driver, replacing the
existing passive reset implementation. When the device requests a reset,
the driver now automatically recovers the control plane and recreates RX
and TX queues without requiring the application to manually reconfigure
the port.

To support automatic recovery safely while traffic is running, this
series:
- Fixes a pre-existing leak of the flow subsystem on device init
  failure.
- Saves RX and TX queue setup parameters and versions queue memzone
  names by reset generation so queues can be recreated before old queue
  memory is freed.
- Defers freeing retired queue memory ("zombie" queues) until after a
  grace period so concurrent datapath threads can safely drain after
  packet burst functions are redirected to dummy handlers.
- Splits device resource setup and teardown into host memory allocation
  and hardware configuration so host DMA memory can be kept across
  resets and re-registered with the device.
- Adds a reset mutex and moves device status polling off the shared DPDK
  alarm/interrupt thread onto a dedicated control thread.
- Implements proactive recovery and emits the standard DPDK recovery
  lifecycle events (RTE_ETH_EVENT_ERR_RECOVERING,
  RTE_ETH_EVENT_RECOVERY_SUCCESS, and RTE_ETH_EVENT_RECOVERY_FAILED).

Jasper Tran O'Leary (8):
  net/gve: free flow subsystem on dev init failure
  net/gve: snapshot queue configurations
  net/gve: add deferred queue memory reclamation
  net/gve: separate device resource alloc and config
  net/gve: add dedicated mutex for device reset
  net/gve: add check for device reset to AQ ctrl ops
  net/gve: implement proactive device reset
  net/gve: remove unused device reset parameter

Joshua Washington (1):
  net/gve: move dev status poller to its own thread

 doc/guides/nics/gve.rst                |  67 +-
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/net/gve/base/gve.h             |   1 +
 drivers/net/gve/gve_ethdev.c           | 775 ++++++++++++++------
 drivers/net/gve/gve_ethdev.h           |  87 ++-
 drivers/net/gve/gve_rx.c               |  36 +-
 drivers/net/gve/gve_rx_dqo.c           |  36 +-
 drivers/net/gve/gve_tx.c               |  32 +-
 drivers/net/gve/gve_tx_dqo.c           |  35 +-
 9 files changed, 813 insertions(+), 261 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

