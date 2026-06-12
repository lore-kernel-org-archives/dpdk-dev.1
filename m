Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D48CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8071D43416;
	Fri, 12 Jun 2026 17:00:56 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 3770940279;
 Fri, 12 Jun 2026 17:00:55 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 98434EC01E4;
 Fri, 12 Jun 2026 11:00:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 12 Jun 2026 11:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781276454;
 x=1781362854; bh=fka1oWLfEnzZqDaxuqH6maaMR1vDUB2GY5MEhx4EUyo=; b=
 hUMGihazkMPLTZOqaO8pvej/vMzvyDAREFNunYku2i9FflikncxgR+w4p6oBtumi
 ZDDTQfpEuagqaoeVgaWy/8RS+7D5n2XQU/dDY0oOy2QAceDT49sve2AopAL3mOBf
 ApSD1cNlYl1AfxZwphgIpwBQ1MmPEVycz9X0/gqK0K+tE1BCD/SutgaUEAfaqRQ0
 6g6bTMGuCxmUN4+EoQvsxfJd1a2bh2vv9iGFts+gEYkH7dKQBqN39gGeTJNCledD
 h51taeK+h0gSBQuHiJvsQ558BfGTbe6BLZS1fzYBWaEy0jMQ/XKh1FM+IEiL7K+b
 ImCWUfCI0boCiPJpCK6vBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781276454; x=
 1781362854; bh=fka1oWLfEnzZqDaxuqH6maaMR1vDUB2GY5MEhx4EUyo=; b=Y
 lpy0OsLTbK1abUF2K31HL/BU1lfDXd2wdvuKU5wiRXLdbA3RiNNdluR/EQUcrE7S
 zmXQckx3T2rmsqUJ47t6ENTzESsIt4x61q2U49ej9RI73dpBrFLXvFHOnKRxrLQK
 /vBfZafP66l3E9vueNxTCFHEVsPwc1i+NhhgN2vh6sreqK5NCMccpy9ucoPgVJpT
 sCxPPlqMvJO1OCtY2KF0bdDNPsQajoInMGRNGAYgXgn5H806PIRlbKOWJ8WIBh+k
 lh4/fQnQdPA7tny97e6NBncua3k+qK++YBjcEw8Suv27GmEb1L1CZE6+vlo0E/ro
 Aprs7viEvxm9pXu8zX4ng==
X-ME-Sender: <xms:JR8saqLT013y8S7VtZzJMWhAI7fRHa82UXUeeg6hKP2UhsacsNRhsA>
 <xme:JR8sasMH-irOjYSwwZFCAwkltkRL0U66JTtjLDIcbR_I_3wkq8gemKGKNofvuS3YA
 E4V1oGOxvtSIcEzhx-f_MWJIokE-q2T6clc7FroMeREierYDQl19g>
X-ME-Received: <xmr:JR8saqnbDKWY0021TMlQWe5Fgm80YqqbZ4ZviUURyyrGLjcfdfcElIG2IoC5_EeLcFxWP3-uogtIlfvBs0RJL9l_Kg>
X-ME-Proxy-Cause: dmFkZTGwQFgcG72uGIbTkkiSaKJJUupY72OXFhHALzF2MyvsFFTOF58ycDzbj+bRz75kjj
 AUYmZ/6CDybpvwQqwX3nc2N2JvKmFe1NLnMY9Z+Hz+rfteZaX3TIrGQMCOZ4t3hdAVQ4Cb
 xibfue4knM3lXyna5z5n4+RSPAcg9wZMC+SlAD6+sdUXfexUwlcmGB+ssmlreWqqrXCXqS
 5IUGDE6wmxlIkjFvoQwyXBwheZ4pnXGxMB3B50L/HsURBqzOZICrW53/YKQZHddJxIh5Sz
 hKk3ikzN4PcOW44Lu8BwkkxsdniUMFuDeTSElQViHIsHP5X10HeUhORQfGTUahDjtOCaNW
 n4p9YztLFoOuvJvZCrZeHxIkh5E1gX7UN4h/AdDy/DPVg5ZJdm8okiUURkuLr6usyesdKd
 +XUreO2Xh9HUgtigZB8o83V6wnFpyTZS6pimZdIIzhXF/SSiozOVRt9GiRjGYOxShqgl6s
 jjqrTJXVJpMRmHUtiDDD1H42plJRYtucbR43OqYAW7qp3o6Jz3v4AjOflWI5be6X628lI6
 J8bOWs1uQpxsa7fIDA+QUfQdsguz81OsMNRWlqDvU49UaPzEBgXEV4FkuXiKdyYMBx3ajx
 uOHdxDHFUzcWW8HBQIS2qDSdmIHAKvwx6cjVMPwgjHVYEYutPIAHU7Ea8DZQ
X-ME-Proxy: <xmx:JR8sag5YCHDcJpbjOY4nrp2M7H2dymCuR-rtfJuytNpq-Zc6rTJPtA>
 <xmx:JR8sau3PHhdtyxBp_LnEc7VqK5PROiTasXumbXWf6kzQksR7PG1I1g>
 <xmx:JR8sarGTUjCfuIsWzBYu8xkjLZTuMB8FdeK-nQyRR3MK3YsD_45H_A>
 <xmx:JR8sath2RJH6ts6q2n9ICgYL0l_MHEQ94YlOQRR34_RbJc2eBHRYnA>
 <xmx:Jh8satybuzSjZYw2UZXBVEmIZbl0MB6qA6jBaTygi8s0KKBiOBF7hKNj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:00:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maxime Leroy <maxime@leroys.fr>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, dev@dpdk.org, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
Date: Fri, 12 Jun 2026 17:00:50 +0200
Message-ID: <2ePv3yh4QL-977KPOt1dXg@monjalon.net>
In-Reply-To: <CAHHRULUGdnTmpnAX2aONEMj3bJmN11RG2cHGJ7h3-qhjoJLsFw@mail.gmail.com>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <98CBD80474FA8B44BF855DF32C47DC35F65909@smartserver.smartshare.dk>
 <CAHHRULUGdnTmpnAX2aONEMj3bJmN11RG2cHGJ7h3-qhjoJLsFw@mail.gmail.com>
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

11/06/2026 20:39, Maxime Leroy:
> Le jeu. 11 juin 2026, 18:01, Morten Br=C3=B8rup <mb@smartsharesystems.com=
> a
> =C3=A9crit :
>=20
> > > From: Maxime Leroy [mailto:maxime.leroys@gmail.com] On Behalf Of Maxi=
me
> > > Leroy
> >
> > Good catch.
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >
> > Not related to the series, consider sending as separate patch.
> >
> Thanks for the review and Ack.
>=20
> Agreed, this is a generic ethdev fix. I kept it in this series because the
> NAPI user depends on it.
>=20
> The current Grout NAPI loop arms RX queue interrupts and then re-checks
> rte_eth_rx_queue_count() before blocking, to avoid sleeping when a packet
> arrived between the last empty poll and epoll_wait.
>=20
> With the current ethdev reset path, rx_burst is replaced by a dummy
> callback on stop/release, but rx_queue_count becomes NULL. So if the port
> is stopped concurrently, the NAPI worker dereferences a NULL function
> pointer and
> segfaults on that recheck.
>=20
> I can split it out if maintainers prefer, but then the dpaa2 NAPI series
> has a real dependency on the standalone ethdev fix.

You can keep this patch in the series AND
send it separately for a quick merge.


