Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5EEF3C997
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F490402E9;
	Tue, 24 Feb 2026 16:27:34 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 50529400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:31 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12732e6a123so611381c88.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771946850;
 x=1772551650; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=tLal1RyTOugiH7HAwgylm179bnjbHO3MKV0s8vkg+yiDyJdQP1xtT2jqcqdaLiOIQO
 JT6vQo6MD/0lRgVmmrkDqjPVs7KCK8XBUFONrTmS9qGW0qmURQyA1HrmsBvqpv0iT/AK
 3a3D6Cvq2hUXR1hDCsSNzXoNq00KufeQ4IZoZYMNKBclS9N05tR5T4+3IWeg3M4yfIdH
 hJmrCvvjk4UKLXN3TPGlARviWlt413C31nLpZT3UlD3hXD2A2KoiOMHYjzaCoMt22nk3
 TTAwlFExxScgJejZafE1wEKhPdQpL9I81qX6DPF0nh5BqZVgvU6wERrLdQftPpkOZju6
 aNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946850; x=1772551650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=XX/0SvzASPLa2zdm+PYOKfHNYdXaF8WJ/p/GIAUSPCuyC9DyTpBkX3oWYbPKUXTuKs
 K0MtRltjWgLstmsbgMJxvAGQufboY079LQgFCYP+6RFAQMYNTQBgNCVTSRK07UOIrgqP
 /OiRoFksPvwOmHPfV6iVknYQarnXtffTMa9PW07ArjLhdmGIe+VXOeBnhCQgkgsKlzIY
 mEjQutclbJmqqX0nRz7pgQqNK/KQy/IGoh4zb2H1rsa61n39I7MEkn6x3Zd0C4s+/KXk
 pXc9ImNyTHirAPfIi/x980c6zCMk8UJv6eXm7OUgo0CHM9bQTtJqCppK+gT0D1VFyDBf
 EvoQ==
X-Gm-Message-State: AOJu0YzjH0qS2mEwqaQQniDPyqqBAj9g5C7Cc1GCZ0Qu/fZTbLf+l6tn
 O9lWEHD+EGePyWbVOX5+2LRbFkYt7oq8gSedOgm4DdbqZj2Z3HKUMvU4e+uH9EwJ0Y0wxPyARVd
 maMcp
X-Gm-Gg: AZuq6aL7/kO7oy3o53Lo2L7BOKzmYOB/J/9l6psmMbOODDdxPNFKfQ6z/UnHFe1sF7e
 vchMbr8wU1iDkoVOsa9fh9gRaFO7mWL+NH61/7RNzR936MrlkaPgfGrdrN2+kTI8u5w5Y2z9H0B
 sxmgdcxw2j7E92MzuqUsdkMxcTzbGsFJZZrAMXFaCUD/l0qiauhVKvsWQFXOwyTtJ5QLWb2+MGA
 C+mru/5y0/vgIhYnSRF256Z2Lx/v2Q2y9H4loztceBk3/wIOJ7VbEtRxaFm/tYKvFkqBVnege4e
 SUF6+e4KrHlnyYVNnNDgPnfx/ya1K3wk4MXLj9luDrvr8xwtBnyk+/wmnynURBCkUfoiN8x7gLi
 UG7S04afqFFOt5YCdnSppKfsx+ImdmhjI6XZnegbXczZCm1e2PHhfXAhNzP9QC+t/fpjz7qY4hp
 NCTRind3BPa72EQsea8NU9/RXiL6RpqWSTWT1mRrU7j9q5WJfImeVzFpGbbF54rQ==
X-Received: by 2002:a05:7022:608e:b0:119:e569:fb96 with SMTP id
 a92af1059eb24-1276acda68bmr5704214c88.5.1771946850150; 
 Tue, 24 Feb 2026 07:27:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm10728774c88.9.2026.02.24.07.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:27:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 1/4] test: fix pcapng test to work on Windows
Date: Tue, 24 Feb 2026 07:25:54 -0800
Message-ID: <20260224152726.567604-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152726.567604-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260224152726.567604-1-stephen@networkplumber.org>
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

The pcapng test needs additional wrappers to be able to
build and run on Windows.

