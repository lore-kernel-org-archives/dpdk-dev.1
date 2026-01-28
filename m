Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F8D46BE5
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 115804026F;
	Wed, 28 Jan 2026 18:43:58 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id CB36B4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:43:56 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so110747f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769622236;
 x=1770227036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNtMkhII9OHUv7PV1b5hBnUf9Q3/BFwLtjzng9QOKgE=;
 b=cywfnpJLoD7qMnqkhF6YakjJ3Z0BPLhQQppFdfkh5eDCuNqszintzfsg7XFgrTjFOt
 yjExhEnnks27mG+RpzkxrwtbKHh0IXS4nyRR8hThngDEuPuhSDePOkXnznINyhWRjabK
 ESqF/1PTINC6M/kL5bmTKExb/coL+pg60JKUKEOF8wK79RJRkIWJn6V5ruDcAwb/GTsX
 lKbIHDfpIp8/1n4fwL8uas3KbN4koHyUUeKyKJA3OPaL7CiNU3FuSwFOLPRSy2IZiXh5
 T39s9gTefZhMUh0HirS55yD+ok7H/CHG/7CN3LNAosg1aWT0ShlgDcH3IwrvnOMUIEBJ
 4hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622236; x=1770227036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNtMkhII9OHUv7PV1b5hBnUf9Q3/BFwLtjzng9QOKgE=;
 b=fljYMgyeLp5YZqYnVru4M/M4Kvxh58g0zadCSDBz8zR06fhgUq9ImrCK62hQ+l6Ysq
 qREuq+Ffe5bOXdN+RtLseSZUsy2bTY11ccs1yBKRvNcKs9YYvZ1TDXmf6Bf4XofrKtSl
 iJQ+VKHbN+9bZYtW8AcR5gegcq5NB6K3gaPuDuF41g8LMkLy93Pzo5V23Yl3hcU3A+cN
 RFX6IxX/JG1j7uQqEta5lsgF05DQLTV8NPaA3J9ZUc9aznOxKB/fuzJaxWN4HnxhDdpQ
 ouJsHugO4GXGligE9n6iRBzM+G08vxGfH3UFAYDk9I+hID8kxHVJBCaQRwl/Lr7i7jCu
 HkCw==
X-Gm-Message-State: AOJu0Yyre2v5Z9KljrQAM5gGIDZMbc6uMEJZ5seX/CQblIdyCkVJjNUM
 /Aii1oJ9zLMnCHIsECMqZQEzeLZlFp5LNy9mHhHJ+M4KValsDoXcEhZHNLSNKyauudk=
X-Gm-Gg: AZuq6aJJzIw+ZBb33qbKVMANw/XL5HwZlGJYJ48L2w7nyczUlEoU6cqAh7OywnYrsZV
 FhSRO7hwjml2Aczw/9C/Zd0MeOUQfFV/uGuQ0BoTcZY7XLaNMjvUwab34/yPV1VncB+M/ukUj4O
 9Pmzmc3ZfHy6D24unZ2mnfQat0XH7anTk0e16+XqUQ9pp2yL6Dd4OFmCMjvpIJyLEiW6iXrjSf4
 RfioT5qLZjJPfbfaLQAHKKCCVYTVTbJLT9UO0pq8XRFaAAC9UJu8PGxX2WmiR8mff4V33Q3Giur
 00az18XOa1jnB3cyktjPn7qUnivkavyCE2E6Q3mI+Po+TpCSwNhm0ryk0eaFGJce5nl7EywxxAc
 9KKEirWuAXqIndd6yVxr58Qg0EJGxsfhVsDT/91dwfbKdWqmBCoV/LMDw6lOamp7O7v6IWRLxNB
 wlKPfExnpsDwGnSd0An+yJSNXAWlQJI3AFMsNI6o0Fc/tRsPiobjuQwMu/0FkkysE=
X-Received: by 2002:a05:6000:178f:b0:435:abbb:fa77 with SMTP id
 ffacd0b85a97d-435dd030421mr9375665f8f.20.1769622236393; 
 Wed, 28 Jan 2026 09:43:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e474csm8638944f8f.2.2026.01.28.09.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:43:56 -0800 (PST)
Date: Wed, 28 Jan 2026 09:43:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [REVIEW] common/mlx5: support dmabuf
Message-ID: <20260128094350.1224b08c@phoenix.local>
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

I got AI to fix itself :-)

Now I understand the issue. The AGENTS.md says "New external functions must be exported properly" but doesn't explain the current mechanism. The AI is filling in with outdated knowledge about version.map files.

DPDK has moved to automatic symbol map generation using export macros. 
