Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD59EDA682
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72687402AA;
	Tue,  3 Mar 2026 16:14:30 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 999EF40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 16:14:29 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1271195d2a7so2834495c88.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772550868;
 x=1773155668; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PUJ58Bg478FEILPLEVOQa7ftJr96BjNtn5Vi4OTdLQk=;
 b=GNSj8WefXN/D3bK94lk/7Le72JikkWyexuD8pRJp5One0G0tBTPTDmTbK2P6F30Ych
 DnSRuF9Pk1y6v7TccfVxdPVGpHgfwRyELAJrOaiEvuYTgaE4rtT1ZJErtXWvgR6QulL/
 vM//M1R56PonCJv/1cyXuRiLBvOtcMNe3T+xY3EF5AzPlUNFMlEUh5Qs/us0UIIuqd/6
 MlReC/XsUxeK9cTmTlVeWDD2ymzu2KteF2j+8M19TgT8xcCloQ2ZiXseQSzlDTLgRkv2
 hCT+yH/5B7WHO/pVRRdHEFZ3ZEsXW0+KGcAbB04wIs7BFNz1Y/55DV9KZ80kh6wzSepu
 v0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550868; x=1773155668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUJ58Bg478FEILPLEVOQa7ftJr96BjNtn5Vi4OTdLQk=;
 b=BJXW02seMO8xIi5GAKoEXRClL1VBODsg3d15f88mtStsvwJgFQVKBooYhg8Uucgsxg
 09oRnVkgJcgEOOXCSjeksXJg+Uv2/vc0yfo0MM+WNtln9ZmwBB+lqXsOPWdV3ph3NMzD
 4Cja+o0DYkjVA6Fa4aQB7ixk9eHSvw/RtQ1cYx1+Qo4LoItSsWKjQx4/o+YbfVgdUIam
 HaFV70Yt7l3ICGsK47hkcSU0eequfiWy7a/qFdCwK/HlSgW5mVLTC/drdxTRcVvFpDzh
 +4LFwUDJFJqzx9mj4G8wxdid88PY5U0/8S0x/Qc3IDi23g5CVb+GgzSdrQa+1mqn2Aj5
 SuNQ==
X-Gm-Message-State: AOJu0YxC5S1kHwvliZns4geZNM1qYbJonn2Pwcpjj0/MuYwFl91QfmkG
 by1J5X9qJ8pYm0EbzWarZfYRah8oKoo2GCWmJrDNBwHWDW2G5IRgic1LKtm3+hkEj7owLu55iYA
 6xBkl
X-Gm-Gg: ATEYQzxguuSTEfobn43/MA7EttGC5qDYgOyw97IoJgeWmEwAmhjP7tcLLX2CdqItnDY
 8YlhCxazjLOh249RXSJlgjpEmmYGJ+cs2FSYiE2zVAkcZUB8s4ap6eWhin0Sf9Kc9lCiVs6Om2/
 hgn/N+OuhDjXrBtauCsxW1KkL5f7n3R732DAzRxvtxFhNvPYe4ErbGmWx/lKnGMd6kezVRGmMe1
 nIUIniXXp3mCoJ4ynpJzleEkRY9lnPuWGXDKotoZUkmCDDV39rq+A1tYVSmr5OekoZupg6/Mm59
 2b1fnfgJMgXQUVQpGqPtEdxcfoFmlgnWqjoprtTl51sO/9sQGIwzwJpuVrS+tmwbYJG6747Tar7
 Lu9BeHMwajkyF0oGI75DBcmSXZ/5Rx+yTJ5kA1ZInuw8aDXpY1sseY/2BHPP1vIAcyhbmMTLpsD
 4P0/GzcE0xdPhbAIGkoPu/RLcS2vqiYwdfGC/XvoQEEd54MArzEG/f3169B8Uigw==
X-Received: by 2002:a05:7022:1081:b0:119:e569:f277 with SMTP id
 a92af1059eb24-1278fd10d7fmr4775744c88.32.1772550868312; 
 Tue, 03 Mar 2026 07:14:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32633sm19433985c88.9.2026.03.03.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:14:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC] MAINTAINERS: update NBL maintainers
Date: Tue,  3 Mar 2026 07:14:24 -0800
Message-ID: <20260303151425.20121-1-stephen@networkplumber.org>
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

The email for kyo.liu@nebula-matrix.com bounces.
Drop as maintainer for NBL driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..88b52bdaa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1020,7 +1020,6 @@ F: doc/guides/nics/features/rnp.ini
 
 Nebulamatrix nbl
 M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
-M: Kyo Liu <kyo.liu@nebula-matrix.com>
 M: Leon Yu <leon.yu@nebula-matrix.com>
 M: Sam Chen <sam.chen@nebula-matrix.com>
 F: drivers/net/nbl/
-- 
2.51.0

