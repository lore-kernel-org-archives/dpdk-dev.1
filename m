Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F84C021B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CDBB4278D;
	Wed, 19 Feb 2025 17:47:33 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6014B4270A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:47:31 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2210d92292eso120132995ad.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739983650;
 x=1740588450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kcs5zUDace1HWeWIyFRpk5PWEVUK1xwJyQz/g+Im80M=;
 b=LyOcRfGGTnMOcTOH0eJeWCrOx02cTF8+PUYOlgrB6xpYpAdcrqXSf1FdODsnBv8tFF
 q8FF7iEqZSWu1Oc1IMAbf9vblLO2h/NAsNxqVwuAeHkrMk6XssBKtzQIjuw6ZhQJV1rZ
 yXyIs6aAT5O6nOiqoLDQmIyHEztAe+vn7c2RWNxHR8nD9hDpuJ4i6wZ97JQPRbULHRpF
 5UcIBdvWSTdudirKawYxfjEUWBCBz1cKEMkvTAxPCZIKwDl6C3jYgeqnwzR4Nl1xE1xH
 7J4GWGeXMM5drDEdbryumyLbAWdegdKtL1B1rLJouXy6JVRX89HfnVQ4itC84pSvZJ+f
 Kjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739983650; x=1740588450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kcs5zUDace1HWeWIyFRpk5PWEVUK1xwJyQz/g+Im80M=;
 b=MzTlFqMNpFkfzRDTyAmX8Uk5Ccycs2S1A9xPdII6xfpbNv/SUOZ3PyBbmBmNIsZIhk
 LeXVWujjJKTL9FM5LeCPgAGOTpYe/tMEr63qj3+iPslZqLKe73oHtbpKzu8DAJIFf/4P
 lpYRWjEZGC7Fh64BcYmLc0/btTUHwNydRbswfObev4oAbVP2UnlRxadDawm1bZUKj2iX
 GKh2fvQKwURHq+XilYFnaLYMietCHLk45BmJVbJGWtK2c1GxBo0Vrn9uwA1CyfgLFL7j
 ts0jVJULIF/pCv4HTrTf2QA5phhvzEPxyDXlDdVo9jburBOf4WgOpABnx6NhdBs31YIJ
 NQWQ==
X-Gm-Message-State: AOJu0YysCFmBvAPTrTpaYkBoGCMcPaMZQ+Ys47zG5T3fGAFbjdv3H4JP
 zhaNz8HQQ8yo7UAzNMAivTSeTZKpC8WldmNRr7utNR82FYucwWO+JoG/dKaDsTxfzP7mI0xdNLQ
 0Tcg=
X-Gm-Gg: ASbGncuqtvRe3EkRT+5w47u1GWCGe5GeKXxtteRr1s6OnTfhfJvAmggNpgQBNV5mvxz
 PcMvo/ZclfNs3jAYSOPVYtaAkmTXyprVyFpArL5giGgX4IkXV+NBStQB/hUIWPeYMNhYJwjXU74
 57uKRkle8Kg/mxZ+5VOTL/ZWZelwCPBBw5J8/SkC/0vitQiW+DgEzI0E0kyhzqsN79+N++A0xrR
 yEvc+tpIk0pxuf4fidoyxJbsznxlotn4rN2Eir0klmYxWajNem9/rY52O/rzysb36sp2ngDW+rm
 T34cZJONFiDim3pTkTupK5Ny4iS51jj3F5pX/XLrOvj5zhoT5IYz1S5FkHvEDy8W4mBd
X-Google-Smtp-Source: AGHT+IEvC5aElmM3AsNYICgR8+ZW22BbaqldueRos19xDODNKLTgUse2AMcrzOwD0ILbHD/HwbqY5Q==
X-Received: by 2002:a17:902:ea08:b0:220:ef79:ac9d with SMTP id
 d9443c01a7336-2217098bff3mr65510365ad.31.1739983650447; 
 Wed, 19 Feb 2025 08:47:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d000sm107742705ad.111.2025.02.19.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:47:30 -0800 (PST)
Date: Wed, 19 Feb 2025 08:47:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 3/4] app/test: add tests to find devices
Message-ID: <20250219084728.01634068@hermes.local>
In-Reply-To: <20250212163836.178976-3-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-3-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:34 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> +static struct rte_device *
> +create_pci_dev(const char *name)
> +{
> +	int port_id;
> +	struct rte_ether_addr rand_ea = {0};
> +	rte_eth_random_addr(rand_ea.addr_bytes);

Minor nit, no need to initialize address then call random.
Random always writes the value.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
