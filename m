Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA2EB3648
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 00:58:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C527402AB;
	Tue,  3 Mar 2026 01:58:10 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 9400240289
 for <dev@dpdk.org>; Tue,  3 Mar 2026 01:58:08 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-3598007eb74so13212147a91.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772499488; x=1773104288; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=up6HmZ/2vHemxzi4wKefaaewt9YSgDl0FHjpSSjIWOQ=;
 b=EVpyMNLKoqGLda7zjU/kNaBLwXlEkIZKf3OCYhe1pt7y+sxvI3YWKZk0DID/ldme3S
 NQUdS5ckI8edQprQ1zqxg6trnQPPggyBtqqR80kH1RNNPfCln5AdUUJ8rNyR25ZpJN8E
 pQl9DzneheM67Ow4sBArayOpyb9aSPD/FD698HlW61a4jz17PO1TzYJ9uS9jbMxUlV7W
 LdNLzW7wPcRbHRLcT1UD4YogGqgxJ681H2OaZyYKs+oTnQ0p0wfpuIpWU70uHbRqN+bl
 +H96h8zIKZHI7jqLCvyWzh6QF82ulsmI3VrSMNklABQkndch1kjnuKPvqvJnn1s/JNvN
 Hx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772499488; x=1773104288;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=up6HmZ/2vHemxzi4wKefaaewt9YSgDl0FHjpSSjIWOQ=;
 b=n2gfHa3exEvZ1OVDZzJ8ykMgyY7AF5M0K3xzpy65YkqYjN2Gxe3r9JF7q0mEoET1DM
 Mv4t9U9Y+dq74mC6yIUYc3bsnaYCOzA2e+AS4W3lCtoj2A59HEdswyhH6A90HUQSGgP9
 jJ+JRVPCCXTHlYWZaTqKsWFKo8Icy50ST735NvoBTydXvhohUcwACkv9iNg1hu+yYnlV
 hoh2fA+osDY+mzWIyxpOaGdDcKBQD1DK2ousw1OYtxOEbt6FCOa96kMyX+HjBmUOl1jD
 ySXvU1+S86jpB7wi6AwZLxVggXxBR6Cntaz3Pe8ulpz+Ln8Fz+Dwsq+Uh8nnxuLgBxNM
 0kfw==
X-Gm-Message-State: AOJu0YyayH+8zNU5jq/vipgHUv0BPKGGVQ01oo01EZOutbFYIFLLfEKG
 2F2rWgfjrghjIEPFeZyiwtHkstAttnl6Hdvc1u/hFHchgLxONsNl/0+D6JGAbV8pF+vu27FWGjJ
 ztmqV3v1IsPWNp5iFCVW3bZI7uQ==
X-Received: from pjbgp2.prod.google.com ([2002:a17:90a:df02:b0:359:8467:cdd7])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e18f:b0:356:8719:f516 with SMTP id
 98e67ed59e1d1-35965ceaf7dmr13079165a91.24.1772499487418; 
 Mon, 02 Mar 2026 16:58:07 -0800 (PST)
Date: Tue,  3 Mar 2026 00:58:00 +0000
In-Reply-To: <20260227195126.3545607-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303005804.924545-1-jtranoleary@google.com>
Subject: [PATCH v2 0/4] net/gve: add flow steering support
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
 doc/guides/nics/gve.rst                |  26 +
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/gve/base/gve.h             |   3 +-
 drivers/net/gve/base/gve_adminq.c      | 118 ++++-
 drivers/net/gve/base/gve_adminq.h      |  57 +++
 drivers/net/gve/gve_ethdev.c           |  83 +++-
 drivers/net/gve/gve_ethdev.h           |  46 ++
 drivers/net/gve/gve_flow_rule.c        | 656 +++++++++++++++++++++++++
 drivers/net/gve/gve_flow_rule.h        |  65 +++
 drivers/net/gve/meson.build            |   1 +
 11 files changed, 1063 insertions(+), 5 deletions(-)
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h

-- 
2.53.0.473.g4a7958ca14-goog

