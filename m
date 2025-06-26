Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F132C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 15:22:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B074021F;
	Thu, 26 Jun 2025 17:21:59 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id D8A3740156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 17:21:58 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 50622140003F;
 Thu, 26 Jun 2025 11:21:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 26 Jun 2025 11:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750951318;
 x=1751037718; bh=tEW+bSTThh5Y+TfJzcr3W6kLwZojxIOqfDfOMbNAKWI=; b=
 yleBnn5UdhuIb/nTTxd7gqX6Q3J/YTevJVurgrRT1Be0jtA2FXQ0FrU7kusealwZ
 3cEanCnnn7zPIN9VYi7BJbGE+iVLnncqY+RHOXhH0yiLw8oH2DWUMBBOJFHqoVu/
 20R3DT/oVv3b6x+bGlq9CML6zqFtMD4QjTuQ2F57q7BwfGKOWLKBu+4dQ4n8Krr8
 fJNP3N4J4lZ2RU+OqvmbdcDLjQ08LGUlEHMFrR0iQDJXWtwLhNBVzqsKkmyDpYhh
 qEK3BRwjIF+Gw1sGflMb9rdqwmpAxMB4++Ub7r53648c2IoK9gc7Ul3WwY1hzY14
 1FNAhMawK+vzWlrvj518oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750951318; x=
 1751037718; bh=tEW+bSTThh5Y+TfJzcr3W6kLwZojxIOqfDfOMbNAKWI=; b=H
 9UhUigqMf4ChhOxIdGxynfr2rC77ttMS2wRy2KA8ju7ElypA1J3FmuNDnYSjFayu
 sFr+dB8MRQPwCAeF3rJdhfF9oN/cQp3QKDD/hCghpBc2fMNXTaeXnBxmKi3JPitp
 rDRw9AVk2TseYuG998WxlETEFj8N03fKo5LGcxmIQX+S+/LUHpt0xd29B1NTOVqX
 Du3XDzJeTLPsxPCyiCLSKO4ELYcaMt1oKR9qPxh9Qe3xmrd+vVHJSnkCi7JBImhU
 rcG5psBA/L44lCwnFLm1ZZGJyQRc4MymonWzLt/zRFTlbK46pcokOnoRFrHqhfQD
 dy5/czL7CDLw1JS8d4XPg==
X-ME-Sender: <xms:lmVdaBopDqWglHdZ8PeXaXPAJuGajhk9IacsbIiSUXiXwF7Q5wHsVA>
 <xme:lmVdaDr44rfKqBL99wHP1PfXNR6Gid7iTe20WtxzXIvvrFpxSO1R2OurD45qHEtYc
 UqJvmSky2wgDfmFvA>
X-ME-Received: <xmr:lmVdaOMkgE-vJjui8hC4srSfPc9fP61QT0Yy4HAAmy5skhe2h4cOnNdFC28tPDBi4V0iEOy_MkYQURwdup4enmDKPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdelveej
 ueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtg
 hpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghp
 thhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmh
 grthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
 pdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtth
 hopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehrrghslhgr
 nhgusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:lmVdaM4S2xpjNgRkkSZkEkb3ADP3cLXoydQvnx-J7G9VHiNKOyV7zw>
 <xmx:lmVdaA7aV3gMdFplZeYuvmI0YzVMHhyx0aLrFlZ-V9IfpTI59XBOgw>
 <xmx:lmVdaEgIH9Ut2JTkq3imf9bge0olTWSI-qllkZmMkKNVJtGldsxxYg>
 <xmx:lmVdaC7IpCQdWpu46HLUNb1bx5lCBLSkvPdmMM_nyei4FnMmGOEiCg>
 <xmx:lmVdaBR6QBOrhzYq84hBQGdizC1bZW2PC_wk-AeXa-rjC-ye99-slB2f>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 11:21:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Slava Ovsiienko <viacheslavo@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 dev <dev@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH v2 2/3] net/mlx5: add new devarg for Tx queue consecutive
 memory
Date: Thu, 26 Jun 2025 17:21:55 +0200
Message-ID: <5112176.f0I1acK8xe@thomas>
In-Reply-To: <20250626072954.6ca04456@hermes.local>
References: <20250623183456.130666-1-bingz@nvidia.com>
 <PH7PR12MB6905F9250E91DEE1DE0BF4E8D07AA@PH7PR12MB6905.namprd12.prod.outlook.com>
 <20250626072954.6ca04456@hermes.local>
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

26/06/2025 16:29, Stephen Hemminger:
> On Thu, 26 Jun 2025 13:18:18 +0000
> Bing Zhao <bingz@nvidia.com> wrote:
>=20
> > Hi Stephen,
> >=20
> > Thanks for your review and comments. I will add the description about t=
he new devarg in our mlx5.rst file to have a detailed description.
> > Indeed, after some review and internal call discussion with our datapat=
h experts. We would like to change the devarg a little bit but not only 0 /=
 1 as a chicken bit.
> >=20
> > Since the memory accessing footprints and orders may impact the perform=
ance. In the perf test, we found that the alignment of the queue address ma=
y impact it. The basic starting address alignment is system page size, but =
it can be bigger.
> > So the new devarg use will be the log value of the alignment for all qu=
eues=E2=80=99 starting addresses. And on different CPU architectures / gene=
rations that have different LLC systems can try to use different alignment =
to get the best performance without rebuilding the binary application from =
the source code and it is configurable. WDYT?
>=20
> Please make it automatic, the driver already has too many config bits.
> The users should just get good performance with the default.
> If driver needs to it should look at any/all system info to determine wha=
t the best setting is.

The default would be good enough, but it looks very difficult to know the b=
est value.
That's why the idea is to allow some tuning here.

I agree there are too many devargs for most users,
but at the same time DPDK is a project to get the best performance,
that's why there are so many tuning possible.
I think we can meet both goals by making clear which options are for advanc=
ed tuning,
so a basic user will not mess with with such options which have a good defa=
ult by the way.


