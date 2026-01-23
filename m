Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43AD74EDA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 14:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D4EB4026F;
	Fri, 23 Jan 2026 15:34:21 +0100 (CET)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) by mails.dpdk.org (Postfix) with ESMTP id 13E4A40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 15:34:19 +0100 (CET)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5f52ed75c45so1789326137.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:34:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769178858; cv=none;
 d=google.com; s=arc-20240605;
 b=fiMYk2+ZW8B0plb2bGF/pQnf7J9Y59bQsHEUHDL3kdXCxY46PKNa6bAhGGbClcmLFd
 xCd/AEy3FxyGFezwHjpAT6SUZ1baoUPyPymM87UNDPwWnGabABZYlSfyHBXPrxRBUlhv
 3JnW40DZhhZfH4UUWf83bo4c1S9GlIzQzXiEJxtCvNItP7gB1OBdRtZxWnOo9rMAtJCg
 NadM1bzg7GIe9oZQVxj4FS1YgFvt6bO+CgwT3tOoLDW3LHsFcjiTQw/hiC6g+WYRifar
 cQMdqKpEIg88iJEh9gqSNiRtXtEtsO5xAPObmswUxh67H83vxJJb0muXX2rBsy9/jhCH
 Gtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MHQ20xrcA0wXFSvpZxfEtBBHdj6CAqRPgWdmugrzEvk=;
 fh=N1AgVt4iUyBR8neRQ6hcuw40kuLszKs+QhL2vZ38rxs=;
 b=PMHoFwUDepzQHnzzxB7NHBxYKvPCjilDwIuwFXLBdlJgdMzeI5Hq1CQ0n3lPoAKzEr
 vUTkPTLbioB5hAq6AN08kjjcgBV34mcgF2GT6u7HlBZgDDUEMzHnSKXqMNqCVz94uI8F
 WWLsBdP4dEjTkN+O7HDpjY5xuau9HIRw2CdcGRJ3VPEj+jJ9mBTHhU6WoolWS2XFqioj
 MqmLNhI2krQnO3gxYaTppV/0VzlEqLGyK8lhYh6+Q5e/5z/9iB6n2jhk7yx2hxAaA0HH
 nZdLXAM2rh/sodyqNTqTslDBzaJ7/IQxiQddlojwXupOrwdkUnICSZHzALzJPubZsHF1
 ccpQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769178858; x=1769783658; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MHQ20xrcA0wXFSvpZxfEtBBHdj6CAqRPgWdmugrzEvk=;
 b=D7Aa8BnpQQ1xHghGk1Z+POG9Nr3agBnIwE+/2VJnRgbGn+ys/F8Z5tyCKRL0dChoLN
 0RIIXYoIzzSwB0O3/wBeolzS8j352vq0238cDwSPSKFH2j5bBajYcRZXh+wj8NkcrK7C
 47QIi9TBvF/dQpoeFmAutLG9F8/HWEqMur/dqtwh8r8j2dLp5eoCt4PUbypL4IrvWmId
 SoM6l2DdpGEmknV2NHQEqusN+qoLZ63iKxsy7oHoEmPr6wRonzvyvJqPmVdKKui4M1RT
 LqLtabhP0wGz6tCZv3+fIrAj+ZkuKSLCe9SdtI23SV3YQLhU6Vt4/d9wqRUCB7G+UE84
 H0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769178858; x=1769783658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHQ20xrcA0wXFSvpZxfEtBBHdj6CAqRPgWdmugrzEvk=;
 b=PuQLcIoWvaIjNZjGkrelYvK1LZoKZoRMyJHzHqlh5yxRCgKn0r19yj92g1sSm3tiP1
 WdD/BxtiN/ARR3W1Zyw7eDj4nU93TiMLVCyibPZvzM2sl66XcI8HCqN20Iy0Ea8VkRfh
 WLkDdH6DWRAv8JyPusIv8rSMJlWqE8ivR8IvTynTrwepgdju5MV+cyA4ZZMfdMR4UKJW
 Uzo2QOrr+Mj2NvZpS4J7EIa6IF8QbOfAtUHT4iKNf32NASCsgt7uloHNjJu3UZ1WWw1r
 9PEV7TqLt8EqnjNYb5RG/wEzoBRbphZdzYcF2zdgFPepBbNlVEWg+/piume1QlFKcfK4
 ZGRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDDxmTt1BSk7A35EUpGR0QtCfa9oCAnTOxgiLCURymm63hLO8cFbISCCR11OxtkAIrJxA=@dpdk.org
X-Gm-Message-State: AOJu0YxxN7olGnQAYwJv+Qy8/xtT8WHDzfz0PmL+iNNpOAjpy2BgHarj
 R1vxNma4/YeSHQhU3DB/dHe+d8nUJSqt/UJNg4B+tAzi25pb0ahiQ2+SISQYbAM3ndrjqmRNcnp
 nvP4RwLZhyU+12AmQpLTwkxjV2o0tA3w=
X-Gm-Gg: AZuq6aIs1cONAPVFnK/K85/Eov7V8B86ZmOhmuT0uNQgGO9JgsG/imyeoFFCV/XKOTJ
 goBgmavC7DnDLIlLmzus7vPvQV8Jv33RKI2bBtyQxm7jUZLqbPC+SHLbZ5OhJSdQUHGt4VjzOOx
 mOw6lxBXKVnTotG7COaBqsAs/u1ARrcH7+W5nuFHklp4VAGEx/mDUsjMjKHFCvbcmZ1oIgLHXfz
 H5YMFn7O1XsTbgPz0ojfS6BBHFBzc3hNttMmd9NsimGVu7yKTNcMhYC+biFOLhLh9kFctOtszg6
 oUg8ow==
X-Received: by 2002:a05:6102:2ac7:b0:5f5:3f97:58df with SMTP id
 ada2fe7eead31-5f54bc6cfc8mr1069338137.27.1769178858255; Fri, 23 Jan 2026
 06:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260117212114.10466-2-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65680@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65680@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 23 Jan 2026 06:34:07 -0800
X-Gm-Features: AZwV_QjeW8zCVTJwIFjxossKAn7dA71cfkKAcSFv_xThtIhbsr8x51CujOlYSdI
Message-ID: <CAFn2buDvGhHnAE1a1gzntmPZeQokAZZcXXdvsmTJzCV7PFcc5w@mail.gmail.com>
Subject: Re: [PATCH v15 1/2] eal: add __rte_may_alias to unaligned typedefs
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: stable@dpdk.org, dev@dpdk.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
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

>
> Although this is a workaround to fix bugs in GCC, and not DPDK itself,
> I think it should be backported.
> It may fix (GCC induced) bugs in applications using these types.
> That's my opinion; let's get more opinions.
>
> If so, add:
>
> Fixes: 7621d6a8d0bd ("eal: add and use unaligned integer types")
>

I agree. I will submit a v16 with this.
