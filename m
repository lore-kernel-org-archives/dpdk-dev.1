Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A3CC982C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE19B4028B;
	Wed, 16 Sep 2026 17:18:02 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 3CD1340264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 17:18:01 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so549444a12.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789571880;
 x=1790176680; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fKYqb4xdVZfONW+aOH5vaZkCTreb5ntSV5wULJdyAik=;
 b=WeWY7s7rIn9jDNnblSc2/suPHnmv1BEaJmiqrhfM0FgggQpdAd9ouT+B70044Lw06R
 gyNe7qlk341BGbQRKNsmGSUZ7b32yFEE6pCWO1W99IrYkLNsHO4I8PaVDhDxh7FQxGim
 Hlk32Vea3zzcBE7bA6PZgsd6C2Gy+dL2wG4dcF2Z2RpJADzmL9nWBAT5U9SnuEg9xmug
 TnchiWRJt9YTSDs0VjL11NOjADbO/rUs+LOqk8dH9tPD7e/rKHNsxmtQJn5vavivt10K
 8IU6BXCEkm7E8ZqLudr6fazijKA0cF2pwiT2rxjXeUiMxByeqHr5cI/fOz/4ecnhxme+
 KRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571880; x=1790176680;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fKYqb4xdVZfONW+aOH5vaZkCTreb5ntSV5wULJdyAik=;
 b=nrqc4oSTwqi4n6d3B4sUYMFsf5WYANQf7bfOdtS6Yhm/i/W72W142T3hgSwvuzzlHU
 PwNsM6iz6+wTd647tY30PBFswfHcXPOFIJGVzsppcF93wRqzfkoJ0xtPUv0j+tCQ6X7g
 kQ4G+4/v6vwE7a911FQcWdhXWM/XurE7tHjunU7xD2ri7sft3RH1334ni/vChCN77e2g
 kCVWFkUvwkJYKLy+kPaJoHGI8TevtY81GDADdHGgm26w+4x433TZhfmhEQhoqiWPeDLq
 7XWcLGYFwFxeYuw7SgUjv8kYwkoktCHERShQPD2aLokFbWonUXy0KNVPNYsufyzsmDWo
 R8Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3ir6xZnFSH1fSu0aKmKtivfm+yw85uKKua+htRzpDWUcbFk0+01T2lUndWFr14ZZeXYI=@dpdk.org
X-Gm-Message-State: AFuF++n1YgYIRQseafxdp0OMq5DWZE6u6q2MMWMQ1tbbjJhkwsGPBopC
 pI5aCV0ncwGyAMw0pJEEiFfeos1U5I1pGPLjh+L7oqNogze4lv3rUM7Rrf1riaOtC/g=
X-Gm-Gg: AYBFou32DfzctWflGMTJ+0uEBvYFz7h09pHFkNGHclZoDzm1gRu+CrPoBF74FPHsnbD
 1sqMf9NqO4jAiXMovkIDltvzTcmPrV13a2aKPHccFHt7fJqlBmPSUd9y9Ydw4TbAiv5c5BrVw0K
 CDlYlPjA9giT+OuKnKOFjYzIAwghuRkWVDg7qHxO1MTqWUKiZHwONih7n/JeJm/yZs62E/SfaqM
 mIlC0ko3vespIwIqT0fsMuLpebsd2WVySJpFelm4Yv9h9ZoHx4RftuiVL5oEF3rpLzIcISfo87Z
 X9XyShIqwpHp8t+s1xRsNYkDfxY36gq42a09FInQoj/+iEFQIzGUuPS+nQNqXh1DtUE1z36xBMN
 cZGOmtFezBcZkeEfTn5qC1TslcVhQVSnNtgCYw5mdO8C6OUl0qK/jNbJPbYqPrpTnYhMeBYo75R
 OLLXGSnZhSlXXyBfN44l66PVFnkg0uaDWm0V0SzmkLIwzXEt4Y94kLhG1BAXKmLWI1wLuMBp4/M
 GFS9iWyx2NZGRvFqd9sTuUbMsF7qZuuctk62OvR
X-Received: by 2002:a17:90b:2803:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-39e1e324463mr8111477a91.10.1789571880176; 
 Wed, 16 Sep 2026 08:18:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1c337e97sm1670288a91.2.2026.09.16.08.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:17:59 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:17:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rita Ruvinsky <rita.ruvinsky@weka.io>
Cc: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "longli@microsoft.com" <longli@microsoft.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue
 free-space unit mismatch
Message-ID: <20260916081751.1a188255@phoenix.local>
In-Reply-To: <CAJEiD5gTKwKf0pZuAB4hRUwa0JbkTtD-rQeeuKjkZeEyoJfr8g@mail.gmail.com>
References: <20260914105809.919580-1-rita.ruvinsky@weka.io>
 <20260914091419.22e3ef6e@phoenix.local>
 <SI3P153MB18385AC2FAA3AFA6DE465B5DBBBB2@SI3P153MB1838.APCP153.PROD.OUTLOOK.COM>
 <CAJEiD5gTKwKf0pZuAB4hRUwa0JbkTtD-rQeeuKjkZeEyoJfr8g@mail.gmail.com>
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

On Wed, 16 Sep 2026 14:12:12 +0300
Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:

> Hi Stephen,
> I am happy to send these as a follow-up if you've already committed v1 or
> create a v2 patch.
> 
> Thanks,
> Rita

It is in next-net branch now. But if you send V2 I can swap to new version.
