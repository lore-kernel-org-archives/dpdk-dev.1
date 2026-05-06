Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EFCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D8D140285;
	Wed,  6 May 2026 19:11:48 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 952D940278
 for <dev@dpdk.org>; Wed,  6 May 2026 19:11:47 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so1009394c88.1
 for <dev@dpdk.org>; Wed, 06 May 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778087506;
 x=1778692306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYxThsPiocyfO987PXsalSnlr3URdRYaUEmXpmpk/g4=;
 b=xSHr7lbeqe42wPziq3kLFHY5aXDhcjsCeNgM9DxRmC3a8xV0dpzKdo6dwojWebbT9X
 kxPKh/B7gLCSoecBm+CR2QuldDnE+s1N9G2sqJzWb03VxHbJMLXTtPNwLgOIx9Jb/8ig
 IyxJhz0FyGmZA+1JYDTNFXIK4AwBxdz7Fvph2Jt7LJpiAD3wlnWBlYeTm8hy9IvRX17B
 JRZjFMh5N24vNmdUfeB8j83auh6alctG7WqLNQUEGWwvDz3xm9kOyWyKMuyzDwzCmzXv
 iVbKsUvQMahRjOIDdU2MnkYjDp52NcqW46mG3OIwId/YKGUgcLSXN2uY/IaGzmUtqUy8
 LPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087506; x=1778692306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYxThsPiocyfO987PXsalSnlr3URdRYaUEmXpmpk/g4=;
 b=ny7fsj0Ymd2iriR/eQj9+dEQ91pkQcdLzmBhWNWASCgjKwnuNcT0nsoIezyvPYJdGF
 qGdlvwAbDq9DP/FF6DKif6nqEwokZtVH4z7PS2f2FfgURXcX8f+WJidCrw0gwZhhINRm
 WcgkYXy8Of19LTCxRd2o0fJl3p1EMHcJwQGIpEIyKiv0wLbZmaklTvO90FOy1gl/XTBH
 Akja+YxJRSKtp3j8KcEVFQl4cAKcDvolFcWc9drzlRb66iCasoca3pJvslIp7MyrQczR
 e2W9N83b8YyycjVqeZ4Bgl9Xq8Dc6NwiqT65pDlxdssCeN45sJNE3RPbpHPPZvmlORMs
 3t0Q==
X-Gm-Message-State: AOJu0YxPnAjBYUH1eXIyqb02YMz1rlgQSoneelEbbtaIZZg6H8sLHRMC
 nuOh1qp9uyFGnx1yJl89iOHVpuL+fLPdqGdEfKbYtUi7+UkWbfgqgWBnUjbS0jMiz3Y=
X-Gm-Gg: AeBDievdoQOE3pdzOi40IGYE1cQijYOs//WpBPdkpci0Vd+wqpDjWX4bt/2dbnnryaP
 NhYjZUVxYry10zpPlij+NbZxO3CGF3NC0YkMRIdaWparFSgoL5ARdYKQW4G5B8i1KASFezJdckx
 L1MUa8PmXu3GQX2J3M1mjmTzAOPBeucP8QZ4OhszNMxJvFQAO5FkC88+bCcHIvRFYrXWZJipcKU
 gyXY11Hm4M/JbKhXGgxcyoQbixRklUxWuq0ZQCpxkmsGQWFSJEDDoS0IDw6gcb/5H1b3QL9AnMV
 U848OqUruuLCEb1sJrefe154XWzUaJ1NdoMEhOWwyktOwntSFOntt81ICWvJ0jCBJ1jo2hOpBXS
 87r+/FA7qhe+UE/pE/ZPfht6BHzigwB5JFwCVaDWw8gi9S4KuyzFC4IJjgePT1i+Kjybxbk3Weg
 9C3J5E3GTz2d8Lq7er2HXufmeaWquThfebudg8u1zV/iVJJA==
X-Received: by 2002:a05:7300:2323:b0:2ca:bd22:6102 with SMTP id
 5a478bee46e88-2f3d0cc9abfmr4155585eec.14.1778087506180; 
 Wed, 06 May 2026 10:11:46 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d8c45acsm4703999eec.13.2026.05.06.10.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:11:45 -0700 (PDT)
Date: Wed, 6 May 2026 10:11:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Message-ID: <20260506101143.7f7343a5@phoenix.local>
In-Reply-To: <aftkrgIfFPNUpbE2@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <20260506033338.480610-2-stephen@networkplumber.org>
 <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
 <20260506084632.5cfc676e@phoenix.local>
 <aftkrgIfFPNUpbE2@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 6 May 2026 16:56:30 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, May 06, 2026 at 08:46:32AM -0700, Stephen Hemminger wrote:
> > On Wed, 6 May 2026 09:06:22 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >   
> > > > 
> > > > Dependencies are limited to rte_ethdev and rte_net; no
> > > > librte_cmdline, no flex/bison, no platform-specific headers.
> > > > The grammar follows testpmd's syntax so familiar rules carry
> > > > over and is documented in the programmer's guide.
> > > >     
> > > Was there a particular reason to avoid using flex/bison here, or did their
> > > use just not make sense? In general I would prefer using code-generation
> > > tools where possible rather than maintaining (metaphorically) hand-written code.
> > > 
> > > /Bruce  
> > 
> > As long as we are willing to accept flex/bison as build dependency,
> > it would make sense to use it.  
> 
> Google search points to https://github.com/lexxmark/winflexbison as
> available ports for Windows, so I see no issue with making these build
> dependencies.
> 
> /Bruce

Right, I am pushing AI to use flex/bison.
Surprisingly it is resisting; showing a bit of emotional ownership to the code
which is both humorous, odd and scary.
