Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2390AC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC9C410E3;
	Tue,  4 Feb 2025 16:58:52 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id DFCE0400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:58:50 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 701701380205;
 Tue,  4 Feb 2025 10:58:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 04 Feb 2025 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738684730;
 x=1738771130; bh=6EHAoETGMMrhn3dc4dRWP7BYWQNPMNTmX8kPlnYrodo=; b=
 SbwhR6N2WGjbydAtjW7Y25cOdJajrIcg9PIXM9JRM+OVndK80peyAVWmEeFx9pEF
 KHW2gt9CUt1cCKh2uSx7AVgsM8PjWON5bSHdgLXGqk2XLDH+TNrBBQydgq7VPc1k
 E8eWqRxXA4IfabQswEguWWnN4Fo2TLj9kFim2EbN0a0312ct/5DS8DTqXdOESQgG
 NrT27nnVV5VDnelWT9BN7YoxLbPd62nA4bYnxxT72CAPAatNInL2aQJXU4SAa1Gm
 s4X/5wGjnEYmAjinAYuWhQrMGkZByfcu2/+cAyEkF+twmEoTwWtB8J5pWq3NL6VG
 AwbKDhbGY8Pdr/w+FNUjfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738684730; x=
 1738771130; bh=6EHAoETGMMrhn3dc4dRWP7BYWQNPMNTmX8kPlnYrodo=; b=g
 0UPO5iJscet83lwP4M1XPJJ9X8Nnz0ek8hkk5vDRcig4d+HNiIEyHpHRKKNKLm1M
 cO8WbBFrHmnEdyiuj+Q+PciXrGYDN3i8nSDAbnCJB+MdrYl1alpJpeNfKQ/eooRS
 6Wzm8eL/6yMG7MED/OWDqcAanjAmBcaw8tVYfdmVdQZFt1gUpMaj5xd4BLMGqT+G
 rE8O3d+A4ZnzGZj41ZuQzqBuEInQedYSy3wce2/pzdEZXydQpy2khFPeysC3+Anf
 Ykn20gOT/tLDZ6DTR/nc8t7K2ciwPM8KsmzGuFqyD53hc3gWQfXRKwZ5Q4l2HMCl
 YJ7N64DeZh4KpZm0lt1cw==
X-ME-Sender: <xms:OjmiZ217xIUZoZ2QPZViaNz4A2KeuUljIxyKarL8X51GVC2tXXbm0g>
 <xme:OjmiZ5GX_hFSDRhUKwV00uPUirodqWp8zLIWnn3hIlUTEF_Eah7lb8o5MaDp6Cw8i
 DBVdD-pjoHNBMo9Dw>
X-ME-Received: <xmr:OjmiZ-4mn9RbubyZy6NDhbdppAB4F94dVP7FPhStyuRgCsqavYo2HNnPyOBKO9vc7pyiTJJEpYZgz_9us6IRYbMilg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnug
 hrvghmuhgvsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepkhho
 nhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhope
 guvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:OjmiZ33TCBF_cazgG2Dtfpyz_phKPzMOkEsKDFN8omk49OG3K6vXjg>
 <xmx:OjmiZ5EeRMiAg5n-SlEGBOsa4kL52v72iNJQq_TwQgFCP6fIfECyLw>
 <xmx:OjmiZw_mCeW5KexMzG6QOipfPCPa33_7YRrYlA3_3UVSn0KZLyQS2A>
 <xmx:OjmiZ-n_WfTph0exTVNBqru3_4pvteZzF7gJvkbP2NjrOolwm49DtQ>
 <xmx:OjmiZ5Be_SJ0sdm8cMX9qhswTR1UJ8mwylySoov-deQLqyLLyIwZUE0C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 10:58:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v3 2/7] drivers/bus: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue, 04 Feb 2025 16:58:47 +0100
Message-ID: <1783033.jNaZZp9DzI@thomas>
In-Reply-To: <20241206181404.GA14561@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <6cff1c5a700842d79c19b045fb1f5bb8@huawei.com>
 <20241206181404.GA14561@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

06/12/2024 19:14, Andre Muezerie:
> On Fri, Dec 06, 2024 at 04:41:16PM +0000, Konstantin Ananyev wrote:
> > 
> > > > > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> > > > > Therefore the errors below are seen with MSVC:
> > > > >
> > > > > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> > > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> > > > >     case expression not constant
> > > > >
> > > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> > > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> > > > >     case expression not constant
> > > > >
> > > > > Turns out that the places where __SIZEOF_LONG__ is currently
> > > > > being used can equally well use sizeof(long) instead.
> > > > >
> > > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > > > ---
> > > > >  drivers/bus/fslmc/mc/fsl_mc_cmd.h | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/bus/fslmc/mc/fsl_mc_cmd.h b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
> > > > > index a768774c89..f27a18905d 100644
> > > > > --- a/drivers/bus/fslmc/mc/fsl_mc_cmd.h
> > > > > +++ b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
> > > > > @@ -29,9 +29,8 @@
> > > > >  #define le32_to_cpu	rte_le_to_cpu_32
> > > > >  #define le16_to_cpu	rte_le_to_cpu_16
> > > > >
> > > > > -#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
> > > > >  #define GENMASK(h, l) \
> > > > > -		(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
> > > > > +		(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
> > > >
> > > > Inside
> > > > There are macros: RTE_GENMASK64 (and RTE_GENMASK32).
> > > > Which as I understand does same thing.
> > > > Might be better to just use these ones instead of hand-crafting
> > > > same thing over different PMDs.
> > > >
> > > 
> > > I agree. I can submit a separate patch for that once this series aimed at
> > > unblocking MSVC from being used on this code goes in, if that is OK. If
> > > instead you feel strongly that this change should be made as part of this
> > > series let me know.
> > 
> > I am fine anyway.
> > Just thought that doing something like:
> > #define GENMASK(h, l)	RTE_GENMASK64(h, l)
> > Would be less work for you and less code churn.
> > 
> 
> I thought about that option too, but getting rid of that "redefine" and just 
> replace all occurrences of GENMASK would be better I think, despite
> the code churn.

Yes please, it is better to remove these macros and directly use RTE_ equivalents where needed.
Thanks.





