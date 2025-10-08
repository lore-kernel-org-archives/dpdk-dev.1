Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA2CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 07:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F0A4060A;
	Wed,  8 Oct 2025 09:53:05 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id D710E40297;
 Wed,  8 Oct 2025 09:53:04 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 5DF92EC0575;
 Wed,  8 Oct 2025 03:53:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 03:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759909984;
 x=1759996384; bh=5JhArw4hmvjpnGtjj7hxDeMvVEG6eEnW57MMG+8gTNw=; b=
 IHR7LYZKznxMj+vI/oselLsWZ9aHEeD0Xsp0Id1C5ceS4WO4iKi2YO9VX7MGLYVV
 YV9nKLdKkCLMAHFaoY0uZSfKmJs7Ib6jbSkAjp7lt3abqjylPWfydhPSqad8vcMK
 RGFH5VrPK7ySljrlYRtP0YgbfAvLPEJzW/q8HY1EHvLzD/oRY7Js6UHgVmntiTy7
 QB4VKtlDkoSjgIfFB0v1D82oYVWVd+oNZyQ/wMgy49Q/AiA6dDiCrRZjBEyzsQnK
 by59zSIYSeupAJqGBkXWY9ZquLCa/L+8gkaeSb5OSi7X0THyno8d+pR1+4ZBJ72t
 uiOzP8XyZbl2VYRM11cKWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759909984; x=
 1759996384; bh=5JhArw4hmvjpnGtjj7hxDeMvVEG6eEnW57MMG+8gTNw=; b=Q
 AnHirPGm9ougiRkyfEGsG1ZzaIfHyYAsGYvV21vo3zhztFp9voCf9rZffrseNufC
 dMORZrYhZRPCzJow1d71WqY3FOtLdRWA2I6RpLGmjUr6lJudIVY7eqUj5i5/BbDJ
 OVdDoNVb9ABhgU+DY8YcvtwdjVSdY/Jn8xTEMaWfzQl/TRdFPoquKfzLEW/jC8sL
 EimV/VxXQpRIRNlEwh91OHkl1gyAcibVaP/fic+peAJ1G+PRYubFHpnOty3DOuOX
 Qu+lGgQJMpx6CBTRAY1jWGfvrbtyILQZ7GgvgWTTQakNLFwlv8aBaxciVSi1q8yo
 QZXuZg3mhpY7CFBveGIkQ==
X-ME-Sender: <xms:XxjmaPNKZEqxykreZFlBfZPqEaOz-loRCJzLAjnRQu-SbGctlMFrtA>
 <xme:XxjmaC6VCp6m30ogUApKmtNAlT27qKSyQMi8PDUj5S7Kajo_Iwb9ML57oU260MWAZ
 YmjCWJ0yDJZJiHq8fcOevUcn5JIgwbtERtFZ5od1VZtb-VZdSQgI5Q>
X-ME-Received: <xmr:XxjmaJ0gKo1yjFJ3l9ndyKzh9oCZQ3TjXGtK8aUbaz3pMB5TClZ4MWAczrvFuZG-bODtRoUaubDCW2TsHGZl2OoLhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvjeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehi
 nhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 thgvtghhsghorghrugesughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmhgrrhhtsh
 hhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:XxjmaDwyaiI__NOJ6wF1POi8BlQ1ejg_nH8VM46_NKitotZ0Upha6w>
 <xmx:XxjmaDumbLDAf1PORZQzuUXPbF4RilV9wvr84lewBmKH1t6laER6Uw>
 <xmx:XxjmaNw47QeDc5VEa8bpvzUl1pGs75bVkXHyFAm4waF5INyJ5qn6kg>
 <xmx:XxjmaOCsXBpX-e3-H8cQxVThRCpk6VtA9Jl4J-YzABlXK6mkiK8GjQ>
 <xmx:YBjmaADldYzbmulLmvPwgs3brbSaVHamz7_ISzbv_jrNiE_kUuHHWxzI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 03:53:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 dpdk-techboard <techboard@dpdk.org>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v9 00/18] Simplify running with high-numbered CPUs
