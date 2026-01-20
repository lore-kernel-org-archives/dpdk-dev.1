Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF5D2629C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54434410EE;
	Tue, 20 Jan 2026 20:54:33 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id A0F124026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:23 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so31676545e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938863;
 x=1769543663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNXCPIFznQtnuBhQO+JaVSbl+7nNV8Wm2tPKiKMe2xM=;
 b=tiT339qbkcI2YhyeFxx207sNbv+PfyfV9mhvySXXVE8mH+TnB4jbZVQr9hAGYzDIYn
 +Z+3DTW0IiZ/wBPuR7xsAkFZ8VwU5xF6+tXK+GisAUiodCoCEKjn1x1uZXdHqqXM2Ks7
 JZX87JEE9M2OogrDMd+G/izUbWJwK0JJNZfyNAmK2r57/jrmQqEbyIaD6QfH1YAHeOmt
 T74jf52OL4Ez5SZrM02sp3y4cBNuqPBdfF4IaZUpdNMAtDpa7bPGt+GsaWOGRaBOYa2Y
 T60wJeRox2cHZpi/h1y73ToUtkaeiygRATXeOHfN1q80DpIIMYMgBvq6OleoQxys8u2D
 6fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938863; x=1769543663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jNXCPIFznQtnuBhQO+JaVSbl+7nNV8Wm2tPKiKMe2xM=;
 b=q/YSYw5dwmkMpE+TquCSRk0uRqO4824ePqZbjxeupV2uHlgPVuRbokua4lzsaNjX/7
 NnpHDjswaNXxPe8KgUj+0EQI44Ld/pnRJ+fOwrUHWAjkeoHW7xiC5VUXtjJCKWTqRHno
 l3cG/CpSl3JbquqWNR2aXRzfEIHmHpPypc6dH5M1saygiZYLpPp100wDvYqDQz/WbqER
 psu25r5xlwoAblKa/a1FTCX4tZji2Bets/pK1S1ys9CNrrBIrKBqrNT4pP9IV/CRiB4T
 OzNfSumLKqoW2LeiC+eKrEG5iBvcvzHo8LPZAXwtsDfw8LTwc/OqC4DPBg/D003i0wZM
 p+QA==
X-Gm-Message-State: AOJu0YyVYniOU39oMkJrasY9xN/L+L6PMfgvqzd0RjX54CcQVQB+UeWp
 fzmrHsQYlAAQZN19uq0/xlcPTP7Dk5ug70YQ3W41lMYFRResk7pyWNJHc1G08ngZo+ouuN06aW1
 a+q4n
X-Gm-Gg: AY/fxX6h1nnxKEkkMdxKFEkIkSVrQQaEcf1VBXOSF3uR8MBndsguTW+zDxivce8QxRT
 8B7DqVd1W1W8ND6/JZobU46KRVyfeCDJ89ji+DsCS6A8mE/OctF86rHFCopgYMmq/HivKr5rskE
 fCxwNWoFrDBRHj1Y8pnOotlRkoYtJPiFlN9WF5MMlAS40wACU3MBRd2AURUjSGWAvHP/yvV1WW+
 rbamDpC0Q1vDYzzFic+uDqJW1bocXyFQkmrimkRCa1beXEUtNcU9YA453U5ys4LUK/ZKhpg9P19
 bkWK+pV9Eu2HjR19CqIoRzAZkIVh3sC7ZxUFcW3IxqH4UvVujqWefXPTG6hpxTYvm0WPhfsr+9l
 2Vip9woeJLDUBbIRTgxnITaYQ8du1UmgZLgcg4R+Pw3nO/wrZqZrOB8yxZkg8cERxgoT+OD6OeH
 0yvy9s8Fp1Cp5aWB6qmLpvgY69MPgDOZvwSq8981+8K01xqkwX7Q==
X-Received: by 2002:a05:600c:450e:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-4801eac0721mr175594325e9.11.1768938863033; 
 Tue, 20 Jan 2026 11:54:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] Fix LTO compilation warnings
Date: Tue, 20 Jan 2026 11:52:05 -0800
Message-ID: <20260120195418.466318-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
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

TLDR; fixes LTO build

Full explaination from AI...
This patch series addresses multiple compilation warnings and one buffer
overflow bug that are revealed when with Link Time Optimization (LTO)
enabled.

LTO enables cross-compilation-unit analysis and inlining, which allows
GCC to detect issues that would otherwise be hidden. The patches fall
into three categories:

1. Variable Length Array (VLA) fixes in common/cnxk [patches 1-3]
   - Replace VLAs with fixed-size arrays and appropriate bounds checking
   - Re-enable VLA warnings after fixes are complete

2. Actual bug fix in common/cnxk [patch 4]
   - Fixes buffer overflow in IPsec inbound SA initialization
   - Detected by GCC's -Wstringop-overflow with LTO enabled

3. False positive warning fixes [patches 5-6]
   - Add explicit bounds checks to help GCC's static analysis
   - Adjust inline attributes to prevent spurious warnings

All patches have been tested with LTO enabled and resolve the respective
compilation warnings.

Stephen Hemminger (6):
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings
  common/cnxk: fix buffer overflow in SA setup
  net/mlx5: fix LTO stringop-overflow warning
  ring: use inline instead of always inline in soring

 drivers/common/cnxk/meson.build      |  1 -
 drivers/common/cnxk/roc_aes.c        |  3 ++-
 drivers/common/cnxk/roc_nix_inl.c    |  2 +-
 drivers/common/cnxk/roc_platform.c   |  4 ++--
 drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
 lib/ring/soring.c                    |  4 ++--
 6 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.51.0

