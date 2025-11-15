Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26ACEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DADB540E8A;
	Sat, 15 Nov 2025 20:34:15 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id CB94D402A2
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:34:14 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3436d6bdce8so3756014a91.3
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235254;
 x=1763840054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=IHuiZ720eMs7/wFQ8ipCVyum5mhtw/uy8yWLCcVco4abtVYZMk/N7WMl7YSkTILOJo
 yQzKm8RtW80Y0TNb0lTSID2rlDyT+kGNLsbV66GfFK/9k/4iLkBQpWVfD9KWv/wvsKRq
 DB8kqeeprgPFUpIk/Heyc1nntmw4nLgSobljtVQIv86AOGRyQsfGSWzAc44RQCA+stNb
 4sEYxy8eFTlUyivddpYP6xDAW3N8dCU5DtWDhd7u6dzqXPg3jcWMA6HnGCNRK3lstU2s
 3AnZ5CdAyNcQamC9fBk5L0hNU81NP+XQ+bK/vIMXUnXPyKku2qEtm9f1NDxBRdYhKsjd
 8tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235254; x=1763840054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=Kggjf0vgx6F4XWz/GzGDWS+Z1xJAm2RAyvDoZSIDypMH4gftVwBeCuti8zu9H8JYKM
 tkVIONufJNkMM8WHn9D6QSWuzPN8IuXEUhZNh1SAOgHbeSheIrSrnHYZhTGUOrjZGjez
 pdJ4lT1zRqyUcMDcQVm/DYO9unn8DbQmZhixgiQpLNtVbtHcWM4yB4J1mCg1goEqTfSC
 fwBtM2+DkDF37GY7r1CdqRyQvBOCB26GQTfmZgG+U5lWoTNJ6jgTi7zTZ4WaZbn5ZLpd
 4eVo6kCtN0tSgBAjLlMnuFV+m+Fj4S26Zsex8WNxQyPSURnq8cY9GUln98BnReIKfsy0
 uoxg==
X-Gm-Message-State: AOJu0Yw5nuJX1WCtzxajs979GaB88dim0Pogu2Cafj1gV096aYa5iyoh
 McoTJOdZPWW4MVCq5vnJBLL1Wrw3OI8syud9Zav/QKVTJwctsMLa46kX1+unzU94Ivz9+OlYxKb
 95sfB
X-Gm-Gg: ASbGncuhQg1TsBMh0Q/fxZhYblhZvPHpfJoPffvE0eav6IgrfFTkWT19GgJVNob7zS0
 hFx4qZBaIA1mU6jdLrnE1wSa0gHF+6Md8BjcA+YB8RaNFe17nBCWunnquDAm+0TnC5oYVlWGycO
 51fAhg39NXeh3nNqJHNwi+vV0SSzLZBuaTeq3x7Xcn16OKWg0vfuwQqWKFl2LrL7PoObmLtzD++
 8OpHREAZiwAVj+D8C4afF/Zn3Ec9bisT7S2nGvLGcZzJzJZr5osLl8GNUlBtfLsACxbLn2kEvss
 Z8ZqCBTbhv/tP3uXb6jMBpKMfOGCbDzJGMyHxv/+mT34gqkaj/BfKET7nYDqmCIv0FS2+WY+j9a
 /lCK/lR1W3Qi3qyliPNnx9V9WMzSd6wLjhVEUgfjPyk6QlwV5FkhjNG9QRZ95RcrXbvwNrqXrTd
 1cE9X2Qf/73TQ+Vbr8WmxLZkJ28gtirDvWvV6GbCdExbpqzDuS3Q2jyH7hDizN
X-Google-Smtp-Source: AGHT+IHUBUB6hzimYOXCdw7jDD4VIL2vGa/SMWXxFM98Su/87FZutHWaF8nHVAiETtg+zm9vTTnXZQ==
X-Received: by 2002:a05:7022:ff41:b0:119:e569:f629 with SMTP id
 a92af1059eb24-11b4160cecfmr4150461c88.34.1763235253854; 
 Sat, 15 Nov 2025 11:34:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm26588644c88.7.2025.11.15.11.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:34:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/4] test: re-enable format-truncation warnings
Date: Sat, 15 Nov 2025 11:33:07 -0800
Message-ID: <20251115193409.99740-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..66cbabe9fe 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

