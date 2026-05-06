Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D3FCD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:46:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B584026D;
	Wed,  6 May 2026 17:46:37 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 18E994026D
 for <dev@dpdk.org>; Wed,  6 May 2026 17:46:37 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2ef38cf04f0so7264400eec.1
 for <dev@dpdk.org>; Wed, 06 May 2026 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778082396;
 x=1778687196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrbBWMUHyJj8PEz0T8A4tGhmgDvaPx4P90le+68hr4I=;
 b=G3IANxjc4GQK02Mx+Xdh4j+ETZ28TCYQPhSwEsWbuVdHYLTRCiAjhpH0rTY2YQmMph
 IsvFWe7gitoFIa1+MqyM1UZDj7mXkwwTutubZdzpw7rgOUh73eh8x8AY92cqNpiyrJfL
 xsmR2cEe27dVBThs/PjRRHZ5illtjYfVwnYEy7Ol6KjkzMToEW8FSeN/TMmqjRF1wEpo
 Mm4zJU1JgF6Yz03wCdRGCbV0rlsPDZR9dGJEvn27dSdkoCnRsoPsqWD9/0Ft461Lgl0q
 v0riYQoJQlZrHu30wbOP695LASxpkhTuF13Y2YJYmapP+9DlMHx8Y7IajzCMk2Plib/P
 u9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082396; x=1778687196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrbBWMUHyJj8PEz0T8A4tGhmgDvaPx4P90le+68hr4I=;
 b=o7lbF/3TiOqzJotKABIRNVRRhdVFGRnDhMoOoQz8xdeUPjUu4OSCTCs4/0zGbyoCkk
 97SFeb2beCgLSw9Ktc+LvibqzgE811pZJxoH0MOMIUWUzF0ljt0d8F2kClodbFH7+AKJ
 +HSMCyQus/uthxKmY5aRXyZJ0v2RDDf65ILN2uNpjvH0ZfFSBx2CY6jV2/P5vG/oobLv
 Tdz5sEOKwyZLg6tueiiHpLPn9JzXnTuBh4+ljNi5CkMVssn/246NYNDXEEJweSGLSsk/
 ZlaY8vOPyRyvDD4AwuZssZNreANYUKYctCr3eu9Nh8dlyIzYBgfqprWe4OT70aKBbX6s
 Ai5Q==
X-Gm-Message-State: AOJu0Yyt8e9oZ/7OX+q4eQu/MIEblDW0ckFTvlAnrnGOwcl+HDMWmsQv
 4v4ZjXrIxl22By0G75Gn/YoBsYpfefxPO2ug9VkkxeH+YNgdZQkZWeDD3fTB2OdJ1tg=
X-Gm-Gg: AeBDies1bPgA4cUzFAfMKg5leAKgmnUVmI61+XDA0X/ZXSU//YN1E90k3hxo4v9fFOU
 HeQR8NMHcAUBI3HP6hk0AqXV9KQbjMYjM+pr8b5AxqXoBJtxKl5gy71tuYHKLDLpYzDyBHj4ko+
 P1M0YQ+nzy5tqiFARr1cXIFNEp81lMAtzLfzvy9YF1VeQn+hKzPWyCemBX2m3mLbMuMzA+VNkEs
 dAuoqK9uIdWhge+q3n6n5qleyOK2SZRVjEPfU+mBwF1isTjT+Gn4A5QpDgnCCkjMc9ss2OxUT4M
 d8HqFPBZl1dAhXmousigW5uyzF+MPC1pAdcFUq330vVkrr7qq4XizizSEeYLLI6Y+UohE6gkyd0
 RJGCQo4ssw5LPyOn5UKuaSZD5L3pXyHcq61whLYUR80FeNMmMjvqhl27MBnCIIacij47VOT3oaV
 9adhLPPmMWXmRH4tCBM+TEhBdzI94igHC5c6HtSyKipy7cwg==
X-Received: by 2002:a05:7301:38a3:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-2f54a38a0femr1825334eec.23.1778082396010; 
 Wed, 06 May 2026 08:46:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec593dsm4313010eec.6.2026.05.06.08.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:46:35 -0700 (PDT)
Date: Wed, 6 May 2026 08:46:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Message-ID: <20260506084632.5cfc676e@phoenix.local>
In-Reply-To: <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <20260506033338.480610-2-stephen@networkplumber.org>
 <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 6 May 2026 09:06:22 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > 
> > Dependencies are limited to rte_ethdev and rte_net; no
> > librte_cmdline, no flex/bison, no platform-specific headers.
> > The grammar follows testpmd's syntax so familiar rules carry
> > over and is documented in the programmer's guide.
> >   
> Was there a particular reason to avoid using flex/bison here, or did their
> use just not make sense? In general I would prefer using code-generation
> tools where possible rather than maintaining (metaphorically) hand-written code.
> 
> /Bruce

As long as we are willing to accept flex/bison as build dependency,
it would make sense to use it.
