Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E88CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A872B4065E;
	Wed, 29 Apr 2026 18:29:19 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 41AC4400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 18:29:18 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2dee127b3c5so4471833eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777480157;
 x=1778084957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwoksKLWb2CcfgP/EMhy0Crsnvtn/t8MYjJRD4mpGVA=;
 b=f918tJoqG0FdUf5XMJO1sJeQZRZ6Yhbqby4UglsaUMVqsUTNFiD9TFLM/t0CjB0gfF
 Ri5aGX45KWKOAojO/fqSYE8yNZQoVGnaGHw5Kz7Y03wFI/86IhFruSBQOB2j7MPtrgaR
 bmn0pvLNszi2IkRHfq9pOA0cDHlaF3A6sADQerdw0XMpiRhRvSdT9trZDrHTFKwIzA3m
 pD8qw+YsH5B8BV05XR+ygSM9aNOTnrCEs1Fzs8caBYS7Q2BuETEanQlf3ymZrLblKeE2
 lcfGJR5YygwJNxWK3nANlle2uEYUfFh91pg+qZkz3SIZJ1Fwh2EpIugjclOfsTWJsQCG
 NlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777480157; x=1778084957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwoksKLWb2CcfgP/EMhy0Crsnvtn/t8MYjJRD4mpGVA=;
 b=IA5+m3/Hk2WnQVkmTqDC3+iRvGvk1b9a1v8A2hleiaqUDsNCztjm+tN+NQ9GQRxrpe
 qmsMGOTteL3gMNGsVj6APYW+Jj/u014A/YLhdMnbd91WB4P8duPDceR9dAusw59FbpnT
 gfUvyDBHP6/RjJHXXAiKDp2/9o9Mb82WZwjs2mafgg8iBDvXGSZsk67rPKnJbnOLpkTk
 MES69WyEXHUnHflGUJpZzI9pYK9PL/h3fO3jDhy5NnaZXm4whyzcT8Z4ZraK5mc7OzPd
 OKQAkSwpyosrYnDzYFHaC6eoPVqSr1dPhQ0INZPCJo+stghvFDlKbZPRNOPtOSAYFIqt
 RQIQ==
X-Gm-Message-State: AOJu0Yyo95mNLUUz7IKSEE7M9pV7VRhaU9x1SoeE1s7l4seJtID2wkYh
 hmL7QN6K7hlcuPE7fZP1K9dRPt2ZYNGFrzp4AZ6dddKkmNho1zz+d6ljmGeAlaE/66BqDRZLaJg
 k0XTr
X-Gm-Gg: AeBDieuqGQv2ZeAVESrOJ/RwV5IUX+sE06PSrFunA6w9d8VpFxCC2Oe9cr37k6pT5uq
 fJkY9aHDm164wqmbvaqPVAp3OrDVtDkHG9nKl0Klz7Oka6WosVuh3HTJLlpzfRTulMPR5CcSIAe
 2VXHYDC12DNxoXwiPnMZicSx/s/2K32NjfHQQQMm1aDUhItRRHpZEcYG5ZcWs9lgbXrzQw1NR4w
 eDhkOw59cxh4wWj3bO8fvUzypy4FER2gALWwB3KkUiuvrrpdX1h8eYaCLVamSbRdnV8OqoKkBz8
 pZKkb0Akh9BO7j9MovGRf3Q4BzQA0pls7gfppkrpFKkbyerdh0nrhSfebGv8y62At8g/9bFNJYM
 NG1IZJdn2dyOWpfbPtbzhT9bYdIVteoVtQ1ZZ0v70QlZV0wC9iLd2qPewqO6khOb1ZTkKIEpnJ9
 s58Ws1sAqFP2NW5EKOhCjNsD0DThOUJNtGO63G38N26P4=
X-Received: by 2002:a05:7300:cd8e:b0:2ed:e16:6b4b with SMTP id
 5a478bee46e88-2ed0e16e98fmr3554655eec.33.1777480156790; 
 Wed, 29 Apr 2026 09:29:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09c6e3sm2646687eec.25.2026.04.29.09.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 09:29:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] maintainers: fix app/test attributions
Date: Wed, 29 Apr 2026 09:29:13 -0700
Message-ID: <20260429162913.272259-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Two app/test entries were attributed to the wrong section:

* test_event_ring.c exercises rte_event_ring
  not the standalone app/test-eventdev/  binary.
  Move it from "Eventdev test application" to "Eventdev API"
  alongside test_eventdev.c, matching how test_event_eth_*_adapter.c and
  test_event_*_adapter.c are grouped with their corresponding
  lib/eventdev/*adapter* sub-libraries.

* The "test_*hash*" glob in the Hashes section unintentionally matched
  three crypto hash test vector headers which belong only
  to the Crypto API section. Replace with the two narrower globs
  "test_hash*" and "test_thash*" which together cover every legitimate
  hash test source (test_hash*.c and test_thash*.c) without leaking into
  cryptodev.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..928e695abb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -540,6 +540,7 @@ F: lib/eventdev/
 F: doc/guides/prog_guide/eventdev/eventdev.rst
 F: drivers/event/skeleton/
 F: app/test/test_eventdev.c
+F: app/test/test_event_ring.c
 F: examples/l3fwd/l3fwd_event*
 
 Eventdev Ethdev Rx Adapter API
@@ -1754,7 +1755,8 @@ M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
 F: lib/hash/
 F: doc/guides/prog_guide/hash_lib.rst
 F: doc/guides/prog_guide/toeplitz_hash_lib.rst
-F: app/test/test_*hash*
+F: app/test/test_hash*
+F: app/test/test_thash*
 F: app/test/test_func_reentrancy.c
 
 LPM
@@ -1985,7 +1987,6 @@ T: git://dpdk.org/next/dpdk-next-eventdev
 F: app/test-eventdev/
 F: doc/guides/tools/testeventdev.rst
 F: doc/guides/tools/img/eventdev_*
-F: app/test/test_event_ring.c
 
 Graph application
 M: Sunil Kumar Kori <skori@marvell.com>
-- 
2.53.0

