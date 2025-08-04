Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1103C87FD3
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 173174025D;
	Mon,  4 Aug 2025 09:55:16 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 4F565400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:55:15 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so3895996b3a.1
 for <dev@dpdk.org>; Mon, 04 Aug 2025 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754294114;
 x=1754898914; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdMIzbYTW6iJj1ZdKKFNrL/MJYf0WYbaO1OpKjil3A0=;
 b=X+iuM05jkGaD9IOCSfUXXcP5wi01W6N/1jD7o7ZTAH7+o35Yjcnfm3i/WbhI7eqCsx
 eg4TcGY9Ji+Cc/2O6ib6qut+M/Pb3LcfC2VHhLC4jV8xl70SpMdSUJGM+pNqP1MzMFqc
 rugvWfw40oFGfQEo4PCjpBQ0i11c32r5QtGmqZwHrIrnC46zbWWFOZ9kuD2vXWBNM7LY
 EpQ0dVpdT+UlbB1GjWbGXjgzOmEATzg/nkmg1tOgu3/yIeOKX9tDp9XY+81YK5MA+QOE
 dr2sUG+W70iNbPSrGlxpvJRE8UT+h0Z27I+LfHwwS1i8jrEZcbmUKgcNAyTX8dhGQndd
 zCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754294114; x=1754898914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdMIzbYTW6iJj1ZdKKFNrL/MJYf0WYbaO1OpKjil3A0=;
 b=cKcz5osp8YSzmYTGwJUNzLOAp5mJI30FeZLrT4ltmzOondoN8YWmicXzq4kmZQUicz
 qNFyZiUgWItYKqpV4G/z+WW0hY9ihBm+JiDosaPAXPbVsniy3sH+8ad7S2vumGQdnE+T
 eVIpepKcpyWhkWcHxMVruAwnvH0qH5TmLhiCBuCX+o7RwjSm5TNb4QkbhOX0pEFZGaUb
 gCpKrV0HAb5PKaundU/A4Gk/AjrPAcH1AQ/xAx/cWrA4GNhsYePfosjZO7+sLkq4t5KY
 /NyPX/ysrucSVCa8vmE+GfT/n88Lu+PaOD8TEyMPciDQWR2xFWlsCXUZyOswUKaz76Iw
 ZiZw==
X-Gm-Message-State: AOJu0Yy08KpTA8IsoOP6khdDwod+WPm9t7qN64xTWMFDmzTeaFgEiIpS
 CYq2uG1Hb9QxPRC+ZtSL/yjVg+tf++T2+hYGMIwqC2ZhWtFzRvr3FV5Od41bQun+FR4=
X-Gm-Gg: ASbGnctq6ITVgU0CQo1c1thdshnlW2hSaSGQu3p4Qh4kf86icd5dfIyx4PPcrxZ3xFM
 I0bBQK3iy0NLTVN/AM1HZk0lxLeFhhylRNkFvbUinflhLltZHiiBu542GEL78osix5i4J3Ox723
 2AXwLmP9nW4Fq5s/Ot/yerXJaXexIcgsB/NXDad8TwI/EJUqbe1kXWhluovfUfVpb0UrDNA45lP
 +79yyq33Ufa2/JKSL5BX2ZD04seFX7ZDfVriPaMC4LamCeR6lD/ovn6RIApQLyWeE0wp22KBtFe
 5NRUSgw+8pzn1rqyJmYMTZ2wAFxIKGdvIQdBJPBN/fL62UyfHfcdT/q5LOU4sMEsOnKQ3L9KwLI
 GbieFxpcvG/a1pmCu1cCPl7iSMDKYRhyqtg5ezrzIgvtlhPtq
X-Google-Smtp-Source: AGHT+IEBd8ALjx15Bk29BYXynZMdb62CvsFylbBLK4OORclG71mN09pPD2bCmvdrnYQXwXwktqO0Gw==
X-Received: by 2002:a05:6a00:802:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-76bf5d3892fmr6647483b3a.9.1754294114160; 
 Mon, 04 Aug 2025 00:55:14 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfea38csm9787676b3a.128.2025.08.04.00.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 00:55:13 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v7] app/testpmd: monitor state of primary process when using
 secondary
Date: Mon,  4 Aug 2025 03:54:52 -0400
Message-ID: <20250804075452.975461-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, accessing device after primary has exited
will cause crash.

This patch adds a mechanism in testpmd to monitor the primary process
from the secondary process.
When primary process exits it forces secondary to exit avoiding
issues from cleanup logic.

Fixes: a550baf24af9 ('app/testpmd: support multi-process')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..f9dab2106a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -101,13 +101,15 @@
 uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
+/* Maximum delay for exiting after primary process. */
+#define MONITOR_INTERVAL (500 * 1000)
+
 /* use main core for command line ? */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
 char cmdline_filename[PATH_MAX] = {0};
 bool echo_cmdline_file;
-
 /*
  * NUMA support configuration.
  * When set, the NUMA support attempts to dispatch the allocation of the
@@ -4332,6 +4334,36 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+/* Alarm signal handler, used to check that primary process */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	} else {
+		/*
+		 * If primary process exits, then all the device information
+		 * is no longer valid. Calling any cleanup code is going to
+		 * run into use after free.
+		 */
+		fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Setup handler to check when primary exits. */
+static int
+enable_primary_monitor(void)
+{
+	return rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+}
+
+static void
+disable_primary_monitor(void)
+{
+	rte_eal_alarm_cancel(monitor_primary, NULL);
+}
+
 int
 main(int argc, char** argv)
 {
@@ -4363,6 +4395,12 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+	    enable_primary_monitor() < 0)
+		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+#endif
+
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4556,6 +4594,11 @@ main(int argc, char** argv)
 		}
 	}
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
+#endif
+
 	pmd_test_exit();
 
 #ifdef RTE_LIB_PDUMP
-- 
2.43.0

