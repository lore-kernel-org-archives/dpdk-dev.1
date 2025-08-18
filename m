Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8880BCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F6A040677;
	Mon, 18 Aug 2025 18:18:46 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id B447840677
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:44 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so21742085e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533924;
 x=1756138724; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdhDtaTmlEWFzs+dxSugpmiVPjfmT+1AwZr84TdS624=;
 b=E8SAHfm9RVzH13xYvYZW0f+kZPCiqqY6ATJU81kjqAmIcASax5LyHJaSdhBB2bokiX
 SKiOMxTwSN2ul0vCXQY+Cc725wCn2AgVsr+ZIt2B0FZrKn7Qrbzd0Za6qqtmjAR5aVrk
 UYCdqWzVfl18DJxJuoNcg5C+CZWbdLVKSKLgbFYjnuN7c4VbOyRWN3GPIJLNnfAVil64
 ofdKy1X6mdGPpMCJNb2mKcKos3K/r2ChvdCNkHTFcNfq/YpDpX3gyE7IRGaA3Y2Ul8zU
 f7xCqQ5Br7ZdUNERSvN/7FbbPMj1DWfrFP8T+RTWaZJr9APAuYF2clkPok3dRdplBS83
 7Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533924; x=1756138724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdhDtaTmlEWFzs+dxSugpmiVPjfmT+1AwZr84TdS624=;
 b=apPHbSm3HT/u6YFviAZYRi7mHGHtbJlM8oYoVe1Uf6Ib0xwxSt+EyJBJ8ilnF4gtNb
 DbQ9TSe1jUVoxLEk8khBlV+voAqO3Bff1+tsYLdRD9rSCmjNEvqxLy/0HqJdZMtVFAXA
 mvO1sG8GNUQ0ftDu6PmNzNQjyNNKXifCunTzwcOz1TKl+i+g/qPHN0ZecCR9ylV7Tbkl
 gZlsEUZHUrqzjtrMK70Wk76arL5gNoLj04ozLgBxaWBqhnqPZpRep98dvdSmuoJMk0tc
 xJt40aViGPzX0hAzvZ+ntknOt6uchVzlFrPnRlxwveAI0Put5Ohy9ZGwRFEaakrjLyUa
 RNPA==
X-Gm-Message-State: AOJu0YzijrK/Q++VfXpKZk0j8JoDtQK8xoPe/xLgCPHVgY4SiNjckSB/
 LtoVI0UqPPSi2dHk9MuHMpv1rV4PqWiWKFROQl7bfK5vwr9HOdBYHrS4Br2m3YdFdReSmioy8eI
 vpjbE
X-Gm-Gg: ASbGncteAxxKF4F1XI/xaZjQjpovbo9YQchMxN7y93EkeADfLpzlMT2P6H/SXxVs40V
 Vdyg3v7E4xmnc8ipTFf+aBOdFG2CjIELuj3jD9QrBrZraEUXIbbDOSGeTPQyOsBIqJ3WjN4GheW
 ecIcOQKR+a+lIHT7WaFK5Kbs+69TgJb2/aZRbRJwm3pCrubLXNz04f9rR70xG2bi3gEwtawfKZa
 J64o9nYXoUu5GhHFha2BGgLMTF/tkiphPhvkfVy/ptELkAbZ/3pcB8F069gw5FQMNKph1XXvj7U
 R6CmQmwDq6EHajH860bamtwrObtCU2wfsrkW7WGsmyINaDeWtbIRJ+CtK/zGHQi/MERc6gFOfHI
 UuyN9J5kJu+SKTew1Q/shPSi3Xshzytop2sQAbtl4Z72N8tWoW4l4f5TmV/BLM0cLf94twesK
X-Google-Smtp-Source: AGHT+IEBdLnv+cgiWeK80xqkRmC3KSJk1rB+Xdrt+Co0LPYQz5LsH0EPo0BcbGSShUcDWTQjIy3cbg==
X-Received: by 2002:a05:6000:2c02:b0:3b7:942c:5450 with SMTP id
 ffacd0b85a97d-3bb66567dd6mr8831298f8f.9.1755533924313; 
 Mon, 18 Aug 2025 09:18:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 9/9] config: enable comma warnings
Date: Mon, 18 Aug 2025 09:18:14 -0700
Message-ID: <20250818161815.23611-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
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
index f31fef216c..d9ff0e31c0 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -313,6 +313,7 @@ endif
 global_cflags = [
         # additional warnings in alphabetical order
         '-Wcast-qual',
+        '-Wcomma',
         '-Wdeprecated',
         '-Wformat',
         '-Wformat-nonliteral',
diff --git a/drivers/meson.build b/drivers/meson.build
index b62880db02..4c08a1dd9d 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -59,7 +59,7 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
+warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']
 foreach cflag:warning_disable_cflags
     if cc.has_argument(cflag)
         default_cflags += cflag
-- 
2.47.2

