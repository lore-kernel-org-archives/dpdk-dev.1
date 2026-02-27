Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042AB1039881
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D4B940A77;
	Fri, 27 Feb 2026 20:52:52 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 99F1240A77
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:52:50 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so11109962a91.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772221969; x=1772826769; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AFKJ0ijVJq+yJ6HvIKb1exGrQVsbtr1Sa6v6Ang3rxI=;
 b=U2EdmZ5aeV1Gs9xL1yqPGy+iBcYvcp5LQEFGbSgtLmAZEfiB3ojeKoJotTb6ufnQNr
 ZkoePnIu471fGhthP/JjtxwyoRT7xeXCFs64i/RmhhJJrFB6MJ+bK+quJ0oxEysdd9YZ
 tKJEFPE3KcckplippW4byKaQVz8grOGe/bHKAYU7Ho8kwGtoWHlwbcNGyQmFD+I/vlFp
 /fxGEwDVxqe0jUdOP0awnJNK8MmF5muN1jMkLVC5sBxs+S7AtllSEC5+l+W4jvgipreL
 eSsgnvsQ0VZplJDQzDMNh60GTyRm2Rt/MCyw+2gCMyscUveD2aNx61oyF1FpZ9ZDTKMY
 el/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221969; x=1772826769;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AFKJ0ijVJq+yJ6HvIKb1exGrQVsbtr1Sa6v6Ang3rxI=;
 b=QH3e2aCwKt469HJVPWvJLA4jtGyQvFS6ZdM35yauC8bZTwIlaW3eTZugeyzsqCwO81
 O4eTpxm/6r1ltyR9ve5GB0MDuoshy6ijXu+rCYGWVENK0NdxtvXvje2fItPQpQIlhMTx
 GLxxbcCIgVy1Vs2JKDvpcmlkWF1dvJnMG9c3aTJKWUdmbUf79zY3MoifhvbEcu4AyQNA
 pQM6CUE20mikicNH1w21hyh+ufXDHXFHOWJrlv7tEHbrkMmNzNqHZkoHpzIEbm7izzi1
 cAlxK9FkfDyFCUVWiCCyRJ02olMdroqmMassXQxV8n9Rl79MzEQxdgrcBvSMWgtq/mm7
 zn6A==
X-Gm-Message-State: AOJu0YzU55oleYtGrt9QvMwgsTvoltlE9h86zbNod2FXUmBDBdjquS3f
 hSYqGIoNzYFJrnZm0tyFw79OrbjfcJcYzhe7TCjmOxT1+CBBxl4fCoykqYbq99hb4qHdqjCWW/m
 eo5NscfVAWDMWQxTx+8L31/p/qQ==
X-Received: from plhc6.prod.google.com ([2002:a17:903:2346:b0:2ae:3999:86bf])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5804:b0:356:24f0:af0c with SMTP id
 98e67ed59e1d1-35965c9033emr4478289a91.17.1772221969324; 
 Fri, 27 Feb 2026 11:52:49 -0800 (PST)
Date: Fri, 27 Feb 2026 19:51:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227195126.3545607-1-jtranoleary@google.com>
Subject: [PATCH 0/4] net/gve: add flow steering support
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>
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
 doc/guides/nics/gve.rst                |  20 +
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/gve/base/gve.h             |   3 +-
 drivers/net/gve/base/gve_adminq.c      | 118 ++++-
 drivers/net/gve/base/gve_adminq.h      |  57 +++
 drivers/net/gve/gve_ethdev.c           |  87 +++-
 drivers/net/gve/gve_ethdev.h           |  46 ++
 drivers/net/gve/gve_flow_rule.c        | 645 +++++++++++++++++++++++++
 drivers/net/gve/gve_flow_rule.h        |  64 +++
 drivers/net/gve/meson.build            |   1 +
 11 files changed, 1049 insertions(+), 5 deletions(-)
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h

-- 
2.53.0.473.g4a7958ca14-goog

