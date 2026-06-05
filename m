Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD9CCD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 18:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37B840652;
	Fri,  5 Jun 2026 20:12:39 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3F348402E0
 for <dev@dpdk.org>; Fri,  5 Jun 2026 20:12:38 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-9159bad8c98so245873385a.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780683157;
 x=1781287957; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDB1buZPI+X9hvEahKUor1tRJlOX5PA8KVzoTvk8iMc=;
 b=n1GfD6w0bjIvevrRAYw8Jf0h6oh04u22A61KP7VvgzJpRW7NiL5sxoGwzsL+f0qkZ3
 tYv2LOARzwsa4CzyPHBAyBBYO8/xEmf3FbhB6cDADDRLkEZu8dtDf/8CSbRJrpU/ScL2
 qdsDJ9kg129fvnBssFXVCgiFm4xxkQaoeIBmfjHRSku5MbWOqdsks+kvNI/FwzosF9ip
 qyA9JS8iVDC74sBvJ17f6ARbSS6ZKGHkrA28Lib2HZUPTaEFPkbNGOrh/X+v7rMfw0ab
 AlktjmoNKMVnrfLSnXY6Fi4cWuQ7X9vSslBm5K0cBC3Wt0C+9X0mW/kZvuixjdmVe/8f
 sqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780683157; x=1781287957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDB1buZPI+X9hvEahKUor1tRJlOX5PA8KVzoTvk8iMc=;
 b=MNBngze9Q6mLPkC+FlTzUOZIbTcWLjgn3FJOqYnRkVJKfq63swOZwEvXxzea44lpCF
 BcpQ9jsV+TWXRCCCnxqDzUuRU/ror4UzdWtyUmXm1QOFpSLC8bwA8zQLjRrgi0fKzv7H
 wCn8eqg3QlXNvCVgf13+DDfOZvbU+BFeqXQQVVQp/Msh7GMYf79mm939lizJ2zTHY4Np
 6ClQ/DKlQiiXd1+k/bfQWaub8/dV487++jYgiFbCZ+bqgtWGv5FrLt2H1rzQ303PyZ9j
 +wXT4j7xDIYbqCQGm50znrDJhB88wf2M7aelDoTIfNxVfZbtSLEGQwMD8WC3ozfMb5m6
 UM6Q==
X-Gm-Message-State: AOJu0YyOkPBXclHS5JDCSINhWNbSWT5E5syU0O1lYmqoHrFT6EDzSlXK
 N6dr5qtDgpAh7dR//1Qx0d2t6T9lBUACVBrguLc+SJUbOx3VPVNO8KX5Av2cUO9D6lE=
X-Gm-Gg: Acq92OFEPrSNJEn2CH2HR4phiyd4p8PB80eXnVFuK1k5OYDJ8HgeVnqOyhZuNlVk9Pe
 kh4CaV8T4hWbrSVmb8CW63MBnP3rw94EPny/kJqcLd5hYsjR7kwVwz2+slBrM1M6Mw9jw24kieP
 haEgvYgdeKoaq3/UMI4mAusQDGtE69y/PhauZ7Yijj8cxy2Zs992qQqHu8eiLq/EZ0dbnnAJbmJ
 1xm1U4N5J03ZFlKPR2qUszKnrpqvGIx0G1fFP8xP37nDfRkgT3slw+BFn2jlwWP+pb7HsN6J9oq
 PXL9Jzj8/L3Zisd8HTB8QnPBnBWXcVhQ5fIw/xxdyA8F9HHim2B3QiZXOxpIdgKx16sgV+3ziaJ
 ETkyUEGWrhDojOirCtzlC6DyF2vV1AWzS3V8lcw00TvT5GZKRlzCpfa9bNwPdDnjPzL3uTCiXHm
 QHjtxWBbunY/1rVkhq8CtAaGYUPxC4HTWzvhFzrDlccXnxUDQz7px3zSTmSmF949C2VTrWvRjr6
 ao=
