Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D1C83F22
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD58B4028B;
	Thu, 10 Jul 2025 18:42:42 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id D2599400D6
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:41 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7d44c6774e7so74549785a.3
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165761;
 x=1752770561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5l1+I6aLFvGhrpZXT4XGGNbmbB3Mgf+rSKVdF2U+mbg=;
 b=KchKqM9E7OWe/7SAhg5Zz7PPf31GdXCdlZpXZUwo68+qnl6n6tASYD5E6wPvF0unX0
 csWXlAMT4SC28kwZ99rSF/pHqktetGgJI4XXjEdpT/uLNKANVE2tNfceL6IOHtZbniMj
 M1jxpVb6YwwYlq5TDJi0aeZ3Q60Wvcr+JlLbuH2E5xS5oeHGKKCxsrzIsSVs2gmuVyit
 qpujyzCz/TRdyOtrezJ8pFp7SDJZQQ9D1vbvU43ZrLz35SRwM8HFNQwQT+WhrpIOJuKu
 rUpOhszGPMEDceBjuyS9q1jpQ5prk9qJD90JQNebrm6MYYb8qAq/xXjziE0bPaI1UKB8
 cINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165761; x=1752770561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5l1+I6aLFvGhrpZXT4XGGNbmbB3Mgf+rSKVdF2U+mbg=;
 b=HTGd/UcQqtn88m3ZMIL3p37cZ28KcNGnLArdTv3lRsc4NFLGTokcrDVAeDEI2UN0dT
 0VRmOFjwa+p3VjXSaBeSnZGfR3/cxLDS5syclT4Cvtgkp3VtlXxVVX6WOkPsgSmAUnRb
 JafVKqw06C7D3ITk4RXNL/GbJwws2So6SxoZFV9nPYs62t/b6Wi9P2WjCVOmLl+nNDHt
 p65+jOY7cdjNpTGt+bUs8VfUZMuUoJfn8Igyr6uPPcVJJOVXArch737MVxTbSqusMRxx
 Q4t4DSiGXLPEIhzD/AcNFtw0nR2yCcI4OIQ3sNORhwHFNRyB5IcDpfpEsuipc5T7n1A3
 Ji8g==
X-Gm-Message-State: AOJu0Ywpv41BtTKq9VNNX882dTFS5t44DXtJp0o/3OsyR9KC4L81wYkM
 dh1/x5sBoj/6pHJyH0zBDaUfEnSCvUJdLM6xgFHraxICIcCyRCOkgiQzQrlQsPrij5DxYHHhBWe
 a7KzP
X-Gm-Gg: ASbGncsRiaGnh1MJmP2szFlhFdf853BvT6cGazoFU0UAYmTRspmTJ6LMXTlRsHz+Asn
 /F0N8tEaIrrGiw+DJ3DFYSG8NGcL56quwD2FiZBVERHgaIf9UwLYkrACdA3lSx0raODX1995hwj
 bmJLTq6Qfa255B3a+SnCvRz1y3fm6wycqHU/CAWVFU61Qn86BQ+PbZ8AYUrIig6s6j7KExdn1TC
 Plej0vyVDnmEZWJv5HQCUvrh+yNx/KmRhGHaW2Ypcid2N19C6z+q6IsT+Bu4B/A742S6uWXKg17
 JtgNjND9L2k+DoGV3jRnUeW1Oik0iUaEcKkFVnm006/GyaAZ2sctEwxXj8Ytm1fGy/GV9QQkJrm
 F8rYJ+YLstBaWrH6/KcXfZT/n3QChgU1OPn4D
X-Google-Smtp-Source: AGHT+IHu4OeIjIKMgqqxodDKz/GXfgLv+Ail8wa9bQZJ7vpDQ+Qcq2VEsKYGFGeKOXG81WlhIGIfpA==
X-Received: by 2002:a05:620a:1926:b0:7d3:8f51:e80c with SMTP id
 af79cd13be357-7ddeb3cca99mr31977785a.22.1752165760778; 
 Thu, 10 Jul 2025 09:42:40 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/13] Packet capture using port mirroring
Date: Thu, 10 Jul 2025 09:16:41 -0700
Message-ID: <20250710164237.8630-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <0250411234927.114568-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
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

V3
   - fix CI test reported issues

Stephen Hemminger (13):
  ethdev: allow start/stop from secondary process
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devargs for dumpcap use
  mbuf: add dynamic flag for use by port mirroring
  ethdev: make sure all necessary headers included
  ethdev: add port mirroring feature
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump
  pdump: mark API and application as deprecated

 app/dumpcap/main.c                          | 444 ++++++++++++++++----
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
 drivers/net/ring/rte_eth_ring.c             |  91 +++-
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
 lib/ethdev/rte_mirror.c                     | 349 +++++++++++++++
 lib/ethdev/rte_mirror.h                     | 113 +++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/pcapng/rte_pcapng.c                     | 179 ++++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 lib/pdump/rte_pdump.h                       |  12 +-
 31 files changed, 1866 insertions(+), 212 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

