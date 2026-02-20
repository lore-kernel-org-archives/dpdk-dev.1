Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC4C5AD48
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 18:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4880040609;
	Fri, 20 Feb 2026 19:43:02 +0100 (CET)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id 64E7C402E3
 for <dev@dpdk.org>; Fri, 20 Feb 2026 19:43:00 +0100 (CET)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1501683fac.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771612979;
 x=1772217779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=YfR27mKRLLgsEw9Icctj07w6rLzo+7qth7OpgJt6PZEHzJbGPWKYvMFzIyuyAnZNv8
 rqAHPrPoWTemrXKILITb0eBQU9Y3bWJ+dNNgDP0B/pRTDijBrhFKhosVli/rgC7Saenu
 NnYKIT010joOmJZp5jGsbE/Ujoa71yvXKYsmAjCEEduGy5+Imgp1sTrFrNJhmeYaagMo
 SGT7EorcmaniAF0ngICiF1zA8Tl8c37BsA09l3mJkBzXJLQGG89dFoQ17zhPWd3cWI2H
 eg7boufYmaFyH93Qc6dUpHFreFsMpMd1x8v06XrkOXMtZqSyJwppSF+kG4BhQJczCzjK
 ZmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771612979; x=1772217779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=tvJ2OX1XiBgpVcn2IaUA9mKgBCzdeZnfIbdCDNU27XUxW1mwPSi9o8Ek/bTmMV62M6
 eey4Dzj10DIn9g6Qm/Tebc+76Llfu6LBfyJvS/qGm3U741a7XbsN8PeYv4QxH+DBzb7O
 WLe/s6hWSfF8MjNBovSCIXUmZB6Y80LN/yOl3VHBtLkBx+oZHsM+ItFWqtBf2HSrxPlJ
 rbkYWC0L/xbKKNen85y2GZLL3yYW0rhh1OCNUd/89ur0mrl25w+PoqgofFsakUjEydBX
 9J6eeydzhcQlB3nN3dBqWLqbFXKnXg+c1mjtOjsSiTztqoB87iUyyewtAteKtnyRE9Eg
 ZVUg==
X-Gm-Message-State: AOJu0YxualnzhoJBIYoahXqZo995y6FEn3XiE+npVYT9cz6mTpNswVHX
 fhGb1+KKxEMQ2E38vGAqp3Un9CXaaxhn7Qr0fCpGoRhpbXGLn2yGwuEWtSpy+3pEXThp1CD3VyM
 D5zfL
X-Gm-Gg: AZuq6aI6dVQsosoOHxpDC6y7k3tWFmSRBc0uCYPNtIkoDE5fL5+shRu7X2rD42ukdwY
 /GtOUj13QCeVDBe9Rb5Umx9GOwI5nDlCwbZso+KlKgIlz48vwX3d2UjzYYuLOpV+s/fJw1gqtEU
 TYqfj69jX5T3kJdomdvt6/GD59bmFcJXCv9OwpNDHYYWp5+78sg4kq8pdVPQ/vr0kndqjIFzFl9
 uIRqbZk5iC/r67WfdGNFs5tBnklPXlX+fkuxEk8Z2xwzKLy4RBAHvnY++wfc/v2kFE3bzV61PIb
 LEZeBu3Hm8ajtZCcqhbBGVRvdMqj+mvmz3vOzTvQQtECoZZ7P/UzrjuW3z1THNd27PgF7s/62lA
 yQpKZ9eLv58vl+J8jLgg1aFDqG1Lrp1KFui66sycm5Vb4YgwZjbZPOmk2+SVLeu4ujEnW5z3Tnf
 u3JIGAfz0qt4b0d3cSsVQTDaZA3XswT+RHLuCLlFbwtJnWJ6C7KSQ+MxVf9e0M0Q==
X-Received: by 2002:a05:6870:d621:b0:3e7:eba8:327e with SMTP id
 586e51a60fabf-4154589518dmr3622053fac.22.1771612979436; 
 Fri, 20 Feb 2026 10:42:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm250876fac.4.2026.02.20.10.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:42:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Jie Zhou <jizh@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] test: fix pcapng test to work on Windows
Date: Fri, 20 Feb 2026 10:41:55 -0800
Message-ID: <20260220184255.306368-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220184255.306368-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
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