X-Received: by 2002:a05:620a:1988:b0:914:c226:ecbb with SMTP id
 af79cd13be357-915a9cb2056mr881887685a.23.1780683157344; 
 Fri, 05 Jun 2026 11:12:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3b3f6bsm954281685a.33.2026.06.05.11.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:12:37 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:12:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] eal: fix function versioning with LTO
Message-ID: <20260605111233.725bb792@phoenix.local>
In-Reply-To: <CAJFAV8zEg7YNuoO-U-fwnWCJ4MWk9Zm0Zp9pwoirRRn9LHFKrQ@mail.gmail.com>
References: <20260602225722.950617-1-stephen@networkplumber.org>
 <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
 <20260603085359.739ab626@phoenix.local>
 <CAJFAV8zEg7YNuoO-U-fwnWCJ4MWk9Zm0Zp9pwoirRRn9LHFKrQ@mail.gmail.com>
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

On Thu, 4 Jun 2026 09:50:25 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Wed, 3 Jun 2026 at 17:56, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Wed, 3 Jun 2026 12:01:48 +0200
> > David Marchand <david.marchand@redhat.com> wrote:
> >  
> > > Hello,
> > >
> > > On Wed, 3 Jun 2026 at 00:57, Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:  
> > > >
> > > > When using function versioning and building with Link Time Optimization,
> > > > the compiler does not see the __asm__ annotation of symbols and
> > > > therefore thinks there are two versions of the same symbol.
> > > >
> > > > The fix is to use compiler symver attribute on the function which
> > > > was added in GCC 10. Keep the older method for backward compatibility
> > > > with older compilers.
> > > >
> > > > Bugzilla ID: 1949
> > > > Fixes: e30e194c4d06 ("eal: rework function versioning macros")  
> > >
> > > We never used the symver stuff, so it seems unlikely the issue was
> > > introduced with this rework.
> > >
> > > The fact that clang does not support this attribute is a concern.  
> >
> > Clang doesn't have this problem. It works as is.  
> 
> The Fixes: tag is wrong regardless.
> The issue is probably present since introduction of the versioning
> macros, or introduction of LTO in DPDK (not sure which came first).

Right the Fixes is wrong, will resend without

> 
> 
> > > > Cc: stable@dpdk.org  
> > >
> > > Why do we need to backport?  
> >
> > Well LTO has worked for a long time, it is not experimental just
> > not commonly done since it takes so long to build.
> >
> > We were doing it years ago at MSFT.  
> 
> Well, sorry, but every time I enable LTO, I end up with some warnings somewhere.
> I don't think I am doing stuff really exotic though.

Using LTO has always been extra effort. It is worth it for largish
legacy code because the compiler can crunch things down.

> 
> Looking at bugzilla, we had various fixes for LTO over the years.
> We still have one open bz btw: https://bugs.dpdk.org/show_bug.cgi?id=1709

That bug was fixed a while back. It required addition of hints (__rte_assume)

> 
> Hence my feeling this feature is not something used by many people around.
> And without a CI, we will keep on having to fix bugs/issues.
> 
> 
> > > LTO is kind of experimental, so it seems good enough to reply "not
> > > expected to work in older LTS" if someone reported an issue.
> > >
> > > And in practice, no LTS release call the versioning macros, since a
> > > LTS drops all compatibility.  
> 
> Just to be clear, we don't need fixing the macros in LTS: every time
> we prepare a LTS rc0, we drop any kind of symbol compat.

Agree, this is not LTS related

> > >  
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> > >
> > > I would like to reproduce, but I can't build main with LTO.
> > > What patches did you apply locally to avoid warnings on the hash library?  
> > I use Debian testing and GCC 15 but shows up on older versions as well
> > I get no warnings building main  
> 
> Building from scratch, I do avoid the warnings I hit yesterday.
> 
> The fix looks correct, my problem is with the form.
> Fixes: tags accuracy is important.
> And I prefer we stick to "It is not broken, don't fix it".

Could argue it is a GCC bug, and applying their desired workaround :-)
