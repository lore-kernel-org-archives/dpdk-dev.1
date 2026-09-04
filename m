Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C2C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 933B7427E6;
	Fri,  4 Sep 2026 21:17:01 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D04D427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:00 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d9db539a54so12654765ad.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549419;
 x=1789154219; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sE0HDlVPylzpGfTbYHb6i7dbHxhaRpPWURoVTzCnnLU=;
 b=YtjvNzKKpTK8scyEAbNWHgqhYbpLxK49gCBP7Gv4CeljtaWRpxs6Q7aNBjVH2pkubQ
 aheLDe3J8Xiqi4tVuAyTqTvoKk3F9YNjmg1YLcVh4BeZ62JADTsitIVBfFYF549Uz7Xc
 O4BJOeIVDdFAUjoYXbqyl6ZWOqwEs1tJXL7ZeQhGLPcUFrX9CRL8+SgvGm4275WjUePY
 /irzIVozVgeDEVpeXNhMFeiK+CERq4LxsX2+7OUSoD+Gu9wtsMDObI6OwHhqwwgsr6J3
 1ZIGrKfR9oHIDfc35NbS1mYicbSfuvYJRo9Lp/52kDFdbBY5RDFjrz7/LTbK4drSO6sP
 ueUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549419; x=1789154219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sE0HDlVPylzpGfTbYHb6i7dbHxhaRpPWURoVTzCnnLU=;
 b=Hd8qUmOPIUPTM8CENKC7j0ipjRtsq8jCxw5RwtowNVVfVoH3GItBvoV87XketHxuYj
 /s84ICY6NMFcpfRErL+4cMnRH9y52qqMCaETy2vnkYUBTMHqcs+Wwe0c9CBQu0lwBVQf
 hylseue/8YVjoHQu8kDiFmVXYaleBnCbNtju+ouYOElbqZkPIoDgQJu1wOz+rYZXCl3f
 pyDnHzAKIfowj71NCMmcN+Ql3XxiqXWIOzjaIyZ+a8FPnJUxhqg3C+LnXaFNVAACdke0
 MLEfDAxobn3src//3+gCJ97dSOxbcwP1xSs1AtakQ/hecQHkOIsnNOKCk5t1wbqgnBqP
 xDlQ==
X-Gm-Message-State: AFuF++lOZTNiGc6fk6syPN2Xb6/WGEW/C1KQ02r5hDdh8MgQ1EsUjN9N
 bcx40vROdLu+IP5e5YZ/+Ob+HVFIyq1o70DS6o74atH+gsCHN7iEZyPE5+sPYMVlSAS3pLTwmOu
 DwXD9
X-Gm-Gg: AYBFou3t3qVk7bKZkLvBny6KAnBXsgjaRwsT9p9aqIoIoKuhVsT352EVL9w068cPTPZ
 P5cs0H/sx2mVWqOudq5Z6++AOja92Fb5GA8nr7lPs14FHG6vZ1o1MwuoTwG+7Xm1TAr6Brx0gpP
 GUBOMZx8r9WMkPod4V8PnqoitwjqkWLe+/khfAa5VGtplT+q3Ua1i2JpdI5T+ecqVhJ0q1lC9pM
 dJL5bsQEvX/QA6Odzvzh57lHR/wdw3Q2V2cY96Z7Q+qfpqJ25liMMBpIcO7hWHsTp4n4HGc6Sgb
 t0fZ+tFOOgH54Xzt1WO0QhtDgValKjVA5fdr86+HcluD61X2ohUBwt90FrLZBKmLZDdSFQ5pbX7
 1CnK/ZGi3HbXigKCKRvrSEpkibcLHyBaHOhytQ8afskV9KY25/69zR0LO7e6ZnCavLtbXOQKIAF
 m6MrWO1c8yIymsQQMi2z60bFzVH4SBU1kdIMWmUhAoQTQYsnjlKak01saEXqpjxkcESXGZeqBVf
 KSRcEh99U87Z5SMu5WJpemeuzA=
X-Received: by 2002:a17:902:f546:b0:2d3:7c58:b0e1 with SMTP id
 d9443c01a7336-2db1212aa5bmr124039035ad.0.1788549419280; 
 Fri, 04 Sep 2026 12:16:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:16:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/7] fix XXX_DEBUG warnings
Date: Fri,  4 Sep 2026 12:12:35 -0700
Message-ID: <20260904191652.2399074-1-stephen@networkplumber.org>
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

I recently modified my build test to automatically enable all
DEBUG flags. This is because developers often add debug code,
forget about it, and it bit rots.

This patch series fixes all the places where #ifdef XXX_DEBUG
code was present but would not build without warnings.

Stephen Hemminger (7):
  bus/fslmc: fix build of qbman debug code
  bus/fslmc: fix signed comparison in buffer acquire
  crypto/caam_jr: fix descriptor dump build
  crypto/ipsec_mb: fix missing header for debug build
  power/amd_uncore: fix debug log build
  net/rnp: fix register debug log format
  net/vmxnet3: remove unused queue dump functions

 drivers/bus/fslmc/qbman/qbman_debug.c   |  3 ++
 drivers/bus/fslmc/qbman/qbman_portal.c  |  4 +-
 drivers/crypto/caam_jr/caam_jr.c        |  2 +-
 drivers/crypto/caam_jr/caam_jr_desc.h   |  6 +--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c |  2 +
 drivers/net/rnp/base/rnp_osdep.h        |  4 +-
 drivers/net/vmxnet3/vmxnet3_rxtx.c      | 58 -------------------------
 drivers/power/amd_uncore/amd_uncore.c   |  2 +-
 8 files changed, 14 insertions(+), 67 deletions(-)

-- 
2.53.0

