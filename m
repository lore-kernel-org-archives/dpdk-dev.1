Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B945CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 12:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EDB402B0;
	Tue,  6 Oct 2026 14:52:30 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 798F4402DC
 for <dev@dpdk.org>; Tue,  6 Oct 2026 14:52:28 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id D26421D000C3
 for <dev@dpdk.org>; Tue,  6 Oct 2026 08:52:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 06 Oct 2026 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791291147;
 x=1791377547; bh=58ym2PqwarlGZHgG0ZDwIZgMUTyduARXYA1H7Rn8jxs=; b=
 PFS2b8u0XKnnbVQfIJn/uQa8v1y478z8SPQUakOd629s2q9Uw++aaAlkhJNWNior
 HIwiBAxL6qXGAF3SVLTmwOlRR64+o13VpUAfw38wLK5/8ufzzwjjjYfjytCoqLl2
 LwjCXFlfb8KxGw42T/UzdEgprKf5HX0V9qkLx2x5sM7TRoQJsVtLKejsdXRrn0LI
 d5Lo37ffhyPVFIoiEPiY4y+Wx8OrzGDq6PLWtBc4yQ8RSNnOhbEKA12e6Ys7TiUM
 Ijfw63iJXhCFbLNiI+1w6sJmDfK3GKyVmZepJponmo65TzNGh0gUZdv1QouCINnt
 W1hb55hRxrdH0eU4gF7WKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791291147; x=
 1791377547; bh=58ym2PqwarlGZHgG0ZDwIZgMUTyduARXYA1H7Rn8jxs=; b=K
 E5mD+5723vUXHsDGS9WjmXKrMwZTQeMH+reKA9KMcESKhq3eN5IRijQRDmgamicU
 +SRwW15eZlKp7uRbFf38cAf0fOF2dmTo/xpuEbeLGg3xYkB6x3qq1MlDWslObAkd
 7D30PKv++ChwFCGXdWcj1/jr1YHD10wLjU7MJPb6AP8nWp26Xqc+t2k/PzdiBW/W
 Zz4i3TKI10wBNIWCpPF7krZePtv3p4KiUoNdnDepr6xFZudCRdrEoyjkao+lBVy3
 naksfdh5zR+Um+GOMuc7Qn7c8dyp+NAUnxvRwtQCnGC1g+KEBtg1VTwEAYP1zD1M
 zGzWjH1Es8scbsam3i/OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791291147; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:ezeQ/I9RtOx73bLN/ehUX7olr3d4KSgKyuRhqoXx4tS9+qg
 7cQojqf8Sv2upMAXbsVECeJXTWjxIOPdGp6oLvi+KNVIftb9tS8oW6mM+/VCrGth
 Bp8sI1/bkvcB5LjXYCwYjX+iGfYgyKCU325Irc7up8ajYwZdZLNHK6dmM0kN4fPj
 Yv+6qmSFL0b/RIJFiHzR+PjaB0SHcSh8XI1z7uVX/EUkBwnz+LV44hQpebl6E5N2
 o8RvXWCCeMdDm9rgZKFXmY3Qcfuoh2rFLCpB/tmY/w5AlyJ3V3uTNnqXcgKP6qf9
 Inma6tmPFJoBiUJmP8B6F/d4CgHQm25k+V1RBGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1HXgoCW2p96SuXpvOvGHwB96RLH9LFaykDR8BBAt6Bg=:yLXqNwlKTeqmrplLoMQQbUBUwo0suXtEZdC60ubPFMY=;
X-ME-Sender: <xms:Cu_Eaqsrtt98Ui8xYa-WDEEgVCZzo3aDP49AjzOgQqw1s0d853VhJA>
 <xme:Cu_Eavm6AYIvp85Ckia2gffE21g00h2GzT-3xoX5mQ-JEtgPrHpvUEr81Bkhmy2k_
 lSUDnvFjpxQJZlTCnmEpiPQc8CRT9aEYGZB1aZFLZTaX3s_MhgTpsQ>
X-ME-Received: <xmr:Cu_EattbF6IH6o6LEPaW5pjQzhfO2oe8yTppFhJiCmgaWR-I_0a5MoVdzTKBUM9kzfQ1eB_WMLOpEV97NfLvxVU>
X-ME-Proxy-Cause: dmFkZTEsCYnvm/IcVKFUwPzodVRL0eQbMh7CRWSRvYq5nMMt98u/lzU/ru+SFR1obWmVA4
 eT+iwhzHu/bEKgY3hOrNFuDaS1sCfrLELCNS6ZJMlDk0ZgrkW/pZtx2V8H0wJa6WMlLhiZ
 C+2dIaFV1oCDKi32UfM1CbAyPNRdBwpJNRwAppNInC/6vlDkjY6YaZlAkpVl3AHWza5GTE
 Ypbw+Tyh84SheoarehL2VYBBL9M3kPl62Da53Ebmy5ybL23MmcDAnHxDb9AaBaSebnfkBe
 if1UvldR7JkVvuQsAbx/KGUfeM17hvTgkpmAUQs+bdAtggihiwC6SjiyQUeTdLNF75JMjd
 FLwN9HPcAuGRBHmRZVYWyE3yhdNhu/Y7qwo5yhlJKx6oDCoTMWAhQTQY6R33IV7tyIaj31
 r0Zi2bpS7JJqiwxDK+hk19MgAv5FQ5zvWFiSzwWT6XLpB3yZGmgNqxJk9ZFpNFw1JC7aRy
 l98bMBJ1jZSH+olIzV8OnTpKxmYMlR5CBK1mSa8yR/VvKtKhLMaAGh3UWk7TKM8mK6rN37
 u3nArxDgbi5K8AT7O/jyTeMqIjgvxVNuehiIk5sINkyuYEgIBpusqB5VVXAHJWM5rbigMy
 EnDbEtOEB6Iy8X+BxW5H3Ba82MJn2YyAUNMLSFgaL+y2utuaoZeEmRzonxTw
