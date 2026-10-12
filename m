Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC9CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 22:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785B440279;
	Tue, 13 Oct 2026 00:05:02 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id E879340272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 00:05:00 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1089151a12.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791842700;
 x=1792447500; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TgqI3aXpRkZFKF+EyHaP6jrEaApvsNSHkl20c6J/fY=;
 b=R/h01y7MpJoZU7a2w9sk1PObkZVu2evpJkwa6TV1nwgpAqraMcLlTjXQMXuNqQIIr7
 nfJpWodDUQnh83/rZlqzN+fhS24K7J4MMEiqZvC604o8X11YmJWw9eSQVPGj55cRqf/J
 yzX3SVf8Jg5TpVcf7sBxxIeKN9UiwQUVqVVbu2/6l6M9I4WgRQfiiqOWgkcjVwdV8rLX
 4jS4irX0rno5yO+k0jU7WVeBrNfoA5Ps78Lit2Lq8YeHW6MSk0afkHzNsvix1oMsU/ty
 Bfnxv6POhEX2PuU+QHDXr3z7GPPAEO0Yx7zQa/U4N0lKL765yGalOeptKy++TmVd1vML
 +NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791842700; x=1792447500;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TgqI3aXpRkZFKF+EyHaP6jrEaApvsNSHkl20c6J/fY=;
 b=BXbpUJ91bTC7I5lm2F1DWIKmsPZ2zSEcWfGHyIfltSXI+EThq95jRST11lGfSz2D8H
 YrVmbQddVkhP8pWXO3fPxiKWtBdl3fqAkgTqPUNSXMIdWqkZbF714Ye4PO+NM+pxtC6e
 pl+uYf13vBvNk5WxI1jZR/P5VNw+sY3rQdYcMGOhLvqis2pgNy8CwGSGkF+oyt24XUxx
 zC5QFCbtGq0pniHxo9V+UbXZO4Zj9xIXgE9FFsdcc3porRh9fYjnO+lHe41BV4aVxs5p
 J+oRrx4VpLCMxtPqXPRYXj+JAAkjxsFcN8XHbOaLskRQTfQHUrHfOMpt/IUcme6kaR7M
 ZT5A==
X-Gm-Message-State: AFq9FYIrc151aDYebCG3wwifvX25knaz2XMUKhPTFJ8BSqgPelMKwE2c
 JTs+YcWYHHhjOkICjby4wSHztXWMbJ6+fZxLW+7sZZ/nG4iQEoFwzZAxEm7ZaVLZxVI=
X-Gm-Gg: AYBFou2v0A0ysGLJD+efH0n5LfaZB6TnvKCCnfCSiD+lxIQJjr8iveSAC9MjPmHIE/h
 YjMmGbwE2X8SmWWbJcJTpyZ8hZx+29bCYHS9XgWExWc/CyjdP4ndnqaIx1lPvcYCwgfzTvWDLDi
 2nyIm969/S1SG99/nwNk7OKiM2oCubnuGw+OG/lNAU63twNxxulrrvkbF7Gi8YJ9bqCmQrbhvVb
 Jd/IN87VNtkmACS/Fh/Eg5kmR5FQ8qbNJuTEuYztygz88dae4GtqIGIw7SM9f/wjlaH+tjPqN0/
 x95oSzLG0w4jiS2fnNZkvHpmKuFQs4MDPaQ7CPNR7sZZ5znJNMuv4tr6I9kyEra/48BFzeGsfr+
 vbpA2RaQNQ8av3ZrCtqD+q9xr2Q+iboN8KPQKc7Sru0qjRS1tnlK+2HkTnjrBKJTpnNnEZZ8UvS
 hCXrcPyRTYDOSIyNj48ZKsQc7oP2UUZ50eK0+dbBKaBcCgU7/I9JAKjOzY0HKN0hWMSrJ/iw1ni
 mA4Oe0KQRotZKIdnj5i761iNi6W1+P1EXLhUq5G
