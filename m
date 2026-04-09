Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C6F364AF
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 20:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0666402E2;
	Thu,  9 Apr 2026 22:10:48 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 404E440276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 22:10:48 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12bfa7fe691so448136c88.0
 for <dev@dpdk.org>; Thu, 09 Apr 2026 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775765447;
 x=1776370247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zYWNoNLYtcZNqCNyWAVPpJd0f+/VsMpM76BSwcmiNo=;
 b=WCgeJndvZ1OUBYJQQ+47j9s1iClePQNMpXcsVT9zV4dDBSfYL10GtMAwNT0gD1MRVZ
 zqn91UUjIMs2zh4Uvdh0LjnCjZvBxkl7Wni+OO6eXmP0fdc9AgJEASr6ed2fUn+CJR/B
 edF1AJ2EEpGtT6SB73m98vHTFmP4Ozl6PEdT6j8d3aBZHrF/xcYacsVGdNf92seyfeuW
 b8LcItYS+cpDPPjpnM2s6lHBvxEeelVuimKaa3dPArxEXPKvr4ezZMPU6P5gKrcjabEz
 GMpgvaf+UPy7QLHYUkSf59q4EO8w8F4FhpRjG/AYIA1RgwVyN8e3+2upyY/dlSEy5dQu
 94Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775765447; x=1776370247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0zYWNoNLYtcZNqCNyWAVPpJd0f+/VsMpM76BSwcmiNo=;
 b=L5ZRGAwiDNXUQiLDQTOSfVMV2gL0iEDgnRX1fDhvKKIsJ3xr6EensFPjtklDaerc4v
 K8SB8q8J/tGcSFtWgY21vhTZHnZTw4OrJxAsNkmd8khIs90Sw7aszIBWQcZBkOGePqrS
 dpiMjuuDPYRxAWFScsq42NjYgAyXvFLMO71bolSv7tKl1EBEM1KxnA8qY25uTVztF31K
 DghlNbz8hy+MFKAflBWVDBwW0crb5uWRcSOv3JezIxjCb0+5g1ReP+WOPNUYENcQJHi1
 ge/j4yWZ2GZ+ghC6P9qNx/AWUtvK3XLtGKlI9DZ3aW2jn9MUtineXLJG1MQCk0C0zepK
 Gj3Q==
X-Gm-Message-State: AOJu0YxTRnyDg5K+4nsim982+znQAO6buApS19mDhvdYO4iG5wHRV2Be
 BbB2nkl1xNfNAd0tmz13HpD+407K6Y845ys+ap9S6zsuO8fq2nCvVqxBUeAA7mypOg0=
X-Gm-Gg: AeBDietyY/NKxseyFe5zYtSTHozhvsqhJK2M0yVkg3WCGQYKVmI3lCTuEDhngkAbgGb
 xG107+5rdXE1rvlU9Oti19gHejV+DPuVWmm7m8RB0DNpMoQpWbp41M36W0eOEod3/DaD//OTpsr
 g8gGjv7aDJL8R8pzaFylF9eqXpXngO/abhyCTBj75aBAKd5H46HCarULMWekFvS7tE45+1nsqsS
 pvfhsfv+ksm9MehxYd6Z4yb37Z78yzV8NoceY9tMB0W9v0K7oDbWasNcCgZDl3iAi7BCGqVcDdd
 EW2BhOYW3KvIi5mgZtop8I5qX+48N+l2VK2o0n6qkC81wdEJAZR5vxpg06wGdKF81DrpYOJhW/3
 Ou3wQacvEBC0ZEkg7yuJtGudOiWOVr0k2panhsTnpDK5QiS40VReTRVQTsUy7TthBEwwvWAQAg4
 u8jktAWhaZwSxZwheJN9TlztQAQW0UDUpwcRs=
X-Received: by 2002:a05:7022:6627:b0:11d:c86c:652e with SMTP id
 a92af1059eb24-12c34e45328mr298503c88.5.1775765447022; 
 Thu, 09 Apr 2026 13:10:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459fa73sm1120375c88.1.2026.04.09.13.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:10:46 -0700 (PDT)
Date: Thu, 9 Apr 2026 13:10:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: DPDK ip_frag security analyis
Message-ID: <20260409131044.242b8b2d@phoenix.local>
In-Reply-To: <282c899d27cb40b292d199c7490f3ede@huawei.com>
References: <20260407172750.34e1aaf0@phoenix.local>
 <282c899d27cb40b292d199c7490f3ede@huawei.com>
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

On Thu, 9 Apr 2026 13:04:52 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> >    Fix: use TAILQ_FOREACH_SAFE, or save TAILQ_NEXT(fp, lru) before
> >    calling ip_frag_tbl_del().  
> 
> ACK, that looks like a valid one to me.

I sent patch for that one:
https://patchwork.dpdk.org/project/dpdk/patch/20260408161947.285185-2-stephen@networkplumber.org/

> > 6. Hash collision DoS via fixed seed
> > 
> >    Both ipv4_frag_hash() and ipv6_frag_hash() use CRC32 (x86/ARM)
> >    or jhash with a fixed, publicly known prime seed (0xeaad8405).
> >    An attacker who can send crafted IP fragments can precompute hash
> >    collisions, causing all fragments to land in the same bucket.
> >    After bucket_entries concurrent flows collide, new flows are
> >    dropped.
> > 
> >    Fix: randomize the hash seed at table creation time.  
> 
> ACK, seems valid - needs to be fixed.

Sent patch for that one:
https://patchwork.dpdk.org/project/dpdk/patch/20260408161947.285185-3-stephen@networkplumber.org/

Probably should go to a better hash function to be really paranoid.
Linux and BSD switched over to siphash because of this.
