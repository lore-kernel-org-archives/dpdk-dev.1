Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D8C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D91740264;
	Sun, 30 Aug 2026 22:26:46 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 65B574025A
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:26:45 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2716658a91.0
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121604;
 x=1788726404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/nMfLEAThgHLgVX/DBYZ6uJqMG5V2EkxYMIgci7vwg0=;
 b=kYER3FhzIHLSpVsdnb+wnhLqNVOyEKxVorgCXSNsMUHQi1TpJHWVvrxsowflThknku
 meKOfTTNLFxH3YEd712ipM+/1ol6vaNga8VEvmEPSIUNgYbmCA1vqedNJTb4XSwDAb8q
 wIkX0o0ekik93WMfy1Y2z0zEkkvZ/wk9ntG3sEiR7V06AZg/me9rjGUgaqRnGekW8y8Y
 Y1epZB1TdfakPBBf6/GX0KDbSh94IyEcinHfTcDZLDi0BPeBLAHA9X31xm4g+sPtJMCN
 8RcFgc/SlMTynbBvi0cTi0hU+zlpJD2J4iLvmh7oKwI9TJRwttQQ+LIDo0E1fsSwlkTr
 S2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121604; x=1788726404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/nMfLEAThgHLgVX/DBYZ6uJqMG5V2EkxYMIgci7vwg0=;
 b=Itw5O+ZdW5Tu7OhmNawxEf3PzqsSrg1KbyM/e4bJVsXlm+1f1d8Mrd2Hdz6hAjN82E
 gE2VronycsMecJfctONlmCYqNvkbm1iOpoz5UuQQi+sFmP2rohIb2mFKdfe11q12aKpA
 lhcV6ldfBA4Gf6T33g21pQWuBZyxF3HoqRtk2ybHUDQGWzL6Af55ow97hlM9Tow2BSsi
 hBXpFqD8V+6nOQSMO/oh9+i6rvZJabrc1qZ98aYI/y/l61EN1TSmPuxonFlyp0dW+FpO
 3Nh78z7hopX70gcR71n37F9m28TkbFbOW3BFMMEvhJiTLnWI6PqY2fRpz/Xy/P2UdD1j
 jYnQ==
X-Gm-Message-State: AFuF++nnlJThrtCjJQLuS6kTessJjdlBR+J6R1afpSyxYV+IrWiFgP3T
 XReIEhXQXm6nmyHbTJkdjXG4z0/cuqquOacQyTJc5VcYa6+gKik49FnmLDDXR2z5H89UHSXjCvX
 AeVUm
X-Gm-Gg: AYBFou3HY7MpcRimjmM3WGlMAwYeoyzUS9wJZdvodqdsAmB6UTZsYWiM1ityJq8zbJa
 nQ3slrZYEWjIvnoPNznmMOr1ev+CsCW5AYMxyHpflXb8ibqmJ9SgfdtqzC5eQ5epQTKtL00oVO2
 q7Zxi3Gwxjq/5q2U5CUtlrq3PNaC6+T2O96MI78w6jT1ud8el+QZALDJXPloEtuYk3AGye5G8MA
 lmytK+9Hj8YkTZaO87g1tvPQI2XzEdQNF5G1Rec8hXbKTkCL3WE/HC6arHzNvZ8jB1Kn7NUiI8d
 7ogpViBHEJ8CBuUMy8TCkHjEEfob4TPyfEXCnKL/4wTTUL3wbsJ9vQe2iJ+E7SeutigLepMd+SY
 EqgffzVwe0ihEJ2HIy4rtVXZdj9I+hsniIkliMSpccxIVvj5RAB+YrwA4gn86IcpngH8FYsGOS8
 DjjX04XRUTFlWf6ETHqIimv8RWbp9Bf/VIyAMo8oNRGD3JnAUGu9lK07roa+py8L579qlnMiAr2
 NiZaxu4Irnypx5t5oRdyRNE/p4=
X-Received: by 2002:a17:90b:48cf:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-398da6f3e41mr3152499a91.10.1788121604058; 
 Sun, 30 Aug 2026 13:26:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:26:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/8] net/bonding: fixes and per-member statistics
Date: Sun, 30 Aug 2026 13:23:42 -0700
Message-ID: <20260830202636.760014-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708174204.72574-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
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

The recent RFC's to bonding prompted me to (with AI assistance) to
look at current state of bonding PMD. Several issues were found.

This incorporates the RFC patch series and modifies it to 
have Fixes and more checks.

Added proper extended statistics which allows looking how
members are doing.

Weijun Pan reported the stats double counting and the secondary
process crash (Bugzilla 1900).

Stephen Hemminger (7):
  net/bonding: fix TLB member ordering with unusable member
  net/bonding: skip unavailable members in device info
  net/bonding: use atomic link status accessors
  net/bonding: restrict control operations in secondary process
  net/bonding: add extended statistics
  test/bonding: add extended statistics test
  doc: add bonding features matrix

Weijun Pan (1):
  net/bonding: skip unavailable member stats

 app/test/test_link_bonding.c              | 148 ++++++++++
 doc/guides/nics/features/bonding.ini      |  28 ++
 doc/guides/rel_notes/release_26_11.rst    |   6 +
 drivers/net/bonding/rte_eth_bond_8023ad.c |  18 ++
 drivers/net/bonding/rte_eth_bond_api.c    |  24 ++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 338 +++++++++++++++++-----
 6 files changed, 483 insertions(+), 79 deletions(-)
 create mode 100644 doc/guides/nics/features/bonding.ini

-- 
2.53.0

