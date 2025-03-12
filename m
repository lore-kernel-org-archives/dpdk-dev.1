Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376BC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 17:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E312040663;
	Wed, 12 Mar 2025 18:24:29 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id AC3B2402D3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 18:24:28 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E61E425402E8;
 Wed, 12 Mar 2025 13:24:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 13:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741800267;
 x=1741886667; bh=OwbkELMZR5yH0ekWRkiN+TIznzFDsjp5QiXOy7bjVZs=; b=
 uk/aVo5MDgoba66VaiUDqltWvRhbtW2e0XPixjpClZ7lOPzMwUPygEjI8OexA86S
 7gZIBm9o37savRV4KZGxLd6REUM4d/numcBnbreHrXqKp53rEMBwgdKq9Ob6yxwR
 e24Xxfr7ZhRBo7QfL+UAI4whxxXxynymseP2XtR1gbByYZdZhgYg0BCEsQgjTdRo
 seY+YgEVb8805q2IrH3jTCiXQHWLxdS9x4lR6fQ+7ngklUiPFlqelJ5rCcBC236o
 eliTXZpKra/d4PqquNSEhFkNYXDnB3F9tGts5FbuHZj9LpP+Jt/z36SdASVkV5ml
 6PzqaWoplZd9sOB5Buoy2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741800267; x=
 1741886667; bh=OwbkELMZR5yH0ekWRkiN+TIznzFDsjp5QiXOy7bjVZs=; b=1
 rrVCGPp5qgIIjNUC5zIJgdAuLDP4cpyHgSMjrWCiZRPQjho04QS83AhEVqBBhYs5
 ixG80GBpHpxlqz00hLB1PnjFw8CCE643/+T/zq59Eea/+HVK/tOJjq+biCElWDz/
 IcWVRIeoblv1QIxHQqd1lQZpFQuSZPkOOw/eHwxmuRPpAM76ye6ckjB0DqVRxbQ0
 PfOiTjJ/cMCBP8k0MCFygF8TQtkkZ/xX0HHLEPT3e1Ms2eUaFFTCwPf2whtZfY65
 Z5e+I5Fs4zo3X6mTKGTZu1rA3df5reO/gPzle2k7kOVcb3tbRT/KOzYQRhx35qYk
 2G2shkI4YyZXQUqWlaRbQ==
X-ME-Sender: <xms:S8PRZ_PhmhQCbSLye7uN9-Kz5hmK7mu0o9h9XYIbf-8oUwGDBwwRbA>
 <xme:S8PRZ5-i7DrljZLo64q3HLBKHpnvG5eHxGJZy6TKvAX6LP676FbEVZVmOoDuBU_lR
 saChhCGMJ9-_pk69Q>
X-ME-Received: <xmr:S8PRZ-Rv0HSfzw7nn6fVYmk_3OA4Q6tCFB5bqk4y-il9VDOSmRLdeTxiK-LHTJBFq3k8vDexNOd1e0WWZlWaPQCfZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehigh
 hoohhtohhrohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgv
 thifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepghgvthgvlhhsohhnsehnvh
 hiughirgdrtghomhdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:S8PRZzvoWSTxyxngoK7k8Dyo7yE_gemAx5hdng0Et3pBIz7zE2Nggw>
 <xmx:S8PRZ3enlL3SAu54LZpuS9MZPZau0MpFNNrmAYaWGxumi48V42uMrA>
 <xmx:S8PRZ_3TWlt_INLC7rleyOAsdLCLi8fkUt_XJ-8sUYMG8LJI9kX6Cg>
 <xmx:S8PRZz8i-8Vy444H-LMm4BLuRg95-lbVyWnar0cQUNLynZ4vjm77Tg>
 <xmx:S8PRZ_SpoJ4RcI0yDMpCNyWt3pp0bAMvPFJ-2XFg7Sku2j0RyZh7A4QL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 13:24:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Igor Gutorov <igootorov@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>, mkashani@nvidia.com,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] rust: support DPDK API
Date: Wed, 12 Mar 2025 18:24:25 +0100
Message-ID: <8897267.aoefvbuG5b@thomas>
In-Reply-To: <CAL7bPf0QpK_WPoMNmoS7a-WZTUsbFEpB6J1pZssv54VJwotPjg@mail.gmail.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310091844.4a3ff0d1@hermes.local>
 <CAL7bPf0QpK_WPoMNmoS7a-WZTUsbFEpB6J1pZssv54VJwotPjg@mail.gmail.com>
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

12/03/2025 16:29, Igor Gutorov:
> On Mon, Mar 10, 2025 at 7:34=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > The real benefit would the ability to support PMD's built in Rust.
>=20
> Having DPDK libraries as Rust crates would be beneficial as well. The
> mempool library in particular is something I've wanted to use in some
> Rust projects. I've previously considered either porting this library
> or writing a safe API around bindings, but never actually got to
> implementing it yet. IMO, the benefit to DPDK would be more users,
> more contributors, etc.

That's all what we want: being helpful :)





