Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B9C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 08:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B68402B5;
	Wed,  2 Apr 2025 10:06:01 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id E4CA24029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 10:05:59 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 12F78254022B;
 Wed,  2 Apr 2025 04:05:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 02 Apr 2025 04:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743581158;
 x=1743667558; bh=rpM2atjWqTfVb8k7kxxHiYCYVxvDVKZWeMj3T95p7UQ=; b=
 dpM7YuBQ0c1QZcuLJ4Yp69gU/GmAfsHBqKlAiA8zDfnDe7Ku3/95XxiOrkEIAbrT
 JIPlvuMQjCjtCtow30eBt+JMMn1fHfZa2P02aAkIHrTGg68yBA2qhu60a2QBLuwM
 4TsGxk9AdyPTs7NFBJtlJd2Tq1Ej+NB21BhRh+K5yv4Xb5SFxMtEr5CeWKJ/Id7H
 Rsg9gVZen2HX9qvnd80EniK7piNAvPNLD35wpDiKYdagtyPp7R0itbDuXepfY1Rj
 FPdBWizwOUTcmpWaprk0jJSlX/dpfcwSVsaEoJ2YBP97YWuupIEZW8AaLL0ZPLrY
 3zgPXnr2Vltp5a8osgrwKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743581158; x=
 1743667558; bh=rpM2atjWqTfVb8k7kxxHiYCYVxvDVKZWeMj3T95p7UQ=; b=F
 7kKCfRL4aCbfBkFi8fZGMithMHSkeJuP5wKIut8ZDT0iz/RTvDZFJP6M5E1QtbXU
 rY0N/akaewLKoXLKn2j9F9ojz5ev1VpQRLFGRKp2EcE7FxUd4kC/xfA6pMH9xJF3
 IVSf3v2ao1JmxpBOfibHDlKtd/Vey87iJqid7J9YI5ZYrr7fAetMZE0ZRwDGas9G
 4sl2ET/DqjMA68ZJp2qVxDfvI5uPAV73taJGh4rYaMn4A9Cnb5buG+Hg6lpN0tZj
 TMp1fxmwoGJ/xT2u4jZHQj23T2MjuOugr2CpIKPGm0VjY3oPsl9dvU6dDfYa7gf+
 j4ILOwKoOdaCSkaj+J2ng==
X-ME-Sender: <xms:5u_sZ27f8ax25SeAi4gJ5MC1JPJm3SfHSSy_v_MFRYJdxj-FqWyTHw>
 <xme:5u_sZ_4RF5fB6rasZvsKFltuVFUlQwLfJGEAl5R6zouervhJJJfCf-ZmZt1Ix5Lja
 267x5JmTEG1SGMmBQ>
X-ME-Received: <xmr:5u_sZ1c1heAnqNXBGVFNoFNYt02HNOJrYLHlkDw-_ykOTM_mDsjCe06zIrkEYZW6bBH1_V9zH-YBKVxF322TGtbg4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehudegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:5u_sZzJMuymIJDa5pZZDA9jnKC2YKrGdVPo_J9Kpp4-u5Gy6nOyEVQ>
 <xmx:5u_sZ6IhkOF_4JOAdtX5F6C6zLmOuivzwAraK7WSln0BBTvwq0QZow>
 <xmx:5u_sZ0x61IaPUNpHw4W90cqIHv_4pSwJYMxdBZX6dOHo-ZrSMwHEhQ>
 <xmx:5u_sZ-LrBWezjaZYN4CTrj1sH9ws-c4ntywuFy_D69VilQNqxGsHiw>
 <xmx:5u_sZ3cUdChUeH8Kg3Fl76vUr93FN4vqRBEeOVklhGyGBf1KWopquSLc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 04:05:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
Date: Wed, 02 Apr 2025 10:05:56 +0200
Message-ID: <6827973.mogB4TqSGs@thomas>
In-Reply-To: <20250328105250.3082414-5-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

28/03/2025 11:52, David Marchand:
> --- /dev/null
> +++ b/lib/eal/common/eal_symbol_exports.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Red Hat, Inc.
> + */
> +
> +#ifndef EAL_SYMBOL_EXPORTS_H
> +#define EAL_SYMBOL_EXPORTS_H
> +
> +/* Internal macros for exporting symbols, used by the build system.
> + * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
> + * version this symbol was introduced in.
> + */
> +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> +#define RTE_EXPORT_SYMBOL(a)
> +
> +#endif /* EAL_SYMBOL_EXPORTS_H */

Another thought, there is no specific reason to have a "s"
at the end of this filename.

eal_symbol_export.h looks better to me.
Or simply eal_export.h ?


