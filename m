Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D13C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319E0402B8;
	Mon,  7 Sep 2026 01:27:27 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id F182F4029D
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:25 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2890357a91.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737245;
 x=1789342045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAU3NPBO08TbjIuVXRLHgqaw+CFuGf5N+nrKnaAPngg=;
 b=Icupzt9KmuDWwMBL2md3Nplj3JDLsc4xSkgVJR1W0FZniVTI48Y3yXnb3SWdr2Tq7n
 vQoSfDdz//Qv+0kgdlKHgSyUDo28H9V/oJ3fk2/WriOuwQbfJtGtoLl9XCRtB8u0D9BI
 m0OTeFhF6GgsRCmijaqDVJN0PmpPeu84Edisr3B1uLC0MEVFPDBzIeaRmMIfp3GaQPt0
 6X06x6dEC00vnmSiB9K+sv8wtypxCDMgkRTjionlVSPSo+gsoU+RkPmLp0bhf2Q6uQii
 4MruEV67H/ei0XW12wnT4E43IsFz8uRo0O7s/JASV/aipcosaYF2lOBPt4mIwg+be5mb
 baXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737245; x=1789342045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAU3NPBO08TbjIuVXRLHgqaw+CFuGf5N+nrKnaAPngg=;
 b=sFVb8uqGmZgSxhFxRXJVWd/RgoAeIjaL+Hx1JihDg4L5UOjgsXaLQC2bLgGL/u3vkd
 8H5cNw0M1go54wM/ydz5NAFKu85p8yszkp1c3Y27uKNpGb6d5FWlXXpZk1ArXgUoBOUz
 T2knPxS5x/sHkaTrTPycdXwRFTW16QNc1jbxPquNSe3tquQDIkKflTXsTp+b7ikqkoid
 uhXkxre6YKFRjvqDXFZmyTSP5iFTujqL1WLL0y4eo5+tU6xFixsD8y58ds7MIKX9KAze
 7W4Q5HyGv+SDha3b+AYBnARluCNrB45VsboOCHg/SlpB9yycWTl3lK5ZRCS65xaIDaLL
 3FEQ==
X-Gm-Message-State: AFuF++k8Hi91Um43TITJsgdgRcHhGzyegyrgOVG2tb4JDwbQmr5IRJxb
 /Dtt33Ycbc4XF9M84ld8GzLE3O3yKYoFIQ4HIs6ab7z6zrXloFKmk0fSdkrqoUrLR/ic05+Bajs
 XfpF1
X-Gm-Gg: AYBFou1T0+QLeEAHwHAEBmv37vmGjqZtLCq4Tal49XCnxoHIqY7eS+Qt+RONNfSzRpT
 H1p0bMiSrDH2Nlz+6PC7eo54GrQ9OudAYAja5upxfgfKC2mLDqsB6qTlVCGn2eG/+AYo6D4sdx4
 XSWd3jCrj6HgPDrYvYbR/BXZxme+k8gjTVouRnxp+hGSsnjaDXQdf4wZkuZ0mP3pN/wvHOc9Y7T
 42sLgL6uiggz987Rr5GZ75+Ws+zpV2M9LxCv0phIEPIYEZD1mzpzCX06oHPEW14Bz1n5jjiYA7s
 W+K7Pbjq0cn7Is+WaEebgJW89NG5zvSMf+xGR/0DvAVbH5zDHtsLamt2Duzw9C1Sbb6lSHtNVEQ
 azfCW+TurRs25xv+D7sw+7CXGItTM+hLGDIA20qSdTeuhMqtF7WBiDZxo1q03bcKs6KOcxmfbrj
 A3KHm67pwImoQht6aig39Jb5GdvdnhutnEqAk9XG/6gVlDfpXYsXK14DGAzrjuLm1vQ511btkPC
 A1Vs/tk6T4MUol+9bcGrhFMf3raQkuUY9/n8w==
X-Received: by 2002:a17:90b:28cc:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-39b260e13d5mr29487534a91.1.1788737244675; 
 Sun, 06 Sep 2026 16:27:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/13] make signal handlers async-signal-safe
