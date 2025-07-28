Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DEC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF952402D8;
	Tue, 29 Jul 2025 00:10:00 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 35F60402AB
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:00 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7e346ab53d8so461857885a.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740599;
 x=1754345399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=je6NtdR3UrOF26jE0E0bonm86RcJRYMotohZSect1Mg=;
 b=H1vIw5pmisnwRjHcXuZBtpxLPCqiLoEAJ8DJHIfT988ycjEjRuD7yARNOYHM/XUVyB
 8v5bJfYAhAOOO3W4i4+TrZVCdY76BuhynVEY6TuqAmVEws3UXIrew16trdN6d7K6rFea
 FtYXUxsVcS7hwORqthSMkaO3+Zpmz0nVqfaW2Fb7+TI96IP2coOlS+i5HX1UL5z7oH37
 Ew8L6xY5hT1Z3N1eelYtnYolfZJdofxNlGZ4wduvNZLegSWXHdHlw+iqUnmUQaro3hRa
 2VUi86n76bnIQd8cDr/Qr9ixql7LYY/tkWxxF8GV0pu+h1o/MTI7tbbCCFUfOI76/1Nk
 yaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740599; x=1754345399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=je6NtdR3UrOF26jE0E0bonm86RcJRYMotohZSect1Mg=;
 b=esxQdhnsQ/Cmg52/X1umahHaOnrBKzVB4wNqBp2P5LFEmNuNgTbfw9nSffO6ofT60k
 vCwBqR6Wn2IgZ1zY+1uIcu9aoaHLnAlAtTcMyyKfFMttoOWgEbD8nL3NcHq1wNoY2Pfv
 I/8Y1nYLG/gVg6iyznCnAUf171VDHExDqZHlxYsKJNX9NWsTKNFgn56FKbqjvrA/abwI
 OCUgwJbCZvwJzv1ayUttE0NgCZ8revYYDOwPOvBYCrjkxBaGsHl1rx4DYqdf81mx56GD
 Hha2u94SOHhYc+1LPaLVaNGBg3SCX9wRtCq/8Sg7gszLfwiI0q8ujkdlGsS1GEqX41ix
 BaXg==
X-Gm-Message-State: AOJu0YxbYonJrqENZg5zM3fcT5TOwkgA0HSo0n1qIJag8DQ1QzpBnsBp
 kCCBNCF2MlN4Zqsux9YXb7e2tGDzdiiffbNMQDgBVXstTz302ggp1K/rA5tPnmkSCz/zrwWAeJe
 e+9vd
X-Gm-Gg: ASbGncvfS3wY2Ho4sPazvhB5fs+MAhA2gpexVyw4gztQIDcmkCSwKCFclfo1zsF9TEA
 hXxTW6fm11wrzChwv7G64p6QmKcPuMvsCLXNPCxvGQBbIdh2lAxxV9wBmgb72+6+OYQq/8r+VnA
 ynoukXXuASnIiDVsMhIc6b9SUFoidEFUv0hVoLap3RTln4yjO79/fIj3NVeoFhtnNsszyLpZOp3
 i+DFcsAnfGuGvCfLDHxyd9unAZ9cEXJnjIfTLZrhfapML16OvRELUin2MFokarthUYh+HUeBy17
 D1fQolf0B/LBmRbaHXPB+/VOIsCnHeUMLEghy0eJPXfEDT85YbLyF5gGMo7o1NPcVWbvFbZHWXX
 M52+YyIYf88bHzlAIndnlo5YNaciAlxbOv1SHGrvyaCwdulaay523NcLKhNbEStn6xIWMG59JlI
 JsIAKRt10=
X-Google-Smtp-Source: AGHT+IEdTNNNQYAPKI5NXIzac6tzc1HMoVszfs9vxW2RcOzcr30sp+NuX7vSpdZiIkb1iDXBuKduhQ==
X-Received: by 2002:a05:620a:6685:b0:7e6:5f1c:4d80 with SMTP id
 af79cd13be357-7e65f1c5155mr145789085a.66.1753740599204; 
 Mon, 28 Jul 2025 15:09:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:09:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/12] Port mirroring for packet capture
Date: Mon, 28 Jul 2025 15:08:08 -0700
Message-ID: <20250728220955.332924-1-stephen@networkplumber.org>
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
  - can't work when packets are sent and received in secondary process
    because callbacks only function in the primary process
  - requires "opt-in" from application

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's:
one to add a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command syntax is
unchanged (no doc change needed). Using the new mirror mechanism, the
dumpcap program creates a port using ring PMD and then directs a port
mirror to that new ring PMD instance.  Then the packets are extracted
from the ring.  If capturing on multiple devices, they all get
mirrored to the same ring PMD.

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

Added tests for the mirror features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - need release note and documentation
  - more through testing on real hardware
  - figure out deprecation for pdump

v7 - review feedback
   - add statistics
   - remove deprecation of pdump

Stephen Hemminger (12):
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  test: add tests for ethdev mirror
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump

 app/dumpcap/main.c                          | 471 ++++++++++++++++----
 app/dumpcap/meson.build                     |   3 +-
 app/test-pmd/cmdline.c                      |  13 +
 app/test-pmd/cmdline_mirror.c               | 194 ++++++++
 app/test-pmd/cmdline_mirror.h               |  13 +
 app/test-pmd/meson.build                    |   1 +
 app/test/meson.build                        |   1 +
 app/test/test_ethdev_mirror.c               | 325 ++++++++++++++
 app/test/test_mp_secondary.c                |  51 ++-
 config/rte_config.h                         |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/ring/rte_eth_ring.c             |  49 ++
 lib/ethdev/ethdev_driver.c                  |  12 +-
 lib/ethdev/ethdev_driver.h                  |   6 +
 lib/ethdev/ethdev_private.c                 | 141 ++++++
 lib/ethdev/ethdev_private.h                 |  29 ++
 lib/ethdev/ethdev_trace.h                   |  17 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/meson.build                      |   2 +
 lib/ethdev/rte_ethdev.c                     |  99 ++--
 lib/ethdev/rte_ethdev.h                     |  23 +-
 lib/ethdev/rte_ethdev_core.h                |  12 +-
 lib/ethdev/rte_mirror.c                     | 435 ++++++++++++++++++
 lib/ethdev/rte_mirror.h                     | 145 ++++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/pcapng/rte_pcapng.c                     | 179 ++++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 27 files changed, 2054 insertions(+), 225 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

