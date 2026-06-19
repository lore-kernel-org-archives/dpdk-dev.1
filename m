Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497ECD98E6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 07:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C6B14027F;
	Fri, 19 Jun 2026 09:28:08 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 6F2A3400EF
 for <dev@dpdk.org>; Fri, 19 Jun 2026 09:28:07 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 011027A017D;
 Fri, 19 Jun 2026 03:28:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 19 Jun 2026 03:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781854085;
 x=1781940485; bh=2XV6i4AcyCD5TuaK8Iai6y+7bbIpri8fCQojV5r2/+E=; b=
 Pbos29R/L22Morcbc5xXjEfeDh538fcA0AV8t1OOG8fHSwuoE9Ryx5rUp59BTGjx
 18vz5hOS+Drpf5nKxOuviR47gwmq0+YloXJIAH2ydl3w6x0q4wVRDNkoAniCdnaf
 X6VY9gFwkgozANt+XxrdPVryTDi4RkAalrBTcNI25xp8Bl9qtggB8uRWD02zZNPv
 jh64SCif4r5FMCKR+Bq3i44RbE+jcgzHNLR+DUGYdgm3QdWlov8qe/qZ3IZSdFMy
 iDt0uwHMWxrS1LAY9SZFuxVVmzFv/rqf85/Fs64+sVugkIZcCyuqHKutccQ4yHKT
 l3usaRKyNR7nDTOxI7NzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781854085; x=
 1781940485; bh=2XV6i4AcyCD5TuaK8Iai6y+7bbIpri8fCQojV5r2/+E=; b=A
 OSi/t71LecubbSPwt7VBpL+n6Njhu5jLOcwvQpeH1ZFJiBorxQ2RM3QFQ9IHvkON
 5mblPoUsXBk6JkrfPs9egJJLOpJAgHGCT/Df+I5HOOMAxDD/lMoEW2A8RUdu3eN5
 8VxsK7Z5uP0i0DcRcGFdrc+MEMCW5nYUhr52+SMJYN/pxcIsFmws83eNQLWMikNa
 gJenZT6Yihj15wPYje8pDoQIPSXlggF1IgeL9UVyQxq0hZaVX3HcYOJXxP5yVRhi
 1SpXjSh50lYFyeSbBpknzXgaw8HNu6aXA9xt15HPSKvc60ZCGEWsCBwzASx8zj9V
 eXkk/Nr3WB7ckZQs4+Ehg==
X-ME-Sender: <xms:hO80arZnQQwkQJRNs_J6zScMQ_ArVtLnE2O3P0SO5c6xA1GGSzLU6A>
 <xme:hO80ajUGy24t4hgoE7WX-daRb4_KL2sn3Gtetz9sTPI4N-xqZ-AaQnAVjUCuVVoGW
 Ff3-82L-3A-cjNNHkipBsQYtp1P3wPzfyr79fQVVcUsybHsZ0yGvQ>
X-ME-Received: <xmr:hO80apiKGpmkxqlc5Ze2aqjmGl-J37tPdVYuxuURaD7K-dlMdYlH2wCWUIdGEaZuPjBdh7EfJ3P4KMiOC7BPO67TYA>
X-ME-Proxy-Cause: dmFkZTGWCWOer+D/5iD1pfADulmQ9Z4xFFrxwQ5435Zlx04cihF9q6crxDQCTCXV24wmyZ
 yB3BT67VZhPoQzUgU5rqk0MC+t+rROiM9oO5WeEDwy6VJ9KijkCgtZ4Uu7sRwmTDCgVzHE
 RR4lKxvbgyoUnGMoDIs2RKmMxNgCpCITiLsicGfJ7Am84E/JkXZRvSJky2iDaywsOggA8o
 iJAGc6ybQR62RqhfGVlXtbnnOxFcGlvA3F1xvR11NPHNVcJZ9NJ2UsBDrmAFpSfYTH3yoW
 p52ICczuUo5PtpaGZuTWrhSXvA3KwrKMN3MAg4ATJMDYo3rMEGGGxxMmsr0D+ZghtpWFrU
 m69vL05sUTdMHoyg87LqEttubfO822R3RTB0SG04LsZbE0sF1N3EGOgQ+rh3Va6JRVyNf4
 NikqLcmjPMpWBWmgYZV6xPTR/LsxoUbCHgbSiqRS+9B9qhr/JaN9PvijxW8qeVZ8GvPKdc
 J8CmNsT19GqQbYUEZs98EPyrFNziMbbEP4+rv+coVuzDLSSSE3orswxufy/rWuCHgnfsl6
 9Vgk2JUY3L7PPQ4I0dJNOpmXZZapkBuFqQHjeDUpVqu67AGK9E2l1zgb92xyminytJWgT+
 S1e3KUkKa18OYUfQD6yyaBdmPhVUQVHRr0AC7L73yqESsVWmQX38s7k0ZkoQ
X-ME-Proxy: <xmx:hO80ahvUYpQjuuuosDpec25lojsxU9ikPaCrC6LynBUHD7fTIzwX0w>
 <xmx:hO80ai7sSzRyP4zr_ED8AkSme5x_tn89IMPURzFVSompP-SAAsWp0g>
 <xmx:hO80alNT2vzV7IILwjtvMyR3a55BsnRgsCB531kWYYMbAAahT4kR6Q>
 <xmx:hO80aovbywCyQhwiFQxIJBOs3EM6sAKhuNhWMnwVBCv-pbbu4VvY5g>
 <xmx:he80atQThcPnpidMLzVWWwlLyDaZF9BVhQos5M7_gZL3NJaOt0rlbAzY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 03:28:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Huisong Li <lihuisong@huawei.com>, andrew.rybchenko@oktetlabs.ru,
 dev@dpdk.org, zhanjie9@hisilicon.com
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Date: Fri, 19 Jun 2026 09:28:01 +0200
Message-ID: <ApV03BBBSN-iQgiffDgXRg@monjalon.net>
In-Reply-To: <20260618190339.2fc76616@phoenix.local>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local>
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

19/06/2026 04:03, Stephen Hemminger:
> On Wed, 17 Jun 2026 13:48:37 +0200
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > > From: Huisong Li [mailto:lihuisong@huawei.com]
> > > Sent: Wednesday, 17 June 2026 12.28
> > >=20
> > > Add the RTE_LCORE_ prefix to the lcore role enum values in
> > > rte_lcore_role_t
> > > to follow DPDK naming conventions.
> > >=20
> > > - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> > > - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> > > - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> > > - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
> > >=20
> > > Old names are kept as macros aliasing to the new names to preserve
> > > backward compatibility.
> > >  =20
> >=20
> > Series-Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >=20
>=20
> The problem with this patch it causes build failures now with abi diff.

It is probably a bug of an old version of abidiff.
I recommend updating.


