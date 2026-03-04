Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A034EDEBFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 01:47:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F71540269;
	Wed,  4 Mar 2026 02:47:31 +0100 (CET)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 3C4AE40041
 for <dev@dpdk.org>; Wed,  4 Mar 2026 02:47:30 +0100 (CET)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2ae415b68b1so37037585ad.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772588849; x=1773193649; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ycb4sNu4DFRed9AeZeqc5gHJ3cQ8e/csHusJbs3c3Fg=;
 b=JRze1+oSfvS+KbmpD3t02c/48tLm9PQ2V+svKJaSmRAqWuPpaQyVaQYESZIEFhAhRV
 vgDXOVEvWv6dIdAP9B8zuOhJ6AvYHf1bPZy7dYbJVoxbHxd+VnGwwwVFJ4N0wma/RL2B
 8r95k5enBpo8Ys6UPm87lQoNEQKWAglUnmtKnKgBPM0d5F7XdOH4zXQIoiyjYbw8PXN9
 0eP0mumMHZgnDyLEIYQ1eBLu0VtnKAu2jWbllv5zg7uOLitlpbUK0IGpDBPSwBgX0fO6
 LO52yiT9CiK3e9dy9ZZ8hH8oOnlXdPZr9vxEkBH8RNdOzG5mfR5Bbn9AqZ8vVuHcU9I9
 o6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772588849; x=1773193649;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycb4sNu4DFRed9AeZeqc5gHJ3cQ8e/csHusJbs3c3Fg=;
 b=XIM0AdFQVFD5N0oW6+DPSojCn9mrGsbIDVo/QCkIP/h9W7wZUNQ6D3u9birQSOGY4p
 fOH6IE7Q5zu2AGzRSSWGJF/uM6HC0FNFokgueIu2lHgqWH92c381FBOS590v5Gp5gfgh
 W7q7MFKdR4sLo/HhQHi9LMthGj4gkFR1MP0wFlMrrddXbJypJJ0M5EZ93osi/Z1grBtU
 inZplkS8C+y5WEd4oO+BNfAOXxmhaOM0ClNWU2iNvHSqlt/cumykm00MGRpzm4gP0Aa4
 YGjp4+nKj0/PeIsM5FGV779mnVi/ePmeEv9L78BwpRiQR2Is7QZsU0j/tKUzSPsdrROh
 cULg==
X-Gm-Message-State: AOJu0Yzo0qZfXaTozwKY5h/sArtGVDUztmNW7I5xgAfFKqxYwhrtMF4Q
 tfS90JzMd3t18KdHOqrSF8zVNYTHT6B1Km4ALdYtP7w3CXRuXKeq4Ng3UWpJN9mTqZz/BZAMUAa
 7WSRkpUiYVm1XgszKktQoRRqDmQ==
X-Received: from plbjf2.prod.google.com ([2002:a17:903:2682:b0:2a9:6366:197c])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c5:b0:2aa:daf7:84f6 with SMTP id
 d9443c01a7336-2ae6abdd127mr4077695ad.55.1772588849050; 
 Tue, 03 Mar 2026 17:47:29 -0800 (PST)
Date: Wed,  4 Mar 2026 01:46:20 +0000
In-Reply-To: <20260303005804.924545-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260303005804.924545-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304014624.1297874-1-jtranoleary@google.com>
Subject: [PATCH v3 0/4] net/gve: add flow steering support
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

