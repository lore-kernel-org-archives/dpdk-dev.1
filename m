Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78446CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 03:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2874C40285;
	Tue, 13 Oct 2026 05:41:51 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 3CA2540272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:41:49 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ab33730821so1355188a91.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791862908;
 x=1792467708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4hbxWju3I/St9eTINr7QBgxAmbpASb7jeRkWXUW4fo=;
 b=XTTIo9YT9uyuxE6+DPTWYiXwLnmfqBLQ32DrM6t3AHmjVbahRuDkFVoQY58Oycw4zs
 x6gmn39qR+pWuy8YApBpgQxQuBydZfSPiBnp6FtP5wSU1Mhd/GAIYJdBawWK9iCsut8/
 6NOLhkWxBBxl+6WjcEd+3/wuoZpo15po4MVFVP2lako5n8nvS9kavokXl0Iy04Zgyjh1
 SGmvE/f92LTKgdwdwxNJWJB3zpV4jgwZodQ0fWBLSv3ot4yJ3eApefApQc1+K3CLUHGG
 ceD25fZ5iBH5jg2OBNJSpvYqGgObMTt5GQAAwb2csaAWUKmMXs5asF7IL4fcgo+wsTBh
 p5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862908; x=1792467708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4hbxWju3I/St9eTINr7QBgxAmbpASb7jeRkWXUW4fo=;
 b=uOJwF1InSHA9BG9jD3LWHo6LpsAbW+BWGzrGz6cFKw/p6Tdgx+pYasfN+D8IbSX9Nb
 R84VEadOdq/uJ/mDMI4hbNsxeRyLBxkc+10YXeSqsGEEPRj2NTAbdzFUiJjVuumH+9G9
 oRnVxgdkLkbIZjqryoM0P27jRpvwUpDcGxvVKavh2/AtBVi9WXntkuTqRi5yAKoQFypz
 957hGu+1mSHvLIB/ds6tQjmLnGuVHkACKXihlNZB/HDok4W2l3Cp3FFApfB5dJFJc8DX
 whMbWqNMFweXyuz3srQcYxUHhfy6rlP+PBh0aFXoAwOIchY5ELS521ilUZKq/Sc/NZm0
 4eeQ==
X-Gm-Message-State: AFq9FYLCccMhZi7bPq18UYQC3HEMv5sww/6AfmeWa0npvFi9ysOk9Aip
 Wa/I8Iw2WK5qKnJtnJX7zSh0vuPln6Aj83ZPr60vlg5FNbXNWA8lgSHRv8337HgV7iEHbDmLBvy
 J4GmaQPI=
X-Gm-Gg: AYBFou1KyZuRx/EMmZAD9NlAgzKUhl6lzJEa7RYbliO9clTOrFeWNQUFh0Ng4xvRUwK
 V2NBQuuuwFGyPboxJ0xs2mRbPnSQPkhlzM6FQ7sejW2D6gECm1WzRTwyQF53h2ka4hYn7160Ogs
 foVgz2WqFMO7/ApLitXq38UdIGwc1KY7o5cV32QBq2sVcT979RvQcpkci6Z896Qi8QXsIDDXTyu
 T5WO7Sm3D0aQXFWvTRYd23ukSqfXY0jwLilcwe0lK/9PEDg+EyF8K8Tjj6oBlHMTqeCz0sE0vvq
 QigVA6sxnlJJiaSt9TtXzOKxddAD4rGR6XlWgsxcXONXSc5Yh55DIIPSVB3/5I3ZAqsTshjSKtX
 SAVxTNwR23+RCL6OPrx55DBbKHzuxbb2GaVcsxybFhqCGEqQepPziiyA31zxdXsfvc/A9UdEUjd
 bGcqkuG1DNuHjLDr1Grq9/Aec9a/bkG6jJDsGPGB88bG2+VdWJNzcH6CENNQ2RXIAzTiuiqJbTY
 6ZVUA4t7NFpxp5RvO7poCLv0o1nIuIuAcpeWQ==
