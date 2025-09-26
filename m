Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC355CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C65D940677;
	Fri, 26 Sep 2025 17:43:36 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 9BF7240261
 for <dev@dpdk.org>; Fri, 26 Sep 2025 17:43:35 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id B509C1D00031;
 Fri, 26 Sep 2025 11:43:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 26 Sep 2025 11:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1758901414;
 x=1758987814; bh=z7uK6ns45AXfXw5ra3Wavu94gO5fXsIE0rQPTC9C83s=; b=
 a/0xUrZRELrqtAC/KnYnwcLw9UJFwtPUxcwng2Bh3wpxGrAdfsVLvuMtnyWxm7NO
 Ud9uIuwen8UdW0J649V571TT7T4yAru8BMrt+WAOdvd7fsftP9k75yPgA4BoHvZp
 l1Uyx2K08MpQyHyIhLBBc5isgujkK79GvgRuhGFai1LpYcA3oM8HPraD+fQjcWRM
 zJSki/2eYGTDkcZ69XkCWkHtuVVUnvLm636STunERM7ZfvCJw6en1aXThFIh3TzY
 HCBlSQfRHL6KoEUDy/JL0U5or6gZUCYYs8toHqyszHiVxxVDmnwpd0NaFT8WiBBY
 K9MrgqTPUgp5+Ax/05waig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758901414; x=
 1758987814; bh=z7uK6ns45AXfXw5ra3Wavu94gO5fXsIE0rQPTC9C83s=; b=j
 5N1Zx7bTw/f09/L5j0TYdQweGpkhFZ6HS6wTmYpwX9z+LjaFm3MGFcousZDfLdT+
 BsdDUPooSOqbnz+r6livdFiBe7onLj5UWKgOPpZETf3loIZknh98DssgIwII8sST
 nzR47aLWa989GuGznZMe3DKS9B/3BZs+8r38hZ5Y0eJGkMegcgsjYVl0vZPmhicy
 LBgLg+321UEBW2L9Ms7LLraJNXGDqQbTiPbBQx/etT8ZjtTtldtj4RXeu+oO1H5h
 f4yMClGgox7DxPf8VQJtlBefizhO7iuneRRIa90qHPKpRFIZIJJucX23VmzggIvJ
 4+lI7SrBV8ICFSVCJEfaQ==
X-ME-Sender: <xms:pbTWaL88rK29YSUeL_DgvrV7likD64yBC4zdoVEDNKUqrYcDs9A_WA>
 <xme:pbTWaBzXSqV8al0tf9nOoAnzQQT3yuqczZAH5rU3qLDiJ1iBHZhZvE7J0HVmCSLu1
 uyb0kC8mC_KQ780URI4EuSZC0GaTos4kO9bBbNyT5OGD1Ns1zKXVw>
X-ME-Received: <xmr:pbTWaI4ay6ec7fTQyPrjAKgDUxL9u45Hns1PWege1MyK0fs2TCOuQNqqZy5G0Pjlzwmo_Vay3E5i8vdLClbwSKG-RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohephihiphgvnhhguddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrmh
 gvhhdrghhosghrihgvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegsrhhutggvrdhr
 ihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehvlhgrughimhhirh
 drmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghnghgthhgv
 nhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrg
 hrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:pbTWaI_dphgl_RMHTGNTDockTKVzkEcHFRmrtUlb2meIqlw4FYMwMg>
 <xmx:pbTWaNqNez9HzWIuHEi4DVidseDLJ7wIayG-0h7FXX1y2O_wdj05-Q>
 <xmx:pbTWaJpf7k77vKHazgLMJbemjFdzKJ6e8umx6KaQyHVPz6vKKFNmQA>
 <xmx:pbTWaA2fmZsO6Qmm-xrzk-YcM5rCawOukwoQ6AJzixVaK7C3Q0YOTg>
 <xmx:prTWaOR5r1-7gBiCo2wbixx1X42Smddp6t2vMp4G1uLjaB9tYgcm9k9M>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:43:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 fengchengwen <fengchengwen@huawei.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] hash: replace zero length array
Date: Fri, 26 Sep 2025 17:43:29 +0200
Message-ID: <2679209.vCJZsxu672@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE59@smartserver.smartshare.dk>
References: <20250820211901.21986-1-stephen@networkplumber.org>
 <0b845c31-7c76-4cc4-b1e6-a1912be7898b@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE59@smartserver.smartshare.dk>
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

> > > Zero-length arrays are a GNU C extension and instead use the ISO C99
> > > flexible array member.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.


