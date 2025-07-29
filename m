Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6FC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 21:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC91140674;
	Tue, 29 Jul 2025 23:48:56 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 8F1AF40653
 for <dev@dpdk.org>; Tue, 29 Jul 2025 23:48:55 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso5399123f8f.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753825735;
 x=1754430535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCmSdEScsHLDw/WFD+ZKXJfjbxVNQtPy+mPlQQu0vo4=;
 b=ex6yhUh5OgYcvq/BcWyu2Utk98uCgWii1Y0sJMMTo0V2e143yCxWCYkwMGlIMgdhMn
 kQ0lsAnuLVWk+TRwqLPACskVEQ5Ut3keRUt5n/0E7IAb6u9zk9fvRyyz7g2zvXDFIFEj
 KOPaKn6V1yBGx0xxpnHKTWfJVt+x+3/NSiQyzdxPTucRx4+QbQJJfPuw2Vfl2gZj9pTg
 GFzfos1B+YTDzob9zHQNmxyUljGk10aALsG226142GOTBK5KsYRAaS9Sfhc/cEtczOFm
 mTfTd0GxWRZD4Z8GFtkjywLi81mbnR798HNGbr0xEYdPzpAQMlYPB28Mnj0rsTdMjz1S
 wJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753825735; x=1754430535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCmSdEScsHLDw/WFD+ZKXJfjbxVNQtPy+mPlQQu0vo4=;
 b=CTVMOpMd0r+JSkWjT1JNDdcyY8aIgWciw4rkLWxNIUxg4No3KdZdflIWL1lWOciNDR
 CwynHEhy++oPatdIgKHJOXMUUd7uwUY+lrOE5mnMwP80eGF8zcdKXUuvrGyTTc21RfRk
 v1NOmbmW8r9n/kAF2mxg6QCqujgcMRcwzzV0wVd93snJQ2qUe1NYoFDdl7q8+Afq5xgz
 RNytNwtIQeIZRy8z8wxaDh1ryDej0vrQVU6UK9zUmj5E/9uKwN09OvidTojl32eH/tsm
 bRe1dz0r4FouoXJV33gSNKZz2STeoJXQJ5P1IlXwlRZtyXdvs7ejKjRFrLt6/Wnx4Fih
 f0XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYwQXv0byeg9em089ct7RmF+0gNk+IVTW3eo5q8nPMGkMvDFkHvlzfN/ONDIguctjLKrk=@dpdk.org
X-Gm-Message-State: AOJu0YxtScLR8ERlLNHinSRtuPhzAHQSv3qV34kdrU0z0/JnAk4sCVf5
 JWI/jj0Utj9dB4NwraUk50yHn1WWki3BFLQLwHCvVJqKI0l/CIb2Dp+kLr51HSPEm3k=
X-Gm-Gg: ASbGnct0CaTP5ZdiCkFXDFbZ0fZL9wFZq6DFt0dpEFqpDz1MiHJx/850WAac5nsAVB0
 c3OKqBWaS4VAFgTYy1yu84oll14gFRcg4YaKuWZWUvtLFQIVkVwYXIIgLCwyRdhflPrlMvR+OIH
 u3dl9a548Ok6v65kCAjhnE9aAcCpmhsyiB9NRhQ5g4z/y/xzXDIAkMTNoFRLuitnI8OuAUSH6qP
 7Imtuxx6EePmnMH4myEpiQnoJtyeH/mcb6uKS5xUi6pTsM7VSdbNKOY3po1G804dwnAbDghynRf
 iDtBpAElVgXHY8+SwoEWyT1rid9W3z6DZEY1fqjvhp6s87OpaXEmCmbvoWQ1GWwASAURuxslEqI
 cEMSErshWWkmJ/omO431tT8zbaKNMfHVmvXZiEHA7Aid+Aq5fk2v1j+SVcJjmbEJVCSHH2Yk9t0
 o=
X-Google-Smtp-Source: AGHT+IFDvBPe9agvaHPIijP2fAbi16W7tn3iq0HgJH2wLlaWY3w7t7DKk8ohsX3yM119pjB0luBOLg==
X-Received: by 2002:a05:6000:42c5:b0:3b7:9546:a117 with SMTP id
 ffacd0b85a97d-3b79546a2cbmr338382f8f.30.1753825735144; 
 Tue, 29 Jul 2025 14:48:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b77db8a944sm12258029f8f.52.2025.07.29.14.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 14:48:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:48:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary
 process by monitoring primary
Message-ID: <20250729144850.2392840f@hermes.local>
In-Reply-To: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
References: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

What about this simpler and more direct approach.


=46rom d3a85e214e8ba9a89e2b154480a8fc76a67c0f68 Mon Sep 17 00:00:00 2001
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 29 Jul 2025 08:59:15 -0700
Subject: [PATCH] app/testpmd: monitor state of primary process when using
 secondary

In secondary processes, accessing device after primary has exited
will cause crash.

This patch adds a mechanism in testpmd to monitor the primary process
from the secondary using `rte_eal_primary_proc_alive()`.
When primary process exits it forces secondary to exit avoiding
issues from cleanup logic.

Fixes: a550baf24af9 ("app/testpmd: support multi-process")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..7c22046efb 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -101,13 +101,15 @@
 uint16_t verbose_level =3D 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
=20
+/* Maximum delay for exiting after primary process. */
+#define MONITOR_INTERVAL (500 * 1000)
+
 /* use main core for command line ? */
 uint8_t interactive =3D 0;
 uint8_t auto_start =3D 0;
 uint8_t tx_first;
 char cmdline_filename[PATH_MAX] =3D {0};
 bool echo_cmdline_file;
-
 /*
  * NUMA support configuration.
  * When set, the NUMA support attempts to dispatch the allocation of the
@@ -4332,6 +4334,36 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
=20
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
@@ -4363,6 +4395,10 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
=20
+	if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY &&
+	    enable_primary_monitor() < 0)
+		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+
 	/* allocate port structures, and init them */
 	init_port();
=20
@@ -4556,6 +4592,9 @@ main(int argc, char** argv)
 		}
 	}
=20
+	if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY)
+		disable_primary_monitor();
+
 	pmd_test_exit();
=20
 #ifdef RTE_LIB_PDUMP
--=20
2.47.2

