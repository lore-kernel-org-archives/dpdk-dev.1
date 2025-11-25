Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CADD0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2B3240E20;
	Tue, 25 Nov 2025 16:22:57 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 29EE540DD3
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:46 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-297e264528aso60430055ad.2
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084165;
 x=1764688965; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=midG/AdhsizWFZ9rHmgsk+TQf5UrWGtmXv4pFk7rKC6dqUPafHmYHGwPr1BKAP1hrE
 qWEz7ws61T1XN91AgmJvo4wwvuU71FFzeyfc3wrWr7GHpbbf2Trq52Kt+XRc5BGgOBl8
 EkFSg+tpFTQ4Gn+5WzePbuep6jkt+OT9lA7drYoap3Gd6GOBl7dm/xLJOgdNCGUOwsbt
 Sg4q1vSGrE7NaPCyr4hXQNUXxzq0P4PVJdq9XbO1ml7qGfzKwccqYuZhmp3mZTkQ5WRl
 KV2ee6pr8stRps3JRDjWGn1p/9HGMBE0XV2K4XDJDMX3tzBsfCgUiJqrolF4fTt8G7Mb
 qCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084165; x=1764688965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=EZoCd7gTCoebpv6u/sgXZnIYR7P1Pm5DhODmUrt3nn4juMdCZMIGV5IvNZzG76b3CL
 ONeO9yiNVJKri3a48k5+/zr81s+d/b78mq+rST+z1d3s8QxZk2mBJwOdpnUyAp8Zuesb
 Vwyd+TlfKC669kUgt3t5lYL/Ae2IO2dImqh1ctJKSJYMwUvgpNq22B3DMPUJCYmgD4dv
 bKVU0otpxFB2dcYpfdTaa7MP/tpvmg/EQnKogb0kYRi4vRqL5GXclIlwFBwwSCj/s5vO
 Dbal/FxwjyAwufijcIlv5mvYyho8RlZIvkL2oYYIiYz8KoPwdOH1QsFFHrLY5gWKv1QL
 Smkw==
X-Gm-Message-State: AOJu0YwixpTqyhDgbo4OMSIYqrB7rIn39HuD7UJZmbyR2zrPT1outdTb
 ZO2TBfp6M7grVOjtaQDiJPRR7f4FfOo869B4FEquOYH753XcT/+1u685nVX+ZPVJwFszPejgApu
 mmYap
X-Gm-Gg: ASbGncse366ry2cP3KOrhdsdToNUlr1rP2FmhAPlIXFjIbtJrESH9yz0oPiOzyRX1fy
 fX9XwlXPivGZPVuHCBgDo/z/Oy858TdSYrFyKh2LTZTuI1E6owsu9ZUf0/3/SH+BwNLjlvg1/EJ
 9/+F2IU6Oau6+mttXhooYOuTQsmQ9xDV7bqRXd1Q1nQmvsunwYzXc4ygABMwde1aDdQVldaAl5+
 KahD/gxxOZ4yZjv0/opI8lJQHsMUxyLE1L0Lc/hucOuuGaYiUrKO3Y75EFmi54yyfwnPISDWwQ5
 nSqUlS8yRLLcte7e/v58OwASuhNv37hRJgTSN9/gWRLatTmeUS1uYaNq1TkTWi1kl2MFXoz/Oka
 0PYGaLjpmY6ZyqAZS4HP3mnrmwp6DSgIg4Us+IGiWkaQ4nQ6aWNdbl+znCL7jSB5IBofLcu5q0A
 rAv2/J7IpPq8oTiIzs13MbAhG+N/DGbkSS5P0=
X-Google-Smtp-Source: AGHT+IGdpcZvk4ePmRHPb5+EXQK6jiqiKct81ESduDDQE+7eNts/+8SvYZNV+R1QAD5xor94P1VW6w==
X-Received: by 2002:a17:902:db04:b0:276:d3e:6844 with SMTP id
 d9443c01a7336-29bab14895amr31983445ad.33.1764084165309; 
 Tue, 25 Nov 2025 07:22:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 10/10] test: re-enable format-truncation warnings
Date: Tue, 25 Nov 2025 07:21:00 -0800
Message-ID: <20251125152232.73528-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125152232.73528-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251125152232.73528-1-stephen@networkplumber.org>
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
index efec42a6bf..b00260c0e9 100644
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

