Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B8C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F0D42DD4;
	Sun, 18 Jan 2026 20:14:37 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 5E4EA42DDE
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:35 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8708930695so565287366b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763675;
 x=1769368475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GxEIclen1uXijooDnRkNzpg3hA8SNv/szoHy0uUJco=;
 b=k+7Big3qbU4Bc4aHYCYxxosEo64ue/7kOngMauz5QtHIfbZ1RdriLPDuD56CxSOHKL
 32Liaf+yLxIGhK1EWCFrg66tM/EDehj05cDmRisrbIP3Ht2d5c4mDrhvuMKbr1N+waAH
 sMJ3WWnaiMWmgopER72VTo90vhvOat6Fy9ExrA8arPttVkJMD26nm95urkrptD+DNEyf
 QpyCEPjEcJaeGlycMZHdxwb+eqlX6/iK2yrzhBLa9SyMrOtJojCZ7iZMCuFp/qf45do7
 F3Rjm8hRrjndqmgxxS6SBvdTl0Tr9c7bH97IGKgeg9xLTNrNNxmTgP67lC5z2GhGxyau
 UFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763675; x=1769368475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GxEIclen1uXijooDnRkNzpg3hA8SNv/szoHy0uUJco=;
 b=dXayTNplEP6W0tzpDKUTl8utXPfxW9wLKdXBLbUmzmh/OGiiZkCHTlXvx42PScOlN8
 /pqiogOH1KvRxCoiSgvUPRUJQU3WzeBoewN3DcL4Ati1rVTEJ+2nyQbWL5dFyrvS+NdO
 LJ3/yAM/Fz1RYhGAGpI6IMvSsShBooxfVS31fHbLfthE7rt7EBIQltjCqiu4j0ppmusW
 0XnXM2zog37ZfHDENkNEeiee+f5QKwdPEse/eqdS0MdT9n57bbNGSAn49pNge0pXWn3G
 k+/NObJ18VEwRelpcKmBd+yQfDs1qTi1YgQOlmj2sSb2yPMdx7TZ/iq8LbBhNVw83H3n
 abtA==
X-Gm-Message-State: AOJu0Yx+tKG6XIf8id4pMvzS+8IfYlmxNY4Icza7aQnb1h3wdnB8+HrP
 9BElrijHXKZ5/vZ4uKuVCr/2QNNAOPI4nFYE1kqQXdtAPXQ/mYFPFLROLuUFWcE+9kfIMlhzrCc
 wqQ3v
X-Gm-Gg: AY/fxX4tO+CurhCyI0QAmeGvPPhYi4rTF/JcboFWRSY2kltWKBIe+5na+tYGYgqY7Be
 6Ac+WcW1SuMjgvT56VVN1WbpzU7OCv7LBK7F66L6ZL9abH0yxDJk9Fr8cqdCHBms6c7TfvrI30r
 aqQE2c3xzIQqoFn654VsRdYMsbNsYsrKIH1YJD2g3z2Tjhnw7Ne+GQp54Vz03Zp4HmDz+gR2NWL
 dP7llzqxo6oQz7aG0eZLMF7YJpNkiiDAnx8GcMfr9z4n/d7l7xvKRHf4yuulmho9l/meLL19Sth
 zQ3piT1DxkGQKxnqIPUuXMClkHl2+ur0+X9SgSTOSdhn4SywF0iOn6aAGiBQ36fc8UDNJiW2uex
 q9YwC/xJSkdIQhk6wyd1M6vcoRsVWgaK1pSkNLJSPiBC7cbHfynxeOJ/x1PbfCKGqsR3v3UB+Rw
 h5WTIqlECNVsPtBx7aTY7onuD5Xg0Jil27ppweUNm3LXLNh9PzRA==
X-Received: by 2002:a17:907:cd0d:b0:b83:a32f:8106 with SMTP id
 a640c23a62f3a-b8796b3746amr829172566b.46.1768763674936; 
 Sun, 18 Jan 2026 11:14:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 43/54] doc: correct grammar in pdump library guide
Date: Sun, 18 Jan 2026 11:10:46 -0800
Message-ID: <20260118191323.241013-44-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar issues in the pdump library documentation:

- fix "both...or" to "both...and"
- fix "maybe" to "may be" (two separate words)
- add missing article "the" before "application"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/pdump_lib.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/pdump_lib.rst b/doc/guides/prog_guide/pdump_lib.rst
index 5bacb49ffc..d27385fef1 100644
--- a/doc/guides/prog_guide/pdump_lib.rst
+++ b/doc/guides/prog_guide/pdump_lib.rst
@@ -7,7 +7,7 @@ Packet Capture Library
 The DPDK ``pdump`` library provides a framework
 for capturing packets within DPDK applications.
 It enables a **secondary process** to monitor packets
-being processed by both **primary** or **secondary** processes.
+being processed by both **primary** and **secondary** processes.
 
 
 Overview
@@ -76,7 +76,7 @@ The library exposes API for:
 .. function:: int rte_pdump_stats(uint16_t port_id, struct rte_dump_stats *stats)
 
    Reports the number of packets captured, filtered, and missed.
-   Packets maybe missed due to mbuf pool being exhausted or the ring being full.
+   Packets may be missed due to mbuf pool being exhausted or the ring being full.
 
 
 Operation
@@ -128,7 +128,7 @@ What is the performance impact of pdump?
 
 What happens if process does not call pdump init?
 
-   If application does not call ``rte_pdump_init``
+   If the application does not call ``rte_pdump_init``
    then the request to enable (in the capture command)
    will timeout and an error is returned.
 
-- 
2.51.0

