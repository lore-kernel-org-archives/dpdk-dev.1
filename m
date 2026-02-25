Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4346FD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1689940395;
	Wed, 25 Feb 2026 23:59:22 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 880CA400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:59:20 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso213999eec.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772060360;
 x=1772665160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=kGlm8l+TwQy36T7gcKmdaoJiuQ4wN0eb5lMw5xBoWBYHx9sIdYceXyEFrhjJj2YRZ6
 OcDiHxldraGIXELGD64NMDiAeGsqT+nfGnfTU4z4DK6dflJMaFIssjw/m+uJWcVjlqBC
 hdti9vj8CcOqeAJVijHONFgWVC+sZW8IbN30C4rUDMDKVuLegOlBuEGDly66qwy1dU0D
 HskiZcJL+O44rtpvA8yL2zubUk09g1gbVP6gYWLGCUjs5KC8GBxIIHQL9tq85ZxjJj4W
 YL/3uN49XeNv5F1kDRPgfr9DNZ61hDY7Ci+uA7GfV2sYZ1Qdjge5NDIZjv7zqbBYLi3P
 8hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772060360; x=1772665160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v90z5pVm19smAuPI5Y18MucsAHQ1zmuNHvYNuiKNpo0=;
 b=Smj3x1FKAgCirqJd4Zqtr8vEFYfiOjPh8rIsHJy3r6/1Qkx7Y2N6/o/fV1bE4l/iS/
 oU81ZBPp9cBoVL987R4WCRxaL+Emr+erVtVcZ8ZTvbplN6H1KDv5lQNYKMEt1JHdx+bk
 pgXEI2T2KaPNLlTRU0Gkky+xO7ll5lEaeVQrShA7lMC5ys5q4n4CmafaYI6RAUOGNoCL
 yO1f6TitDMR2iM5V3o2VGfzu7rmcXjJePtjmw0RwbbCgT49DSAeEGp940JzKAZ39dOlo
 4M+lymQhpHJE4dXRUl4bWy9EU4Xty7U7hBnBWqggFeYIT3Ou7zB6reH8z0bkVTQ06NTM
 +3QA==
X-Gm-Message-State: AOJu0YwCstL1OZEGPlMGcJS64D8BLTfE+9ywacoS1MXBpbtVgqK0LFdg
 Es7CjsKccHn4/QBGifuguI/p5pFikw0LrVInHj1qEqtI28y3KwVmXNusfQ/l3uoD7A0fUczP+1C
 qN8CD+1E=
X-Gm-Gg: ATEYQzzhpZ0IwFjmbybFruuxIEG7NHHdlQq1drStc9AgOnZE6AuphN8XpUf+Z1qyL56
 Yolet2cXG14Z8e8DZePiW3MMU5Pj/+4Y8jrrg3ixXmurCB+pgecsCS9OPgnOd3/R4rZDx61EiOj
 qj2KMOnKVeIhuBE2ZCXVTxXIWpb1EuVcXgttQd08ReLSg4lSELjdE5rLR8qt2JEeLc/c/TjvJrf
 hzposuxwcFxjDZrsuxaCugf1VfgHRmBfnTYIuiTBMsraYEs0AkqGSVn9KpeEF7T18XKqVh2zYz6
 LLkeQjeW3dpOzHELI/DYP4/DGM7/uDzO+CFjPuXOmtlnYk0FwKtbA8p67Yi2ej6077YXvgBK2Jp
 sV0hcx2UYV2V8yKB7//sYUvwibvaTm3qxZAv1+HeBMZxsKUHVc2TfdpdFXlKvJgz/Fln2C6BL+V
 wjrlJlKLaf7Jbir4dpj+x/6u8N3K4emuDam+Lb8PKw5IjVh/BjB+izp1EXeXu5nA==
X-Received: by 2002:a05:7300:af06:b0:2bd:c8a2:963 with SMTP id
 5a478bee46e88-2bdd301489fmr83116eec.18.1772060359610; 
 Wed, 25 Feb 2026 14:59:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f23c47sm411104eec.19.2026.02.25.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:59:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 1/4] test: fix pcapng test to work on Windows
Date: Wed, 25 Feb 2026 14:57:16 -0800
Message-ID: <20260225225916.518790-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225225916.518790-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260225225916.518790-1-stephen@networkplumber.org>
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

