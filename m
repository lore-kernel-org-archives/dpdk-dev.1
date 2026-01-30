Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E0D73EB7
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B6E40274;
	Fri, 30 Jan 2026 06:21:49 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id AA5E640150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:21:48 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so15902485e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750508;
 x=1770355308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t4ARnYmAAenJLUbNHZDtiR01nIOzPSJeUYnn57qs598=;
 b=RCpZyAj195AUH7hVNs75ifgFr+j1me8VBvVxkHjQl3eLl8Wt/7lxFM2WDZEzMrPAMA
 y287Xt0ZIKvkU7X85a7Ygl/ywwgI2F1tdriM9QGmw0PVDnS2kSPAWGc1EnAl12GwPhcc
 PklJ6LkUhc6HdPygw/jOEnS/0ftZ8SrVBFePXfYIMzak8CjFHRpVZlDHsvHR3HfPttcx
 zkcTtxqFYie5LCD9ovOcAVyH6jm7NTpgvlBTpRB05TnTPXHUjcMoaxJ7TNu0VgZ59Arq
 Pmn41VKvOf/miazf8Kw9UhfTLcxuaizO0hyixakT/Rexrpu3oyFOM15fgMKgXfEreSP2
 3a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750508; x=1770355308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4ARnYmAAenJLUbNHZDtiR01nIOzPSJeUYnn57qs598=;
 b=fs/iAuLtH++sbUFUTWJID/b+vIRc4WwZBi62mwKkqcSKdj6GylcIb6w/CV9VU6WXXc
 SvAys6JUUNy86qwjpGRDgapm+3R8RK6oJfxtsiNXTASxtCY3idoV2j5xRlZSwUXBymbZ
 dR+Rm4xQA+voIP2i/aIUEZoeA4i/h0iusb2jhOSzxw6twAre1A/1BRySBnsePaUduPKp
 RyRmnbRa6neLk5cBRNFk3XFuhGZviwxq4WsaBl/hBfKl9qlCk3rVPlJjf8+kXR8S2LiM
 hXrbw5qkPd4OFXwn5BfMDs9Slmex5WFQTwJCXtWghPHpYPINj2HRXAAfw10xRoYst4MO
 pxRw==
X-Gm-Message-State: AOJu0YyqvX56lAL9nOiKsYKVpNa53YTwVZMRrxeDrprCDqkw0N0lGfVE
 abDzuaqpPrG3Cf3fDa80GXxCrBJDFQVCltf0B6gPyfO5tI3kMPpLWFTWsdvCvTKxPFo6HJd2isD
 ltmVm
X-Gm-Gg: AZuq6aIP6SWx5ZZi6v7TDjZxc2TguFQhCerQzU6xYfppupRLhm3Hg+hU6NFnGtsy6qN
 Qs564tHeUURLty4okx4jTMb9tde8Vm47Rj6gJcqWyYzwVNoWnktQSHFAvdZj2mNbmcJT8Elqjek
 IUCr6C3I4mVtq9gbwbwAmWhQk/DZu69/xl2HGekomN4VDnc1KIVvSnGKrZnV+HQFAUsySUvHiJu
 kr0r0ybFbrm1PDVof4cOnrAyKd/bLaTlqjcA8RzkTUyImONrTpaq7LDOGgb5yeTaAKiOF3WQS1e
 K5xVYlxEmzSJV6k+jKHQBSJkfi2NMESjN3DpP/7ICeZbbU4Y9HKwk0bX62akQpGkkCewRuxlLEa
 NjIvx43ywcQ6ew7C54M006OLZw11t3/R35ftXVknkeAHragpk1neMQnFdk3/bHjJZIIXw6huqvq
 7EXdboU3NEG46DP8r0/2eKMAG6XHOq+DvwnNYjiTQS+CHDBgc7JA==
X-Received: by 2002:a05:600c:3f16:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-482db4592efmr14121775e9.8.1769750507709; 
 Thu, 29 Jan 2026 21:21:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/6] Fix pthread mutexes for multi-process support
Date: Thu, 29 Jan 2026 21:17:31 -0800
Message-ID: <20260130052142.251649-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

While look at the back catalog of bugs, started to use AI
to analyze Bugzilla ID 662.

