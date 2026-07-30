Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D036C5516D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 177DF40616;
	Thu, 30 Jul 2026 20:25:08 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id EEF3540616
 for <dev@dpdk.org>; Thu, 30 Jul 2026 20:25:04 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso189373a91.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785435904;
 x=1786040704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ub7S8m62JAqu2psY18UxYda1xUnymA7ma4sPiImIYpQ=;
 b=R9zON/3jHvjOJVK2JlNZRBktjsOe+Ro2sQhBKfxfN7RkAlNlniy39ykSnCPDdh2/hH
 lSm34DtkPQR2X3OJCCInJWaDOBBzyvx2nNJrJrT791xvf2pnWW2s0nmUldSjK28KhXK6
 sTzh8nF8nRNsVhLp+M4eH4lJmdWaO+25w1iaM9HV7U+PgeEaK6NyYcjX18qeRTBGA7uG
 BTCBJm3JR5Xbw4nDQsLmDTmtySuuFU6S9OtcU1LMy5tSWWmOEuq2EciFmZxi9rkoy1rE
 DBkbMoqFwYKLt0pjoA//DyItrTsu5YrA9FzQtrTZsR/3OtqRMF9iWXKhKtg7UntoRqzm
 4JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435904; x=1786040704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ub7S8m62JAqu2psY18UxYda1xUnymA7ma4sPiImIYpQ=;
 b=IGxgYg4J2JRzi54teZsPjed9leVMZbw++CBWjHqtIHOBR/PmuDh4wo7ktw/uEKExmR
 AFmVaDGTJTvWKesf1bUeMa27kPENCMgVxRC7HRX6BAZPzv+ySxdMoVXamDgqrLCaty9Q
 4lBw8jxvUz1U2h5Hj0sI2yLQR6D26WIF2VayYFTTJJLEzp/qyBW+Xq6kBPkNeNDf0hZw
 Haj5/AJleBTWlBXJLcrCadR0LO/R+K6H3itUdZxlhGNN3u7Kizvq31H4jRqkL5YbNKCc
 0A9HrOhXAr7UDjWL30EZIoVFO43+aBT4OhYaTGxjiSEz9HoLfQQRYTYB/4KC+3UHkkuO
 ApfA==
X-Gm-Message-State: AOJu0Yy4SDyS+o3AY/aP99DKzicPIafEBvYBFzanylB/4iC0dGrgb3d+
 idF+XcaAo3c6wdaxOLvkLcZZ8O/HwbKMO1frpQCa18inQl2jxtSeNjYo8/pvHsgYrsgwA5C94uT
 4rtjw
X-Gm-Gg: AR+sD11N8yGcAHHhwBO+wZMXpe0AUMYSu9whIxzdIKe/SCNfcU5PLZdgwUu6xqc4Eny
 A/I9xKwPXfC6TaEgG0mtxGpi4bemc3fVKkVUNV9Jw8Hg1R8xf6jt6Zic3hRj92P8o3AaG6n6wjB
 6oSV4pTiV+GTTR4XslCcewRuB4VWeBHgpLzZPmkiVe1ncDfxPV/Ix+kyoDPNKUZchCgUAZ9tRYZ
 J7u8UAGd9MG24HfQnWNeb/5sTJaFWImfvap2NIa7/NaxbXuBNfTf5H6cPRFt4jqOLhY4W/X+wff
 QVNopgHbNcPGO34xgDO7B1/fwkZKWeRV/4ZkKx0V2yrilo4C78ekeZxLjDd6ibPTmnSaknTjYpz
 sYiFYKq1RDgT4y1zzFfAyhbGfoQ+yrIbrFrvB3z1FdoGx0XGxTpKwSbVUTMP8ofcAc66IQASNMw
 VxFndEhYHTBiXR5iBz7v8ssLYi+tU1u9EjE124usqbxpM9Ib0MEy8mzTr7QLXhpwBN9YOr/Zlju
 iJoUlocBeGWIzGHFbU6hCFujSw=
X-Received: by 2002:a17:90b:1649:b0:37f:9ce1:7364 with SMTP id
 98e67ed59e1d1-38f9bed3bccmr3279808a91.26.1785435903765; 
 Thu, 30 Jul 2026 11:25:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262bc27sm30272155c88.2.2026.07.30.11.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:25:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v3 4/4] usertools: add script for wireshark capture
Date: Thu, 30 Jul 2026 11:22:57 -0700
Message-ID: <20260730182455.502175-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182455.502175-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20260730182455.502175-1-stephen@networkplumber.org>
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
 MAINTAINERS                            |   2 +
 doc/guides/rel_notes/release_26_11.rst |   2 +-
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/wireshark_extcap.rst  | 144 +++++++++
 usertools/dpdk-wireshark-extcap.py     | 416 +++++++++++++++++++++++++
 usertools/meson.build                  |   1 +
 6 files changed, 565 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100755 usertools/dpdk-wireshark-extcap.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 608cb4b77d..7f220cc2c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,6 +1732,8 @@ F: app/pdump/
 F: doc/guides/tools/pdump.rst
 F: app/dumpcap/
 F: doc/guides/tools/dumpcap.rst
