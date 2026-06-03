Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CD1CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 10:02:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5F18402B6;
	Wed,  3 Jun 2026 12:02:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 10E35402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 12:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780480924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYwjGS5I4tm71edFwsvRJqxb2OM8Hi4D32enoBencUU=;
 b=Fhbp02pTJNNyVdByewWqbwKwgjqPqLSH0N0sX4Nwb79j70WiiU3NnmDoAanngAGTJld2EW
 RqFwcJeCXa4/7wL6v/9IRW9j+oiJ2lx45xKx/JexSvxPEdVntqZLQJj/GgQG+zuUm2Eiun
 gNnU5XtzhrUqxOoXsaTalr+bVzbp15s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-ifUlxLJeNMmaPUT1cYmR0w-1; Wed, 03 Jun 2026 06:02:03 -0400
X-MC-Unique: ifUlxLJeNMmaPUT1cYmR0w-1
X-Mimecast-MFC-AGG-ID: ifUlxLJeNMmaPUT1cYmR0w_1780480921
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-396a99b2de0so5942871fa.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780480921; x=1781085721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYwjGS5I4tm71edFwsvRJqxb2OM8Hi4D32enoBencUU=;
 b=G5R6lcmlvx/fYc4uKPoA2NgQt35YACHyU1GpVfuOMQGs7VwpFQJmCH98L7WF2SwAQf
 bmrEu//N63in3op/GIH/u3ukuX6/e0oxBbU1DldCWF9oNlq8pYESl4HHb0rrwyYtrr8E
 YI8acx0hw8auTPmTcsXBrE9/MJLq7PH6/dqL8VkWyRKdKqsfqqlF55ae8V3aOC3i0igU
 SZiIfLoWZWMhtgNhj2voRmaNR/bCxMBB8wPoV3dQzxKQZwxu7LLZ8CoXFb0FswOw2ZeW
 x5p60FHxewaLP8Ihdd5J9lTGvj8lZXShlNLOGqW8+fwMASbYmLBZYdsSmYmSQFLm25T6
 nqig==
X-Gm-Message-State: AOJu0YxHWjuQe1ibe78v0kiEPTGE7QJGMuYwVlpvbLQRNg0xC7U228q/
 FKvnUbrcKU7jB8wQ1OnQBVt2C06drIgJedGnXejf3wVI2rMuUf33xR4YaNrO/k20BRmNPYnCpFt
 NPWJsad/Otj/bMuj9vP1ED93WC46S6SNBiARtigKWNavlbb4ZsC0SpF3C/zmN9iJCMll7S3jNB5
 vUw5cLY4AqoNrW0Kx1Q4M=
X-Gm-Gg: Acq92OF23YLVwf4dn/h4henXwSR5obFdjN1qooBDpYBGRhyBIkaoWZjv74uV94C7Fy2
 MB7FnzNMxBqRDUfrrRYcRr6GIRuKL4xWbye7UHczldKZ+vOFnSTeN4DXqAUz3frgHFElKHRpiAX
 kfQo9x0PPItZynhNVMMRLZK2I5QjL2abNQTpql3rj+D+/g1s9eykPUxbrkkxiZarcNpzv6Z6tTo
 cTO4bACGiInoOLZWVLsGdw4Tg3RF7WCcqaTnep3+6/gQBcQeVhcCFXqMO+wZ48tQAxeXbVBPeCM
 PKUC
X-Received: by 2002:a05:651c:1a0b:b0:396:9967:cd69 with SMTP id
 38308e7fff4ca-396af401abamr8053161fa.13.1780480921421; 
 Wed, 03 Jun 2026 03:02:01 -0700 (PDT)
X-Received: by 2002:a05:651c:1a0b:b0:396:9967:cd69 with SMTP id
 38308e7fff4ca-396af401abamr8052701fa.13.1780480920832; Wed, 03 Jun 2026
 03:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260602225722.950617-1-stephen@networkplumber.org>
In-Reply-To: <20260602225722.950617-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Jun 2026 12:01:48 +0200
X-Gm-Features: AVHnY4L2YTIIutvAPOatYmnZQxTUicBgF0NITM5GATrwksYouMarRmmlFUf-CIE
Message-ID: <CAJFAV8w+bUJGTBSOgqp8xOHXm5av2xdFMo8TNwr=kP87R30AYg@mail.gmail.com>
Subject: Re: [PATCH] eal: fix function versioning with LTO
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wNvOKphoR0z34lTHVglq8jD6o9WW6H96N-xbCzU3TB8_1780480921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Wed, 3 Jun 2026 at 00:57, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> When using function versioning and building with Link Time Optimization,
> the compiler does not see the __asm__ annotation of symbols and
> therefore thinks there are two versions of the same symbol.
>
> The fix is to use compiler symver attribute on the function which
> was added in GCC 10. Keep the older method for backward compatibility
> with older compilers.
>
> Bugzilla ID: 1949
> Fixes: e30e194c4d06 ("eal: rework function versioning macros")

We never used the symver stuff, so it seems unlikely the issue was
introduced with this rework.

The fact that clang does not support this attribute is a concern.


> Cc: stable@dpdk.org

Why do we need to backport?

LTO is kind of experimental, so it seems good enough to reply "not
expected to work in older LTS" if someone reported an issue.

And in practice, no LTS release call the versioning macros, since a
LTS drops all compatibility.

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

I would like to reproduce, but I can't build main with LTO.
What patches did you apply locally to avoid warnings on the hash library?


-- 
David Marchand

