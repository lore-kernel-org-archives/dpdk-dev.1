Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E205CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C66C40395;
	Fri, 24 Oct 2025 23:55:08 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id B08BA402E4
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:03 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7a26ea3bf76so3477849b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342903;
 x=1761947703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPQTx0z2LrGhFBoUFfqMhsEtngbOKeBe2Sa3KcccjjA=;
 b=gtb2iWJaM5jbAbmtLata9MtRTWxSMmgd4IC76sscAduiTXJMdC4fRSVOv3yu69pl4O
 F7PK9wZ9BibML2/3kcRuD3iUdI9Tb+C/hNvb0bzBwwNQT6ZZTaQ3mMp6VkcwWBoQLD+/
 RxjWYXTnn6F3bHHhMrLwWk7wTehmTUxLcoD3WhEWgZRxHijDSTPmh4enfwB6neE+VlRX
 ew65LshEMfr69QjKuvGVnB0dQMoHQ06ZlvkY9MdgfZoc0MzzX+kvXVhPEk90YrnT/3Xy
 ByyaxY5jrmsbugecsPsnliZJxmkW2wZtfl1tnbXu1L2MjCKzWXKvT8YsemPqLQC76WhC
 dGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342903; x=1761947703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPQTx0z2LrGhFBoUFfqMhsEtngbOKeBe2Sa3KcccjjA=;
 b=poUjJgt6zuBVkXgjTjOPxUlwAGuu1wu2KDchKCwIFBrELH+aFnZsSVfjsfQYeUvmRt
 uDGjOXEKI/rUByuOH3x6agmddpL+0VFTr4EzTnN2BBfAbxMaYX3UVgi74Ouu/FMkgNts
 3aoHBpbI30iU4ov/QUWyhgrbpDqeR9UmbBsgSglHyOnN5dQbQ32nJfvD1v/Mhfcl7HRZ
 Iz4WdDuyflPkdqWHaNgiiWVKD7FywTfwfpgGSXQNWI6FaQ5HFlZrK4D78Cajm7l69Ydi
 o6c1Dt3u2Flg7J1nl2SXiYlg0son0JWfyLsOPlNxc8tP3RiUqxQpgk5t3fYt/UwqxLty
 K90w==
X-Gm-Message-State: AOJu0YxR4alR6EDfJo6yDnjSki87Qoi2m9O9H7bn2/p6cAOcQY9E+Ywt
 +jZhrqtdovVazh40HvTW3lYmDdw+n8EsuyEfVxO6xOaVdrYEwGTHzJeuBh53/xwcQhrHKyKgnuX
 cis/b
X-Gm-Gg: ASbGncv2iQKOPuJehQckEjYM6xOPzcH7hjMYbkcfv43rIdyiAuzx7U/ZYXJ1xmNL3j8
 CiYXG42d4x2sdvOZPnu3oeFYfywkR9r/UQsr/zTDSP1OpYYdooJmboWQb3eB5UEhOR5CWZyrv7d
 qcKryNzcL3HwllOI+EhJBLCeAm9jABhaReJlnf/SHmVmRARlb6TNsCcBeb5JQ/yUbDM9qUP8jZv
 nRXwB8WfdJZvDhaycgMZ7oNrysgol4LfbD4BRNytMOr4MjsRfQDnqyeiGLrQApXO5eL7fdttEQK
 Y+m4HKQMmbuph7Ut/HaN7QCXM9Rxg6q7lO5UlUIhNKmpkixYglbW17J+5H3S1ymCAPZsyC2XBa4
 sFR9ESubqcCIdsJiFg7UGrYgFienUUugDAzZRY85D/eHFfOB0g85xlSBwGtRpCS07OrnLipqX+r
 oif91aH2i7V4G+vf5jj/B+OoYFrioeRHtBGg3t4iLXPuELD5e+rg==
X-Google-Smtp-Source: AGHT+IGmA0SCHCeIsPk1y2tIXyDXtM7epxzbrD67uIBGUE768i9JTMr9+9LRcK3juoBHtZvITnWGUQ==
X-Received: by 2002:a05:6a00:cd4:b0:7a2:7d0d:80d5 with SMTP id
 d2e1a72fcca58-7a28680406amr3894648b3a.16.1761342902881; 
 Fri, 24 Oct 2025 14:55:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 4/8] dumpcap: handle pdump requests from primary
Date: Fri, 24 Oct 2025 14:53:59 -0700
Message-ID: <20251024215456.282171-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
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

