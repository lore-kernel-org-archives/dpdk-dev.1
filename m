Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E26CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 21:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F3B640685;
	Tue,  9 Jun 2026 23:05:52 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 2D05140664
 for <dev@dpdk.org>; Tue,  9 Jun 2026 23:05:49 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-307d0405e07so1788018eec.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781039148;
 x=1781643948; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccCE61lh8exBqHVfQAgCsPppBYqBdD6E2Y89PEEQby4=;
 b=biaXcP64f0kfN9J5+eGfKTAXpwO6Z3uqNGv0yYj2XLHVKGiVZsHNarVks6yf7rKTzD
 783rZekavpuZpA+Ozvm20v+HrtpjfCyITi43V0PacBzNZrtnsBiYQy7xOUH/WZkUGhgx
 mLKfsIujvW+c/4C/t6ju63e61BVHGX1zYyFAgSdHe4MnGj5paQIj0ObV4LZGrBORfeGC
 +fpKAM+v6zV1dssjtiKghLL6rar/03Bi14qhs8W6Qi2up+EqeYU66hCS0s7rAf49P5xr
 Wes7ePLoVa6MokSE9vATsgJj2XgGytodacj6WJvDVd/2vYgqxlJdzLVCpekCTjblgN1Y
 oOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781039148; x=1781643948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ccCE61lh8exBqHVfQAgCsPppBYqBdD6E2Y89PEEQby4=;
 b=ADI7TGOrCXxrmXJbMFcm4En6dLOvqU5/fqVZatH9dZlKXbheqByGF6JkHYIe2mSmZi
 S52mZ/xPvbJ17JvS1H7P0Kmke64aOpTM4l9zhxP6uABWe9/2j0GLbjGg73sjdC/YIq0m
 TcKXYu1ACmxgRlAxr2cQ8NyEfL54gNa0USjyYvnmk3toAk5CdX4GChWyD2d+lynwmlFq
 FJEvyIMA/JegzGIFlDWZYMbkONtB7i57MMJJInJjeGbcTUhZoN8j5jaPUbIUKapk7VuM
 tK8loxFFO8EfVjXLJvLxVwv70Cd/LgS2Clc9RKGIGTdx3mQP34fdCF5OxsxmZjrZfR+C
 IT8w==
X-Gm-Message-State: AOJu0YzyweXgW6NUjdCim15nLoTh3xiBdEu5QdC9xnTMSbmFsAfepV+4
 i2bSSHngYK2bsAIKfJWHoU6EbdnduiXP76bG+/ySs40KmWXoCjccbMtULnDIt7wiAJsrM4soFnu
 7LBiD
X-Gm-Gg: Acq92OHrUdaMF7I7d5SH1hkTv+2/f7xs3YuhyK6qOpFyRuHpSb9dgzzVTrtkccXMlZK
 cuhhWLvy8/FyBApmgjYkU/wATya+ODUgFurWjnVvheiK554Vvmu8vZML1l7Sf3Nw6/Vx9c5usqE
 NCdThca4wk61Y0otDpa5CkjK9DRmhz67f1EXCcG7+XvLYiiEZrgEXYQS20yBLX/PGyYBR6/e0Zn
 JOFVmZkxDu3n174fVRlvMX74eIKo8YAh8Ym5iLr6VHPp5OzO/9AfHDttjaC09jMr2He01IMYN6j
 ktmxECVeMMVTKURVd2/sr1KIH/+RDb9F49t0e1xgCXFWLwu7+2sw2SW6eCjpbiZ/z4R6VwQYy3i
 ZhyrsDfn5XdJMoV8L/ZBGuNhBf/3N7CVyBh+I8YSaTw4ndVdcH95SBg5HIjJwQ+UTh4yHkht8To
 AFfwru56mfqoc06el9UCxSgZCv9ZdEOHE6tYSRnvGm7hXbyb++7nd4HrjotnH2GmNaxCaY+WQ8
X-Received: by 2002:a05:7300:8cac:b0:306:f474:738c with SMTP id
 5a478bee46e88-3077b084d97mr13034868eec.13.1781039147953; 
 Tue, 09 Jun 2026 14:05:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcad34esm32953589eec.11.2026.06.09.14.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:05:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Robin Jarry <rjarry@redhat.com>
