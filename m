Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD8C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:02:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6FB640289;
	Thu, 13 Mar 2025 00:02:29 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3239740144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:02:29 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-22359001f1aso8528695ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741820548;
 x=1742425348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myjk8ut7k56J73Kh0PELDnP1QPgt7KWTgYnZBN7iqGk=;
 b=ZWvmQpqSOLnePkESl+tu+kQbfbbWnjkX4dg30xJqLioJ7CpCACsuyceNVIXPJ5y9ks
 y+S0ZeOx48qp/XWR65hoYynjch0CI5Kvcwf0386cwF2XTadW/AiOf4Pxf5GDhGbNaeDb
 66PnDWK7K5uiiUIhaqrbSizdTmDMj2snF3h2IFEGSg30M5AekOqU8aSWWm+xxZz7UFTN
 K8VY7aeCBBAqWbrdyRBfwOQy8NeX7/QkV5WLlMldhXVBFM9nHrKYQAFeNtQhNn24eyU5
 r3+/60BTPLw7aVKyKT10wM/EH6aFEnhdjXJ0GHQFH1ro7+A9ASigntZA1bZvibYYC2DE
 aWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741820548; x=1742425348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myjk8ut7k56J73Kh0PELDnP1QPgt7KWTgYnZBN7iqGk=;
 b=jsxvXo8gpT55Xyo0XS2hOjhSJ+8unItWt8y+x4dYp9XMfoOZlXKSZaHXHBUQr/EY0K
 iIwCVehGxtzKUePhJerbdweUfVfvwZGAcNkPcqET4WpCReD1phSrciFqhoT8mIad+Nam
 xs0a86n2pu6gwpVpM33rmVLgOK7KAb0gWPtZjRFRQvPhtQhvl2eT8qLAq+ZkOB1I+F3h
 DF7zPrMZEHX5j0X5k1rWaHCnbVri4tJgXZHXZCo8LbcKTVsux4sLZu/1OpveTdvl/X+M
 rw4g8cAMjrBMbUUU83EFCD2v9q3itB4cXjTQsk8wJ+u2u+eNgdoHK7v8ronkfQsqczes
 /EoQ==
X-Gm-Message-State: AOJu0Yzp3Amcrmdiut83OT7OTZSfRbJi0JYod7+3nFpFfwks/R3q8RBr
 LJyAknJD6qRi1ZE88f3qPCBaySBmkM5i4GG7eD5zwMTrM+y+rlYudBA8RssSFJU=
X-Gm-Gg: ASbGnctG8RYXHpn+DOpPwC6OKcZ5hiLHltcgsRsswuXA0PhnoQZgjAaYeCcAKuXIHHc
 fEdvSdjnVlt/F+4G8ZtHS3AsFXX4uVUPZEP1Xp/y1svUFyPfyEcW3GGqNGFeFfuJVVH++5/oHFW
 q9AcISWiiraDGVx/B08mb4rMvGAwDSqS/TuIUlXtaTDNLZr7Rk+fdHGLMkEyGWGydNnq4LOoiwL
 YnULeSsadFrnTbIPtNj1SypW9hm8IIsqxwPGNG4Cw2oUvOvlRChYCD9J6G0jUErhB3lwtHz74ks
 bjsjf2NgVhv5NdVXLAkiRx+mjhO/SIfuaYB9g+zYzAig1Ge2FBgvHImAYzxh/Ap236h8VWF4Msr
 HV92auvuVi0baof55CktX0Q==
X-Google-Smtp-Source: AGHT+IGYa++S1ZOMCzS3ucHGmoJPgROs6F84L7eQukdZuxQM9fFfn3t4f4lPK1zODFrGGn6+4r7cUQ==
X-Received: by 2002:a17:902:ce0a:b0:223:fd7f:2752 with SMTP id
 d9443c01a7336-2242899463dmr368708055ad.29.1741820548109; 
 Wed, 12 Mar 2025 16:02:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbe7ccsm866545ad.174.2025.03.12.16.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:02:27 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:02:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Message-ID: <20250312160225.2d90e78a@hermes.local>
In-Reply-To: <12279496.nUPlyArG6x@thomas>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-2-stephen@networkplumber.org>
 <12279496.nUPlyArG6x@thomas>
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

On Wed, 19 Feb 2025 15:55:17 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 14/02/2025 18:20, Stephen Hemminger:
> > The Linux version of sys/queue.h is frozen at an older version
> > and is missing the _SAFE macro variants. Several drivers started
> > introducing the own workarounds for this. Should be handled in EAL.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> We may want to unify with lib/eal/windows/include/sys/queue.h
> 
> 

Not sure, we have several options here:
  1. Keep using Linux sys/queue.h and add enhancements in rte_queue.h
  2. Make rte_queue.h a copy of FreeBSD version of queue.h (that is what Windows did)
  3. Use the bsd version of queue.h.
     On Debian/Ubuntu this in libbsd-dev package and referred to as bsd/sys/queue.h

I chose #1 as simplest. But all of these could work. #3 means DPDK has least new
code, but adds another dependency to the build.

No matter what, should add to checkpatch to block any new files that include sys/queue.h
directly.