This is a pre-existing problem, only exposed when the
test was enabled on Windows builds, and when libpcap
is setup on Windows.

Fixes: 0edc1f408a8b ("test: enable subset of tests on Windows")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 65 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index ad9ad51f4c..f0faead728 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -4,7 +4,16 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
+
+#ifdef RTE_EXEC_ENV_WINDOWS
+#include <winsock2.h>
+#include <io.h>
+#include <fcntl.h>
+#include <windows.h>
+#else
 #include <unistd.h>
+#endif
 
 #include <rte_bus_vdev.h>
 #include <rte_ethdev.h>
@@ -23,6 +32,52 @@
 
 #include "test.h"
 
+#ifdef RTE_EXEC_ENV_WINDOWS
+static uint64_t
+current_timestamp(void)
+{
+	FILETIME ft;
+	ULARGE_INTEGER ul;
+
+	GetSystemTimeAsFileTime(&ft);
+	ul.LowPart = ft.dwLowDateTime;
+	ul.HighPart = ft.dwHighDateTime;
+	/* FILETIME is 100ns intervals since 1601-01-01, convert to ns since Unix epoch */
+	return (ul.QuadPart - 116444736000000000ULL) * 100;
+}
+
+/*
+ * Create temporary file with suffix for Windows.
+ * Returns file descriptor or -1 on failure.
+ */
+static int
+mkstemps(char *tmpl, int suffixlen)
+{
+	char temp_dir[MAX_PATH];
+	char temp_file[MAX_PATH];
+	DWORD ret;
+
+	ret = GetTempPathA(sizeof(temp_dir), temp_dir);
+	if (ret == 0 || ret > sizeof(temp_dir))
+		return -1;
+
+	if (GetTempFileNameA(temp_dir, "pcap", 0, temp_file) == 0)
+		return -1;
+
+	/*
+	 * GetTempFileNameA with uUnique=0 creates the file to reserve the name.
+	 * Remove it since we open a different name with the original suffix appended.
+	 */
+	DeleteFileA(temp_file);
+
+	/* Append the original suffix (e.g. ".pcapng") to the temp file */
+	strlcat(temp_file, tmpl + strlen(tmpl) - suffixlen, sizeof(temp_file));
+	strlcpy(tmpl, temp_file, PATH_MAX);
+
+	return _open(tmpl, _O_RDWR | _O_BINARY | _O_CREAT | _O_EXCL, 0666);
+}
+#endif /* RTE_EXEC_ENV_WINDOWS */
+
 #define PCAPNG_TEST_DEBUG 0
 
 #define TOTAL_PACKETS	10000
@@ -344,6 +399,7 @@ parse_pcap_packet(u_char *user, const struct pcap_pkthdr *h,
 	pcap_breakloop(ctx->pcap);
 }
 
+#ifndef RTE_EXEC_ENV_WINDOWS
 static uint64_t
 current_timestamp(void)
 {
@@ -352,6 +408,7 @@ current_timestamp(void)
 	clock_gettime(CLOCK_REALTIME, &ts);
 	return rte_timespec_to_ns(&ts);
 }
+#endif
 
 /*
  * Open the resulting pcapng file with libpcap
@@ -395,7 +452,7 @@ valid_pcapng_file(const char *file_name, uint64_t started, unsigned int expected
 static int
 test_add_interface(void)
 {
-	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
+	char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
 	static rte_pcapng_t *pcapng;
 	int ret, tmp_fd;
 	uint64_t now = current_timestamp();
@@ -444,7 +501,7 @@ test_add_interface(void)
 	ret = valid_pcapng_file(file_name, now, 0);
 	/* if test fails want to investigate the file */
 	if (ret == 0)
-		unlink(file_name);
+		remove(file_name);
 
 	return ret;
 
@@ -456,7 +513,7 @@ test_add_interface(void)
 static int
 test_write_packets(void)
 {
-	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
+	char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
 	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
@@ -508,7 +565,7 @@ test_write_packets(void)
 	ret = valid_pcapng_file(file_name, now, count);
 	/* if test fails want to investigate the file */
 	if (ret == 0)
-		unlink(file_name);
+		remove(file_name);
 
 	return ret;
 
-- 
2.51.0