Subject: [RFC 4/4] usertools/dpdk-wireshark-extcap.py: script for external
 capture
Date: Tue,  9 Jun 2026 14:02:05 -0700
Message-ID: <20260609210540.768074-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609210540.768074-1-stephen@networkplumber.org>
References: <20260609210540.768074-1-stephen@networkplumber.org>
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

Also add MAINTAINERS and release note.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                           |   2 +
 doc/guides/tools/index.rst            |   1 +
 doc/guides/tools/wireshark_extcap.rst | 155 +++++++++++++++
 usertools/dpdk-wireshark-extcap.py    | 274 ++++++++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100755 usertools/dpdk-wireshark-extcap.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ff5f31c770..7cb8782910 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1725,6 +1725,8 @@ M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
 F: lib/capture/
 F: app/test/test_capture.c
+F: usertools/dpdk-wireshark-extcap.py
+F: doc/guides/tools/wireshark_extcap.rst
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
 F: app/test/test_pdump.*
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 8ec429ec53..580c7d28b1 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -14,6 +14,7 @@ DPDK Tools User Guides
     pmdinfo
     dumpcap
     pdump
+    wireshark_extcap
     dmaperf
     flow-perf
     securityperf
diff --git a/doc/guides/tools/wireshark_extcap.rst b/doc/guides/tools/wireshark_extcap.rst
new file mode 100644
index 0000000000..fae39fd393
--- /dev/null
+++ b/doc/guides/tools/wireshark_extcap.rst
@@ -0,0 +1,155 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+Wireshark Extcap Plugin
+=======================
+
+The ``dpdk-wireshark-extcap.py`` script is an external capture (extcap)
+plugin that lets Wireshark capture live traffic from the Ethernet ports of a
+running DPDK application. Each DPDK port appears as a capture interface in the
+Wireshark interface list, alongside the host's own network interfaces.
+
+The plugin does not attach to the DPDK application as a secondary process and
+never touches packet data itself. It connects to the application's telemetry
+socket, asks it to start capturing, and hands Wireshark's capture pipe to the
+application over that socket. The DPDK capture library writes pcapng packets
+directly into the pipe; the plugin only sets the capture up and tears it down
+when Wireshark closes the pipe.
+
+
+Requirements
+------------
+
+* A DPDK application built with the capture library and with telemetry
+  enabled. Telemetry is enabled by default.
+
+* Wireshark with extcap support.
+
+* The plugin, and therefore Wireshark, must run as the same user as the DPDK
+  application. See `Permissions`_.
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
+In normal use the plugin is not run by hand; Wireshark invokes it. The ports
+of a running DPDK application appear in the interface list as
+``DPDK <name> (port <N>)``, where ``<name>`` is the device name reported by
+the application, such as ``net_tap0``. Selecting a port and starting the
+capture is all that is required.
+
+The plugin can also be run directly, which is useful for confirming that a
+DPDK application is reachable::
+
+    $ usertools/dpdk-wireshark-extcap.py --extcap-interfaces
+    extcap {version=0.1}{display=DPDK telemetry capture}
+    interface {value=dpdk:0}{display=DPDK net_tap0 (port 0)}
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
+Capture filter
+    A libpcap filter expression, applied by the DPDK application to the
+    captured traffic.
+
+
+Permissions
+-----------
+
+The DPDK runtime directory is created mode ``0700``, so only the user that
+started the DPDK application can reach its telemetry socket. Wireshark, and
+the plugin it launches, must run as that same user. Run as a different user,
+the interface list is simply empty; running the plugin directly with
+``--extcap-interfaces`` prints a diagnostic to standard error explaining the
+permission failure.
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
+file-prefix, and no configuration is needed: its ports appear automatically.
+
+Running several DPDK applications on one host is uncommon. Each primary
+process needs its own dedicated cores, memory, and network ports, so it is
+generally done only on large hosts deliberately partitioned for the purpose.
+In that case each application is started with a distinct ``--file-prefix`` so
+that its runtime state is kept separate.
+
+Each file-prefix is an independent namespace, much like a network namespace.
+The plugin operates within exactly one of them at a time and lists only the
+ports of the application using that prefix. The prefix is selected by the
+``DPDK_EXTCAP_FILE_PREFIX`` environment variable, which corresponds to the EAL
+``--file-prefix`` option and defaults to ``rte`` (the EAL default). It must be
+present in the environment that Wireshark inherits, so it has to be set before
+Wireshark is launched, not from within the capture dialog::
+
+    DPDK_EXTCAP_FILE_PREFIX=myapp wireshark
+
+The prefix cannot be chosen per capture from the Wireshark GUI, by design.
+Wireshark builds the interface list once, before any interface or its options
+are selected, so the prefix must be known at enumeration time. It is also
+deliberately not a per-interface option: the device names in the list are
+resolved against one application, and a per-capture override would let the
+name shown disagree with the port actually captured.
+
+
+Environment variables
+----------------------
+
+``DPDK_EXTCAP_FILE_PREFIX``
+    Selects which DPDK application, by EAL file-prefix, the plugin operates
+    on. Defaults to ``rte``. See `Selecting a DPDK application`_.
+
+``DPDK_EXTCAP_PATH``
+    Overrides the base DPDK runtime directory that holds the per-prefix
+    subdirectories. Use it when the runtime directory is in a non-standard
+    location. It composes with ``DPDK_EXTCAP_FILE_PREFIX``: this variable
+    gives the base directory, the prefix selects the subdirectory within it.
+
+
+Troubleshooting
+---------------
+
+The DPDK ports do not appear in Wireshark
+    Confirm the application is running and was built with the capture library
+    and telemetry. Confirm Wireshark runs as the same user as the application;
+    see `Permissions`_. If the application was started with a non-default
+    ``--file-prefix``, set ``DPDK_EXTCAP_FILE_PREFIX`` to match before
+    launching Wireshark; see `Selecting a DPDK application`_.
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
index 0000000000..2d710bdf5c
--- /dev/null
+++ b/usertools/dpdk-wireshark-extcap.py
@@ -0,0 +1,274 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-or-later
+# Copyright(c) 2026 Stephen Hemminger
+
+"""
+Wireshark extcap plugin for live capture from DPDK ethdev ports.
+
+Capture path: this plugin opens the FIFO that Wireshark hands it, then passes
+that file descriptor to the DPDK primary process over the telemetry socket
+(via SCM_RIGHTS). The DPDK 'capture' library writes pcapng straight into the
+FIFO; this plugin never touches packet data. Teardown is implicit: when
+Wireshark closes the read end, both the DPDK writer and this plugin see the
+hangup.
+
+Interface values are encoded as 'dpdk:<port>'. The DPDK file-prefix is
+ambient, not part of the interface value: it comes from
+DPDK_EXTCAP_FILE_PREFIX (default 'rte') in the environment Wireshark inherits,
+so one invocation is scoped to a single primary like a namespace. See
+doc/guides/tools/wireshark_extcap.rst for the rationale and the multi-prefix
+case.
+"""
+
+import argparse
+import array
+import json
+import os
+import select
+import signal
+import socket
+import sys
+
+EXTCAP_VERSION = "0.1"
+TELEMETRY_SOCKET = "dpdk_telemetry.v2"
+CAPTURE_CMD = "/ethdev/capture/start"
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
+def file_prefix():
+    """The EAL file-prefix to operate on; see the module docstring."""
+    return os.environ.get("DPDK_EXTCAP_FILE_PREFIX", DEFAULT_PREFIX)
+
+
+def socket_path():
+    return os.path.join(dpdk_dir(), file_prefix(), TELEMETRY_SOCKET)
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
+    def command(self, cmd, fds=None):
+        """Send a command, optionally with file descriptors as ancillary data.
+
+        Returns the decoded JSON reply, or None if the peer sent nothing.
+        """
+        if fds:
+            fd_arr = array.array("i", fds)
+            self.sock.sendmsg(
+                [cmd.encode()], [(socket.SOL_SOCKET, socket.SCM_RIGHTS, fd_arr)]
+            )
+        else:
+            self.sock.send(cmd.encode())
+
+        reply = self.sock.recv(self.max_output_len)
+        if not reply:
+            return None
+        return json.loads(reply.decode())
+
+    def close(self):
+        self.sock.close()
+
+
+# --- extcap query operations --------------------------------------------
+
+
+def port_name(tel, port):
+    """Device name for a port via /ethdev/info, or 'port<N>' if unreadable."""
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
+    path = socket_path()
+    try:
+        tel = Telemetry(path)
+    except FileNotFoundError:
+        # No telemetry socket -> no DPDK primary with this file-prefix.
+        return
+    except PermissionError:
+        # The runtime dir is mode 0700; a different user cannot traverse it.
+        sys.stderr.write(
+            f"cannot access {path}: permission denied. The DPDK runtime "
+            "directory is created mode 0700, so capture must run as the same "
+            "user as the DPDK application (or set DPDK_EXTCAP_PATH / "
+            "DPDK_EXTCAP_FILE_PREFIX).\n"
+        )
+        return
+
+    # One connection for the whole enumeration: list the ports, then name
+    # each over the same socket (each telemetry connection costs the primary
+    # a handler thread).
+    try:
+        reply = tel.command(ETHDEV_LIST)
+        ports = (reply or {}).get(ETHDEV_LIST) or []
+        for port in ports:
+            name = port_name(tel, port)
+            print(
+                f"interface {{value=dpdk:{port}}}"
+                f"{{display=DPDK {name} (port {port})}}"
+            )
+    except OSError as e:
+        sys.stderr.write(f"cannot query {path}: {e}\n")
+    finally:
+        tel.close()
+
+
+def cmd_dlts(_iface):
+    print(f"dlt {{number={DLT_EN10MB}}}{{name=EN10MB}}{{display=Ethernet}}")
+
+
+def cmd_config(_iface):
+    print(
+        f"arg {{number=0}}{{call=--snaplen}}{{display=Snapshot length}}"
+        f"{{tooltip=Bytes captured per packet (0 = whole packet)}}"
+        f"{{type=integer}}{{range=0,{DEFAULT_SNAPLEN}}}"
+        f"{{default={DEFAULT_SNAPLEN}}}{{group=Capture}}"
+    )
+
+
+# --- capture -------------------------------------------------------------
+
+
+def parse_iface(iface):
+    """Return the port number from a 'dpdk:<port>' interface value."""
+    scheme, sep, port = iface.partition(":")
+    if scheme != "dpdk" or not sep:
+        raise SystemExit(f"unsupported interface '{iface}'")
+    try:
+        return int(port)
+    except ValueError:
+        raise SystemExit(f"malformed interface '{iface}'")
+
+
+def wait_for_stop(fifo_fd):
+    """Block until Wireshark stops us: either it closes the FIFO read end
+    (POLLERR on our write fd) or it sends SIGINT/SIGTERM."""
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
+def cmd_capture(iface, fifo, snaplen, cfilter):
+    port = parse_iface(iface)
+    path = socket_path()
+
+    # Open the FIFO Wireshark created; this blocks until it has the read end.
+    fifo_fd = os.open(fifo, os.O_WRONLY)
+
+    try:
+        tel = Telemetry(path)
+    except OSError as e:
+        os.close(fifo_fd)
+        raise SystemExit(f"cannot connect to DPDK telemetry at {path}: {e}")
+
+    params = [str(port)]
+    if snaplen is not None:
+        params.append(f"snaplen={snaplen}")
+    if cfilter:
+        params.append(f"filter={cfilter}")
+    cmd = CAPTURE_CMD + "," + ",".join(params)
+
+    try:
+        tel.command(cmd, fds=[fifo_fd])
+    except OSError as e:
+        os.close(fifo_fd)
+        tel.close()
+        raise SystemExit(f"capture start failed: {e}")
+
+    # DPDK now holds its own dup of the FIFO write end. We keep ours only as a
+    # hangup sentinel: when Wireshark closes the read end we get POLLERR, the
+    # same event that stops the DPDK-side writer.
+    wait_for_stop(fifo_fd)
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
+    p.add_argument("--extcap-version")
+    p.add_argument("--snaplen", type=int)
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
+            args.extcap_interface, args.fifo, args.snaplen, args.extcap_capture_filter
+        )
+    else:
+        raise SystemExit("no extcap operation specified")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0

