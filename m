Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C078FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:49:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E22406B4;
	Tue, 10 Mar 2026 03:49:34 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id EB4FF4067C
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:32 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d1872504cbso8932534a34.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110972;
 x=1773715772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=noyZYmkRHjkJQeEBTymBUh++VuyKIJSJZLvlq9Iw/T5DHKwEuWsKW5NF23W8tB4QxH
 5dguiB/TKjFsr5SUPMaqnP7cCa1U5XPnMjP3joPPY6U18kD4rvbixnK/blyjNgMhAUXR
 YLWH5FtFjDm8DvJGLqQflPToBGVw0GPpy0fMiMighYtpRI7ju7rOnyTmRMKDCTFnDdXt
 aZIjoVBfjaBUMUp/nE6ZomLHWEQPGwb0GYBKocoRY4k7R+9XEoT+u4uMZZVpLbqq1Ybn
 zt/iIEVPtXRfFweSQba+2DX1LZBUyNspGMkvZ6Ar/CQWTICncPRpPkzexcUBzaJkAgUo
 NjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110972; x=1773715772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=fIFj/pUFBygRaQQrNufRoccYM62BZETEPn82+U4n2K2pSAD5IdhoYXlabR6bAKMYqN
 hT6dTPaOFWIugGu6/UAXEBxiV/7yyFOvhvFl5eFvpK413h8Jr3MuvYq4Hhb+ALzQQn6M
 42Sxlver4Un52uFLjoJCyQPHGjy4OlxZyhU/GzWIg+z/hi7sXOuQEay2CZmpwRqtaCYB
 LZd+EVV2FwB8L6DH1h0IWCsnY4YN7DOvgnfj/40f8lTrUhWqCAIFUXSW5lbit71ujl3e
 COshUrUV6OKrct5I/23psdUH2MRpqeOeXNOfK27pNb5wm2aRCF5Dd/VtS34+a7XNJY7w
 799Q==
X-Gm-Message-State: AOJu0YyGdRHpS+cu6YsfB81nUZ860Ev3pRKT0hWYO1hfVmRE3NRE5dFt
 Pm8nWQg8f4ZmuJfE/BT+rJ0YZKp06dcPluflmJmSqORz+RtTI7Z4QO9+7m3GhuRu/e0W+PoJ9z+
 IOCfzL+o=
X-Gm-Gg: ATEYQzzBSpMKT6/fmN0QyWStjk0BioNbGKqW8chK6pC13C8B0wxTOr9q6iCqDPHhzIZ
 bmt7PqwID8gSCj1OqQSU44JaP10ZCZwSoYlIIwPCgFt6AemCknKpDr5p5ztRLOcWyQATwpev1Ro
 32hXP8BJB8D7H+j5zl0bnccBdA+/ZDRA3T6F2oVD2QKgCRvtaPnffny8cZ8CsaXdig3XqTcXqIK
 AjZMlU29zs2uOmhRiwMXhwc34Wwq36pF5y1EpylnX8JD7/qmIpPKAyhG3Su7BEEjnnBDnYUjlzX
 TJvRkvVQsLP1GiOhwzS6K2ZaEgyELWQ45WM9QXtxH+MW7Pu/cm1LaSPZP2yhk7Rnw6jpTJtKzom
 kPhWKig63h9ZNis+JvczSM/9/HECN0RZuFHLPdB2Ob0B+skbGwELh82dn6Wt4l2HKMmDvxFkDR7
 Drej81+pygCLsYTkMufcsaj7daTBTx24Gv
X-Received: by 2002:a05:6830:f86:b0:7d7:4de4:2f12 with SMTP id
 46e09a7af769-7d759aaf8acmr1232445a34.8.1773110972262; 
 Mon, 09 Mar 2026 19:49:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 03/25] doc: update features for PCAP PMD
Date: Mon,  9 Mar 2026 19:47:38 -0700
Message-ID: <20260310024925.476543-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..c4f0360a06 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

