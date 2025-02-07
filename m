Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A5C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 18:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A9BA42EE1;
	Fri,  7 Feb 2025 19:26:47 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 125BF42E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 19:26:46 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21f0c4275a1so38274665ad.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738952805;
 x=1739557605; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ApizXZE3l6oRN/oCbx2VKdyQoLB0LvOdz7pABXDAGU=;
 b=z7AUVPQ9+ggYW4t9xLgvY+ZEQMDhVFcttbj1NwwlYVIs1sUnLnST48G45ac0kyIgqB
 mSCtLcbyEACOh7roQL91Ne9BSpgBfnE77yqWUcRdJOw/i0wbTnEU2mO68zpNffqgTNcz
 GdWYajWagjU07I+G5fnRedfNpCKQitSoIwQ7V/RgTgM9n+e3B8WoNPby3ixeTlh9ddzQ
 WK+PMA3Ia6AzaBKuLE6b2rAdfSbNIaudL4lVzvnjFRTnqU+ltdqVhLVAVTZITxwG/pAR
 xVGkxX2E35+dTRi0k5NICYkENIxhN4uanolWoJdLwLntDWzjO/sM665NxFwOS1/yMSw9
 Uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952805; x=1739557605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ApizXZE3l6oRN/oCbx2VKdyQoLB0LvOdz7pABXDAGU=;
 b=Nt1z7M63YOBC6JdEQXfqlPpaTaFaSyYtS+pheueooJ16icFNFe2dPWvu7N8ybXNbOP
 +98XR083qplv2GotCeVpEz42iZoE8gkdeunUy16voDsVxwIu/4bc/Rr5YWeuxOLchRPS
 K+/JJkipLLBsUucgqH28XbM6QQHnEx8MzYrOyWpKlBKcRIshP3LqS2zTNjrkq7wn07jh
 sAIMNoGChXDCLf3EAIPdkieua2MCv8Kj/qWBr2CCIKTw6YqBypzzAeNI7KI7NNvaOR/f
 cvlA7kVRuzOxAN0CV/2ewl+DzzJbutlTWZ5mbalJ6vlRNREE5dB3ZbQYb4x6Jp9c/sRD
 MTHQ==
X-Gm-Message-State: AOJu0YztSqzFEOphQWU2n3hsjqg9TQjBExPZAe3Tb4sR2Q7zrBDHo1+O
 VLg1TsnvLXsR+Lih0jgnRpHFgIhE7c4oR/uVPxdAc3lpzcDOxNec83eCRjSXH5DeMQXiZHQcIcJ
 Q
X-Gm-Gg: ASbGncs+QrgJvyBX4AjeYegxg4yHZ6dynDY9ZPzVsaO7fGMpD8+5k6SSIxPg0yCKR+U
 RL8/0wDk2JLAUtRoWv7VUYQ9pRJIp8KLLMWXD9VvfUmf+ERrGqtrrKGaDP+UBB6C8AQo1MAWL0m
 CscE6dKHkCZF1o/06GI5vnDFGc+7kRHsN47wAP252ZRt2CyKx/60wJ7E3Bl8Aso9iVpG0VVCHW5
 AEdJl51QDy9+0u3savCXEJr57ZIb3bdsfAk9/5rcHhxo/b7LY8OgPSNbL/lTHpNVbYGdGNeO/A2
 wB8UkIcBC6OhwUBXTSC4wXJeZoKOK/rjhayqJuap0zQl4x8XfZD3XlZb3mL2bEhtypN0
X-Google-Smtp-Source: AGHT+IGqoEbmbWye2M2ncsH8Am46TCBBhP05qMWgeZeb5swkubK9oqG+rwDTmMIuTQHzxcr+Rq9v7Q==
X-Received: by 2002:a17:903:2309:b0:21a:8382:fcbb with SMTP id
 d9443c01a7336-21f4e700f9bmr67563425ad.25.1738952805262; 
 Fri, 07 Feb 2025 10:26:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa184ac945sm3074058a91.46.2025.02.07.10.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:26:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] devtools: ignore .gitignore in SPDX check
Date: Fri,  7 Feb 2025 10:26:34 -0800
Message-ID: <20250207182634.168820-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

New .gitignore file in dts was getting marked as error.
Change to ignore all .gitignore files.
Remove no longer use Kbuild pattern.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-spdx-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index b983268b1e..47bc9f7b60 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -22,9 +22,9 @@ check_spdx() {
     git grep -L SPDX-License-Identifier -- \
 	':^.git*' ':^.mailmap' ':^.ci/*' \
 	':^README' ':^MAINTAINERS' ':^VERSION' ':^ABI_VERSION' \
-	':^*/Kbuild' ':^*/README*' \
+	':^*/README*' ':^*/.gitignore' \
 	':^license/' ':^config/' ':^buildtools/' ':^*/poetry.lock' \
-	':^kernel/linux/uapi/.gitignore' ':^kernel/linux/uapi/version' \
+	':^kernel/linux/uapi/version' \
 	':^*.cocci' ':^*.abignore' \
 	':^*.map' ':^*.ini' ':^*.data' ':^*.json' ':^*.cfg' ':^*.txt' \
 	':^*.svg' ':^*.png' \
-- 
2.47.2