X-Received: by 2002:a17:90b:384c:b0:3a7:aa1c:476b with SMTP id
 98e67ed59e1d1-3ab3a747d90mr11152297a91.31.1791862907766; 
 Mon, 12 Oct 2026 20:41:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38ff0d34sm19928740a91.14.2026.10.12.20.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:41:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/3] wireshark capture implementation
Date: Mon, 12 Oct 2026 20:41:02 -0700
Message-ID: <20261013034145.979361-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727224417.1419663-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
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

This series adds live packet capture from a running DPDK application over the
telemetry socket. A new capture library installs Rx/Tx callbacks on an ethdev
port and writes pcapng to a FIFO, with an optional libpcap filter and
per-queue selection. A helper program presents those ports to Wireshark as
capture interfaces.

Advantages of this:
 - no secondary process needed to capture
 - installation is just putting the helper in the Wireshark extcap directory
 - the helper has no dependency on DPDK libraries; can be packaged with
   Wireshark
 - allows for live capture
 - supports BPF (with JIT) for filtering

How it works:
 - The capture library registers telemetry commands (/ethdev/capture/*)
 - Callbacks are installed on the specified port/queues to copy packets
 - Packets are formatted as pcapng and written to the specified output
 - No packet data passes through the telemetry socket itself

Packets handled by a secondary process are captured too, using EAL IPC as
pdump does.

The helper is a C program so that it can be installed with privilege, which
is what lets Wireshark capture from a root application without itself running
as root. See doc/guides/tools/wireshark_extcap.rst.

Linux and FreeBSD only. Windows needs the transport first: telemetry has no
socket server there and uses SOCK_SEQPACKET, which Windows AF_UNIX lacks.
A stream socket would need the replies framed.

Testing:
  - dpdk-wireshark-extcap --extcap-interfaces lists the ports. Reasons for an
    empty list go to stderr, which the Wireshark GUI hides.
  - Unit tests are in app/test/test_capture.c
  - Tested on Linux capturing from a root application as a non-root user.
    The unit test also passes on FreeBSD.

v4
 - helper rewritten in C, and can be installed with privilege so Wireshark
   need not run as the same user as the DPDK application
 - capture packets handled by secondary processes
 - split the library into several files by area
 - dropped the pcapng change adding the filter-accepted count to the
   interface statistics block. Still reported through telemetry.

v3 - fixed AI review feedback

Stephen Hemminger (3):
  capture: infrastructure wireshark packet capture
  test: add test for capture hooks
  usertools: add script for wireshark capture

 MAINTAINERS                            |    4 +
 app/test/meson.build                   |    1 +
 app/test/test_capture.c                |  688 ++++++++++++++
 doc/guides/prog_guide/capture_lib.rst  |  167 ++++
 doc/guides/prog_guide/index.rst        |    1 +
 doc/guides/rel_notes/release_26_11.rst |    5 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/wireshark_extcap.rst  |  198 ++++
 lib/capture/capture.c                  |  560 ++++++++++++
 lib/capture/datapath.c                 |  420 +++++++++
 lib/capture/filter.c                   |  180 ++++
 lib/capture/meson.build                |   24 +
 lib/capture/multiproc.c                |  246 +++++
 lib/capture/output.c                   |  294 ++++++
 lib/capture/private.h                  |  214 +++++
 lib/meson.build                        |    1 +
 usertools/dpdk-wireshark-extcap.c      | 1145 ++++++++++++++++++++++++
 usertools/meson.build                  |   23 +
 18 files changed, 4172 insertions(+)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/datapath.c
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100644 lib/capture/multiproc.c
 create mode 100644 lib/capture/output.c
 create mode 100644 lib/capture/private.h
 create mode 100644 usertools/dpdk-wireshark-extcap.c

-- 
2.53.0

