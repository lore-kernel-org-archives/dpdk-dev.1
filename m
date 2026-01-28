Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17891D3F097
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:10:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 544B34026F;
	Wed, 28 Jan 2026 18:10:13 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id B125B4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:10:11 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so646125e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769620211;
 x=1770225011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIV7JAWTNdqqVQkJUGs8aufHPbU1PBGnyNBfc440a2I=;
 b=dgNTYHVcqGeBnItOqsWnahy9riA7srZq69I3xxtc511Fbn9xqrI8iSjjCbV4CsD7l+
 HyPMBHK+QdVWdAZ4skjkkcoD1n3QC4y2187Mp3012bc3yRUcfRm1lKDAuB0vlevvQ+ui
 HJ0ltt6rRiew8n8XDyP+Vzqyuxmj+1cP4llnOPOMmC5G6RSvYzJ/Wjrw9T1GMrdMtIZs
 0shc+VYFveZwA1Bx9j7V2HuvnrgsFlUTnXFW146y6hR3Q+b8M8ShNuyc8UpNt409uBEi
 z+D3JJj1pkyGuiLpUsQCtWOpIglH5x5dsDkhRsqA6+Na3ORM7m9a3newQ1z3wFRfLv4I
 Lf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769620211; x=1770225011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QIV7JAWTNdqqVQkJUGs8aufHPbU1PBGnyNBfc440a2I=;
 b=aqleujMsrDuxW09alvQmh00yT0mf+WW9ryXqX/y4dm0CMq0dicLl+4zqjO4q68SHNB
 J+vN4CUY472OB03MTGflCUOjR+GYdZBCwHqHLmYInY9msWHzVisJ4bJmgS4KA9iUkZjD
 EKRfJd+OdFHIPfbXQymj8vzE7D7a6c/RRdF9fEMkusB4fMqgYbh/xCsEOGzdLdCYXifl
 m7HKnHUGjAvN7x30sUHFvW3cdZau5xGM8Nktjqx6BVR/BR3Pmh6bcUETwwl7W1McXsdi
 k1N3Z8NHIvRbpA9R8yhDDhxwXynIKn2WpXPwCP1KrqXQ9jCm8I4CQj2UGxUUSQwTHNQW
 QtbQ==
X-Gm-Message-State: AOJu0Ywkg9rZbTR09Ki3lF2rK2S/S/dSYJVwHl5Ebr2Ul1uBrhCWec8b
 FIkEiWjM9bKbRcsl1jb0OwF3GLpnHBFZcoR9QPn7zd44ANtVdF5exNbkgdzZGUgZUvQ=
X-Gm-Gg: AZuq6aKlkWzfIunT/G5bYlWH46E+hKgLoXBQymN49MX5snIpOAi+jjvhyytaiWMjOAf
 dqUrEhLKMGXtfvaHL6Hz5wJauAyyTl9TsXTRv8skKA/3Kz88IauoZIJWogjf0Crsozg7EPS34zm
 0QDPNP4W2AEsYou4EcK0ioLiR8YmYva+KlOFcZv5Xj/d9OtNnxaAkSA9xBSBCKqUd69t8un8cY2
 pFGChIG7II9pGpH8iZUt+rUsfVWrYQz3DdXZGkHVaj9gIb7QJoUfMWQkIaf3u+65XdCfW6UsQ+r
 e0YkD9pvWxPGx58zBh9EEOe3XygpGD1skPUW7a/1Rbqul59xpVSSB3UWzuZCf8ISwSf67MYsQrA
 GIuOkn2v8pr0IS/YDADG2x1aQO4U1+DcOTXlFcuI2N0D8dc7NyMnA6KJFHapOxzCZZDPOs4dgDD
 bIk8unXJHpKIIoR82n4HuRnYou/4l2/KSQdhD4loVDSuBAJBalZld1
X-Received: by 2002:a05:600c:8b61:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-48069c16356mr81024845e9.6.1769620211205; 
 Wed, 28 Jan 2026 09:10:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132356dsm8678756f8f.33.2026.01.28.09.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:10:10 -0800 (PST)
Date: Wed, 28 Jan 2026 09:10:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [REVIEW] common/mlx5: support dmabuf
Message-ID: <20260128091006.5284fcab@phoenix.local>
In-Reply-To: <CAJFAV8zWtmZX86h7U=tXxAss+1B7=Jpex9NgNkOA67ATTWyvNQ@mail.gmail.com>
References: <20260127174429.1504288-3-cburdick@nvidia.com>
 <20260127192146.169967-1-stephen@networkplumber.org>
 <CAJFAV8zWtmZX86h7U=tXxAss+1B7=Jpex9NgNkOA67ATTWyvNQ@mail.gmail.com>
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

On Wed, 28 Jan 2026 15:30:17 +0100
David Marchand <david.marchand@redhat.com> wrote:

> Hello Stephen,
> 
> On Tue, 27 Jan 2026 at 20:22, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > AI-generated review of bundle-1701-dmabuf.mbox
> > Reviewed using Claude (claude-opus-4-5-20251101)
> >
> > This is an automated review. Please verify all suggestions.
> >
> > ---
> >
> > # DPDK Patch Review: dmabuf Support
> >
> > ## Summary
> > This patch series adds dmabuf (DMA buffer) support to DPDK EAL and the MLX5 driver, enabling DMA transfers between drivers without proprietary kernel modules.
> >  
> [snip]
> 
> > **Warning: Missing version.map updates**
> > New exported symbols need to be added to `lib/eal/version.map` under the `EXPERIMENTAL` section.  
> 
> I noticed similar comments on other series.
> There is no version.map update needed anymore, since v25.07.
> 
> 

I know, there is nothing in the AGENTS file about it, not sure where that neuron is coming from.
