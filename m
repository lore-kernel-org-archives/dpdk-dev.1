Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690FCCF2C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 22:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2B84064F;
	Sat, 17 Oct 2026 00:32:12 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id BE622402EB
 for <dev@dpdk.org>; Sat, 17 Oct 2026 00:32:08 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso1672155ad.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792189927;
 x=1792794727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KyVJl13G/9qon+bEWiqfeuy7avDcz1AvFSxIeAdm+cU=;
 b=LqYfJbXYmPPqO7vAaXILNsqFUzESN5pLM6oZaeMpqdYGQbZKUcbOs0R2HD3RcI1x03
 saha9w23a3msHaPqtGdqxTsGBhPNMpG1kEtIjKYcgWA1CFquq9kAcgy+Z3SIyZ8mL3ng
 /7+lMuY5WWQvbDQYEpdH/IjXQkYBWYFJGSQXeielVmB3TJp5QiInnUfXS9+JaA4HW77x
 RAhTUTKkHG4gdVaURZPcw7drRv3V74Eol+Ys2SG4l82/wc26Gs2y0ixKA48y/myjfVDF
 jVlzSk6HQuW4fpandfC4d1Z2z/OskpnhyiQJ9s4IhYrmCF52axo0tZbSR+27GXP+FRxM
 NaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792189927; x=1792794727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KyVJl13G/9qon+bEWiqfeuy7avDcz1AvFSxIeAdm+cU=;
 b=AWSNx20n2hG9Vgzs02fXOemGbOc8YjIPYJK0rV5xN4jYplKcw/FRdSvvpauA61wMoP
 QfkeyC2b11S+LxlhDUDar15+x1KYyl0N8kYjDbBwB5+plve0V7DEMdBDWAQxJeXFl4+Z
 n3f7OVUHgoUNiY2GQeju2ZrlPrOmj5T6M5AmlnYk82bk0C+6MV4qyGXyCsnjL7LxXpo7
 F82NPfsN04gBaPwdAvwKX8DPKybEk3yN5UbjHffYngkQ+hhMENJF2zNfIS70TPW3VFDX
 T5lED9h2ChfYXStfWDXMWaKnQEybtV3C+yB+YBTMFycxyAwOxMTvLXRSa60TwZmt5y0X
 Nikw==
X-Gm-Message-State: AFq9FYKnPzOaACRp9OBgmQPy8VLaBkjhJs/pjd3lk+IlLA/zga3enWGH
 A3Ct7PCmEyP0hNZUlLHWiFKAMXOWUVfahI9Q7MDvdq23QN47e0LpTdFqWYDo1ml4lPySEc6UL9/
 6Imru
X-Gm-Gg: AYBFou2LKkJzH3CUCADmFP///yG6Dw0U9POYjik8h1BoIyXOcJQ5icJxVnwE+tJXmNK
 o2o5e3809VHW+Vh0i1zSeF2oRDuOYEuAJmUSMDq5Zs8pVjFm/O2g4NrbVS8mcP/W1xMMABRDMv2
 rzWqKSEq/LsLNcLAD1HsCF7XELppj4wY0d/+W5rJPp6GzrLdWOR0OOF4RMVyI36HnCz38UEbVfZ
 aAjUxCRZngrGGQXizw+IH2Pc/R9NYdYHIBfsirmgNvaEvzufY4batprZhZ77j/CfmNLGZi1WC/W
 dbLJZepmsfV8jOYuItD4NncgVTyah/q2fOiLgd8ml/FRUc7gw+02qrGSLESnbycXOTHzrNl4qK6
 2p9u9QnEA3acj1x7D3SROElAdp9m+71ArLA0CDyY+T/RUw8mcrkbDXysz5sgRyaFJwfgLE2UJjT
 QkT25S+B5UGFFRshjjQorHqEzSnK4Be4YZ8Y/xehr0QhBObiBjIY4nRjWgkw82scz9PuBPZTS2b
 HXjj4pJYSFg3vc71MD8E74m2ZAFH7bYJV581g==
X-Received: by 2002:a17:90a:d44d:b0:3a4:6f38:f2a2 with SMTP id
 98e67ed59e1d1-3acef19cb63mr979552a91.25.1792189925325; 
 Fri, 16 Oct 2026 15:32:05 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm10827348a91.7.2026.10.16.15.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 15:32:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 1/4] capture: infrastructure wireshark packet capture
Date: Fri, 16 Oct 2026 15:30:31 -0700
Message-ID: <20261016223201.608942-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016223201.608942-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261016223201.608942-1-stephen@networkplumber.org>
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

This provides a telemetry extension to provide packet capture.
It is intended to be used with a front end program to provide
external packet capture for wireshark.

Captures packets from both primary and secondary.
The mechanism is similar to what is already done in pdump
but does not use pdump itself.

It uses its own implementation of userspace RCU so that the receive
and transmit callbacks need no atomic read-modify-write operations.
This relies on the OS being able to force a memory barrier on every
CPU running a thread of the process.
That is available on all the operating systems DPDK supports.

The DPDK QSBR is unsuitable here because it requires the application
to report quiescent states, and the point of this library is that
the application is unchanged.
If this type of RCU proves generally useful it can be moved
into lib/rcu later.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                                   |   1 +
 doc/guides/prog_guide/capture_lib.rst         | 185 +++++
 .../prog_guide/img/capture_overview.svg       |  49 ++
 doc/guides/prog_guide/index.rst               |   1 +
 doc/guides/rel_notes/release_26_11.rst        |   4 +
 lib/capture/capture.c                         | 656 ++++++++++++++++++
 lib/capture/datapath.c                        | 414 +++++++++++
 lib/capture/filter.c                          | 179 +++++
 lib/capture/meson.build                       |  42 ++
 lib/capture/multiproc.c                       | 245 +++++++
 lib/capture/output.c                          | 311 +++++++++
 lib/capture/private.h                         | 233 +++++++
 lib/capture/rcu.c                             | 258 +++++++
 lib/capture/rcu.h                             | 112 +++
 lib/meson.build                               |   1 +
 15 files changed, 2691 insertions(+)
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 doc/guides/prog_guide/img/capture_overview.svg
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/datapath.c
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100644 lib/capture/multiproc.c
 create mode 100644 lib/capture/output.c
 create mode 100644 lib/capture/private.h
 create mode 100644 lib/capture/rcu.c
 create mode 100644 lib/capture/rcu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93ad53027d..71af3542e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,6 +1723,7 @@ F: doc/guides/sample_app_ug/qos_scheduler.rst
 Packet capture
 M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
+F: lib/capture/
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
 F: app/test/test_pdump.*
