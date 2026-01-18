Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62CC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E44AC427CD;
	Sun, 18 Jan 2026 20:14:17 +0100 (CET)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id C281B402F1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:15 +0100 (CET)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so525886166b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763655;
 x=1769368455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTI/f4G6e+d6SFTAHH4Pd9K2luUo5vsEWc6ehkHNWiY=;
 b=ROKk9lx3dwlO4S89hd63dh0hqUVMnCwFsXfeVTFMO+ZHU7WgmyGdhXQ7oGEwmmHgZj
 EzHu8xtC2PlZR8q9si78E6RBUnmfycHuDZ65lMGXRb00pNVyW0k2osVZO4MhzibMCdnW
 QsXTqA+l+6No0britOPb+CRkmVZ55eqthxK6tAL6+zA7o78QWKRLT7ss06b4d+F/3T7v
 SZ4WJZ5RevoApkyGnlk+wTLAV6mVrCYZrU+InLP1Asnq/dGHHQSbuj7TraohVeSd0USM
 Gs/ObscrlPwJeDUlzdRbXeu0mSyita4stNm2Ia8fdgVTsXPG7BRYxUxyO8vKrPGcVYno
 zBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763655; x=1769368455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KTI/f4G6e+d6SFTAHH4Pd9K2luUo5vsEWc6ehkHNWiY=;
 b=fEsyCn1FgTaxoPY+BuBpoJ40ibskmmiG58HqkJjcKEtwSjlmBJsJxA++SBqvxxLR9S
 ibHCratsrqagbxsr73kMEoMH19s3N/styX57ZN9onOBfuUgtIKeMiANnpmVX2iYTIQMN
 CidTbtEG2GrdA6CTEazs8qJnzqKC/dqYPBnEgPeiu3FY8Ke9FDm2c8zvXsZa/2TU8tAM
 ksLMoNVap0wA5r2ma4xOxnV3VwRyXbTmDkF0l6DySvF7a8wu750pGaMlnAXjJXhnRsFR
 lh51MxRweMiwgDPahxmWk19CBxPujauRipvO8LRsOsmCMOFeGFUTaDLV4GCGJ6cid4Dj
 8H/Q==
X-Gm-Message-State: AOJu0Yz7TbiPrgqGQ8Eprck6yOOORq8LSPhE/ppCpWlHUJFXcGCmDJIL
 YFXBJjICAWhhJYLvytTzcK2Uvr4Ml4BCH7DSne6ZUEbkqBszs/g0c0PuvPF1TXnbOVanIt20Bdz
 UB1HK
X-Gm-Gg: AY/fxX4kZ2kEaWr1HEou+nBCQHh9NcBEvv4S0Yi+eARUNSRB6/lQLZUvpqmv+AXGwt+
 6p1zXtfI/bjppoGeYY/YWmPwbdJzTdTFVxTqoSqCCGd0G4nL7YW2QQ7QpKCAIIQG/BggHqmFT5p
 aCAfi/xIvKEKB7s8CQsJXAAsbqF03ErcKFlq/5alk9GZkeMxZNH7xJA/cv7UvuUxTuZgQG9Im7E
 ztmitdrDoNA+DV1HoW/Eql9Tit7lcVHCsct/Oy5bl38oj2ImhLA1YIs0zv8VLvGk8aSid/PTOHV
 iu28UaQgCwygFOxKnLT6maG5NboQohQgzkc+e1pNwND8banB29QsHBqfuQAR1HtEWkggqqR7oDT
 DYKU14fhaw5RANGgCgh7t6DhVvgkAVW9mf2jXraFlGkFd2iVWHe5hEUbjWXubbVTnc0rRq5TvK7
 OZ7Xi8KRbGGCp/RjHw/06ayveC5hk1Jn0O6T7LM2TveAYAN8ktFQ==
X-Received: by 2002:a17:906:4793:b0:b87:1fb:8369 with SMTP id
 a640c23a62f3a-b879324c8aamr779262866b.57.1768763655231; 
 Sun, 18 Jan 2026 11:14:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 30/54] doc: correct grammar in introduction
Date: Sun, 18 Jan 2026 11:10:33 -0800
Message-ID: <20260118191323.241013-31-stephen@networkplumber.org>
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

Correct missing subject in sentence describing release notes content.
Correct inconsistent capitalization of Linux in the documentation
roadmap section.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/intro.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/intro.rst b/doc/guides/prog_guide/intro.rst
index 44877bd3e3..5055574206 100644
--- a/doc/guides/prog_guide/intro.rst
+++ b/doc/guides/prog_guide/intro.rst
@@ -19,7 +19,7 @@ The following is a list of DPDK documents in the suggested reading order:
 
 *   **Release Notes** : Provides release-specific information, including supported features,
     limitations, fixed issues, known issues and so on.
-    Also, provides the answers to frequently asked questions in FAQ format.
+    It also provides the answers to frequently asked questions in FAQ format.
 
 *   **Getting Started Guide** : Describes how to install and configure the DPDK software;
     designed to get users up and running quickly with the software.
@@ -31,7 +31,7 @@ The following is a list of DPDK documents in the suggested reading order:
 *   **Programmer's Guide** (this document): Describes:
 
     *   The software architecture and how to use it (through examples),
-        specifically in a Linux* application (linux) environment
+        specifically in a Linux* application (Linux) environment
 
     *   The content of the DPDK, the build system
         (including the commands that can be used in the root DPDK to build the development kit and an application)
-- 
2.51.0

