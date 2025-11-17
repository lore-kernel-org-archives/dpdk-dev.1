Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFFCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57AB8402D4;
	Mon, 17 Nov 2025 18:53:46 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id F1F61402CD
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:42 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b9a5b5b47bfso3071055a12.1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402022;
 x=1764006822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=MnSQxCtDWxffFt3XRir/cXDzC7J7x03/0cLWu6yEqBzsaz6u7wGkchbrhwmsEHWEQ5
 HXljsE9kRNK3zH5m8z3mtb/1ldwL1kIxA7I3IbnCbiyejWs1y7KZNBX/25j/+d95uMvk
 bAc08/ZGwwHy7XzYu3aUEyuhWThgubmDf6hJ5sMp8/TLw/Hj4YdK6uuNGrcyoYxObGaj
 kyBN97PvrKaXbLmrAyLsq9TarYfmQIOfc3A4rzYTxDHN47B8o4usphFSIFm2rPe1fe3z
 2Y6KMTRtszX7Qein8G5pFmEYWBmj2fEo19mNDef1fvGOzK5ImYnN5v9lLpZrwgAE4Zg3
 T6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402022; x=1764006822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=GJIJI/MDpg1bR030FXIbsF34F8OZ2nm2fhvt6Kg4fGU20OnHbyJS02buupN7ySPqlo
 okBqDViph2Zw3vms22zHdvf66XJa/RqO0At2PjekernhczRaU33Fi0G0ytd2PYaBbkmY
 fRDDQE7F+ZslOwSOPsKIVZuBuYFHg1L9eCfLFFlj3J4YfK3SekocDHJqyoxPTKk6oplE
 GkPoqhfEhhB2VEj//GEO1UH5OsOFQeMjwBj7lrJbfn8D87Oh5qP+bMgmOZFDrhMDHISu
 MMC1F2jXJGIn+nKxdCS9lM47w/l6G67p+a+Kq4o+inDNfFxujG20XMkm/wWn0havt/IU
 O5mQ==
X-Gm-Message-State: AOJu0Yyg5qfogGYFvkAKG7523ko8Ay2/HYiOyQC6S3YZvrWJBfnPWjdM
 FlsSQtBvVQC4dkOTs+MYR/G/SF1No2RgxzfqKAugUg/qmH0c5+KrsW9ag6u5qRdDwNRY0UkqNpt
 t3hPG
X-Gm-Gg: ASbGncu3GVaFUSGEERPdU+pLaRDr/Gc9kamY/H+VaMopPnLn67TWoHcUiI0ijTqtm2T
 xyGWMiSVw94ZEqmw9SgBEbdVzN7eOXHT2yX5/hbltVGw5FJSb+HgugqSw6z8ghAixys3oCspB+V
 GWDp2pXg9wo4kzfS4jUJMCCX9xSdP8P8naf3F4KzoJN76nCJDrs1S7zKBuNXicess6y0tZSIJNl
 UBlPVrp3btqIvApOgjWdUHvRfp1+upjwRL8iQq5g21Tclt49ISZFBotoGfaN0eTJOT8nYq1hbok
 3nAH1Kjy3Oi8iYnkCM+Iy4p3EaCFzvw9EQLm+EY9jE1sOQYwGm7wXiiqFK0ktVi9qAyNQxot4Vv
 BfLmEO1qDfUI0PTP/cG9r1bCO8awyfrhc7Ky9GmFhy7PmQkCevi4jBkMMCoI0hahVjPFdVlIYBl
 1Ug8DWetsToPFfzRBQIxwHYlzg4C1mCfI1E8JAMByEY1PNMoGdRo+dJVjxsjvh
X-Google-Smtp-Source: AGHT+IGVFMm/eyNeoeeaLi4y3xqZ1N/k3t7jPf0cfgSlh7CF/zAgr4RG5tbQSDj28q72WwMvk3hhnA==
X-Received: by 2002:a05:7300:cf8a:b0:2a4:87e2:bc8c with SMTP id
 5a478bee46e88-2a4abb10669mr5423740eec.24.1763402022107; 
 Mon, 17 Nov 2025 09:53:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 6/6] test: re-enable format-truncation warnings
Date: Mon, 17 Nov 2025 09:52:13 -0800
Message-ID: <20251117175332.14014-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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

