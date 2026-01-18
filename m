Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78745C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B750A40E64;
	Sun, 18 Jan 2026 20:14:30 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 0138340EE1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:28 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8708930695so565278066b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763667;
 x=1769368467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GHJWMvwMXtNDA/r/FJ/QR9opUIo6yMYrw0zYbq2G2g=;
 b=hCQV+xDZe8iaUusp1KF5eijrMZyzH5nqxc8HMuqQFRgj3Y6l0bM4+MCYlzuuWzxvO7
 xanmtWIp5IkbxqIjmrlWbGzR/RIkXo0Pj23cHwZco/meiEXW5411IB6LvvSlhFmkyviL
 htoWxpMS7gLSoQN/pss7qg5QllfHEM5D1rNojalL87Z0qHXDUht9H+/1SpiNhQZPARWI
 +Bvcfs22DH0yqN/jf31xDs17QNQhFOn/Eh1L7ZS3LoaY6zOLlLUpIOY+gpqFoRbsof/R
 GSQOkT8T9YK9ah9ILQdQUCnMM9+REfQC0ImoIqAmajyb4pZpiGR2f1D0cbsWfpiSgUxV
 2MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763667; x=1769368467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GHJWMvwMXtNDA/r/FJ/QR9opUIo6yMYrw0zYbq2G2g=;
 b=GGT6dn6ZNPewnDyHB/ZXjuVnwmPQIuHmetM3KkaVOq/sSbWSbMRJErbvd8i4jSbyYs
 HW1wpEZupmDJy1AXDHsXv7bpPN6Vca0Yx7Jiih30PsmceZ5qck7JyqPPFFTZdq/G9uFE
 VS9GXYNdrr+ilWNPblDnTwI2wfKKHZKBuJD7FD9TktVUMMo6m8TLnV172XTnSz1sB9Gp
 P68fxsB1n/hl5JdAZ3GBZzfmqZG3Dcmh7N9nKn37DfJweZvGYSIhPXJWDE6dkDXDo4zc
 T5afBGbhxWarQh0bAzB3zaLifgabOL5odNZt5xJW91/tlCMzOeTV+E1s6aM4WNucGtj+
 1Ivw==
X-Gm-Message-State: AOJu0Yxv46DPe8dX0aNUOwoVzDEOJsmr6fwuG2loenL8tq44RbZChuW8
 xJf1+VALZvBz5RNgz4bGpGd+OrGg2ERw3eYk0it+Eerpz5PcKjYG97DLppGMc/9Dxo9WHbTPcLF
 HQBYE
X-Gm-Gg: AY/fxX7YgSKirl19HOlKXGghAn4GL/kGvfA6MpHBZt3YDzE7bIKPYMo46x2irapc+w0
 p5TJyP+UDdl7o6/DRXI2ARNDU+q3c2YpOmLKhU31WTPNcgM2Gt7sw596ODusri7dxzFUutN0CO/
 UfCTIum8fToK2FUEH4O7K5gg8KjVfVzwMmkVTtlLIT4mviQDLHOcnLsueHCmQCgJaO2kncDG+Wk
 cCBfDWgWzjlmwhJssBaiLrOnaZVlUdhUj0h+sRQeXgiGr/L1PgAaxFwuHHR/greCWl2vgZNFcqe
 eAYrogdiJosVNI37iLUC2QzkBMz/r9IacogecEGEnqMO035LL0UOlz55pf98fJWryB0MKkw+oAr
 +/aMODqZx8hrXDm1sZv4XVSx5haY+Nw0H0GjQNHx/tM6l08Bt0jOSEFGe9qiUl1K3SjaMQKtpqV
 oVYSL//Cm51VD4q818k5DLbWOJ+bDgYSSL2Jkhyj3zWHNQ4nzM5w==
X-Received: by 2002:a17:907:d17:b0:b86:f926:fbc4 with SMTP id
 a640c23a62f3a-b8796bb1d74mr790314166b.58.1768763667553; 
 Sun, 18 Jan 2026 11:14:27 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 38/54] doc: correct grammar in overview
Date: Sun, 18 Jan 2026 11:10:41 -0800
Message-ID: <20260118191323.241013-39-stephen@networkplumber.org>
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

Correct various issues in the overview documentation:

- fix typo "Mos" to "Most"
- fix grammatically broken sentence about interrupt driven model
- use consistent spacing in "40 GbE" to match "1 GbE" and "10 GbE"
- add missing space after comma in LPM library reference
- remove extra space before doc reference

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/overview.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/overview.rst b/doc/guides/prog_guide/overview.rst
index c70023e8a1..a22f51e8ca 100644
--- a/doc/guides/prog_guide/overview.rst
+++ b/doc/guides/prog_guide/overview.rst
@@ -23,8 +23,8 @@ Longest Prefix Match (LPM) and rings libraries are also provided.
 Sample applications are provided to help show the user how to use various features of the DPDK.
 
 The DPDK supports multiple programming models for packet processing.
-Mos of the sample applications use a polling mode for performance but
-some of the samples use interrupt driven model is useful for saving power
+Most of the sample applications use a polling mode for performance but
+some of the samples use an interrupt driven model that is useful for saving power
 but has additional performance overhead. If available, it is possible
 to use the DPDK with event based hardware support.
 
@@ -140,16 +140,16 @@ The library documentation is available in :doc:`timer_lib`.
 Ethernet* Poll Mode Driver Architecture
 ---------------------------------------
 
-The DPDK includes Poll Mode Drivers (PMDs) for 1 GbE, 10 GbE and 40GbE, and para virtualized virtio
+The DPDK includes Poll Mode Drivers (PMDs) for 1 GbE, 10 GbE and 40 GbE, and para virtualized virtio
 Ethernet controllers which are designed to work without asynchronous, interrupt-based signaling mechanisms.
 
 Packet Forwarding Algorithm Support
 -----------------------------------
 
-The DPDK includes Hash (librte_hash) and Longest Prefix Match (LPM,librte_lpm)
+The DPDK includes Hash (librte_hash) and Longest Prefix Match (LPM, librte_lpm)
 libraries to support the corresponding packet forwarding algorithms.
 
-See :doc:`hash_lib` and  :doc:`lpm_lib` for more information.
+See :doc:`hash_lib` and :doc:`lpm_lib` for more information.
 
 librte_net
 ----------
-- 
2.51.0

