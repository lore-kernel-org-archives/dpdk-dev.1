Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE1DF4BB89
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 20:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A17C640270;
	Tue, 24 Feb 2026 21:37:15 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 233C6400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 21:37:14 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b82c605dbdso1879036eec.0
 for <dev@dpdk.org>; Tue, 24 Feb 2026 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771965433;
 x=1772570233; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AKwBHLKt2SWzwruuhrSVikmaGgsha/0LGsF8IJDrwLw=;
 b=snQqOdFRGX6zycMBL4TssuF9exyjo7kbeN1wrBKjhJybSM4V7zV4jmYJ6kg3PuT4Yy
 ADabAcaKKwAox1t8H4JvyPu6sVr0eG1lQRaD+ybJ9rkW0OXE5ftd3RLSGdfd74ALQFPo
 6kNiORWPR9UWEl9lxeoFawypBXUBtP791BEJbxhOGkN26JJHE7NnAEEDEWJPOSTt6Cup
 gAibuga0Xe7VLBdTmVhOY/t+hHdJ0qw+eUglWpHxTgGBcRNIZa8tyevioQjJGfNbEFqz
 cL9cdnyIzqVeY++B+82FgCebcZMhWBWWjsq7pNTE+jV6ngNiXiQDDT7vrbrOuIxBg4RI
 Nk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771965433; x=1772570233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKwBHLKt2SWzwruuhrSVikmaGgsha/0LGsF8IJDrwLw=;
 b=rR5C8+7kubY1ZlxKk/o+UQC6ygbSAHqVqBpPfuYSENQmwiwB3yPVLp0TBL20RALdpk
 ObzWLvHArpNVXU8MEzyilKQHCk+idDXbvRrjVbk7CNjpC17zW9Q+D7XS2GvnI1LrqL8F
 aRXuUUOHAuhqI5cM3npB56IJcbZW53DfazBx6kkl3nASpgd96n2t+G6mngB6/cFwvk4K
 nmcvHvoIs1DAb2ix7rRShYetiPLngy9X5OqQqq807LsCnz457bcPHgQbZODAB6G+Ul6E
 QaMr1/qN0EtnD3CUNGJtbPt8gZeQVJ6wYatBDft9pSLTKDaSU9p2t2czm7D0Lf3iFnkq
 HA3w==
X-Gm-Message-State: AOJu0YxbSN0HT+HB0q2eaWFsXpaJMWm59Z1eL2OQ0Ag3jRqkwJG7Xyb6
 MEl+QTk+6fRjmz5vX3Sfnz/TvjkIzffBW/a7WfBQWhZ+UAUaUaLBfp6A5k2CBEKFvJIG13mx2sW
 bDSDG
X-Gm-Gg: ATEYQzw+oPlXQCbk/p//jsddRz+NEOwpHfycPq48yqjt5tkokcJoqMziTYjPob7MHsZ
 JMSykWqslOjyutpiCKLv/Ts/8IlNx7JZNhS2n35AkrmcGoZgyFEWNIV5ac4h8/g4t0StMFp3ddd
 7GFsHSvGg5q0JH4U9V/tmPuFPUriblJWU9IMCRqWfa+U+S9zEEi7DyxqhmB78KIr6qwo2ccASLn
 ZbhecBmhkpcaouAHjGVO4ET3Q5fnA1btO01WFXl6LSlnNFxTKZoeUlDXe8P62hzkWZ8SfcUQ8jV
 SQK4ifJ4LWoHcdlDpD79cPyp6E0T2VLcbd+CydajQdg5+y8yXn9Uu/kcy6i96X0BF8Wx0cLrgCp
 ITjmRgVmX3SOy3wBGzLJixlZwdcVpkQucnIUMpTN2rg0LDLl62SCTP7YhGeAC0H5v5e2of01Gzt
 WqZOVTYRvffABGIluORjAvRPUucCrR4S6VEJIdlACngvDrRVDq5R66BTSS6bOEwZnZwtfFJl7y
X-Received: by 2002:a05:7300:e8a3:b0:2b7:1e86:3604 with SMTP id
 5a478bee46e88-2bd7b9e6bd3mr6385394eec.6.1771965432895; 
 Tue, 24 Feb 2026 12:37:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7dbe82d3sm8575083eec.21.2026.02.24.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 12:37:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC] net/cnxk: only build if platform is specified
Date: Tue, 24 Feb 2026 12:37:09 -0800
Message-ID: <20260224203709.27696-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The generic build was building for all SOC types and that
takes a long time (like 10 minutes). The driver should only be
built if soc_type is set to one of the know values.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 53caa6c171..4a2f4e1a92 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -14,8 +14,10 @@ else
         soc_type = platform
 endif
 
-if soc_type != 'cn9k' and soc_type != 'cn10k' and soc_type != 'cn20k'
-        soc_type = 'all'
+if soc_type != 'cn9k' and soc_type != 'cn10k' and soc_type != 'cn20k' and soc_type != 'all'
+        build = false
+        reason = 'not supported on soc_type ' + soc_type
+        subdir_done()
 endif
 
 sources = files(
-- 
2.51.0

