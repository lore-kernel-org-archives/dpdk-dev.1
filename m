Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19938CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34EF402DC;
	Thu, 28 Aug 2025 11:17:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8AEA94025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 11:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756372628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2QRt6WP7nP9nyrUWl6S17CtXfkoxguhfy5M+sWYk9o=;
 b=faneFjbnHSoAsRxhNJyyTgWjBoO2OlKdMTfQQfy2TB/l7fJ4dDOwH7Q+Is/ARZMgwe8Wfy
 o56Ee8cqXzlNpCsI4Ci8RS85M/QVaEt8i4TDarsiW0k0cB2w9kRsTLL+fC35VMiT7Scy6x
 Y+kw+59OMfauK/NZ7oeb5v76JcG3Ox4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-pb3JKQhiOhe2eDRk5hyVrQ-1; Thu, 28 Aug 2025 05:17:06 -0400
X-MC-Unique: pb3JKQhiOhe2eDRk5hyVrQ-1
X-Mimecast-MFC-AGG-ID: pb3JKQhiOhe2eDRk5hyVrQ_1756372625
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-336a2c9742bso1959401fa.3
 for <dev@dpdk.org>; Thu, 28 Aug 2025 02:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756372624; x=1756977424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2QRt6WP7nP9nyrUWl6S17CtXfkoxguhfy5M+sWYk9o=;
 b=XAg5pkHCutgP1cNvzHp5CSLtDvLybKrlfTqcZY+i1NT4E69ZvIPptQTF6jgruLJ9o9
 Uv5mAXHzIMN9Rk1ZsSlfm/Nu1fJn5b44cKrSM5TwRq0TTpEBu1pDNE/HeHDjSAk2UFAE
 PFUN3hpnPQcKFnzDjyfEH6s8OEFAw7ajgZMHSVe6LMNG1/oXyvSz758IddCRWnFU6GQS
 WRkY4cemJqTHHlGi9jUW0c9T5LP+KkaMKC2CVp6oyRCIhu7Akc0jF+snx/m2j46bFCGf
 xNPRtw1329ouZE9jok2QUB613mpz8aIvH6RTEEMyMoxnD3Wqy6YVPNTGeqcEQJFOk9CO
 J+QQ==
X-Gm-Message-State: AOJu0Yz+egQLyiGnp//+SEHUyHTEd4Tf7Oa6Mv7WHwVFizwjAD9spAis
 m8DhfOwkB30Pe81EfOorOJq+ie+/SUyrKNGFvaLeLhQN0evJodKlnHnwjZwjnu6pzwdiG8DHU9o
 DOneDpwagpslV6iNaRsA0SgkyjXeBD2dL7ts/eBYXHS3pdoMbr0b8sJUpjlVj9UqVjxD1iQJpjr
 05+SugSzmtSvY1DC+xp8o=
X-Gm-Gg: ASbGnctVPDIrmIunSk8D2xCGu+w5CsGdNSHSlCcecEuA7sruabVzZI+0z0Qtyuuvp3d
 BifDEYDbJIlOyZ11ULb+EcB+BNs9kgM0vhGUYZ7yKTUjBcWkhY61VSookQxxjQZzr/hoFSLHLW4
 Y58fu8UQH4+6emEP5JJOtQ/Ic=
X-Received: by 2002:a05:651c:4012:b0:32c:ab57:126b with SMTP id
 38308e7fff4ca-33650deecaemr45467171fa.16.1756372624611; 
 Thu, 28 Aug 2025 02:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJxTOzF8gWrFg/rsDcWDCFHGeWXNvGRmSjtSbM/qeRutk+0PCoO+OL2aaijNserVfQBBP8SHwztzQtp+MdsI=
X-Received: by 2002:a05:651c:4012:b0:32c:ab57:126b with SMTP id
 38308e7fff4ca-33650deecaemr45467001fa.16.1756372624187; Thu, 28 Aug 2025
 02:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 28 Aug 2025 11:16:52 +0200
X-Gm-Features: Ac12FXz7-LZC6LCTPCRx4ejclr-5dWkAix_3krWs6yEz8V0dJXU3WY1FKf2I_n4
Message-ID: <CAJFAV8zBdnxBoEXtcxruapKmw1TV7gPRxhkz0c+P23HVYW8w=A@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Run with UBSan in GHA
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Aaron Conole <aconole@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Marat Khalili <marat.khalili@huawei.com>, 
 Chengwen Feng <fengchengwen@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5dSf9uOuNmLNTdwA4pq3epLZmONdmMhnP3fPux2_284_1756372625
X-Mimecast-Originator: redhat.com
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

On Wed, 23 Jul 2025 at 15:32, David Marchand <david.marchand@redhat.com> wrote:
>
> This series fixes a number of issues reported by UBSan and adds a simple
> job in GHA to avoid introducing undefined behavior in the core
> components.
> There is way more work/fixes to do if we want to run with a full set of
> components, but baby steps first.

Thanks for the reviews.
Series applied.


-- 
David Marchand

