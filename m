Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54887C43327
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 430E94026C;
	Thu,  2 Jul 2026 18:30:11 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 76B1E40265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:30:09 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-37df416c44bso1603025a91.2
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783009808;
 x=1783614608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osU8isFgS3MCeE2DC69CWaAzFi1oZLlSsY9Kzg4hj08=;
 b=m7Jaq2SfH91KExxsDJucYdBC+zmOw2mrFjtBHh1neZyZAv6OFFtVcWg+RTN5/m1Fi1
 y3TEx+GTybh8cwV5jHrE+ZfneFvBbhsRdPYw/OPKxe4d8ZaypfY3m0R7n2rsv8Hwsmmy
 9//vqxr2TTTfzBg2cP1q2iWIJpDli/h3owyazjQ0qUpWpohahZV2OShnGxyUIOMyN9Cq
 szx4Z4hAVGgfBpcvkcBv7jrmf4RZvHBRJGGRhLjZmQKnnA+wDWNF3xLHVn+ZTDI18pnj
 mkTLgW+/YbeHVWLilfCXDkG884pw34HADupAUcPWSiZ48uYUeG6LfbjIpLsr0ypNpuL9
 Ec+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783009808; x=1783614608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=osU8isFgS3MCeE2DC69CWaAzFi1oZLlSsY9Kzg4hj08=;
 b=iA244e9GN40MKaY8mKNXRRqtajZ9gLXdi+k92rBD/AaWYplKVePN9Q+qR9lCUlS4RS
 I4Kld+pdGArr6WHWLURfZYhseUGWh4vnjaIyUGfxDENTHsSYnj+9FnOMrT2pkjGmTsce
 UvNWMY9eRgTWFJFhqFUbbI4lLcdEdaLLA3vzU4mdjoscTA5YDSERKSV/ts2DzZb1X09N
 dQ63M7NohTY5tw/frINFcsZ2AD0Z+G1jAb4SXGOgwdu891iMZJZvlD+bz1Vf1MCL2ymT
 AKctPgLCZVks9QVrvflJNUfHqd9xBTpXEjlwbD31OLIKqLMwRiJjlGikFA+kCEvcqimK
 fUhA==
X-Gm-Message-State: AOJu0YxK/vGAQ26k3PhJDEE0lA5/Q33HxL7+YdPiESHaq1TBX+K7setL
 UI9zAUtj+LhsHqKcy+X8XDIfGC90prm7l3jTBUDAy9ILlWslZzi5FlNrfpZB7OSLFoQ=
X-Gm-Gg: AfdE7cmuRuWZtX777ueCNQ6/5+7CV1ouSwfsaaJzClsfzQTzAYnBKjon8mbxAWl7h2J
 wMpd5Rgke29ncSeIbIDvtTMzPgD5yAtgauFfPciN93BQuhOcOsdDr8O4DNXBPnn1Rc3/03yBJiM
 p7Oro1B0kUUZzCy9YruR1tLe144W1UX5HV4sqaOVE7zo/vgJ2ttL8dIeZ5d3f7HUMqwbtqyf/LG
 sO454f0UvYuF4YETxjb1io57mLoF7hNbftsnHaQIoCNqRcumG+BSfx0r0GMSOihVFruZDuh5pNW
 85Mp8TOWYxMTJPOj4fOj5qqDQeR0lzRwQ+FNEPxKPXkDS7if/fLw9BhY6LK7pmraExnEvFKwpAo
 q86NVznYVsoOUh1RMROuYrwEEvt+tyNwG392jJCHu8sx9QTX4VFb30NclkMiVYR6G2bkYtdWCK0
 JA0uPP5Z6xFrJxm56UI6Vpt+q4BAt6wmp6CVdNPsosTBFMJUiAC+hHRyIQGNkxVSsi
X-Received: by 2002:a17:90b:5547:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-380ba8d00eamr5671868a91.12.1783009808244; 
 Thu, 02 Jul 2026 09:30:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm11415574eec.22.2026.07.02.09.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:30:07 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:30:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 2/2] bpf: silence noisy message
Message-ID: <20260702093004.15841f2b@phoenix.local>
In-Reply-To: <75fa182ed2b64f88bdb0c6c8a729aaea@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
 <20260701223453.104660-2-stephen@networkplumber.org>
 <75fa182ed2b64f88bdb0c6c8a729aaea@huawei.com>
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

On Thu, 2 Jul 2026 08:36:14 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> The commit message and Fixes tag are not 100% accurate, this message existed before:
> https://github.com/DPDK/dpdk/blob/09e4f37ddd0f7d5cc7c696741f31f1582c73a716/lib/bpf/bpf_load_elf.c#L331-L333
> 
> (In fact I tried to eliminate it, but had to but back at the insistence of AI reviewer
> and even broke the build in the process...)
> 
> So naturally I support downgrading this message. With the commit message corrected,
> 
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

Looks like you added that message in:
  55192fe168b9 ("bpf: introduce extensible load API")
