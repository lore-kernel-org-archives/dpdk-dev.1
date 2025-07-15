Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684FC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE9134042E;
	Tue, 15 Jul 2025 18:17:06 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id BCCCA4028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:05 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fae04a3795so43726146d6.3
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596225;
 x=1753201025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZevxG148xAMh/Wu9ayy0sBpoYxnmJZeS8QjQ8AnR+L4=;
 b=tSM8nI4JIGzsrvRH4Dhr7zHXOAAPktSCk4zAx2WnkimQWmuRJWtjw66rS3CTaUYMdO
 PcpguWbiq+26OpM73jbd41T2AR3LMRJVdT+AGaTEWC2Yy/bYvwLm05IOavQaF7roOltL
 AKF6kwS3Yto2j0Lp1zGm6F8iWCIgLrTY+BNdKZQNGZEFeXPVC5MtIAZKwxmdH0/I+0H+
 yOTd+sSXC8stl6REvzLyLmzYI10ilyiJlqU38GkRlugP38C9+Ez10HqbHZQk5GPQio9Y
 Gxjpk8t9y2mHo7vE/a+BKdo0OpCtFBA2dVBeZ+qt/ymG0/6VuKSFdptFavDWSh08XKM/
 Hjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596225; x=1753201025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZevxG148xAMh/Wu9ayy0sBpoYxnmJZeS8QjQ8AnR+L4=;
 b=wPguj5mpTvUq5Ln0yveN9+Jvl2rh4Fw3O2lKebrXTxmJlaBm4MBXr3iZ5crG2E6tfQ
 QMv+NWNOZSDOdj2x0jLMXr4O6bEXUvFBGluRMKSrVB9PvX6GKiGRPmcMhKze45gtQluo
 mhON+Bc6PcbsFkLqAVqMND+CTmK2GNCBOxlZ7/HVr1bONZ2SiQAqZ816ONL3UheWhoNf
 A+Voo7ngGe3LUeUkLTx1t9k1ng147G03opPZ5sMAZugPIGo/K7emaNHytwwZ8Z4RcirT
 8TGzauNf2uisTgBqWr3RVSoqWB4BcWWYpIt7vw87eCKd6n+mFu97zGxvqA+fw8IkvROf
 Q+xg==
X-Gm-Message-State: AOJu0YyzrIKpFLCChvwaKuKfMYxw1/ssKxtq8TzjkSHrGuQDoUiG0fc+
 Lgio7czAbYvFsirbmBDe+q/WKYur8GvHKq9CWRLW7zFeuXCPaDq/pEXZ+vrHoL+IRciuxMBXTEs
 fOp7I
X-Gm-Gg: ASbGncuPe8LKdp9h6A+Ot9MI1cPp2tkab5R+gik2J+HaJ2azvQQyDm/n5XBJW/f3b9m
 bm/k5ywhFWhFXjEbULVLWBIvWQEN2GIGQAqHmsCXoHmN/FjzetRdjZ2EnuP7IRTZ2rZN1n0Dzak
 6Pzv93EBVzfsfJN/pPhTd2DAYF7KTa3E5L976Q61M8ibxReAg9t6XSn1ulLca0F2TvZ4mSLAAZ7
 aYhGo/NCfeCHFgxhDS9TN6G9hCd3+5akRoFqpiwKfyFxAUAG0V+wQOnu5WfP3nM8LQ00vTQyIIE
 lku3bf3RCNnBA4eIgxb+3mF68lgaLHmfJXYEpiQk7h3jfyOG3xNslrTKv+jrknvgNeYiuBMPXkt
 NI3QE8KQWhVPr3wtBPahuKHYMI8MMUCthKrKcV356vK6eJM4nXDm4l2i9+axlO0JbaBQaEKCZ
X-Google-Smtp-Source: AGHT+IEeEm82PQ3s7dKEiMVBXLsKEu6cAfdzPWMFbO7E4B5o/YbzQXinJIXsYSfk3kK5NmpDyborjQ==
X-Received: by 2002:a05:6214:301a:b0:704:cad3:a2f8 with SMTP id
 6a1803df08f44-704f47f0958mr1136386d6.7.1752596224362; 
 Tue, 15 Jul 2025 09:17:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/13] Packet capture using port mirroring
Date: Tue, 15 Jul 2025 09:15:38 -0700
Message-ID: <20250715161700.103209-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

This is a rework of how packet capture is done in DPDK.
The existing mechanism using callbacks has a number of problems:
it won't work when packets are sent and received in secondary process because
callbacks only function in the primary process; pdump requires that the
main program "opt-in" to having packet capture which requires changes
to existing network appliances.

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's one to add
a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command
syntax is unchanged (no doc change needed). Using the new mirror mechanism,
the dumpcap program creates a port using ring PMD and
then directs a port mirror to that new ring PMD instance.
Then the packets are extracted from the ring.
If capturing on multiple devices, they all get mirrored to
the same ring PMD.

The dumpcap program needs to be able to start the ring PMD it created
but the existing ethdev API is broken when used from secondary process.
One of the patches fixes that, it was also reported previously in Bugzilla.

The mirror API has a restriction that the port being mirrored to must allow
lock free transmit. This is because both Rx and Tx as well as multiple
queues need to go over the same transmit queue. Although it might be possible
to have some complex mapping between multiple ports/queues being mirrored
to multiple transmit queues, that gets to be a lot of overhead in API's
and implementation. Fixing the ring and null PMD to allow lockless
transmit is good enough.

Added tests for the new features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - some names are too verbose
  - need release notes for new features
  - more through testing on real hardware

v4 - add headers need in some build enviroments
   - don't need ring pmd to timestamp

Stephen Hemminger (13):
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump
  pdump: mark API and application as deprecated

 app/dumpcap/main.c                          | 443 ++++++++++++++++----
 app/dumpcap/meson.build                     |   2 +-
 app/pdump/main.c                            |   3 +
 app/pdump/meson.build                       |   1 +
 app/test-pmd/cmdline.c                      |   1 +
 app/test-pmd/cmdline_mirror.c               | 129 ++++++
 app/test-pmd/cmdline_mirror.h               |  12 +
 app/test-pmd/meson.build                    |   2 +
 app/test/meson.build                        |   7 +-
 app/test/test_ethdev_mirror.c               | 285 +++++++++++++
 app/test/test_mp_secondary.c                |  51 ++-
 config/rte_config.h                         |   1 +
 doc/guides/rel_notes/deprecation.rst        |   3 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/ring/rte_eth_ring.c             |  47 +++
 lib/ethdev/ethdev_driver.c                  |  11 +-
 lib/ethdev/ethdev_driver.h                  |   6 +
 lib/ethdev/ethdev_private.c                 | 142 +++++++
 lib/ethdev/ethdev_private.h                 |  29 ++
 lib/ethdev/ethdev_trace.h                   |  17 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/meson.build                      |   1 +
 lib/ethdev/rte_ethdev.c                     | 101 +++--
 lib/ethdev/rte_ethdev.h                     |  23 +-
 lib/ethdev/rte_ethdev_core.h                |   6 +-
 lib/ethdev/rte_mirror.c                     | 348 +++++++++++++++
 lib/ethdev/rte_mirror.h                     | 113 +++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/pcapng/rte_pcapng.c                     | 179 ++++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 lib/pdump/rte_pdump.h                       |  12 +-
 31 files changed, 1822 insertions(+), 210 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

