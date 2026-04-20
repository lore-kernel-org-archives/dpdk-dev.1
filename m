Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4512F5A8A3
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 17:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24024402E5;
	Mon, 20 Apr 2026 19:20:38 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id E0466402A2
 for <dev@dpdk.org>; Mon, 20 Apr 2026 19:20:36 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-479e6bc357eso217021b6e.2
 for <dev@dpdk.org>; Mon, 20 Apr 2026 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776705636;
 x=1777310436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+B20nbhFL1kH0dwRrR8yw84MWolqixVfRTAAU/uanI=;
 b=umR+sIVMlVCFjIC2GU+ZS44BFdumKyCyspQe6GC0wttRZ3LH+whawAiTn28XYl38Al
 EGPW9zroZElTd9O7nJgq/7MCXTRpgbMttAerpOiL7gXePkCBRY3YJUpZgFbXF5EwvQGb
 EQeaV0VUIeEAFLw1CcbrQb9m7z6Ejr6qd4SSKKgoBbmWtE8Eon+zvkjwKrn4WEcIHh6T
 TcNpvC9Wmqtv3738zrv8Ov5ovfIhsHgON1967yEdYlP6WSgGW04ZPT46yIwquCiJUHLM
 SGyDCPgodSxAbkXT8m2qlJYBuBbg5p5W9oMBNKWxrnI6oaWD5J7ZN4og3CZNWaGUgDcM
 xcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776705636; x=1777310436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+B20nbhFL1kH0dwRrR8yw84MWolqixVfRTAAU/uanI=;
 b=iBj0wQDSDpYlzc34E1Ltaol9Ub9IvF204GHHyZqyAc5Z4F0qmWH6V3asjj3G/LsDWr
 b7ANXBzhGGxcm5kTBZBAFwHOahs4khdx2OuZY6s4cqpOnLBxJ+KZHF5qFwc/k3KmZkrr
 vvdExgk71Wo4fQ84HAGXXUdH8h05uoHER2Hl8ovLrB7qDO8Pqu/2037Slp3HmHzZCDby
 2LRipFtQkWkaaJIz0vtCeE45cWSRRJgXvz2wvut78+RR11YQeSFO3sZvyFNnupDANfKo
 iPFJAM3o25aNjHfboQ8wAor4Mhy9JMl7BJvUkwgvqX7PPKQdgWViYvSaT+iGOoyBPHha
 6Oxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p8rUUOHY2WGrN+4p1R5S5tPVi4VKB1mLF+Gjjq2mMxNNA/bbSUS1MvZgyoS0J00CCeF0=@dpdk.org
X-Gm-Message-State: AOJu0YxFZnXYa9Y7FEcT4vxiIPwi6XpitlB9bxFWrql7YsEWp0qyWF20
 0suBqYGqrkXivsfn0xr7+LaaGmGX52l29nRedmDke2boToxoc002ES9PCuBMe94FKeM=
X-Gm-Gg: AeBDietRYgONpTtOINIKQNYOCQBlkvZr9X0C+CrieJ2AA+U2l9bAA+6+TV+sSgHOIIu
 7hjT3ZioppY5otnoNjvj0ozt210lkuEk5adf5lmdohEaoIAdEFbKr3e6KOxBaQisYyHH5zJD/QQ
 utk1qzkSj5KBwdGWLhF1SWVQ56iJYD8syGgugadZGGi7pJBHjWAKcentyOwfnTiiJQf0aUtGv/O
 h+0EvBM0Gzfkx3/4r3p0MmfIBr4MoXjDXuByet7qltQdKZ3fDSmHo0K+xd2DfmtaE5AjZYbKyOL
 7L04lr4GPwrBLdfN3H+DQdGAeJ2WOUIv67L9UQ6B+b4zgO65JKDjEO761uSubVpHuHEF32fjZjI
 MJdOj0h7BAR3ar/2JYqn/kwPzhu3cz6itEdYlBQYkvATy8fkhyVYZPO1wC+7O89wAZjWbQvzlAX
 8qwp+rnDqaOTrP+aEH4mhEp76sgXUyYSF2RX5/j8XCJUE7bQ==
X-Received: by 2002:a05:6808:8816:b0:479:a90b:a011 with SMTP id
 5614622812f47-479a90ba0e6mr4153852b6e.41.1776705635770; 
 Mon, 20 Apr 2026 10:20:35 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-479a0169edfsm7099456b6e.9.2026.04.20.10.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 10:20:35 -0700 (PDT)
Date: Mon, 20 Apr 2026 10:20:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: reduce debug messages
Message-ID: <20260420102032.21ea1b54@phoenix.local>
In-Reply-To: <aeZcwGty0qvQUIbc@bricha3-mobl1.ger.corp.intel.com>
References: <20260414052603.201114-1-stephen@networkplumber.org>
 <DM3PPF7D18F34A1AA387BF494651F0DA4918E232@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aeZcwGty0qvQUIbc@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 20 Apr 2026 18:05:04 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Apr 16, 2026 at 09:13:35AM +0100, Loftus, Ciara wrote:
> > > Subject: [PATCH] net/i40e: reduce debug messages
> > > 
> > > The driver logs normal things like choice of AVX at NOTICE level.
> > > This shows up as unnecessary noise to regular users.
> > > 
> > > Bugzilla ID: 1936
> > > Fixes: 3f24891594c1 ("net/i40e: use common Rx path selection
> > > infrastructure")
> > > Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection
> > > infrastructure")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> > 
> > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> >   
> 
> As with the other patchset changing the log level of these messages, I'm
> not convinced they are bugs as-such. However, since we have a bugzilla I'm
> keeping the fixes-lines. Dropping the cc to stable, though, as we don't
> need this backported.
> 
> Applied to dpdk-next-net-intel,
> Thanks,
> /Bruce

I just want programs like dumpcap not to get spammed with noise.
Certainly not worth back porting.
