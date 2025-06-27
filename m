Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D0C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60BC84026D;
	Fri, 27 Jun 2025 19:35:20 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 5A05C400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:35:19 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 01DC5EC01B7;
 Fri, 27 Jun 2025 13:35:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 27 Jun 2025 13:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751045718;
 x=1751132118; bh=8izFBf4v9DP5CYH1y0GqmM7rpCbkCXyZcqrWDuZPq2M=; b=
 U7YbBBJl5WOfiHOLPeY3TT/wmSkCCfKFj5PY+gh74/vrutMm2ns5y9fdBxQ+46G1
 CaflXi/0UPkTjLgj5TwimQg5WaHCRLXfBSdJVWcu+qSalRiKaX0DgPREZF/b2J+e
 JLdEHzonmnG84FHuL8i4tpLJDgTQqk+kzhqppei4cme6VF0abOkKRxfVU/pAfK9W
 ClH0wLxzYQuUVsZCxCC8md5U8V2lh8bwJt6FnMhVvjFcmH5eTdyuWduImpm2eXgb
 F1Ov8tLKPwRANDguGvji3upU7xbqb9lzBlJO8nWnUSe2VQH7YlL6LwklE1MUshA1
 Gs9ZKGpMGQOsmYqgn0JWog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751045718; x=
 1751132118; bh=8izFBf4v9DP5CYH1y0GqmM7rpCbkCXyZcqrWDuZPq2M=; b=m
 LD06B1By3iyAUoy6l49cLAq8O6WOUrixoxCrEXjE7w5mSCTu0033SJziTTlZ0oA+
 U5tqHW1xwASKiWsmJUQbd0AxEymz5XLXOYpmvTrLgbdjoHO7QSeIE7ilO5YtDcgz
 ZFffaRREzsdKajTmBVdInIlLjPeReN/13nhBEhFAMgDBSkG6YdapR6+c1EC7ipfv
 HRlsLk+HxQcjVMsiV1SRyuSvs2KQhDAIA9vA1cZstV2zPkF04e0eAxIG6H6DwgJ6
 N2znC3djCJ44/xdwtAy3fXcdEklOhOVh2GDq+CucUIRZ8FNXWocgu87KPzI3/Vbp
 cc0xSlG570KKWYHGbWHwg==
X-ME-Sender: <xms:VtZeaGod1ehGzinfoG6pxudR7ScPZHu4JA1imv7rOKD2kH3X1oA7Ww>
 <xme:VtZeaEre2OwO3wtMd1Xqo95oybFmEX9IC5Jxp_FDXqxXZBroEACYH6xXmoS9O7BfE
 P04COjuku0I1d4tGg>
X-ME-Received: <xmr:VtZeaLN5pb_pY8mOqI80HRPxiIK5nOMcfwFjZMRj4oKzsgvBM_t-wVM9pig6NLLg1x3OW42fIZs5r23ymdz6sRjWHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvg
 hmshdrtghomhdprhgtphhtthhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhs
 ohhfthdrtghomhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvg
 hlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghl
 rdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtoheptghhvghnsghogiesnhhvihguihgrrdgtohhmpdhrtghpthht
 ohepthguuhhsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:VtZeaF4Ps_Q_nKq8ya3c_BKkw3uN1REdWkU1huHdJzfJAk2h9Fn5Ng>
 <xmx:VtZeaF7D9_q4E7FDe-3o3ltuKFHYYNAYXIqm7P3Q4119R5h30lpdIw>
 <xmx:VtZeaFg_k5QAZpE-VR3DumWSdiYQf5KLq1oEoaW9oW3tG2EkEiz4pw>
 <xmx:VtZeaP6ZWLUe-BtLFxIUaHoxy3PpAyTxinjttNqj8PR4UUPL9ZuMmA>
 <xmx:VtZeaLlZY_19EYWOsmdale_tUb-BpWPLGj2YSZ_ODk28Y9DsfhCmg0nt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 13:35:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative return
 value
Date: Fri, 27 Jun 2025 19:35:16 +0200
Message-ID: <6180155.ReJHH8Nr61@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD51@smartserver.smartshare.dk>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <17086222.mzqWEpnEhh@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD51@smartserver.smartshare.dk>
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

27/06/2025 18:38, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 27 June 2025 17.58
> >=20
> > 24/06/2025 10:03, Morten Br=C3=B8rup:
> > > +		if ((ssize_t)page_size < 0)
> > > +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> > > +					errno =3D=3D 0 ? "Indeterminate" :
> > strerror(errno));
> >=20
> > We don't want more rte_panic().
> > You could log the problem and return 0 here.
> > It will be a problem later, but it may allow the application to cleanup
> > instead of abrupting crashing.
>=20
> Disagree.
> That would be likely to cause crash with division by zero later.
> Better to fail early.

Which division by zero?

I don't think a library should take this decision on behalf of the app.