+F: usertools/dpdk-wireshark-extcap.py
+F: doc/guides/tools/wireshark_extcap.rst
 
 
 Packet Framework
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index cd53fc6b9f..8d4f57cef4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -58,7 +58,7 @@ New Features
 * **Added wireshark capture support.**
 
   * New ``capture`` library for packet capture accessed via telemetry API.
-
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
index 0000000000..99fb94df72
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
+plugin that enables Wireshark capture of live traffic from
+the Ethernet ports of a DPDK application.
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
index 0000000000..ba7323b857
--- /dev/null
+++ b/usertools/dpdk-wireshark-extcap.py
@@ -0,0 +1,416 @@
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
+        # No DPDK runtime dir is present.
+        sys.stderr.write(
+            f"no DPDK runtime directory {root}. Either no DPDK application "
+            "is running, or it runs as a different user\n"
+        )
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
+    found = False
+    for prefix in sorted(entries):
+        path = os.path.join(root, prefix, TELEMETRY_SOCKET)
+        if os.path.exists(path):
+            found = True
+            yield prefix, path
+
+    # Handle case where leftover unix domain socket
+    if not found:
+        sys.stderr.write(f"no DPDK telemetry socket under {root}\n")
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
+            "arg {number=1}{call=--queue}{display=Queue}"
+            "{tooltip=Capture a single hardware queue}"
+            "{type=selector}{group=Capture}"
+        )
+        print("value {arg=1}{value=-1}{display=All queues}{default=true}")
+        for q in range(nqueues):
+            print(f"value {{arg=1}}{{value={q}}}{{display=Queue {q}}}")
+
+
+# --- capture -------------------------------------------------------------
+
+
+def comma_error(what):
+    """Telemetry command parameters are a comma separated list and there is no
+    escaping, so a comma inside a value is parsed as the start of the next
+    parameter. Reject it here rather than let the primary mis-parse it."""
+    return f"{what} must not contain a comma"
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
+    except ValueError as e:
+        raise SystemExit(f"malformed interface '{iface}'") from e
+    return prefix, port
+
+
+def wait_for_stop(fifo_fd):
+    """Block until Wireshark stops us: either it closes the FIFO read end
+    (POLLERR on our write fd) or it sends SIGINT/SIGTERM. Watching the fd as
+    well as the signal matters because the signal may be missed -- Wireshark's
+    reliable stop is closing the pipe.
+
+    The handlers and the wakeup fd are restored before returning: the caller
+    still has telemetry work to do, and a second signal arriving during it
+    should terminate us the usual way rather than be swallowed."""
+    sigs = (signal.SIGINT, signal.SIGTERM)
+    old_handlers = {}
+    old_wakeup = None
+    rd, wr = os.pipe()
+    try:
+        os.set_blocking(wr, False)
+        old_wakeup = signal.set_wakeup_fd(wr)
+        for sig in sigs:
+            old_handlers[sig] = signal.signal(sig, lambda *_: None)
+
+        poller = select.poll()
+        poller.register(fifo_fd, select.POLLERR)
+        poller.register(rd, select.POLLIN)
+        poller.poll()
+    finally:
+        for sig, handler in old_handlers.items():
+            signal.signal(sig, handler)
+        if old_wakeup is not None:
+            signal.set_wakeup_fd(old_wakeup)
+        os.close(rd)
+        os.close(wr)
+
+
+def cmd_capture(iface, fifo, snaplen, queue, cfilter):
+    prefix, port = parse_iface(iface)
+    path = socket_path(prefix)
+
+    # Both are passed to the primary as telemetry parameters; check before
+    # opening anything so a bad one costs nothing.
+    if "," in fifo:
+        raise SystemExit(f"{comma_error('fifo path')}: {fifo}")
+    if cfilter and "," in cfilter:
+        raise SystemExit(comma_error("capture filter"))
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
+        raise SystemExit(f"cannot connect to DPDK telemetry at {path}: {e}") from e
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
+        raise SystemExit(f"capture start failed: {e}") from e
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
+        # filter but without --capture (see doc/extcap_example.py upstream).
+        # Wireshark already syntax-checks it with libpcap against our DLT
+        # (EN10MB) and DPDK compiles it again at capture start, so the only
+        # thing left to reject here is what the telemetry encoding cannot
+        # carry.
+        #
+        # No output means "accepted"; any output marks the filter invalid and
+        # its first line is shown to the user. The exit status must stay 0
+        # either way: Wireshark discards the output of a child that exited
+        # non-zero and reports the filter as unknown rather than invalid.
+        if "," in args.extcap_capture_filter:
+            print(comma_error("capture filter"))
+    else:
+        raise SystemExit("no extcap operation specified")
+
+
+if __name__ == "__main__":
+    main()
diff --git a/usertools/meson.build b/usertools/meson.build
index 114d0a65b4..5debf73702 100644
--- a/usertools/meson.build
+++ b/usertools/meson.build
@@ -13,6 +13,7 @@ install_data([
             'dpdk-rss-flows.py',
             'dpdk-telemetry-exporter.py',
             'dpdk-telemetry-watcher.py',
+            'dpdk-wireshark-extcap.py',
         ],
         install_dir: 'bin')
 
-- 
2.53.0

