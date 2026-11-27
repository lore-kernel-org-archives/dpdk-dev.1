Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1B606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWSY2Lgk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD27402B2;
	Fri, 27 Nov 2026 08:39:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id B5BE640291
 for <dev@dpdk.org>; Fri, 27 Nov 2026 08:39:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795765196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rm57rer/O63SyvD/KudRPzKMIcjxg0p/petiZ9OLF0U=;
 b=CWSY2LgkLV8buUuPFIa+fHvuraCT5o168B4YlIEJbWqYAbON83FpKmLu1wHkUU7CYjnUox
 69Jaz6CeAYya+vLssqd7Nz8T/OwS9zrqBJDgt9VGhvS0bSbqZkqk++IRLgxaqscRow01yz
 qegWhqicUysApPX9gJ8UdIlGlQQwzok=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-kRdN9LBKN2W4F5eMgjaCOg-1; Fri, 27 Nov 2026 07:39:52 +0000
X-MC-Unique: kRdN9LBKN2W4F5eMgjaCOg-1
X-Mimecast-MFC-AGG-ID: kRdN9LBKN2W4F5eMgjaCOg_1795765191
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5c3250530f6so1471405e87.0
 for <dev@dpdk.org>; Thu, 26 Nov 2026 23:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795765191; x=1796369991;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rm57rer/O63SyvD/KudRPzKMIcjxg0p/petiZ9OLF0U=;
 b=UPwSe2iktXJwRavuT9g9lnaqCCS9/9UTuGxnH586H4jIt/HU1COfWaUZYNRnTKxkot
 /VQbP7qUId+MWbBlk03TvQc5E/eL7Uznqw2BjqoSDmGgt5MHAHDPeFQiBhsaZhP6dGSf
 JA2C0TbvUZUPOQhukaYybyU+SnmlIojizJxE6R/+f13jNJcWMPpU5IlV1jM21mi840uk
 +kCoUJLvk9H74M6hHBms/nDKQzE6zXk0P3TlgLlZ8vzHtnrPH2udy6B9BTlzkrWMLr96
 S7pkJmE6i7ymrk+75AYg75GOmco1m3kquDiw5mXhE3QX7hMvhuC0ahDMkbXwbykT0XJY
 wumA==
X-Gm-Message-State: APuU4Z9mMjrbUxiLbR0l7Roj216W9PVVUZCfx6iTBblq1ipySBvhyppF
 deVQmQbLfaH3SSStIc2W1xuBdW6qxEecwo6B40WqbbbzXyhSBcRMVykv97BjNdT7RBxGWlP6CVn
 4AijkNOhQqlFagia/xz/98NMu+jDqvF/qosPhOtASeizlh1Zv68FqzWV8nRYVb7kmoYM5dXXbQP
 LPi4+mbcvMvea6D8q2Zr0=
X-Gm-Gg: AZFdTZcRvRnw9DnZfpwPFJG7WvTjapA/P7xHKeGqIOzvhNUamXIIpitnXBNnoJ+1J72
 zyaS5irEiRBVYrfCXg0b9pK9dEdgrR7Ad7sLh2pOkSeStcGqNzyeGUZ/7MJXw/izLd7e88LO6Cg
 LrB9WMHM1NuvvzPULeAFbgc/uw6fh7A+hEjCpJap/dTE45ELWIAGKDMqPfuTHTg0h2U9y4cmW4i
 RqZ1eOXyJ/lI3vxnsg63PP/bcUv07mCoqMWG2MyVhhr6l+8
X-Received: by 2002:a05:6512:3041:b0:5bf:d26e:7992 with SMTP id
 2adb3069b0e04-5c1bc81c6femr6212234e87.28.1795765190763; 
 Thu, 26 Nov 2026 23:39:50 -0800 (PST)
X-Received: by 2002:a05:6512:3041:b0:5bf:d26e:7992 with SMTP id
 2adb3069b0e04-5c1bc81c6femr6212222e87.28.1795765190296; Thu, 26 Nov 2026
 23:39:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126155447.4095116-1-bruce.richardson@intel.com>
In-Reply-To: <20261126155447.4095116-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Nov 2026 08:39:38 +0100
X-Gm-Features: Aa3M54qnl43FhEqFX79MaZFQ68AP41iHJjxeRWZen1x6e7piZjDnSRU-aK2rvdc
Message-ID: <CAJFAV8zmU91wvLb3Xam0YX0YaW2D2ekhfpqauuw6r1OVGURzNQ@mail.gmail.com>
Subject: Re: [PATCH] version: 27.03-rc0
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZBqq-OKWuWMskjYU8ZO1x9YOeo4L6UmzLvIv0uBDnI_1795765191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Bruce,

On Thu, 26 Nov 2026 at 16:55, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Start a new release cycle with empty release notes.
> Bump version and ABI minor.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>

Applied.


-- 
David Marchand
