Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B6C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:34:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4441A4026D;
	Fri, 27 Jun 2025 19:34:20 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id A7877400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:34:18 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1009FEC0192;
 Fri, 27 Jun 2025 13:34:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 27 Jun 2025 13:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751045658;
 x=1751132058; bh=X1ZNc37KBPF0AwqnbF4DbGm1zNs/G6Rtu9xlLYX+df4=; b=
 Bp6xCEpLfwdIvpem0rHR/2iGpwmPoLdXHK04eXqMrQ3622QBytNrOJSF9CUo9Qjg
 e/rAiiWkMMMuj48VaraBhqUCbCucQlrUif3NEgQC4XbZOQ6QmQlmvRVJWxAw/id+
 gwGeerUzkvKTrIfUjxuu/EKKGT4HedL6cUUoW22zgx/H9Re7Cab3uF+wE3LXpKey
 JNI2QLOPqZ8TrN2yKwHokYnXmqTT6361q/3Z5pZIERsZP8upLBCLBGHMSRylpIym
 gSvhmKy7OQCCqqQKq53SLPVouvzqLohPcyaS3o/aHP5IP4to2EhU1mCkibaggWRh
 KHhyw0r+t0p4KJSLQWBApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751045658; x=
 1751132058; bh=X1ZNc37KBPF0AwqnbF4DbGm1zNs/G6Rtu9xlLYX+df4=; b=P
 lxdPDhup26O193//hQyinm0nN2tTfMM4o/Dnlg/tqTTr87i12wwn7q6gvcF/97Fe
 JXu+lJDl2EHBnxPzQqqPD9YmHgxDMcap+YQk77Qcb9yvKtS65N5yanBc7IzYKBM+
 w4PwMaNNBx2XRs6hauU47TDvt9O5Bt2baEoteRraLZSpB1rp3GbYWzOJtBuAeuI8
 koYRj+Z1gDYNKF93oYP3lZYpRcgW71CtbaVvu+lkp54oILxyILLZ5rgffuL9uDvd
 KYennzBU2MIOKvnNkVGjJqhXSjInoCdLnIRXFiOVDFug5do/On81fXbTqgQLzeJX
 b/xtYRylSrmOkJognb+CA==
X-ME-Sender: <xms:GdZeaBvJfDIAhac6DfuNj3mG3g5whdl4--ZnG5DE1ajGeuK9-lpBJA>
 <xme:GdZeaKf-qbKn90XYwTw-ZrRIq1qjPYJOvso-KtGdYt6lixOHs6d1hXRz2o-yEZtwS
 Xa-EvmtZD3JiINB_A>
X-ME-Received: <xmr:GdZeaEzPf1jwhZ5E7vY0FaJaojrunPNYhvWoXXEYnLadgwiMvvDRAVdXWEI_nlowi6cu2kviEqJKnPN-9PMfIUZ39Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpefftdeuhfehvdekleelveffvdelhfelhedvgedtvddvudeuieevtdfgjedv
 udegfeenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgv
 thdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
 gssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoheprhhorhgv
 thiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheprghnrg
 htohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrgigihhmvg
 drtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhgvnhgsohig
 sehnvhhiughirgdrtghomhdprhgtphhtthhopehtughushiihihnshhkihesmhgrrhhvvg
 hllhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggv
 rhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:GdZeaIP3nMmC3WTgOAyYNetzTnSZDCdbNe2DyRquv0QMsFt0iXmgQQ>
 <xmx:GdZeaB_ZPOH7-FkOk3mT0NpIkdjqXa7ExYn4WVhuN6XKSe35WVO9mw>
 <xmx:GdZeaIXodB1JLKjJWl-gsp7aaiPI1UmDaHVLDnT8ptE3TfAqK7U2CA>
 <xmx:GdZeaCcQ6LbuU5j6D3z3aMfSpAeNvL0gG4-vFP2iYEc6Rq-KNG-R2w>
 <xmx:GtZeaD4wDA5zH1tX0FWVIECnU27wA01FCY3nxHAGmSo5Jla-R10AUScQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 13:34:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Date: Fri, 27 Jun 2025 19:34:14 +0200
Message-ID: <3811264.esFFXGZ24q@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD52@smartserver.smartshare.dk>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <4027143.U75o6juQT5@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD52@smartserver.smartshare.dk>
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

27/06/2025 18:47, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 27 June 2025 17.56
> >=20
> > 24/06/2025 10:03, Morten Br=C3=B8rup:
> > > In eal_mem_set_dump(), when madvise() failed, an incorrect reason was
> > > logged.
> > >
> > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > > Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> >=20
> > We need to track the root cause with Fixes: please.
> >=20
>=20
> I already looked into it, and the bug was there from the initial commit o=
f this function:
> https://git.dpdk.org/dpdk/commit/lib/librte_eal/unix/eal_unix_memory.c?id=
=3Dc4b89ecb64eae773337f3b1367dd8b1f09737f2e

If we don't track this origin in the commit log, it is difficult to know.

> I didn't think the Fixes tag was required if that was the case, but I may=
 have misunderstood this.

Yes we must be explicit and add it.

> Also, it's an insignificant bug, so no need to backport.

A bug is a bug.
LTS maintainers or anyone maintaining his own branch will decide whether to=
 backport.


