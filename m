Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B224C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE32C40E30;
	Sun, 16 Feb 2025 18:01:28 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 713BE40150
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:24 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-22128b7d587so4725225ad.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725283;
 x=1740330083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKsHwBy4OeQM441PNFrvjPnAsOJIxD9G/WylTgJ1y/c=;
 b=1B6eauzhcLcwcSG3deUIBAwtAnR51gBriPhphpZ1bV4FOeqJdXwq9zZjc2gASFt0MJ
 1GPwYOH1J1oeANzdKc806dnFlefqKScSL9fzUY3cRWIxrq8cICEDTR61ffw3zaYsqj6e
 758m7FFiI2OSOrzae22li7H7dB/ootmrFk/7j3WwIJKDQF45RGzUTyeSUDsnmOQITrxu
 EV/4dEfbmRm8LvIhFSK4WQ/tcGftsj4h/R1jY6cSd0sGf+Fcma123aQqLAWmcs/Zp4Jx
 nKiHqLcF6+qO+o6oyd2Ekeg1QH3REwnrVGOhx4C4t/1P9kMHiFYwJa8oFXrPr4ele5w2
 9VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725283; x=1740330083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKsHwBy4OeQM441PNFrvjPnAsOJIxD9G/WylTgJ1y/c=;
 b=eCNfzOmd8zmOln61zaK30SpLnozGzhZR2soWzVFbeMqZY0lSah7AzuKKTC3282gGES
 YBI+IXPsUuTRnV7QQ4MXLP+sZyQhdZQXiWfjiLwcbg0D0X/bHxbEw0fcA6JDS59jXnGd
 qmQwn58AF3k8c+cTXsaQIy5mVi6Y9ItvDmQxjg80YSqQ5GUZZClE98StnQWxGZW6LHn+
 7zrczXWIjzQY/14U9+I0cwmgc+Sqw1rCufBH4Oe70qXPvAjXyBqgXkws64Ihv2wwBuRW
 g4SfeYYkdtlZRqjx2rqHIns6OSr7XXPDLo22lO7ij48tE33furqm/+uB9MfcIms1jyVq
 BPFw==
X-Gm-Message-State: AOJu0YwE0qOnt6U3tH85VmmWU6XuwrswzDjhQnfTsUFiq90oxBD8IOoP
 sYrWwQumFWm2cdgvqY3Ot1KieOO60KBxPA6L6v0/wVI0nsIVJZf9oef60A4j7IV5LKOOV4y+XQM
 j
X-Gm-Gg: ASbGncvgLm6Btxm3mAdSA9q56nf/N6JwcdP1EkjHKYT+lc+dddToGGQHSxu4M6oMOXi
 +5HVKXbFI8v+Cu62G+Lchk6AgQ8TzVlbBEX1l53O+wiCFWK39GY5mjPwjywIpiZpQCV9ZUO2SyO
 DLQRqsEk2wpZoYBPpqX5VFHOOnzouQV6UwAIy6Dh4Oe78bzO6kGfod69lYWOaFuXE/4e1mNYDXR
 qMZlZefvxzXO1neB3EkUniWSNGBWq4rEmq9zjzPYRvVzNFRXeuhWq3S9jqZZSfCiMyIf4pgPbQG
 Moewe5ErNPj6SD0TE64MiC3km9pXsudemjjGlxFbW+JpjfDEo0UR+l6Qe390abVHWnq/
X-Google-Smtp-Source: AGHT+IGn1dpLr85/rzPN+mZ7S7mJ/u5SQ3pbWgdxlx9G9uM5pPHh/56Jp0DIFiTuWIU5NSWo6VD2VA==
X-Received: by 2002:a17:902:e747:b0:215:a434:b6ad with SMTP id
 d9443c01a7336-221040ac0f9mr111197165ad.33.1739725283494; 
 Sun, 16 Feb 2025 09:01:23 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 04/17] app/test: remove unused variable
Date: Sun, 16 Feb 2025 08:53:03 -0800
Message-ID: <20250216170110.7230-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

The buffer tmp is set but never used. This leads to warning
since the memset could be eliminated by the compiler.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_cmdline_cirbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/app/test/test_cmdline_cirbuf.c b/app/test/test_cmdline_cirbuf.c
index 8ac326cb02..f6361d49e9 100644
--- a/app/test/test_cmdline_cirbuf.c
+++ b/app/test/test_cmdline_cirbuf.c
@@ -251,11 +251,9 @@ test_cirbuf_string_add_del_reverse(void)
 {
 	struct cirbuf cb;
 	char buf[CMDLINE_TEST_BUFSIZE];
-	char tmp[CMDLINE_TEST_BUFSIZE];
 
 	/* initialize buffers */
 	memset(buf, 0, sizeof(buf));
-	memset(tmp, 0, sizeof(tmp));
 
 	/*
 	 * initialize circular buffer
-- 
2.47.2

