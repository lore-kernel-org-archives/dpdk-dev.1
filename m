Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F6AC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 15:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0037E40275;
	Wed,  5 Mar 2025 16:46:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4DA524025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 16:46:10 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 79F56210EAE1; Wed,  5 Mar 2025 07:46:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79F56210EAE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741189569;
 bh=aoVfg1kR1eNgUT1003i3Ab0lE1Z9kIeAAy7QHrIg7m4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eic1C+hFmUg+WQo2UZlDzeCw0anIM0I9Ic0QIf4KhpApMmYMMRy/wLPZaQ8T97hpT
 v1oKKWIiUYwxcZrzQag4W2qFGMvAFe7jZtVbfbtbpiR5KROjEyPTIpqHpLjFPztii4
 2Wo/EcVbnYhAPukYMCwOTvDVvqoRstUNJDH1T1NA=
Date: Wed, 5 Mar 2025 07:46:09 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2 2/5] lib/eal: add portable version of
 __builtin_add_overflow
Message-ID: <20250305154609.GC13013@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1735936781-24199-1-git-send-email-andremue@linux.microsoft.com>
 <1735936781-24199-3-git-send-email-andremue@linux.microsoft.com>
 <Z3u5Xw-tNSrKQ8O1@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9F995@smartserver.smartshare.dk>
 <Z3u_uo_S4Ldz6LWR@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9F996@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9F996@smartserver.smartshare.dk>
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

On Mon, Jan 06, 2025 at 12:58:44PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 6 January 2025 12.34
> > 
> > On Mon, Jan 06, 2025 at 12:21:39PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 6 January 2025 12.07
> > > >
> > > > On Fri, Jan 03, 2025 at 12:39:38PM -0800, Andre Muezerie wrote:
> > > > > __builtin_add_overflow is gcc specific. There's a need for a
> > portable
> > > > > version that can also be used with other compilers.
> > > > >
> > > > > This patch introduces rte_add_overflow.
> > > > >
> > > > > +/*
> > > > > + * Function that allows performing simple arithmetic operations
> > > > together with
> > > > > + * checking whether the operation overflowed.
> > > > > + * Example of usage:
> > > > > + *     uint8_t overflow;
> > > > > + *     uint16_t a, b, result;
> > > > > + *     a = 1;
> > > > > + *     b = 2;
> > > > > + *     overflow = rte_add_overflow(a, b, &result);
> > > > > + */
> > > > > +#ifdef RTE_TOOLCHAIN_MSVC
> > > > > +#define rte_add_overflow(a, b, res) _Generic((a), \
> > > > > +	uint8_t : _addcarry_u8, \
> > > > > +	uint16_t : _addcarry_u16, \
> > > > > +	uint32_t : _addcarry_u32, \
> > > > > +	uint64_t : _addcarry_u64)(0, a, b, res)
> > > > > +#else
> > > > > +#define rte_add_overflow(a, b, res) _Generic((a), \
> > > > > +	uint8_t : __builtin_add_overflow, \
> > > > > +	uint16_t : __builtin_add_overflow, \
> > > > > +	uint32_t : __builtin_add_overflow, \
> > > > > +	uint64_t : __builtin_add_overflow)(a, b, res)
> > > > > +#endif
> > > >
> > > > For the gcc version, can you just simplify to the one-line below?
> > > >
> > > > #define rte_add_overflow __builtin_add_overflow
> > >
> > > Yes, but then GCC compilation would not fail if "a" has some other
> > type than the four types explicitly supported.
> > > I prefer keeping the method used this v2 patch.
> > >
> > Is that really a problem? Should our DPDK macro not support all the
> > types
> > that the GCC builtin supports?
> 
> The DPDK macro should support all the types that both MSVC and GCC supports.
> Using _Generic() for GCC is an improvement for the CI to catch MSVC incompatible code when building for GCC.
> 
> Only these four unsigned types are supported by the x86_64 intrinsics.
> I don't think we need support for more types; but if the need should arise, it can be added later.

Great. Let me know if any further action is needed on this patch.
