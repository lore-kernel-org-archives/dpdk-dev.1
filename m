Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE737C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEE2440274;
	Thu, 10 Sep 2026 17:53:46 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 43B0C4025F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 17:53:45 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1312623a91.1
 for <dev@dpdk.org>; Thu, 10 Sep 2026 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789055624;
 x=1789660424; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JUpsdGvqseB1AHyz0tW4KfPnNJ7ouSgW4ym01OBM0jI=;
 b=tNtuwEeLT5AvQ5uBK593J8HnXQ/iyGnl35cn0xIpwAK3gF9Ghl/vCxvxkUDQPPJXZG
 dew7zqhBMGiH073PTny64zz5xcdpHkmUAfUdefiLGiXP/xyU5RHkHo4bgz/1G1x6h+iW
 VtH7h2TZkLoI51orEjf8efD+uO7wGCDCaIno0HtTXrmqcJrTWgATN+az4jQD1MO6j/Lk
 ZDujmtsJQlldsWWEGAwWXx8dcIhJujAtx2eecHQ6rOx1JNMZlTS/MoTN4rFb97rgD1O7
 e56Q7cBHKtlA3RDb03kVKL7vpMTQSba6qhIyCZCO1O1sRQLhFzRnWZ3YNXuyxhYraFGn
 JB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789055624; x=1789660424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JUpsdGvqseB1AHyz0tW4KfPnNJ7ouSgW4ym01OBM0jI=;
 b=P6gMVh0JaNGSDxdDcng3MsCGMMMwTd1CnRAfUWoej5vk6kBxee2KGlwJg8XF0b5bQ9
 GR+tElti4t5oQcjDX3w9XVRgmBXUYpdfApf2sb1j7QkmLKsFpP9JyNWEzALekREPnJ8y
 mLYnP4Y9rVvhLnSpnEFtMuEVvpv5gGaQumGGx6CpR2KsvgKx1B9qwzIsB9aPM96ZMJgM
 SlhoyRHEgZCtWf8Vlkatif64cr0fuEJ+sdhyldgeQmUUKIYGAtBIrbE6QN1tCdKyW4EF
 P4+Zia3eCkUweMk48MIhOAlAU7QXoHYQQrga8PHIa5NHhIv/WDyYxMxQaWPIezIPtsP7
 lDzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydToQX0iirIEeLGT+E3/qhK9/f153F1UUzIGr7see/FRyrTO8ap5IMWEyOGU1ObKpvnIQ=@dpdk.org
X-Gm-Message-State: AFuF++l94cW/RHMT4B5+Lb9VSkhhllRqCZi5TRHVux8pacf7HvNfG/vN
 xKyGgt8GOcmLqNaID9bpw+nB9LFIp4CRSllex2cuJr4/7SW3yZB3L40j/ibJV3725v0=
X-Gm-Gg: AYBFou1Cq7ObpjiGt5WvJoHztV6y5WnfwfbXEmKx4QfVaZKaY/t/3zxDYrGxbRKj3Ca
 cOrLzgcYHYEsSAhvLGssn7644i7vwbP71VzKV3uoESoMR6YfB5Hg1gw824++fZH/qtl4aM32GfH
 ydpiusvd2+cfMzZR2eQQ9q+NGYVdADrP5Vx32x0u+83nytFrrn7Qe5ATwAAgR1VzeRPLLPphDVZ
 CrdykfSweA8OZ4iEFt1L/PfbN40Ek1Cr9ZVggk4nuETpNKCnAMPcwMPIXjZqkWlVtUI7Wy9++Zj
 ZXKRI0WqFhfuk2Ax0y7ECf6rHtHXfnW3OG0SUs7ykbveWgAu3N5+JAUopkezF+VySxT/EtR7YGc
 qaox4RuMwo4GJmarhHQyyAJUiONXZZYJOagrjAixAwirg2Cy6JShrXQT5Aa0OhF5mSbWjg8PqbD
 mex3rs8kkO5/+ItLKNn/cELROayvtMlIZBS1EBYOp5SJWz1GOumboZiX2s4UJ2fFDpWjvvs8v/6
 ZO6wS0GhdhjH5ObuG/mpt4FeqjWj9e8uK53rH1J
X-Received: by 2002:a17:90b:5108:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-39d97f392d3mr28390a91.8.1789055624270; 
 Thu, 10 Sep 2026 08:53:44 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d94dacb79sm257496a91.13.2026.09.10.08.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:53:43 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:53:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang
 <zaiyuwang@trustnetic.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/txgbe: fix use-after-free in flow destroy
Message-ID: <20260910085334.5dc6872a@phoenix.local>
In-Reply-To: <20260910133941.77565-1-zhtfdev@gmail.com>
References: <20260910133941.77565-1-zhtfdev@gmail.com>
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

On Thu, 10 Sep 2026 21:39:41 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> TAILQ_FOREACH advances via the current node's next pointer. Removing
> and freeing that node inside the loop reads freed memory on the next
> iteration.
> 
> Find the matching entry first, then remove it after the loop.
> 
> Fixes: e342da2d438f ("net/txgbe: support destroying consistent filter")
> Cc: stable@dpdk.org
> 

OK, another option would be to use TAILQ_FOREACH_SAFE which several other
drivers do. I have a patch series to cleanup the queue macros but waiting.
