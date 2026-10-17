Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5BDCCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 21:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FCDB40276;
	Sat, 17 Oct 2026 23:18:31 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 9BE5A4026D
 for <dev@dpdk.org>; Sat, 17 Oct 2026 23:18:30 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3a7cfe8f761so1356741a91.1
 for <dev@dpdk.org>; Sat, 17 Oct 2026 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792271910;
 x=1792876710; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K3AIDG4kpDzo+Jr4+ziipE+bOeb31pIT01nz8qO2qdo=;
 b=xHDEJeiwTZBbtWaIWQxQiObAWrp+ep7ax0gthYy4vXjT5tMxCtXyf6pxvOxcd4QWGE
 QV6lMkGFDlnm814iVGJZ+KiXJnGzRQIgZpXeh2Dqv5W+HRtYTeSDVlsr5EANqm6dpzHO
 6uTBvx2PiPntfJ5d2YTwxHsY75tW84Xhx2ArLQ40p7KXPSPZAlISipLIDsPXIZCAa+Ni
 gNaaDXgv+QJW1nhrv2FHugS+sId9zXl61iIJjZzXJ5sNQguSurt+OASFjqAlAkqx3Bsv
 OCLydfrNWLmbxPLPnyGxv+AUALGXJce3o6RHezUrqBxwAtOs8jkQfF0XqDhqiJoj82QA
 mY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792271910; x=1792876710;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K3AIDG4kpDzo+Jr4+ziipE+bOeb31pIT01nz8qO2qdo=;
 b=OfjwevIZ2FdBv4u8M35h/EvtJjRqyjl2/Q7NfaP6glt2AoSSbN1zN14HUHqNiXXoe0
 JV59OCwY8QA5r9tkCR5FqsHsyYegp+KK+0VmWe1gHycEx6cUD35Zwxd2rMgvdHPcTgny
 K0BVrRJ6bKAFdzpm5a1fw68jhmz4AvKVfp5MJgHUU6hzEd6LDTFPC0yme1WB1hzveOF8
 U/ADBqRiCQXwEwwqB9RnBksXPBkatzqEZ6BjSS9lnARYBM4SJ00vieflwV12x1Xg7trn
 b7PoETNbctMVKeWMGR8fecJdxIhHV1qikwg+Uzqz2SUuIxgpkqSViBIDAj2VWqImg716
 QZUg==
X-Gm-Message-State: AFq9FYLz1IL28PVjUe2ltjQxC8K544lj9bNGjblqiZIPrykh0dIEwn0I
 YcxahaTtCyAiIJpzVSZCEVNP9skdY9D0aQl6SjRavuNfoJrXs3+3vGFNacSFmES2V0G+uKukY+y
 MVsFF7YI=
X-Gm-Gg: AYBFou0Q3O/AW9tTt3jWdxWw51wccCySBP5LQSGUHx0zh2azBtrTQ6OssS+5a7CbP//
 TELYCFSBrd3PCGxf8TFwYsrn2pzznHbbTp/oxkrTPvaKqGGaYOTQB2d744/uEeBb1JF7O25CIWr
 1o8Y8VMjXI2T6Ru+g4ocBZJkF7r7PijGhnhILLq41+YEkHmDyoZD2gzQ+z6A5gGBqi6JqDbvzxk
 4PPePSBecoho202gkIPR6VXehEq8QAOUUQMEgVKf1Q/1AuAqFktuNOY6AynNL0Z/Z3h+NFFcMzk
 SkU39ZGm5rplKKfivMf9Lo9x9G4FKAAyZ8l3SW3e3N7SbDb00vy8RbwjdQlJj5deWQzMtNg59pr
 Fcs7rhaOwJVw/as5cIZYhod1U1by3/kXz0npSYvI/PmpWwIBjXbz52U9eJIvEi5jkFy0OrjRspl
 SFokZuwrfZbwbTZIWigV/JJzTLvHeGZ+m9uN/lFRUMI+bbHJ2yclaGTwLWlKhO5KIuvgcqhfolG
 9G87WZs988ESMmQJilAozMgRrJE6xnhq3K6aMMv
