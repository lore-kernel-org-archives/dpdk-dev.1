Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376BFCCF2C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 22:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52525406B6;
	Sat, 17 Oct 2026 00:32:15 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3379D4064C
 for <dev@dpdk.org>; Sat, 17 Oct 2026 00:32:12 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so758790a12.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792189931;
 x=1792794731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aaUWmQm21VGLYl2Qfrpc/oVVA+rAan9GrQPFJLE0lbA=;
 b=JuO6kFPenmSWGo+K3BfZ9/8i1C56jTjvSoB4cPIo/fA/P2HW+XoqgP+RxTCo5qdCPx
 banC0L2Lv8jTfehOxDueZIP7rn58k8aD3ZVNoLWo5sRKcsxy80g6S7k7kVTgRev3G4AA
 u3UpJPl6gQ+XkgSqfPHc6tr2buphtfAnUywyfE7cSXk4WzSH/PyRAPiS38A5pwN9+PAt
 dy7wJ8ChnBIoySUS/58euKOxbPnSbC5xqwBuzF5YljsAKXeC/nJAXKZl2AMbBPgXFvjT
 TM7vqplyKZHKgoFYKGl7x7YUn2HhiIQljYKRG7UueU6SXbWezr83LWb4OmQ4tffXbfY7
 nNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792189931; x=1792794731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aaUWmQm21VGLYl2Qfrpc/oVVA+rAan9GrQPFJLE0lbA=;
 b=AZhkVLJu5maB/FdJuUVRFxUSD9yyQuGnZHAm/CWigJkGo/T4RzHCIxpMbZZWfuuHBT
 Ca5kMJ2bRLacdAxwV+UVvHaL6yoowr29ub7TvB23aA20lXzfe04jpfMC/gbPB1fG64S4
 jxZTxUt6XIMqdUvnCB3w8swSxDK7sX93ZOSzkCzSOJeDZqVc1zhrITsJ8b3SCihwClNu
 XCYQULv+pXp56XtpHXS782IJW7/UQbsm8b8JrmuBtfGA5f6XEtKy1CfBEPO6/cYhD9Xo
 COLPSYk8vqPyzTYCorfYeNo91ck9VTD7Yl/9G6/1WMmxNAnkbTp+OVHCVugruPnG7th3
 1cfg==
X-Gm-Message-State: AFq9FYIUxk/1v2205NBRvlD0HTBY9UgEe5nRmCeUHt2cV1ofpm/7Z+ru
 /H66JwpgCJttQ1kNY5GD0DoCAKwcz818nrj4jNOMEpDWjSjfnMHxwpZWqamz8V4ZPs1HZUYbmMo
 9PTQZLxc=
X-Gm-Gg: AYBFou1v8TV94za5ix1T8ns4tsmRRUXI3gNdtonA8jguVq/kMIuOay3hD5EnfrX9meA
 tZ3F0L8vHs2YD1qLBSPOw+bJ3UvC7twd0fA8Mt5eMakKhPe0cyYJoTC+ferlYohqj8BTyss9brI
 8zjkVnTq4D2CHCKLpGHWKyat9zXdyUVUAqh7uYqQrWRcA2C3pHTJw4DbdU3CiCBR0xGYbLX7Xv/
 WQIB4i+zoDQRrQfumcD5E4j/93xdJ09s5m4w8Rw+kC1vLsoqPzmb9f0C5NyyQXsfMRWs4DdTj9D
 FWiMl1AGDlOuvCdFPBN+5eZW9H8zqegx6LFAnEgqbHIhgXyvzOc3+7ty7aAXcAfhr+P4Gc7LF1M
 7FvrrkrsjVr/4jbGIFzdpT9oo2drBCWGuwy/H2Q6TlbuK8R7RDlBXr2ng/+ZpkbBKeuuK82N2kw
 /4TSbC7DP67KkDD3h+Esfh94mU+r3m/xH3ht+zbRkzBLKGsHxviFpDFtQLHDCiPbtLP6yn3xTfk
 Bi0cLpBcQ5rc4U73HrbWTN34+JngA0w/JBhzA==
X-Received: by 2002:a17:90b:3e85:b0:3ac:36c7:c144 with SMTP id
 98e67ed59e1d1-3acef2b4edamr650620a91.28.1792189930757; 
 Fri, 16 Oct 2026 15:32:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm10827348a91.7.2026.10.16.15.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 15:32:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v5 4/4] usertools: add script for wireshark capture
Date: Fri, 16 Oct 2026 15:30:34 -0700
Message-ID: <20261016223201.608942-5-stephen@networkplumber.org>
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

Provide glue executable that wireshark can use to access
telemetry based packet capture. It is a C program so that it
can be installed setuid if desired and it is standalone and
does not depend on any DPDK libraries or infrastructure.

It is dual licensed because it maybe desirable to put this
in wireshark repository later.

See https://www.wireshark.org/docs/man-pages/extcap.html

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |    3 +
 doc/guides/prog_guide/capture_lib.rst  |    8 +
 doc/guides/rel_notes/release_26_11.rst |    1 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/wireshark_extcap.rst  |  203 +++++
 usertools/dpdk-wireshark-extcap.c      | 1131 ++++++++++++++++++++++++
 usertools/meson.build                  |   23 +
 7 files changed, 1370 insertions(+)
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 usertools/dpdk-wireshark-extcap.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 843fc3a6c6..a1a053c954 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1724,6 +1724,7 @@ Packet capture
 M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
 F: lib/capture/
+F: doc/guides/prog_guide/capture_lib.rst
 F: app/test/test_capture.c
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
@@ -1735,6 +1736,8 @@ F: app/pdump/
 F: doc/guides/tools/pdump.rst
 F: app/dumpcap/
 F: doc/guides/tools/dumpcap.rst
+F: usertools/dpdk-wireshark-extcap.c
+F: doc/guides/tools/wireshark_extcap.rst
 
 
 Packet Framework
diff --git a/doc/guides/prog_guide/capture_lib.rst b/doc/guides/prog_guide/capture_lib.rst
index bafa194fd4..690f5feeb2 100644
--- a/doc/guides/prog_guide/capture_lib.rst
+++ b/doc/guides/prog_guide/capture_lib.rst
@@ -169,6 +169,14 @@ capture fails to start if the FIFO has no reader::
    --> /ethdev/capture/stop,0
    {"/ethdev/capture/stop": {"status": "stopped"}}
 
