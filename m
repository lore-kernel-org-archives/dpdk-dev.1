Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC97CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D13F0433CF;
	Thu, 11 Jun 2026 23:21:31 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 051C4433C6
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:29 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304d8362a58so272174eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212888;
 x=1781817688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wa1IGCIB8es21P041bf4PB+z9aPTQ+TU/e4xBzGS82Y=;
 b=JiWLApMjM6O545VJ4InLxjBK1i96dYXpT2GdXGmNGbl1IIKP5PAb4y1/xVWfrug0Fp
 p4VXuFpgCa0fl4vstt6GkH1oeRztkEawP8dHeaMGpIRK4M5tD6zyDkqot2wvpZW90cQG
 aBrkgUZt1Mlg42gPab1/ubC/MGEomihtX2I49lYx4o/e4rrjpZsyi4dMhxoaHU9dCx/F
 xg2Qjmg8eS9pg1BuINaydX+QcELgHrqVxkG7oqd8RQI0RAewBWAYCoCQo88yCFlWYr/k
 3DVUPw9O07xb9ffGp9paBxA3pttEVRYatKlPeNLkZPVwix2b2ojWRQzcO+OmybJpOotJ
 DSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212888; x=1781817688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wa1IGCIB8es21P041bf4PB+z9aPTQ+TU/e4xBzGS82Y=;
 b=fIIEOjt4wXvguv3om46g5zju0NAnp3v48WNmqxumIosH56O5m75fQDE6bjYshzfdvR
 NFIMdE6Fl0w1NaBeM3OAEpwn70y8JR4wVuWv5ci8r2G8yi3w/10mLlnNFUi5JlwCvuFr
 WJxmjmKAP6rtGbgauM9pSqrQYi8TgL/at76lHK+2fA5J5AQeFijCKCg2XcYBaRkie0va
 bqtZnedmVB0YbS9n1SGWmHjoNjdSeKRfZjurrpcpNYU0VPx2kvY7QOa2lBC/QRS0cm6q
 HNGZtNIjs2h9r+7P9gY32tk4DW2+TsAVTunf1lrvUj0ZY+B/2lROKYHabbAQ8DprbkAZ
 UqZw==
X-Gm-Message-State: AOJu0YxMynwFv0Lr4s8UG4/b/K1AgX+gScfKZYQwZYhvFBoHD8AXsQKd
 osggY7nVTN0pJagOxrxNszt141NyoGsK4ZyaxVzW063mVh3UlC+eGKjcjhxOXhVS3g+mKueH93n
 gPCm8
X-Gm-Gg: Acq92OEyVtmg6TnP3oyuhDlpVgweLzEg+dLiH2DUjMqdARWXX2vR98h+4ap8/BOjHCA
 bRgDSSmAgfp2YintoHDTg/z4Jdgg8gIZBmKV/PPzoiafm2rSUv2KOcTc371QAs79AimM/4CtzBv
 rtBZblJBLyTHPGT5+Aipe3Mx+ZqLgTWl9BnCU+WKKP0y+UYzRA/kTZ476bbBYEK7dl8Uebxs12j
 gGwhbwtgHdSyWTZCWjK6SLbpDHKpXBWDP0Fam08tsNQrXpgEnRs4Nq9GP93p8M4JvpMNhfuMU5G
 pUUWBHX5YwxIpRa/aUHi95Yd6LQR9DNgw/WVmIqri/TaS22VoZq9lcy9YOfcOKzgNaYMTVUuK7c
 LJincm7SDlSP5VO3QIOOVhiWEedJ0i60KR9cYO+dD8+v3do50cjPuDso/raBX5+myoeBoKh043U
 +rhELf+hGM9aifRbsC41np76nUwlpZ22Z7G9+S8v4wqEmjqrLKb/VW9umdBDjALw==
X-Received: by 2002:a05:7300:2319:b0:304:ddc3:2c35 with SMTP id
 5a478bee46e88-3081f022cbbmr268798eec.10.1781212888012; 
 Thu, 11 Jun 2026 14:21:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/15] doc: correct capitalization and formatting in ethtool
 guide
Date: Thu, 11 Jun 2026 14:18:45 -0700
Message-ID: <20260611212119.1026721-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Correct consistency issues in the ethtool sample application guide:
- Changed "sub-directory" to "subdirectory" for consistency
- Fixed heading capitalization inconsistencies
- Corrected "Ethtool" to "ethtool" where appropriate
- Fixed "call-back" to "callback" (single word)
- Improved sentence structure and readability

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ethtool.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/guides/sample_app_ug/ethtool.rst b/doc/guides/sample_app_ug/ethtool.rst
index 8bb8b73922..68bcf25b1f 100644
--- a/doc/guides/sample_app_ug/ethtool.rst
+++ b/doc/guides/sample_app_ug/ethtool.rst
@@ -20,9 +20,9 @@ Compiling the Application
 
 To compile the sample application see :doc:`compiling`.
 
-The application is located in the ``ethtool`` sub-directory.
+The application is located in the ``ethtool`` subdirectory.
 
-Running the Application
+Running the application
 -----------------------
 
 The application requires an available core for each port, plus one.
@@ -43,7 +43,7 @@ The application is console-driven using the cmdline DPDK interface:
         EthApp>
 
 From this interface, the available commands and descriptions
-of what they do are as follows:
+are as follows:
 
 * ``drvinfo``: Print driver info
 * ``eeprom``: Dump EEPROM to file
@@ -67,8 +67,8 @@ Explanation
 -----------
 
 The sample program has two parts: A background `packet reflector`_
-that runs on a worker core, and a foreground `Ethtool Shell`_ that
-runs on the main core. These are described below.
+that runs on a worker core, and a foreground `ethtool shell`_ that
+runs on the main core.
 
 Packet Reflector
 ~~~~~~~~~~~~~~~~
@@ -82,11 +82,11 @@ source address, and is then sent out on the same port.
 Ethtool Shell
 ~~~~~~~~~~~~~
 
-The foreground part of the Ethtool sample is a console-based
+The foreground part of the ethtool sample is a console-based
 interface that accepts commands as described in `running the
-application`_. Individual call-back functions handle the detail
+Running the application`_. Individual callback functions handle the detail
 associated with each command, which make use of the functions
-defined in the `Ethtool interface`_ to the DPDK functions.
+defined in the `ethtool interface`_ to the DPDK functions.
 
 Ethtool interface
 -----------------
-- 
2.53.0

