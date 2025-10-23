Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40DCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 23:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1426D40151;
	Fri, 24 Oct 2025 01:49:07 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id CBC9E40144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 01:49:05 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7a23208a0c2so1173405b3a.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761263345;
 x=1761868145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vBRapEAknEfCbe4xlxqekxrh+DMm5I9imVmUAiSmPqM=;
 b=1J6NWvEJcQB9efv1O1klorrCATaaEXrd3k0yoYB0cw8iXId2f38QzzYH6deBm3g8YI
 kOrkkkGIIlnBgtegABbTNe9mhSSQF5fn1fJL4uSPwU1hbIFdeoDLCNSbbmKLVZ2RPlf1
 KZBJ9/eqfchOte9f7A74XY7gTKPt1bsIDpEhjQ6+25TmnNwN8KcHHSyqFAuBeROn8Z3p
 ncb86Ki//wLR2HcVxhj4JhkMThaJjH6/JbeDgIgUwAyBrTdxVrz0QqI/dHn29FtYdsa9
 iSRzVjmzx0TNvk5fsqQg5Xxv6mXX2ZlO+yO8MrQpCM8lLdXph13HvKm2jH8uEpUU4oT8
 /LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263345; x=1761868145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBRapEAknEfCbe4xlxqekxrh+DMm5I9imVmUAiSmPqM=;
 b=Glm0cZL3PDsm/Ik6m5fZrTfqMPpGBIRg7Vchckvp+yo/rc+MB/ybwsRJuzJiVDzb65
 Yrki4xsUWz8B4IjU3vuDeKXs4MIvGYSgur2T/Tjd971Wbx0nJIKMd/aOo0FyWkMnPVV1
 ytvAlOr2dLWDNTtoplbkjuOwLOPDLSJ6ibE1EjQMag32vtimoEu26ahkOyWWc8J5S/Db
 EPmlBN6EJw+cZAryprXiqkO4TzArunOImKfa68kB/iKshuUOQ+GNs19gMyg7WIw7sWEs
 ExV8aJVC/H0HqFGU7lyLFkSOk1h6cZGcZZ5DPyLovRQ/wvPHe80cQKD/nhhWZS78P9Zj
 NTBw==
X-Gm-Message-State: AOJu0YwYyqNptjPtMfqSCLoEmlGlm3VfpMNdFxzfAoD2gTUfoJ2D4Mem
 Wv8W6KyiFmMSPXuaGuU7SnpTvP3GwXMGeVBHVz6MBsACUcPIlgIeqG9L4c93hFevsBt+8CsT0ql
 ifhhJ
X-Gm-Gg: ASbGnculJKjT+n4Q2APo/VYM/wYqtfKFQSryrLv0G8bvKjuwOpfd0OgPOZIPI6x9fCs
 Pyeivq/LjEexvLV15ptyVHzUHoZPoevwOWQywSwcaKYnjaF30qwZSjn5fpoLrndVZwOnzGfIigm
 UHykSxzHjurwJ9XiH4NYPJqUPqtMoNQpKhDx6zuYyE8ZIk+iLHym++zH4Qmbtr/QhVU434encHv
 QdfQoCMTVLtAliOotNFfk72Pa0ozVIyulsUJSuVGHi+H4h1CGxzmC6OFz0GTm22o+V2sJ8WDIPk
 HCB+Prtt4dJmti0QSjpwsUCBjAlbnKU01o/jpGjqPCraxn6EWrN8I6D51sS7AJOVj3rb6/56354
 dEGT7QxHCbechGhESAYRXdOz52s3sbmxkAMGS+l+y9PMh9V1wsQyxFJcB8CI5D41+UA6WW/vVx0
 oGQbMBvtp2Y8La4oworG/DfXiCPrfkdT8p
X-Google-Smtp-Source: AGHT+IH0OeUv9Q+iIo1Yi9kq+t0jcXtTWlp059YBZqJ3opJGF52guBH0rXSzNlP6Dqpf5alZi8gGqA==
X-Received: by 2002:a05:6a00:238b:b0:77c:64d8:3afd with SMTP id
 d2e1a72fcca58-7a220b214b5mr35215719b3a.28.1761263344831; 
 Thu, 23 Oct 2025 16:49:04 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274a9ce15sm3834440b3a.23.2025.10.23.16.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:49:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:49:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/8] avoid unnecessary use of comma operator
Message-ID: <20251023164902.1b8abb7d@phoenix>
In-Reply-To: <3190671.o2A3GueYyp@thomas>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
 <3190671.o2A3GueYyp@thomas>
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

On Thu, 23 Oct 2025 22:05:46 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 17/10/2025 17:02, Stephen Hemminger:
> > Clang has ability to detect suspicious use of comma operator
> > where a semicolon would have the same effect.
> > Easy enough to fix in DPDK code.
> > 
> > Stephen Hemminger (8):
> >   eal: replace unnecessary comma operator
> >   ipsec: replace unnecessary comma operator
> >   test: replace unnecessary comma operators
> >   app/testpmd: replace comma operator with bracket
> >   examples: remove unnecessary use of comma operator
> >   net/bnx2x: remove unnecessary comma operator
> >   net/bnxt: remove unnecessary use of comma operator
> >   config: enable comma warnings  
> 
> Applied, thanks.
> 
> Please could you open bugs for drivers having such commas?
> 
> 
> 

Ok done. The bugs are grouped into Intel, Mlx, and bnxt.
