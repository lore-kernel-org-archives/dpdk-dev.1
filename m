Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F24CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 10:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9950C402CE;
	Fri, 19 Sep 2025 12:40:30 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B9B464028F;
 Fri, 19 Sep 2025 12:40:28 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id CCF0C1D00243;
 Fri, 19 Sep 2025 06:40:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758278427;
 x=1758364827; bh=Yr7nWhYFpE3xOKkP0lIAuOvnQakOASjYSG5TPNtDTlI=; b=
 rYhEzVG4Azco0w8cG+WXkjOBU7vIpUYUkFgRrJ+tuF6tQXjR1c5UShAscTx+agsz
 /i8rJdgzoGYVMiAUnqiXxlDMNWe/0pbJ2MykeV9Sc8dBP/bga5qDPPBZneQp0VZ5
 nWhIanE+bZh0crlCuXIQ90mngnkYkUVIxFNjnX1K9yVAtL9z7PSjbBSXoL78u1us
 sEvwQ3XaAcA2EjyHr9XMYTRaA8njK/hO7dwfx1/67PQmnvHnt6GUYnPsdpF7pLq/
 Naa7OBQOKF0Cda2lrIj6XTuoPZsBN2FXwcaJ5lKyBvUPGKpRF6tI/Owb+JcR6ew4
 Mqw0hSMqEsRTt/dfPt1Ffg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758278427; x=
 1758364827; bh=Yr7nWhYFpE3xOKkP0lIAuOvnQakOASjYSG5TPNtDTlI=; b=C
 0JRu6LrlqqojyDBdjih08texek2CYQ8Pxwsp9VCIDUlWaUMdkU8xq5DsgC1tuuc2
 KnfHQDoWu4FvKR8lBVNDy7KQR9EAzQfC7oxqIZnrwdyAxqeQH2Bs3i2HFXbyVq5V
 Huhvj7uLeRdh2GJce6hLovuP2oqNjyKX0/h9Wo74hdu4oqevDPwHuGQfv7vlHAqm
 k/UW37/maGwSKxC5+hY3n3+/NI5SleFY0tDZdWcp5PW0h+HXCt596oeV5hduEwev
 lxSvY+PIdb4LYQEDSMeO398qcCGyakKGbZYiCvzqsFfsPQ9R9hhWjKAnCrmOyaNq
 HZ0UpEIHb6xbEEQXwdtgQ==
X-ME-Sender: <xms:GzPNaDSbvy5MTKhvON7Cj2VyZr17ffgra9TZFFAU1ILiATuKwqdZsg>
 <xme:GzPNaCsVL4-NjXDijjLg-m9nSN1FuMOLTpiEytKkmqHKEBN7Gh4kd4W6f63CGs_NV
 y99GlQ2ePdS87NrdA>
X-ME-Received: <xmr:GzPNaLLmJQkpip--2RYiwEkgXDPqBVZCnGJTc0EK8OLXzRGXfG-tnvBYkKz3OArsk05ZEl_R2LxzqDs4DY5zUMnEPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeellecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrthhhrghgrghtrdguphgukhesghhmrg
 hilhdrtghomhdprhgtphhtthhopehkuhhmrghrrghprghrrghmvghshhelvdesghhmrghi
 lhdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoh
 ephhhujhhirgihuhdrhhhusehfohigmhgrihhlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:GzPNaHmAQkNSKL-h88rs2HhUmeXX9KRK5Lg5qD317B_IA5OFvgiduw>
 <xmx:GzPNaELZNqQejda__WzSOYa8dXrQ2iWKFaBn9-2thnC2H6QVfuFDJg>
 <xmx:GzPNaE6c2R325U9EKYEgX8aeRal7RKfm17B9tcyYAYj1gJXtVZkt7Q>
 <xmx:GzPNaA3ALYM6U-KIJX5rPzHc8I9uF82_HGMw8ZYMtb5PJlbbBpKfvg>
 <xmx:GzPNaGKtsG3bjPUTt_7KLUCGFFThjqNFCGxQNgv1a2asezusM7kginVb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 06:40:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>,
 kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
Cc: stable@dpdk.org, hujiayu.hu@foxmail.com, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] gro: fix payload corruption in coalescing packets
Date: Fri, 19 Sep 2025 12:40:24 +0200
Message-ID: <2732001.3VsfAaAtOV@thomas>
In-Reply-To: <CANxNyatw+4568dh6Spf2TpXzPvesV01rJKiBvH6GyKMnGMBkQA@mail.gmail.com>
References: <20250902104451.81876-1-tathagat.dpdk@gmail.com>
 <CANxNyatw+4568dh6Spf2TpXzPvesV01rJKiBvH6GyKMnGMBkQA@mail.gmail.com>
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

18/09/2025 14:36, kumaraparameshwaran rathinavel:
> Reviewed by : @kumaraparameshwaran rathinavel <kumaraparamesh92@gmail.com>
>=20
> On Tue, Sep 2, 2025 at 4:14=E2=80=AFPM Tathagat Priyadarshi <tathagat.dpd=
k@gmail.com>
> wrote:
>=20
> > In the current implementation when cmp is larger than 0,
> > the new packet is appended to the original packet. However
> > the code is operating on the trailing packet to update the tcp flags
> > which ends up corrupting the payload of the trailing packets.
> >
> > Fixes: 547f29435769 ("gro: fix reordering of packets")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>

Applied, thanks.



