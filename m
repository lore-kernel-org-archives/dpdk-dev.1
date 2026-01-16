Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647CD4A603
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E335542DCB;
	Fri, 16 Jan 2026 07:47:02 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 8717E42DC9
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:47:01 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso302110966b.1
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546021;
 x=1769150821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=dEuqF/NpXhGrW/fq3k/J3Ts4QIzryTMiakDERXxC22VilhFfLddLCR4pCXkNM5Q16F
 aLxaMK5SxkH5su4jINLakVb5Qii1VqU1wNM5ymDlQRz0UoPgz8+0NDR1HSI714qFdGhY
 p5cJqXpkm5lEfPa/pC4S5IN5vwQD/YYCVJVKC8dJ9AB6XfVOh7H9VC3S8JBaow1LvFD/
 JSarrn/LQrcfxKYY7LfAC18/3e2U1UIxxMNtIZ9c2RqKUiXJ5eD3X3mcLfJhl+RcAR/4
 R4NWUwOJgCe3Ist6eQp7sPJ2C3Y7n8TRag5dIX7hcWUfIbClcM3JkEZ4899vdj+oeOIM
 I/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546021; x=1769150821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=AhZVEDgOrN/K/wh66uvYfq2bDLHP8163XpaN7NJTa+vf5fMNr6A/e/td0zl6JXNqJt
 0dozXRX72jrydquX9Eg6bM2bYoPzPCLhDzm1Rc3b51a9b8wiDzhqqxzeWBdpVrgaYCy7
 XM4E9xlUtIVVNfL8S91AHFo/fa83d/KWDR9fVn0bUK6GHRym2wmxpvPam9D5iRnC1ArV
 DsNwhLHdUko+G4N+uve/9Wy66o8GDy/3In25rCAS3CoDtIuSqIZGjAAiEv1sNe0l7VlS
 gCVXferYR+NDYvsQrPdxa/QYCt+Y5CRi73YD5USZGW3OlmCQKHuO4Wggb4Pu6tlBhac9
 4tRA==
X-Gm-Message-State: AOJu0YzbwHFJEa7D8y3ORTOgHgNKkIhYGZ1a0UYa/16H5hp0HcC/oiXE
 noA1NZN0cMe6d/b+LPfrOdhjb3cf3PY3uNRUs6Tje0511hi4R8D4vBhrAhZgPwhK0R6xy11RGoT
 Tv40v
X-Gm-Gg: AY/fxX6Er2xlm4b3+/ag22DyX4rf5urgXicXOnE5L/uB/vzY69eNS5LJRnDboIcDP1B
 GCddOvC2SUyYuc2BtVEezcT2pNOQd5g+9Oc6gmjq9MX7clZE4osYcfNPGqSRXEcXtlpvhbmCytF
 FpmCGJdc8T6sN458f1KmyqCVFmZtrNh/JfiN1ySfmBadWzPQH3WnBngUDqPpbeRSC8z2KdawMkx
 miB42n4S/5gjFUxCJfHDtw9fA17jG1HkiDg84f38vyDpOR9xH/5k/QezP5zAzR6wWesrD3M7cip
 O224WmIGEK+oARrBoOFctI9hMG+sebEZxHYj+WaSIJ5nPvJaPK6WGIIKsOoeM+TcNaMHoBje3rb
 kjMglET/MNxctW5QoaO5tVAuQnmIDaPrWh3x7FzSqC2HP7ifXLPJxiaUBkSuzD3W0jz7Mv63e9/
 RZqzcw7k0nhR+fQdPsP+54+ufH6aM1MteUEVg3sptczj0pEVrt6Q==
X-Received: by 2002:a17:907:3d42:b0:b87:35fc:ae6e with SMTP id
 a640c23a62f3a-b879327dfb1mr183688666b.46.1768546021060; 
 Thu, 15 Jan 2026 22:47:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:47:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 4/6] common/cnxk: re-enable vla warnings
Date: Thu, 15 Jan 2026 22:46:25 -0800
Message-ID: <20260116064646.224254-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

The code in common/cnxk no longer uses VLAs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index daffc15afd..58ebf4c99f 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -94,8 +94,6 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
-cflags += no_wvla_cflag
-
 if meson.is_cross_build()
     soc_type = meson.get_external_property('platform', '')
 else
-- 
2.51.0

