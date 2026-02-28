Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017CFEE4F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A97240B9D;
	Sat, 28 Feb 2026 18:56:07 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id BB91E402C5
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:05 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso3023570eec.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301365;
 x=1772906165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=PRDqV7izlqHkvnETNZdHer94ro0MIuNrLl4ey11ULfXdVVAN5arY52IjNPFr1sLGpu
 M9VtflP70h+o1Fa7nqpldA9ne1CWS6tzka/YekEV9kkImXzV6+Bxvpq7xn/siZ0cekHq
 X0AwRidFWE2HoVsVziVfphJFbs0J5G25n9ufOX8HeBSYtUzLVZ98sNT+mxNmymAGq8CE
 1fsjLaWpZLRvlIyXFAWVRDAeyE+5n3qCLV9EnFbxTHIHe6VJ9qT9QbLFHC/Hd2cF1TGD
 /B0XYGlqnd+JcF6vdibKkYgIsaX/IqcWUBNeXPLUDwndi7s1lfflS0M8RPrpYXtIW6+n
 CmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301365; x=1772906165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=M7PyBTosDJ46wFvl0ya9B+4yaMEBpL8YL3zpqFEG+riS+37/0eHI9nkLfefqM8V/t+
 wciym3fo0x9TCgXMQ8ChmG56LgwnaDApziEDTt74naWSSma80oSe9PFDWvoGSoPR9WgO
 hXxo0KcXFbficFNtt4dmyRSQDtNk91Cx4RSj7PHwnLoQ+taFIHhU8IV9S7m4fvMFv2bj
 hFi1qoKl5ClTJm+hqKrqn2l3An/lT6x8CDOAZ4KL8H1+b4trew2HQSnsbeie14VHt1ja
 spd1dpZ5oIQYsmfrxOE3kA72nJ7e+lMeasoyk4ZUKNl3fZ/IxAriivYtBuMtQEaFxsLN
 BujA==
X-Gm-Message-State: AOJu0Yxq6ghqH7fslYQTW2uXXQVpDmiCSEElZyfZf02uSSd1PA2Et+7F
 vr5GKGDXejWG7JqPpatjPRQkzjzqwlHiMro/53ji4XECLg5O4EJn/Sx2FLtc19AKWiXT0Ro3wO6
 g8jAx
X-Gm-Gg: ATEYQzxjzuD35leN/W8tq2TsvPHA/xwKLDU3A3xwRO9j0sxgUpm7D7S0z3fYxyJmPAn
 sGooysYFF3U1VdYQ2oQdnqMf62KIppjqLoSi65Gte0piHpgbv1ticqNRNmRT05ZQVK/WYB2e+8z
 P/85fCNC9Mt2lt4J/5PzZzBkxAfhW2NTJ80Wo/hHCEuQkkFb4/2b46fxPgxtN/C8Vh32DA/gSLB
 mwFJcUk5dEx08TPGZbBTZpqc9CpNzdjHcMiBxgbceu1RXGSbYw3AJS/67RZc9k6zVL2ccWXL/Ar
 t5LUfyFE9TpoIhoiCcuTrZ+JE7/5JzuHZ9amc8LoyEIZjoeNzpji5XxmNio94F8TH2gFlQ1xkLB
 PtngFrLFq1RTJsLtCc/BKXz7dXGDbBoDPh4sMJX2pSa5cZRiwLo3YXLrE76sQ/TitGt/Nf38jEc
 WHK1HXwzC7E4H8S2KWR6z0qoyNXVSIQcWbzwUicaLRD1EdceZeJULXrnqqSb+S9A==
X-Received: by 2002:a05:7300:6c24:b0:2b7:1abc:a6eb with SMTP id
 5a478bee46e88-2bde1b50817mr1886345eec.7.1772301364643; 
 Sat, 28 Feb 2026 09:56:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 1/5] test: fix pcapng test to work on Windows
Date: Sat, 28 Feb 2026 09:35:00 -0800
Message-ID: <20260228175601.585102-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
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

