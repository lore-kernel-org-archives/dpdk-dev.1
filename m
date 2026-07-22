Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB7C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 12:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6728540270;
	Wed, 22 Jul 2026 14:57:59 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5CE4E4014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 14:57:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 658251D00128;
 Wed, 22 Jul 2026 08:57:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 08:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784725077;
 x=1784811477; bh=D+S61dupzGWEDSe1lTeBBGLo7260lwmeGPzhTV1nPeM=; b=
 U4+iuRXhhs1uuJHUlcFhuFt4DoLmQ0hh/01lSz/kD9mZdByrdpN6p2sKS40Dymge
 Vo1vxenmjBENTTMsWm2cLpvpQ8gzaySUqXN5rCyZFciDvsz3NDyCS0awDXqkOWgc
 8PeT133Q2I3UPMCmiaT2ZuU6KAEpiWYtaTG7S/gJInFR6eI2ZRDlOMt8suZxVct2
 dwEFHAWr8Rkfkd3rK4QFyQhDnhQmS3IqI2iEEHxo/y+gFGManC6Ii9cRU6QBiTpw
 3ub5pX6y1XZno4qufreoTIcCYO8Y/68JmfTGFzzlHtuI0e39s/OpKNFSZWEx71w9
 4ttjbVxMjxwzAG8heRStVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784725077; x=
 1784811477; bh=D+S61dupzGWEDSe1lTeBBGLo7260lwmeGPzhTV1nPeM=; b=q
 6kcT1uc9VQEQ5BRy+vANT7KjzLalCHu7+AwBgsIrEb4hNJBkbjjrPJ+RCnJ+cOEp
 sY+Rq7Jf7dl346XTrlsK1eoIfzPGu7VfjauddoDM5nTA8M6V3Cwiqtg4/5VSVUhb
 GycuOoMV8bIA8NTJZXTk18Yub04gdmTKIQAeNUaBZH5zUp9FGoL5qvzX1WNCG6AZ
 rTBb0EZl4c86qtLuGqUF899znsXOLm8aBYVT1C5prQJar0AoQW/Rl4+0c1SxnrLC
 0yEXFicpRk2k4PVYT74srULyarlDevzGtdxk8TvhEfGvJq080HEUYELOSpiX8jeN
 vygWl1bua2aK9wlqfzN3g==
X-ME-Sender: <xms:Vb5gasxc3YNJcuCnee-AbgqpjygE5TOr6zhZ5acuogFGX6X1_2VDjw>
 <xme:Vb5gapMkrH5S0ESr1YScAXembyROfi04riAacMK7lxqHCdv4gZiwIIucaLMrSeqEo
 x44GbFYfjv-oF_hp8mfPusTaPw-ra21SHHvTlDOupQKSZSXDBNulg>
X-ME-Received: <xmr:Vb5gap7s5B-LvSetWFgAsJrMn6f4eQ7rdgsZ8Vu6Y4jfd_xKJD7XqeZxem8O-6pOsMF1vgdjXMhwE0vGh3FjEL0TJA>
X-ME-Proxy-Cause: dmFkZTGYBE6L76QIOKhqk1uzdx8pRaPttevEbkr2JilR0A/mxaNeOWxqYV7B/PujVxT4cd
 whRQch3uqCXHzx65wPS9Dri5GKTcWRwyYPWPMwsyYXsP8ceYzhdyIV2NvvRy8vpK+guY4k
 H1Mvq+nqiKUJn4QPjN0vhtPDbxOyowx3nXaDYj6vAktPTUXPGDuIMpP0h0xgcKfIsFuSXq
 UEYK6U7E6ayAYXjL9LbaxmuW2YJzUHCp0xG1mnngNIkP4joGnInIiMC17EkkDrS8FWMqib
 +KVJgVcgAyYbZ8h04CDJ/8reBdffax7oRiE1b71VuBxdtv5NR7rHWXtaeXwTgkwMWlUTQy
 8mk3p4rJXGwb5su1yBMRLOsqgKh6RDYnr3ARg4fTq3iJHsgzFxiorbzfxgObrqZrHuStv9
 MwwSlA3Tv/W/qYZf5JEfbE9my/U4qXDru0e3qy6/7LO8K/q7ihLon8fX0wvvOCUI1AVIid
 lMRKD8VEDXSg/3FRKVkTOvV06W+igwO2vrrY3s4b7xNEwNP1xPW+R6mylw2sq08WZtVR1O
 jQO2sPM7qlmygbaU+R/hB2650ebNBXRDBXHKuc5hFuiCv0fZXw27XEVEYUZWuMCEzzUxHj
 0jCKDaN51UBItI6f0NSB9KBPVRvv3s/g9D07JSY2JVWOMRsbNMIDUoencSMQ
X-ME-Proxy: <xmx:Vb5gaqn0J14LfOKMmMYE3WK5mMCbYQ1UlQHeT0CD_E5gH8Vbxy0ktQ>
 <xmx:Vb5gaqRcYl_gXiLn_qACY2mwDvtKkiSciaxEkYSIjZ35y8mM9GWQpQ>
 <xmx:Vb5gapE5On8NAIIQyCZ_m-xwK0gCykdnmJnmbUVDyj0jBGI_XReBmQ>
 <xmx:Vb5gavGXpLHW4Tk2s1QFvihRBDO1gsUu0TP7fR41K6aEiKTXGar1SQ>
 <xmx:Vb5gaqUSOTFKQ_gWBz6U8P9t0HW7oGoXq8fGo-nfq8g-cs1trNdfztRL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 08:57:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, dev@dpdk.org,
 Nithin Dabilpuram <nithind1988@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc: add deprecation notice about upcoming change to
 ethdev API
Date: Wed, 22 Jul 2026 14:57:54 +0200
Message-ID: <lUCKzIs0SnqUnpLP9LuPMw@monjalon.net>
In-Reply-To: <CAMuDWKQr7XaZdwpF_-DaNgOk6POCukygVyBqbk3Hrwggygw1OA@mail.gmail.com>
References: <20260603023207.31974-1-stephen@networkplumber.org>
 <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
 <CAMuDWKQr7XaZdwpF_-DaNgOk6POCukygVyBqbk3Hrwggygw1OA@mail.gmail.com>
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

> > > Inform users that rte_eth_dev_get_name_by_port() will add a size
> > > parameter in next release.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > Acked-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Acked-by: Jerin Jacob <jerinj@marvell.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