diff --git a/doc/guides/prog_guide/capture_lib.rst b/doc/guides/prog_guide/capture_lib.rst
new file mode 100644
index 0000000000..43823ffc87
--- /dev/null
+++ b/doc/guides/prog_guide/capture_lib.rst
@@ -0,0 +1,185 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+Telemetry Packet Capture Library
+================================
+
+The capture library records packets going in and out of the Ethernet ports of a
+running DPDK primary process, and writes them in pcapng format to a FIFO.
+
+Overview
+--------
+
+Three pieces are involved. The application links the library, which does
+nothing until asked. A capture tool creates a FIFO, asks the library to start
+capturing to it, and reads pcapng from the other end. The request travels over
+the :doc:`telemetry <telemetry_lib>` socket; the packets never do.
+
+.. figure:: img/capture_overview.*
+
+   Capture from a DPDK application into Wireshark
+
+The tool is usually ``dpdk-wireshark-extcap``, which makes the ports appear
+as capture interfaces in Wireshark, but any telemetry client will do; see
+:doc:`../howto/telemetry` for the ``dpdk-telemetry.py`` script used in the
+examples below.
+
+Unlike the older pdump library, no secondary process is involved and the
+application needs no source changes and no additional EAL arguments. The
+library registers itself at load time, so capture can be started on an
+application that is already running, including a sealed vendor appliance.
+
+Operation
+---------
+
+When a capture is started the library installs Rx and Tx callbacks on the
+requested queues of the port. Each callback copies matching packets into a
+new mbuf already formatted as a pcapng Enhanced Packet Block
+(``rte_pcapng_copy``) and enqueues it on a ring. A dedicated capture thread
+reads that ring and writes the blocks to the output.
+The receive and transmit callbacks do not block, but the capture
+thread may block. The capture file is set into blocking mode so that if an
+external reader cannot keep up, the capture thread will block writing to FIFO.
+
+The callbacks copy the packet; the original mbuf is not modified and is
+returned to the datapath unchanged. Packets are dropped, and counted,
+if an mbuf cannot be allocated or if the ring is full.
+
+Several captures can be active at once, including on the same port and queue.
+Each has its own id, filter, ring, output and callbacks, and stopping one does
+not disturb the others. Each capture runs its own filter
+and copies the packets that match.
+
+Requirements
+------------
+
+* Capture can only be started in a primary process.
+
+* Filtering requires that DPDK was built with ``libpcap`` available. Without
+  it, a capture that specifies a filter will fail to start.
+
+* The library can be excluded from a build with
+  ``-Ddisable_libs=capture``.
+
+* The callbacks use a memory barrier that the OS applies to every CPU
+  running a thread of the process: ``membarrier()`` on Linux and FreeBSD.
+  It is not built where that is missing, and registers no telemetry
+  commands if the call does not work at startup, so capture is simply
+  unavailable rather than unsafe.
+
+Telemetry commands
+------------------
+
+.. csv-table:: Capture telemetry commands
+   :header: "Command", "Parameters"
+   :widths: 30, 50
+
+   "``/ethdev/capture/start``", "port id and options, see below"
+   "``/ethdev/capture/stop``", "capture id"
+   "``/ethdev/capture/list``", "none"
+   "``/ethdev/capture/stats``", "capture id"
+
+``/ethdev/capture/start`` takes the port id as its first parameter, followed by
+``name=value`` options separated by commas:
+
+``out=<path>``
+   Required. Path of the output, which must already exist and be a FIFO.
+
+``snaplen=<n>``
+   Number of bytes to capture from each packet. Default is 262144;
+   ``snaplen=0`` means capture the whole packet.
+
+``queue=<n>``
+   Capture only this hardware queue. Default is all queues of the port.
+
+``filter=<expression>``
+   A libpcap filter expression, compiled to eBPF and run over each packet.
+
+Because the parameter string is split on commas, neither the output path nor
+the filter expression may contain one.
+
+On success the reply contains the capture ``id``, which is used to stop the
+capture and to query its statistics. On failure the reply contains an
+``error`` string. The whole parameter string is limited to 1024 bytes.
+
+.. note::
+
+   The telemetry commands for capture are experimental
+   and may change without warning in future releases.
+
+Output
+------
+
+The output must be an existing FIFO, otherwise the capture fails to start.
+Only a FIFO is allowed because the application opens the path itself: writing
+to a regular file would let a capture request create or truncate a file with
+the privileges of the application.
+
+The reader must have the FIFO open already, so that the capture thread does
+not block waiting for one.
+
+A capture runs until ``/ethdev/capture/stop`` is called,
+or an error is detected such as when the reader of a FIFO goes away.
+
+Statistics
+----------
+
+``/ethdev/capture/stats`` reports the configuration of a capture and the
+following counters, summed over all queues:
+
+``accepted``
+   Packets copied for capture.
+
+``filtered``
+   Packets rejected by the filter.
+
+``nombuf``
+   Packets missed because no mbuf was available for the copy.
+
+``ringfull``
+   Packets missed because the capture thread was not keeping up.
+
+Some of these are also mapped onto the Interface Statistics Block written at
+the end of the capture: ``ifrecv`` is every packet the callbacks saw and
+``ifdrop`` the ones that were lost. The block does have a field for the count
+accepted by the filter, but ``rte_pcapng_write_stats()`` has no parameter for
+it, so read that from the telemetry counters.
+
+Example
+-------
+
+Normally the capture API is driven by an external capture program, but it can
+be tested using ``dpdk-telemetry.py`` against a running application.
+
+An example, capturing TCP traffic on port 0. Create the FIFO and start a
+reader on it first, for example ``tshark -r /tmp/port0.fifo``, since the
+capture fails to start if the FIFO has no reader::
+
+   --> /ethdev/capture/start,0,out=/tmp/port0.fifo,snaplen=128,filter=tcp
+   {"/ethdev/capture/start": {"id": 0, "status": "running"}}
+
+   --> /ethdev/capture/stats,0
+   {"/ethdev/capture/stats": {"port_id": 0, "filter": "tcp", "running": 1, \
+    "snaplen": 128, "rx_queues": 4, "tx_queues": 4, "accepted": 1200, \
+    "filtered": 87, "nombuf": 0, "ringfull": 0}}
+
+   --> /ethdev/capture/stop,0
+   {"/ethdev/capture/stop": {"status": "stopped"}}
+
+Limitations
+-----------
+
+* Only the primary process can start and stop a capture. Packets handled by a
+  secondary are included, and its counters appear in the statistics, but a
+  secondary started after the capture began is missed until it is restarted.
+
+* Each capture covers a single port. Capturing several ports means starting
+  several captures.
+
+* Captured packets are those seen by the ethdev layer, so packets dropped by
+  the hardware or the driver do not appear.
+
+* Only threads known to EAL are captured: lcores, threads registered with
+  ``rte_thread_register()``, and the interrupt thread. Traffic from a plain
+  application thread that calls the ethdev burst API without registering is
+  not captured, because the read-side protection needs a per-thread slot.
diff --git a/doc/guides/prog_guide/img/capture_overview.svg b/doc/guides/prog_guide/img/capture_overview.svg
new file mode 100644
index 0000000000..a63daaa750
--- /dev/null
+++ b/doc/guides/prog_guide/img/capture_overview.svg
@@ -0,0 +1,49 @@
+<svg xmlns="http://www.w3.org/2000/svg" width="960" height="400" viewBox="0 0 960 400">
+  <title>DPDK extcap</title>
+  <rect width="960" height="400" fill="#FFFFFF"/>
+  <path d="M 40,120 L 40,48 Q 40,40 48,40 L 312,40 Q 320,40 320,48 L 320,120 Z" fill="#FFFFFF" stroke="#1B2A41" stroke-width="1.5" stroke-linejoin="round"/>
+  <path d="M 40,120 L 320,120 L 320,292 Q 320,300 312,300 L 48,300 Q 40,300 40,292 Z" fill="#DCE8F7" stroke="#2B5B9E" stroke-width="1.5" stroke-linejoin="round"/>
+  <path d="M 40.0,120.0 L 320.0,120.0" fill="none" stroke="#1B2A41" stroke-width="1.5" stroke-linejoin="round"/>
+  <text x="180.0" y="86.0" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="17" font-weight="600" fill="#1B2A41" text-anchor="middle">Application</text>
+  <text x="54" y="149.6" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="16" font-weight="700" fill="#2B5B9E" text-anchor="start">DPDK</text>
+  <rect x="72" y="256" width="96" height="30" rx="3" fill="#A9C6EC" stroke="#2B5B9E" stroke-width="1.5"/>
+  <text x="120.0" y="275.9" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="14" font-weight="500" fill="#1B2A41" text-anchor="middle">PMD</text>
+  <rect x="40" y="340" width="280" height="40" rx="2" fill="#3D4A5C" stroke="#3D4A5C" stroke-width="1.5"/>
+  <text x="180.0" y="365.6" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="16" font-weight="600" fill="#FFFFFF" text-anchor="middle">NIC hardware</text>
+  <path d="M 120.0,340.0 L 120.0,296.0" fill="none" stroke="#1B2A41" stroke-width="2" stroke-linejoin="round"/>
+  <polygon points="120.0,286.0 125.0,296.0 115.0,296.0" fill="#1B2A41"/>
+  <path d="M 120.0,256.0 L 120.0,130.0" fill="none" stroke="#1B2A41" stroke-width="2" stroke-linejoin="round"/>
+  <polygon points="120.0,120.0 125.0,130.0 115.0,130.0" fill="#1B2A41"/>
+  <line x1="200" y1="128" x2="200" y2="292" stroke="#2B5B9E" stroke-width="1.5" stroke-dasharray="2 5" stroke-linecap="round"/>
+  <rect x="208" y="132" width="96" height="30" rx="3" fill="#A9C6EC" stroke="#2B5B9E" stroke-width="1.5"/>
+  <text x="256.0" y="151.9" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="14" font-weight="500" fill="#1B2A41" text-anchor="middle">telemetry</text>
+  <path d="M 120.0,190.0 L 142.0,190.0" fill="none" stroke="#1B2A41" stroke-width="2" stroke-linejoin="round"/>
+  <polygon points="152.0,190.0 142.0,195.0 142.0,185.0" fill="#1B2A41"/>
+  <rect x="152.0" y="176.0" width="96" height="28" rx="2" fill="#FFFFFF" stroke="#B84A3A" stroke-width="1.5"/>
+  <line x1="168.0" y1="176.0" x2="168.0" y2="204.0" stroke="#E8B3AA" stroke-width="1"/>
+  <line x1="184.0" y1="176.0" x2="184.0" y2="204.0" stroke="#E8B3AA" stroke-width="1"/>
+  <line x1="200.0" y1="176.0" x2="200.0" y2="204.0" stroke="#E8B3AA" stroke-width="1"/>
+  <line x1="216.0" y1="176.0" x2="216.0" y2="204.0" stroke="#E8B3AA" stroke-width="1"/>
+  <line x1="232.0" y1="176.0" x2="232.0" y2="204.0" stroke="#E8B3AA" stroke-width="1"/>
+  <rect x="187.0" y="180.0" width="10.0" height="20" rx="1.5" fill="#F07F6E"/>
+  <rect x="203.0" y="180.0" width="10.0" height="20" rx="1.5" fill="#F07F6E"/>
+  <rect x="219.0" y="180.0" width="10.0" height="20" rx="1.5" fill="#F07F6E"/>
+  <rect x="235.0" y="180.0" width="10.0" height="20" rx="1.5" fill="#F07F6E"/>
+  <rect x="152.0" y="176.0" width="96" height="28" rx="2" fill="none" stroke="#B84A3A" stroke-width="1.5"/>
+  <circle cx="120" cy="190" r="5.5" fill="#D9503E"/>
+  <path d="M 248.0,190.0 L 326.0,190.0" fill="none" stroke="#1B2A41" stroke-width="2" stroke-linejoin="round"/>
+  <polygon points="336.0,190.0 326.0,195.0 326.0,185.0" fill="#1B2A41"/>
+  <path d="M 343,177.0 L 419,177.0 A 7,13.0 0 0 1 419,203.0 L 343,203.0 A 7,13.0 0 0 1 343,177.0 Z" fill="#EEF0F3" stroke="#6B7383" stroke-width="1.5" stroke-linejoin="round"/>
+  <ellipse cx="343" cy="190" rx="7" ry="13.0" fill="#D5D9E0" stroke="#6B7383" stroke-width="1.5"/>
+  <text x="381.0" y="225.9" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="14" font-weight="400" fill="#6B7383" text-anchor="middle">pipe</text>
+  <rect x="660" y="170" width="160" height="80" rx="8" fill="#DDF1E8" stroke="#2E7D5B" stroke-width="1.5"/>
+  <text x="740.0" y="215.9" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="17" font-weight="600" fill="#1B2A41" text-anchor="middle">Wireshark</text>
+  <path d="M 426.0,190.0 L 650.0,190.0" fill="none" stroke="#1B2A41" stroke-width="2" stroke-linejoin="round"/>
+  <polygon points="660.0,190.0 650.0,195.0 650.0,185.0" fill="#1B2A41"/>
+  <rect x="460" y="122" width="160" height="50" rx="8" fill="#DDF1E8" stroke="#2E7D5B" stroke-width="1.5"/>
+  <text x="540.0" y="152.6" font-family="'Source Sans 3','Source Sans Pro','Segoe UI','Helvetica Neue',Arial,sans-serif" font-size="16" font-weight="600" fill="#1B2A41" text-anchor="middle">DPDK extcap</text>
+  <path d="M 460.0,147.0 L 314.0,147.0" fill="none" stroke="#6B7383" stroke-width="1.75" stroke-dasharray="6 4" stroke-linejoin="round"/>
+  <polygon points="304.0,147.0 314.0,142.0 314.0,152.0" fill="#6B7383"/>
+  <path d="M 740.0,170.0 L 740.0,147.0 L 630.0,147.0" fill="none" stroke="#6B7383" stroke-width="1.75" stroke-dasharray="6 4" stroke-linejoin="round"/>
+  <polygon points="620.0,147.0 630.0,142.0 630.0,152.0" fill="#6B7383"/>
+</svg>
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index b9c0d59728..7e869db132 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -129,6 +129,7 @@ Utility Libraries
     log_lib
     metrics_lib
     telemetry_lib
+    capture_lib
     pdump_lib
     pcapng_lib
     bpf_lib
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..0a43628aed 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -264,6 +264,10 @@ New Features
   Added ``dpdk-validate-bpf`` tool to pre-validate eBPF programs
   for compatibility with the ``lib/bpf`` execution context.
 
+* **Added wireshark capture support.**
+
+  * New ``capture`` library for packet capture accessed via telemetry API.
+
 
 Removed Items
 -------------
