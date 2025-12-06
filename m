Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D236D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 655BC40691;
	Sat,  6 Dec 2025 19:44:48 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 9803B4067C
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:46 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42e2ddb8a13so1506184f8f.0
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046686;
 x=1765651486; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=sZmN+SdClyr1BkqfuLYl4orhFLQucFyu1FPbcvXW7/40REX1PKsE/3CUnmfzR3rPJC
 K6zuXYg8pIN/3wVHYFNXe9SnMTnk8498cvuLtGdMlpf2iwR0nX5V+GRNaQ/FyJ5HXXcf
 8/hqiCk918aAgfP/1iDgESZEQ8+7GElFVU1gyrEtmvqTTdNUxHcDh7XBIii3drmC5z8W
 WfQynLBiGIykjV+Gql78N2Wh+LM+uyQK1aM4mSHwNTF1xs3V/WxwlBZbGHLyotwEgoYt
 7PbfhR/vL7mp+xWLySgUMu/Gha2xaoDOhzGyESz1Yw5d449n2FKNwmj1p5bqHXQtzvAQ
 L+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046686; x=1765651486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=QeB4DFD4chvmfPp01PvYLQnI4Dmd9Fcq2dE55+fH+flwAa4pf5KKHeMAFvtl3crNw4
 A6DKAWKL0HXzDmznH6zCcKQ5lti7ENQSyBFGaj9MlpRbH9nnBjL4vVmuHCwbovzeObxY
 lWe6Tp+Wq2cub2vGjit98r2+c7dNofhi8mxAiCuED1ocZK+lZMc1kMjZo8K6LYpA3qOJ
 UAx4zhBoTIL4c+IHysusgm52DJRUJDgDvts1chkZl/Io1icvi8z6DS9uAKFYKA9dHEIk
 xRJt5mwfU16M4JqJjRp5hsW+H+UtruC44iqM2sMJqj8ZVm59Q2XgdT6f7wVzcHBaT1rk
 ZL1A==
X-Gm-Message-State: AOJu0Yy1SRzVklYmnxxATWxmk4QHywqs603j4vMnHCybI+BeQShi+jWf
 AKwOJtsqoq/bUNW61WWTvGoTSylW1ppI0lvrQJK0eMz2PYVcCSmR2KyE7u5PGZSW8c1I7U8r4t9
 2CZF3
X-Gm-Gg: ASbGnctPX5wxT/xOwtgPy9eC4jdPjtfVGtKOasQ4HrLEZS7M6Pis6UbfcTpNjpq28C7
 UX2a8t1dh1eSExLDqXm/DfE+uxfH3z2RxWdsfAOXhYyHvn/n4ScOosM6Eid+t4M8Rl/O9fc514w
 9CW10rzzxXLeDMr1smcixuOzhVT2rpMmDdNJXG/H9rc3RSQBLO8BZEAyLw1FJlJaH8QUpW0jiul
 JqX2rX52rFeMzkeSe5de+5LW0W5ireyjqcTfYSGweqIeEDMNI4YGT+GjpxHyFIwkgqWBQNXT/t0
 BWKowpqQLaLuDQ63UVyBt6NGTyzlCFQ6HXMzDfc9J4tbwZwzp41oHK3FFCcq9oeOBpFSQFzv2jA
 qY8CjSvSILD7cpCoCQfUY1G/hlIGAONy/lhufHij8EGn6f0W8hII5ps5nwVBBQgBhguJFYXEj4v
 iLZPnCiQvNJmrfheTQQEtPWLsDYc/G29Y3qIHiUTnQa6DCIjpr1Q==
X-Google-Smtp-Source: AGHT+IFkgJZJgUS9AOEUKo+js8/ezcB+1iM8+yGVN1B8qSwyyI2tgFLpyTJp51JOhVms9BQvjSXiUQ==
X-Received: by 2002:a05:6000:4006:b0:42b:31da:18b1 with SMTP id
 ffacd0b85a97d-42f89f63deamr3311946f8f.56.1765046686192; 
 Sat, 06 Dec 2025 10:44:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 16/16] lib: enable format overflow warnings
Date: Sat,  6 Dec 2025 10:43:17 -0800
Message-ID: <20251206184410.542725-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

