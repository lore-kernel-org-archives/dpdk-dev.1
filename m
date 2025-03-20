Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A14C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 15:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DF1C402AF;
	Thu, 20 Mar 2025 16:06:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D2C0D4028A
 for <dev@dpdk.org>; Thu, 20 Mar 2025 16:06:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2701B2116B51; Thu, 20 Mar 2025 08:06:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2701B2116B51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1742483203;
 bh=KVSX5BTIVC/yKnA8hmWhQWOY3iwfRaZUaaWUYu3Z4L0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KK/SjbuoXNSPKRLaYUuxMkrcICR8ni50j9Cotqh15muf2oE7iPOsGzjL+aESmgG8n
 3sDddiCvoC7xWqsGC4doUnlYkKJT5Tl311B9lkRM1t6yKmu91YTFbD7q01Jy5dAIBo
 A8TgpggpNJLmVJUFai43cWJawHgWLU/XgXogOb5c=
Date: Thu, 20 Mar 2025 08:06:43 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 thomas@monjalon.net, bruce.richardson@intel.com
Subject: Re: [RFC v4 5/8] build: generate symbol maps
Message-ID: <20250320150643.GA18308@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <20250317154308.2782689-6-david.marchand@redhat.com>
 <20250319091912.3b14713e@hermes.local>
 <CAJFAV8wnNCqWmuz5Kw9097BWE51GiiBmypJca71dMm5=WmBgyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wnNCqWmuz5Kw9097BWE51GiiBmypJca71dMm5=WmBgyg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Mar 19, 2025 at 06:12:37PM +0100, David Marchand wrote:
> On Wed, Mar 19, 2025 at 5:19 PM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Mon, 17 Mar 2025 16:43:01 +0100
> > David Marchand <david.marchand@redhat.com> wrote:
> >
> > > Rather than maintain a file in parallel of the code, symbols to be
> > > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> > >
> > > From those marks, the build framework generates map files only for
> > > symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> > > becomes unnecessary).
> > >
> > > The build framework directly creates a map file in the format that the
> > > linker expects (rather than converting from GNU linker to MSVC linker).
> > >
> > > Empty maps are allowed again as a replacement for drivers/version.map.
> > >
> > > The symbol check is updated to only support the new format.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > > Changes since RFC v3:
> > > - polished python,
> > > - fixed doc updates not belonging to this patch,
> > > - renamed map files,
> > > - changed msvc->mslinker as link mode,
> > > - added parsing of AVX sources,
> > >
> > > Changes since RFC v2:
> > > - because of MSVC limitations wrt macro passed via cmdline,
> > >   used an internal header for defining RTE_EXPORT_* macros,
> > > - updated documentation and tooling,
> >
> > Looks like a good idea.
> > Is there any way to make symbols in drivers local by default?
> > Right now if a driver defines a non-static function it will
> > be visible in other code when DPDK application is statically linked.
> >
> > This can lead to problems where exports are missing or accidental
> > name conflicts. Gcc has -fvisiblity=hidden not sure about others.
> 
> This could be interesting, though it is a step further the current series.
> 
> 
> - For clang, I would expect -fvisibility is supported.
> 
> - There is one warning I am not too fond of, in gcc manual:
>            Be aware that headers from outside your project, in
> particular system headers and headers from any other library you use,
> may not be expecting to be compiled with visibility other than the
> default.  You may need to explicitly
>            say "#pragma GCC visibility push(default)" before including
> any such headers.
> 
> I also see that this requires annotating symbol at the declaration level.
> That would require to parse headers instead of sources (which seems
> more appropriate as we are talking about symbol exports).
> 
> I have some doubt though wrt base driver code, that we are not
> supposed to update...
> The current RTE_EXPORT_* macros of this series were not doing anything
> to the symbol themselves, and could be located anywhere as long as
> meson could parse them.
> 
> 
> - Not sure what the default for MSVC is, André?
> 

My understanding is that "-fvisiblity=hidden" only has effect on dynamic linking.
For static linking a similar goal can be achieved with ld's option --exclude-libs
(https://sourceware.org/binutils/docs/ld/Options.html).

The default for msvc is hidden. Only functions that are explicitly exported
with __declspec(dllexport) modifier or through a .def file are visible externally.

It seems this matches exactly the behavior you would get by using -fvisiblity=hidden
with gcc/clang.
--
Andre Muezerie

> 
> -- 
> David Marchand