Date: Wed, 08 Oct 2025 09:53:00 +0200
Message-ID: <4032978.kC03pvyZki@thomas>
In-Reply-To: <aOU8qESdjcs7Qkqi@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
 <aOU8qESdjcs7Qkqi@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

07/10/2025 18:15, Bruce Richardson:
> On Mon, Oct 06, 2025 at 04:10:52PM +0200, David Marchand wrote:
> > On Fri, 3 Oct 2025 at 10:15, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > The ultimate of this patchset is to make it easier to run on systems
> > > with large numbers of cores, by simplifying the process of using core
> > > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > > shortened to ``-R``, is added to DPDK to support this.
> > >
> > > However, in order to add this new flag easily, the first dozen or more
> > > patches rework the argument handling in EAL to simplify things, using
> > > the argparse library for argument handling.
> > >
> > > When processing cmdline arguments in DPDK, we always do so with very
> > > little context. So, for example, when processing the "-l" flag, we have
> > > no idea whether there will be later a --proc-type=secondary flag. We
> > > have all sorts of post-arg-processing checks in place to try and catch
> > > these scenarios.
> > >
> > > To improve this situation, this patchset tries to simplify the handling
> > > of argument processing, by explicitly doing an initial pass to collate
> > > all arguments into a structure. Thereafter, the actual arg parsing is
> > > done in a fixed order, meaning that e.g. when processing the
> > > --main-lcore flag, we have already processed the service core flags. We
> > > also can far quicker and easier check for conflicting options, since
> > > they can all be checked for NULL/non-NULL in the arg structure
> > > immediately after the struct has been populated.
> > >
> > > An additional benefit of this work is that the argument parsing for EAL
> > > is much more centralised into common options and the options list file.
> > > This single list with ifdefs makes it clear to the viewer what options
> > > are common across OS's, vs what are unix-only or linux-only.
> > >
> > > Once the cleanup and rework is done, adding the new options for
> > > remapping cores becomes a lot simpler, since we can very easily check
> > > for scenarios like multi-process and handle those appropriately.
> > >
> > > V9: rebase to latest main. CI complains cannot apply v8 patches.
> > >
> > > V8:
> > > * dropped the final two patches from the series, dropping the new -L
> > >   option in favour of the -R modifier.
> > > * reordered patch 11 to be with the other argparse patches (now patch 5)
> > > * added patch 12, which uses macros to initialize the args structure
> > >   from the arguments header file, avoiding potential issues when we add
> > >   new args.
> > > * simplified and consolidated lcore mask and core list parsing to always
> > >   work off cpusets rather than arrays of uint8
> > > * enhanced debug printouts to also work better with cpusets and handle
> > >   core values in those sets >= RTE_MAX_LCORE
> > > * for completeness, ensure the new -R option works for coremasks, and
> > >   for cases where no explicit core-list or coremask is specified.
> > 
> > I was planning to merge the first part of the series (before reaching
> > the cpuset rework and addition of remap option).
> > 
> > I am facing two issues for which I prefer other's opinions.
> > 
> > 
> > - First, I see a change in how non-option arguments are handled with
> > the switch to argparse.
> > $ ./build-mini/app/dpdk-test --no-huge -m 2048 -l 0,1 func_reentrancy_autotest
> > ARGPARSE: too many positional arguments func_reentrancy_autotest!
> > 
> > Passing the test name after -- does work, but it was working without
> > -- before the patch, so we are introducing a regression here.
> > 
> 
> Looking for input on how much we need to handle here.
> 
> The quick patch below adds support for ignoring trailing args in argparse,
> which means that the command above would work. However, gnu getopt also
> does argument reordering which means that this command works right now (on
> linux anyway):
> 
> 	./build/app/dpdk-test -l 0,1 lcores_autotest --no-huge
> 
> since getopt moves the lcores_autotest to the end.
> 
> Is this behaviour what we need to emulate too, or is adding a flag to
> ignore trailing args sufficient? [I'd tend toward it being sufficient - mixing
> app args and EAL args together is not a great idea IMHO]

I am in favor of being tolerant.
I agree mixing args is not a great idea,
but rejecting them is not really kind, and is a regression.



