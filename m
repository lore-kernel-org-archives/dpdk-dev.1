Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3255C369A2
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 22:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9C3C40672;
	Thu, 10 Apr 2025 00:42:40 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4AC664066F
 for <dev@dpdk.org>; Thu, 10 Apr 2025 00:42:38 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so13264685a.2
 for <dev@dpdk.org>; Wed, 09 Apr 2025 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744238558; x=1744843358; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tl/Db0aW+5WTrf+gF9NpsQno0co+DwBztcSUNcxm8RM=;
 b=f+2+7aXnVQ4p6HWdpl1XhqxewlB2xaOBFuPbG4/s335c5yvIfIV/0yfK9BQfwO15G8
 JGi/I0CD16EHNhpl1kqdCio67XL8D0QHdseEEmD2v4CE5WhAZ8dTNAIvWetYIS+/Ip//
 DeO8t1eU/VYb/PaiBRrnvQOX/bz7v8+v1XaYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744238558; x=1744843358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tl/Db0aW+5WTrf+gF9NpsQno0co+DwBztcSUNcxm8RM=;
 b=LKjrQk551T8id9Rf0RqfsWbTXw3l6AUyodUMT+dFSb05McI/cZUusFSR1FKKS450+3
 SrapYbkJhY3GPZkfAp+T6+mW7Kxzo/DbdIrFtwvNIHnrbkE/chJWWp/NA9yJmgTNabYc
 9fgUsqajGcArUJfqXUdYeN9Y9WIqzm7nOJ2qseIFlyTLVW2LgItoWpLs5rcWJ+ajUYey
 yn5HOERKEYM+qeKf95014AwNrtzI9p4ObjPWrdzQRhmwTdTAxxoRbs3hi0kgsLsNPXWW
 F91ZRVweNZbt+CWzmbPpw6xWvNfw/X4Bs7H0T+EWKSKg/HMNKiFe9yGHU1/0jiO+W9g6
 fc+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtmkdBNoy0yVZbPTh80b6u0UWKHbAmbi4pAJXvfbDu3hdIh+/lDY+0seqqlV4WZ2Fx9o8=@dpdk.org
X-Gm-Message-State: AOJu0YynqG8LmlJTk2m7ErQOPmzVkWRYUPb45jzuN3PZTba6uxB3z/5Z
 xFdcwmIfxHAzmdxnYx6rTbPExw8W6iYYoiMB8BiURr9h05pIlGWFeLG+0gf5J0E=
X-Gm-Gg: ASbGncuUrLZBG+8wnC0MVqYb7KlY45e7EqRCE8n+Q2DlRcXjX59p37wuFatdT2EnSmT
 MTGGZ3qR17/cqG5P3ksImsR1VcfuxfQ6KLp+Hkk46TwGo7Qk9yvQc+r92VPd6BFq/x3fSnqIf1c
 YcloUM/66qj2TTZLnVyF1JSdHxWe6m8cXXOJRYTMAD5oCotWwNLIQAhz/2T59AGUAvbS12eIWJg
 ku41MQuyt18WD251KX8mjFn4BD6IFZR5iwygKGlxsRPGlIW8ve9LMD0yWhPI1q5heinGCckSd4a
 qkX3njNtKxksLIcKrJbJLWVx1abjGmU9JlhBk88U9aMIQ5XWG7nwbnRSfaAvytZGJEc1FPVOJzA
 FQ6D7BMvaEpwXBHp3yLuODqnw
X-Google-Smtp-Source: AGHT+IGVJBYI+Oon26eiDIslYUeDbZD8DOuiAoNCmy3qsL1d3XtCRKrHAjsuOYBv6pgAocBYeP3Dgg==
X-Received: by 2002:a05:620a:3e82:b0:7c7:a604:d432 with SMTP id
 af79cd13be357-7c7a816dafbmr20251085a.30.1744238557933; 
 Wed, 09 Apr 2025 15:42:37 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c7a11ca015sm125949985a.82.2025.04.09.15.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 15:42:37 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: probb@iol.unh.edu, Luca.Vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 npratte@iol.unh.edu
Subject: [PATCH 3/4] dts: default smoke tests to off
Date: Wed,  9 Apr 2025 18:38:24 -0400
Message-ID: <20250409223825.1579256-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409223825.1579256-1-probb@iol.unh.edu>
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250409223825.1579256-1-probb@iol.unh.edu>
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

Set smoke tests to false in the example config so that
users will have to consciously decide whether the
smoke tests will be run or not.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/test_run.example.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/test_run.example.yaml b/dts/test_run.example.yaml
index 330a31bb18..1bc436eed1 100644
--- a/dts/test_run.example.yaml
+++ b/dts/test_run.example.yaml
@@ -27,7 +27,7 @@ traffic_generator:
   type: SCAPY
 perf: false # disable performance testing
 func: true # enable functional testing
-skip_smoke_tests: false # optional
+skip_smoke_tests: true # optional
 # by removing the `test_suites` field, this test run will run every test suite available
 test_suites: # the following test suites will be run in their entirety
   - hello_world
-- 
2.48.1

