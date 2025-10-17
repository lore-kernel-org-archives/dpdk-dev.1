Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37FCCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 727A9427C3;
	Fri, 17 Oct 2025 11:09:23 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id B657D40B8F
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:09:22 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5DA7C14000F7;
 Fri, 17 Oct 2025 05:09:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 05:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760692162;
 x=1760778562; bh=i3DSW/a22IDk40v6+s4WnF+mSLC/w20WnRhj6RQDH8g=; b=
 XLnhL1pW1+bEGLbAU+PXl5FhfahiJAJeVKSaFSY/dtHuaSjutFsz7VV2rnvsZt5q
 r0JGDrq/K3gM6h/rwlGIr2sfiJL84H3wMaHzLOM/0wb+010a6WYwseuEcgHNhJ9r
 K0VhEWv5oUUWt09sfq/SJV5m0xSRdvDdSkxQhlJQ0JQdkHktdYmErV4+eaYBdB5F
 I0QNTKxRBBVyB573z3yo7bk5ugUlu+5bJf0UAuEB8e/Ku4Vb4KCA54NGCa919lDt
 l0dkD3tbKenCLZhqUmErRjLxPHw7Q3ISOcj0Z+2/EbbLg+AdYXH4hFkvnelabMlR
 LqAQeY44r5e7nUz2FNW9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760692162; x=
 1760778562; bh=i3DSW/a22IDk40v6+s4WnF+mSLC/w20WnRhj6RQDH8g=; b=m
 OnWVCL+EjHgRDe+zSkghmrAjG5gnRYokab9IELUh1DcK5jNBKnq92SglJkBbVruK
 bK00kGC6kHV8QVkxx6mliHeLRFOsTs5cGd3UvOw1Av2hJMlCd9oa2CrQgqNrGQV+
 oMYe7LaKf7BImEzCNBh/Dcr/3PpV3m/57qbm5sTCGMmJM8tBu0FIwEjbKgKuHTdi
 q51NHPCaHjbQQ8CTvFYPSyBgEF3PQoklaPIvwmdhQLjM2l/qC7ilCt+ippppAMHL
 rEpWYUV0BhoOuwPGd5COvOvxqzEZLNlrDnukPWRGHJzq7NUFeksec0xLN1MqFYlt
 moG238phRoEyrEc9isUtw==
X-ME-Sender: <xms:wQfyaHH5nhYEwIMKQuAIAEHmGAH7jOjtrkLD6ERrk2v2rZUBijVoFQ>
 <xme:wQfyaNQU9GvAcRTvA0SVMF3BjnB-3qrimEgCPiozoxi0cqVAETnQu_7L5q2av6Veh
 7pfHEVsBQM60GZQFDEwSAVBv5WfXyhUDtOkp0AvQ3NgPO876jId-Q>
X-ME-Received: <xmr:wQfyaEueTKOtojJAnmkouDuIW2CnUUSZCxnQcW3_X4nQP2rnNIhTb1wADFw7IRy8aXSH0fihLuwMAKyh7O8fZZZndg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvsh
 hlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifoh
 hrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:wQfyaFIJbExV3wX_VmgzCuLCfRF94QJ8Zagc5RgouuiL3MdSMoBRwQ>
 <xmx:wgfyaJn-upZHtNMBGfC9JJh1pXUfFyQSRYgDRWXhySZRxI7UySZqMw>
 <xmx:wgfyaOJMVXXPovbd8y87o1wAAO4JwQ1M5W1KH3Wjuk_fltkIVrFi7g>
 <xmx:wgfyaG6XMtvEn7Fzsgm13_ifSRdsvygL2FbIp4fUqQAoDvqkQmZDeQ>
 <xmx:wgfyaBSRLDhKpIND3hHm13P9mohBBvC_Mm6BJR22NlWdr7csVN8zKnHC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 05:09:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v7 3/7] mbuf: record mbuf operations history
Date: Fri, 17 Oct 2025 11:09:19 +0200
Message-ID: <21751345.Yz81rIOvuz@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654D9@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <2943496.bcXerOTE6V@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35F654D9@smartserver.smartshare.dk>
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

17/10/2025 09:55, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 17 October 2025 09.32
> >=20
> > 17/10/2025 00:29, Morten Br=C3=B8rup:
> > > > +	/* Calculate total allocated mbufs */
> > > > +	uint64_t total_allocated =3D 0;
> > > > +	for (enum rte_mbuf_history_op op =3D RTE_MBUF_HISTORY_OP_LIB_ALLO=
C;
> > > > +			op < RTE_MBUF_HISTORY_OP_MAX; op++)
> > > > +		total_allocated +=3D stats[op];
> > >
> > > I might be overly cautious here, but the app (or driver) might have a
> > bug, and mark the mbuf with OP_APP_FREE (or OP_PMD_FREE) without
> > actually freeing the mbuf back to the mempool.
> >=20
> > Yes
> >=20
> > > So you should only trust the mempool library (OP_LIB_FREE) to mark
> > the mbuf as actually freed. I.e. start the loop at op =3D
> > RTE_MBUF_HISTORY_OP_LIB_FREE.
> >=20
> > We cannot because these statistics are about the latest state.
> > So if the app marks the mbuf as freed after the library,
> > they should be reported as non allocated.
>=20
> The app cannot mark the mbuf after calling rte_mbuf_raw_free_bulk(). That=
 would be a "use after free" bug.

Yes but it can happen :)
Anyway there is also the transient of mbuf marked by PMD or app
before being marked by the lib.
I think in those cases it is expected to consider the mbuf
as non-allocated in the stats.

> > > The app/driver should eventually call rte_mbuf_raw_free_bulk() or
> > similar to release the mbuf back to the mempool.
> >=20
> > Because we don't know in which order the mbufs are marked
> > in the call stack, we must trust these free ops.
> >=20
> > I really think there is room for improvements in the details of the
> > marks
> > and their usage. I suggest we merge and play with this experimental
> > feature,
> > and discuss in the next cycle how to improve the markers.
> >=20
>=20
> Since it's only a minor detail in the dump function that I'm having minor=
 doubts about, merging as-is is OK with me.
>=20
> It's more important getting the feature included than making it perfect a=
t its introduction - as you mention yourself: it's an experimental feature.

Yes let's play with it, we may discover that the markers should be changed =
more deeply.


