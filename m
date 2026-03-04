Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64055EDEC04
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 04:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DBA4402B3;
	Wed,  4 Mar 2026 05:50:41 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id ABAC440269
 for <dev@dpdk.org>; Wed,  4 Mar 2026 05:50:40 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-354490889b6so22777420a91.3
 for <dev@dpdk.org>; Tue, 03 Mar 2026 20:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772599840; x=1773204640; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ycb4sNu4DFRed9AeZeqc5gHJ3cQ8e/csHusJbs3c3Fg=;
 b=I6s8jLUnbbe5gpdjXA9wpybfo7oxsRjZU+i6fThP4025D408QmUlCMQv/NnQiD+RxE
 QIEXzMnVpLLLsB/GWHS9TfdambaZE9QcLBt1DOEMOP0sy1JSzjNY+SkAVBy3fiDcOZ2F
 sRIY8wWYkx1aDLg9qE7J1vfrlhKuZTmwQfJhsZCc6PmPdaE9txW5ciXf49O68AWwug4h
 USmR62mdpcj4RlWu9eqLYt4HS1IhPLG992YnQbSI/YVyLR4CUo+uvxHauwI5AdahfY4H
 1YPQm9kiwmaV5MoXEiyUhE76PJJd6a1lTcQwHwEscQLj42f84mx2CjL6I7Rw4kIChf4h
 jcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772599840; x=1773204640;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycb4sNu4DFRed9AeZeqc5gHJ3cQ8e/csHusJbs3c3Fg=;
 b=LeROx/wTAl7sD/jltnrK6nwLLiXPpvY82Jh4AEC7g6BCsheNcLeJMxctzZ90/1gGUk
 Kd4HzHdNH2CurV1N4vemlLWOBJqzhLqkmSWBKleFZcL5IxoFHE2DSOTGk/A7PZ9GMNzo
 g9+V8+evI+MJxmVey34+WAq9TNOQPh3FBzNYpl/7XEAptiOdX1oK4XPziPK7RHQxFIzB
 hSWM9pMn023LPqDk14wMOmhCKzsP2GVlIFWvo2rpbzftHTfYu2xiottkvPg/MG19h8j1
 TW7A9P6kALna2+TaaAdn+HCmeNc13bcVV0uAA2TS13tDuDSoU7hTppx03j0JHxGdDPzm
 2nVg==
X-Gm-Message-State: AOJu0Yw/PLpWUWBDSfkFH4MGjv8pbkgwxFj0IecTsrtNWHUY7T+hPtVz
 FblDapKkDZhVLjqScgkKRx3QHjSzdwg8y2aAUBVfLv2fO2EyzSzzJazacOflE8yp+Pep5SYYctc
 pNUeN2o6PuBEstufUu9ezyNIlYA==
X-Received: from pjbds10.prod.google.com ([2002:a17:90b:8ca:b0:359:8b86:e0dd])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1643:b0:356:24f0:af0c with SMTP id
 98e67ed59e1d1-359a6a4d3famr1105799a91.17.1772599839621; 
 Tue, 03 Mar 2026 20:50:39 -0800 (PST)
Date: Wed,  4 Mar 2026 04:50:29 +0000
In-Reply-To: <20260304014624.1297874-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260304014624.1297874-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304045033.1340269-1-jtranoleary@google.com>
Subject: [PATCH v4 0/4] net/gve: add flow steering support
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This patch series adds flow steering support to the Google Virtual
Ethernet (gve) driver. This functionality allows traffic to be directed
to specific receive queues based on user-specified flow patterns.

The series includes foundational support for extended admin queue
commands needed to handle flow rules, the specific adminqueue commands
for flow rule management, and the integration with the DPDK rte_flow
API. The series adds support flow matching on the following protocols:
IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.

Patch Overview:

1. "net/gve: add flow steering device option" checks for and enables
   the flow steering capability in the device options during
   initialization.
2. "net/gve: introduce extended adminq command" adds infrastructure
   for sending extended admin queue commands. These commands use a
   flexible buffer descriptor format required for flow rule management.
3. "net/gve: add adminq commands for flow steering" implements the
   specific admin queue commands to add and remove flow rules on the
   device, including handling of rule IDs and parameters.
4. "net/gve: add rte flow API integration" exposes the flow steering
   functionality via the DPDK rte_flow API. This includes strict
   pattern validation, rule parsing, and lifecycle management (create,
   destroy, flush). It ensures thread-safe access to the flow subsystem
   and proper resource cleanup during device reset.

Jasper Tran O'Leary (2):
  net/gve: add adminq commands for flow steering
  net/gve: add rte flow API integration

Vee Agarwal (2):
  net/gve: add flow steering device option
  net/gve: introduce extended adminq command

 doc/guides/nics/features/gve.ini       |  12 +
 doc/guides/nics/gve.rst                |  27 +
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/gve/base/gve.h             |   3 +-
 drivers/net/gve/base/gve_adminq.c      | 118 ++++-
 drivers/net/gve/base/gve_adminq.h      |  57 +++
 drivers/net/gve/gve_ethdev.c           |  83 +++-
 drivers/net/gve/gve_ethdev.h           |  46 ++
 drivers/net/gve/gve_flow_rule.c        | 658 +++++++++++++++++++++++++
 drivers/net/gve/gve_flow_rule.h        |  65 +++
 drivers/net/gve/meson.build            |   1 +
 11 files changed, 1066 insertions(+), 5 deletions(-)
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h

-- 
2.53.0.473.g4a7958ca14-goog

