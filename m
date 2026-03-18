Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9210310854D0
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 03:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8AB8402A0;
	Wed, 18 Mar 2026 04:16:22 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id C05184026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 04:16:21 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso25958145ad.3
 for <dev@dpdk.org>; Tue, 17 Mar 2026 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773803781;
 x=1774408581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsoTZT1HJW3kgkftjTkTqNLtbUmoW1HnyiGUp3/ogBg=;
 b=PCX+bLUFmCyi4z3sQ4HXOoGbhU5a/ILfc3RkXNE66h0sVij2yTOTBHYCLDZgPOX7ii
 2zYsfuSr++CtSis3XLgrpzB4tyhsHsg6aEVVjSL+QHlFYJLb1mBFHgIsxsI01eBNjgwl
 01UTDle4HGcK4kYvCUKHILovSih8DGzZckMzfJp+i1UoKHWEz1B5xG01RY5ddO5dT2CG
 3VAnetkPkcxgeoj07ImlrxbZsJDXT9pt8HUQe5bShM06JABUsBCvN4yXHm11z+256neV
 NYvnI/VAaNLWXZizmVheIbaa0eNPm73qG+8im0xZ85WSqwHskRReXjNU+hC7Ymnkmm6j
 H2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773803781; x=1774408581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SsoTZT1HJW3kgkftjTkTqNLtbUmoW1HnyiGUp3/ogBg=;
 b=WEa5027pTPVSqs6D1qdYHUeIjuzWy4Bsy7jgxQSESgnR7d4RMpEhQ+bbdYE8fkMYVS
 +IU7+ezeKuoMOW2e46+9DfWmAw9OAARND6tW1EUcYLRLUIN7e8M0hJDwFXh1SRILlR1v
 nmgXwcWkjnU/xZuDij+OQIm1qtI/cU4hp7eiPOF0vIPcNADTJdp7K4Gt3gO/oAs95WpF
 7ITl8JGJACmFSy+G55W1gpXvOF+rGmTHR89UBE4fUQ4SRmd173YAPV1SXOuTt1LOm4WD
 lhM9dF/jRHR+aTk7SiSHvmdnKAWreyhAxprpG8S4MVlLqNfq32K/ZyPF33xerc7sqeow
 46zA==
X-Gm-Message-State: AOJu0YwmHjTmW722/gSr6DR+3zFI10gmOHVFwDqDdWPf3ebEqDgYu/sU
 aze0Nz56yf0UpoJABPplFcporud+5u2CxJk9QCK6WjEpH7ig+7jMcfAi4va2fEGACAQ=
X-Gm-Gg: ATEYQzzx7Qtt9Dh6U8NxobFCauLZ0Kmh9YX9GDutKSnGgZeslrsaF/oYZmMx/Qb9PTB
 p8AAOGIZGzSsUMPpRWpb9xvh8yyrKR59D13V8QdcoOO1eSbtdCHmxNny/DNgEP+gW5syWZVuWK2
 a7y+fBQq+CORouvw8AUg0gsVBm+xIJJ62jfbGtWH6L9AARg0p0hVKK3LXYdV3wPSSUgAwO1Q4Jm
 PAJHumuIXwdSDKGtMgmsJTi32xHz0eEwAmhdZhUN4/9lqkWR+xOAsHu8jLOG+g11hSqsfbSpgiw
 EjZSMVgYLXn9sYpXQx0s17t6T+nemlNqhelbWpNO2UYYRu+a6LBYPgYKYI9n6E2Ag5CATWehRw+
 Ad9uiQMEBlKk7ohopmki6ObePuAmUGwVqO8q8jAxAwX1xqwouCo7z9Eq31qU6veRSjf2Cy6MNE5
 Ba/j/+oiMbsl0SxtWSPO92i8IH4SMNHIeOAU8Rgqew7ORVOuhuUB390uMtCS2ODbTcUHDJDXC4X
 qanaUfB6Vi+alUB+KYF6g==
X-Received: by 2002:a17:903:2f87:b0:2b0:4b3a:9b4d with SMTP id
 d9443c01a7336-2b06e32c06cmr17185455ad.20.1773803780739; 
 Tue, 17 Mar 2026 20:16:20 -0700 (PDT)
Received: from stephen-xps.local
 (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e431735sm11581815ad.22.2026.03.17.20.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 20:16:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 20:16:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit
 Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH 2/2] net/bnxt: fix shadow variable warnings
Message-ID: <20260317201617.28d6ec23@stephen-xps.local>
In-Reply-To: <15698507.tv2OnDr8pf@thomas>
References: <20260312002123.867357-1-stephen@networkplumber.org>
 <20260312002123.867357-3-stephen@networkplumber.org>
 <15698507.tv2OnDr8pf@thomas>
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

On Tue, 17 Mar 2026 09:02:45 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 12/03/2026 01:20, Stephen Hemminger:
> > Fix things flagged as warnings about shadowed variables.
> > If the variable was harmless overlap then just drop the shadowed
> > version. For min values case use RTE_MIN3() and RTE_MIN4().
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/net/bnxt/bnxt.h        | 6 +++---
> >  drivers/net/bnxt/bnxt_ethdev.c | 3 +--
> >  drivers/net/bnxt/bnxt_rxq.c    | 6 ++----
> >  drivers/net/bnxt/bnxt_txr.c    | 3 ---
> >  4 files changed, 6 insertions(+), 12 deletions(-)  
> 
> Why not removing cflags += no_shadow_cflag ?
> 
> 

Yes, should do that, just wasn't on the tree I was testing.