X-Received: by 2002:a17:90b:28c7:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3acef134e1amr2185269a91.16.1792271909559; 
 Sat, 17 Oct 2026 14:18:29 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94794dd9sm14270411a91.12.2026.10.17.14.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 14:18:28 -0700 (PDT)
Date: Sat, 17 Oct 2026 14:18:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/4] net/af_packet: do not return outgoing packets
 from rte_eth_rx_burst
Message-ID: <20261017141826.0d364768@phoenix.local>
In-Reply-To: <20261016211942.217041-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261016211942.217041-1-frank@dressler.pro>
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

On Fri, 16 Oct 2026 22:19:38 +0100
Frank Dressler <frank@dressler.pro> wrote:

> The third patch adds PACKET_IGNORE_OUTGOING which moves the
> filtering into the kernel. It is supported since Linux 4.20 but only
> works for single-queue AF_PACKET scenarios. Multi-queue AF_PACKET
> is still filtered in the PMD.
> 
> The fourth patch adds PACKET_FANOUT_FLAG_IGNORE_OUTGOING which is
> supported since Linux 6.2 and moves the filtering into the kernel
> for the multi-queue scenarios. The kernel does not expose a direct
> way to check whether it supports PACKET_FANOUT_FLAG_IGNORE_OUTGOING
> but it also does not return an error when the sockopt is set on
> kernels that do not support it. Because of that the sockopt is set
> opportunistically. The PMD check is kept, since older kernels accept
> the flag without effect and support cannot be detected.
> 
> Overall we get the following:
> 
>               | Single Queue | Multi-Queue
>   ------------+--------------+-------------
>   Kernel 5.4+ |  in kernel   | in PMD
>   Kernel 6.2+ |  in kernel   | in kernel
> 
> I tested this on both, kernel 7.2.8 and kernel 5.4.0 with both single
> and multiple queues. My results, strace'ing testpmd 7.2.8, with the
> variants of ignore_outgoing=0|1 and single/multi-queue:
> 
> Kernel 5.4.0:
> 	qpairs=1,ignore_outgoing=0: -
> 	qpairs=1,ignore_outgoing=1: setsockopt(14, SOL_PACKET, 0x17 /* PACKET_??? */, [1], 4) = 0
> 	// 0x17 is PACKET_IGNORE_OUTGOING
> 
> 	qpairs=2,ignore_outgoing=0: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-1878917532], 4) = 0
> 	// -1878917532 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=2,ignore_outgoing=1: setsockopt(14, SOL_PACKET, PACKET_FANOUT, [-805175699], 4) = 0
> 	// -805175699 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 
> Kernel 7.2.8:
> 	qpairs=1,ignore_outgoing=0: -
> 	qpairs=1,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_IGNORE_OUTGOING, [1], 4) = 0
> 
> 	qpairs=2,ignore_outgoing=0: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-1878978899], 4) = 0
> 	// -1878978899 does NOT contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 	qpairs=2,ignore_outgoing=1: setsockopt(13, SOL_PACKET, PACKET_FANOUT, [-805236964], 4) = 0
> 	// -805236964 does contain PACKET_FANOUT_FLAG_IGNORE_OUTGOING<<16
> 
> They show that the setsockopt succeeds even on the old kernel that
> does not support PACKET_FANOUT_FLAG_IGNORE_OUTGOING, so setting it
> opportunistically is fine. They also show that the code only tries to
> set PACKET_FANOUT_FLAG_IGNORE_OUTGOING or PACKET_IGNORE_OUTGOING when
> requested by ignore_outgoing=1. And it shows that
> PACKET_IGNORE_OUTGOING is used for single and
> PACKET_FANOUT_FLAG_IGNORE_OUTGOING for multi-queue.
> 
> I have also manually ran testpmd in all modes and both kernels to
> verify that ignore_outgoing works as expected, sending packets and
> checking what testpmd was receiving (``set verbose 1``).
> 
> 
> v7:
> - log ignore_outgoing with %u
> - use n_inject for both sides of the ignore_outgoing test
> - mention Linux 4.20 once in the single-queue commit message
> - keep the release note to the devarg, not where filtering happens

Applied to next-net with simplification of the release note.
