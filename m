Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B5C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EB2F42D80;
	Wed,  4 Jun 2025 15:56:26 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4D6FB427DA
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:56:24 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 54535201FF2D; Wed,  4 Jun 2025 06:56:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54535201FF2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749045383;
 bh=g5RhDBpKzBtRNNmGAqr0BNEHRnf/g+QZrkSp8iWILrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CHfxwyNgZfxh8y4IxQCpsF+U36L4zxZmf5Qg8D8BVJUYNv26Aq1kIcsHNiWVPUruu
 aLakJ1tdncq37A3Siqfv6/wqJsOGiHHlrwaRBUvboVbygHc6iezc1HcHGnWur2TteJ
 R06dOU/R9Bjkj9xw/eh65zWWYBMrrAfchma65lso=
Date: Wed, 4 Jun 2025 06:56:23 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/4] allow pmdinfo to be inserted and parsed using MSVC
Message-ID: <20250604135623.GA4412@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <20250603010127.GA30135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAJFAV8xoy+Tuk-mOi93W6bo=0Su2Q-cPy5vjoZ6i4U9N0BkGZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xoy+Tuk-mOi93W6bo=0Su2Q-cPy5vjoZ6i4U9N0BkGZg@mail.gmail.com>
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

On Wed, Jun 04, 2025 at 02:03:56PM +0200, David Marchand wrote:
> On Tue, Jun 3, 2025 at 3:01 AM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > On Wed, Apr 16, 2025 at 02:44:54PM -0700, Andre Muezerie wrote:
> > > DPDK uses GCC attribute "used" through macro __rte_used to indicate
> > > that a variable not referenced in the code should be assumed being
> > > used and therefore not be optimized away. This technique is used to embed
> > > information in the binaries, by having crafted information stored in
> > > them.
> > >
> > > MSVC offers similar functionality, but it differs significantly: MSVC
> > > requires a pragma to be used to send a command to the linker telling it
> > > explicitly the name of the symbol that should be included (even if not
> > > referenced). As a side-effect, variables called out to be included cannot
> > > be static, otherwise their symbols are not "seen" by the linker. This
> > > restriction requires some DPDK code to be refactored.
> > >
> > > Macro RTE_INCLUDE is used in this patch to ensure these special variables
> > > make it to the final binaries.
> > >
> > > The elimination of "static" for some of these variables caused name
> > > clashes when __COUNTER__ predefined macro was used. As a workaround,
> > > predefined macro __LINE__ was used instead. However, when __COUNTER__
> > > was used directly from a header file, __LINE__ had to be used from the
> > > .c files, otherwise it would also not result in a unique symbol. This
> > > required a parameter to be added to some macros so that the __LINE__
> > > could be passed from the .c file to the macro defined in the header
> > > (which was originally using __COUNTER__).
> > >
> > > With this patchset commands like the one below provide the same JSON
> > > output as would be obtained on Linux.
> > >
> > > python usertools\dpdk-pmdinfo.py build\app\dpdk-testpmd.exe
> > >
> > > v4:
> > >  - limited the use of __LINE__ to the header files, reducing number of
> > >    changes made in previous versions of this patchset.
> 
> Open question, since the submission of this series, __rte_used is used
> in the new symbol export macros.
> It seems those macros are not affected by the problem you described
> (and fixed with RTE_INCLUDE).
> Is it because the symbols are explicitly listed as exported?
> 

Correct. When using MSVC, "__rte_used" is stripped away by the preprocessor
and therefore has no effect. All required symbols need to be explicitly
listed as exported, otherwise the linker will complain about symbols not
found.

> 
> -- 
> David Marchand
