Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE47D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:01:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0540402D5;
	Sun, 11 Jan 2026 16:00:56 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id A80D1402B0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:00:55 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-88fe44cce7eso44965966d6.3
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768143655; x=1768748455; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=kCkSUhBzeRAhFVXjb3otjCnfFZSnxQnpGuDs8DWU30q8w0dIBGLu13/Y0g4Mtc9M8j
 qI6KMVmZaFZMGNCl5UzmVf780Bn1A7tUxq7rL/yCT5HLxDF8+F2wSl05f4Xl8Wju+LMN
 Ntac4yIDzCeh4aYt3yLYq0z3r4r6R9XHQC3weGN9Jp5zirTXrpl9X6OQYpj8xR57qGOJ
 mWX1VYYmuSNZV0fUgyvY4GmfGqz3BdjymWhuVX4YkazirSeOhfGBhooryGG/av5+P4eP
 LfhweiVutRmFePQCyh7C25DMJQdn9bmxwvdrTiF31eo+b/ZFgDZ2RQFzSzEQtVnOfokb
 ZZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768143655; x=1768748455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=g8l05TYn8o4MttQTqfBnm3aYpW7zK8QOhNo6YSUM7lb7SYmbUGQcIbjbwYBRASOIet
 9Hd/nKUVic7T0OLl+y5lCxu844yE38yUwu4nNq7ObCYnJgWlow4WzA7NB4X7pg5N9z4Q
 mW1bjNqob/asgtAXMCHUy1DSVCy754hIw+rGqwsGYq3HlNztxEHAuTq8Zvm42a1BMI5Z
 yfBWHKzlTP9igFPyg/QxPiDp/2G2nWx8aZFW3PDrPzBHFs/kutH3X1EPLYpsFPVXNqvS
 OyOpLUYO/GNzmD7xz8l6KyeHCfoHIFr88HHIB+2wrDlAuEdBJWFwspkrSLXASNNzhzzJ
 1vVQ==
X-Gm-Message-State: AOJu0YyGAW7vT5f+BU10hOdHiq1BzalG0EYHJjombgDHtofaUSPPVzLG
 UHC3N9h2NL+hHMQ4JIaocu/c6Sxg/xPp1x5RhiLa0igDPl5DXlJJl9Fq+izwXQ==
X-Gm-Gg: AY/fxX6JmJWFOQhFsEOdBS2cxXD3R4evIXX4pYqZEI+0poq3KKBtTcDpWCxGWTUbALV
 X4sfDM/I996TmKkbTpMuZLVv3qNKCKwgY1RiX3Y1bKUFbS93MdMnzBpaQRyirXoZNhrK7WwXHAV
 dR0ykMDEbzUgriNyr61fabPmRQmo8/C20wPYPywQfjzx0s2/GsML7tq3R1sFz8oF8A7i5rnBXft
 xv47W5OxDU2LOStEbcgCy35DvlPpBNzGpHoDtiDFKEDO9oddUhPGsIElpDby7v9+/LsoUJ7T67u
 d6sgPJxh9Ydu+je/lRZsj6n+smS4oxi5eDUNQgnavJowvaw428H94nLVJ5GJUkmShRXoV6BlV/e
 8MAyFzYgH0T95HrunLMm+HlJUhScytXpYHq4FWuUKthiHHzI98jFe1cLNqcPxPXuw6LS45Ma604
 f+t+peGXDEQQi0fq1gQOe3nBmSxDyxu4EPuFfaZ85wMQWo5TDDTMzSc1frybpWrd+tdA==
X-Google-Smtp-Source: AGHT+IFeBkJc1U0GqpltbdUs685uh/76Tj6S/JUUkA+FkZ+NRTtRsJbi/3ahG4zrVnz4MXcJ7UcomQ==
X-Received: by 2002:a05:6214:1d23:b0:88a:577b:fa4f with SMTP id
 6a1803df08f44-8908418397cmr191355756d6.12.1768143654717; 
 Sun, 11 Jan 2026 07:00:54 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077234d08sm119361056d6.28.2026.01.11.07.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 07:00:54 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH 2/2] mailmap: add Scott Mitchell
Date: Sun, 11 Jan 2026 10:00:33 -0500
Message-Id: <20260111150033.81760-3-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add email mapping for consistent git attribution.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..a0987fc3c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1437,6 +1437,7 @@ Saurabh Singhal <saurabhs@arista.com>
 Savinay Dharmappa <savinay.dharmappa@intel.com>
 Scott Branden <scott.branden@broadcom.com>
 Scott Daniels <daniels@research.att.com>
+Scott Mitchell <scott.k.mitch1@gmail.com> <scott_mitchell@apple.com>
 Scott W Taylor <scott.w.taylor@intel.com>
 Scott Wasson <scott_wasson@affirmednetworks.com>
 Seán Harte <seanbh@gmail.com>
-- 
2.39.5 (Apple Git-154)

