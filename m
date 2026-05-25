Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2275CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E468E40276;
	Mon, 25 May 2026 16:30:34 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 9451040144
 for <dev@dpdk.org>; Mon, 25 May 2026 16:30:33 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso17740950eec.0
 for <dev@dpdk.org>; Mon, 25 May 2026 07:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779719432;
 x=1780324232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNdE6GRivc+Et8OjEQFNutVKXCixioxZXeTgn5cd1t0=;
 b=MBw2GHUFpQ/EpSnJXm5hhSfPrpIJ+84G1/QHEFHby3a2HgL5j7KlgoYrXRdQ/WlmTD
 f0gJysLsaVoVew1YBXXVYGIb12sp3hmV0LhUWirvJSoxzNgQ/VcGtbxer9pCvVQeaaS4
 xHGwQxF0y2sbST3w4SIv+bA0MSmynr2X4CXtAnKz2UbK3MJNus0UhO6OxROt7EnyE1U5
 q9aipsj+zDtzKeM/p0j/VajkPWzGIZtFWLhH0XEMvB52nO6AO7dVJ/dEAxI08CbbTjKS
 pfKC57nPKHL2K5cGxo0yIqA9sZ706LRi1Ian/D1CbWQpY2l8bF8NmiA6wo2IbwprhOrA
 Abbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719432; x=1780324232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mNdE6GRivc+Et8OjEQFNutVKXCixioxZXeTgn5cd1t0=;
 b=E2/mFsIcUinrq3AIPvfkNNrEP8qv2rT62dIPLpv4ROmag8Jgq/S/ZWAb1egchlpqDd
 /SZUC8HbyQNGSkVx3agPxh3z5KErf/LxVuXsO/i3JE7XnqS3dV/6fzZfXmDVnhZ53S7v
 qQzMAL9MURy8itAzCUQxyVP6sBT8Ig2h+HGcim/T8tDZSVYkHswwZ9nu4rJQnat1A4gy
 /HsnTpy1VUrEZdIzswtzwmpvM12CB15HhAbGEvJhAQiUwH7/tgbZICRuATbP6BSEbjwr
 PzHnCScZuENcY8Jq8XX4KitUFWKIohrE1GFrGnKgIqopdh6fxUYxuo2s2ARwYkxlhyjt
 przw==
X-Gm-Message-State: AOJu0YwevTHUhflkNUm97u7U6EcHqkzlG4Sde3v/VX7+8BG9G6Fbvb5w
 bvH04TJa69IdHIk/+ZyHUDcNrPvWJijSkA5p0R4lwziq/tgLdXqNF3Bp5lWkSXo1ehM=
X-Gm-Gg: Acq92OG1+AVsTzAVR4v3BB1qi4IJr+cMOuV5Gh/WJK1qlVPdVq6OPafxs3GIfpCBnFF
 6AO3Iak17BoLw9M3t+QRiO4dHA280DyLmXtZI0s4W8FMR9nqvo2XOgYXSXKpmPDPNJ6TitKEPt8
 iyVJmcWcGyg4hgXDPaHB+JISb5UONo7Gzr18QbPguMuGYmHfZ8x6i4XRHGJ08h3IaUGa6avn695
 dhRzxDLiNwpPQ8WmLp8jgBzqiyqyH5VjMt4pBa8L2ODnw2dXipIR837bFeGB4Pah1gIkhHLYexf
 wI5kBqINSuaLHlMQbwjDzYZgAIy4DkgavwHMuq+47GTtuFSggLxYJwswxkaDNrObVuo0HXHKFXH
 aT4QoSHGv6Ln3auhHmK2dbHxSPhWhSDBJGuTvFV+k5HKnuxZyLbYLljHvknwIsvzsS+/PVXftdC
 P6bzu+7lDh3e82jNzpgKWqe7/9ersdW6N0GxGnCOCCnxt+/5vM/H3XzfhEWVHw8hoD
X-Received: by 2002:a05:7300:6919:b0:2dd:6937:79b8 with SMTP id
 5a478bee46e88-30449035bf9mr7955881eec.5.1779719432289; 
 Mon, 25 May 2026 07:30:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20e71sm7818950eec.12.2026.05.25.07.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:30:32 -0700 (PDT)
Date: Mon, 25 May 2026 07:30:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
Message-ID: <20260525073029.235b4d40@phoenix.local>
In-Reply-To: <20260525103642.55255-1-hofors@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
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

On Mon, 25 May 2026 12:36:39 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> This RFC introduces fastmem, a general-purpose small-object allocator
> for DPDK. It is intended to replace per-type mempools with a single
> allocator that handles arbitrary sizes, grows on demand, and matches
> mempool-level performance on the hot path.

Makes sense, what a simple wrapper inline to allow full replacement
testing/performance A/B comparison?
