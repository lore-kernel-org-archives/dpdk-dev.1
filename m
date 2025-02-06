Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A94C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 02:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92AC94066F;
	Thu,  6 Feb 2025 03:01:18 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 219D0402F1
 for <dev@dpdk.org>; Thu,  6 Feb 2025 03:01:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 74A01203F582; Wed,  5 Feb 2025 18:01:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74A01203F582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738807275;
 bh=+La8z5Hci8cNqREbQ9W7mDK8BKaZc7YUpf+5C4TI4NQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QGdwmqXR1NHDFKcNx2EKESQaWfygDquMsY7wUbZHMi5tSPZWPlLiWsTG0zpTkGNGl
 /e0oUPDVQwxCLCdSVGtd2ApWid4LoOMJQdp/8bK5YmAzLgkZ/5oDyWR8xvT57qjE+4
 pDQaficDQAVpUGhSZQNDq+dp+wsqO13S4aNWi8io=
Date: Wed, 5 Feb 2025 18:01:15 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, thomas@monjalon.net,
 Mattias =?iso-8859-1?Q?R=F6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v21 18/27] test: remove use of VLAs for Windows built
 code in bitset tests
Message-ID: <20250206020115.GA22751@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
 <1738702638-22363-19-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zNk++o-P-QtQjkPDkQjb2=C=NfUxfgLVSSk1eSu+x3dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zNk++o-P-QtQjkPDkQjb2=C=NfUxfgLVSSk1eSu+x3dg@mail.gmail.com>
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

On Wed, Feb 05, 2025 at 05:35:26PM +0100, David Marchand wrote:
> Hello André,
> 
> On Tue, Feb 4, 2025 at 9:57 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> > @@ -168,10 +169,20 @@ test_flip_size(test_fun test_fun, assign_fun assign_fun, flip_fun flip_fun, size
> >         rand_bitset(bitset, size);
> >
> >         for (i = 0; i < size; i++) {
> > -               RTE_BITSET_DECLARE(reference, size);
> > +               RTE_BITSET_DECLARE(reference, RAND_SET_MAX_SIZE);
> > +
> > +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 110000)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Warray-bounds"
> > +#endif
> >
> > +               /* gcc is giving false positives here when code is optimized */
> 
> Why not simply alloca(te the right size)?
> 
> I tested with my gcc 14 (for which I could reproduce the array bound warning).
> By replacing with uint64_t *reference = alloca(RTE_BITSET_SIZE(size)),
> gcc seems to be less smart and won't inspect 'reference' and 'bitset'
> arrays boundaries.
> 
> 
> >                 rte_bitset_copy(reference, bitset, size);
> >
> > +#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 110000)
> > +#pragma GCC diagnostic pop
> > +#endif
> > +
> >                 bool value = test_fun(bitset, i);
> >
> >                 flip_fun(bitset, i);
> 
> The rest of the series lgtm and the plan is to merge it for rc1.
> 
> Just beware that, if you send a new revision, new drivers (net/xsc and
> net/zxdh) landed in main.
> Both use VLA, so both require cflags += no_wvla_cflag in their meson.build.
> 
> 
> -- 
> David Marchand

Thanks for the suggestion, and for warning me about the new drivers that got added.
I sent a new series with these changes.
