Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79607CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 21:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5339F40609;
	Thu,  2 Oct 2025 23:23:57 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 867BE40616
 for <dev@dpdk.org>; Thu,  2 Oct 2025 23:23:56 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id AB3341D000D1;
 Thu,  2 Oct 2025 17:23:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 17:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759440235;
 x=1759526635; bh=w+ByTXwd8s2W8uujuQm2SFQA9+ov9J0SDoyVrMbRmgo=; b=
 hIrgUb6oZDX4cnpq2L9jjVu1onyhnaM7PN4R9xZ1lxCkhvQQIJ0GuuucN0qp8iv8
 X74rc8AN3pCTyGjD8Gk2x1RSFdl4GCJhJz4n8PJfE+i6xxfGEuyOkxy0mgyTAdD5
 wE6ehS552Iz8V4UwjBNuZtHiOTAA51U+mHnoG7E4CnqxMpEAQiFThkhCxslf59Q8
 Mc/hi/rs0WDFWHHWnxHGC5MqjFUsebhcsrFzfw7AABpKnAINhljsWZ5eUg8ODP2z
 oQ49Lu4yNDKRH8m1iKMoFBJYudnPMLfuOEFYMHQOoi/xrX+GclJrUngcBJmmvkXW
 2gfFdQ7WuR9K6KN8u2mBcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759440235; x=
 1759526635; bh=w+ByTXwd8s2W8uujuQm2SFQA9+ov9J0SDoyVrMbRmgo=; b=e
 ckNpD458uPKF/MbpWbkK3/GlhrXCQ0p0Djd22YSeCZ6hmO7D5W43IPz7557+eW/l
 ME3sGE5nX8mqIuAHXKbclplyVls6zcGWhvwp6rsXQaKWoMvrVIzH59hRtfdZqniC
 ItbN5fJ6GSKcKm7G2iEPFAI2avh9BbfuYZgiTU8FQ699GQY+c3CLPxaPFdWXYQ87
 bXT4ea7y19T93Sz7YEmYVb5nnVYjtH3HDXJhmNIM5PLJpLM98EWOBkEkj7rKZR6K
 CpnBv/WBXPcOH6HIoANBKbUBoCq8XOR+R7wnoHjPbH7HjXDp3mK46UBLrnkxAhe+
 e0hBKJWpYJ4EuaY5Thy4g==
X-ME-Sender: <xms:au3eaNLhceZAHIvHYGs8HmHHkZUWNE2xhmqjeVfqvdh1v6KYN4xFSA>
 <xme:au3eaCEs9LxwgR2K6yDX9NwFIPtAXLE_v3Fu45tCsmUWS5WouqM-Ii4_8SC7z0VOH
 UHLQ5kOHzYTdNHcpj7c8I_hmFDH2U7DFttHPuosi78c4S6H13QcDi0>
X-ME-Received: <xmr:au3eaBS4QXZr4MhO681cJB5-igYs4P-iZYMjk9yEQkVepe4P7ekH1SrAPtrLL5CRLoYyGWnbPWj7LIf2dwV4sItiPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjedtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslh
 grvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgu
 shhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorh
 hkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:au3eaOeZPmcpl9aySW5QpBMgUAnEGgrjos2INyJ6_YJEizvaKPPeFw>
 <xmx:au3eaApspK-KevgSS6385A2hep8OXKYxkTlaKRwVshRQGtQVCsEWYg>
 <xmx:au3eaP9rOKtuVL3pkoq99ETVIbTx5SAjK6OILRs9ZwW8JyyXllhCdQ>
 <xmx:au3eaMfklq-T87_9yYJw56W1mmaa3Z2pY7PK5r1H4X4yQM6Dfiem2g>
 <xmx:a-3eaK2n_CDsjaLfFHL8ZQ9lrfxwJgiTuidaYU6rZ4cI_yoiYSLoTjxf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 17:23:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>, viacheslavo@nvidia.com, 
 bruce.richardson@intel.com, stephen@networkplumber.org
Subject: Re: [PATCH v3 2/5] mbuf: record mbuf operations history
Date: Thu, 02 Oct 2025 23:23:52 +0200
Message-ID: <14407511.EVyyLHbfrO@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6548D@smartserver.smartshare.dk>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-3-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F6548D@smartserver.smartshare.dk>
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

02/10/2025 09:37, Morten Br=C3=B8rup:
> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > --- a/config/meson.build
> > +++ b/config/meson.build
> > @@ -379,6 +379,7 @@ if get_option('mbuf_refcnt_atomic')
> >      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
> >  endif
> >  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
> > +dpdk_conf.set10('RTE_MBUF_HISTORY_DEBUG',
> > get_option('enable_mbuf_history'))
>=20
> Not really important, just a suggestion:
> The mempool library has its debug options defined in /config/rte_config.h.
> For consistency, the mbuf history debug option also belongs in /config/rt=
e_config.h, instead of being a meson option.
> It also means using "#ifdef RTE_MBUF_HISTORY_DEBUG" instead of "#if RTE_M=
BUF_HISTORY_DEBUG".

Yes I was thinking about it.
The separation between rte_config.h and meson_options.txt is not clear.
The idea was to keep the list of Meson options short.
But I think we should make more options visible to most users.

The first thing I will fix in the next revision
(after removing this option from Meson)
is to better document the mbuf debug options.

In future we should create a single debug option in Meson for simplicity.
I think about such a Meson option to enable some debugs selectively:
	debug=3Dassert,dma,rcu,mempool,mbuf-sanity,mbuf-history,flow



