Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15DEFCE33
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 18:04:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A5B041101;
	Wed,  4 Mar 2026 19:03:20 +0100 (CET)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) by mails.dpdk.org (Postfix) with ESMTP id D352140E7C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 19:03:17 +0100 (CET)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-5ffbcfbcec4so177220137.3
 for <dev@dpdk.org>; Wed, 04 Mar 2026 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772647397;
 x=1773252197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gVRilbtEBuiCuBfPvgGSxQx8MO/vNDZx0iQln2wnIY=;
 b=FfobP1pp3d/T9B/UiCoRP9tJvTVt1YaXqd65FiyKYqqrwT5qBDHzvn27BxTgCt++w1
 jddiDZ447KwfqTD/m5Mc/W6XaCJSHAJL4jkPo+PLXhkItYmfQ3S6hvx51WpQqK+WadVl
 QhrKX5qKBOCzGtezeiXJfkC4pHysc9RSdDtlZApzEotBfJX35zuVxxLUUPQhZCTVl5NM
 fYp0eeTBPk7X/JmREAhfLjx671mjxq2Dt0/bvG2ETvcLqD+laQcidpV5KpzcixpXsI3y
 8rrcYtpZUVBDWHTHKEwkNB8wdCNh/BWWJZV0Xclr7wqihkobtJDitZFlp5/eYQemDb63
 OT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647397; x=1773252197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gVRilbtEBuiCuBfPvgGSxQx8MO/vNDZx0iQln2wnIY=;
 b=uHqzDDyw5TZE2kWHGwcyyGCvom1HikCYIZseewVkM1ug4d/nTVZxPjA+BuX/Ze6gVc
 dLY5CNrJCW+I6Jcnp75b3O+rjtmApcHIygNOOGEBPI9maZ6D3hsnA8Sb/oHHXmia9yjI
 SNB6DyVppUmSrWOuClvVWSZGkaGPZfaiMx2pvtZVtHz24EfqrUT5EZggOBdSEWewGAEw
 nVROYWqzc0hcMCNWQlif5hRD54If3DfDX9EP4u7vP65hOYptNm30Y8C+snZxWGV/3RGL
 Boe7JnYF2Z5RFh2RF4o3qu+6ZU4/kMFlDM/afhBD4SEjIr2p39u8LucNCk23UvRGt1Qh
 tuTw==
X-Gm-Message-State: AOJu0YzBGf0AcLriWO+hiwIYPG/OBzEInGg4BHi+p5B+QmjNDk3u9ZsH
 iW4B6JdNUrSOfZ+bmycbT05JufCuCpnMUQOB3yn6FSUY+CbeQaT3OG7OXsaIDpjn0d85WhrUTOQ
 v/L/m+NA=
X-Gm-Gg: ATEYQzy4SsmLLnRNf5/3CS+dcqttthEjoxzSAMhBop0PUhhNx46UhR3U27r64N/7iJv
 Qt7xBMCMGA18hxhmzztlIXNXaHIFlu3d1Kk4/Z5PfPQWu1u8LHa/w6c0rvYof4Ap/8/3Hg9YXyJ
 ipwMuTQRgzYjBlzDxWtdWcG/q7EzxVQJ24YcBc7lhXoAqsGV49VpNfuxh/ijl8J6LAnCUQH9KA5
 Gx/joNPFS1CfS5nEvilhV56L9+5Uhg5aPVd7UmKrv2dxlBfjr8sy+61PZI90yESPJgL9ZUF8ILG
 KcohyrdXDVL7UDSBv6Z6hQqihOLZ/wvnhMQi+KCQCpTiU6YaEoMPjQYr2/K5DT6KLI0Nl7ank57
 JKPPnhsuVCwZhH0RicXMcQKbTg2xi94+KRE+HCIzlLURE5jbf0fv39twGdQjQASjG3R9ZPnERec
 kjDpWLKWS9niEECPreB/Yw+TcXFNcyj59rjS7T2tZjznwc7x0tN8D9Rq33uo1H3r29mbqj3B+i
X-Received: by 2002:a05:6102:3e8a:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-5ffab2433f2mr1158043137.37.1772647395645; 
 Wed, 04 Mar 2026 10:03:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a083a95fbsm51698626d6.38.2026.03.04.10.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:03:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v9 6/6] MAINTAINERS: add section for AI review tools
Date: Wed,  4 Mar 2026 09:59:42 -0800
Message-ID: <20260304180303.436779-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304180303.436779-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260304180303.436779-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eb8e9dc22..7c1a84274f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
-- 
2.51.0

