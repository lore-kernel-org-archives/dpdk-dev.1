Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70528CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B34E402E0;
	Fri,  5 Jun 2026 22:52:59 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 40D37402C4
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:52:58 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8ccdf8d4ac5so26015016d6.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692777;
 x=1781297577; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ATCueUp4WEnTRo6kEaVJAz/HfXyVSGsKxTpGB6G72Yg=;
 b=eanSTNBWoggP7MOTLhGDdeF4jzZzfVv+W09OF8CTV/jBU28sOVNgKMwl1qVPwTMVS3
 66YTKVWl5XHQUEGkGzwrh9pvnecSzJFieRVvMv8bQWWgvfHGE/KI8/oCgEjFLsjW4498
 6LntHLzY//hFgOitA8AAiGH04l5mYyQoBLRCQL1/ZnOj0iZLtlPWAYqc8Opx+rHkmBGN
 TKIu73P9c2/0Dc1xE3dn5lBWxkm4rcQP9aUhcQwl1EL3Z7/9TeNdUp4lS9MPzerCGr18
 bLjHWH565oi75g21R2ojctp/0gnyyMWvu6xqea+aSOdCvbFhuGg9EsS5K6Ob8VK5VzQn
 gYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692777; x=1781297577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATCueUp4WEnTRo6kEaVJAz/HfXyVSGsKxTpGB6G72Yg=;
 b=aDqnWHhtU75DB018gSWrKCEOLmky/c8mPwOCbNPwLWxmrypSKgZ4+D1zmZkThJMLHV
 w+29XrFyVBDeuLszsUWWPCvHZfWVG+YkuVGqnW3EzPPs5m7nF5cJvtuFp5eNw4YDW3K+
 zNQjTjasew9qEV06cc9eU7h0ESr5FTxdKZRYyYFb6rwczg/gyk0Sx77XKRKgIU4zpVSR
 8yUSBK2xOhI3xXFeHZmdGbNqntoGc3fKACv//MjmXB8RXuWlYoTp6Q7trcqE8fczMlvp
 UcmInNEm9veLwB8VlsiTNSj84crNmmi8XK9X8GY0BrrqE5n9TInBTwySe28Rg5wcAj5a
 plxA==
X-Gm-Message-State: AOJu0Yxu+rZhbGcmMd0DjGW7wZFoYqGiOtzpefBik/8cewSek8y8slR1
 jUdJXL4gAUP/BNXbdBa9kUn8baepyJEagfRquXGzmjXHug6k/y99wUf3gc/XDmG+vuEqOqq3ID+
 hK3Dy
X-Gm-Gg: Acq92OHV1Q8gSWIRbrw9gBiZOskEWK4Zy/QuWLavyqvTiBx5CPeS6Mi5xtY9BXnfyW5
 +RzmB+aaPfj1pwweavVRE3ykwJEhtjN0vC23NUbtEV4r0cHVzyZm1oFuaI7Fenwmml7Y9x1qUFT
 33UtJYj501+wK+IGw+RQUbPhPB+YxQ4Wy+pU0PDuh61nmKF/Hi91IWB5CkTVmHkl5IrVNmcLd7y
 OTmubtfbFtVh79D80jXWv+pJsGfNkQNfB7y7EfFCXocwrZUK3H7W5IbCJJ0h1/XY9orYEO2XtQ/
 v8NKXDUEW+tGg7gdClTRccapfBfGYgU9l8lfU3LpJ+CuGvq02ehq9JVDns2rVQep5F+VZGPgTBt
 41fuGz2AKl0bY+E55JDiqrgZkDO3vTpEoWAF+S5evLX0JO0fFnhUdWIIKuiV2MNlIycRWWEIzbk
 PkJjgx0Itur96iJKjFwKnmX94wYJsF/ZN3qjnWBrub4UR4AHplOMIt5WKqn6/1o6f30+t1mctWX
 nbK9LTBmiA=
X-Received: by 2002:a05:6214:2aad:b0:8ca:2559:8886 with SMTP id
 6a1803df08f44-8cee5fbda5cmr90497456d6.13.1780692777402; 
 Fri, 05 Jun 2026 13:52:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:52:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/8] telemetry: thread-safe and bounded parameter parsing
Date: Fri,  5 Jun 2026 13:50:57 -0700
Message-ID: <20260605205253.520196-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While looking into extending telemetry for other uses, I noticed a
pattern of unsafe string handling in the command handlers. They run one
thread per client connection but parse parameters with non-reentrant
strtok(), and convert ids with atoi()/unchecked strtoul() that silently
truncate or alias out-of-range values; in eth_rx the strtok()
continuation chain can also dereference freed memory.

This series covers the library code (telemetry, ethdev, dmadev, security,
eventdev, eth_rx, timer). A follow-up is needed for the same strtok()
use in drivers.

They are marked for stable: the races and the use-after-free are real and
the changes are low-risk to backport. But severity is low since telemetry is
not a remote interface, but these are the kind of issues likely to
be found by AI security scanning tools.

In future, atoi() and strtok() look worth adding to the forbidden
tokens list in devtools/checkpatches.sh.

Stephen Hemminger (8):
  telemetry: fix thread-unsafe command parsing
  ethdev: make telemetry parameter parsing thread-safe
  dmadev: validate telemetry parameters
  security: harden telemetry parameter parsing
  eventdev: remove strtok from telemetry handlers
  eventdev/eth_rx: fix thread-unsafe telemetry parsing
  eventdev/eth_rx: reject out-of-range telemetry adapter ID
  eventdev/timer: reject out-of-range ID

 lib/dmadev/rte_dmadev.c                 |  44 +++++---
 lib/ethdev/rte_ethdev_telemetry.c       |  12 ++-
 lib/eventdev/rte_event_eth_rx_adapter.c |  97 ++++++++---------
 lib/eventdev/rte_event_timer_adapter.c  |  22 ++--
 lib/eventdev/rte_eventdev.c             | 136 +++++++++++-------------
 lib/security/rte_security.c             |  41 ++++---
 lib/telemetry/telemetry.c               |   5 +-
 7 files changed, 186 insertions(+), 171 deletions(-)

-- 
2.53.0

