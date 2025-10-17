Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C983CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CAC042E4A;
	Fri, 17 Oct 2025 17:02:59 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 85F0242E52
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:58 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-27d3540a43fso21818365ad.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713378;
 x=1761318178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73nNz4S6eFLymqe2uH5dhcnw6AALc+feRApE2P8LHUc=;
 b=Y6TMaj/HBLwO5ez3G+2bUgWcXGM7CGslTJR069CuPcpX+vfz0VvULAZO/TbXLPSLBd
 xyc3zrLIkNiWLcqqNgdOwd5FOXFD4eABB3XX01wxBultYhyENtMVZeJVZgiTRpqOkDVK
 MkCTAudE1zeV9ODTHgCeuQxMrj+lfg/rTCMS35kD+3nXDy/RLRo7PpVp9kYENLHtWlVq
 iGdIwyoHMB+ig7ep47vDTRevfNasO+ExMtVJlrHQsKUd+ZlundpP2ODv5/i8PurBf3kq
 RZKJimVnGEV/6cMsEJlWBxnZJ+DPQDmqB0ssl6870mYzhaSafDYcO4G5RU5WndM5pqUN
 A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713378; x=1761318178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73nNz4S6eFLymqe2uH5dhcnw6AALc+feRApE2P8LHUc=;
 b=fq3eW3yPlny1aIRtoq3Fts5T52zoHhyHXq+gaQARL7JPMUhoDKCI/0Vz0EZ6EcHCgb
 LtOzuomFMYv7Q5Ijg4kilGs8kcZnnsrPD7gLbhq5s/2ENnCw3Q4L9UYH9SuyN04QUjy3
 /De2V6adfVFKnQp+tCvS0RFg7RtSV7DJAC4RBFhlVux3Ydtdx0orY+Razo9YIxhoNK/7
 sFPouS8ZKRfzAIv4OynIAelKEao7x1zsQuHvcYi6sl+mFx4n26LXqfNIaFiVIJY6jHkl
 w6gDEygeJs5/JMIlY+/q739c0MuBsnEvsnBUAqlXSxSsqVhrRnsDLB2vbLQpp3Mhl1NI
 S3Ew==
X-Gm-Message-State: AOJu0Yw/tvCh5R77Hbb/sbTIOxXrc/1v5e8Oh8jeOfqT+A/Xgz9tTW+L
 mSn1jqtzl9hMcvmBN1QLMNj3AgUgwioSVEaYrDnZMgIqOGnvc3fgNr9CaC7yj31JyX3kJvjeBEp
 VsGcxGqU=
X-Gm-Gg: ASbGncuJr5naTHq8I2flV6VxjanDXcy0MDXyRZWP8jlIZyYTS3PmGIisavv2wKSQ4V1
 o+7M6UvLRZWmC9QOzOQqDZyEsD9YZzX0jxMfBpa5AaltiqHLmpSfiaNa0pi/0UdHHFwl/fWjbUj
 PthLnTQQCJEusHm2v29vlqrs/sq0Dozz9QsgID3LfxqtGmDMY2hpoBJ+/oBvIVGFVfl3f0hcFRj
 OILtJ1gNGSA6sw8NdTOt5pWvMtgI7bv4Pd5+Oz0gS3rBvNc8k4jToEiJ07RGwsp8I9jF8VQNpFk
 +AjeqOyAkqT8LtdDVyODJakftR6LYQtpD5ZFYbFpMPRlw8nvcbGXIORwYKydouVPLDCmxhaajXR
 r39gyOLMne4Vbc57hCojcvH+t4To1Mqsv7Rym+nuRHaPPj3h43ViOUvy17hfJffK7JkgfqsvQTl
 4W2tZqWyOKajikKmsvLEF87MfLJsoA2UwQH3wT7SSNdXgSlU/9yQ==
X-Google-Smtp-Source: AGHT+IHLL975JTp3TTTuah1WjcqeM+qZAMrlVNKkK7mLGTqE0ODdswUA73sp4Ao0KjL/zb/OcdlsNA==
X-Received: by 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id
 d9443c01a7336-290c9c8c7c2mr50162955ad.12.1760713377576; 
 Fri, 17 Oct 2025 08:02:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 8/8] config: enable comma warnings
Date: Fri, 17 Oct 2025 08:02:09 -0700
Message-ID: <20251017150241.28511-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
uses of the comma operator.

Don't enable it for drivers since many drivers still use
comma operator unnecessarily.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 config/meson.build  | 1 +
 drivers/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index b8c1f127a2..0cb074ab95 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -319,6 +319,7 @@ endif
 global_cflags = [
         # additional warnings in alphabetical order
         '-Wcast-qual',
+        '-Wcomma',
         '-Wdeprecated',
         '-Wformat',
         '-Wformat-nonliteral',
diff --git a/drivers/meson.build b/drivers/meson.build
index 6ae102e943..3fe3be48fb 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -86,7 +86,7 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
+warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']
 foreach cflag:warning_disable_cflags
     if cc.has_argument(cflag)
         default_cflags += cflag
-- 
2.47.3

