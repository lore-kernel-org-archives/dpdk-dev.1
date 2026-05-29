Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED62CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54ED74021E;
	Fri, 29 May 2026 17:25:43 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id BEF65400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:25:41 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304d555293aso1032826eec.0
 for <dev@dpdk.org>; Fri, 29 May 2026 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780068341;
 x=1780673141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6qkwgPVqbsLu3Sl23GDEPpL2KovYrg7Z7y9BKgaWns=;
 b=Zr0rqY1mTu1CgEOlw15qm6pipIPaEQhj+c3FRImZsYVwE3q0GY7nLJfhc0TMo7iTIe
 UM6AwO0m5Z2kG5ivdJZf8B6eMcPCH5Zk3a4EH8bQdv3LksU97ETFekrulqb1g0TAgqHY
 InrcufCU9whSXSyeOIOKrC0Y3KBBaVuFx+ZnfojraM1NeSlf2rxVj67nFNZZj7VcGyKf
 ikUk8PNX5/HHjMpIlWcDvwhRRZhw67SPJ8pEQjl/iDr47BMg0MRh+qHWYKd7vU9AEZEx
 qDmj61ZkYafclVyidYKpDkAX4800JoQC+dcusNoeT+6TBR5Uv2n3zsNdwcJfxEjeqkX6
 cHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068341; x=1780673141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o6qkwgPVqbsLu3Sl23GDEPpL2KovYrg7Z7y9BKgaWns=;
 b=mndkcmku0uTB8FKThTyipqi1TjbyI6czZ0TunLSvAxOwX29ImHNWBu3r47WySZM5cZ
 jSz6fMmlZD3hZVg313XrUFkExBLjCBW7HFn9trINLWyiTu00LCA3MML8uAZ4ZaeExAcD
 39IiuwBH2Orc93YavXaAMHXXgg8D6Detz9UitR0u5cfikURHtRetu/+eSuoZsfdyB8vD
 pQpoRkIeBSYZPnyDG7E6lDv4kkirmpvqBg8rcGUi2uIUQ8CDGSEkcqxjTbS0PzQsATGe
 du7AqH0RRLH7e/LlRlmOFj7KNeNJBNoiXd4yCS58TdHPcgxeCMDqkXVzcRAWXrHGqhtL
 r0oQ==
X-Gm-Message-State: AOJu0Yxe9x/zpy7Ys+rCsktGtkTuS53bwc9Y0KT2QWkjemtJZsZ+nlTE
 ZHYGirIRaK0GUouP2QXC6lYosfA3HbKKQK8X6wXnb896Dfdi4gm1FuZX67rhxpCpn5A=
X-Gm-Gg: Acq92OEXlKp6OdjrFAE/0bAr+5kcp9H6m/qRFqsLfhuqDFjKk51b3166wno4ZVgDEpo
 SVEa4Mwdk+FgdAX6uGDaRpPu2vPDwX2ASXuHbupmGxaMcAqSRtFW040flhyg8pYAK1wssYHFPcP
 qzWF1SjgJoJHmvhqqGiMpiEG5bR+BawEHXtAynJKctdyvDvk4Ju86wkZm40HOjgJP8dUoPMpLuq
 zGOOCWibyP1sGhbkpbkg4tXNA3zjhakqKK0EKVIf1Gt5M24bsAhYIn7Hz2VMND86tKw91qJ49oU
 RxIw068HS4/q4cZyVrSAhvwi2+uYXlW+l9Xs0jKYMXGHQteXOa6+WTyISzOx0rh+5rPdvpruu08
 zG463qeogoBMQSUUDVDORDaNN2ilXIqtOMmBZTJ8n4BSyWRXlsk1wEdCZOWQ7j0W9Y0yqRmKQJl
 sPzcIC6e2qZlc49BJay1JP3UEbLjahHE6Wvv09PTLlPmIOeYcXWE/INnaG3YgdgYYqsxFCAwOAH
 yw=
X-Received: by 2002:a05:7300:641c:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-304fa4a97e1mr171832eec.4.1780068340660; 
 Fri, 29 May 2026 08:25:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm1609558eec.1.2026.05.29.08.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:25:40 -0700 (PDT)
Date: Fri, 29 May 2026 08:25:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 "Anoob Joseph" <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>
Subject: Re: [v1] crypto/cnxk: add ML crypto support
Message-ID: <20260529082530.3a57c61f@phoenix.local>
In-Reply-To: <20260529091330.6308-1-gmuthukrishn@marvell.com>
References: <20260529091330.6308-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 29 May 2026 14:43:26 +0530
Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com> wrote:

> +/* ML table address and length */
> +struct re_ml_entry {
> +	const uint8_t *data;
> +	int len;
> +};
Better to use unsigned for size like size_t

> +
> +struct re_ml_tbl {
> +	PLT_ATOMIC(uint64_t) refcount;
> +	uint8_t ml_tbl[];
> +};
> +
> +const uint8_t re_mlkem_zeta_tbl[RE_MLKEM_ZETA_LEN] = {
Tables should be local to file so static?
