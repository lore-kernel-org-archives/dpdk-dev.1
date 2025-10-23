Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E1CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 19:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 666344064F;
	Thu, 23 Oct 2025 21:42:46 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 9E7AB40431
 for <dev@dpdk.org>; Thu, 23 Oct 2025 21:42:42 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-33ba5d8f3bfso1069177a91.3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761248562;
 x=1761853362; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LenICeMj8yM0oShhvBtF7tcDxv1QnHpiEqXqvSSAQc=;
 b=ZUUXxXdq9aXRM3dPcK+a6HFY8RTTzASjMlV9bOg+aN2Ebp2Rpf3KoovwwjEOGNujmx
 9KArXGIV/1+UUl4pRKddLw6dLX67kiwHcurG0npmSLICjq0xdvZhTUtJ9fQFbm1n2iEX
 Di4h+nGF2yAmTiOj5wAR0z8b9/R9jaAzF7LWTIVVyW8CBqeIanuLKotjElayipCWdC7n
 8ibsawwJgr7/rVPC358PNZmwj+vJY605UKyc9g4lR4wD+NQcK2zM6E62XKC+AQJgtoKi
 oIOkgka/Su3ewmOA2Wb1Bds5qpvGX8DCvzmrWp5cYkzx0kfhaW2XhS0N2paHaciX0h0+
 V8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248562; x=1761853362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LenICeMj8yM0oShhvBtF7tcDxv1QnHpiEqXqvSSAQc=;
 b=EarSBPIt4eC1cXCoNf7Hqralcb24uknAfydskI6jmzPGIwsl5dU87ENwLyKpgO+9je
 ikAdEP9Qy9I3un9ohc1u049sJ8vmLFrZEIB10Cdz2Ph2woL77F9taehSC4xSssqDqOvU
 y7pVRIlLxFwZ5EOTC1nFjgqJLnFaEhrF58r+ccsagZnWwAETNLhpiH2hM2C7W1PKwsYt
 w7dyLrRwa12a7ILwkhshW8djJJ2XNhHqucGerIFHO1fv7XewnlkINt8JOUMqyuejPORu
 oWjqM3jcdvd01Up67Vr9D9oPzm6qCFRMMNTmd4qgvUDsU/hv0qH60l3VkZhIL3yPdS4p
 ry3w==
X-Gm-Message-State: AOJu0YwJC+e1Qn2EkaFTL7eT97ENpUk8Xfp0XLJKRGvsAs/3JJ9k/RNi
 ctROjvKnLB3YER07BTHw4sgmEl47OrYcv4T/DMpm5JMP9UcH6XgTwu22EYd+U+oTToMhIRDLVek
 MzKZe
X-Gm-Gg: ASbGnctuavDUlEJPQ1p9uua/x8LKk6NAqU/Lf+lhXkmNqz5Ys/x+MCiJorC9WF974+q
 S06qTW2yvZYMikRpgDxRpTADVhNuuZL5uHapndmUlASog1XYwOljxyZkSS79FrN1nZmiukDVgaF
 I6Iy6uytyYYYSC8BvS8a4H++OdeqsY93io+nNeLsQ8M/jjcYgzOiLOtiE/G3qONAytumpf/WmIf
 OvzqLhUxryh97muFM9bjHhwPo1wUH8tSOwtefCZXSjEVQFOML4Xx7kKHfDEhpk92hQsHJqm4D/l
 FxZEsjODr6A4T1iGFejmwU+HiGmkn5Z/aI2nlzy/HL6hqARsIA2VYjNDWYdmLHKqJDnPFNjLRIf
 kZL4h5tBLNp88i+pFE6JdgviGrP+Aey4WIw41pbTf3okaoF1NQ5pW0cSxFktd9tkrIhU1AdCKBi
 GlLAR1OLoq5Y5RbCyEjsvAX6pd3x15yOcgV3eWiT5XeOAYOZAOGTVGW3vgamli
X-Google-Smtp-Source: AGHT+IHE7UZ0AZ41yL2EsUuk7mPZT5kZ7BfbPTQIbYSRa9LViI2PAWgOnurICd1iM94LyiKMQZzCrg==
X-Received: by 2002:a17:90b:5290:b0:32e:a54a:be5d with SMTP id
 98e67ed59e1d1-33bcf85abbfmr28907116a91.2.1761248561621; 
 Thu, 23 Oct 2025 12:42:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4e15a80sm2884768a12.22.2025.10.23.12.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 12:42:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 3/3] common/cnxk: re-enable vla warnings
Date: Thu, 23 Oct 2025 12:41:33 -0700
Message-ID: <20251023194237.197681-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
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

The code in common/cnxk no longer uses VLA's.

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

