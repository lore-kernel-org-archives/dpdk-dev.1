Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5062EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B1540608;
	Sun, 19 Apr 2026 18:11:05 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id C3FCA40291
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:04 +0200 (CEST)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so1799768fac.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615064;
 x=1777219864; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=FUPu2UdwzYuyKSX0xylJofQJJTetqvIJzYxSdQQ/DiwAfHAYdKJmrMBXoHcisWvllv
 LGFF4vpmU8G+OqS2eDc4U43wL4VMnuPgmJSEMvfK5VNwle03J3ouGxMoVqbdG3dTX0GI
 WwbxPH3r8dNDYL4qVjBGXD42n+2OErbn5HaFZTGbn8pIVlVmC9N2dBnZebGPKHXzXdAt
 R19Inq9jd7EP1rsKs8AdzILiN1yNuQR6TWebXxDdTPz9Xet9lFWpD7HVO0ECzvbAPg2O
 YDyvGhm3qIz24/lUz1se/G9R6uHn8gbG5Ag3hSvvkJeFJtnDeem4mxqTJmlK8U4YywYE
 WlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615064; x=1777219864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Vbp4u9gM9TWygNLGhiTUb6nULz7qpRw1eo/ENs94tw=;
 b=Ff6J8PQXAntyud+AmPCAaEBsu3FhJX9/iIbpJem2F39A92uGtwDOhYmEf0wDBF8SBi
 GWhV+4p0itf1NqsZwg7DKD8zdV6LDSRw3TpChecGiDU6znOjav9xeXLmnAU5ZrQFfbVL
 ucefRez94/9l9CW9E586H2wV+QxwAz8dmtUYJYCmFld0Tj58mzN4RYWq9Vwws83Bpz99
 ikobsUobFvqh7HRyxEmwi35+SNWwbV4GOb1O2bwOoeMtKDR/Qd/frVg+wnEu0X9klrxY
 Mrlxho1oxXXOrfomeq0SbQ3LkZ2qAxfTSxsWgBamNZ9HQ3lyIbdncROXAZW8Q3xkCZdv
 GsQg==
X-Gm-Message-State: AOJu0YxYz5pMSEY3KeOqmJ+0B1g4wLkU00e3xbG/viaFhAVznHuW5hd1
 0U3FZdWWz0I+ygzQ+EQWKGMGGyYv1ntRQZsBnRiPdjJqxwyNP0P+ZkbzCT6yHK/52GMWLqSiPBf
 FusCe
X-Gm-Gg: AeBDievILVkQcO2Xyxz648mkGHWuA7KAQYAVrrTkQiPagWIt5tj2QF2Jh4+uc3jREQ9
 3nr7ETDnbH6ZAxg1MLK+cBj62ALEdrZCd9HlG9kXwc2EvNC6BIxJiCsz3YDEGl33VrvEQp/5ZXa
 gdGDD2vilNmURvGYs7HFE4qYEi1DBHEFOenD2Q3zGYuQoYnBUOlgnY2bAXE7x9jh0MqbyENRif5
 7/c51dnCxM/qV4dXQ29tzXNdRtNGNsGJPrTAZ/94M8tMlY0kU7W1kp8Ml/D/jNSGpTK/dgBLEHz
 lqj3mqtztOx0kElRdoFMG/zmv9YA8VjpUdeaZtIBo5sfJZ4qO/xYV3eymx6rozA+hFjEZL+rxUk
 DB3cgmpqokwJpjazwIwyhLKJwUX7Wam+x1vVQY20is3lTrVNz3PbUJePLGbI7mtzaVzN74sFfV2
 unatKyCDLiUPEj4GgmVWCEjWJUCU++nWM2z3cNgVNQjmk=
X-Received: by 2002:a05:6870:d0c3:b0:3f4:fed5:d88b with SMTP id
 586e51a60fabf-42adedad09dmr5677667fac.35.1776615064094; 
 Sun, 19 Apr 2026 09:11:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v25 01/24] maintainers: update for pcap driver
Date: Sun, 19 Apr 2026 09:09:34 -0700
Message-ID: <20260419161059.205954-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..580113a658 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.53.0

