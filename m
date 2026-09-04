Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AC4C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 20:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD5E42DCE;
	Fri,  4 Sep 2026 22:46:53 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 39B3E42DD5
 for <dev@dpdk.org>; Fri,  4 Sep 2026 22:46:53 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1030414b3a.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788554812;
 x=1789159612; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kvz1ERnCSg+5q7TkuZmpYgNirhdqZY2i6kLPBPThJGo=;
 b=r22J2ooyaADEM5WBsQVKrRRVnWILsryDfdnRY6jJGlMUKzGOept1i4o5dELKjgBFLG
 n6L8NTGUSVJizpC46cYdxvYZASkJmZuad6d6het8dc63QE/yomCjs9Gw+6UC7VCc0+7E
 jqXnITsPrbKQMWq0fa48i1/a2tOCG/WAHzJ/y9COEbL7KECtAS+npiCW+FCB1seUYxf2
 QTITH8AGeaRQFZlkb8d5cYpqSALzLaSrV4Eows8nw9ObvbIbZyna2gRHlpfUYbx94dHu
 iWVd//952h774IDplJmbYE9a6dnuGeNfB1MtwO0iTcVeeKNyIZmlb9U/YKmYo3A3i7mJ
 EDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788554812; x=1789159612;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kvz1ERnCSg+5q7TkuZmpYgNirhdqZY2i6kLPBPThJGo=;
 b=qnlo3rAbxfF3IbLyu45kvmsJUerD23NuEnxTQgTuDNvmY021Ixa7aWwYN8D2pHCd8T
 dJKRNFQ0qjgxXsmI6ioZWF+9j8rR9I0p+7jGqlc5sMjIV0HmS6X2mtMSAFxlM9adkfmt
 JwsMkSHvK3Quq+FaRtWLx3DLhHynMn5A5BbCKYt6ksRerXvZh2R9N7IeVBVbxskWLZ8T
 g35qtVYN2aYln5lKvvx0Eqs0mor55+Vl2Esu3Cyeu3JPQpy2FvMEYHvdxDwS60t9EN0q
 zz1p/YnjtORU4iBnC7+slChOZl85O93o/4cHrECDlc7xiA0/WXlyiLI2b0odM6ZyGn+X
 6LIA==
X-Gm-Message-State: AFuF++kFWM7qEHUhC4l5yc9XB0SJGJQ7u1hq0+juiyB6Z01si5VxswI2
 1Hr3fqbPiCpL1sy4mun88ooqnBcO8M4cdEExUYP4zBQ6kdIrZEre4lkIQrRYA/CAgWanB0p6GPJ
 u27CY
X-Gm-Gg: AYBFou3mMUqh0hpzolvpSLIriqeKjxw7Ed9Da2PTwFfw46tf+TF0YN5zKrbCujgWaaT
 73V2yISnJ5f3ShyDPuY9Aq7rk1UCmVcSSM5p/RE7YKLGNd2XIKvP7UpF0IXpkmk4i/srfskHxu5
 lPlICD2fHKpPIj9N854cLv4EO6V9NQ0o0CCxN1KGJ921xBdpzwedJ/ReWVTSepmB6FUjClVYxJV
 P7O4/ocqXB1lYfVNZeQPgZv1ywW09QjnuWjb1KHUGHjsou9q0H9ZkUyfI7RBy2zqn+TgRclhNB8
 /mjogHedkogZMsYBltXayarP5Kea69C69fhG3DSx0+P5rZiP0DyjX1RF4VsUwcJj1FvwsdTZtaX
 LJ0DhbD5U+8lbthwXiMbnwSfq5psuiW36Rf+YK5fHcFh+F2lkgBhrQkIqYcMDl9fjbFzMWCW6wa
 q8PmqJZ3gi4FK223IwoHJi3T9z5rHZTDTbgQd9l898BIYnjnPsvtcBxszHTJ+tgC9LiR+buEvD5
 +F9GSj08OZbk8+AKQaGSjw1cfqGag==
X-Received: by 2002:a05:6a00:3cc5:b0:848:2c2e:c79e with SMTP id
 d2e1a72fcca58-86169876142mr11266830b3a.12.1788554812008; 
 Fri, 04 Sep 2026 13:46:52 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614f871fc6sm1609938b3a.7.2026.09.04.13.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:46:51 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:46:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Dmitry
 Kozlyuk <dmitry.kozliuk@gmail.com>, Narcisa Vasile
 <navasile@linux.microsoft.com>
Subject: Re: [PATCH] eal: fix alarm cancel list walk
Message-ID: <20260904134642.18a288ae@phoenix.local>
In-Reply-To: <20260904202031.2688530-1-stephen@networkplumber.org>
References: <20260904202031.2688530-1-stephen@networkplumber.org>
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

On Fri,  4 Sep 2026 13:20:31 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> All three implementations of rte_eal_alarm_cancel() free entries while
> walking the alarm list with LIST_FOREACH, which leaves the iterator
> pointing into freed memory.
> 
> Linux and FreeBSD use two loops: one draining matches from the head of
> the list, then a LIST_FOREACH over the rest that frees the current
> entry and assigns the saved ap_prev to ap so iteration resumes from the
> predecessor.  ap_prev is only refreshed to a live entry by an iteration
> that does not remove, and the head loop leaves it NULL when it empties
> the list.  A removal in the second loop then sets ap to NULL or to an
> already freed entry, and the LIST_FOREACH increment dereferences it.
> GCC -fanalyzer reports the freed case:
> 
>   lib/eal/linux/eal_alarm.c:224:44: warning: use after 'free' of 'ap'
> 	[CWE-416] [-Wanalyzer-use-after-free]
> 
> Windows has no such dance: it calls alarm_remove_unsafe() straight from
> the loop body, so the increment reads freed memory on every removal but
> the last.
> 
> Replace all of these with LIST_FOREACH_SAFE.  FreeBSD sys/queue.h and
> the bundled Windows sys/queue.h already provide it; glibc does not, so
> define it locally as is already done in several drivers.
> 
> Fixes: af75078fece3 ("first public release")
> Fixes: f4cbdbc7fbd2 ("eal/windows: implement alarm API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

The windows bug is real, the other platforms it is not a bug but just
Gcc getting confused. Will split and resend
