Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F375CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 21:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9874026F;
	Thu,  7 May 2026 23:01:58 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id D63FC4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 23:01:56 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso899666c88.0
 for <dev@dpdk.org>; Thu, 07 May 2026 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778187715;
 x=1778792515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dtwwtkhnvpmOuC2kGhqDri9f7/VmqQu6tV3fcy2jsAQ=;
 b=YbY2ltBFZJrCRSwpDt0SrwaoP8qUpSbR25nkuQmZIJKWsqBVnOMQgzBSr9IOg/VCh2
 NlqbDNXEn8Gv0BZcfm0c+GsxSESFEYWnk6kmkOVqYVCnynV5AzUm7Sba3q1Knpzx2xr+
 SmnyFhYIThzmqDgAxGYzfe5GSJ9rT1bV+uJb1qCGhn7GvrOFPTc8MKNXq58V6ProaevZ
 0MggE8WM91+3/LOjXlAd9DfDQ7I+BL09p/z6FIw+xT3bQwoYQHBol/iQnPzd0PNHwq72
 EuIQIH3ajmLMYoyRLjf0xS0UiYOAEUsft8YVMaO5d/ot8crfKnV4Vf0dpgQTwRya0xV4
 0P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778187715; x=1778792515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtwwtkhnvpmOuC2kGhqDri9f7/VmqQu6tV3fcy2jsAQ=;
 b=mzXaCNBMe/X0lQROaKugxu68bDU3aCg0X6dtV3fa2mRWVQh6EFqKvc/ofCQ33ghmhl
 2G1VB6L0BcYLItbWgVNLVJqxICwhuQbsJWqPdenRZHxjXdvyIOJRmDWNfp1Vq3JG1Ye9
 FcWd8jJYJpySd31b35PKle+ZM2XjnS4WoI9MALfS3Tu+Gy+E9eyNmoCNsrt70ILnZofQ
 cTsyaMhK5ybFHh+/vGaV0OZyM2W9aHx91+xpfq6hiErWj9nZX/WipofxD2eXfaApOTvg
 L4xDCKfMtV6hx61+lCWnMPCGZmJ5oQ9rsl07TK3nZOnD3vtFkkBWThEwPZZdHHsP8Wg4
 5Vrw==
X-Gm-Message-State: AOJu0Yxx9HbMST1OvxGtdfjJ6Fjo7dCfzK79PLM7AYm6lPSLVG1tfgKq
 OR9qGvRApeayvjx7/F8GeUPRDZyFtBo8e8pgdPmYExY0HEiAx45USp2z/RJB64CwADDhEn4z2Ro
 CWKoU
X-Gm-Gg: AeBDiesNEWmfowWCqBKZO4BQCapSAStAq6gC/LiV4NEVyRFRfsWM5N/3e0zdGGpaQOP
 Q/bLRpL0vpCWdu7fec/SuKzfAtHJF0APWTGvoel5Gr0UXjXSgK9/RhGah5SX2aBLmPTOZhDVJpu
 b9VPdzKPsLElSOXCtLF7kzKhMbjH3/UcnMl6x5VZg78q1RuNv2KhEYbs03BTr7BqqkR9XP53uts
 zM9j7rKSXDaje32vZ5pVG/2iLdajdz4dnOWFmYYyJzJtIheZ2SSXpyLt7g2z2H7vi4a7W/52JJo
 9VoE3q75AnmAbuvCMwPTcJYL7E3JlvrOdUZ237LAPzkfMOiUyvUhoMoULYyhbqk0tB9pXzcLg7m
 IN1QvrLK+/SLy/LVlfxul+y+DRVaB+TaT/I4pHKcfmLwp6PXIUR7kHC9v5eIFDOCP4rOZigblZ4
 WBC/Sifyys1SbKkeShUA2pHVgBsmN16pnpqddRNBkwqQ8=
X-Received: by 2002:a05:7022:486:b0:12d:de3e:86b2 with SMTP id
 a92af1059eb24-1323b0af222mr2070241c88.21.1778187715017; 
 Thu, 07 May 2026 14:01:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13270901ba2sm227282c88.11.2026.05.07.14.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 14:01:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] eal: notify secondaries on primary exit
Date: Thu,  7 May 2026 13:58:35 -0700
Message-ID: <20260507210152.410419-1-stephen@networkplumber.org>
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

Bugzilla 1942: when a primary process exits cleanly, secondary
processes other than testpmd do not get notified.  The notification
mechanism added in 25.11 was placed in testpmd and used
rte_mp_request_sync() with a testpmd-specific action name, so any
non-testpmd secondary (dpdk-dumpcap, dpdk-pdump, dpdk-procinfo, or
out-of-tree consumers) would log "Cannot find action: mp_testpmd"
and the primary would block on the 5 second request timeout.

Putting application-specific IPC actions on a broadcast request path
is the wrong layer.  Notification of primary exit is something every
secondary needs and should come from EAL, not from each application.

Patch 1 reverts the testpmd-side mechanism (commit f96273c8e9d3).
The secondary-side primary alive monitor (enable_primary_monitor)
is preserved and continues to handle detection of primary exit via
the existing alarm-based polling of rte_eal_primary_proc_alive().

Patch 2 adds a generic EAL-level notification.  On primary cleanup,
rte_mp_channel_cleanup() broadcasts an MP_REQ_QUIT message to all
known secondaries via rte_mp_sendmsg().  Secondaries register an
internal action handler that tears down their own MP channel on
receipt.  No new public API; no application changes required for
any secondary, in-tree or out.

This is the minimum fix suitable for backport to 25.11 stable.
It addresses the clean exit case.  The crash case (primary killed
or signaled) continues to be handled by the existing
rte_eal_primary_proc_alive() polling on the secondary side, which
detects the primary's release of the config file lock.

A more complete solution using a connected socket type (SOCK_SEQPACKET)
is planned since that can handle both planned and forced exiting
of the primary.

Tested with testpmd (primary) and dpdk-dumpcap, dpdk-pdump,
dpdk-procinfo (secondaries).


Stephen Hemminger (2):
  Revert "app/testpmd: stop forwarding in secondary process"
  eal: notify secondary on primary exit

 app/test-pmd/testpmd.c           | 103 ++-----------------------------
 lib/eal/common/eal_common_proc.c |  51 ++++++++++++++-
 2 files changed, 53 insertions(+), 101 deletions(-)

-- 
2.53.0

