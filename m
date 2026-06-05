Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0288CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D05D540298;
	Sat,  6 Jun 2026 00:45:20 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 1D52840278
 for <dev@dpdk.org>; Sat,  6 Jun 2026 00:45:18 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137eb0d76beso1978104c88.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780699518;
 x=1781304318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S1MqPwwIM/N0f2n5sb3eNnyk3yx1Hv+O3gY99qaONbY=;
 b=sDtv7omz61eO18yUQWqkU9TqohVrLoLCAMdS0jgIVTJLz0arLESBf6sJ7H8hrTAJ4O
 poY1k2OrT1rg+AF90JxaJKm9GUknLFs72ASjVoxP2O6VjV6hjrL0oxMPXVfyCn16HcPO
 FH4C7CwOunIGnHAaxstXHxr/L1x5zWKJNC+AD6+MqB764JDASqpAKFMZjY3QuHCjlCQu
 CdJ8k+4ufGVdkUR5GUU0lrTQdN221F3GDJv5/CBdIXtmkbsYaYEDEsNd6LdY1UZOhvmW
 QSh20NSg0a2ZUrzy7u9rvn31b9E5QEMXC7RcWvPQkPZnlj5DBUS+lyXjhGN9GzLsCopB
 cLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780699518; x=1781304318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1MqPwwIM/N0f2n5sb3eNnyk3yx1Hv+O3gY99qaONbY=;
 b=UZnl75zd14Qp40CAjHhIJiK7zWf4HbMwcEQlY28JrYO6eCEuA/lolctTVH0aPmXzyg
 69/xMZT/+5vnsMJQmHzjHf7A8ezD+M2ym8OTBi2NwQgBf4A6IRrAfxHKCXTX/CdJCvMQ
 Z7Ct40w1CBHJwMrYqGe8ncfzmin+LpHu6JwwRdiNxtz2n+sTl6qvJcth69oQZCKwl+Ia
 iWxHjlz5aAdmlKcaOErLw3AR5L0KDQ3nM2YJ1Zahqp8bI15Dr6P/piGsVwAvTpUkXe3B
 FFX3pQ6TMjIxebjwCBnHWMF0slhP87Nihq62jt1sgA9GdlEzOMJ8ilktKfQxRYBrz8jm
 OUQA==
X-Gm-Message-State: AOJu0Yzxc4PupP7QHZEigCbtSBvaus4saV44k9rUq3Cl2g1T2SiuTSlz
 9ceOu9rhrTIvSO7/3btSU3n+UMcUg311Jn6eah40nrqT9DHWlU5umNQ/NrbZvXUdziJ07x4Dp6u
 2jW89
X-Gm-Gg: Acq92OHGsnQIyoLwtx+ODLQEv5xaktfJ0CREwh0Ra5aBYJOl+wEgctoEFht09qQpzD8
 mW7sWvdbWL9dvNwismz1FbV6C1qJ6f+rCGILRASMggU6NhUyXGJrfQXYto/0COtWHGiH8JsN904
 pqb0JThvwnspD8uP2YIeOEWznNR4kiLRBXx1LTvg5V5pqnkckMBd/1lhd/HmjyGoKGDv34V4/qA
 vxUysYHLqbSjOS1GChCXQ5VAKR9BeoUBiZEKEClR75tket8NEEll3cU5j/P0i0HkIl+FirjCimS
 XFXA6xC4JZgdNEWzCO0gAYfc9RBBVHZJODw8xGmle/CTemJS9KtBvGrQneOALeuVAQ21K6obPvv
 ZsTFW87oq5GliLUvsY8QahaTjH31huecofA1o+hgW0lRyDclmsoW7t7XdAhH58VJTQ/ceSNIpju
 nz1d7LeS7Rx7AfVOOgRjvc1vQWvNnc89b90sHK0HqmY8IeZg7A9k0kLgpPmpgP31SRq4cK/uMG
X-Received: by 2002:a05:7022:3d03:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-13807d94f3bmr2004269c88.19.1780699517431; 
 Fri, 05 Jun 2026 15:45:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm9681306eec.29.2026.06.05.15.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:45:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] net/cnxk: harden telemetry parameter parsing
Date: Fri,  5 Jun 2026 15:44:38 -0700
Message-ID: <20260605224514.651081-1-stephen@networkplumber.org>
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

The cnxk telemetry handlers parse their command parameters with strtok(),
which keeps non-reentrant internal state and races when telemetry callbacks
run on per-connection threads. Both handlers also trust the parsed integers
more than they should: values are narrowed to the destination width or
aliased to a valid index before any range check, so an out-of-range port or
queue id can slip through and read past the backing array.

These two patches replace the strtok() walks with strtoul()/endptr parsing,
range-check each value before it is used, and drop the strdup()/free() that
the old SA-info path needed. The NIX handler additionally copies the full
parameter string rather than capping it at PCI_PRI_STR_SIZE + 1, which had
been truncating the queue id for longer device addresses.

Stephen Hemminger (2):
  net/cnxk: fix telemetry SA info parameter parsing
  common/cnxk: fix thread-unsafe NIX telemetry parsing

 drivers/common/cnxk/cnxk_telemetry_nix.c     | 80 ++++++++------------
 drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c | 50 ++++++------
 2 files changed, 54 insertions(+), 76 deletions(-)

-- 
2.53.0

