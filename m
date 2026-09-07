Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61403C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3351F402DE;
	Mon,  7 Sep 2026 19:05:04 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 1B65F40262
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:03 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2983467a91.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800702;
 x=1789405502; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SUae9/u5P8IKsdPnqOQ+CY/IM3MRUNvL/FwiaBqxLU=;
 b=q40ZkhtvWRlrOUbE7ySawVQWFyEMkw6B3wIcPeW2lDWAcvDCZGcVgqac0PJbFLOAo0
 jzE1TVLzPSDfvAUhoEm7hrIMAS8zKZJhC7VoS65pWpZnnzpILzVdPwvFZcaMhLWyFoec
 LcvNxpj593gMDNaSgG2iVJ64WbQwiKPntDdI+GQAAFXtqiMkCYan+TjriY0x/pjOd5CX
 eGGFzI3vQkTDP2ro2W3M1MqjXDUhj8/8pOAMfhCPxAUvAwyFzQC/2zcEsSgV0Efv8b2X
 lfx79s76/nsPBVH+43rZytrgmkHI13lUcruYp523ITjUS0MneW+Ylw20q2u2UQ+YNjas
 kPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800702; x=1789405502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SUae9/u5P8IKsdPnqOQ+CY/IM3MRUNvL/FwiaBqxLU=;
 b=nGaS4jjkoW2BCmPlIX2T502GD9A0D9Z//1iMH6zpMjj2XuQah1gQ/P3QC5ZSpmZUhj
 gaXdfXZoyiTeUolbArYc4R+03l38leuPRnJ+0ADlfsoTTNlnGtY+JVo7FrFpsPCRTPib
 F7lV36B6OVkL782Pjb5RdvKN4Igv7+c59ryC+sF983/zqBMGhrjF9guKrV9jM0JdgFGn
 jPucLk/odpfUu4qXUn2YG0dGi2AkO0OyNs71og2o9dQmWPP75KQjAVddFqd20WeR7Xyb
 IWXkF3ZFR9w4mpw3yeYCuoXD/Vm0yXXMQyxsbM5A7P3ea4elFOVEC7xK64G2EyzoZEVb
 D+Hg==
X-Gm-Message-State: AFuF++k6gtLiFsIer1rCrQlLdaV5ldvh8QfJSXMA5RAcpqVcuxzaoJOB
 lPTyIIatRKFMzkR6bYtW/P7D5GDeagBL1ADh9b1EMXyCfCFegKVM2ZlTPVlgFAdMYAUq2xOETZc
 9wdpM
X-Gm-Gg: AYBFou1pt28vSUYrMyDmafwOn/K1UlXq8ie5IL+KSv46CQMabwGj7IDsVQBoONrVUuP
 8iORCHgE+IAstpnydHDAcZaU1mNgalYa5N0d2qtrKGyRHRIdBVNaJGYakP3bQwhquqDMm63bIah
 pUR2sD6BZ/GF2iVF1YvkTxR6kQTaGWdllXMW4wksto9s3M6XcFHL3JwmeBngUPbx1ULLxeCByT8
 5DYsv+ct9RYwPesJ4F7Cp5gpKZa9myh1+6stvitGYdzKYtGd6/aV1FvN0oPLXmZyqdnkbc28oHG
 rBaZQmrmnsqEnwdlg4QwrL8VoCakMB0HBjX0gx1M5MCSTwwc4C6hJuo8WzBYTF2MQWfRZaBRm9y
 QWGeNUGBKNP3YpeAaUWQLxed6jOJCU1Jd8yRBzIkBUZ+Zk4j65YlUfKwu44e93w6u0fzDJ6RiO1
 qE7iDg2vog+MYiFZmvdgiqgFvSviHj+zCrcx6SjewQ/NPQHJR/SjXJ+vzZ22QsZ8g93PeiqUXP1
 3oABEp8hj1jbdn5/hR6pGyKx0Sl
X-Received: by 2002:a17:90a:d2c7:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39b262e4e02mr34632592a91.23.1788800702033; 
 Mon, 07 Sep 2026 10:05:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/13] make signal handlers async-signal-safe
Date: Mon,  7 Sep 2026 10:03:18 -0700
Message-ID: <20260907170454.351647-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

v2 -- needed more work, the Claude version of examples_pipeline
      was over complex and had build errors.

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

 app/graph/main.c                             |  4 +-
 examples/distributor/main.c                  |  3 +-
 examples/dma/dmafwd.c                        |  2 -
 examples/ethtool/ethtool-app/ethapp.c        |  5 +++
 examples/ethtool/ethtool-app/main.c          |  2 +-
 examples/eventdev_pipeline/main.c            | 41 ++++++++++++--------
 examples/eventdev_pipeline/pipeline_common.h | 13 ++++---
 examples/flow_filtering/main.c               |  5 +--
 examples/ipsec-secgw/ipsec-secgw.c           |  5 +--
 examples/l2fwd-event/main.c                  |  5 +--
 examples/l2fwd-macsec/main.c                 |  5 +--
 examples/l2fwd/main.c                        |  5 +--
 examples/l3fwd-graph/main.c                  |  5 +--
 examples/multi_process/symmetric_mp/main.c   | 26 +++++++++----
 examples/ntb/ntb_fwd.c                       | 16 +++++---
 examples/vdpa/main.c                         | 16 ++++----
 examples/vhost/main.c                        | 14 ++++---
 examples/vhost_blk/vhost_blk.c               | 26 +++++++------
 examples/vmdq/main.c                         | 20 ++++++++--
 examples/vmdq_dcb/main.c                     | 20 +++++++++-
 20 files changed, 140 insertions(+), 98 deletions(-)

-- 
2.53.0

