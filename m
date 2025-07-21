Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89323C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC7F402E2;
	Mon, 21 Jul 2025 17:00:41 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 9BD3840297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:00:40 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-315f6b20cf9so4680222a91.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753110040;
 x=1753714840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jH/kAQsJXaZv9WCc/mQ3BXDyx51k4Bz8aLcHIFYPzXo=;
 b=h/9EFzTRHtKvMBCDzP5hoYO5e300DSvfWQ3qt9vB+dcUBJsiZkCCF3Jl49PXzK8lrm
 XVjsskzPZZ51J2ezaN0Utvi2hyQamBH8xeZgUedh2wKCf+b3MCsAvTRxb5CF/BSPpVyM
 N+cq3wPB1ute9uGaX01ZpC3D1wSZsx+7vnM07ZDO8ctIwEVzZpC+VOVWvdTge7o22jOG
 oxV4ZD4bq7rBpoCRCarNZSqfkdNJmg++dKYAakxQXJrskycxdGtGVzst06QhiKuB+BN9
 Ie9aMydVpCPCLPC5HwHHT2IZICqOOwj2orP5z6JHBiFc1Z6nGxsmxlpNME/acddoL1oP
 f9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753110040; x=1753714840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH/kAQsJXaZv9WCc/mQ3BXDyx51k4Bz8aLcHIFYPzXo=;
 b=l+2NSNay5YRPBX9NTkQ4Ceo3L4XZdRIEMCRT430em4F8/bjSs05pi60Ijr3HOuaMsY
 OnB88rKEPRcwFGUelCMbcc0Jlm04HscKQfU5Cx95vOHBR3Uq/aIAJxTnJVDTowqRlio+
 t0c5d1hxLVL/KetAigEP0a4vFfcYLm5PRWhXPBacuB00I/VrOr3OsQteTVjDzgwxaudq
 slTYJLXbwsnk+hoPfN78/yGFgthtZu9lGSJpRxrmH3ssRFJx6DSR38kyQj11meMHm+KV
 xwZaEX+2uDIno4qldFdDrlpiv8I6BEBi+e6V/6Hhp/7HbktzVZQLl9a38TWY3OVBT1YW
 WeRA==
X-Gm-Message-State: AOJu0YxlldE2bj9Nj3Gl2nEE3sjHUC6BnXKjfSbNRzBFY4Oz2TJaRPIk
 eOPhQHvEY/tUWse3lfl352TvZu7PzDb6/c3O+Alhr98GyCVfOm5v914Ilqt7sOBygEg=
X-Gm-Gg: ASbGncs/nh5zwg4/MifMk6ldsuzOk6m75w9ZzFsTLk3pOTtsXEn6+d5hV1fy/WT+Zsr
 uk5Zw25iajgZZLZegeKUzraBW+2WOFC1fUOth2bbZRDDq6uOxWInRljQyQkFH5yJA+2UvksigMx
 gThO8Phrg7Yiq8r4TLsgmV921Y3PM80jk+K/8AYTOkE7qNikfF+OuDto7PkXQpa3H86DOnvtW6H
 HN4ZxK2OufxbV/1BvVayNIohP26TOndTIg6pevlX2JQjYyWQ/iopCwmK4mG3U0NB8xPqYD7YD3u
 eIkX6Qxr1GEeiIWdJqiPV772r9+I6is33fbRDPbiXQJAxFK90anJXFc5DI/VECrZV7ws+FW7ZEP
 AC9ICl1QhpGFqH00BYOTrFTRFx4D/p+UgQnU/dwTjisiJDF5WODXIe2NV56pRMEXAZ6TFNt9NvG
 8=
X-Google-Smtp-Source: AGHT+IGdb5qqsPC2abjFprIb3bI5axvxkwMeqfUXt7KHArVHnhcitgtkJu7KBkxOnS7zFtKsJ8jvEQ==
X-Received: by 2002:a17:90b:3d10:b0:315:6f2b:ce5a with SMTP id
 98e67ed59e1d1-31c9f3c5b7fmr30102807a91.11.1753110039546; 
 Mon, 21 Jul 2025 08:00:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f1b8f89sm10379785a91.9.2025.07.21.08.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:00:39 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:00:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>, "Bruce
 Richardson" <bruce.richardson@intel.com>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] mbuf: de-inline sanity checking a reinitialized mbuf
Message-ID: <20250721080036.6a9d3337@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDB9@smartserver.smartshare.dk>
References: <20250719102315.435921-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB9@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 19 Jul 2025 16:14:42 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

Good to see this a not inline.

> Exporting the new APIs as non-experimental (i.e. using RTE_EXPORT_SYMBOL(=
) instead of RTE_EXPORT_EXPERIMENTAL_SYMBOL() in the C file, and omitting _=
_rte_experimental in the header file, as shown below) works, but is that ac=
ceptable?

These can be exported without being experimental.
Experimental is optional for new symbols, to allow for future API changes.
But this has been around for a long time.
