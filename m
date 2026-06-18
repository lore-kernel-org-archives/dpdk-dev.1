Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC7CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 16:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ABCC4027F;
	Thu, 18 Jun 2026 18:19:44 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 31DC140268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 18:19:43 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 961031400180;
 Thu, 18 Jun 2026 12:19:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 18 Jun 2026 12:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781799582;
 x=1781885982; bh=M9QDw/W39xKf2UDOMOkcSsenQmA5CrFIyO6eijqeG3k=; b=
 fn+Jde4xb/++k4WPOFvci4d3NoB11jHCHtfnpB2VT/axGIuMO+Z9aJW50o1mYaIx
 0gykt1l01emWKwFT0g4d6vUUatVEmeXsahuKz7kk/0E+thkv+bZqi5H8OkdUJYbQ
 CuLtAdpD2BGJ25nWJbuZ8BLOS0LXp/HnEeO5pVFk8nPXPbx4nzmMJrCtdTAed4BE
 0MYnHKj3/PPj5dLfCPkTGMgNH2gDDv00Wdqxdzru9/WIOooQ8FzQQuw0swvLf8iu
 sjKjYyiZOD2Oa362NMRBXw2K44dbdQ4HnhewSCE9GooY2HLK1NSxFTDNTMbdwApk
 IYQ55TMlAVOBJHO2sGkHbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781799582; x=
 1781885982; bh=M9QDw/W39xKf2UDOMOkcSsenQmA5CrFIyO6eijqeG3k=; b=O
 VbiM7OCcyrT8a32Rfdc4x+Z9t4XLVBSc40yXPpRzze9YM/I6ho75PB1xWaEgR8HO
 zEs990IBCZ/hzd0gFl+a3MbEOd3PpPpJSbJRZhspzu6Q9PfdNpS09Yj7qnWR4hVr
 /1QeJtblJMyluj+q9aBW2njEQdt1v7VBusQiv3B2hrRBnTlq0adGzAbcnIaxA8FW
 bDZ09A763+RzUuw7oKpV4VbYqAEq0kRel2AaRIeMYRcMktlXqADZoTaZ2s+q+7VG
 zVLko7urZp/44nQV3rpxXMIUecUgHB8AMPgOY+pbYa7Kjhiq1B2IWMBUzFmXvKo2
 2ai13yTftB85hAnYBJQvQ==
X-ME-Sender: <xms:nBo0akaR9ykvf-M3FQEUgKQSwFGpgC1oOEFHJin3DRAMgjt1Npinyw>
 <xme:nBo0aoUYcu-RODsUhp1oBUA8933v7gze6kF7F_-Am5foem2SnG3rO2Ptv-LgpRQCW
 WaQ8W28D4iHN57qQQx1tfexHjalxvNnGg2mvNN6tPzwlw39R9doAg>
X-ME-Received: <xmr:nBo0aqg2cbyaucPlJbguZAMvUqbOCvKcf4cb5_lAiwlku5Z7S_li9k6TIscEfWKcNPvJ-yQBuzMM6tEgs3DoJyFWIQ>
X-ME-Proxy-Cause: dmFkZTFj2/b/HgCzPGBHU+PVtfe3B88+7HczGwY+9ntj1I3KnMihmQR44rGXxD6dhNEdZ2
 4zf1IKJTFqDGrMKxATUtIJ7aprqAqb+3tMLmVcYzfHM7/6PJGWO5Ep7dUTzcDnlNWURhO8
 GbO50cDIN2pGNPN2sBs//XqrLmoGPl8u95ow4bWVZp5kPUY9S2et/40fVhPymVVBYCXqXQ
 GIXGx6OKUH02ZUw+CgsHOf+isi/iFk2jpG6+X7KOwmCsTRqaszRfaipvvb5h6n5YvG09aB
 R+hYUpduArJRQBqZzhAshycSvBiwW9sQDDoOktXKc5ah1YXNeguqT1RFIbTQMZzdcaWpTe
 0jf46BrsvIYjxQVmNtljH/n4xig+RaFxxJ1wRIuNHQGaBDcpT1keTZmQ921t59lbP8aZ6c
 VhRfkV+V804Vcxn33h4VzSRPCI2vE5EnaL5Cv5Pdllw9hPFubVceI9KIO1y5XMDb9nGlJn
 4mIM9Fdiw6BoOfNy67YOpXVPWlZ7iQyzqorCEzhPusCCTBOYbf+moJEaNAIDhU86iNDueH
 +Wx++0R6JtgFX53m4W5gVviwT6e+lWhQQP0jtwzt/HX9E5ZLqsouloSfJ9PADYj9H2fCud
 5uNCC/t2TFY+lNOEyGcyplMymijTc/JqRl5wtui6HY+ciAhbF4KhlonVfgxw
X-ME-Proxy: <xmx:nBo0aut2oP0UG5aQsqosIQxRsbW9n9DR1xO2ZAdB-ZfvSkp34Wmt7w>
 <xmx:nBo0ar4ekds1GihLhlS0fYp6jdAuTejVTgKYQe7KU9afaNUZkZTQIw>
 <xmx:nBo0aqM6ft09lXGhMgEzLhwEyqPjy-uYiV0VMT3AZE2bgPSng9PP6A>
 <xmx:nBo0aps4J4YslFQgm1PtixIyU9h1Ps_YQwYDxM7ylQ5UDybFk2n0gg>
 <xmx:nho0aqoLFM9l-3LHRNFqP8tL1vjNOizIC80evID87Yt-OfZSwOdqrjvB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 12:19:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, zhanjie9@hisilicon.com,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Date: Thu, 18 Jun 2026 18:19:37 +0200
Message-ID: <SdThFrO9S62xAryFCraiCQ@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
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

17/06/2026 13:48, Morten Br=C3=B8rup:
> > From: Huisong Li [mailto:lihuisong@huawei.com]
> > Sent: Wednesday, 17 June 2026 12.28
> >=20
> > Add the RTE_LCORE_ prefix to the lcore role enum values in
> > rte_lcore_role_t
> > to follow DPDK naming conventions.
> >=20
> > - ROLE_RTE      -> RTE_LCORE_ROLE_RTE
> > - ROLE_OFF      -> RTE_LCORE_ROLE_OFF
> > - ROLE_SERVICE  -> RTE_LCORE_ROLE_SERVICE
> > - ROLE_NON_EAL  -> RTE_LCORE_ROLE_NON_EAL
> >=20
> > Old names are kept as macros aliasing to the new names to preserve
> > backward compatibility.
> >=20
>=20
> Series-Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Squashed and applied, thanks.

I have a doubt about RTE_LCORE_ROLE_RTE: could we find a better name?

Also we should probably add some comments to explain each role.



