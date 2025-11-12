Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B39CD343E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 18:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01BA740662;
	Wed, 12 Nov 2025 19:14:26 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9A8DE4014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 19:14:24 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso1128154b3a.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762971263;
 x=1763576063; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWXUK0ag+LP8rV6tycLddAlt6slgm9efyr4v2tsrd0o=;
 b=0JRcJoFDaV6tpjxUO7RMoHzTO1ZPrpciGHamTTSuIJFuPJqlCBjy1ooK3dRr1LD9R5
 hqUR5WCDMcHVoKguH6ac2NOpc/ykwUs9J+bk3XITgGqfB8E2rTS5M6KOfxmy+tmwveW0
 qAcNoLcsvi43kgEYm8dB5fAlA9v/LSnrpjp2B4hOTgBmmnLCmpyNmhWzX+Z3ZDDBKyjb
 TQgM/0GVU32fF3QOjrwiv0tnjuSjNO1egZQrZWwFDOf44+q+/Wg6TkAjRYc/dHXFK8j3
 UandLhF+E+lNHBdJZ6LmxCarbQDsSe8vzYF3yG2OJX2cld7rkBM75g6AWUP1Ym05gwwf
 cLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971263; x=1763576063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UWXUK0ag+LP8rV6tycLddAlt6slgm9efyr4v2tsrd0o=;
 b=frG9egAWIF4H0tku0Trdinvm86LJZJqjIPej96C5yneay7I5Mz9vo/+6EIlJGg/vAJ
 FzNmhB00QEkiCOmvAVv7lyeND/t2NTwEkEqX4KOa2fx7pqOZsTqrpSV85lLOsq/eqpR1
 raAq2kh3MahCbGaVcy9U1BuWFk0EVBUwRVPrCEzJPsnB4IkEAw3cF2LFbkeQtP+aLfmC
 KYoYfpO/vxYyxdu6dm5sIgCy/0Dnt2VTd6koDSQutaYAnOgL6xS/PlSFJkB6+lQSrm2t
 MCDY5+9tagfLOzIIxGAHF4fJZmYM6IvtxwvxrktUU4Y1HfMiO0yCLMwmUJeMcaX7CErc
 XJwg==
X-Gm-Message-State: AOJu0Yx6ZsqbsrJsYC8gGwkTNJFTb3qfARZlgMqcMF4+UB3xsNHQNZjx
 cVXCjjHTPrcUzrOJbYfABvn4QG2IsJqKXkNwnYitijhZ3V7/MAsmTqnb+f8h9AaXqS/FZH0Yiey
 vIq8O
X-Gm-Gg: ASbGnctwz9BkWeIoVZq2cLVh4jpS0XdBKodPj7ASWeJlXQLffDXL8u5OhC8Pq/TekwB
 c5+ZAubShBqljwyakBfEUYSvxxdg3PPUtklRmh3E8zqIVD5/p92YxQ3xK3VR8NjYdQ2ERxDETDx
 v8nhvQTOHTWS/IksFjwOPoQAs+a245SSRjAMb6Uz8ZRbMld3GSfXVESV3zerbPKt2Pt12C3xzQV
 80HvziFGRRa61SS/gXe+49K1p9G3FcsfZfZ5De08AfxiN8jw9lUFPmMcDJ+MvCek73h3kFBwCb9
 ySGwO6WXkF5sPzNps1ejo/tXzjhOcdUQF8ILD1gJ33V7NoGrH/XIqGcaFKs8OJlfIr6WQGR/eft
 B3JF+75lvsCSwAntgQZsqUNxHDkWYGZEaXvj6SoG8wkXyUBg65KMzNsGXBocFiqsIQmwCa8JEnJ
 XzkbOQUTuGYbJCqRM+9arFC+z1AK1SE7JoQ4i2Msw=
X-Google-Smtp-Source: AGHT+IF8+vSF5LPQLcGwlQ59NBP/H6FhlTd+v/U5lFvK3LcDQV+5CbSC1iupbU0lAgDaM+vGq2dOUw==
X-Received: by 2002:a05:6a00:1493:b0:7ad:1082:fdfe with SMTP id
 d2e1a72fcca58-7b7a52c672dmr4464873b3a.24.1762971263517; 
 Wed, 12 Nov 2025 10:14:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17b0b5sm19294006b3a.35.2025.11.12.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] pcapng: comment handling and tests
Date: Wed, 12 Nov 2025 10:12:46 -0800
Message-ID: <20251112181421.285119-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210657.871310-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
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

Set of changes related to pcapng. First eliminate VLA then improve
handling of comment strings in packets.

v2 - chain mbuf if needed for longer comment
   - add more tests

Stephen Hemminger (4):
  pcapng: use alloca instead of fixed buffer
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test

 app/test/test_pcapng.c  | 116 +++++++++++++++++++++++++++++-----------
 lib/pcapng/rte_pcapng.c |  38 ++++++++-----
 2 files changed, 111 insertions(+), 43 deletions(-)

-- 
2.51.0

