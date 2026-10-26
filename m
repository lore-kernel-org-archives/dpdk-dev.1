Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591F606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Tjvk62SI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1FD402A3;
	Mon, 26 Oct 2026 18:03:43 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 4F21B40275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 18:03:42 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cd62c570b5dso1683985a12.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793034221;
 x=1793639021; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oQo6Dh+dM1wnFxUxHC8yhp3aZJOywYi21qn98eUnxSs=;
 b=Tjvk62SI3UN52xXU/4suG8XpTg1x9vKJ0SPPzbKC2jFdIC3ied+hlH0f96qHenTdMm
 apxTJqlr5y/CKWaZt8Wp7Aj+5BDgXkYFBHv2vgWNKGH/OThK4/KOm28D/bVRhsyPqyYi
 qhaS2YhNZyk19xLNg5Q/LBoUueWRjiMUwXZXUaZYTsFhvkyssr4nRj1N5QAd/NV70FKB
 69Y/JdBVHS2KSrckibat//Y9Ai34rWrqlA3+OBklYV5zuU9ed+86q2bxSTrmaEnrisyw
 ZGJDvZjm5/9jLhdVcI65kFF4EN9NZ/ErAE2nZurWnLBiQYuMI/9evXsWZDEifwu3fa0a
 YYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034221; x=1793639021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oQo6Dh+dM1wnFxUxHC8yhp3aZJOywYi21qn98eUnxSs=;
 b=l4Phbc7EuWm/GbcaTU80u4HEdWRuyZZVty1KMp6x1CvWmNtO0T0JmYLMGimFEvnnuk
 ta62Ok18bp92TBQfq5v8qtmDjyKVgbKAUXUCuPBAUiUHnJ6dAbWL+umMEncR2RXaxexh
 rVHHB4aMeHuNu/0/E2+fFdFZcU2Z8BcItTzHJCWre5a1vT7YNXQXiIL2KfJ31zDdDTie
 G2MpDFp1TtRO8NfFYXy8Tq9+SrBHV54bYKJb4v7H5in/CXKsgLmUsWWI/HZJhMwyAmFl
 oIJopVYEqItjhEOJJZA8foTAVEKMLm+7UFzwxirtZbqL7Wr1FWnIHMoDpL3iFVLAMM1g
 QXxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTHpYliVQxkYJs6c9VqK/qt9ND63rCJ+qiPWKaxl1kJ+4X17v8Q2SbBkypZ4dPVslo6oo=@dpdk.org
X-Gm-Message-State: AFq9FYKTJ00LgctlgI6J8t15l40UVOQSbYyRriyecLdfocVhDJJy4OIF
 ert2j/pTRkQ611RJUUU3U+eanehqHKPB50P7yl4ePNizm0rFpdtwAR24r/otIXBDz5A=
X-Gm-Gg: AYBFou1MeaBL0J0jl6xjhRosrQcS7TkRWIDIdFitHb7Wk/c3Fd0mL6RbB5m3l7OObW6
 zhH1nJ0QdDH+yMcpYjqYgixtF4kVLaaPYxUBkeLM8LHq6MzHbkubIe9L7n/Y98DoBw0l22KlPGP
 0aIN0szoNNPE5CWSDJPCOuwFDPc6ix5sxqgDdtQk+X1tiDAphAQmsPX7V+P4GVhWVjusJ8EXz54
 UZ33nAeUgFFoC+m30DLTrVyvUQVLV1zO+I9bp4YmkzlUbEZfhozBOXc3R/4yM6/dKXj/FMfo89S
 Uts2VJ4B+bCPyk/IGcOoVYZfkT6DNZCR2Lm7sm2nl/ms4AurNDl8wMW9wgmgaGsqcpR7/Nzr9g7
 VBydiwdUe3jlviP5cn8Z0PYkM6P+EgrddpVAKYivGNTarKJWxeoUti+Ec7tESz/PcpNXwp3oj++
 epX46OABQtu/gD7mb8QhhjIS6psBooHdnBlu6OuREof35w0hBFtzOVn1ISglXCotPF8Bn91j4GJ
 eqLYvwFLpfa0++GxCm1U4V+T/DZIovsRDlMp7kJewnCXEmFONEKjLlCfjTa2fZy6jO+PvgZBx2Y
 hkqsxsSns+f6+zMT07eOEA==
X-Received: by 2002:a17:90b:37ce:b0:3a4:adea:50ad with SMTP id
 98e67ed59e1d1-3adeae8b8demr6246114a91.27.1793034220493; 
 Mon, 26 Oct 2026 10:03:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404432a5sm259474a91.9.2026.10.26.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:03:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:03:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: move to polling for LSC interrupts
Message-ID: <20261026100336.15d7ae6b@phoenix.local>
In-Reply-To: <20261026160400.1290443-1-dsosnowski@nvidia.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 17:04:00 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> +/**
> + * Retrieve the carrier state of a device.
> + *
> + * The IFF_RUNNING flag reported by SIOCGIFFLAGS reflects the RFC 2863
> + * operational state, which the kernel only refreshes from its link watch
> + * work queue and which may therefore lag the actual carrier by up to a
> + * second. ETHTOOL_GLINK reports the carrier directly, and additionally
> + * flushes any link watch event still pending for the device.
> + *
> + * @param dev
> + *   Pointer to Ethernet device structure.
> + *
> + * @return
> + *   1 if the carrier is up, 0 otherwise.
> + *   Negative errno value is returned on error.
> + */
> +int
> +mlx5_link_carrier_get(struct rte_eth_dev *dev)
> +{
> +	struct ethtool_value ecmd = {
> +		.cmd = ETHTOOL_GLINK,
> +	};
> +	struct ifreq ifr;
> +	int ret;
> +
> +	memset(&ifr, 0, sizeof(ifr));

Odd, why not use structure initialization for both?
