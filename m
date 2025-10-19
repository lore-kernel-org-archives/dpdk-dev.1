Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8529CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBA9242DD5;
	Sun, 19 Oct 2025 18:57:38 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id A432442D3F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:35 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2897522a1dfso35580925ad.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893055;
 x=1761497855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMzcG/dx47rB7zMu6YKpMEyYpYdcwWlyM2vmgXpTbtM=;
 b=bhZxTmDzmbx4IQAU6AEQB90Q5AJg9D61vStT4oWylszJj7oXurVT2CG1pMA4p0pcFz
 Ac3CPopTfY8TrpKkK8iHBYamb5oj5qIF2XA2dVDHXPilWZtYBGnAnMGr2yGFEe9ar8ht
 d5UQDKs5g2qv00hvTbEvW2Lp/Fw/NYM+d40LsCPG3kk26xdO4kprYR0GxfvGey4Nedf2
 H1u8QlTH/zvyFXr8FCFTrNPKCsWKbX/o4P3RgabCTHYbNuRGbWjEoUmKSmV7VUaLMcfA
 +oHnF3lyEswY+BBqJ4Omu5VBjTSW3rutnW4JcaS/NIN0jzfKwkEC/VrkX8LTpD2s63YM
 D3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893055; x=1761497855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMzcG/dx47rB7zMu6YKpMEyYpYdcwWlyM2vmgXpTbtM=;
 b=DI2Iqm146xWsS8Sz/GEuOMF2ZWhG+G4x5q+9BrmGwpiBDuYkIQDRFOjnH/JAO2W0QT
 alWo4L8lJ9WYqwKHjXiOdBkZrkSMQwFa+UyDeFZglknyBUHL20rWx/q2Vsw5hTeX2Vip
 vdUhw0s/RgCN79U+uHtgT6Ppt6iY326sH73MxRzRYKhNYrCe/JuinDcJjq5PRNvV+JJw
 /dmDIFfjGEfr/43uh908yaaMS4IOoljggluNVyB4dGAzo3wHNM2Epv0RZMLFJQHSd4pW
 s1tYlMw5v+ExTXvC3pVk2SlkTUJm0Z6PNwRzlp9JZKka3krQymw3WWckupP3jXM902yj
 WP4w==
X-Gm-Message-State: AOJu0Yx2Io2HblR+RjCdK9bXuM2TNfzRttlDuDBXMamKJ7A/CpznCmP3
 ZBNnv6RRfEw9Qk/f2osLGeVEQ9zQhiqUHtnLcxTqMdL9LJromkQC3K3VnvOvRhveVtD0sr41wO+
 Y0NzOG5g=
X-Gm-Gg: ASbGncvPE5JDT58v3eQQCaHCRYLlib60lSMobXcFLS3vpXSeY7ZpqQri+RE8JAoqAWf
 VgFjLwnbD14CYMIjB3wq/YyVPSaA/B3macY2b7d9sDvh0MG4ccdLKzQzV454Uj/Snaya6kIKdts
 /pstRKO7hUR6on8MBRDiEzf7PNVPPXbwIYcPrhn/yGci824BwOpMIeO1GmugVFvk7SG6RO/i986
 WMFaRAbCrZFHlablO/slqe4OtVswep9dk2U0G4m1MTcz0lt+PKtOAqAIfQM6PbYneaV96PFarnr
 x83DR8naviKDtOnn1qzBzT1ILWtNs5yxxp32DhCiuCbsTJoB+oFlZ4YYxdDbjLNmv084GPMXcVz
 N5Ki9V4Jfd3Bmoavhx0tt2pdH84QWqN9n3oUgGJ4AgV9nZcnFbHL/IS2RTSOGH9KoaaRjVOQrKq
 JKtwblZW/9tsO8Qs7R/WVaf/i+JCxegjnk8Numq1E=
X-Google-Smtp-Source: AGHT+IHZLZ+bZDeLRCw8ZuwRxtLSR41anzzcAisLs/7lwMILdSc+nMoQgsJA9+aIqMpMEkZodt4fBA==
X-Received: by 2002:a17:902:f550:b0:28d:18d3:46cb with SMTP id
 d9443c01a7336-290c9cc30e8mr144478265ad.20.1760893054857; 
 Sun, 19 Oct 2025 09:57:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 4/8] dumpcap: handle pdump requests from primary
Date: Sun, 19 Oct 2025 09:56:11 -0700
Message-ID: <20251019165728.164929-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The dumpcap secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3621c0ebe3..46a6cb251e 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -528,6 +528,8 @@ cleanup_pdump_resources(void)
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
+
+	rte_pdump_uninit();
 }
 
 /* Alarm signal handler, used to check that primary process */
@@ -659,6 +661,14 @@ static void dpdk_init(void)
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
 		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
 
+	/*
+	 * Register pdump callback handler.
+	 * Primary will notify all secondary processes of change.
+	 * No impact for this application, but need to reply.
+	 */
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL pdump init failed\n");
+
 	/*
 	 * If no lcore argument was specified, then run this program as a normal process
 	 * which can be scheduled on any non-isolated CPU.
-- 
2.51.0

