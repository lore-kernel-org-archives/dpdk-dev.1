Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1589810F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CF1440A7A;
	Wed,  1 Apr 2026 18:41:14 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 9ADC1402E2
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:41:12 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c7d8bbad06so3303585eec.1
 for <dev@dpdk.org>; Wed, 01 Apr 2026 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775061671;
 x=1775666471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qR3g2PRFBp9qmdQNgft9u18YKv3/NKrdLH+rI7Qsbrg=;
 b=H5lZ0r90LwEqO2oZyLEZfMqnXcJDmOV/KHXMKLS8MKPFeO9HTgE6VWYjVYY6LLLL55
 Kb+UxfXDWEVvw/GRBBaau7KF2YBWq/FMquJ5/qHdVOjwW6psmAmyYa/TJTQjWvW2Wl8z
 LfdUndY9NiZWOKrT5frOCwFbCXs4DNcJOaFle3hl+F9O6he2bCBD1lQeG1qdwwQ9M97Z
 Sj2EbpcxMUAn/gk9a0piS7AkZUA2RsleTJbbJp+s3t1dQq/mZkbLw+BTNiDcoOiN8Pcs
 dtH1fpoXeSODryxW4J6qrDWQ8YW5FHRJJ7lwZqM5xGSH+RBKXo+mi9wSbdb/acFFBNX2
 0q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061671; x=1775666471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qR3g2PRFBp9qmdQNgft9u18YKv3/NKrdLH+rI7Qsbrg=;
 b=NkvL12+sOsZggRwyaNqo7ZRUVJkVnMDinu09yQurXtn4XcE+6IlN/ygTEm9Rv2WL1N
 KqWiS/rVTJ3nQ7JcipNgLMCi54PpA1ojBlZScuAqEJfmdOMeSTtKJIA2JIHsq3SsRBAa
 wwFPFYSCRTpFkNCvULx1BPh3+YwGn+lbcJTlhoRBqzc6LLRz2Noa+gVFyuxQQySxrBa1
 +XRBIeoNdIM3HEKomHNgTFTlUU/LdslhjAQ3kbXaz7pXEiupfj5pMBiw2pdT4hrWJ9um
 ZJ5GvDOfJkNwRCUEod6AH3hXkdeyD6PC/rtshJMys584ShvWYwH9TjD5Xq+bkmPitteS
 Oxyw==
X-Gm-Message-State: AOJu0YxU1rc00TAUtn8o6BKS9OSlhJMWVxdjCwri7gdCHokVxg/Z0t7s
 75U07W3DJuzPMaawgw033g7EvRszwd6ReRM5gYrZOoCII5GjLTLVivpqkw7Tg+9Jr2ymNKI/JuO
 4lH7K
X-Gm-Gg: ATEYQzz7C+oPt6fTWnu6l/NuMQhRolbZUDgiul9DpgCeZ/uyLYYBno9bsOB90xdIJB9
 xlV+p6tGLAdEmkTn7PBtW3TGdu9VMFFNBndO39spCQrT0/Yvds2Zbnv14l0Ig/g3FcLOCk3wXcf
 Ive/t+srvja1vqj7m2jfWFzL440zTSdUqcNjpWY07aOT5XHEzyEHsARbI/z1fhwVCnT/GqWuz6S
 kWVCBEl5vyL8tGuK80aFxsTxqFYokqEypDvnPWkZbn6xgODxWJ3eylw79q7fsAo6+1fpILyiEdx
 hfKyg/6OadKFTlSdd9K+f7NKOrNAvFJyYG3RYlu7anbuyjpVzE4iKiZ58iI9GzS5g6kXF+Rp4GL
 Xyno2QCUKioNC0rtwVpUx2Of7SeU0Ol/rrW5KmiLwx5p2RweUQYNwbNyicH4KtR4Gq8V8ZLRZFq
 ssZ9PYCoc5ZJoee5hG17JEPb7KtLKepc0pLjioGIW1vSc=
X-Received: by 2002:a05:7300:3708:b0:2b0:571a:28a5 with SMTP id
 5a478bee46e88-2c9323b7c6cmr2492402eec.18.1775061671271; 
 Wed, 01 Apr 2026 09:41:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c0c2sm202583eec.17.2026.04.01.09.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 09:41:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] remove useless null checks before free
Date: Wed,  1 Apr 2026 09:40:21 -0700
Message-ID: <20260401164108.201404-1-stephen@networkplumber.org>
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

Some small cleanups found by coccinelle null free script

Stephen Hemminger (4):
  net/ice: remove unnecessary null check
  net/bnxt: remove unnecessary null check
  net/zxdh: remove unnecessary null check
  app/test_compress: remove unnecessary null check

 app/test-compress-perf/main.c         | 6 ++----
 drivers/net/bnxt/tf_core/v3/tfo.c     | 6 ++----
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c  | 6 ++----
 drivers/net/intel/ice/ice_dcf_sched.c | 6 ++----
 drivers/net/zxdh/zxdh_np.c            | 3 +--
 5 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.53.0