POSIX mutexes are by default private to the process creating them.
Several places in DPDK use pthread_mutex to protect resources in
shared memory that are accessed by multiple processes (primary and
secondary). These mutexes must be initialized with the
PTHREAD_PROCESS_SHARED attribute for correct synchronization.

Without this attribute, synchronization between processes is
undefined behavior according to POSIX, and may silently fail
on some implementations.

This problem was originally reported against the failsafe driver,
but the issue exists in multiple locations. Every place calling
pthread_mutex_init() in DPDK was suspected.

The following table summarizes the analysis:

  | Component                          | Mutex(es)                      | In Shared Mem | Multi-process | Needs Fix |
  |------------------------------------|--------------------------------|---------------|---------------|-----------|
  | lib/ethdev/ethdev_driver.c         | flow_ops_mutex                 | Yes           | Yes           | YES       |
  | drivers/net/failsafe/failsafe.c    | hotplug_mutex                  | Yes           | Yes           | YES       |
  | drivers/net/atlantic/atl_ethdev.c  | mbox_mutex                     | Yes           | Yes           | YES       |
  | drivers/net/axgbe/axgbe_ethdev.c   | xpcs_mutex, i2c_mutex,         | Yes           | Yes           | YES       |
  |                                    | an_mutex, phy_mutex            |               |               |           |
  | drivers/net/bnxt/bnxt_ethdev.c     | flow_lock, def_cp_lock,        | Yes           | Yes           | YES       |
  |                                    | health_check_lock,             |               |               |           |
  |                                    | err_recovery_lock,             |               |               |           |
  |                                    | vfr_start_lock                 |               |               |           |
  | drivers/net/bnxt/bnxt_txq.c        | txq_lock                       | Yes           | Yes           | YES       |
  | drivers/net/bnxt/tf_ulp/bnxt_ulp.c | bnxt_ulp_mutex                 | Yes           | Yes           | YES       |
  | drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c | flow_db_lock              | Yes           | Yes           | YES       |
  | drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | flow_db_lock             | Yes           | Yes           | YES       |
  | drivers/net/hinic/base/hinic_compat.h | hinic_mutex_init wrapper  | Yes           | Yes           | YES       |
  | lib/vhost/socket.c                 | conn_mutex, mutex              | No (heap)     | No            | OK        |
  | lib/vhost/fd_man.c                 | fd_mutex                       | No (heap)     | No            | OK        |
  | drivers/common/cnxk/roc_bphy_cgx.c | lock                           | TBD           | Unlikely      | TBD       |
  | drivers/common/cnxk/roc_dev.c      | sync.mutex                     | No            | No            | OK        |
  | drivers/net/cnxk/cnxk_rep.c        | repte_msg_proc.mutex           | No            | No            | OK        |
  | drivers/net/intel/iavf/iavf_vchnl.c| event_handler.lock             | No (static)   | No            | OK        |
  | drivers/net/intel/ixgbe/base/ixgbe_osdep.h | ixgbe_lock macro      | Yes           | Likely        | Maintainer|

This RFC since obviously don't have the hardware to retest all
these devices. Some of the bugs are in the base code, but
a bug is a bug and should be fixed.

Note: There may be additional drivers with similar issues that
were not analyzed in this series. A grep for pthread_mutex_init
in the source tree shows many potential locations that should
be audited.

Stephen Hemminger (6):
  ethdev: fix flow_ops_mutex for multi-process
  net/failsafe: fix hotplug_mutex for multi-process
  net/atlantic: fix mbox_mutex for multi-process
  net/axgbe: fix mutexes for multi-process
  net/bnxt: fix mutexes for multi-process
  net/hinic: fix mutexes for multi-process

 drivers/net/atlantic/atl_ethdev.c      | 14 +++++++++++++-
 drivers/net/axgbe/axgbe_ethdev.c       | 19 +++++++++++++++----
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
 drivers/net/bnxt/bnxt_util.h           |  2 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
 drivers/net/hinic/base/hinic_compat.h  | 13 ++++++++++++-
 lib/ethdev/ethdev_driver.c             | 18 +++++++++++++++++-
 12 files changed, 95 insertions(+), 19 deletions(-)

-- 
2.51.0

