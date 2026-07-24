Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4BC531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 21:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D72C40691;
	Fri, 24 Jul 2026 23:22:50 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 633E040671
 for <dev@dpdk.org>; Fri, 24 Jul 2026 23:22:47 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-848593533cbso663811b3a.3
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784928166;
 x=1785532966; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EKHu2bdLsN78mCs1DI5LGCeT8jrOMd+YHye1UMan5sg=;
 b=Mu8T6QQdwj3FCQ2/Cz/ICCCyxeRsq12spWt17mvZUclE+J1UwUyEXwCBqZfvijrTti
 US/8rgGBEVvGkBT4gxHoaR7FgChDtenTxekZVKCucBQZykz+O6eSquOz5E3o4Cn4Eyl1
 0U76ZWNxIQBaB0KTzgm+ZLSg6VpqM96D3jultJRBAE6wSuild77olzjRnmc7ogXSmslZ
 u6Smih58GONp06hWMPGrDPELKDFzhTZjUKxuoX/6uVQk/eG1+O1nVbpxrHi6DyIIXU/V
 TiitUDoOHjEjuHxK28ssFjdf2LhAH1/m8Ai9HXFTXvghTr7mmoss4yZ1glAzJoePT5mK
 p9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928166; x=1785532966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EKHu2bdLsN78mCs1DI5LGCeT8jrOMd+YHye1UMan5sg=;
 b=EiEnUJoeMhphz5enReCnsBFj8Y07RXtqaHJoW7/YrhlxnFd+1vieuf4NaCpZvdvtmT
 NgGeksD58LMiiVT/CpCmw0OpdLU1xK0UICG93qOvTHUjyyqSoNSERDIUnCQuA0ptBX6s
 oeY2y0ysssp3iKoNCoom8pWyyqpEQIlKURrYrRJxfIQT6LaV/TxUxvDXa8q/LwoV7AYL
 iMX2cxQC05Cox12IL2UNx+nCdIxtLZkGfUfXsgakSlPEPkhFfmiWJdyQswvXjsm0UwgE
 VFNXun+7iKMJ5KrDytT49t9vv+TZTJ3KbE1YOGiKMdSVbRhggUgtlbYphpcRTuAjICF6
 774w==
X-Gm-Message-State: AOJu0YxWWQXrjTib1yPLEYlrHlz2au8N5Sg+Ti/JBJHwYfVfnAalcbpR
 I/3je4TXgkvqxt+JfGgTd8E4CnZUeP7dq1vV9/MIELMgbSJicudlENylCahiEXt2HTQBmv/w+tq
 dwO48
X-Gm-Gg: AR+sD133djAj9oBj263UngEcVE09WK8zhTmFPGRCCRxHNDiA2Y5vZ6q8IPOQS14smgT
 KxIUuDFxUVZjy4yXzwqM71IxLL3YA8xT5S1bUnJKUVDv4yCpuFJqQNja4GOgtRbTxeX9xGtpJAX
 RN6LSxawj9NXCdoEjYkMMj9aYdjemEuxsqq/GteEFgFwUR6cnu3+6bcl1B9n4AYsGd1uDV2zFDz
 3ZsXeziZ5soJrKEjt1LIN4sqKKYRgMhPfmkAsxy4J01R0waFX8t2if21eMS7LKDv3Lb7U2SvX2v
 fRtgAPBYd7Fk4wJOhetkz/a2JHahciD03lm8fVRiJjgKnLmaetEp3HHbwl4rMO8AnQq0NQnQ13y
 rDdd5SG6VMCIpKdzeLcSYNiN8dqzNScatnA55YQcinpP/elB6XdzZOUFmBKPEin8hKZCcUHFU6w
 TLQ7ago3PuoMa2L5Sir5gR+JudAmP//6KKq6Sg91f6
X-Received: by 2002:a05:6a21:6e43:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c67dde9ea1mr40055637.49.1784928166350; 
 Fri, 24 Jul 2026 14:22:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548efesm2612725eec.14.2026.07.24.14.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:22:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4/5] usertools/dpdk-wireshark-extcap.py: script for external
 capture
Date: Fri, 24 Jul 2026 14:11:56 -0700
Message-ID: <20260724212238.864798-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724212238.864798-1-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
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