X-Received: by 2002:a17:90a:e7ce:b0:3a4:93c3:9365 with SMTP id
 98e67ed59e1d1-3ab3ac97999mr6613200a91.34.1791842698920; 
 Mon, 12 Oct 2026 15:04:58 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e841a04012sm47844255ad.1.2026.10.12.15.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:04:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:04:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Akhil
 Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, Honnappa
 Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: Re: Proposal using RCU for callbacks
Message-ID: <20261012150455.1ea77c99@phoenix.local>
In-Reply-To: <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
References: <20261012111324.6db17de9@phoenix.local>
 <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
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

On Mon, 12 Oct 2026 21:27:08 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> On 12/10/2026 19:13, Stephen Hemminger wrote:
> 
> > The BPF and packet capture Rx/Tx callbacks use a per-queue use counter
> > so that removal can wait for the datapath. In BPF that costs a locked
> > instruction per burst. The code would be faster and cleaner if RCU
> > could be used, but DPDK RCU is limited to the QSBR model, which
> > requires application opt-in.
> >
> > The userspace RCU library (liburcu) supports other models, so I did a
> > brief investigation into whether something similar could be done in
> > DPDK. As expected, it also turned up pre-existing issues: the counters
> > are wrong with MT_LOCKFREE Tx, the pdump one is not safe as written,
> > and cryptodev callback removal never waits.
> >
> > I used Claude to write it up in more detail (attached). It is all from
> > code reading; nothing has been reproduced or prototyped yet.
> > This is too big to go into 26.11 at this point, will try and have something
> > for 27.03  
> 
> Maybe it's just me, but the document is a little hard to read without 
> knowing all of the context. Nevertheless, there is no doubt the sync 
> mechanism in bpf_pkt.c can be improved. It done today, it would probably 
> be written differently, very likely with RCU.
> 
> I would argue for incremental approach however. I'm currently aware of 
> the following problems, in the order of decreasing priority and gain/effort:
> * Deprecated rte_smp barrier functions being used.
> * BPF inuse counter is not safe when using lockfree transmit (Bug 2051)
> * Code needs cleanup and documenting to make discussions more productive.
> * Possibly additional safety issues listed above (which I don't yet 
> fully understand).
> * Missing features: multi-threaded data planes, multiple callbacks, BPF 
> program reuse etc.
> * On the very last place, performance; as usual, benchmarks are 
> mandatory for it to have any meaning.
> 
> I think we need to resist the temptation to just rewrite everything, 
> especially with AI. Some recent research shows that productivity gains 
> from AI are very limited particularly because code review becomes 
> bottleneck (tbh it always was). Test coverage is also clearly 
> insufficient for any major rewrites of this code. A patch solving 
> everything at once risks getting stuck in review for very long time. 
> Perhaps we arrive at RCU solution eventually, but I'd start with first 
> items in the list.
> 

Short form: BPF and pdump could use RCU to manage callback lifetime;
cryptodev already uses QSBR, but incorrectly. I would like to see
one usage pattern across all of DPDK that is fast and correct.

DPDK RCU only does QSBR, which needs the application to report when
each thread has passed a quiescent state. That restriction is why it is underused.

Other RCU flavors avoid this. With membarrier, the reader side needs
no fence, only a compiler barrier, and the writer pays with a syscall.
Reader state can hang off EAL thread registration, so no application
change is needed.

Today the BPF callback does a full memory barrier per burst. RCU would
replace that with a compiler barrier. Benchmarks will be needed to
show it matters.

This is not "let's use AI to rewrite it". AI was useful for the what-if
analysis; the real fixes will be real code, done incrementally.
Agree the barrier conversion and Bug 2051 come first.

See:
 - https://man7.org/linux/man-pages/man2/membarrier.2.html
 - https://liburcu.org/
 - https://github.com/nmraz/simplercu (toy implementation)
 - https://lwn.net/Articles/369018/ (original 2010 RFC)