diff --git a/lib/capture/capture.c b/lib/capture/capture.c
new file mode 100644
index 0000000000..62b95c9de4
--- /dev/null
+++ b/lib/capture/capture.c
@@ -0,0 +1,656 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Control plane for capture.
+ *
+ * There is no C API; the telemetry socket is the only way in. The library
+ * registers /ethdev/capture/{start,stop,list,stats} from a constructor, so
+ * capture can be turned on in an application that was built without knowing
+ * about it and is already running.
+ *
+ * The telemetry thread calls on these actions, but since it is a shared control
+ * thread, these actions must not block for long. Each action gets a single reply.
+ *
+ * Streaming packets is done for a new thread which reads from ring and
+ * writes into the FIFO file that the caller has already setup.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memory.h>
+#include <rte_mempool.h>
+#include <rte_mbuf.h>
+#include <rte_pcapng.h>
+#include <rte_pause.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_string_fns.h>
+#include <rte_telemetry.h>
+#include <rte_thread.h>
+#include <rte_version.h>
+
+#include "private.h"
+#include "rcu.h"
+
+#define CAPTURE_EXTCAP_PREFIX	"dpdk"
+#define CAP_CMD_MAX		1024
+#define DEFAULT_SNAPLEN		262144u	/* from tcpdump et.al. */
+#define MBUF_POOL_CACHE_SIZE	32
+#define CAPTURE_RING_SIZE	256
+#define CAPTURE_POOL_SIZE	1024
+#define SLEEP_THRESHOLD		100
+#define SLEEP_US		100
+
+RTE_LOG_REGISTER_DEFAULT(rte_capture_logtype, NOTICE);
+
+/*
+ * Captures created by this process. A secondary gets the capture pointer in
+ * the IPC request, so no shared tailq is needed.
+ */
+static struct capture_list capture_list = TAILQ_HEAD_INITIALIZER(capture_list);
+rte_spinlock_t capture_lock = RTE_SPINLOCK_INITIALIZER;
+
+/* Parameter values: only used on stack inside parsing */
+struct capture_config {
+	uint16_t port_id;
+	uint16_t queue;
+	uint32_t snaplen;
+	const char *filter_str;
+	const char *output;
+};
+
+/* Helper that returns error to telemetry and logs it */
+static void __rte_format_printf(2, 3)
+capture_err(struct rte_tel_data *d, const char *format, ...)
+{
+	va_list ap;
+	char msg[1024];
+
+	va_start(ap, format);
+	vsnprintf(msg, sizeof(msg), format, ap);
+	va_end(ap);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "error", msg);
+
+	CAPTURE_LOG(NOTICE, "%s", msg);
+}
+
+static int
+parse_uint32(const char *str, uint32_t *result, uint32_t limit)
+{
+	unsigned long val;
+	char *endp;
+
+	errno = 0;
+	val = strtoul(str, &endp, 10);
+	if (errno != 0 || *endp != '\0' || val >= limit)
+		return -1;
+
+	*result = val;
+	return 0;
+}
+
+/*
+ * Break the comma separated parameter string into tokens
+ * and fill in the capture config structure.
+ *
+ * Does not use rte_kvargs because that would mangle [] etc in filter expression.
+ */
+static int
+parse_params(char *str, struct capture_config *cfg, struct rte_tel_data *d)
+{
+	uint32_t snaplen = DEFAULT_SNAPLEN;
+	char *args[8];
+	int nargs;
+
+	/* Need at least the port id */
+	nargs = rte_strsplit(str, strlen(str), args, RTE_DIM(args), ',');
+	if (nargs < 1) {
+		capture_err(d, "missing parameters '%s'", str);
+		return -1;
+	}
+
+	/* Parse port id (required) */
+	uint32_t port_id;
+	if (parse_uint32(args[0], &port_id, RTE_MAX_ETHPORTS) < 0) {
+		capture_err(d, "invalid port_id='%s'", args[0]);
+		return -1;
+	}
+
+	/* parse remainder as name=value parameters */
+	for (int i = 1; i < nargs; i++) {
+		char *key = args[i];
+
+		/* split at the = */
+		char *eq = strchr(args[i], '=');
+
+		/* all current options require argument after = */
+		if (eq == NULL || eq[1] == '\0') {
+			capture_err(d,  "missing value for '%s'", key);
+			return -1;
+		}
+		*eq = '\0';
+		char *value = eq + 1;
+
+		if (strcmp(key, "out") == 0) {
+			cfg->output = value;
+		} else if (strcmp(key, "filter") == 0) {
+			cfg->filter_str = value;
+		} else if (strcmp(key, "queue") == 0) {
+			uint32_t q;
+
+			if (parse_uint32(value, &q, RTE_MAX_QUEUES_PER_PORT) < 0) {
+				capture_err(d, "invalid queue '%s'", value);
+				return -1;
+			}
+			cfg->queue = q;
+		} else if (strcmp(key, "snaplen") == 0) {
+			if (parse_uint32(value, &snaplen, UINT32_MAX) < 0) {
+				capture_err(d, "invalid snaplen '%s'", value);
+				return -1;
+			}
+		} else {
+			capture_err(d, "unknown parameter '%s'", key);
+			return -1;
+		}
+	}
+
+	if (cfg->output == NULL) {
+		capture_err(d, "missing output parameter");
+		return -1;
+	}
+
+	cfg->port_id = port_id;
+
+	/*
+	 * Default is 256K from tcpdump legacy
+	 * using snaplen=0 means everything.
+	 */
+	cfg->snaplen = snaplen > 0 ? snaplen : UINT32_MAX;
+	return 0;
+}
+
+
+bool
+capture_unlink(struct capture *cap)
+{
+	bool joining;
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_REMOVE(&capture_list, cap, next);
+	joining = cap->joining;
+	rte_spinlock_unlock(&capture_lock);
+
+	return joining;
+}
+
+void
+capture_free(struct capture *cap)
+{
+	if (cap == NULL)
+		return;
+
+	free(cap->output);
+	capture_filter_free(cap->filter);
+	rte_ring_free(cap->ring);
+	rte_mempool_free(cap->mp);
+	rte_free(cap);
+}
+
+/* Generate unique id for naming and telemetry */
+static unsigned int
+get_unique_id(void)
+{
+	static RTE_ATOMIC(unsigned int) capture_instance;
+
+	return rte_atomic_fetch_add_explicit(&capture_instance, 1, rte_memory_order_relaxed);
+}
+
+/*
+ * Convert configuration into running state
+ */
+static struct capture *
+capture_alloc(const struct capture_config *cfg,
+	      const struct rte_eth_dev_info *dev_info,
+	      struct rte_tel_data *d)
+{
+	struct capture *cap;
+	char ring_name[RTE_RING_NAMESIZE];
+	uint16_t mbuf_size;
+
+	/* try and put capture data struct on same node as device. */
+	int socket_id = rte_eth_dev_socket_id(cfg->port_id);
+	if (socket_id < 0)
+		socket_id = SOCKET_ID_ANY;
+
+	uint16_t num_queues = dev_info->nb_tx_queues + dev_info->nb_rx_queues;
+	size_t cb_size = sizeof(*cap) + num_queues * sizeof(cap->cbs[0]);
+	cap = rte_zmalloc_socket("capture", cb_size, RTE_CACHE_LINE_SIZE, socket_id);
+	if (cap == NULL) {
+		capture_err(d, "Could not allocate capture struct");
+		goto error;
+	}
+
+	rte_spinlock_init(&cap->cbs_lock);
+	TAILQ_INIT(&cap->attached);
+
+	cap->idx = get_unique_id();
+	snprintf(ring_name, sizeof(ring_name), "capture-%u", cap->idx);
+	cap->ring = rte_ring_create(ring_name, CAPTURE_RING_SIZE, socket_id, 0);
+	if (cap->ring == NULL) {
+		capture_err(d, "Could not create ring");
+		goto error;
+	}
+
+	/*
+	 * If snapshot length is smaller than one mbuf segment then pool
+	 * element size can be reduced; otherwise can just use the default
+	 * and rte_pktmbuf_copy handle multiple segments.
+	 */
+	if (cfg->snaplen < RTE_MBUF_DEFAULT_BUF_SIZE)
+		mbuf_size = rte_pcapng_mbuf_size(cfg->snaplen);
+	else
+		mbuf_size = RTE_MBUF_DEFAULT_BUF_SIZE;
+
+	cap->mp = rte_pktmbuf_pool_create_by_ops(ring_name, CAPTURE_POOL_SIZE,
+						 MBUF_POOL_CACHE_SIZE, 0, mbuf_size,
+						 socket_id, "ring_mp_mc");
+	if (cap->mp == NULL) {
+		capture_err(d,  "Could not create mempool");
+		goto error;
+	}
+
+	if (cfg->filter_str) {
+		cap->filter = capture_filter_create(cfg->filter_str);
+		if (cap->filter == NULL) {
+			capture_err(d,  "Could not compile filter: %s", cfg->filter_str);
+			goto error;
+		}
+	}
+
+	cap->port_id = cfg->port_id;
+	cap->output = strdup(cfg->output);
+	if (cap->output == NULL) {
+		capture_err(d, "Could not strdup '%s'", cfg->output);
+		goto error;
+	}
+	rte_atomic_store_explicit(&cap->running, true, rte_memory_order_relaxed);
+	cap->snaplen = cfg->snaplen;
+	cap->queue = cfg->queue;
+	cap->socket_id = socket_id;
+	cap->tx_queues = dev_info->nb_tx_queues;
+	cap->rx_queues = dev_info->nb_rx_queues;
+
+	return cap;
+
+error:
+	capture_free(cap);
+	return NULL;
+}
+
+/*
+ * A port is being released, by close or by hotplug remove. The capture thread
+ * holds the capture, the ring and the mempool, all of which the application
+ * is about to unmap, so it has to be finished before this returns.
+ */
+static int
+capture_port_destroy(uint16_t port_id, enum rte_eth_event_type event __rte_unused,
+		     void *cb_arg __rte_unused, void *ret_param __rte_unused)
+{
+	/*
+	 * Claim the captures of this port in batches and tell each batch to stop
+	 * under one lock, so their flushes overlap. The threads free themselves,
+	 * so the ids have to be taken here, and the join has to be outside the
+	 * lock because the threads need it to unlink.
+	 */
+	for (;;) {
+		rte_thread_t tids[CAPTURE_STOP_BATCH];
+		struct capture *cap;
+		unsigned int n = 0;
+
+		rte_spinlock_lock(&capture_lock);
+		TAILQ_FOREACH(cap, &capture_list, next) {
+			if (cap->port_id != port_id || cap->joining)
+				continue;
+
+			CAPTURE_LOG(NOTICE, "port %u released, stopping capture %u",
+				    port_id, cap->idx);
+			cap->joining = true;
+			tids[n++] = cap->tid;
+			rte_atomic_store_explicit(&cap->running, false,
+						  rte_memory_order_relaxed);
+			if (n == RTE_DIM(tids))
+				break;
+		}
+		rte_spinlock_unlock(&capture_lock);
+
+		if (n == 0)
+			return 0;
+
+		for (unsigned int i = 0; i < n; i++)
+			rte_thread_join(tids[i], NULL);
+	}
+}
+
+/*
+ * Callback handler for telemetry library to start capture.
+ *
+ * Need to handle: <iface>,snaplen=<n>,filter=<str>
+ */
+static int
+capture_start_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	struct capture *cap = NULL;
+	struct capture_config cfg = { .queue = ALL_QUEUES };
+	struct rte_eth_dev_info dev_info;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry: %s %s", cmd, params);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		CAPTURE_LOG(ERR, "capture can only be started from primary");
+		return -1;
+	}
+
+	/* Note: params is const so need non-const copy for parsing
+	 * Alternative would be to change telemetry to allow this.
+	 */
+	char tmp[CAP_CMD_MAX];
+	if (strlcpy(tmp, params, CAP_CMD_MAX) >= CAP_CMD_MAX) {
+		CAPTURE_LOG(ERR, "params too long");
+		return -1;
+	}
+
+	if (parse_params(tmp, &cfg, d) < 0)
+		return 0;
+
+	/* Lookup number of queues etc, also validates port_id */
+	if (rte_eth_dev_info_get(cfg.port_id, &dev_info) < 0) {
+		capture_err(d, "can not get info for port %u", cfg.port_id);
+		return 0;
+	}
+
+	if (cfg.queue != ALL_QUEUES &&
+	    cfg.queue >= RTE_MAX(dev_info.nb_rx_queues, dev_info.nb_tx_queues)) {
+		capture_err(d, "queue %d out of range", cfg.queue);
+		return 0;
+	}
+
+	struct stat sb;
+	if (lstat(cfg.output, &sb) < 0) {
+		capture_err(d, "output %s:%s", cfg.output, strerror(errno));
+		return 0;
+	}
+
+	if (!is_fifo(&sb)) {
+		capture_err(d, "output %s is not empty", cfg.output);
+		return 0;
+	}
+
+	cap = capture_alloc(&cfg, &dev_info, d);
+	if (cap == NULL)
+		return 0;
+
+	/*
+	 * Capture must stop before the port goes away. Registering here rather
+	 * than from the constructor because this allocates, which needs EAL to
+	 * be up; it is idempotent, so repeating it on every start is harmless.
+	 */
+	if (rte_eth_dev_callback_register(RTE_ETH_ALL, RTE_ETH_EVENT_DESTROY,
+					  capture_port_destroy, NULL) != 0) {
+		capture_err(d, "can not register for port destroy events");
+		goto error_free;
+	}
+
+	if (capture_add_callbacks(cap) < 0) {
+		capture_err(d, "can not register callbacks");
+		goto error_callback_remove;
+	}
+
+	/*
+	 * Have the secondaries attach to their own queues. A secondary that
+	 * cannot is reported but does not fail the capture: what this process
+	 * sees is still captured.
+	 */
+	if (capture_mp_broadcast(cap, CAPTURE_MP_START) < 0)
+		CAPTURE_LOG(NOTICE, "capture %u: not all secondaries attached", cap->idx);
+
+	/*
+	 * Make a new thread to do the capture work.
+	 * Thread will inherit affinity from the telemetry handler that calls us.
+	 *
+	 * Created before the capture is published so that a stop or a port
+	 * release cannot find it and copy a thread id that does not exist yet.
+	 * Nothing joins an unpublished capture, so a failure here just frees it.
+	 */
+	uint32_t idx = cap->idx;
+	rte_thread_t tid;
+	int ret = rte_thread_create(&tid, NULL, capture_thread, cap);
+	if (ret != 0) {
+		capture_err(d, "thread start failed: %s", strerror(ret));
+		goto error_secondary_stop;
+	}
+
+	/*
+	 * Publish. The id is stored before linked so that any id a joiner
+	 * copies is real, and the thread waits for linked before it can reach
+	 * its exit path and try to unlink itself.
+	 */
+	rte_spinlock_lock(&capture_lock);
+	cap->tid = tid;
+	TAILQ_INSERT_TAIL(&capture_list, cap, next);
+	rte_atomic_store_explicit(&cap->linked, true, rte_memory_order_release);
+	rte_spinlock_unlock(&capture_lock);
+
+	/* Return id back for later use. */
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "id", idx);
+	rte_tel_data_add_dict_string(d, "status", "running");
+	return 0;
+
+error_secondary_stop:
+	/* the capture thread never ran, so detach the secondaries here */
+	if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0) {
+		CAPTURE_LOG(ERR,
+			    "capture %u: secondary still attached, leaking ring and pool",
+			    cap->idx);
+		capture_remove_callbacks(cap);
+		return 0;
+	}
+error_callback_remove:
+	capture_remove_callbacks(cap);
+error_free:
+	capture_free(cap);
+
+	/* return 0 since error reported "error":"XXX" in response */
+	return 0;
+}
+
+/* Telemetry: stop active capture. */
+static int
+capture_stop_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	uint32_t idx;
+	if (parse_uint32(params, &idx, UINT32_MAX) < 0) {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	rte_spinlock_lock(&capture_lock);
+	struct capture *cap;
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		CAPTURE_LOG(DEBUG, "capture index %" PRIu32 " not found", idx);
+		return 0;
+	}
+
+	/* a port release got here first and is already waiting on the thread */
+	if (cap->joining) {
+		rte_spinlock_unlock(&capture_lock);
+		rte_tel_data_start_dict(d);
+		rte_tel_data_add_dict_string(d, "status", "stopping");
+		return 0;
+	}
+
+	/*
+	 * Mark the thread as being waited for and take its id before letting
+	 * it run down: it frees the capture, so cap is gone once it exits.
+	 */
+	cap->joining = true;
+	rte_thread_t tid = cap->tid;
+
+	rte_atomic_store_explicit(&cap->running, false, rte_memory_order_relaxed);
+	rte_spinlock_unlock(&capture_lock);
+
+	/* Blocks until the output is flushed, which needs the reader running. */
+	rte_thread_join(tid, NULL);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "status", "stopped");
+	return 0;
+}
+
+/* Telemetry: list the ids of all active captures. */
+static int
+capture_list_req(const char *cmd __rte_unused, const char *params __rte_unused,
+		 struct rte_tel_data *d)
+{
+	struct capture *cap;
+
+	CAPTURE_LOG(DEBUG, "telemetry %s", cmd);
+	rte_tel_data_start_array(d, RTE_TEL_UINT_VAL);
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next)
+		rte_tel_data_add_array_uint(d, cap->idx);
+	rte_spinlock_unlock(&capture_lock);
+
+	return 0;
+}
+
+
+/* Telemetry: report configuration and counters for one capture. */
+static int
+capture_stats_req(const char *cmd, const char *params,
+		  struct rte_tel_data *d)
+{
+	struct capture *cap;
+	struct capture_total t;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	uint32_t idx;
+	if (parse_uint32(params, &idx, UINT32_MAX) < 0) {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	/* Find the instance and snapshot what we need while holding the lock. */
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		capture_err(d, "capture index %" PRIu32 " not found", idx);
+		return 0;
+	}
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "port_id", cap->port_id);
+	if (cap->filter)
+		rte_tel_data_add_dict_string(d, "filter",
+					     capture_filter_string(cap->filter));
+	rte_tel_data_add_dict_int(d, "running",
+				  rte_atomic_load_explicit(&cap->running,
+							   rte_memory_order_relaxed));
+	rte_tel_data_add_dict_uint(d, "snaplen", cap->snaplen);
+	rte_tel_data_add_dict_uint(d, "rx_queues", cap->rx_queues);
+	rte_tel_data_add_dict_uint(d, "tx_queues", cap->tx_queues);
+	/* cbs_lock nests inside capture_lock, never the other way round */
+	rte_spinlock_lock(&cap->cbs_lock);
+	capture_sum_stats(cap, &t);
+	rte_spinlock_unlock(&cap->cbs_lock);
+	rte_spinlock_unlock(&capture_lock);
+
+	rte_tel_data_add_dict_uint(d, "accepted", t.accepted);
+	rte_tel_data_add_dict_uint(d, "filtered", t.filtered);
+	rte_tel_data_add_dict_uint(d, "nombuf", t.nombuf);
+	rte_tel_data_add_dict_uint(d, "ringfull", t.ringfull);
+
+	return 0;
+}
+
+RTE_INIT(capture_telemetry)
+{
+	/*
+	 * The callbacks need an OS barrier for their grace period. Without one
+	 * nothing is registered, and since this library is only ever entered
+	 * through telemetry or the IPC handler, none of it can run.
+	 */
+	if (!capture_rcu_init()) {
+		CAPTURE_LOG(NOTICE, "no membarrier support, capture disabled");
+		return;
+	}
+
+	capture_mp_register();
+
+	rte_telemetry_register_cmd("/ethdev/capture/list", capture_list_req,
+		"List ids of active captures. Takes no parameters.");
+	rte_telemetry_register_cmd("/ethdev/capture/stats", capture_stats_req,
+		"Report configuration and counters for a capture. Parameters: id");
+	rte_telemetry_register_cmd("/ethdev/capture/start", capture_start_req,
+		"Start capture. Parameters: "
+		"port_id,out=<fifo>,snaplen=N(optional),queue=N(optional),filter=string(optional)");
+	rte_telemetry_register_cmd("/ethdev/capture/stop", capture_stop_req,
+				   "Stop an active capture. Parameters: id");
+}
diff --git a/lib/capture/datapath.c b/lib/capture/datapath.c
new file mode 100644
index 0000000000..7f6c7c911d
--- /dev/null
+++ b/lib/capture/datapath.c
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Datapath side of capture: the ethdev callbacks that copy packets into the
+ * ring, and the callback blocks they run on.
+ *
+ * Callback lifetime is the awkward part. rte_eth_remove_rx_callback() only
+ * unlinks the callback from the port's list; a datapath thread that already
+ * loaded the list walks into the callback afterwards, and ethdev gives no
+ * point at which that can no longer happen. There are therefore two separate
+ * lifetimes to manage, and conflating them is the easy mistake:
+ *
+ * The block (struct capture_rxtx_cb) is what the late thread lands in, so it
+ * is never freed. Blocks are kept on a free list and handed out again, but
+ * only to a later capture of the same port, queue and direction, which bounds
+ * the pool at the peak number of concurrent captures of one queue. A thread
+ * arriving late can then only ever be handed a capture that covers the
+ * packets it is already carrying.
+ *
+ * The capture is freed, so a block points at it through cbs->cap and detach
+ * clears that pointer and waits a grace period (rcu.c) before anything is
+ * released. After the wait no callback can still be holding the old pointer,
+ * and one that starts later loads NULL and returns.
+ *
+ * The rte_eth_rxtx_callback object that ethdev itself allocated cannot be
+ * freed at removal time for the same reason, so it is parked in cbs->stale
+ * and released by the next capture that picks up the block. A whole capture
+ * session passes in between, which is far longer than any burst.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/queue.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pcapng.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+
+#include "private.h"
+#include "rcu.h"
+
+/* Unowned capture blocks */
+static struct capture_cb_list capture_cb_freelist = TAILQ_HEAD_INITIALIZER(capture_cb_freelist);
+
+/*
+ * Create a clone of mbuf to be placed into ring.
+ * Note: for case of lockfree transmit statistics may not be correct due to races.
+ */
+static inline void
+capture_copy_burst(uint16_t port_id, uint16_t queue_id,
+		   enum rte_pcapng_direction direction,
+		   struct rte_mbuf **pkts, unsigned int nb_pkts,
+		   const struct capture *cap,
+		   const struct capture_filter_prog *prog,
+		   struct capture_stats *stats)
+{
+	unsigned int i, ring_enq, d_pkts = 0;
+	struct rte_mbuf *dup_bufs[CAPTURE_BURST_SIZE]; /* duplicated packets */
+	struct rte_ring *ring = cap->ring;
+	struct rte_mempool *mp = cap->mp;
+	uint32_t snaplen = cap->snaplen;
+	struct rte_mbuf *p;
+
+	RTE_ASSERT(nb_pkts <= CAPTURE_BURST_SIZE);
+
+	for (i = 0; i < nb_pkts; i++) {
+		/*
+		 * This uses same BPF return value convention as socket filter
+		 * and pcap_offline_filter. If program returns zero then packet
+		 * doesn't match the filter (will be ignored).
+		 */
+		if (prog != NULL) {
+			if (capture_filter_exec(prog, pkts[i]) == 0) {
+				stats->filtered++;
+				continue;
+			}
+		}
+
+		p = rte_pcapng_copy(port_id, queue_id, pkts[i], mp, snaplen, direction, NULL);
+		if (unlikely(p == NULL))
+			stats->nombuf++;
+		else
+			dup_bufs[d_pkts++] = p;
+	}
+
+	if (d_pkts == 0)
+		return;
+
+	stats->accepted += d_pkts;
+
+	ring_enq = rte_ring_enqueue_burst(ring, (void *)&dup_bufs[0], d_pkts, NULL);
+	if (unlikely(ring_enq < d_pkts)) {
+		unsigned int drops = d_pkts - ring_enq;
+
+		stats->ringfull += drops;
+		rte_pktmbuf_free_bulk(&dup_bufs[ring_enq], drops);
+	}
+}
+
+/* Create a clone of mbuf to be placed into ring. */
+static inline void
+capture_copy(uint16_t port_id, uint16_t queue_id,
+	     enum rte_pcapng_direction direction,
+	     struct rte_mbuf **pkts, uint16_t nb_pkts,
+	     const struct capture *cap,
+	     const struct capture_filter_prog *prog,
+	     struct capture_stats *stats)
+{
+	unsigned int offs = 0;
+
+	do {
+		unsigned int n = RTE_MIN(nb_pkts - offs, CAPTURE_BURST_SIZE);
+
+		capture_copy_burst(port_id, queue_id, direction, &pkts[offs], n,
+				   cap, prog, stats);
+		offs += n;
+	} while (offs < nb_pkts);
+}
+
+/*
+ * The block itself is never freed, so it is safe to reach even after the
+ * ethdev callback was unlinked. What the read section protects is cap and
+ * the program: both are cleared before capture_rcu_sync() in detach, and a
+ * reader that sees them non-NULL holds the section until it is done.
+ */
+static uint16_t
+capture_rx(uint16_t port, uint16_t queue,
+	struct rte_mbuf **pkts, uint16_t nb_pkts,
+	uint16_t max_pkts __rte_unused, void *user_params)
+{
+	struct capture_rxtx_cb *cbs = user_params;
+	unsigned int slot = capture_rcu_slot();
+	const struct capture *cap;
+
+	if (unlikely(slot == CAPTURE_RCU_NO_SLOT))
+		return nb_pkts;
+
+	capture_rcu_enter(slot);
+	cap = rte_atomic_load_explicit(&cbs->cap, rte_memory_order_relaxed);
+	if (likely(cap != NULL))
+		capture_copy(port, queue, RTE_PCAPNG_DIRECTION_IN,
+			     pkts, nb_pkts, cap, cbs->prog, &cbs->stats);
+	capture_rcu_exit(slot);
+
+	return nb_pkts;
+}
+
+static uint16_t
+capture_tx(uint16_t port, uint16_t queue,
+	   struct rte_mbuf **pkts, uint16_t nb_pkts, void *user_params)
+{
+	struct capture_rxtx_cb *cbs = user_params;
+	unsigned int slot = capture_rcu_slot();
+	const struct capture *cap;
+
+	if (unlikely(slot == CAPTURE_RCU_NO_SLOT))
+		return nb_pkts;
+
+	capture_rcu_enter(slot);
+	cap = rte_atomic_load_explicit(&cbs->cap, rte_memory_order_relaxed);
+	if (likely(cap != NULL))
+		capture_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT,
+			     pkts, nb_pkts, cap, cbs->prog, &cbs->stats);
+	capture_rcu_exit(slot);
+
+	return nb_pkts;
+}
+
+/*
+ * Take an idle block for a port/queue/direction, allocating one if all are in
+ * use. Several captures may cover a queue, each with its own filter and
+ * callback, so this hands out one block per capture.
+ */
+static struct capture_rxtx_cb *
+capture_cb_get(struct capture *cap, uint16_t queue, bool is_rx)
+{
+	struct capture_rxtx_cb *cbs;
+
+	rte_spinlock_lock(&capture_lock);
+
+	TAILQ_FOREACH(cbs, &capture_cb_freelist, next) {
+		if (cbs->port_id == cap->port_id && cbs->queue == queue &&
+		    cbs->is_rx == is_rx) {
+			TAILQ_REMOVE(&capture_cb_freelist, cbs, next);
+			break;
+		}
+	}
+
+	rte_spinlock_unlock(&capture_lock);
+
+	if (cbs == NULL) {
+		cbs = rte_zmalloc_socket("capture_cb", sizeof(*cbs),
+					 RTE_CACHE_LINE_SIZE, cap->socket_id);
+		if (cbs == NULL)
+			return NULL;
+		cbs->port_id = cap->port_id;
+		cbs->queue = queue;
+		cbs->is_rx = is_rx;
+	}
+
+	return cbs;
+}
+
+/* Hand a detached block back for reuse. */
+static void
+capture_cb_put(struct capture_rxtx_cb *cbs)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_cb_freelist, cbs, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+/* Install one callback; also links the block into cap->attached for stats. */
+static struct capture_rxtx_cb *
+capture_attach(struct capture *cap, uint16_t queue, bool is_rx,
+	       struct capture_filter_prog *prog)
+{
+	struct capture_rxtx_cb *cbs;
+
+	cbs = capture_cb_get(cap, queue, is_rx);
+	if (cbs == NULL) {
+		CAPTURE_LOG(ERR, "No callback block for %u:%u %s",
+			    cap->port_id, queue, is_rx ? "rx" : "tx");
+		return NULL;
+	}
+
+	/* the block may have been used by an earlier capture of this queue */
+	memset(&cbs->stats, 0, sizeof(cbs->stats));
+
+	/* one program per process per capture, shared by its queues */
+	cbs->prog = prog;
+
+	/*
+	 * Release the object left by an earlier capture. It cannot be freed at
+	 * removal time because ethdev reads cb->next after the callback
+	 * returns; deferring to the next attach puts a whole session between.
+	 */
+	rte_free((void *)(uintptr_t)cbs->stale);
+	cbs->stale = NULL;
+
+	/* publish before the callback can be reached by the datapath */
+	rte_atomic_store_explicit(&cbs->cap, cap, rte_memory_order_release);
+
+	if (is_rx)
+		cbs->cb = rte_eth_add_rx_callback(cap->port_id, queue, capture_rx, cbs);
+	else
+		cbs->cb = rte_eth_add_tx_callback(cap->port_id, queue, capture_tx, cbs);
+
+	if (cbs->cb == NULL) {
+		rte_atomic_store_explicit(&cbs->cap, NULL, rte_memory_order_relaxed);
+		capture_cb_put(cbs);
+		CAPTURE_LOG(ERR, "Register %s callback for %u:%u failed",
+			    is_rx ? "rx" : "tx", cap->port_id, queue);
+		return NULL;
+	}
+
+	rte_spinlock_lock(&cap->cbs_lock);
+	TAILQ_INSERT_TAIL(&cap->attached, cbs, attached);
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	return cbs;
+}
+
+/*
+ * Install callbacks on every queue this capture covers, recording them in
+ * cbs[] for detach. A secondary passes its own array.
+ *
+ * The filter program is per-process, so it is loaded here and returned in
+ * *progp; the caller passes it to capture_detach_queues() to release.
+ */
+int
+capture_attach_queues(struct capture *cap, struct capture_rxtx_cb **cbs, uint16_t *nb_cbs,
+		      struct capture_filter_prog **progp)
+{
+	struct capture_filter_prog *prog = NULL;
+
+	if (cap->filter != NULL) {
+		prog = capture_filter_load(cap->filter);
+		if (prog == NULL) {
+			/*
+			 * Attaching without the filter would put unwanted
+			 * packets in the capture file, so do not attach.
+			 */
+			CAPTURE_LOG(ERR, "Could not load filter for port %u",
+				    cap->port_id);
+			return -1;
+		}
+	}
+	*progp = prog;
+
+	for (uint16_t q = 0; q < cap->tx_queues; q++) {
+		if (cap->queue != ALL_QUEUES && cap->queue != q)
+			continue;
+
+		cbs[*nb_cbs] = capture_attach(cap, q, false, prog);
+		if (cbs[*nb_cbs] == NULL)
+			return -1;
+		++*nb_cbs;
+	}
+
+	for (uint16_t q = 0; q < cap->rx_queues; q++) {
+		if (cap->queue != ALL_QUEUES && cap->queue != q)
+			continue;
+
+		cbs[*nb_cbs] = capture_attach(cap, q, true, prog);
+		if (cbs[*nb_cbs] == NULL)
+			return -1;
+		++*nb_cbs;
+	}
+	return 0;
+}
+
+/* Install callbacks of the process that created the capture. */
+int
+capture_add_callbacks(struct capture *cap)
+{
+	return capture_attach_queues(cap, cap->cbs, &cap->nb_cbs, &cap->prog);
+}
+
+static void
+capture_sum_one(struct capture_total *t, const struct capture_stats *s)
+{
+	t->accepted += s->accepted;
+	t->filtered += s->filtered;
+	t->nombuf   += s->nombuf;
+	t->ringfull += s->ringfull;
+}
+
+/*
+ * Sum the counters of the queues still attached, in any process, plus those
+ * already detached. Caller holds cap->cbs_lock.
+ */
+void
+capture_sum_stats(const struct capture *cap, struct capture_total *t)
+{
+	const struct capture_rxtx_cb *cbs;
+
+	*t = cap->total;
+
+	TAILQ_FOREACH(cbs, &cap->attached, attached)
+		capture_sum_one(t, &cbs->stats);
+}
+
+/*
+ * Detach this process's blocks. Once this returns no datapath thread here can
+ * reach the capture.
+ */
+void
+capture_detach_queues(struct capture *cap, struct capture_rxtx_cb **cbs, uint16_t *nb_cbs,
+		      struct capture_filter_prog *prog)
+{
+	for (uint16_t i = 0; i < *nb_cbs; i++) {
+		struct capture_rxtx_cb *cb = cbs[i];
+
+		if (cb->is_rx)
+			rte_eth_remove_rx_callback(cap->port_id, cb->queue, cb->cb);
+		else
+			rte_eth_remove_tx_callback(cap->port_id, cb->queue, cb->cb);
+
+		/* freed by the next capture that attaches to this queue */
+		cb->stale = cb->cb;
+		cb->cb = NULL;
+
+		/* unpublish; a reader that still sees it is waited for below */
+		rte_atomic_store_explicit(&cb->cap, NULL, rte_memory_order_relaxed);
+	}
+
+	/* one grace period covers every queue of this process */
+	capture_rcu_sync();
+
+	for (uint16_t i = 0; i < *nb_cbs; i++)
+		cbs[i]->prog = NULL;
+
+	/*
+	 * The blocks leave the capture, so fold their counters into the total
+	 * first: whoever picks them up next zeroes the stats.
+	 */
+	rte_spinlock_lock(&cap->cbs_lock);
+	for (uint16_t i = 0; i < *nb_cbs; i++) {
+		capture_sum_one(&cap->total, &cbs[i]->stats);
+		TAILQ_REMOVE(&cap->attached, cbs[i], attached);
+	}
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	rte_spinlock_lock(&capture_lock);
+	for (uint16_t i = 0; i < *nb_cbs; i++)
+		TAILQ_INSERT_TAIL(&capture_cb_freelist, cbs[i], next);
+	rte_spinlock_unlock(&capture_lock);
+
+	*nb_cbs = 0;
+
+	/* no datapath thread can reach the program now */
+	capture_filter_unload(prog);
+}
+
+/* Cleanup callbacks of the process that created the capture. */
+void
+capture_remove_callbacks(struct capture *cap)
+{
+	capture_detach_queues(cap, cap->cbs, &cap->nb_cbs, cap->prog);
+	cap->prog = NULL;
+}
diff --git a/lib/capture/filter.c b/lib/capture/filter.c
new file mode 100644
index 0000000000..97ba032848
--- /dev/null
+++ b/lib/capture/filter.c
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <pcap/pcap.h>
+
+#include <rte_bpf.h>
+#include <rte_errno.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_string_fns.h>
+
+#include "private.h"
+
+/*
+ * Compiled filter, split in two because of where rte_bpf puts things.
+ * rte_bpf_convert() returns the eBPF instructions in rte_malloc memory, which
+ * is shared and position independent and references no external symbols.
+ * rte_bpf_load() puts the rte_bpf object in a MAP_PRIVATE mapping and the JIT
+ * output has to be privately executable, so neither can be shared.
+ *
+ * The instructions are compiled once, by whoever starts the capture.
+ */
+struct capture_filter {
+	struct rte_ebpf_insn *ins;	/* eBPF program, shared */
+	uint32_t nb_ins;
+	char expr[];		/* original filter text */
+};
+
+/* Per-process loaded form of the above, not shared. */
+struct capture_filter_prog {
+	struct rte_bpf *bpf;
+	struct rte_bpf_jit jit;
+};
+
+/*
+ * Convert text string into an eBPF program
+ */
+struct capture_filter *
+capture_filter_create(const char *filter)
+{
+	struct rte_bpf_prm *prm = NULL;
+
+	/* libpcap needs a handle */
+	pcap_t *pcap = pcap_open_dead(DLT_EN10MB, UINT16_MAX);
+	if (!pcap) {
+		CAPTURE_LOG(ERR, "pcap: can not open handle");
+		return NULL;
+	}
+
+	size_t filter_len = strlen(filter) + 1;
+	struct capture_filter *flt;
+	flt = rte_zmalloc("capture_filter", sizeof(*flt) + filter_len, 0);
+	if (flt == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate for filter");
+		goto error;
+	}
+
+	/* convert string to cBPF program */
+	struct bpf_program bf;
+	if (pcap_compile(pcap, &bf, filter, 1, PCAP_NETMASK_UNKNOWN) != 0) {
+		CAPTURE_LOG(ERR, "pcap: can not compile filter: %s",
+			    pcap_geterr(pcap));
+		goto error;
+	}
+	strlcpy(flt->expr, filter, filter_len);
+
+	/* convert cBPF to eBPF */
+	prm = rte_bpf_convert(&bf);
+	pcap_freecode(&bf); /* drop the cBPF program */
+
+	if (prm == NULL)  {
+		CAPTURE_LOG(ERR, "BPF convert interface %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		goto error;
+	}
+
+	/*
+	 * Keep the instructions in shared memory. Only the primary has libpcap
+	 * do the compile; every process loads the result from here.
+	 */
+	flt->ins = rte_malloc("capture_filter_ins",
+			      prm->nb_ins * sizeof(*flt->ins), 0);
+	if (flt->ins == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate for filter program");
+		goto error;
+	}
+	memcpy(flt->ins, prm->ins, prm->nb_ins * sizeof(*flt->ins));
+	flt->nb_ins = prm->nb_ins;
+
+	pcap_close(pcap);
+	rte_free(prm);
+	return flt;
+
+error:
+	pcap_close(pcap);
+	rte_free(prm);
+	if (flt != NULL)
+		rte_free(flt->ins);
+	rte_free(flt);
+	return NULL;
+}
+
+/*
+ * Load the shared program into this process. The JIT-ed code and the rte_bpf
+ * object are process private mappings, so each process that runs the filter
+ * needs its own.
+ */
+struct capture_filter_prog *
+capture_filter_load(const struct capture_filter *filter)
+{
+	struct rte_bpf_prm prm = {
+		.ins = filter->ins,
+		.nb_ins = filter->nb_ins,
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR_MBUF,
+			.size = sizeof(struct rte_mbuf),
+		},
+	};
+	struct capture_filter_prog *prog;
+
+	prog = calloc(1, sizeof(*prog));
+	if (prog == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate filter program");
+		return NULL;
+	}
+
+	prog->bpf = rte_bpf_load(&prm);
+	if (prog->bpf == NULL) {
+		CAPTURE_LOG(ERR, "BPF load failed: %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		free(prog);
+		return NULL;
+	}
+
+	rte_bpf_get_jit(prog->bpf, &prog->jit);
+	if (prog->jit.func == NULL)
+		CAPTURE_LOG(NOTICE, "No JIT available for filter");
+
+	return prog;
+}
+
+void
+capture_filter_unload(struct capture_filter_prog *prog)
+{
+	if (prog == NULL)
+		return;
+
+	rte_bpf_destroy(prog->bpf);
+	free(prog);
+}
+
+const char *capture_filter_string(struct capture_filter *filter)
+{
+	return filter ? filter->expr : NULL;
+}
+
+void capture_filter_free(struct capture_filter *filter)
+{
+	if (filter == NULL)
+		return;
+
+	rte_free(filter->ins);
+	rte_free(filter);
+}
+
+uint64_t capture_filter_exec(const struct capture_filter_prog *prog, struct rte_mbuf *mb)
+{
+	if (prog->jit.func)
+		return prog->jit.func(mb);
+	else
+		return rte_bpf_exec(prog->bpf, mb);
+}
diff --git a/lib/capture/meson.build b/lib/capture/meson.build
new file mode 100644
index 0000000000..a8b19890bb
--- /dev/null
+++ b/lib/capture/meson.build
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
+# The RCU used by the receive and transmit callbacks needs the OS to be able
+# to force a barrier on every CPU running a thread of the process.
+# Linux has no libc wrapper, so the syscall number is what matters there;
+# FreeBSD has a real membarrier().
+if is_linux
+    has_membarrier = (cc.has_header_symbol('sys/syscall.h', 'SYS_membarrier')
+            and cc.has_header_symbol('linux/membarrier.h',
+                'MEMBARRIER_CMD_PRIVATE_EXPEDITED'))
+else
+    has_membarrier = cc.has_header_symbol('sys/membarrier.h', 'membarrier')
+endif
+if not has_membarrier
+    build = false
+    reason = 'missing membarrier support'
+    subdir_done()
+endif
+
+sources = files(
+        'capture.c',
+        'datapath.c',
+        'multiproc.c',
+        'output.c',
+        'rcu.c',
+)
+
+deps += ['ethdev', 'pcapng', 'bpf']
+
+if dpdk_conf.has('RTE_HAS_LIBPCAP')
+    sources += files('filter.c')
+    ext_deps += pcap_dep
+else
+    warning('libpcap is missing, capture filtering will be disabled')
+endif
diff --git a/lib/capture/multiproc.c b/lib/capture/multiproc.c
new file mode 100644
index 0000000000..ab29710210
--- /dev/null
+++ b/lib/capture/multiproc.c
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Multi-process support.
+ *
+ * The ethdev callback lists are per-process, so the primary passes the capture
+ * to the other processes over EAL IPC and each attaches to its own queues.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/queue.h>
+
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_spinlock.h>
+#include <rte_string_fns.h>
+
+#include "private.h"
+
+/* IPC endpoint used to tell secondaries to attach/detach their callbacks. */
+#define CAPTURE_MP		"mp_capture"
+#define CAPTURE_MP_VERSION	1
+#define CAPTURE_MP_TIMEOUT_S	1
+
+struct capture_mp_request {
+	uint16_t version;
+	uint16_t op;
+	/*
+	 * Capture in shared memory. Valid in every process because it comes
+	 * from rte_zmalloc; the secondary only reads the datapath fields and
+	 * never the creator's (output, capture thread state).
+	 */
+	struct capture *cap;
+};
+
+struct capture_mp_response {
+	uint16_t version;
+	uint16_t op;
+	int32_t err;
+};
+
+/*
+ * Callbacks this process attached to a capture created elsewhere.
+ *
+ * A secondary cannot record its blocks in cap->cbs[], which is sized for one
+ * process's queues, so it keeps them here. Guarded by capture_lock.
+ */
+struct capture_secondary {
+	TAILQ_ENTRY(capture_secondary) next;
+	struct capture *cap;
+	struct capture_filter_prog *prog;
+	uint16_t nb_cbs;
+	struct capture_rxtx_cb *cbs[];
+};
+
+static TAILQ_HEAD(, capture_secondary) capture_secondary_list =
+	TAILQ_HEAD_INITIALIZER(capture_secondary_list);
+
+/* Attach this process's callbacks to a capture owned by the primary. */
+static int
+capture_mp_attach(struct capture *cap)
+{
+	struct capture_secondary *sec;
+	struct rte_eth_dev_info dev_info;
+	uint16_t num_queues;
+
+	if (rte_eth_dev_info_get(cap->port_id, &dev_info) < 0)
+		return -EINVAL;
+
+	/*
+	 * Queue counts come from this process's view of the device: it is the
+	 * one registering the callbacks.
+	 */
+	num_queues = dev_info.nb_tx_queues + dev_info.nb_rx_queues;
+	sec = calloc(1, sizeof(*sec) + num_queues * sizeof(sec->cbs[0]));
+	if (sec == NULL)
+		return -ENOMEM;
+
+	sec->cap = cap;
+	if (capture_attach_queues(cap, sec->cbs, &sec->nb_cbs, &sec->prog) < 0) {
+		capture_detach_queues(cap, sec->cbs, &sec->nb_cbs, sec->prog);
+		free(sec);
+		return -ENOBUFS;
+	}
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_secondary_list, sec, next);
+	rte_spinlock_unlock(&capture_lock);
+
+	return 0;
+}
+
+/* Detach this process's callbacks from a capture owned by the primary. */
+static int
+capture_mp_detach(struct capture *cap)
+{
+	struct capture_secondary *sec;
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(sec, &capture_secondary_list, next) {
+		if (sec->cap == cap) {
+			TAILQ_REMOVE(&capture_secondary_list, sec, next);
+			break;
+		}
+	}
+	rte_spinlock_unlock(&capture_lock);
+
+	if (sec == NULL)
+		return -ENOENT;
+
+	capture_detach_queues(cap, sec->cbs, &sec->nb_cbs, sec->prog);
+	free(sec);
+	return 0;
+}
+
+/*
+ * Runs on the IPC thread, but attaching sends nothing, so unlike pdump there
+ * is no need to defer to the interrupt thread.
+ */
+static int
+capture_mp_handler(const struct rte_mp_msg *msg, const void *peer)
+{
+	const struct capture_mp_request *req;
+	struct rte_mp_msg reply = { };
+	struct capture_mp_response *resp = (struct capture_mp_response *)reply.param;
+
+	resp->err = -EINVAL;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* the primary sends these and attaches its own callbacks */
+		resp->err = -EPERM;
+	} else if (msg->len_param != sizeof(*req)) {
+		CAPTURE_LOG(ERR, "Invalid capture request length %d", msg->len_param);
+	} else {
+		req = (const struct capture_mp_request *)msg->param;
+
+		if (req->version != CAPTURE_MP_VERSION) {
+			CAPTURE_LOG(ERR, "Unsupported capture request version %u",
+				    req->version);
+		} else {
+			resp->version = req->version;
+			resp->op = req->op;
+
+			switch (req->op) {
+			case CAPTURE_MP_START:
+				resp->err = capture_mp_attach(req->cap);
+				break;
+			case CAPTURE_MP_STOP:
+				resp->err = capture_mp_detach(req->cap);
+				break;
+			default:
+				CAPTURE_LOG(ERR, "Unknown capture op %u", req->op);
+			}
+		}
+	}
+
+	rte_strscpy(reply.name, CAPTURE_MP, sizeof(reply.name));
+	reply.len_param = sizeof(*resp);
+
+	return rte_mp_reply(&reply, peer);
+}
+
+/*
+ * Registered from the constructor so no rte_pdump_init() equivalent is needed.
+ * Only inserts into a list, so it is safe this early.
+ *
+ * The process type is not yet known here (it defaults to primary until EAL
+ * init parses the arguments), so both ends register and the handler rejects
+ * a request that arrives in the sending process.
+ */
+void
+capture_mp_register(void)
+{
+	if (rte_mp_action_register(CAPTURE_MP, capture_mp_handler) < 0 &&
+	    rte_errno != ENOTSUP)
+		CAPTURE_LOG(NOTICE, "Could not register ipc action: %s",
+			    rte_strerror(rte_errno));
+}
+
+/*
+ * Must not be called holding a lock, the reply timeout is in seconds.
+ * On stop the result decides whether the ring can be freed.
+ */
+int
+capture_mp_broadcast(struct capture *cap, enum capture_mp_op op)
+{
+	struct rte_mp_msg msg = { };
+	struct capture_mp_request *req = (struct capture_mp_request *)msg.param;
+	struct rte_mp_reply mp_reply = { };
+	struct timespec ts = { .tv_sec = CAPTURE_MP_TIMEOUT_S };
+	int ret;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	req->version = CAPTURE_MP_VERSION;
+	req->op = op;
+	req->cap = cap;
+
+	rte_strscpy(msg.name, CAPTURE_MP, sizeof(msg.name));
+	msg.len_param = sizeof(*req);
+
+	if (rte_mp_request_sync(&msg, &mp_reply, &ts) != 0) {
+		/* no secondary running at all is the common case */
+		if (rte_errno == ENOTSUP)
+			return 0;
+
+		CAPTURE_LOG(ERR, "Capture %s request failed: %s",
+			    op == CAPTURE_MP_START ? "start" : "stop",
+			    rte_strerror(rte_errno));
+		return -1;
+	}
+
+	ret = 0;
+	for (int i = 0; i < mp_reply.nb_received; i++) {
+		const struct capture_mp_response *resp
+			= (const struct capture_mp_response *)mp_reply.msgs[i].param;
+
+		/*
+		 * A secondary that has no callbacks to detach replies ENOENT,
+		 * which happens whenever it was not polling this port.
+		 */
+		if (resp->err != 0 && resp->err != -ENOENT) {
+			CAPTURE_LOG(ERR, "Secondary could not %s capture: %s",
+				    op == CAPTURE_MP_START ? "start" : "stop",
+				    rte_strerror(-resp->err));
+			ret = -1;
+		}
+	}
+
+	if (mp_reply.nb_received != mp_reply.nb_sent) {
+		CAPTURE_LOG(ERR, "Only %u of %u secondaries replied",
+			    mp_reply.nb_received, mp_reply.nb_sent);
+		ret = -1;
+	}
+
+	free(mp_reply.msgs);
+	return ret;
+}
diff --git a/lib/capture/output.c b/lib/capture/output.c
new file mode 100644
index 0000000000..d6b8adb786
--- /dev/null
+++ b/lib/capture/output.c
@@ -0,0 +1,311 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Output side of capture: opening the pcapng stream, and the per-capture
+ * thread that writes the ring into it.
+ *
+ * The write to the output is what needs its own thread. It blocks when the
+ * reader does not keep up, which a datapath callback cannot afford to do, so
+ * the callbacks only enqueue and this thread does the writing.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_pcapng.h>
+#include <rte_pause.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_thread.h>
+#include <rte_version.h>
+
+#include "private.h"
+
+/*
+ * Create the file handle for pcapng output
+ * Note: can't really tell wireshark about errors since this in an
+ * independent thread.
+ */
+static rte_pcapng_t *
+capture_pcapng_open(const char *path, int *fd, uint16_t port_id, const char *filter)
+{
+	rte_pcapng_t *pcapng = NULL;
+	char port_name[RTE_ETH_NAME_MAX_LEN];
+	char appname[128];
+	char ifname[IFNAMSIZ];
+	char *ifdescr = NULL;
+	struct utsname uts;
+	char *osname = NULL;
+
+	/* OS name is optional, just keep going if not found */
+	if (uname(&uts) == 0 && asprintf(&osname, "%s %s", uts.sysname, uts.release) < 0)
+		osname = NULL;
+
+	/* add DPDK internal name */
+	if (rte_eth_dev_get_name_by_port(port_id, port_name) != 0) {
+		CAPTURE_LOG(NOTICE, "Could not find port name for %u", port_id);
+		goto cleanup;
+	}
+
+	/* match name convention used by dpdk-wireshark-extcap */
+	snprintf(ifname, sizeof(ifname), CAPTURE_EXTCAP_PREFIX ":%u", port_id);
+	if (asprintf(&ifdescr, "DPDK %s", port_name) < 0)
+		ifdescr = NULL;
+
+	/* mirror what other applications do for name */
+	snprintf(appname, sizeof(appname), CAPTURE_EXTCAP_PREFIX " (%s)", rte_version());
+
+	/*
+	 * Open the output in non-block mode in case it is a FIFO without a reader.
+	 * Wireshark must open the read end before asking us to capture.
+	 */
+	*fd = open(path, O_WRONLY | O_CLOEXEC | O_NOFOLLOW | O_NONBLOCK);
+	if (*fd < 0) {
+		CAPTURE_LOG(ERR, "Could not open %s: %s", path, strerror(errno));
+		goto cleanup;
+	}
+
+	/* recheck that it is ok to use */
+	struct stat sb;
+	if (fstat(*fd, &sb) < 0 || !is_fifo(&sb)) {
+		CAPTURE_LOG(ERR, "Not safe to use %s", path);
+		goto close_fd;
+	}
+
+	/* writes from the capture thread should block normally */
+	int flags = fcntl(*fd, F_GETFL, 0);
+	if (flags < 0 || fcntl(*fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		CAPTURE_LOG(ERR, "fcntl %s: %s",  path,  strerror(errno));
+		goto close_fd;
+	}
+
+	/* put pcapng header on and setup */
+	pcapng = rte_pcapng_fdopen(*fd, osname, NULL, appname, NULL);
+	if (pcapng == NULL) {
+		CAPTURE_LOG(ERR, "Add section block failed");
+		goto close_fd;
+	}
+
+	if (rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB, ifname, ifdescr, filter) < 0) {
+		CAPTURE_LOG(ERR, "Add interface for port %u:%s failed", port_id, ifname);
+		rte_pcapng_close(pcapng);  /* closes fd */
+		pcapng = NULL;
+	}
+	goto cleanup;
+
+close_fd:
+	close(*fd);
+cleanup:
+	free(osname);
+	free(ifdescr);
+	return pcapng;
+}
+
+static void
+capture_write_stats(rte_pcapng_t *pcapng, struct capture *cap)
+{
+	struct capture_total t;
+
+	rte_spinlock_lock(&cap->cbs_lock);
+	capture_sum_stats(cap, &t);
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	/* TODO: extend pcapng to have more stats */
+	rte_pcapng_write_stats(pcapng, cap->port_id,
+			       t.accepted + t.filtered + t.nombuf, /* ifrecv */
+			       t.nombuf + t.ringfull, /* ifdrop */
+			       NULL);
+}
+
+/* Check that output file is still ok to write (i.e FIFO not closed).
+ * Used to detect when wireshark has exited, and idle.
+ */
+static int
+check_fifo_status(int fd)
+{
+	struct pollfd pfd = { .fd = fd };
+
+	if (poll(&pfd, 1, 0) < 0) {
+		CAPTURE_LOG(ERR, "poll failed: %s", strerror(errno));
+		return -1;
+	}
+	if (pfd.revents & (POLLERR | POLLHUP | POLLNVAL)) {
+		CAPTURE_LOG(NOTICE, "fifo reader closed");
+		return -1;
+	}
+	return 0;
+}
+
+static ssize_t
+capture_process_ring(struct rte_ring *ring, rte_pcapng_t *pcapng,
+		     unsigned int *available)
+{
+	struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+	unsigned int n;
+	ssize_t written;
+
+	n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+				      CAPTURE_BURST_SIZE, available);
+	if (n == 0)
+		return 0;
+
+	written = rte_pcapng_write_packets(pcapng, pkts, n);
+	rte_pktmbuf_free_bulk(pkts, n);
+
+	return written;
+}
+
+static void
+capture_flush_ring(struct rte_ring *ring)
+{
+	for (;;) {
+		struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+		unsigned int n;
+
+		n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+					      CAPTURE_BURST_SIZE, NULL);
+		if (n == 0)
+			break;
+
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+}
+
+/* The capture thread that moves packets from ring to the pcapng out */
+uint32_t __rte_hot
+capture_thread(void *arg)
+{
+	struct capture *cap = arg;
+	unsigned int empty_count = 0;
+	bool reader_gone = false;
+	bool orphaned = false;
+	int fd = -1;
+
+	/*
+	 * Wait for the starter to publish the capture. Until then its thread
+	 * id is not recorded, so a stop or a port release could claim it and
+	 * join nothing; and this thread must not unlink before it is linked.
+	 */
+	while (!rte_atomic_load_explicit(&cap->linked, rte_memory_order_acquire))
+		rte_pause();
+
+	CAPTURE_LOG(INFO, "capture thread starting");
+
+	char name[RTE_THREAD_NAME_SIZE];
+	snprintf(name, sizeof(name), "cap-%u", cap->idx);
+	rte_thread_set_prefixed_name(rte_thread_self(), name);
+
+	/* This thread wants to detect when file gets closed (for FIFO) */
+	sigset_t set;
+	sigemptyset(&set);
+	sigaddset(&set, SIGPIPE);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
+
+	rte_pcapng_t *pcapng = capture_pcapng_open(cap->output, &fd, cap->port_id,
+						   capture_filter_string(cap->filter));
+	if (pcapng == NULL) {
+		/* secondaries attached before this thread started */
+		if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0)
+			orphaned = true;
+		capture_remove_callbacks(cap);
+		goto error;
+	}
+
+	while (rte_atomic_load_explicit(&cap->running, rte_memory_order_relaxed)) {
+		ssize_t written;
+		unsigned int avail;
+
+		written = capture_process_ring(cap->ring, pcapng, &avail);
+		if (written < 0) {
+			if (errno == EPIPE)
+				CAPTURE_LOG(DEBUG, "FIFO closed by reader");
+			else
+				CAPTURE_LOG(ERR, "write to file failed: %s", strerror(errno));
+
+			reader_gone = true;
+			break;
+		}
+
+		if (written > 0) {
+			/* are there more packets? */
+			empty_count = (avail == 0);
+		} else if (empty_count < SLEEP_THRESHOLD) {
+			/* spin a few times before checking */
+			++empty_count;
+			rte_pause();
+		} else if (check_fifo_status(fd) == 0) {
+			/* avoid consuming 100% CPU polling */
+			rte_delay_us_sleep(SLEEP_US);
+		} else {
+			/* output FIFO has closed */
+			reader_gone = true;
+			break;
+		}
+	}
+
+	/*
+	 * Secondaries must stop first, they enqueue into the ring freed below.
+	 * Their counters are in shared blocks, so still counted in the stats.
+	 */
+	CAPTURE_LOG(INFO, "capture thread stopping");
+	if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0)
+		orphaned = true;
+	capture_remove_callbacks(cap);
+
+	/* Process residual */
+	if (reader_gone)
+		capture_flush_ring(cap->ring);
+	else {
+		while (capture_process_ring(cap->ring, pcapng, NULL) > 0)
+			continue;
+
+		capture_write_stats(pcapng, cap);
+	}
+
+	rte_pcapng_close(pcapng);
+
+error:
+	/*
+	 * Nobody is waiting when the fifo reader went away on its own, so
+	 * reap this thread here. The decision belongs to capture_unlink():
+	 * a joiner claims the capture under the same lock, so after the
+	 * unlink no new claim can be made.
+	 */
+	if (!capture_unlink(cap))
+		rte_thread_detach(rte_thread_self());
+	if (orphaned) {
+		/*
+		 * A secondary did not confirm that it detached, so it may still
+		 * be inside a burst holding this capture. Freeing the ring it
+		 * writes into would corrupt that process, so leak instead.
+		 */
+		CAPTURE_LOG(ERR,
+			    "capture %u: secondary still attached, leaking ring and pool",
+			    cap->idx);
+	} else {
+		capture_free(cap);
+	}
+
+	return 0;
+}
diff --git a/lib/capture/private.h b/lib/capture/private.h
new file mode 100644
index 0000000000..7bcee7f78f
--- /dev/null
+++ b/lib/capture/private.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+#ifndef CAPTURE_PRIVATE_H
+#define CAPTURE_PRIVATE_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+
+#include <rte_spinlock.h>
+#include <rte_thread.h>
+#include <rte_stdatomic.h>
+#include <rte_mbuf.h>
+
+#define RTE_LOGTYPE_CAPTURE rte_capture_logtype
+extern int rte_capture_logtype;
+#define CAPTURE_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, CAPTURE, "%s(): ", __func__, __VA_ARGS__)
+
+/* Shared between the control, datapath, output and multi-process parts. */
+#define ALL_QUEUES		UINT16_MAX
+#define CAPTURE_BURST_SIZE	32u
+#define CAPTURE_EXTCAP_PREFIX	"dpdk"
+#define CAPTURE_STOP_BATCH	16	/* captures stopped per pass */
+#define SLEEP_THRESHOLD		100
+#define SLEEP_US		100
+
+/* Per port/queue/direction counters. */
+struct capture_stats {
+	uint64_t accepted;	/**< Number of packets accepted by filter. */
+	uint64_t filtered;	/**< Number of packets rejected by filter. */
+	uint64_t nombuf;	/**< Number of mbuf allocation failures. */
+	uint64_t ringfull;	/**< Number of missed packets due to ring full. */
+};
+
+/* Aggregate per-queue counters of a capture instance. */
+struct capture_total {
+	uint64_t accepted;
+	uint64_t filtered;
+	uint64_t nombuf;
+	uint64_t ringfull;
+};
+
+/*
+ * Callback data, one per capture per port/queue/direction.
+ *
+ * Never freed, as in lib/bpf/bpf_pkt.c: rte_eth_remove_{rx,tx}_callback()
+ * only unlinks, so a datapath thread can still enter the callback afterwards
+ * and needs something valid to synchronize on. Recycled only by a later
+ * capture of the same port/queue/direction.
+ */
+struct __rte_cache_aligned capture_rxtx_cb {
+	/* used by both data and control path; see rcu.h for how cap is protected */
+	RTE_ATOMIC(struct capture *) cap;	/* owner, NULL when idle */
+	struct capture_stats stats;
+
+	/* owner's attached list, guarded by cap->cbs_lock; this is how the
+	 * primary sees a secondary's counters. Separate from 'next' because an
+	 * idle block is on the free list at the same time.
+	 */
+	TAILQ_ENTRY(capture_rxtx_cb) attached;
+
+	/* filter loaded by this process, NULL if the capture has none */
+	struct capture_filter_prog *prog;
+
+	/* used by control path only, in the process that attached this block */
+	TAILQ_ENTRY(capture_rxtx_cb) next;	/* links into capture_cb_freelist */
+	const struct rte_eth_rxtx_callback *cb;
+	const struct rte_eth_rxtx_callback *stale;
+	uint16_t port_id;
+	uint16_t queue;
+	bool is_rx;
+};
+
+/*
+ * Idle callback blocks, guarded by capture_lock. Per-process: cb and stale
+ * are only meaningful in the process that registered the ethdev callback.
+ */
+TAILQ_HEAD(capture_cb_list, capture_rxtx_cb);
+
+/*
+ * Per-capture state, in shared memory. A secondary gets this pointer in the
+ * IPC request. It must not follow filter (process-private eBPF) or touch the
+ * creator-only fields marked below.
+ */
+struct capture {
+	RTE_ATOMIC(bool) running;
+	struct capture_filter *filter;
+	struct rte_ring *ring;		/* ring from dataplane to capture thread */
+	struct rte_mempool *mp;		/* mempool for capture mbufs */
+
+	uint32_t snaplen;		/* amount of data to copy */
+	uint16_t queue;
+	uint16_t tx_queues;
+	uint16_t rx_queues;
+	uint16_t port_id;
+	int socket_id;
+
+	uint32_t idx;
+	char *output;			/* filename of out, creator only */
+
+	TAILQ_ENTRY(capture) next;	/* links into capture_list, creator only */
+
+	/*
+	 * Capture thread, creator only. The thread frees the capture, so anyone
+	 * ending it must set joining and copy tid out before clearing running.
+	 * Without a joiner (the fifo reader went away) the thread detaches
+	 * itself, since nothing else is left to reap it.
+	 */
+	rte_thread_t tid;
+	bool joining;
+	/* set once tid is valid and the capture is on the list */
+	RTE_ATOMIC(bool) linked;
+
+	/* blocks attached by any process, so the lock cannot be capture_lock */
+	rte_spinlock_t cbs_lock;
+	struct capture_cb_list attached;
+
+	/* counters of queues already detached; guarded by cbs_lock */
+	struct capture_total total;
+
+	/* what this process attached; sized for one process's queues, so a
+	 * secondary keeps its own record. Creator only.
+	 */
+	struct capture_filter_prog *prog;
+	uint16_t nb_cbs;
+	struct capture_rxtx_cb *cbs[];
+};
+
+/* Captures owned by this process. The lock also guards the cb free list. */
+TAILQ_HEAD(capture_list, capture);
+extern rte_spinlock_t capture_lock;
+
+/* The application may be privileged and extcap not, so only write to a FIFO. */
+static inline bool
+is_fifo(const struct stat *stb)
+{
+	return S_ISFIFO(stb->st_mode);
+}
+
+/* datapath.c */
+int capture_attach_queues(struct capture *cap, struct capture_rxtx_cb **cbs,
+			  uint16_t *nb_cbs, struct capture_filter_prog **progp);
+void capture_detach_queues(struct capture *cap, struct capture_rxtx_cb **cbs,
+			   uint16_t *nb_cbs, struct capture_filter_prog *prog);
+int capture_add_callbacks(struct capture *cap);
+void capture_remove_callbacks(struct capture *cap);
+void capture_sum_stats(const struct capture *cap, struct capture_total *t);
+
+/* capture.c */
+/*
+ * Take the capture off this process's list. Returns true if someone has
+ * claimed the thread and will join it, which can only be decided here:
+ * a claim is made under the same lock, so after this a late claim cannot
+ * find the capture at all.
+ */
+bool capture_unlink(struct capture *cap);
+void capture_free(struct capture *cap);
+
+/* output.c */
+uint32_t capture_thread(void *arg);
+
+/* multiproc.c */
+enum capture_mp_op {
+	CAPTURE_MP_START,
+	CAPTURE_MP_STOP,
+};
+
+void capture_mp_register(void);
+int capture_mp_broadcast(struct capture *cap, enum capture_mp_op op);
+
+/* Shared eBPF instructions, plus the per-process loaded program. */
+struct capture_filter;
+struct capture_filter_prog;
+
+#ifdef RTE_HAS_LIBPCAP
+struct capture_filter *capture_filter_create(const char *str);
+const char *capture_filter_string(struct capture_filter *filter);
+void capture_filter_free(struct capture_filter *filter);
+
+struct capture_filter_prog *capture_filter_load(const struct capture_filter *filter);
+void capture_filter_unload(struct capture_filter_prog *prog);
+uint64_t capture_filter_exec(const struct capture_filter_prog *prog, struct rte_mbuf *mb);
+
+#else /* !RTE_HAS_LIBPCAP */
+
+/* Stub version if pcap is not available */
+static inline struct capture_filter *
+capture_filter_create(const char *str)
+{
+	RTE_SET_USED(str);
+	return NULL; /* not supported */
+}
+
+static inline const char *
+capture_filter_string(struct capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+	return NULL;
+}
+
+static inline void
+capture_filter_free(struct capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+}
+
+static inline struct capture_filter_prog *
+capture_filter_load(const struct capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+	return NULL;
+}
+
+static inline void
+capture_filter_unload(struct capture_filter_prog *prog)
+{
+	RTE_SET_USED(prog);
+}
+
+/* Zero if the packet does not match the filter. */
+static inline uint64_t
+capture_filter_exec(const struct capture_filter_prog *prog, struct rte_mbuf *mb)
+{
+	RTE_SET_USED(prog);
+	RTE_SET_USED(mb);
+	return 1;
+}
+
+#endif  /* !RTE_HAS_LIBPCAP */
+#endif /* CAPTURE_PRIVATE_H */
diff --git a/lib/capture/rcu.c b/lib/capture/rcu.c
new file mode 100644
index 0000000000..dd4a47152f
--- /dev/null
+++ b/lib/capture/rcu.c
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Grace period for the capture callbacks.
+ *
+ * A callback loads cbs->cap and uses it for one burst. Teardown clears
+ * cbs->cap and then wants to free the capture, but must wait for any callback
+ * still using the pointer it loaded a moment ago. Being on the datapath, the
+ * callbacks cannot afford a lock or an atomic to announce that they are busy.
+ *
+ * So a reader announces itself with plain stores to a slot nobody else
+ * writes: the current token on entry, zero on exit. To wait, capture_rcu_sync
+ * bumps the token and then watches every slot until each reads either zero,
+ * meaning idle, or a token at least as new as the bump, meaning the reader
+ * started afterwards and so cannot be holding the old pointer. Once it
+ * returns, every callback that could hold the old pointer has finished.
+ *
+ * Taking the token as 4 before the bump and 5 after:
+ *
+ *                       clear cbs->cap    token 4->5          free
+ *                              |              |                |
+ *   writer  ------------------>+--------------++--------------->
+ *                                              |<--- wait --->|
+ *
+ *   reader A  --[ctr=4 ....uses cap.... ctr=0]----------------->
+ *                            waited for: ctr=4 is older than 5
+ *
+ *   reader B  ------------------------[ctr=0]----------------->
+ *                            ignored: idle when sync looked
+ *
+ *   reader C  ---------------------------------[ctr=5 ....]---->
+ *                            ignored: ctr=5 is not older than 5,
+ *                            so it loaded cap after the clear
+ *
+ * A is the only one the writer waits for. B holds nothing, and C started late
+ * enough that it must have seen the cleared pointer.
+ *
+ * Slots are indexed by lcore id, and sync scans all of them rather than a
+ * list of live readers, so a thread that registers with EAL during a grace
+ * period needs no special handling: its slot was already being watched.
+ *
+ * Plain stores alone would not be enough, because the CPU may hoist the
+ * reader's loads above the store that marks it busy. The writer would then
+ * see an idle slot belonging to a reader that is about to use the old
+ * pointer. Normally the reader prevents that with a store-load fence, which
+ * is exactly the cost this is trying to avoid; instead the writer asks the OS
+ * to run a barrier on every CPU running a thread of the process. The ordering
+ * is the same and the cost lands on teardown, which is rare. liburcu calls
+ * this its "memb" flavor, where fixed slots take the place of its registry of
+ * reader threads.
+ *
+ * Without that OS barrier the library registers no telemetry commands, so no
+ * capture starts and no reader runs. Readers never fence themselves.
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_log.h>
+#include <rte_pause.h>
+#include <rte_stdatomic.h>
+
+#include "private.h"
+#include "rcu.h"
+
+struct capture_rcu capture_rcu = {
+	.token = 1,
+};
+
+/*
+ * OS backends. Each provides:
+ *   capture_rcu_mb_init()  register once, return false if unavailable
+ *   capture_rcu_mb_os()    full barrier on every CPU running a thread of
+ *                          this process, return false on failure
+ *
+ * MEMBARRIER_CMD_PRIVATE_EXPEDITED and its registration need Linux 4.14,
+ * well below the oldest kernel DPDK supports, so no runtime query is done.
+ * Windows is not supported yet but has an equivalent in
+ * FlushProcessWriteBuffers(), so the backend is kept here for when it is.
+ */
+#if defined(RTE_EXEC_ENV_LINUX)
+
+#include <linux/membarrier.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+static bool
+capture_rcu_mb_register(void)
+{
+	return syscall(SYS_membarrier,
+		       MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, 0, 0) == 0;
+}
+
+static bool
+capture_rcu_mb_init(void)
+{
+	return capture_rcu_mb_register();
+}
+
+static bool
+capture_rcu_mb_os(void)
+{
+	if (syscall(SYS_membarrier, MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0) == 0)
+		return true;
+
+	/*
+	 * Registration is per memory map, and fork() gives the child a fresh
+	 * one, so an application that daemonizes after the constructor ran
+	 * lands here. Register this map and try once more.
+	 */
+	if (errno == EPERM && capture_rcu_mb_register())
+		return syscall(SYS_membarrier,
+			       MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0) == 0;
+	return false;
+}
+
+#elif defined(RTE_EXEC_ENV_FREEBSD)
+
+/* FreeBSD 14.1 and later, same command set as Linux */
+#include <sys/membarrier.h>
+
+static bool
+capture_rcu_mb_register(void)
+{
+	return membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, 0, 0) == 0;
+}
+
+static bool
+capture_rcu_mb_init(void)
+{
+	return capture_rcu_mb_register();
+}
+
+static bool
+capture_rcu_mb_os(void)
+{
+	if (membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0) == 0)
+		return true;
+
+	/* see the Linux comment: a fresh memory map is not registered */
+	if (errno == EPERM && capture_rcu_mb_register())
+		return membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0) == 0;
+	return false;
+}
+
+#elif defined(RTE_EXEC_ENV_WINDOWS)
+
+#include <rte_windows.h>
+
+/* always available, no registration needed, process scope */
+static bool
+capture_rcu_mb_init(void)
+{
+	return true;
+}
+
+static bool
+capture_rcu_mb_os(void)
+{
+	FlushProcessWriteBuffers();
+	return true;
+}
+
+#else
+
+static bool
+capture_rcu_mb_init(void)
+{
+	return false;
+}
+
+static bool
+capture_rcu_mb_os(void)
+{
+	return false;
+}
+
+#endif
+
+/* Full barrier on every CPU running a thread of this process. */
+static void
+capture_rcu_mb_all(void)
+{
+	/* order this thread's own prior stores first */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	if (likely(capture_rcu_mb_os()))
+		return;
+
+	/*
+	 * Readers only compiler-barrier, so this is the only thing ordering
+	 * their slot store ahead of their loads. It worked at startup or the
+	 * library would not have registered, so a failure here means the
+	 * environment changed underneath us.
+	 *
+	 * Rather than panic, wait instead. The reorderings the barrier would
+	 * have prevented, a slot store still sitting in a store buffer or a
+	 * load hoisted above it, resolve in nanoseconds, and this sleep is far
+	 * longer. A reader still inside a burst is waited for by the slot scan
+	 * in capture_rcu_sync(), not by this.
+	 */
+	static bool once;
+	if (!once) {
+		once = true;
+		CAPTURE_LOG(NOTICE, "membarrier failed (%s), sleeping instead",
+			    strerror(errno));
+	}
+	rte_delay_us_sleep(CAPTURE_RCU_MB_FAIL_US);
+}
+
+void
+capture_rcu_sync(void)
+{
+	uint64_t t;
+	unsigned int i;
+
+	/*
+	 * Readers that already hold the old pointer have their slot store
+	 * visible after this; readers that store later load the new state.
+	 */
+	capture_rcu_mb_all();
+
+	t = rte_atomic_fetch_add_explicit(&capture_rcu.token, 1,
+					  rte_memory_order_seq_cst) + 1;
+
+	for (i = 0; i < CAPTURE_RCU_SLOTS; i++) {
+		const struct capture_rcu_reader *r = &capture_rcu.reader[i];
+		uint64_t c;
+
+		for (;;) {
+			c = rte_atomic_load_explicit(&r->ctr, rte_memory_order_acquire);
+			/* idle, or entered after the token bump */
+			if (c == 0 || c >= t)
+				break;
+			rte_pause();
+		}
+	}
+
+	/* readers' last loads of the old object complete before the caller frees */
+	capture_rcu_mb_all();
+}
+
+/*
+ * Prove the barrier works here before anything can rely on it: the syscall
+ * exists, registration took, and nothing is filtering it.
+ */
+bool
+capture_rcu_init(void)
+{
+	return capture_rcu_mb_init() && capture_rcu_mb_os();
+}
diff --git a/lib/capture/rcu.h b/lib/capture/rcu.h
new file mode 100644
index 0000000000..39ea8473c2
--- /dev/null
+++ b/lib/capture/rcu.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+#ifndef CAPTURE_RCU_H
+#define CAPTURE_RCU_H
+
+/*
+ * Read-side protection for the capture callbacks.
+ *
+ * Each thread that runs the callbacks owns a slot. On entry it stores the
+ * current writer token into its slot, on exit it stores 0. Plain stores to a
+ * cache line nobody else writes; no atomic read-modify-write and no fence.
+ * The fence is supplied by the writer: capture_rcu_sync() uses membarrier()
+ * to run a full barrier on every CPU executing a thread of this process.
+ *
+ * This is the memb flavor of liburcu, with thread registration replaced by
+ * fixed slots indexed by lcore id. Private to lib/capture for now.
+ */
+
+#include <stdalign.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_interrupts.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
+
+/* one slot per lcore, plus one for the EAL interrupt thread */
+#define CAPTURE_RCU_SLOTS	(RTE_MAX_LCORE + 1)
+#define CAPTURE_RCU_INTR_SLOT	RTE_MAX_LCORE
+#define CAPTURE_RCU_NO_SLOT	UINT32_MAX
+
+struct capture_rcu_reader {
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint64_t) ctr; /* 0 idle, else token at entry */
+	uint32_t depth;			/* nesting, owner only */
+};
+
+struct capture_rcu {
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint64_t) token;
+	struct capture_rcu_reader reader[CAPTURE_RCU_SLOTS];
+};
+
+/* How long to sleep when the OS barrier call fails unexpectedly. */
+#define CAPTURE_RCU_MB_FAIL_US	1000
+
+extern struct capture_rcu capture_rcu;
+
+/* Returns false if the OS barrier does not work; register nothing then. */
+bool capture_rcu_init(void);
+
+/*
+ * Slot for the calling thread.
+ *
+ * Lcores and registered threads use the lcore id. Alarm and interrupt
+ * callbacks run on the EAL interrupt thread, which has no lcore id but is
+ * the one such thread allowed to do Rx/Tx (bonding mode 4 does). Any other
+ * unregistered thread has no slot and is not captured.
+ */
+static inline unsigned int
+capture_rcu_slot(void)
+{
+	unsigned int id = rte_lcore_id();
+
+	if (likely(id != LCORE_ID_ANY))
+		return id;
+	if (rte_thread_is_intr())
+		return CAPTURE_RCU_INTR_SLOT;
+	return CAPTURE_RCU_NO_SLOT;
+}
+
+static inline void
+capture_rcu_enter(unsigned int slot)
+{
+	struct capture_rcu_reader *r = &capture_rcu.reader[slot];
+	uint64_t t;
+
+	if (r->depth++ != 0)
+		return;
+
+	t = rte_atomic_load_explicit(&capture_rcu.token, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&r->ctr, t, rte_memory_order_relaxed);
+
+	/*
+	 * The loads that follow must not move above the store of ctr. The
+	 * writer forces that on every CPU with membarrier, so no fence is
+	 * needed here; capture is refused if membarrier does not work.
+	 */
+	rte_compiler_barrier();
+}
+
+static inline void
+capture_rcu_exit(unsigned int slot)
+{
+	struct capture_rcu_reader *r = &capture_rcu.reader[slot];
+
+	if (--r->depth != 0)
+		return;
+
+	/* release: prior loads complete before the slot reads idle */
+	rte_atomic_store_explicit(&r->ctr, 0, rte_memory_order_release);
+}
+
+/*
+ * Wait until no reader that entered before this call is still inside.
+ * The caller must have unpublished the object first, and must not be inside
+ * a read section itself.
+ */
+void capture_rcu_sync(void);
+
+#endif /* CAPTURE_RCU_H */
diff --git a/lib/meson.build b/lib/meson.build
index 458951054c..73fc64aaf5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -49,6 +49,7 @@ libraries = [
         'lpm',
         'member',
         'pcapng',
+        'capture', # depends on pcapng and bpf
         'power',
         'rawdev',
         'regexdev',
-- 
2.53.0

