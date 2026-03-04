Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345DBEF8FE2
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 13:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17667402A9;
	Wed,  4 Mar 2026 14:28:44 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 8FF984003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 14:28:42 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-899fa7d0780so33663396d6.3
 for <dev@dpdk.org>; Wed, 04 Mar 2026 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mauricegreenjr.com; s=google; t=1772630922; x=1773235722; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6L4P378vVA8vwfmWA0c4UqPc/ClMji43rA2c9X3fnko=;
 b=qDhPsdPFEHINmwsyFcT9z0g17onhAZawBrrvzXIvj0er55Vw4BMW/rXd1FPtSiVz4q
 Nuwi5pgOUlx+WkwlA5MHTYnEJRUfg/5XaGGR8Ah1pfjNgtBND2fMkeuoWw3iWSgLv4d6
 bxX2FoIFQJKQECi61PJm86OSaoGyIyFpMHOUUUVYDn2t8TjF7BCSS6hlD1v6V3C1sCOY
 XU4XKwDL088nKsTruC1AdeInVPeUY8YuQgKW6gsJIwc3WnofCSA/l/G9ZyNDnzA1zN5I
 OC6lu6Cq5Lj7amPJ0Fb8OHkYeWexhjT1xVGV3QpgT0Kk1BVBxowpEHACMYks6hponjF6
 rDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630922; x=1773235722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6L4P378vVA8vwfmWA0c4UqPc/ClMji43rA2c9X3fnko=;
 b=gjjVLgT3ZdkuGZorxhyBN/UK59rBCW0CBm8lC6Q2RKgIsHCH41bgeN8e+CBQ+asnVl
 V/73r9WiAuVaxVTpPOhZwJ6Q6fGBq0XlovsZXzazDulCi4AOMLSXl9WoQDc8x+pg9LX6
 b+PVcaCcNdOydm5sH45C1Zh7Q8wabGeATw2CQxizUlNtHSzwlPm7dLYmBldXBKC9x396
 R9Dl4K/UJAzoeD+UAT/oJC7tdywb3RSiAZqqA8C++e7TzhE8decIGs7YLBjs5G8xaAsb
 aNFQvtJFQekfI+0BHs7+4rfVjYEGunLLW66Zksp0+uAuJ+tvo+HwyiJe0gr7DwxWOkfa
 9ABA==
X-Gm-Message-State: AOJu0YwW3BcerL0Q9NjByInNDNUPMOryMwmHFwPAGgE+mEMeyuxdo6gQ
 JEyVXTy6tL7N9P4uZ8D69BQ5bx1HShIiTDlXv9ljYG40ymFxhT7dVoSaq+GHo/ckn3k=
X-Gm-Gg: ATEYQzyksSvehpM0YHJAvVExFklaJ6oFiqdDISkZasjgGUwTOtdZaY9EybapnZg2Rvv
 Qn55zz3nAX2qVGN0agGJP13LgQo4+Itc1xZL59RFKxAxHH2v1nhXYjIldOjIuM3K4osiVhCHbV5
 cgfz3MpwdCjB0cGPrrGl2YYaL7mwXAE/+Bq3ngpYFU7jhKKnS0O3sCqIAy8n7V/SlkU4vaeVW+S
 OY4qRBoj6Aqqh5CLQKu3+T3MJp7aPA3EmEkxH5rVu1P9/KOC5mFd9EeLTw7SAaRW8l4+je7mXbX
 EX8lZWr2RgfVFmmNfYJZoeHtbfL7ehDbhGxk7b7SWCs895+ZFVHc8K7gnwIqCGHMG11v9/SG827
 TSb+GMy9QdAOo5dOknzYisnfuG9eTWK9tnplB4WdaxJnK4Y/BGaqP21l99XNJho2lkWuFClR8sw
 0p7lr9rmFPXCB+fW/M0s1pUtjQ1vbllb9DboCwQeB1zqKeIP7NnTxB5jMXl8AP+TGlPRYToqGqE
 4Yr
X-Received: by 2002:ad4:5aa6:0:b0:899:f30a:6d99 with SMTP id
 6a1803df08f44-89a19ab67c5mr23165986d6.25.1772630921658; 
 Wed, 04 Mar 2026 05:28:41 -0800 (PST)
Received: from localhost.localdomain ([2601:152:281:a9e0:2164:d51c:5b80:c83f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a08f23e9asm43506086d6.4.2026.03.04.05.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Mar 2026 05:28:41 -0800 (PST)
From: Maurice Green <maurice.green@mauricegreenjr.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, eagostini@nvidia.com, getelson@nvidia.com,
 mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Wed,  4 Mar 2026 08:28:40 -0500
Message-ID: <20260304132840.12740-1-maurice.green@mauricegreenjr.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2884915.PYKUYFuaPT@thomas>
References: <2884915.PYKUYFuaPT@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, 17 Sep 2025, Thomas Monjalon wrote:
> I feel we can scratch all these patches and do 1 well synchronized,
> and documenting a sync command as code comment.

Agreed. I also noticed 0x1df6 in this patch is already present in 
main. I would be happy to submit a replacement patch doing a full
sync with the NVIDIA open kernel modules device list if that is useful.
Having the updated device IDs for this driver would really help.

Maurice Green <maurice.green@mauricegreenjr.com>
