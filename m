Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED390CCD19A
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6ED04279A;
	Sun, 16 Nov 2025 20:00:46 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 804FD415D7
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:44 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ba2450aba80so2022381a12.1
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319644;
 x=1763924444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=ZIKW9LiggWyHVnNiiIw43FZSP2OOX1h0RVc1oqRH+/U7/jlfZL38msOLijhcI2r9gc
 hCjU0b8EwHQ5IPrQM/ROulKV8C191vUc8Eq5xXGbxhRrA/usfqXuoBRno952FcPE4PXE
 bkpo0SIZtrt+5gmHbsT2yjyMNwDDFlGX9QrqLicJpg7YR0HrpJe8autawXrKzN1aUJfu
 OMFLSReOI57xJN4ZIfsdkT4D5hu5VYyP07acRaFSBT/YSgzesPQTNkQSvUfzuYaXFplz
 REiVAoTC1nPoNMzSL5TKJT7FYn5/8kARkh10gyteTK+po94MVxIPhiwQzkRne8yiJhmd
 KMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319644; x=1763924444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4N6VXc3tUc7OXtFjeBwHi1Npc8ZSTloPaYoTVmoy8W8=;
 b=FZf6+caH3uDL0ytJm2cRscb17s9OP23G9CNvxzBAbVb91QygjK4kof/l8qGNpUQhpV
 Bn09frljpFHjXgCmH3noXjM84Pdufwjs/+EBXm38yCRv7bFl73lIHcCdA/s1FsqPsbqB
 fn42FNGRFFE98bbi8UWKIL6OBmvqY0CDErrmcvnBhlSZANaNMZAy40/SqxPFgytjJQXx
 nS/azHHzC07UznKSpVmnprbSUg+jn0F0uNFsM+iKQjdsW1r+bLzXP+8HYHFlMlMIUndO
 eVMubQqbyMV67yDRxwmnFgWSfj3jWJkMaHTuarMNyznNoduuP4dyCm+4uDKJgHZBxKKW
 BHcw==
X-Gm-Message-State: AOJu0YzA3BB/Vq7z4/DSUyd0XCgMtvcihLAv/uV/k2pluD1oU5HPiMjO
 7wOz+x7+QR30DoTiF/tHtVeDmY0Ac0MWrq7PlobUOkPmw5X3ALspIa/XsqkSzE/bkiWn2R3fPyF
 6qJAM
X-Gm-Gg: ASbGncvOo+iQ6kkF1Ffkyr1Qb8AbCHyVkEiLNqglohmopzvKQ3EK3nj5TWH2Iw3POu2
 Do4mV1ZVvAzut6JRLt4pOf0Sq0Rcw6LK5/7tK54mOwErpNkmL7ouWLvej7bGm8TZRIZhx9ZOjf9
 3GBJ8xrYMP+w3tZ5ehTw6XQfWpSfgUNcxBjdWNVSGy8dxR/fSf13mEdeNw16S/7DCFRyWvv84y7
 DH25aFM9/Qt7jW/QBGuIW1SteqlrZoKQE6uYEhqb06CP1WRqkOprkaRJYIuBbGO+cVRXSidFl1I
 LzgHqONZHNCzpeZyjijmDZenBEAy0RAIco5eAYcy8uXhYiJJ2g7pRJ01kEHARFNsqxTs++Y1Rr+
 cMDaWwpO9CXB4+ja6a2joa6znAVElIQ7JTJB3vcmUBZYXuFPlaEjAwRUpWQAdacp0Zgej4ioh9N
 BOq6ZS/mkZdbUjN3X2P3YHGpN3zBAK6428GIOONfzL7hwPS4oS5w==
X-Google-Smtp-Source: AGHT+IGS8Z5Q+TF6CaUIMZrlph+uNh7nElsmuTbC1YhdEtE7EhO8Jz7YcSCtLKQd6MHt3jI0AQloog==
X-Received: by 2002:a05:7301:8614:b0:2a4:3592:c607 with SMTP id
 5a478bee46e88-2a4abb27503mr3678808eec.24.1763319643632; 
 Sun, 16 Nov 2025 11:00:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/5] test: re-enable format-truncation warnings
Date: Sun, 16 Nov 2025 10:59:33 -0800
Message-ID: <20251116190035.76123-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116190035.76123-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251116190035.76123-1-stephen@networkplumber.org>
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

