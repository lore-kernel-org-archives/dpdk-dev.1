Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B164C5DF97
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 00:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9C654064A;
	Thu, 27 Aug 2026 01:59:53 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id BCED840264
 for <dev@dpdk.org>; Thu, 27 Aug 2026 01:59:51 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso96016a12.0
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787788791;
 x=1788393591; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VUgPHWharXJvv24VZMxuRQmS/+hVkBOOK8BecrtYjPk=;
 b=GhE8hHh4PINwaEnuybnu3Zhcq60fwn4+G4gxbrWEixgJZCpG04wzyw3lXrDJjOw+3H
 E7d8RVIxVYtOi/4XeFSG5HmllgZ0rGH40Oq2A84Adzo1jTbpxTx0PauljY8UmzoKwvMZ
 u1cRtfDzP5jTBE6zZQ98fIIruzy7DnkqseGr6PCI/ropYLfqvfMt0oCPVwTQ/6ehXQAd
 bVCvXwoB79skOb7zeBa0X8DE6eMbm2OwOf5gdWqvYu9RBU1ABW+14pezLUOrD3zi/REV
 NnpQLfwf62ZrIQEObwXsYU6z9a88bQHAUs6HjhX3FD1Sa6WJEtJgAbZJGx0+J+zZqz/H
 RUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787788791; x=1788393591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VUgPHWharXJvv24VZMxuRQmS/+hVkBOOK8BecrtYjPk=;
 b=UndqGfu4D8Fnm7dCgvdVLY+uaJub5S91LDqZO5TM0GaN9Fhm3UvLF05lwG/EogTeKD
 pgxuA1+1fPwih+pAzUTP4EppXOyJswukQnh/DkPSXNwKyamqMViu3gwG/A5Kuny72lXF
 gqoYKfxDo2P4zOd4J7QK7p8blRCV8WQLTSfosvTnCjkRcU6OXQqwkaio+hzd/cELIXeV
 TAAIrC5ReHhTHey0xubORxK0s/21Ll/DMCYxH5/ubDYatDWMISVCLj3ybt+d5uOe9czd
 5RobTQjUd7+JnKVUeLv2kqgUAoDWjG0qt2PLJ9Ju0BMQmJUbrChz1mtdZkYa+tIXHFoJ
 xXbw==
X-Gm-Message-State: AFuF++k0C4M/2DP9v8VbHaVWeZvV06ZFqzSG8/PgduSpIvTNglDVCDSL
 oWlrl1kK3EJHhPyJdzp7eIa903AwD7euXkUqLQOtnrRBHQB/5QUunV0fVaYeb3vtxF6F5Wdy2kL
 6Ftvp
X-Gm-Gg: AR+sD11KYr9ZG/K6aovFm0MBkNPj5ZmR9v5/TtWvB8y89gXdC0HtJ5nOxv+FOVZ3X4S
 c0Nrmu578GStZhE5ELrYMl5SWpxTR/2PaFVBtukWw3GO/r7mP9H0Bgh0xxHvu+Tje3vHSN5TduI
 0VwwEefOWFZpWoJDozSOCBy5/rNWSc729NMvDGr48ihjKaXoN20g0C1q06W2oEClz9G7vBiTuVI
 nNCiooPlBf1REV9Cu4VfgPhIOZkzvYdqEv0UpqpBcj2T6McaqnsYM9HItuefMxerq0EzM0xE23Q
 VipjzoEr+qRHNPahRzSKBkolzPV+f7eUEH2yzmM6/mqspe6g88qmxrepbfDB6ncBwDuXC9rufjw
 MHoU1Hse0Crc7rCzqu96+Abwul0kUIiB1cwPs3YOTqotSzLQkqG1zap999jrRvrNt7stejMtXgT
 Hxz3vVAk1WH7whH4oOFziEfl23fISVEhC95jEnXnosr8Qn/99Jd0Tr7oDZVZ+A5l9blaC8VOiIQ
 B78aAG2Hhl0PQH+47lq9Dq6TLl7prucQHXGHw==
X-Received: by 2002:a05:6a20:e210:b0:3bf:63af:855 with SMTP id
 adf61e73a8af0-3cf762865fcmr18743849637.1.1787788790655; 
 Wed, 26 Aug 2026 16:59:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm11019596c88.1.2026.08.26.16.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 16:59:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Geoff Thorpe <geoff.thorpe@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 2/4] bus/dpaa: remove unused qman_clk variable
Date: Wed, 26 Aug 2026 16:43:02 -0700
Message-ID: <20260826235933.194681-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826235933.194681-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
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

The driver was recording the clock frequency and never using it.

clang 23 reports:

  qman_driver.c:27:12: warning: variable 'qman_clk' set but not used
        [-Wunused-but-set-global]

Remove the variable and the dead store.

Fixes: f6fadc3e6310 ("bus/dpaa: add QMAN interface driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 45b094e0c6..bbe2640c52 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -23,8 +23,6 @@ u16 qm_channel_pme = QMAN_CHANNEL_PME;
 
 /* Ccsr map address to access ccsrbased register */
 static void *qman_ccsr_map;
-/* The qman clock frequency */
-static u32 qman_clk;
 
 static __thread int qmfd = -1;
 static __thread struct qm_portal_config qpcfg;
@@ -371,8 +369,6 @@ int qman_global_init(void)
 	clk = of_get_property(dt_node, "clock-frequency", NULL);
 	if (!clk)
 		pr_warn("Can't find Qman clock frequency\n");
-	else
-		qman_clk = be32_to_cpu(*clk);
 
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
 	return qman_setup_fq_lookup_table(CONFIG_FSL_QMAN_FQ_LOOKUP_MAX);
-- 
2.53.0