X-ME-Proxy: <xmx:C-_Eateei_ucXYVp7UnTxbgOVXj8HdjN8lLOF1UAzMVtKGupmyb8lA>
 <xmx:C-_EalzZRdncbaRTxuEMpYSc4d2n9zHkbIBL2TvvOBax8BR_vRuo2w>
 <xmx:C-_EajFC9kW6fbfx7yfXXQV9qE3A6tuLisc4OTO7VXozryyyfP7hmw>
 <xmx:C-_Eapxqvzn1Obpz-6eAkHg0RMJon57DZ4sfbR-06cb5Vx3oOGP-qg>
 <xmx:C-_Eanp4evMgAvbXTYcx1qj3jLguusPTo4ME3gInx4hwFz9qOOH9ZyYx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 08:52:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Cliff Burdick <cburdick@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v4 1/2] eal: support dmabuf
Date: Tue, 06 Oct 2026 14:52:24 +0200
Message-ID: <Y4hmr0dSRnuEoU6AC2BDrw@monjalon.net>
In-Reply-To: <SN7PR12MB69604B778A001E389DB929B4AB2A2@SN7PR12MB6960.namprd12.prod.outlook.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <39632c4b-10c3-4bdc-b4ea-9010391b4ada@intel.com>
 <SN7PR12MB69604B778A001E389DB929B4AB2A2@SN7PR12MB6960.namprd12.prod.outlook.com>
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

Hello,

It's a pity this patch didn't move.
How can we make the design discussion progressing?


23/04/2026 19:06, Cliff Burdick:
>  From: Burakov, Anatoly <anatoly.burakov@intel.com>
> >  On 2/4/2026 4:50 PM, Cliff Burdick wrote:
> >  > dmabuf is a modern Linux kernel feature to allow DMA transfers between
> >  > two drivers. Common examples of usage are streaming video devices and
> >  > NIC to GPU transfers. Prior to dmabuf users had to load proprietary
> >  > drivers to expose the DMA mappings. With dmabuf the proprietary
> >  > drivers are no longer required.
> >  > 
> >  > A new api function rte_extmem_register_dmabuf is introduced to create
> >  > the mapping from a dmabuf file descriptor. dmabuf uses a file
> >  > descriptor and an offset that has been pre-opened with the kernel. The
> >  > kernel uses the file descriptor to map to a VA pointer. To avoid ABI
> >  > changes, a static struct is used inside of eal_common_memory.c, and
> >  > lookups are done on this struct rather than from the rte_memseg_list.
> >  > 
> >  > Ideally we would like to add both the dmabuf file descriptor and
> >  > offset to rte_memseg_list, but it's not clear if we can reuse existing
> >  > fields when using the dmabuf API.
> >  > 
> >  > We could rename the external flag to a more generic "properties" flag
> >  > where "external" is the lowest bit, then we can use the second bit to
> >  > indicate the presence of dmabuf. In the presence of the flag for
> >  > dmabuf we could reuse the base_va address field for the dmabuf offset,
> >  > and the socket_id for the file descriptor.
> >  > 
> >  > Signed-off-by: Cliff Burdick <[cburdick@nvidia.com](mailto:cburdick@nvidia.com)>
> >  > ---
> >   
> >  Hi,
> >   
> >  A few random thoughts about the patchset.
> >   
> >  For one, this API is obviously Linux-only. This in itself is not a problem (we do have VFIO API...) but I would really like to avoid that if possible.
> >   
> >  For another, I don't see any support for secondary processes - the dmabuf array is process-local, and calling register() from secondary process would presumably either fail or create a duplicate segment, depending on exactly what you pass into the register call. If this scenario isn't supported, it should at least be explicitly disallowed and documented to be such.
> >   
> >  My biggest concern is that this is creating another type of external memory segment and thus segregating the API, but isn't doing it in a way that is generic. I can see a valid usecase for this, but what we're essentially doing here is storing some metadata together with the segment. So, perhaps, this is what we should do? That would seem like a cleanest solution for me, and it would extend usefulness of the API to other use cases where there may be a requirement to store some metadata/fd/whatever with the segment.
> >   
> >  You could then build another API on top of this (a library?) that would handle things like secondary process synchronization with IPC, so that you have all fd's valid in all processes.
> >   
> >  Thoughts?
> >  --
> >  Thanks,
> >  Anatoly
> 
> Hi Anatoly, sorry for the delay. It is true that it's Linux-only. I did not see either BSD or Windows having an equivalent to dmabuf, but I'm not very familiar with them. 
> 
> Adding support for secondary processes is something I'd rather delay for a later release if possible since it could be a lot more work. I can add a guard that says it's not supported if a secondary process calls the register function.
> 
> For a more generic API are you suggesting something like rte_extmem_register_ex() that would take an enum type along with some opaque metadata, of which DMABUF is one type?





