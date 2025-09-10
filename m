Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479FCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 00:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BDE0402D4;
	Wed, 10 Sep 2025 02:50:14 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 6DAAE402D1
 for <dev@dpdk.org>; Wed, 10 Sep 2025 02:50:13 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso8378395e9.3
 for <dev@dpdk.org>; Tue, 09 Sep 2025 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757465413;
 x=1758070213; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZEWYUOsl+tfq/TBs2IcBXjp2vG7EmMRZ2Pf0g8V9dU=;
 b=GyvJzKNyaFTW93JBB7VuDQJN27p/T4CfQiynRAlgKmic3qxG9cAuIXFgD4xldEwXzy
 asMOHAYHS2RcIO3wy0eAEcUD4FNVp1VVXWmlp59VNGTSz62w/kEiF8WfzNcpeI2/caT3
 2OhzeikJBX6wgpcDgm48Vb1yS778LBGSFDbVoFiaUIFaTdoI1pc2QaU4hu9QrENc/syz
 56eC7sGQiY61HVf/W+UDyBIpkfg99RhfzNM+58lK2xPdKTEgh3VcoNGuxGTaBlPRSCs6
 Pm0Nl6ZuZcdIyKOsj524w9OhXbW4PehMLli7td0j6ezo9nHOVpfeWiCZ0q6pxqSTqJPH
 78uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757465413; x=1758070213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZEWYUOsl+tfq/TBs2IcBXjp2vG7EmMRZ2Pf0g8V9dU=;
 b=FqEVjsbSuPVkMIcx5mxfJEO3GtuNtzIQ7dDpVQtUlmJX70e2zJCe1X+x5kVfOgmzs3
 b+SMVXZCXQz6w6hck3yixkTIzM4D539f4afDrWGj7WgvToSk+w2QjhpSpju5yI+/HYaE
 Sxfs92BjX/t9naEMRyrOmS5h9qc3E6n0rPkSVDl9BooYvLHod1Qqqs8lCJBqoZDbv8un
 KxDEiSRemCrdCeviCUiah4krLLi084mym4B9RFlXR5wcLo+S+Sc1VAGizC7Ne1W9x93Z
 iBWCLh7zZRMLkBGFzahQI+Tkn6OuNe1eqvxv4FEtHfPyvIK0dFevBsd40qfqYQMhnrWH
 WEKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf8SOGOVvgrVlLGWa+GwE9TBzGn7MSIXt4bK3GoAiH3I/eE0bNr6QOiKNVWoXXrEUhl4U=@dpdk.org
X-Gm-Message-State: AOJu0Ywnw56i7/Pc2EEpBvABsX/32zuwNWhWPsMKRkfecFWg3axEmHsw
 0dY5KrttzRNhcLpeILxqD6SFSWVF3Y4A7eKvBTf7KpNK+/+b3esK2YtES84or3jdaJE=
X-Gm-Gg: ASbGncu2RKE+4V6V6qSszr/sqqrFGT65bzgRoL1zmmGkdNmdGF6ZP+9udfJcFLNUdQT
 ACgBmVavKOZT10DuY6fNOCTGeZiC5rEb7z9cIg2wTuhuBw0urtsm+cgGZxXTscQta3O5ZUguVM0
 OW+TIBlbhNqs+D1Oc5wwkC5c6OKvzD51wkXukmw+hPE9jo7EDvfHviO8XMQJUMcrXPUxKcS/xh9
 gJnwteNNaW8ZUuWsh3ege5J97MGI0H55KzXlfmBgCeo8n281QC4dpzdZUtnO+uIS7eYGr+NNtqV
 oZIVzBF5jCHtsO4xk+TbR+qOIE/3LlQ3KDSTgpjpAibgixxopYbFIMXv38z5iOhwlkHCmDLodj0
 TrJKIbI5uGJnTmn/MUy1mP0gyQfH/Ujb2KBw7zupyNFx+Z83InUIeou8WNkaD7D0qgADmkhp3uO
 Y=
X-Google-Smtp-Source: AGHT+IE/teFYrfFEpq5CgNkve/m4dWbJrByfU8HkKw/MntHd4lUBTda2aexb0ZFSy5mqwIEEXVLDuA==
X-Received: by 2002:a05:600c:450b:b0:45c:b53f:ad9 with SMTP id
 5b1f17b1804b1-45dddede42amr128063545e9.33.1757465412803; 
 Tue, 09 Sep 2025 17:50:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df82194bdsm6616695e9.14.2025.09.09.17.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 17:50:12 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:50:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v10 1/1] ethdev: add support to provide link type
Message-ID: <20250909175007.5a54bcf9@hermes.local>
In-Reply-To: <20250908085256.1866407-1-skori@marvell.com>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250908085256.1866407-1-skori@marvell.com>
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

On Mon, 8 Sep 2025 14:21:48 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
> 
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
> v9..v10:
>  - Rebase on top of next-net:main branch.
> v8..v9:
>  - Adds 25.11 release notes.
> v7..v8:
>  - Add documentation for invalid link type.
>  - Remove trace point from API.
>  - Rebase on next-net.
> v6..v7:
>  - Replace link_type to link_connector.
>  - Update comments.
> v5..v6:
>  - Fix doxygen error.
> v4..v5:                                                                                             
>  - Convert link type to connector.
>  - Fix build error on Windows.
>  - Handle comsmetic review comments.
> v3..v4:
>  - Convert #define into enum.
>  - Enhance comments for each port link type.
>  - Fix test failures.
> v2..v3
>  - Extend link type list as per suggestion.
> 
>  app/test/test_ethdev_link.c            | 18 +++++----
>  doc/guides/rel_notes/release_25_11.rst |  9 +++++
>  lib/ethdev/rte_ethdev.c                | 45 ++++++++++++++++++++-
>  lib/ethdev/rte_ethdev.h                | 54 ++++++++++++++++++++++++++
>  4 files changed, 117 insertions(+), 9 deletions(-)

Queued to next-net.
Fixed the fuzz (file offset) differences in release note and test