Provide glue script that wireshark can use to access
telemetry based packet capture. It is dual licensed because
it maybe desirable to put this in wireshark repository.

See https://www.wireshark.org/docs/man-pages/extcap.html

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/wireshark_extcap.rst  | 144 ++++++++++
 usertools/dpdk-wireshark-extcap.py     | 374 +++++++++++++++++++++++++
 4 files changed, 520 insertions(+)
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100755 usertools/dpdk-wireshark-extcap.py

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8291c2c4e5..9835807fcc 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -58,6 +58,7 @@ New Features
 * **Added wireshark capture support.**
 
   * Added ``capture`` library for packet capture via telemetry API.
+  * Added python script for wireshark external capture integration.
 
 
 Removed Items
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 13f75a5bc6..01db27511a 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -14,6 +14,7 @@ DPDK Tools User Guides
     pmdinfo
     dumpcap
     pdump
+    wireshark_extcap
     telemetrywatcher
     dmaperf
     flow-perf
diff --git a/doc/guides/tools/wireshark_extcap.rst b/doc/guides/tools/wireshark_extcap.rst
new file mode 100644
index 0000000000..f3d932f651
--- /dev/null
+++ b/doc/guides/tools/wireshark_extcap.rst
@@ -0,0 +1,144 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+Wireshark Extcap Plugin
+=======================
+
+The ``dpdk-wireshark-extcap.py`` script is an external capture (extcap)
+plugin that lets Wireshark capture live traffic from the Ethernet ports of a
+running DPDK application.
+Each DPDK port appears as a capture interface in the Wireshark interface list,
+alongside the host's own network interfaces.
+
+The plugin uses the DPDK telemetry API to query and start capture.
+It passes the path of the fifo file that Wireshark created to the DPDK application,
+which opens the file itself and writes pcapng packets straight into it;
+the plugin never touches packet data.
+Wireshark signals the plugin on exit and that results in closing
+the capture session.
+
+
+Requirements
+------------
+
+* A DPDK application built with the capture library and with telemetry enabled.
+  Telemetry is enabled by default.
+
+* Since the plugin is started by Wireshark, Wireshark and the DPDK application
+  must have the same permissions. See `Permissions`_.
+
+
+Installation
+------------
+
+For Wireshark to discover the plugin it must be present in an extcap
+directory. The configured locations are listed in Wireshark under
+*Help > About Wireshark > Folders*. Copy or symbolically link the script into
+the personal extcap directory, for example::
+
+    ln -s $RTE_SDK/usertools/dpdk-wireshark-extcap.py \
+        ~/.local/lib/wireshark/extcap/
+
+The DPDK ports then appear in the interface list the next time the capture
+options dialog is opened.
+
+
+Usage
+-----
+
+In normal use the plugin is not run by hand; Wireshark invokes it.
+The ports of a running DPDK application appear in the interface list as
+``DPDK <name>``, where ``<name>`` is the device name reported by
+DPDK ethdev, such as ``net_tap0``.
+
+The plugin can also be run directly, which is useful for confirming that a
+DPDK application is reachable::
+
+    $ usertools/dpdk-wireshark-extcap.py --extcap-interfaces
+    extcap {version=0.1}{display=DPDK telemetry capture}
+    interface {value=dpdk:0}{display=DPDK net_tap0}
+
+
+Capture options
+---------------
+
+The following options are offered in the Wireshark capture options dialog for
+a DPDK interface:
+
+Snapshot length
+    Number of bytes captured from each packet. ``0`` captures the whole
+    packet. The default is 262144.
+
+Queue
+    Capture a single hardware queue, or all queues (the default). The choices
+    are bounded to the port's configured queue count.
+
+Capture filter
+    A libpcap filter expression, applied by the DPDK application to the
+    captured traffic.
+
+
+Permissions
+-----------
+
+The DPDK runtime directory is created mode ``0700``, so only the user that
+started the DPDK application can reach its telemetry socket.
+Wireshark, and the plugin it launches, must run as that same user. If run as a
+different user, the interface list is simply empty; running the plugin directly
+with ``--extcap-interfaces`` prints a diagnostic to standard error explaining
+the permission failure.
+
+No privilege beyond access to the telemetry socket is required: if you can
+run ``dpdk-dumpcap`` against an application, you can capture from it with this
+plugin.
+
+
+Selecting a DPDK application
+----------------------------
+
+A host usually runs a single DPDK application, started with the default
+file-prefix (``rte``), and no configuration is needed: its ports appear
+automatically as ``DPDK <name>``.
+
+Running several DPDK applications on one host is also supported. In that case
+each application is started with a distinct ``--file-prefix`` so that its
+runtime state is kept separate. The plugin lists the ports of *all* running
+applications at once, so the application is chosen from the interface list
+rather than before Wireshark is launched. There is no environment variable to
+select one.
+
+Ports of the default prefix are shown plainly, as ``DPDK <name>`` with the
+interface value ``dpdk:<port>``. Ports of any other prefix are qualified with
+the prefix, shown as ``DPDK <name>@<prefix>`` with the interface value
+``dpdk:<prefix>:<port>``, so applications with colliding port numbers stay
+distinct in the list.
+
+
+Environment variables
+----------------------
+
+``DPDK_EXTCAP_PATH``
+    Overrides the base DPDK runtime directory that holds the per-prefix
+    subdirectories. Use it when the runtime directory is in a non-standard
+    location. It gives the base directory that holds the per-prefix
+    subdirectories, one of which is scanned for each running application.
+
+
+Troubleshooting
+---------------
+
+The DPDK ports do not appear in Wireshark
+    Confirm the application is running and was built with the capture library
+    and telemetry. Confirm Wireshark runs as the same user as the application;
+    see `Permissions`_. An application started with a non-default
+    ``--file-prefix`` is listed with its ports qualified as
+    ``DPDK <name>@<prefix>``; see `Selecting a DPDK application`_.
+
+    Running the plugin directly with ``--extcap-interfaces`` prints
+    diagnostics to standard error that the Wireshark GUI does not surface.
+
+A port is listed as ``portN`` instead of a device name
+    The port was reported by the application, but its details could not be
+    read, usually because the application stopped between listing and naming
+    its ports. A capture started against it will fail; restart the
+    application.
diff --git a/usertools/dpdk-wireshark-extcap.py b/usertools/dpdk-wireshark-extcap.py
new file mode 100755
index 0000000000..6c6b792a77
--- /dev/null
+++ b/usertools/dpdk-wireshark-extcap.py
@@ -0,0 +1,374 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-or-later
+# Copyright(c) 2026 Stephen Hemminger
+
+"""
+Wireshark extcap plugin for live capture from DPDK ethdev ports.
+
+Capture path: Wireshark creates a FIFO and hands this plugin its path. The
+plugin opens the FIFO -- which rendezvous with Wireshark's read end -- and then
+passes the FIFO *path* to the DPDK primary process over the telemetry socket as
+the 'out=' parameter. DPDK opens the FIFO itself and writes pcapng straight into
+it; this plugin never touches packet data.
+
+Stopping: Wireshark stops a capture by closing the FIFO read end and/or sending
+SIGTERM. On either, this plugin asks DPDK to stop (/ethdev/capture/stop,<id>) so
+it can flush the trailing packets and the closing interface statistics block
+while a reader is still attached. If the read end is already gone, DPDK detects
+the same hangup and stops on its own; the explicit stop is then a harmless
+no-op. Note that when stopped from the Wireshark GUI the read-end close usually
+precedes the signal, so the statistics block is delivered reliably only for
+standalone (Ctrl+C) runs and for file output.
+
+Interface values: 'dpdk:<port>' for the default file-prefix ('rte'), and
+'dpdk:<prefix>:<port>' for any other primary. The default prefix is left
+implicit so the common single-instance case stays unadorned.
+"""
+
+import argparse
+import json
+import os
+import select
+import signal
+import socket
+import sys
+
+EXTCAP_VERSION = "0.1"
+TELEMETRY_SOCKET = "dpdk_telemetry.v2"
+CAPTURE_START_CMD = "/ethdev/capture/start"
+CAPTURE_STOP_CMD = "/ethdev/capture/stop"
+ETHDEV_LIST = "/ethdev/list"
+ETHDEV_INFO = "/ethdev/info"
+DEFAULT_SNAPLEN = 262144
+DEFAULT_PREFIX = "rte"  # EAL HUGEFILE_PREFIX_DEFAULT
+DLT_EN10MB = 1
+
+
+# --- DPDK runtime directory / socket discovery ---------------------------
+
+
+def dpdk_dir():
+    """Directory holding the per-file-prefix runtime subdirectories."""
+    override = os.environ.get("DPDK_EXTCAP_PATH")
+    if override:
+        return override
+    if os.geteuid() == 0:
+        base = "/var/run"
+    else:
+        base = os.environ.get("XDG_RUNTIME_DIR", "/tmp")
+    return os.path.join(base, "dpdk")
+
+
+def socket_path(prefix):
+    return os.path.join(dpdk_dir(), prefix, TELEMETRY_SOCKET)
+
+
+def list_prefixes():
+    """Yield (prefix, path) for each DPDK telemetry socket found."""
+    root = dpdk_dir()
+    try:
+        entries = os.listdir(root)
+    except FileNotFoundError:
+        # No DPDK runtime dir -> no DPDK application is running.
+        return
+    except PermissionError:
+        # The runtime dir is mode 0700; a different user can see nothing.
+        sys.stderr.write(
+            f"cannot read {root}: permission denied. The DPDK runtime "
+            "directory is created mode 0700, so capture must run as the same "
+            "user as the DPDK application, or set DPDK_EXTCAP_PATH.\n"
+        )
+        return
+
+    for prefix in sorted(entries):
+        path = os.path.join(root, prefix, TELEMETRY_SOCKET)
+        if os.path.exists(path):
+            yield prefix, path
+
+
+def iface_value(prefix, port):
+    """Interface value for a (prefix, port). The default prefix is left
+    implicit so a single default-prefix instance shows 'dpdk:<port>'; any
+    other primary is spelled out as 'dpdk:<prefix>:<port>'."""
+    if prefix == DEFAULT_PREFIX:
+        return f"dpdk:{port}"
+    return f"dpdk:{prefix}:{port}"
+
+
+# --- Telemetry transport -------------------------------------------------
+
+
+class Telemetry:
+    """Minimal client for the DPDK v2 telemetry socket (SOCK_SEQPACKET)."""
+
+    def __init__(self, path):
+        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+        self.sock.connect(path)
+        info = json.loads(self.sock.recv(1024).decode())
+        self.max_output_len = info.get("max_output_len", 16384)
+        self.pid = info.get("pid")
+        self.version = info.get("version")
+
+    def command(self, cmd):
+        """Send a command, return the decoded JSON reply, or None if empty."""
+        self.sock.send(cmd.encode())
+        reply = self.sock.recv(self.max_output_len)
+        if not reply:
+            return None
+        return json.loads(reply.decode())
+
+    def close(self):
+        self.sock.close()
+
+
+def port_queue_count(tel, port):
+    """Max of the rx/tx queue counts for a port, 0 if unknown."""
+    try:
+        reply = tel.command(f"{ETHDEV_INFO},{port}")
+    except OSError:
+        reply = None
+    info = (reply or {}).get(ETHDEV_INFO) or {}
+    return max(info.get("nb_rx_queues", 0), info.get("nb_tx_queues", 0))
+
+
+# --- extcap query operations --------------------------------------------
+
+
+def port_name(tel, port):
+    """Device name for a port via /ethdev/info, or 'port<N>' if unreadable.
+    For a physical port this is the PCI address (0000:c1:00.0); for a vdev it
+    is the vdev name (net_tap0). Reuses the caller's open connection."""
+    try:
+        reply = tel.command(f"{ETHDEV_INFO},{port}")
+    except OSError:
+        reply = None
+    info = (reply or {}).get(ETHDEV_INFO) or {}
+    return info.get("name") or f"port{port}"
+
+
+def cmd_interfaces():
+    print(f"extcap {{version={EXTCAP_VERSION}}}{{display=DPDK telemetry capture}}")
+    for prefix, path in list_prefixes():
+        try:
+            tel = Telemetry(path)
+        except OSError as e:
+            sys.stderr.write(f"cannot query {path}: {e}\n")
+            continue
+        # One connection per prefix for the whole enumeration: list the ports,
+        # then name each over the same socket (each connection costs the
+        # primary a handler thread).
+        try:
+            ports = (tel.command(ETHDEV_LIST) or {}).get(ETHDEV_LIST) or []
+            for port in ports:
+                name = port_name(tel, port)
+                # Name the prefix in the label only when it is not the default.
+                if prefix == DEFAULT_PREFIX:
+                    display = f"DPDK {name}"
+                else:
+                    display = f"DPDK {name}@{prefix}"
+                print(
+                    f"interface {{value={iface_value(prefix, port)}}}"
+                    f"{{display={display}}}"
+                )
+        except OSError as e:
+            sys.stderr.write(f"cannot query {path}: {e}\n")
+        finally:
+            tel.close()
+
+
+def cmd_dlts(_iface):
+    print(f"dlt {{number={DLT_EN10MB}}}{{name=EN10MB}}{{display=Ethernet}}")
+
+
+def cmd_config(iface):
+    print(
+        f"arg {{number=0}}{{call=--snaplen}}{{display=Snapshot length}}"
+        f"{{tooltip=Bytes captured per packet (0 = whole packet)}}"
+        f"{{type=integer}}{{range=0,{DEFAULT_SNAPLEN}}}"
+        f"{{default={DEFAULT_SNAPLEN}}}{{group=Capture}}"
+    )
+
+    # Bound the queue dropdown to the port's actual queue count. If the primary
+    # is unreachable, just omit the selector -- capture still defaults to all.
+    nqueues = 0
+    if iface:
+        prefix, port = parse_iface(iface)
+        try:
+            tel = Telemetry(socket_path(prefix))
+        except OSError:
+            tel = None
+        if tel is not None:
+            try:
+                nqueues = port_queue_count(tel, port)
+            finally:
+                tel.close()
+
+    if nqueues > 0:
+        print(
+            f"arg {{number=1}}{{call=--queue}}{{display=Queue}}"
+            f"{{tooltip=Capture a single hardware queue}}"
+            f"{{type=selector}}{{group=Capture}}"
+        )
+        print("value {arg=1}{value=-1}{display=All queues}{default=true}")
+        for q in range(nqueues):
+            print(f"value {{arg=1}}{{value={q}}}{{display=Queue {q}}}")
+
+
+# --- capture -------------------------------------------------------------
+
+
+def parse_iface(iface):
+    """Inverse of iface_value: accept 'dpdk:<port>' (default prefix) or
+    'dpdk:<prefix>:<port>'."""
+    parts = iface.split(":")
+    if parts[0] != "dpdk":
+        raise SystemExit(f"unsupported interface scheme in '{iface}'")
+    if len(parts) == 2:
+        prefix, port = DEFAULT_PREFIX, parts[1]
+    elif len(parts) == 3:
+        prefix, port = parts[1], parts[2]
+    else:
+        raise SystemExit(f"malformed interface '{iface}'")
+    try:
+        port = int(port)
+    except ValueError:
+        raise SystemExit(f"malformed interface '{iface}'")
+    return prefix, port
+
+
+def wait_for_stop(fifo_fd):
+    """Block until Wireshark stops us: either it closes the FIFO read end
+    (POLLERR on our write fd) or it sends SIGINT/SIGTERM. Watching the fd as
+    well as the signal matters because the signal may be missed -- Wireshark's
+    reliable stop is closing the pipe."""
+    rd, wr = os.pipe()
+    os.set_blocking(wr, False)
+    signal.set_wakeup_fd(wr)
+    for sig in (signal.SIGINT, signal.SIGTERM):
+        signal.signal(sig, lambda *_: None)
+
+    poller = select.poll()
+    poller.register(fifo_fd, select.POLLERR)
+    poller.register(rd, select.POLLIN)
+    poller.poll()
+
+    signal.set_wakeup_fd(-1)
+    os.close(rd)
+    os.close(wr)
+
+
+def cmd_capture(iface, fifo, snaplen, queue, cfilter):
+    prefix, port = parse_iface(iface)
+    path = socket_path(prefix)
+
+    # Blocking open of the FIFO Wireshark created. This rendezvous guarantees a
+    # reader is attached before we ask DPDK to open the write end (DPDK opens
+    # O_WRONLY|O_NONBLOCK and would fail with ENXIO if no reader were present).
+    # We then hold this fd for the whole session: it keeps the pipe from
+    # EOF-ing in the window before the DPDK capture thread opens its own write
+    # end, and it is our reliable stop signal -- POLLERR here means Wireshark
+    # closed the read end.
+    fifo_fd = os.open(fifo, os.O_WRONLY)
+
+    try:
+        tel = Telemetry(path)
+    except OSError as e:
+        os.close(fifo_fd)
+        raise SystemExit(f"cannot connect to DPDK telemetry at {path}: {e}")
+
+    params = [str(port), f"out={fifo}"]
+    if snaplen is not None:
+        params.append(f"snaplen={snaplen}")
+    if queue is not None and queue >= 0:
+        params.append(f"queue={queue}")
+    if cfilter:
+        params.append(f"filter={cfilter}")
+    cmd = CAPTURE_START_CMD + "," + ",".join(params)
+
+    try:
+        reply = tel.command(cmd)
+    except OSError as e:
+        os.close(fifo_fd)
+        tel.close()
+        raise SystemExit(f"capture start failed: {e}")
+
+    result = (reply or {}).get(CAPTURE_START_CMD) or {}
+    if "error" in result:
+        os.close(fifo_fd)
+        tel.close()
+        raise SystemExit(f"capture start failed: {result['error']}")
+
+    cap_id = result.get("id")
+
+    # Run until Wireshark stops us (signal or read-end close). DPDK now holds
+    # its own write end, so closing ours below won't EOF the reader prematurely.
+    wait_for_stop(fifo_fd)
+
+    # Ask DPDK to stop while we still hold the write end, so if the reader is
+    # still attached it drains the tail and writes the statistics block before
+    # the final EOF. If the read end is already gone DPDK has already stopped
+    # on the same hangup and this is a no-op.
+    if cap_id is not None:
+        try:
+            tel.command(f"{CAPTURE_STOP_CMD},{cap_id}")
+        except OSError:
+            pass
+
+    os.close(fifo_fd)
+    tel.close()
+
+
+# --- entry point ---------------------------------------------------------
+
+
+def main():
+    p = argparse.ArgumentParser(
+        prog="dpdk-wireshark-extcap.py",
+        allow_abbrev=False,
+        description="Wireshark extcap plugin for live packet capture from the "
+        "Ethernet ports of a running DPDK application. Normally "
+        "invoked by Wireshark; see the DPDK Wireshark extcap guide.",
+    )
+    p.add_argument("--version", action="version", version=f"%(prog)s {EXTCAP_VERSION}")
+
+    p.add_argument("--extcap-interfaces", action="store_true")
+    p.add_argument("--extcap-dlts", action="store_true")
+    p.add_argument("--extcap-config", action="store_true")
+    p.add_argument("--capture", action="store_true")
+    p.add_argument("--extcap-interface")
+    p.add_argument("--fifo")
+    p.add_argument("--extcap-capture-filter")
+    p.add_argument("--extcap-version", nargs="?")
+    p.add_argument("--snaplen", type=int)
+    p.add_argument("--queue", type=int)
+    args, _ = p.parse_known_args()
+
+    if args.extcap_interfaces:
+        cmd_interfaces()
+    elif args.extcap_dlts:
+        cmd_dlts(args.extcap_interface)
+    elif args.extcap_config:
+        cmd_config(args.extcap_interface)
+    elif args.capture:
+        if not args.extcap_interface or not args.fifo:
+            raise SystemExit("--capture requires --extcap-interface and --fifo")
+        cmd_capture(
+            args.extcap_interface,
+            args.fifo,
+            args.snaplen,
+            args.queue,
+            args.extcap_capture_filter,
+        )
+    elif args.extcap_capture_filter:
+        # Wireshark validates a capture filter by invoking the extcap with the
+        # filter but without --capture (see doc/extcap_example.py upstream). We
+        # accept it: Wireshark already syntax-checks it with libpcap against our
+        # DLT (EN10MB), and DPDK compiles it again at capture start. Exiting 0
+        # with no output means "accepted"; printing a line would mark it invalid.
+        pass
+    else:
+        raise SystemExit("no extcap operation specified")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0

