Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F1F8D755
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 172124065A;
	Thu, 16 Apr 2026 20:47:45 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 386CA4065A
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:42 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so15832444eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365261;
 x=1776970061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=UuV1vQ0OMWR5qqAl7vhk+XNPP+8TgiTezuGNTthB9R9VQWxnHThLXQLIWD5q1dK/nv
 pE+OLD/vPySClh/YvJlB1Db2xfx1h+1EatQhPHshOn3NPEQY6f1d2RFzUweASlwtZSs2
 rt4wpbhFMqFk6sYA3sKEbRbywXYaP0Wb7+5OnKof1zNtTgp7bxEAoF97W/H3XhR7p4M1
 fIv+VOLkReFSwdphlLRXJz7Ecl1+TQbps7larGQbX0mS+ZVOlGoZXeKJLJrouDlTW6ne
 HoILMYeiW/F6JVr/xrDjoOJzim/hqK0B4VSG6Z3GZGPcCVtr6cKmnJvAOjv18DpJM+aK
 hnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365261; x=1776970061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=C3MhJKcGQVv4aaItuQzFUvqhXWgvhktPy4U3sPQ1ugU5mCFFNBMlMZa1Kkhkz6Fqoh
 AODrphbtb7oh+hkeCTD3fWi9igm/YJOQiXvFQspzZh+nQ/hsjwPBurD8ELyK3Bov4HqY
 uDcA1JoIuyToEK+i3JzCHS1Dl9rCkludt5UBbnskHbElMzprrawhagOo2XTMBKFRws27
 Sokm1srftkCAhQXE1l7vOgpMlKYJ26Iyd+CHDs+KRuM9/2jwNO3xr4TGpumBx4HOI7Ke
 r4vbK2YUCBR2QUvM6tM2ntV4Zsi0MLnB3oeaWsixrxK/jp1Vd2aYzn4MYnKtukIIW4aS
 dwvA==
X-Gm-Message-State: AOJu0YyuwnnJoRsvGDSKzQAZK0rPmho66TBx+CYtyH0HfuvoY67TcceV
 k+2W8btlN84K3MQVZRWH2zjP4bCIBzuRYCaRcYmLcIkPt6C76C55SJIOEHhXoDEG0lz0ZdmIU1v
 9s11u
X-Gm-Gg: AeBDieu8LKvlvTlA06xCpNwf4HUahuE4mKonQlXtDVyCxvH/tBfQmtMImBboFBnYMdh
 HnuPDaRhu58TiQ6qwcjsidixoSFDxzabgL3eXkZF478+PkRd4m4Mrc3skE7CHipO8RnxYG5qW+R
 vDhDLdYQx+wQdyitwopvI8fX6FMfOyrb23/C2S8yTg33UtIq7jc7LWqMMO9676ZCcuQiLlXJQHv
 tO/dtJTrySLpc5L9takEg0Phr5bs8yQrGtm0wQ07lsO7i6thXMAqlfoFLVpRXklMTp2ECyxMBtb
 j+PzZcCJy5Kv4kRRZj5C/3UEXCI3QhiRfVgOsj3jyWQtUpCTOJYP7jhXTCCoVx2YCm4sm65s24S
 jVVyr1nDJatg/tIBuqDnoTG+sX5Ye1j92jUYuGKHvQmlj6NMTtvxuD2C55l6rX76jcj7BL7FvCt
 gEFR9NpruxOvslzE0qQQc8A/dj6MiH4nDBWaNRJW6wWAxTVvsS40aasQ==
X-Received: by 2002:a05:7301:4185:b0:2d6:78af:ef5f with SMTP id
 5a478bee46e88-2e2e309c5bcmr259051eec.3.1776365261194; 
 Thu, 16 Apr 2026 11:47:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 03/24] doc: update features for PCAP PMD
Date: Thu, 16 Apr 2026 11:45:25 -0700
Message-ID: <20260416184731.1347342-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

