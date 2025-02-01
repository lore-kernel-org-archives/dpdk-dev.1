Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D2C0218A
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Feb 2025 10:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D08C402CF;
	Sat,  1 Feb 2025 11:03:11 +0100 (CET)
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com
 [209.85.167.100])
 by mails.dpdk.org (Postfix) with ESMTP id D6BF540264
 for <dev@dpdk.org>; Sat,  1 Feb 2025 11:03:09 +0100 (CET)
Received: by mail-lf1-f100.google.com with SMTP id
 2adb3069b0e04-53f22fd6887so2895550e87.2
 for <dev@dpdk.org>; Sat, 01 Feb 2025 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738404189; x=1739008989; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRVHwQ4bRZhW3TvoC8QedlqXVMIQC4895nEG2nEnMQc=;
 b=BC4lKOaAIpfUjSouultiALntj+xl2iXsUcmuGa7MOf0MmFXBmiKEugonW0sdI88suk
 mJVsWxoqwiAiRogWF05wLj1NO6KR22e4+cuE+I2sGRex90qG9FhTLsGVlf8z50S67Bor
 Sy5tdJReEZVdTLGb8JJWvtfEyElF3y5vUf37pnDpjdCjE9ITeMIVN5XnLqQfMRRS7jvm
 dfwCEDqQK2JGwrNMKI4I4sofZoEYjkjGbuYMycghAmcmL9HAmdMgS3Jefr9zzI15Dgk6
 KVPCbuFyVFtNxP4T8bfOiyAchZ+nL0OwOGlPxrodbmn4KkjbCZi/kujUqODnDPs/NiRa
 DJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738404189; x=1739008989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRVHwQ4bRZhW3TvoC8QedlqXVMIQC4895nEG2nEnMQc=;
 b=bujCSLPTpTsYF+DFG7WJXAFvP2kYn70zz7GzWptDGUtq44pahIVw580M7Y2Ye0s27c
 afgOMuz5zhQcHECfam+QkCAxOTXJhqqJtd3WihF4GdWEt4ntQTxO34Bk16kYVgAHCDlt
 JiEYYEV/qxr0ie2iXad2pNaLCU+Z0WJcJoeiDjHCzYFL8Ti67HI+AOfuCjxd0gYr6GJ9
 VNhgTws5dRoTFDbYdQHI9Aci2+90XxKAPHxK41wAjxP8m/edRSs/vkwGfP3JsRoqRWjA
 dKpJY2RnAfyZhRGgDRhsjYK387pzKjm6VIFxRZkueziF2fqIfvEMz3DxjTIDx5YcDi0/
 GAaw==
X-Gm-Message-State: AOJu0YwBwy/87R+lrtUg9cLO7tVtlcfiRmoDZgxWTgARVQeZ9Gv5YaVb
 Wy9LkBVxLdwsNyRiQYE1K/m8MaDkAIeVHK9FutYmuV0HVHoEHq5pAxWNq4+QqIPSmi7o+/JfE29
 VYTAiarr3iTiCcDmmI8L//HY1955TuOMLPveX3Nei
X-Gm-Gg: ASbGncsE0zudqT0kseMSYx6udHTY+VT6hvV0NDbxip+zxPl4s17AMWYST6/TDs6coKJ
 FOFvQ9gg/B7S9bW5Ooq56N2M/afar19vOlgDzUCb2Ltgu5A/pli7OPjNZ5kUiTjRp+84OqGvVhi
 v4mBcQPNBTqNd9AONGZukrYRtgmGdSUXJaDEj+RLmURTzH9C+Yq8pnoeoACwCrHjjyfZfbY2bIC
 pO4RpU8TmimymQ+Ccwt/HNGAG/uNzzzV4an4IpFIq5YT7PMbZtLTuWARcJ9jZxQ3VcE5vlcZchw
 juWa4DAaC1sbJdT6OW/gVgo0jUj0F8zgGsE7LzjdGvBQgChCfw==
X-Google-Smtp-Source: AGHT+IHqdp0yOzSt52uV0sXTUlfkyj1I8m2r+f1YOuTvtInDpsyidwBkCEfcMBqh9aYDGMxGETuKF3PuqRNp
X-Received: by 2002:a05:6512:102f:b0:53e:368c:ac4f with SMTP id
 2adb3069b0e04-543e4bdff58mr3752748e87.9.1738404188787; 
 Sat, 01 Feb 2025 02:03:08 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-543ebeb73besm199917e87.117.2025.02.01.02.03.08; 
 Sat, 01 Feb 2025 02:03:08 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 68AD61A105;
 Sat,  1 Feb 2025 11:03:08 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v7 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Sat,  1 Feb 2025 11:02:58 +0100
Message-Id: <20250201100300.2194018-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v7
* no change
* resent because CI didn't take patch-2 into the series

v6(https://inbox.dpdk.org/dev/20250131231018.2163893-1-ariel.otilibili@6wind.com/)
* added missing credits to Maryam Tahhan in v5 

v5 (https://inbox.dpdk.org/dev/20250131183439.909831-1-ariel.otilibili@6wind.com/)
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)

v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan

v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger

v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 64 ++++++++++++++++-------------
 2 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.30.2

