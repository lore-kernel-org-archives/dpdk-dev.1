Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01906CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 14:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5AFC40649;
	Wed, 29 Oct 2025 15:57:53 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 48CBD402E5;
 Wed, 29 Oct 2025 15:57:51 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id AE4B01D00139;
 Wed, 29 Oct 2025 10:57:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761749869;
 x=1761836269; bh=sKfrs7pZdatLnIYC+CxI5wb4N8N/7BHxVnBMnNCmQxw=; b=
 lSmKClhPUBbyAK+yaIrP6cHCbKKwt6lUXg6ssS9FxT8vfbRmeGmvBqkMKGYHQZYF
 Xub571nNEiZgOaboagTVIHbptfuOoiZfvuZTVKxSV5/AYyr9+xBX12GF7iNa8nPo
 mVTx3pccIuBE+dI+Ridqi3hJE7ujXxL/OrqBhwStF/451pROW+IrifP2L849PyFE
 cxlLc09ZZbzYATVPVo4qGchjKC9SrKfTCp8JG45HPHxFMP7rFHgJHkjV3JWoF2t+
 BV43Lj02ej2ZVZqSoongA39qvRmcFYboWa+upMiBypsoAOCM7mf0PLHA/fzbiRv0
 wGxWfgfFzjnRrTqiUH7FZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761749869; x=
 1761836269; bh=sKfrs7pZdatLnIYC+CxI5wb4N8N/7BHxVnBMnNCmQxw=; b=Z
 CWIPEsu1+QEk2Li65MSLRT9bh68BY0LFYYdZ1ZJElXxKlMeRaCNxsqxgvv7HWIUs
 yA1Zn2cFxPvVBFpBL25rB+6I5Cuff6pPDbz7/Np//d1lnRXWxCo8WAQVHMCKA/r+
 jgRHdMMTPEtCFtD1imlAmjFpwJvEi8H2V8QUyLXu5F8DzRChOseNTx9qgRRw86mH
 TLOTT9gnUDGDh5VlaftFajSycE4BqhXz5Pzn5Qj1DYn+Tt5cfH9aANC4Aydk0SeN
 uUhfwNQvivGIvdAbYJlFb0VGM3ulFY2hSvz4niRgkBDdRXQMjfcPcvOpuIB6iM13
 Rg2iEQLssymki4XK4xypg==
X-ME-Sender: <xms:aysCaeTq-6KtScLSsHyDymFyNkclj8PNGNtOM7M69bMrzWlelE89TQ>
 <xme:aysCafL5uhq0XnZ7wGXuV3WaW1G9l8n7yZ6vu5EZ8j2mmbrGIgI4vr9xQP9YLowjk
 a_i6YUseA5w3b8uyTOVuT1Bt4Q2KH0o_6YDNfsWwjrar0vtwDKSMII>
X-ME-Received: <xmr:aysCaVPe9NG5uDDv415HqH5Z0w-RsA8F5b44TImTuBsjfBCwPIsgqNinDEbNDhaXaxHn3RTHULOoUrYB02LOQXSjRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegtdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeevfeejfeeuleejuedvtefgteeivedtgfeuheejfeeltddvhefgueeu
 fffghfekudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsohhothhlihhnrdgtoh
 hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhh
 ohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfeelpdhmohguvg
 epshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghm
 shdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlh
 drtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhl
 rggsshdrrhhupdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuh
 grfigvihdrtghomhdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrhhorggu
 tghomhdrtghomhdprhgtphhtthhopehsohhmnhgrthhhrdhkohhtuhhrsegsrhhorggutg
 homhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgvlhhlrdgt
 ohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopehskhhorhhisehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:aysCaRyD8MbuXsz8cnE_gjV0Y9IXNoog1N6s1090yQAOSh_kg0wtZw>
 <xmx:aysCaTHmq_X0MiFAyzNM3Z_yYCgcE5XCHPIddGaosMMu6DBUH5A9Ag>
 <xmx:aysCadEyklw6xIDSVc_LsIjMoprUR6630fm7Fp2E5zPRB3eMbGNg4w>
 <xmx:aysCaUsztaKE_ldFowFDplLGFT2xebheckpMSBM9pdBApagfn9hvtg>
 <xmx:bSsCacUlla3Ve27pIdpUUt1Qh5pNU1Rte6uBuR-X7O3nCRAHiUoST51M>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 10:57:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>,
 Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>, Gaetan Rivet <grive@u256.net>,
 yangxingui <yangxingui@h-partners.com>,
 Fengchengwen <fengchengwen@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Wenbo Cao <caowenbo@mucse.com>, Jerin Jacob <jerinj@marvell.com>,
 Maciej Czekaj <mczekaj@marvell.com>, dev@dpdk.org, techboard@dpdk.org,
 Ivan Malov <ivan.malov@arknetworks.am>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
