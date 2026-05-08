Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCDBCD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 17:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB384025E;
	Fri,  8 May 2026 19:59:26 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 3F67C40150
 for <dev@dpdk.org>; Fri,  8 May 2026 19:59:25 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12dca45ca21so3461633c88.1
 for <dev@dpdk.org>; Fri, 08 May 2026 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778263164;
 x=1778867964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkvQOsTr0qvm5mysT7f8iuHgJuYqe7gkWB5E40c1EHU=;
 b=RINt93YHSFzOP5dxlCYZmEdltJ0RkW3Vqex1+U8D51IWiHQ+qPxmyUCboeU6QLHf0v
 fOOBtNPrPWv4RoNZft6Uml2s0w6RB0DJpEAbWdZ9FwticOMz4av5ewvT9jXTEsgfrgvc
 cXljm3eDVGD2UNuYhKu2q8JCZ4VvVEdBhlLT2zN8ndXRsHqIZ9ZuyTukI/uAZeQVfe9+
 j/4vZe8gCyn9eSf2hDer1n/5r2Xz8wJ6vNObj9ikd3yD5KbNKtupHg9nOz1Ya7y9sRZh
 OQdHjCv/3aaUqcxMA/y8ncskWQOurlIW8ngdlStOb01XeyaK+NI4TGDCmE0kNZH1brLv
 G03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263164; x=1778867964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkvQOsTr0qvm5mysT7f8iuHgJuYqe7gkWB5E40c1EHU=;
 b=AWzKN2jBSqF1RCHiVnpAx+8l2Xw4wpVLxdL22k41WcU0UlXFO3nmh5hM6fnUGNrII8
 vuXb616PBQgHsyygVa5XcV7/SQYjMjnaO467DZtXE+uC2PVJyB8VkxzENgV9/rO0h9TR
 LlP5RvDKj75ZRmqCKciw1C9I7wVnrMnEHHRUHvDHDMb17723xgAEnXVIUi+gmivoY4Bm
 zJHvQLxDgC1Nr7Jdmj2NlcCJyF9xFWCmCSQhMnasbCRa4c1ZuGM8aXR0L0NTEvpGfN4n
 d2fcIM86uATnvKouzFs25L9m+SD5lArkWvKyUQVItNqTuKQFzzIHisiRJoHp7AahlrFq
 EDEA==
X-Gm-Message-State: AOJu0YxaM1Msw4/KoWDGeGhXlvad5g3AsJJFqLCs+e2nha/horQONkoE
 Q8xL5LIEozfEc6pfazmcgNxTZ1mMK9OLmg0Ixuk3yOUUNA4M99zRZlNaZV+SkFFTN6tVYUab7x/
 t+2Tv
X-Gm-Gg: AeBDievccsmSMvPjsFrOetbEm/Hs2yWd1t6fGVtfaHmc8VEZ42QlixTLQMgHLLdBsRw
 wSJ+B6u0Iry8BRQOdjnUJW5Dw5T1tzwmwdgw88diVn9OvoN65L7PBhaZGhGyipSJQdqJDBEgZ6s
 /gR+puQYPCpUd2nxw9sNLwSK7PVuibcnsE7A3XEZ+GF6G2TcGKfhgPLM2tTX7Kr85fgvFPaFiop
 QPOy7yankdk05BH+khC4aMiQt4UoFxgMbugltzJx88krVUrgsWkxl4Bj16xmB5NI8XbwNq3RRON
 RpFy7/MQBYF+lvDIQrlKdjPJxsIAknn8AMZnmc5YvHx1zFPKMjgtzqIQ3546KYbaWTAxj8Jf5AB
 OqH+CBt7MbUgEMYt6rfqGtK6b9cSm91VOqyDg7Q3uP2CotG33109H941+ypfG58ieSJvm18ztsF
 q+DpW7ShMsW2fBUekbhdryHFRMSITsMn0lKp55gEaixg6nTQ==
X-Received: by 2002:a05:7022:4384:b0:130:ab68:2b5e with SMTP id
 a92af1059eb24-131852d904fmr6139378c88.4.1778263163958; 
 Fri, 08 May 2026 10:59:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm4018468c88.15.2026.05.08.10.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:59:23 -0700 (PDT)
Date: Fri, 8 May 2026 10:59:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: Re: [PATCH 0/3] net/bond: fix secondary process crash and related
 cleanup
Message-ID: <20260508105919.5cae9edc@phoenix.local>
In-Reply-To: <20260417165530.653328-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 17 Apr 2026 09:51:34 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Patch 1 fixes the 8023ad dedicated-queue APIs which ignored the return
> of bond_ethdev_mode_set() and left the enabled flag inconsistent on
> failure. Ordered first so the secondary guard added next does not
> leave shared state corrupted.
> 
> Patch 2 fixes the secondary process crash: a bonding port attached in
> a secondary crashes on the first Rx or Tx burst because the probe
> path never installs burst functions. Blackhole stubs are installed
> and mode changes from secondary are rejected. Fully sharing bonding
> state across processes is out of scope.
> 
> Patch 3 drops redundant %s/func from log call sites now that
> RTE_BOND_LOG supplies the prefix.
> 
> Stephen Hemminger (3):
>   net/bonding: restore dedicated queue state on mode set error
>   net/bonding: prevent crash on Rx/Tx from secondary process
>   net/bonding: remove redundant function names from log
> 
>  drivers/net/bonding/rte_eth_bond_8023ad.c | 19 ++++---
>  drivers/net/bonding/rte_eth_bond_api.c    |  4 +-
>  drivers/net/bonding/rte_eth_bond_pmd.c    | 66 ++++++++++++++++++-----
>  3 files changed, 66 insertions(+), 23 deletions(-)
> 

Would like review of this before adding to next-net
