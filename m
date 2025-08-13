Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08835CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:29:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2CE40EE3;
	Wed, 13 Aug 2025 17:29:24 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 163C640ED9
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:29:23 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso40757935e9.1
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755098963;
 x=1755703763; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANVbGOklvKoVvSmZTD9Bw3g1dMbZLtcew40JCKHqPJQ=;
 b=B3EPGqW/iiLKZKo43LnqdCjIiluw2sAElPcuZhc1rwC+wxr5ewGd21kapiiYTFF0tI
 SYBZr17nkW8wS79GSmkpV3cSq2bfqtPc5WXU00XAOvHlHB3r4s6Co6b12ABBZHPzJ2A1
 9s4GodMOzsHBN9oTybPzocBS+FKXpD4rRVIy8Pd+LFNDOH3d+RwxA1DaMcqQiEmhqu/K
 jyqvzc/zSMTPhmbrFkC1rfUa2qjRMm6xzruv1LCnAWr4IiGYI2tuQjM8tymDZf9FwEp+
 pBQ0RqdovOyaCr5Ssqc6ng49QW/HzdPNFuN4TxuhNqOWimuOJBSyg8Jxg4fskhUBzYNT
 aEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755098963; x=1755703763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANVbGOklvKoVvSmZTD9Bw3g1dMbZLtcew40JCKHqPJQ=;
 b=psf3JU2F6A2y6MQWmoAAmBy2XOn343U4Si6LZLDZL53PyyRuww6XhCPKvcZYIf6xjX
 ckJybk0eFLaPw5sSWAKKUTktzjIVdRp+1NtAfeok9AEb8y4OWvlaWlBBnT8qwtrDh9sP
 5mbav4sq6KLO3hnFD/UfNRTwBdE4CJy8jyUu8IwS7g87Tb6HxbdbSV2bsu7pC+KH64fc
 608Ri6wrnxv0lHiYTJLoUCFDCBQfpqas3FfV9tSJoNQ+vp7liOdvhmndqP3U+2Bacine
 Dj1JseST+d9yn+mceNHVCwr401g/JyeJo1FuXJhjZ6RXLMdtXMgrDLM3tPDyV4reIac9
 XcWQ==
X-Gm-Message-State: AOJu0YwCuFw3Tqbg/X1W95qpci3krwdjlBIUUV1mylAJ8Z+kY2cU6iBA
 fN/oJciI21t0eNyIDYwwVJwIFFGlhB6sFf5iYbXhjWAJgwRVlTZeIhfB/KNqHlj6RxY=
X-Gm-Gg: ASbGncsYkISuOXCL94lIFqTNm9w5yKnC6zGXkR9GRKABfDWHJYdJaRJVkxqKjGQTtBu
 anwh8I13KTTum4YCiPQznPT+QeYq/JYyJO5R4pEyKZblE7XQ0Q/pS9ycyQ0AZqYClcxRTn36FJa
 ocohRztVBNw/XICo+TQygjRPp1JVUQxNH3EE95HFMqnJfdSlxHjI7tQH/Q2bEULjqq1GLByMrsL
 M7moIA1lYlONfdj1qXWqdwUaivMPNWncNHnmfKb/8DBZ5sfGTDuQBUNZOWbqOTgCg1QEQtsm8SO
 cfKcOh4EljwJfrGvRQbxwAK/bBTUo1PhX4EqzKDg6CVP39cbJmeHPNxOHMnSSuZz4mxKHxCFJmp
 mUB3FZEmVS0ryH5W9uRkKYYMOL+PjPKft8XhaTJ7icV0/hfsesDz5PvTYvEsRsE052cZNsxgy25
 8=
X-Google-Smtp-Source: AGHT+IEbDsUcGxVDKFJtUDAkLL1+k+4baV5pnPeNzZ/6HVqXmoPGmNKzGI+Iwtnv039m2VuAC0/fkg==
X-Received: by 2002:a05:600c:c490:b0:459:e440:61c7 with SMTP id
 5b1f17b1804b1-45a1660c711mr35384465e9.31.1755098962559; 
 Wed, 13 Aug 2025 08:29:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1ab24d1dsm799155e9.0.2025.08.13.08.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:29:22 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:29:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 1/1] common/sfc_efx/base: enable parallel detect via
 netport MCDI
Message-ID: <20250813082917.49bf438f@hermes.local>
In-Reply-To: <20250810044605.7911-1-ivan.malov@arknetworks.am>
References: <20250810044605.7911-1-ivan.malov@arknetworks.am>
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

On Sun, 10 Aug 2025 08:46:05 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> When autoneg is enabled, also enable parallel detect, to try
> to discover link tech/FEC settings that result in link up.
> 
> Suggested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>

Applied to next-net