Date: Wed, 29 Oct 2025 15:57:40 +0100
Message-ID: <5090512.QZNE9M9tJY@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65513@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aQHdDf7DnAIyIzR4@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65513@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

29/10/2025 13:23, Morten Br=C3=B8rup:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > On Wed, Oct 29, 2025 at 12:16:37PM +0300, Andrew Rybchenko wrote:
> > > On 9/18/25 5:12 PM, Konstantin Ananyev wrote:
> > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > > On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Br=C3=B8rup wr=
ote:
> > > > > > > Dear NIC driver maintainers (CC: DPDK Tech Board),
> > > > > > >
> > > > > > > The DPDK Tech Board has discussed that patch [1] (included in
> > DPDK
> > > > > > 25.07) extended the documented requirements to the
> > > > > > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > > > > > These changes put additional limitations on applications' use
> > of the
> > > > > > MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually
> > exclusive
> > > > > > with MULTI_SEGS (which is typically used for jumbo frame
> > support).
> > > > > > > The Tech Board discussed that these changes do not reflect
> > the
> > > > > > intention of the MBUF_FAST_FREE TX offload, and wants to fix
> > it.
> > > > > > > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
> > > > > > exclusive.
> > > > > > >
> > > > > > > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements
> > were:
> > > > > > > When set, application must guarantee that
> > > > > > > 1) per-queue all mbufs come from the same mempool, and
> > > > > > > 2) mbufs have refcnt =3D 1.
> > > > > > >
> > > > > > > The patch added the following requirements to the
> > MBUF_FAST_FREE
> > > > > > offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > > > > > > 3) mbufs are direct,
> > > > > > > 4) mbufs have next =3D NULL and nb_segs =3D 1.
> > > > > > >
> > > > > > > Now, the key question is:
> > > > > > > Can we roll back to the original two requirements?
> > > > > > > Or do the drivers also depend on the third and/or fourth
> > > > > > requirements?
> > > > > > >
> > > > > > > <advertisement>
> > > > > > > Drivers freeing mbufs directly to a mempool should use the
> > new
> > > > > > rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so
> > the
> > > > > > preconditions for freeing mbufs directly into a mempool are
> > validated
> > > > > > in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> > > > > > > Similarly, rte_mbuf_raw_alloc_bulk() should be used instead
> > of
> > > > > > rte_mempool_get_bulk().
> > > > > > > </advertisement>
> > > > > > >
> > > > > > > PS: The feature documentation [2] still reflects the original
> > > > > > requirements.
> > > > > > >
> > > > > > > [1]:
> > > > > >
> > > > >
> > https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b7139188487
> > > > > 6
> > > > > > 673c1
> > > > > > > [2]:
> > > > > >
> > https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
> > > > > > rst#L125
> > > > > > >
> > > > > > >
> > > > > > > Venlig hilsen / Kind regards,
> > > > > > > -Morten Br=C3=B8rup
> > > > > > >
> > > > > > I'm a little torn on this question, because I can see benefits
> > for both
> > > > > > approaches. Firstly, it would be nice if we made FAST_FREE as
> > > > > > accessible
> > > > > > for driver use as it was originally, with minimal requirements.
> > > > > > However, on
> > > > > > looking at the code, I believe that many drivers actually took
> > it to
> > > > > > mean
> > > > > > that scattered packets couldn't occur in that case either, so
> > the use
> > > > > > was
> > > > > > incorrect.
> > > > >
> > > > > I primarily look at Intel drivers, and that's how I read the
> > driver code too.
> > > > >
> > > > > > Similarly, and secondly, if we do have the extra
> > > > > > requirements
> > > > > > for FAST_FREE, it does mean that any use of it can be very,
> > very
> > > > > > minimal
> > > > > > and efficient, since we don't need to check anything before
> > freeing the
> > > > > > buffers.
> > > > > >
> > > > > > Given where we are now, I think keeping the more restrictive
> > definition
> > > > > > of
> > > > > > FAST_FREE is the way to go - keeping it exclusive with
> > MULTI_SEGS -
> > > > > > because
> > > > > > it means that we are less likely to have bugs. If we look to
> > change it
> > > > > > back, I think we'd have to check all drivers to ensure they are
> > using
> > > > > > the
> > > > > > flag safely.
> > > > >
> > > > > However, those driver bugs are not new.
> > > > > If we haven't received bug reports from users affected by them,
> > maybe we can
> > > > > disregard them (in this discussion about pros and cons).
> > > > > I prefer we register them as driver bugs, instead of changing the
> > API to
> > > > > accommodate bugs in the drivers.
> > > > >
> > > > >  From an application perspective, here's an idea for
> > consideration:
> > > > > Assuming that indirect mbufs are uncommon, we keep requirement
> > #3.
> > > > > To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of
> > requirement
> > > > > #4.
> > > >
> > > > Do we really need to enable FAST_FREE for jumbo-frames?
> > > > Jumbo-frames usually means much smaller PPS number and actual RX/TX
> > overhead
> > > > becomes really tiny.
> > >
> > > +1
> > > > > Since the driver knows that refcnt =3D=3D 1, the driver can set n=
ext
> > =3D NULL and
> > > > > nb_segs =3D 1 at any time, either when writing the TX descriptor
> > (when it reads the
> > > > > mbuf anyway), or when freeing the mbuf.
> > > > > Regarding performance, this means that the driver's TX code path
> > has to write to
> > > > > the mbufs (i.e. adding the performance cost of memory store
> > operations) when
> > > > > segmented - but that is a universal requirement when freeing
> > segmented mbufs
> > > > > to the mempool.
> > > >
> > > > It might work, but I think it will become way too complicated.
> > > > Again I don't know who is going to inspect/fix all the drivers.
> > > > Just not allowing FAST_FREE for mulsti-seg seems like a much more
> > simpler and safer approach.
> > > > > For even more optimized driver performance, as Bruce mentions...
> > > > > If a port is configured for FAST_FREE and not MULTI_SEGS, the
> > driver can use a
> > > > > super lean transmit function.
> > > > > Since the driver's transmit function pointer is per port (not per
> > queue), this would
> > > > > require the driver to provide the MULTI_SEGS capability only per
> > port, and not
> > > > > per queue. (Or we would have to add a NOT_MULTI_SEGS offload
> > flag, to ensure
> > > > > that no queue is configured for MULTI_SEGS.)
> > >
> > >
> > > FAST_FREE is not a real Tx offload, since there is no promise from
> > > driver to do something (like other Tx offloads, e.g. checksumming or
> > > TSO). Is it a promise to ignore refcount or take a look at memory
> > pool
> > > of some packets only? I guess no. If so, basically any driver may
> > > advertise it and simply ignore if the offload is requested, but
> > > driver can do nothing with these limitations on input data.
> > >
> > > It is a performance hint in fact and promise from application to
> > > follow specified limitations on Tx mbufs.
> > >
> > > So, if application specifies both FAST_FREE and MULTI_SEG, but driver
> > > code can't FAST_FREE with MULTI_SEG, it should just ignore FAST_FREE.
> > > That's it. The performance hint is simply useless in this case.
> > > There is no point to make FAST_FREE and MULTI_SEG mutual exclusive.
> > > If some drivers can really support both - great. If no, just ignore
> > > FAST_FREE and support MULTI_SEG.
> > >
> > > "mbufs are direct" must be FAST_FREE requirement. Since otherwise
> > > freeing is not simple. I guess is was simply lost in the original
> > > definition of FAST_FREE.
>=20
> Agree about the "mbufs are direct" statement being lost in the original d=
efinition.
> It can be extended to include mbufs using "pinned external buffer with re=
fcnt=3D=3D1", because freeing those is just as simple as freeing "direct" m=
bufs.
>=20
> > >
> > That's a good point and expanation of things. Perhaps we are better to
> > deprecate FAST_FREE and replace it with a couple of explicit hints that
> > better explain what they are?
> >=20
> > - RTE_ETH_TX_HINT_DIRECT_MBUFS
>=20
> In the FAST_FREE case, this hint would be TX_HINT_MBUF_DIRECT_OR_SINGLE_O=
WNER_PINNED_EXTBUF.
>=20
> > - RTE_ETH_TX_HINT_SINGLE_MEMPOOL
>=20
> Prefer TX_HINT_SINGLE_MEMPOOL -> TX_HINT_SAME_MEMPOOL, so we can add a gl=
obally scoped TX_HINT_SINGLE_MEMPOOL later.
>=20
> Also, RTE_ETH_TX_HINT_NON_SEGMENTED can be added later.
>=20
> I strongly agree with the finer granularity for the hints; the optimizati=
on of freeing to one mempool instead of a variety of mempools is orthogonal=
 to the optimization of not having to consider indirect mbufs.
> And the drivers are free to only optimize if multiple hints are present; =
so there is no downside to using a finer granularity for hints.

Yes we can have finer granularity.


> Although we are reusing "offload" fields for hints, there's no need for d=
rivers to announce capability for such hints, including FAST_FREE; since th=
e drivers can freely ignore any hints, hint capability doesn't contain any =
information about the driver's ability to do anything useful with the hints.

Capability does not need to be announced,
but it would be useful to have debug logs when an optimization is enabled.
I'm not sure how we can enforce such logs in drivers.


> Regarding naming, we should use "promise" instead of "hint",
> to emphasize that the "hint" is not allowed to be violated.

I'm not sure why but I'm not confortable with the word "promise".
To me, a "hint" is already something strong.