Date: Sun,  6 Sep 2026 16:24:35 -0700
Message-ID: <20260906232716.496546-1-stephen@networkplumber.org>
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

Signal handlers may only call the functions listed in signal-safety(7).
Many DPDK examples ignored this and did printf() a "preparing to exit"
message before setting the quit flag. A signal during another printf
call can deadlock. And some of the programs did even more
unsafe things.

GCC 14 -fanalyzer reports these:

  warning: call to 'printf' from within signal handler [CWE-479]
	[-Wanalyzer-unsafe-call-within-signal-handler]

The fix is the same throughout: the handler only sets the existing
volatile flag, and any real work moves to the main loop or to main()
after the lcores are joined. The message is dropped; the user pressed ^C
and knows a signal was sent.

Patches 1-2 only delete the printf(). Patches 3-13 also relocate work
that was being done in the handler.

Behaviour changes worth review:

- examples/ntb: SIGINT used to printf(), restore SIG_DFL and re-raise,
  killing the process without stopping the forwarding lcores or closing
  the devices. It now sets the per-lcore stopped flag, so SIGINT stops
  forwarding and returns to the ntb> prompt; quit does the teardown.

- examples/vdpa: the teardown moved to main() now also closes the vDPA
  devices when leaving interactive mode, which was missing before.

- examples/eventdev_pipeline: the second-signal escape hatch becomes
  _exit() instead of rte_exit(), the --dump-dev exit dump moves to
  main() (and uses the real dev_id rather than a hardcoded 0), and
  SIGTSTP now sets cdata.dump_dev_signal, which schedule_devices()
  already drained but nothing ever set. The SIGTSTP dump therefore
  requires a scheduler lcore.

Only examples/ethtool and examples/vmdq_dcb carry a Fixes: tag; the rest
remove an unsafe call that has not been seen to deadlock in practice and
are cleanups rather than backport material.

Applications outside the analyzer's reach likely have the same pattern;
this covers what GCC flagged, plus eventdev_pipeline found by inspection.

Build tested with GCC 14 -fanalyzer; the warnings are gone for the files
touched.

Stephen Hemminger (13):
  graph: do not call printf in signal
  examples: remove printf from signal handler
  examples/vmdq: do not print from signal handler
  examples/symmetric_mp: do not print or exit in handler
  examples/vdpa: make signal handler safe
  examples/vhost: make signal handler safe
  examples/vhost_blk: do not tear down from signal handler
  examples/ntb: do not print and re-raise from signal handler
  examples/ipsecgw: do not print from signal handler
  examples/l2fwd-macsec: remove print in signal handler
  examples/ethtool: fix exit flag and unchecked cmdline
  examples/vmdq_dcb: allow exit on signal
  examples/eventdev_pipeline: make signal handler safe

 app/graph/main.c                             |  4 +--
 examples/distributor/main.c                  |  3 +--
 examples/dma/dmafwd.c                        |  2 --
 examples/ethtool/ethtool-app/ethapp.c        |  5 ++++
 examples/ethtool/ethtool-app/main.c          |  2 +-
 examples/eventdev_pipeline/main.c            | 18 ++++++--------
 examples/eventdev_pipeline/pipeline_common.h |  3 ++-
 examples/flow_filtering/main.c               |  5 +---
 examples/ipsec-secgw/ipsec-secgw.c           |  5 +---
 examples/l2fwd-event/main.c                  |  5 +---
 examples/l2fwd-macsec/main.c                 |  5 +---
 examples/l2fwd/main.c                        |  5 +---
 examples/l3fwd-graph/main.c                  |  5 +---
 examples/multi_process/symmetric_mp/main.c   | 26 ++++++++++++++------
 examples/ntb/ntb_fwd.c                       | 16 +++++++-----
 examples/vdpa/main.c                         | 16 ++++++------
 examples/vhost/main.c                        | 14 ++++++-----
 examples/vhost_blk/vhost_blk.c               | 26 +++++++++++---------
 examples/vmdq/main.c                         | 20 ++++++++++++---
 examples/vmdq_dcb/main.c                     | 20 ++++++++++++++-
 20 files changed, 118 insertions(+), 87 deletions(-)

-- 
2.53.0