+Using Wireshark
+---------------
+
+The ``dpdk-wireshark-extcap`` program presents the ports of a running DPDK
+application as Wireshark capture interfaces, using these telemetry commands
+with a FIFO created by Wireshark as the output.
+See :doc:`../tools/wireshark_extcap`.
+
 Limitations
 -----------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0a43628aed..095e4a9903 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -267,6 +267,7 @@ New Features
 * **Added wireshark capture support.**
 
   * New ``capture`` library for packet capture accessed via telemetry API.
+  * Added ``dpdk-wireshark-extcap`` for wireshark external capture integration.
 
 
 Removed Items
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index c6a145a9fe..dccf9a7daa 100644
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
index 0000000000..2af7bf094d
--- /dev/null
+++ b/doc/guides/tools/wireshark_extcap.rst
@@ -0,0 +1,203 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+Wireshark Extcap Plugin
+=======================
+
+The ``dpdk-wireshark-extcap`` program is an external capture (extcap)
+plugin that enables Wireshark capture of live traffic from
+the Ethernet ports of a DPDK application.
+Each DPDK port appears as a capture interface in the Wireshark interface list,
+alongside the host's own network interfaces.
+
+The plugin uses the DPDK telemetry API to query and start capture.
+The work is done by the :doc:`capture library <../prog_guide/capture_lib>`
+in the application.
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
+* A DPDK application built with the
+  :doc:`capture library <../prog_guide/capture_lib>` and with telemetry
+  enabled. Telemetry is enabled by default.
+
+* Since the plugin is started by Wireshark, Wireshark must be able to reach
+  the telemetry socket of the DPDK application. See `Permissions`_.
+
+The plugin is a standalone C program that speaks the telemetry protocol
+directly and links against nothing from DPDK. It is built and installed with
+the other DPDK tools, except on Windows. Building with ``libcap`` allows the
+capability install described under `Permissions`_.
+
+
+Installation
+------------
+
+For Wireshark to discover the plugin it must be present in an extcap
+directory. The configured locations are listed in Wireshark under
+*Help > About Wireshark > Folders*. Symbolically link the program into the
+personal extcap directory, naming it ``dpdkdump`` to match the convention of
+the other programs there::
+
+    ln -s /usr/local/bin/dpdk-wireshark-extcap \
+        ~/.local/lib/wireshark/extcap/dpdkdump
+
+Or from a build tree::
+
+    ln -s $(pwd)/build/usertools/dpdk-wireshark-extcap \
+        ~/.local/lib/wireshark/extcap/dpdkdump
+
+The DPDK ports then appear in the interface list the next time the capture
+options dialog is opened.
+
+
+Permissions
+-----------
+
+The DPDK runtime directory is created mode ``0700``, so only the user that
+started the DPDK application can reach its telemetry socket. No privilege
+beyond access to that socket is required: if you can run ``dpdk-dumpcap``
+against an application, you can capture from it with this plugin.
+
+Running Wireshark as that same user needs nothing more, and a DPDK
+application need not run as root. A containerized one has its own runtime
+directory, which can be made readable by the Wireshark user. Run as a
+different user the interface list is empty, and ``--extcap-interfaces``
+prints the permission failure to standard error.
+
+The rest of this section applies only to capturing from a root application as
+an ordinary user. Install set-user-ID to the user running the application,
+root here, and restrict who may execute it::
+
+    chown root:wireshark dpdk-wireshark-extcap
+    chmod 4750 dpdk-wireshark-extcap
+
+Set-group-ID is not enough: the runtime directory is mode ``0700``, so the
+group bits grant nothing. This is unlike ``dumpcap``, which is set-group-ID
+because the ``/dev/bpf`` devices it needs are group accessible.
+
+On Linux a capability grants less and is preferred where available::
+
+    chown root:wireshark dpdk-wireshark-extcap
+    chmod 0750 dpdk-wireshark-extcap
+    setcap cap_dac_override+ep dpdk-wireshark-extcap
+
+This needs a build with ``libcap``; without it a file capability cannot be
+dropped and the plugin refuses to run. ``cap_dac_override`` rather than
+``cap_dac_read_search`` because connecting to the socket needs write
+permission. FreeBSD has no file capabilities, so set-user-ID is the only
+option there.
+
+Whoever runs Wireshark must be in the group named above, or the plugin cannot
+be executed and no DPDK interfaces appear. Link the extcap entry to the
+installed program; copying does not preserve set-user-ID or capabilities.
+
+Privilege is used only for the connect, then dropped permanently before the
+banner is read, before any reply is parsed, and before the FIFO is opened.
+The drop is verified and privilege is never raised again, following
+``dumpcap``. Nothing after the connect needs privilege, so unlike ``dumpcap``
+none is retained.
+
+After a privileged start the plugin is more restrictive: the environment is
+ignored, only ``/var/run/dpdk`` is searched, and the output must be a FIFO.
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
+    $ dpdk-wireshark-extcap --extcap-interfaces
+    extcap {version=0.1}{display=DPDK telemetry capture}
+    interface {value=dpdk:0}{display=DPDK net_tap0}
+
+When no interfaces are listed the reason is printed to standard error, which
+the Wireshark GUI does not show. ``--help`` lists the options.
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
+    are bounded to the port's configured queue count. If the queue count
+    cannot be read the option is omitted and capture uses all queues.
+
+Capture filter
+    A libpcap filter expression, applied by the DPDK application to the
+    captured traffic.
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
+The runtime directory location depends on the user the DPDK application runs
+as, not on who runs the plugin, so both are searched: ``/var/run/dpdk`` for an
+application started by root, and ``$XDG_RUNTIME_DIR/dpdk``, or ``/tmp/dpdk``
+if that is unset, for one started by an ordinary user. Ports found in either
+are listed together.
+
+``DPDK_EXTCAP_PATH``
+    Search this base directory instead, for a runtime directory in a
+    non-standard location. Ignored, along with ``XDG_RUNTIME_DIR``, after a
+    privileged start; see `Permissions`_.
+
+
+Troubleshooting
+---------------
+
+The DPDK ports do not appear in Wireshark
+    Confirm the application is running and was built with the capture library
+    and telemetry. Confirm Wireshark runs as the same user as the application,
+    or that the plugin is installed with privilege; see `Permissions`_. An
+    application started with a non-default ``--file-prefix`` is listed with
+    its ports qualified as ``DPDK <name>@<prefix>``; see
+    `Selecting a DPDK application`_.
+
+    Running ``--extcap-interfaces`` by hand prints diagnostics to standard
+    error that the Wireshark GUI hides.
+
+A port is listed as ``portN`` instead of a device name
+    The port was reported but its details could not be read, usually because
+    the application stopped in between. A capture against it will fail;
+    restart the application.
diff --git a/usertools/dpdk-wireshark-extcap.c b/usertools/dpdk-wireshark-extcap.c
new file mode 100644
index 0000000000..69a3f70234
--- /dev/null
+++ b/usertools/dpdk-wireshark-extcap.c
@@ -0,0 +1,1131 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-or-later
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Wireshark extcap plugin for live capture from DPDK ethdev ports.
+ *
+ * Wireshark creates a FIFO, this program opens it and passes the path to the
+ * DPDK application as out= in /ethdev/capture/start. The application writes
+ * pcapng straight into the FIFO; packet data never passes through here.
+ * Capture stops when the read end closes or on SIGINT/SIGTERM, then
+ * /ethdev/capture/stop is sent so the application can flush.
+ *
+ * Interface values are 'dpdk:<port>' for the default file-prefix and
+ * 'dpdk:<prefix>:<port>' otherwise.
+ *
+ * May be installed with elevated privilege to reach the runtime directory of
+ * an application running as another user. Privilege is used only to connect
+ * to the telemetry socket and is dropped permanently after that; see
+ * doc/guides/tools/wireshark_extcap.rst.
+ *
+ * The runtime directory location depends on the user the application runs as,
+ * not on who runs this, so every candidate is searched; see dpdk_dirs().
+ *
+ * Build:
+ *   cc -O2 -Wall -Wextra -D_FORTIFY_SOURCE=2 -fstack-protector-strong \
+ *      -fPIE -pie -Wl,-z,relro,-z,now -o dpdk-wireshark-extcap \
+ *      dpdk-wireshark-extcap.c
+ */
+
+/* The DPDK build passes this; keep the standalone build above working too. */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <dirent.h>
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#ifdef __linux__
+#include <sys/auxv.h>
+#endif
+#ifdef HAVE_LIBCAP
+#include <sys/capability.h>
+#endif
+
+#define PROG_NAME		"dpdk-wireshark-extcap"
+#define EXTCAP_VERSION		"0.1"
+#define TELEMETRY_SOCKET	"dpdk_telemetry.v2"
+#define CAPTURE_START_CMD	"/ethdev/capture/start"
+#define CAPTURE_STOP_CMD	"/ethdev/capture/stop"
+#define ETHDEV_LIST		"/ethdev/list"
+#define ETHDEV_INFO		"/ethdev/info"
+#define DEFAULT_SNAPLEN		262144
+#define DEFAULT_PREFIX		"rte"
+#define DLT_EN10MB		1
+
+#define SECURE_DIR		"/var/run/dpdk"
+#define ARRAY_SIZE(a)		((int)(sizeof(a) / sizeof((a)[0])))
+#define MAX_PREFIXES		64
+#define PREFIX_MAX		64
+#define MAX_PORTS		256
+#define MAX_QUEUES		1024
+#define PARAMS_MAX		1024	/* primary limit (CAP_CMD_MAX) */
+#define CMD_BUF			(PARAMS_MAX + 128)
+#define REPLY_TIMEOUT_SEC	30
+#define MIN_REPLY_LEN		1024
+#define MAX_REPLY_LEN		(1 << 20)
+
+/* One connected primary. */
+struct source {
+	char prefix[PREFIX_MAX];
+	int fd;
+};
+
+static uid_t ruid, euid;
+static gid_t rgid, egid;
+static bool privileged_exec;
+
+/* --- privilege handling -------------------------------------------- */
+
+/*
+ * True when the kernel raised our privilege at exec: setuid, setgid or file
+ * capabilities. This is the same test the C library uses to decide whether to
+ * trust the environment. dumpcap compares uids instead, which misses the
+ * capability-only install where ruid == euid throughout, and counts a plain
+ * root invocation as privileged, which this does not.
+ */
+static bool
+exec_was_privileged(void)
+{
+#if defined(__linux__)
+	return getauxval(AT_SECURE) != 0;
+#elif defined(__FreeBSD__)
+	return issetugid();
+#else
+	return getuid() != geteuid() || getgid() != getegid();
+#endif
+}
+
+static void
+priv_init(void)
+{
+	ruid = getuid();
+	rgid = getgid();
+	euid = geteuid();
+	egid = getegid();
+	privileged_exec = exec_was_privileged();
+}
+
+/*
+ * Give up privilege permanently, then prove it cannot be taken back.
+ *
+ * Effective uid goes last: changing it is what takes away the right to change
+ * anything else. Capabilities are cleared whether or not this process has any,
+ * as in dumpcap's relinquish_all_capabilities().
+ */
+static void
+priv_drop(void)
+{
+	if (setresgid(rgid, rgid, rgid) != 0)
+		err(1, "setresgid");
+	if (setresuid(ruid, ruid, ruid) != 0)
+		err(1, "setresuid");
+
+	if (getuid() != ruid || geteuid() != ruid ||
+	    getgid() != rgid || getegid() != rgid)
+		errx(1, "privilege drop failed");
+	if (euid != ruid && seteuid(euid) == 0)
+		errx(1, "privilege drop failed");
+	if (egid != rgid && setegid(egid) == 0)
+		errx(1, "privilege drop failed");
+
+#ifdef HAVE_LIBCAP
+	/* A file-capability install changes no id above, so this is the drop. */
+	cap_t caps = cap_init();	/* all capabilities off */
+
+	if (caps == NULL)
+		err(1, "cap_init");
+	if (cap_set_proc(caps) != 0)
+		err(1, "cap_set_proc");
+	cap_free(caps);
+#else
+	if (privileged_exec && ruid == euid && rgid == egid)
+		errx(1, "built without libcap, cannot drop a file capability");
+#endif
+}
+
+/* Make sure fds 0-2 are open so later opens cannot land on them. */
+static void
+std_fds(void)
+{
+	for (int fd = 0; fd <= 2; fd++) {
+		if (fcntl(fd, F_GETFD) < 0 && errno == EBADF) {
+			int n = open("/dev/null", O_RDWR);
+
+			if (n != fd)
+				_exit(1);
+		}
+	}
+}
+
+/* --- minimal JSON scanner ------------------------------------------ */
+
+static const char *
+skip_ws(const char *p)
+{
+	while (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r')
+		p++;
+	return p;
+}
+
+/* Return pointer to the value following "key": or NULL. */
+static const char *
+json_value(const char *json, const char *key)
+{
+	char pat[96];
+	const char *p = json;
+	int n = snprintf(pat, sizeof(pat), "\"%s\"", key);
+
+	if (n < 0 || (size_t)n >= sizeof(pat))
+		return NULL;
+
+	while ((p = strstr(p, pat)) != NULL) {
+		const char *v = skip_ws(p + n);
+
+		if (*v == ':')
+			return skip_ws(v + 1);
+		p += n;
+	}
+	return NULL;
+}
+
+static bool
+json_int(const char *json, const char *key, long long *val)
+{
+	const char *v = json_value(json, key);
+	char *end;
+	long long x;
+
+	if (v == NULL || !((*v >= '0' && *v <= '9') || *v == '-'))
+		return false;
+	errno = 0;
+	x = strtoll(v, &end, 10);
+	if (errno != 0 || end == v)
+		return false;
+	*val = x;
+	return true;
+}
+
+/* Copy a string value, replacing non printable characters with '_'. */
+static bool
+json_str(const char *json, const char *key, char *out, size_t outsz)
+{
+	const char *v = json_value(json, key);
+	size_t n = 0;
+
+	if (v == NULL || *v != '"')
+		return false;
+	for (v++; *v != '"'; v++) {
+		unsigned char c = *v;
+
+		if (c == '\0')
+			return false;
+		if (c == '\\') {
+			c = '_';
+			if (v[1] == '\0')
+				return false;
+			v++;
+		}
+		if (c < 0x20 || c > 0x7e)
+			c = '_';
+		if (n + 1 < outsz)
+			out[n++] = c;
+	}
+	out[n] = '\0';
+	return true;
+}
+
+static int
+json_int_array(const char *json, const char *key, long long *out, int max)
+{
+	const char *v = json_value(json, key);
+	int n = 0;
+
+	if (v == NULL || *v != '[')
+		return 0;
+	v = skip_ws(v + 1);
+	while (*v != '\0' && *v != ']') {
+		char *end;
+		long long x;
+
+		errno = 0;
+		x = strtoll(v, &end, 10);
+		if (end == v || errno != 0)
+			break;
+		if (n < max)
+			out[n++] = x;
+		v = skip_ws(end);
+		if (*v != ',')
+			break;
+		v = skip_ws(v + 1);
+	}
+	return n;
+}
+
+/* Names go into extcap sentences, keep them to a safe alphabet. */
+static void
+sanitize_label(char *s)
+{
+	for (; *s != '\0'; s++) {
+		char c = *s;
+
+		if (!((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
+		      (c >= '0' && c <= '9') || c == '.' || c == '_' ||
+		      c == ':' || c == '-'))
+			*s = '_';
+	}
+}
+
+/*
+ * Why this string cannot be handed to the primary, or NULL if it can.
+ * Telemetry parameters are a comma separated list with no escaping.
+ */
+static const char *
+param_problem(const char *s)
+{
+	if (strchr(s, ',') != NULL)
+		return "must not contain a comma";
+
+	for (; *s != '\0'; s++) {
+		if ((unsigned char)*s < 0x20 || *s == 0x7f)
+			return "must not contain control characters";
+	}
+	return NULL;
+}
+
+/* --- DPDK runtime directory / socket discovery ---------------------- */
+
+static char dirbuf[PATH_MAX];
+
+/*
+ * Directories that may hold the per-prefix runtime subdirectories.
+ *
+ * Where the primary put them depends on the user it runs as, not on the user
+ * running this program: a root primary uses /var/run/dpdk whether or not the
+ * capture tool is root. So rather than guess from our own uid, return every
+ * candidate and let the caller look in each.
+ *
+ * DPDK_EXTCAP_PATH overrides the search. It is ignored after a privileged
+ * exec, where the environment is not trusted.
+ */
+static int
+dpdk_dirs(const char *dirs[], int max)
+{
+	const char *env, *xdg;
+	int n = 0;
+
+	if (!privileged_exec) {
+		env = getenv("DPDK_EXTCAP_PATH");
+		if (env != NULL && *env != '\0') {
+			dirs[n++] = env;
+			return n;
+		}
+	}
+
+	/* where a root primary puts it */
+	if (n < max)
+		dirs[n++] = SECURE_DIR;
+
+	/* where a primary running as an ordinary user puts it */
+	if (!privileged_exec) {
+		xdg = getenv("XDG_RUNTIME_DIR");
+		if (xdg == NULL || *xdg == '\0')
+			xdg = "/tmp";
+		if ((size_t)snprintf(dirbuf, sizeof(dirbuf), "%s/dpdk", xdg) >= sizeof(dirbuf))
+			errx(1, "runtime directory path too long");
+		if (n < max)
+			dirs[n++] = dirbuf;
+	}
+
+	return n;
+}
+
+static bool
+valid_prefix(const char *s)
+{
+	size_t len = strlen(s);
+
+	if (len == 0 || len >= PREFIX_MAX)
+		return false;
+	if (strcmp(s, ".") == 0 || strcmp(s, "..") == 0)
+		return false;
+	for (; *s != '\0'; s++) {
+		char c = *s;
+
+		if (!((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
+		      (c >= '0' && c <= '9') || c == '.' || c == '_' || c == '-'))
+			return false;
+	}
+	return true;
+}
+
+static void
+socket_path(const char *dir, const char *prefix, char *out, size_t sz)
+{
+	if ((size_t)snprintf(out, sz, "%s/%s/%s", dir, prefix,
+			     TELEMETRY_SOCKET) >= sz)
+		errx(1, "socket path too long");
+}
+
+/* --- telemetry transport -------------------------------------------- */
+
+struct telemetry {
+	int fd;
+	size_t max_len;
+	char *buf;	/* last reply, always NUL terminated */
+};
+
+/*
+ * Connect to a telemetry socket. This is the only call that needs privilege,
+ * so it is also the only thing done before priv_drop().
+ */
+static int
+tel_connect(const char *path)
+{
+	struct sockaddr_un sa;
+	size_t len = strlen(path);
+	int fd, save;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sun_family = AF_UNIX;
+	if (len >= sizeof(sa.sun_path)) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	memcpy(sa.sun_path, path, len);
+
+	fd = socket(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		save = errno;
+		close(fd);
+		errno = save;
+		return -1;
+	}
+	return fd;
+}
+
+/*
+ * Read the banner and size the reply buffer. Runs unprivileged: this is the
+ * first point at which the primary gets to send us anything. Takes ownership
+ * of fd and closes it on failure.
+ */
+static int
+tel_handshake(struct telemetry *t, int fd)
+{
+	struct timeval tv = { .tv_sec = REPLY_TIMEOUT_SEC };
+	char banner[1025];
+	long long maxlen;
+	ssize_t n;
+	int save;
+
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+
+	do {
+		n = recv(fd, banner, sizeof(banner) - 1, 0);
+	} while (n < 0 && errno == EINTR);
+	if (n <= 0) {
+		save = n < 0 ? errno : ECONNRESET;
+		close(fd);
+		errno = save;
+		return -1;
+	}
+	banner[n] = '\0';
+
+	if (!json_int(banner, "max_output_len", &maxlen))
+		maxlen = 16384;
+	if (maxlen < MIN_REPLY_LEN)
+		maxlen = MIN_REPLY_LEN;
+	if (maxlen > MAX_REPLY_LEN)
+		maxlen = MAX_REPLY_LEN;
+
+	t->buf = malloc(maxlen + 1);
+	if (t->buf == NULL) {
+		close(fd);
+		errno = ENOMEM;
+		return -1;
+	}
+	t->fd = fd;
+	t->max_len = maxlen;
+	return 0;
+}
+
+/* Send a command; reply lands in t->buf (empty string if no reply). */
+static int
+tel_command(struct telemetry *t, const char *cmd)
+{
+	size_t len = strlen(cmd);
+	ssize_t n;
+
+	do {
+		n = send(t->fd, cmd, len, 0);
+	} while (n < 0 && errno == EINTR);
+	if (n < 0)
+		return -1;
+
+	do {
+		n = recv(t->fd, t->buf, t->max_len, 0);
+	} while (n < 0 && errno == EINTR);
+	if (n < 0)
+		return -1;
+	t->buf[n] = '\0';
+	return 0;
+}
+
+static void
+tel_close(struct telemetry *t)
+{
+	close(t->fd);
+	free(t->buf);
+	t->buf = NULL;
+}
+
+static long
+port_queue_count(struct telemetry *t, long port)
+{
+	char cmd[64];
+	long long rx = 0, tx = 0;
+
+	snprintf(cmd, sizeof(cmd), ETHDEV_INFO ",%ld", port);
+	if (tel_command(t, cmd) < 0)
+		return 0;
+	json_int(t->buf, "nb_rx_queues", &rx);
+	json_int(t->buf, "nb_tx_queues", &tx);
+	return rx > tx ? (long)rx : (long)tx;
+}
+
+/* Device name via /ethdev/info, or "port<N>" if unreadable. */
+static void
+port_name(struct telemetry *t, long port, char *out, size_t sz)
+{
+	char cmd[64];
+
+	snprintf(cmd, sizeof(cmd), ETHDEV_INFO ",%ld", port);
+	if (tel_command(t, cmd) < 0 || !json_str(t->buf, "name", out, sz) ||
+	    out[0] == '\0')
+		snprintf(out, sz, "port%ld", port);
+	sanitize_label(out);
+}
+
+/* --- interface naming ---------------------------------------------- */
+
+static void
+iface_value(const char *prefix, long port, char *out, size_t sz)
+{
+	if (strcmp(prefix, DEFAULT_PREFIX) == 0)
+		snprintf(out, sz, "dpdk:%ld", port);
+	else
+		snprintf(out, sz, "dpdk:%.*s:%ld", PREFIX_MAX - 1, prefix, port);
+}
+
+/* Inverse of iface_value. */
+static void
+parse_iface(const char *iface, char *prefix, size_t prefix_sz, long *port)
+{
+	const char *p, *c1, *c2, *num;
+	char *end;
+	unsigned long v;
+
+	c1 = strchr(iface, ':');
+	if (c1 == NULL || (size_t)(c1 - iface) != 4 || strncmp(iface, "dpdk", 4) != 0)
+		errx(1, "unsupported interface scheme in '%s'", iface);
+
+	p = c1 + 1;
+	c2 = strchr(p, ':');
+	if (c2 == NULL) {
+		snprintf(prefix, prefix_sz, "%s", DEFAULT_PREFIX);
+		num = p;
+	} else {
+		size_t len = c2 - p;
+
+		if (strchr(c2 + 1, ':') != NULL)
+			errx(1, "malformed interface '%s'", iface);
+		if (len == 0 || len >= prefix_sz)
+			errx(1, "malformed interface '%s'", iface);
+		memcpy(prefix, p, len);
+		prefix[len] = '\0';
+		num = c2 + 1;
+	}
+
+	if (!valid_prefix(prefix))
+		errx(1, "malformed interface '%s'", iface);
+	if (!(*num >= '0' && *num <= '9'))
+		errx(1, "malformed interface '%s'", iface);
+	errno = 0;
+	v = strtoul(num, &end, 10);
+	if (errno != 0 || *end != '\0' || v > UINT16_MAX)
+		errx(1, "malformed interface '%s'", iface);
+	*port = v;
+}
+
+/* --- privileged phase ----------------------------------------------- */
+
+static int
+cmp_source(const void *a, const void *b)
+{
+	const struct source *x = a, *y = b;
+
+	return strcmp(x->prefix, y->prefix);
+}
+
+/*
+ * Connect to every primary under the runtime directory.
+ *
+ * All of it happens before the drop, as dumpcap opens all of its capture
+ * devices before relinquishing. Nothing is read from these sockets here.
+ */
+static int
+connect_dir(const char *root, struct source *src, int n, int max, bool *looked,
+	    bool *complained)
+{
+	struct dirent *de;
+	DIR *d;
+
+	d = opendir(root);
+	if (d == NULL) {
+		/*
+		 * A directory that is simply not there is not worth a word: the
+		 * other candidate is probably the live one. Anything else means
+		 * a primary is likely there but out of reach, which is worth
+		 * saying even if another directory works out.
+		 */
+		if (errno == EACCES) {
+			*looked = true;
+			*complained = true;
+			warnx("cannot read %s: permission denied. The DPDK runtime "
+			      "directory is created mode 0700, so capture must run "
+			      "as the same user as the DPDK application, or be "
+			      "installed with privilege", root);
+		} else if (errno != ENOENT) {
+			*looked = true;
+			*complained = true;
+			warn("cannot read %s", root);
+		}
+		return n;
+	}
+	*looked = true;
+
+	while (n < max && (de = readdir(d)) != NULL) {
+		char path[PATH_MAX];
+		struct stat st;
+		int fd;
+
+		if (!valid_prefix(de->d_name))
+			continue;
+		socket_path(root, de->d_name, path, sizeof(path));
+		if (lstat(path, &st) != 0 || !S_ISSOCK(st.st_mode))
+			continue;
+
+		fd = tel_connect(path);
+		if (fd < 0) {
+			warn("cannot connect to %s", path);
+			continue;
+		}
+		/* valid_prefix() bounded the length */
+		memcpy(src[n].prefix, de->d_name, strlen(de->d_name) + 1);
+		src[n].fd = fd;
+		n++;
+	}
+	closedir(d);
+
+	return n;
+}
+
+/*
+ * Connect to one named prefix, trying each candidate directory. The path tried
+ * last is left in out[] for the caller's error message.
+ */
+static int
+connect_prefix(const char *prefix, char *out, size_t outsz)
+{
+	const char *dirs[4];
+	int ndirs = dpdk_dirs(dirs, ARRAY_SIZE(dirs));
+
+	for (int i = 0; i < ndirs; i++) {
+		int fd;
+
+		socket_path(dirs[i], prefix, out, outsz);
+		fd = tel_connect(out);
+		if (fd >= 0)
+			return fd;
+	}
+	return -1;
+}
+
+static int
+connect_all(struct source *src, int max)
+{
+	const char *dirs[4];
+	bool looked = false, complained = false;
+	int ndirs, n = 0;
+
+	ndirs = dpdk_dirs(dirs, ARRAY_SIZE(dirs));
+	for (int i = 0; i < ndirs && n < max; i++)
+		n = connect_dir(dirs[i], src, n, max, &looked, &complained);
+
+	/* a reason was already given for an unreadable directory */
+	if (n == 0 && !complained) {
+		if (looked)
+			warnx("no DPDK telemetry socket found. Is a DPDK "
+			      "application running with telemetry enabled?");
+		else
+			warnx("no DPDK runtime directory. Either no DPDK "
+			      "application is running, or it runs as a different "
+			      "user and this program was installed without privilege");
+	}
+
+	qsort(src, n, sizeof(*src), cmp_source);
+	return n;
+}
+
+/* --- extcap query operations --------------------------------------- */
+
+static void
+cmd_interfaces(struct source *src, int nsrc)
+{
+	printf("extcap {version=%s}{display=DPDK telemetry capture}\n", EXTCAP_VERSION);
+
+	for (int i = 0; i < nsrc; i++) {
+		long long ports[MAX_PORTS];
+		struct telemetry t;
+		int nports = 0;
+
+		if (tel_handshake(&t, src[i].fd) < 0) {
+			warn("no banner from %s", src[i].prefix);
+			continue;
+		}
+
+		if (tel_command(&t, ETHDEV_LIST) == 0)
+			nports = json_int_array(t.buf, ETHDEV_LIST, ports, MAX_PORTS);
+		else
+			warn("cannot query %s", src[i].prefix);
+
+		for (int j = 0; j < nports; j++) {
+			char name[128], value[160], display[256];
+
+			if (ports[j] < 0 || ports[j] > UINT16_MAX)
+				continue;
+			port_name(&t, ports[j], name, sizeof(name));
+			iface_value(src[i].prefix, ports[j], value, sizeof(value));
+			if (strcmp(src[i].prefix, DEFAULT_PREFIX) == 0)
+				snprintf(display, sizeof(display), "DPDK %.127s", name);
+			else
+				snprintf(display, sizeof(display), "DPDK %.127s@%.63s",
+					 name, src[i].prefix);
+			printf("interface {value=%s}{display=%s}\n", value, display);
+		}
+		tel_close(&t);
+	}
+}
+
+static void
+cmd_dlts(void)
+{
+	printf("dlt {number=%d}{name=EN10MB}{display=Ethernet}\n", DLT_EN10MB);
+}
+
+static void
+cmd_config(int fd, long port)
+{
+	long nqueues = 0;
+
+	printf("arg {number=0}{call=--snaplen}{display=Snapshot length}"
+	       "{tooltip=Bytes captured per packet (0 = whole packet)}"
+	       "{type=integer}{range=0,%d}{default=%d}{group=Capture}\n",
+	       DEFAULT_SNAPLEN, DEFAULT_SNAPLEN);
+
+	/*
+	 * Bound the queue dropdown to the port's queue count. If the primary
+	 * is unreachable just omit it, capture defaults to all queues.
+	 */
+	if (fd >= 0) {
+		struct telemetry t;
+
+		if (tel_handshake(&t, fd) == 0) {
+			nqueues = port_queue_count(&t, port);
+			tel_close(&t);
+		}
+	}
+
+	if (nqueues > MAX_QUEUES)
+		nqueues = MAX_QUEUES;
+	if (nqueues > 0) {
+		printf("arg {number=1}{call=--queue}{display=Queue}"
+		       "{tooltip=Capture a single hardware queue}"
+		       "{type=selector}{group=Capture}\n");
+		printf("value {arg=1}{value=-1}{display=All queues}{default=true}\n");
+		for (long q = 0; q < nqueues; q++)
+			printf("value {arg=1}{value=%ld}{display=Queue %ld}\n", q, q);
+	}
+}
+
+/* --- capture -------------------------------------------------------- */
+
+static void
+cmd_append(char *cmd, const char *fmt, ...)
+	__attribute__((format(printf, 2, 3)));
+
+static void
+cmd_append(char *cmd, const char *fmt, ...)
+{
+	size_t len = strlen(cmd);
+	va_list ap;
+	int n;
+
+	va_start(ap, fmt);
+	n = vsnprintf(cmd + len, CMD_BUF - len, fmt, ap);
+	va_end(ap);
+	if (n < 0 || (size_t)n >= CMD_BUF - len)
+		errx(1, "capture parameters too long");
+}
+
+static int stop_pipe[2] = { -1, -1 };
+
+static void
+on_stop_signal(int sig)
+{
+	int saved = errno;
+	ssize_t r;
+
+	(void)sig;
+	r = write(stop_pipe[1], "x", 1);
+	(void)r;
+	errno = saved;
+}
+
+/*
+ * Block until Wireshark stops us: it closes the FIFO read end (error/hangup
+ * on our write fd) or sends SIGINT/SIGTERM. Handlers are restored before
+ * returning so a second signal terminates us the usual way.
+ */
+static void
+wait_for_stop(int fifo_fd)
+{
+	struct sigaction sa, old_int, old_term;
+	struct pollfd pfd[2];
+
+	if (pipe2(stop_pipe, O_CLOEXEC | O_NONBLOCK) != 0)
+		err(1, "pipe2");
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = on_stop_signal;
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGINT, &sa, &old_int);
+	sigaction(SIGTERM, &sa, &old_term);
+
+	pfd[0].fd = fifo_fd;
+	pfd[0].events = POLLERR;
+	pfd[1].fd = stop_pipe[0];
+	pfd[1].events = POLLIN;
+	for (;;) {
+		int r = poll(pfd, 2, -1);
+
+		if (r > 0 || (r < 0 && errno != EINTR))
+			break;
+	}
+
+	sigaction(SIGINT, &old_int, NULL);
+	sigaction(SIGTERM, &old_term, NULL);
+	close(stop_pipe[0]);
+	close(stop_pipe[1]);
+}
+
+static void
+cmd_capture(int fd, long port, const char *fifo, long snaplen, long queue,
+	    const char *cfilter)
+{
+	char cmd[CMD_BUF];
+	char errmsg[256];
+	struct telemetry t;
+	struct stat sb;
+	long long cap_id;
+	int fifo_fd;
+
+	snprintf(cmd, sizeof(cmd), CAPTURE_START_CMD ",%ld,out=%s", port, fifo);
+	if (snaplen >= 0)
+		cmd_append(cmd, ",snaplen=%ld", snaplen);
+	if (queue >= 0)
+		cmd_append(cmd, ",queue=%ld", queue);
+	if (cfilter != NULL && *cfilter != '\0')
+		cmd_append(cmd, ",filter=%s", cfilter);
+	if (strlen(cmd) - sizeof(CAPTURE_START_CMD) >= PARAMS_MAX)
+		errx(1, "capture parameters too long");
+
+	/*
+	 * Blocking open of the FIFO Wireshark created, unprivileged, which is
+	 * where dumpcap opens its output too.
+	 *
+	 * Rendezvous: a reader is attached before the primary opens the write
+	 * end (it uses O_NONBLOCK and fails with ENXIO without a reader). We
+	 * hold this fd for the whole session: it keeps the pipe from EOF-ing
+	 * before the primary has its own write end, and it is the reliable stop
+	 * signal (error here means Wireshark closed the read end).
+	 */
+	fifo_fd = open(fifo, O_WRONLY | O_CLOEXEC | O_NOFOLLOW);
+	if (fifo_fd < 0)
+		err(1, "cannot open fifo %s", fifo);
+	if (fstat(fifo_fd, &sb) != 0 || !S_ISFIFO(sb.st_mode))
+		errx(1, "%s is not a fifo", fifo);
+
+	if (tel_handshake(&t, fd) < 0)
+		err(1, "no banner from DPDK telemetry");
+
+	if (tel_command(&t, cmd) < 0)
+		err(1, "capture start failed");
+
+	if (json_str(t.buf, "error", errmsg, sizeof(errmsg)))
+		errx(1, "capture start failed: %s", errmsg);
+	if (!json_int(t.buf, "id", &cap_id) || cap_id < 0)
+		errx(1, "capture start failed: unexpected reply from primary");
+
+	/*
+	 * Run until Wireshark stops us. The primary holds its own write end,
+	 * so closing ours below does not EOF the reader prematurely.
+	 */
+	wait_for_stop(fifo_fd);
+
+	/*
+	 * Ask the primary to stop while we still hold the write end, so a
+	 * still attached reader gets the tail and the statistics block before
+	 * the final EOF. If the read end is gone the primary already stopped
+	 * on the same hangup and this is a no-op.
+	 */
+	snprintf(cmd, sizeof(cmd), CAPTURE_STOP_CMD ",%lld", cap_id);
+	tel_command(&t, cmd);
+
+	close(fifo_fd);
+	tel_close(&t);
+}
+
+/* --- entry point ---------------------------------------------------- */
+
+struct options {
+	bool interfaces, dlts, config, capture, version, help;
+	const char *iface, *fifo, *cfilter;
+	long snaplen, queue;
+};
+
+static void
+usage(FILE *f)
+{
+	fprintf(f,
+		"Usage: %s [options]\n"
+		"\n"
+		"Wireshark external capture (extcap) plugin for DPDK ports.\n"
+		"Normally run by Wireshark, not by hand.\n"
+		"\n"
+		"Extcap operations:\n"
+		"  --extcap-interfaces          list the ports of every running DPDK application\n"
+		"  --extcap-dlts                list link types of an interface\n"
+		"  --extcap-config              list capture options of an interface\n"
+		"  --capture                    start a capture, needs --fifo\n"
+		"  --extcap-version[=<ver>]     version of the calling Wireshark\n"
+		"  --extcap-interface <iface>   interface to act on, as listed above\n"
+		"\n"
+		"Capture options:\n"
+		"  --fifo <path>                where to write pcapng, created by Wireshark\n"
+		"  --extcap-capture-filter <f>  pcap filter expression\n"
+		"  --snaplen <n>                bytes to capture per packet, 0 for all\n"
+		"  --queue <n>                  capture one queue, -1 for all\n"
+		"\n"
+		"  -h, --help                   this text\n"
+		"  --version                    program version\n"
+		"\n"
+		"Environment:\n"
+		"  DPDK_EXTCAP_PATH             base DPDK runtime directory to search\n"
+		"                               (ignored if installed with privilege)\n",
+		PROG_NAME);
+}
+
+/* Match --name, --name=value or --name value. Returns 1 on match. */
+static int
+opt_value(int argc, char **argv, int *i, const char *name, const char **val,
+	  bool optional)
+{
+	const char *a = argv[*i];
+	size_t len = strlen(name);
+
+	if (strncmp(a, name, len) != 0)
+		return 0;
+	if (a[len] == '=') {
+		*val = a + len + 1;
+		return 1;
+	}
+	if (a[len] != '\0')
+		return 0;
+	if (*i + 1 < argc && (!optional || argv[*i + 1][0] != '-')) {
+		*val = argv[++*i];
+		return 1;
+	}
+	if (optional) {
+		*val = NULL;
+		return 1;
+	}
+	errx(1, "%s requires a value", name);
+}
+
+static long
+parse_long(const char *name, const char *s, long lo, long hi)
+{
+	char *end;
+	long v;
+
+	errno = 0;
+	v = strtol(s, &end, 10);
+	if (errno != 0 || end == s || *end != '\0' || v < lo || v > hi)
+		errx(1, "invalid %s '%s'", name, s);
+	return v;
+}
+
+static void
+parse_args(int argc, char **argv, struct options *o)
+{
+	const char *val;
+
+	memset(o, 0, sizeof(*o));
+	o->snaplen = -1;
+	o->queue = -1;
+
+	/* Unknown options are ignored, Wireshark passes several extras. */
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0)
+			o->help = true;
+		else if (strcmp(argv[i], "--version") == 0)
+			o->version = true;
+		else if (strcmp(argv[i], "--extcap-interfaces") == 0)
+			o->interfaces = true;
+		else if (strcmp(argv[i], "--extcap-dlts") == 0)
+			o->dlts = true;
+		else if (strcmp(argv[i], "--extcap-config") == 0)
+			o->config = true;
+		else if (strcmp(argv[i], "--capture") == 0)
+			o->capture = true;
+		else if (opt_value(argc, argv, &i, "--extcap-interface", &val, false))
+			o->iface = val;
+		else if (opt_value(argc, argv, &i, "--fifo", &val, false))
+			o->fifo = val;
+		else if (opt_value(argc, argv, &i, "--extcap-capture-filter", &val, false))
+			o->cfilter = val;
+		else if (opt_value(argc, argv, &i, "--extcap-version", &val, true))
+			continue;
+		else if (opt_value(argc, argv, &i, "--snaplen", &val, false))
+			o->snaplen = parse_long("--snaplen", val, 0, INT32_MAX);
+		else if (opt_value(argc, argv, &i, "--queue", &val, false))
+			o->queue = parse_long("--queue", val, -1, UINT16_MAX);
+	}
+}
+
+int
+main(int argc, char **argv)
+{
+	struct source src[MAX_PREFIXES];
+	struct options o;
+	const char *why;
+	long port = -1;
+	int nsrc = 0;
+
+	std_fds();
+	priv_init();
+	signal(SIGPIPE, SIG_IGN);
+	parse_args(argc, argv, &o);
+
+	/* Needs no privilege and no primary, so answer before anything else. */
+	if (o.help) {
+		usage(stdout);
+		return 0;
+	}
+
+	/*
+	 * Privileged phase. Only the connect needs privilege, so it is the
+	 * only thing here, and everything it needs from argv is checked first.
+	 */
+	if (o.interfaces) {
+		nsrc = connect_all(src, MAX_PREFIXES);
+	} else if (o.config || o.capture) {
+		char path[PATH_MAX];
+
+		if (o.iface == NULL)
+			errx(1, "missing --extcap-interface");
+		if (o.capture) {
+			struct stat sb;
+
+			if (o.fifo == NULL)
+				errx(1, "--capture requires --fifo");
+			why = param_problem(o.fifo);
+			if (why != NULL)
+				errx(1, "fifo path %s", why);
+			if (o.cfilter != NULL) {
+				why = param_problem(o.cfilter);
+				if (why != NULL)
+					errx(1, "capture filter %s", why);
+			}
+
+			/*
+			 * Advisory: fail before costing the primary a connection
+			 * and a handler thread. lstat() to match the O_NOFOLLOW
+			 * open, which is the check that counts.
+			 */
+			if (lstat(o.fifo, &sb) != 0)
+				err(1, "%s", o.fifo);
+			if (!S_ISFIFO(sb.st_mode))
+				errx(1, "%s is not a fifo", o.fifo);
+		}
+
+		parse_iface(o.iface, src[0].prefix, PREFIX_MAX, &port);
+		src[0].fd = connect_prefix(src[0].prefix, path, sizeof(path));
+		if (src[0].fd < 0 && o.capture)
+			err(1, "cannot connect to DPDK telemetry at %s", path);
+		nsrc = 1;
+	}
+
+	/* Nothing below this point runs with privilege. */
+	priv_drop();
+
+	if (o.version)
+		printf("%s %s\n", PROG_NAME, EXTCAP_VERSION);
+	else if (o.interfaces)
+		cmd_interfaces(src, nsrc);
+	else if (o.dlts)
+		cmd_dlts();
+	else if (o.config)
+		cmd_config(src[0].fd, port);
+	else if (o.capture)
+		cmd_capture(src[0].fd, port, o.fifo, o.snaplen, o.queue, o.cfilter);
+	else if (o.cfilter != NULL) {
+		/*
+		 * Wireshark validates a capture filter by running the extcap
+		 * with the filter but without --capture. No output means
+		 * accepted, any output marks it invalid. Exit status must stay
+		 * 0 or Wireshark reports the filter as unknown. Only reject
+		 * what the telemetry encoding cannot carry.
+		 */
+		why = param_problem(o.cfilter);
+		if (why != NULL)
+			printf("capture filter %s\n", why);
+	} else {
+		warnx("no extcap operation specified");
+		usage(stderr);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/usertools/meson.build b/usertools/meson.build
index 114d0a65b4..c2bc8715a3 100644
--- a/usertools/meson.build
+++ b/usertools/meson.build
@@ -20,3 +20,26 @@ install_subdir(
         'telemetry-endpoints',
         install_dir: 'share/dpdk',
         strip_directory: false)
+
+# Wireshark extcap helper does not depend on anything from DPDK
+# and speaks the telemetry socket protocol directly.
+if not is_windows
+    extcap_cflags = []
+    extcap_deps = []
+
+    cap_dep = dependency('libcap', required: false)
+    if cap_dep.found()
+        extcap_cflags += '-DHAVE_LIBCAP'
+        extcap_deps += cap_dep
+    endif
+
+    executable('dpdk-wireshark-extcap',
+            files('dpdk-wireshark-extcap.c'),
+            # only for the project-wide '-include rte_config.h'
+            include_directories: config_inc,
+            c_args: extcap_cflags,
+            dependencies: extcap_deps,
+            pie: true,
+            install: true,
+            install_dir: 'bin')
+endif
-- 
2.53.0

