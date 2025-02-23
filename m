Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751CC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 21:41:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3105402DF;
	Sun, 23 Feb 2025 22:41:31 +0100 (CET)
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com
 [209.85.128.99]) by mails.dpdk.org (Postfix) with ESMTP id EB345402D1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 22:41:28 +0100 (CET)
Received: by mail-wm1-f99.google.com with SMTP id
 5b1f17b1804b1-439950a45daso22620045e9.2
 for <dev@dpdk.org>; Sun, 23 Feb 2025 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740346888; x=1740951688; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcn35pJna9h3p7s3FpDOASY6Inc0i+PHwDk1fuGIRDI=;
 b=bPNxTMVJ0/71NBeS48NJ7mV5/Ag4VWhbj8Rku8xu0OPNGSLBOmR9IBJp6RNBs5z5pd
 cW3fDUuG7eq6obBs9KIellnM6wl1fV5qEVIsP+F+eMBUurIEuACTxTib/kempei2cGYO
 oNrEt6nyA1QOtXbdlDyPEvkYpATXGW+yBL6WPXUw+pJ3lwk77o1TGznbUyiYFwZy0soL
 cCsJy4bH18sJIIIFPhjpqsMjFHav7vayAI+t6D4iH9vs7LIt5fGVbQjqIWcTU2+WMhiT
 Sw5ML4x1+w55IDlsf/Mxl710xaseUcXVx2LIM1jNX4Yg3H4ogzDoumqfanFLNDSCDTzJ
 Y8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740346888; x=1740951688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcn35pJna9h3p7s3FpDOASY6Inc0i+PHwDk1fuGIRDI=;
 b=ksED4J6jVc+hyAyLNIPm3r9bNzNLxJ7e7I7TDzglnZIFQ7yl6UzhB3/1ZDbQovEP3G
 qXYQ8Mj8wfBNds1KLMrUCXY3+7TI+LztJV6NWNcpWWStJB9JVpRQx5EkyQ8kd5tOklc1
 AcineCAx+H4CYfWJre3XAfgL8kPy48yjcGQ3vMimUANESQzafO82f6wmFM6NBFgx18lC
 a7K8RSJgBy2JKZDo30+vEhBqfL1pXjjqwRp46TminWq2t98IoxgMyezx3aiR3/Zvbcch
 ljyb4HQqTvvXukqx61eGM43YVjV2mzEAaBwuJ6g4Xi24y6ytwiB3Fhkh2KzxmZLKL+/O
 C79Q==
X-Gm-Message-State: AOJu0Ywy+jASIZJ+x4NXtZgTfQrYtENhoB7JfXxQ3LgwrAUpFO+zB2PV
 gq0J7akRAkHC0Mh1qXcHvVU7BCs4lE0NsB/vtTLOxIkCx0F/xyb41Dx8ZQponmPT7fe37mBboMd
 h6md+2e8YfIl7rLxFpbAXvQGSA0luW75iKw7JsiyU
X-Gm-Gg: ASbGncs3ZhbQqrRb32o2nRc3stZHdwT7Aa8PHIHOk0TmqalMdHeN9GHG4f6itoPb1Hd
 4xPt5f7vfDY08upWOcFW04b50ubxodN1LnLBzUPQKTAGoGMjcM1BmXNyhJW9yzG2fagha9+hgti
 l2WWgLXLIPL3OkEYSjb7odnd4thJC508kQDWiyZTsCRSwCurpDxwz4ZljJtRUKeRIY1nzJYPy/P
 QbdRsLS+roZkKFRGVLTLuJq/eepFlxBuSA7+bniSJDnVg3iGS8KWb8Yu56Wb1t+j0HPwZRSXYTc
 910RdDhU0zjWfR7rpgRwF1erg2dkKS32Ge3v/Gk1AJAn54ZC3bAYbaGT+rDK
X-Google-Smtp-Source: AGHT+IHT9AX1SMtu8PS5CE0AcbcN/WgmzjOlImWSnf4SiUAvMkv+TpxprnT0WhJyCCoDaGCrUDlF27yQVnhX
X-Received: by 2002:a05:600c:3b93:b0:439:96b2:e9b with SMTP id
 5b1f17b1804b1-439ae1e6a3amr75376745e9.9.1740346888461; 
 Sun, 23 Feb 2025 13:41:28 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-439b037040fsm4997805e9.45.2025.02.23.13.41.28; 
 Sun, 23 Feb 2025 13:41:28 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 5821D14EF6;
 Sun, 23 Feb 2025 22:41:28 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
Date: Sun, 23 Feb 2025 22:41:23 +0100
Message-Id: <20250223214123.447579-2-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250223214123.447579-1-ariel.otilibili@6wind.com>
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
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

rte_pcapng_close() might dereference a null pointer; as example,
PVS-Studio gives its usage in test_pcapng.c: indeed, that call to
rte_pcapng_close() might receive a null pointer.

In that case, rte_errno is set to EINVAL. The API is updated accordingly.

Link: https://pvs-studio.com/en/docs/warnings/v522/
Link: https://github.com/DPDK/dpdk/blob/e5176f23ae8b31437c3e5eb875c81f95bf3a9942/app/test/test_pcapng.c#L438
Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>
---
 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 3 +++
 lib/pcapng/rte_pcapng.h | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb591b..ea68d6180ccc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -135,7 +135,7 @@ Anupam Kapoor <anupam.kapoor@gmail.com>
 Apeksha Gupta <apeksha.gupta@nxp.com>
 Archana Muniganti <marchana@marvell.com> <muniganti.archana@caviumnetworks.com>
 Archit Pandey <architpandeynitk@gmail.com>
-Ariel Otilibili <otilibil@eurecom.fr> <ariel.otilibili@6wind.com>
+Ariel Otilibili <ariel.otilibili@6wind.com> <otilibil@eurecom.fr>
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
 Arnaud Fiorini <arnaud.fiorini@polymtl.ca>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b27cb46..d2cbcea42885 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -716,6 +716,9 @@ rte_pcapng_fdopen(int fd,
 void
 rte_pcapng_close(rte_pcapng_t *self)
 {
+	if (!self)
+		rte_errno = EINVAL;
+
 	close(self->outfd);
 	free(self);
 }
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 48f2b5756430..f7b976987320 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -60,6 +60,8 @@ rte_pcapng_fdopen(int fd,
  *
  * @param self
  *  handle to library
+
+ * If self is NULL, rte_errno is set to EINVAL.
  */
 void
 rte_pcapng_close(rte_pcapng_t *self);
-- 
2.30.2

