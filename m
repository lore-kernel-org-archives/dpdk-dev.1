Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F4606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWrJxGYk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1EF940151;
	Tue, 27 Oct 2026 18:16:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 79672400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 18:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793121416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMoLLqWRrqaOMFE9PGy67iWqZ37S8/sPVfDdFuOymm8=;
 b=jWrJxGYkCSGOtx+cUCiiY8q3MviSNZiwZyUKPAeH2dtQEb1mi52AwdaUClF//Z0j82Nv+v
 yULHZus+MBFfr+Im1g3wec44Gef2wttzLwui2ilUnf6Wgf1UyseMxDZX1N5ExxITM6eorB
 WeTPcloHcG9ZNDp+8On1+zSZuD/CaOE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-UxDVgMKgO6656iF8H7eKug-1; Tue, 27 Oct 2026 13:16:54 -0400
X-MC-Unique: UxDVgMKgO6656iF8H7eKug-1
X-Mimecast-MFC-AGG-ID: UxDVgMKgO6656iF8H7eKug_1793121413
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab2de4544cso216811fa.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793121413; x=1793726213;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XMoLLqWRrqaOMFE9PGy67iWqZ37S8/sPVfDdFuOymm8=;
 b=LjLbgAxyC6JPt0iQGRAjUAGtZsNPg2UAhYmj3ObXHYyT032HuEVQmGNaDoaWeh8IxX
 FfOiD2D8/iktUgWQ4Qai/aMW1GPRMWyoqLDFRcsR5xM0TaYXe3Vk94HEJLYGTOVa0eah
 kTrPlhhuPstsISf6UHdcGtoyvEl7S+etOkHPTg5ZivNv5ZacWUsAuUj57YZCXnmQnXR/
 8jQL8CSLr34mGvIOdDAUDHOfSbHtoP+FKupVn0Yei41JTk9EkaviHcUSkZB3HzbDcJCL
 HT8atn3ws941OzmpqREpW/dwIxm3vBi3Vw9XKw0FpWZvPo99SurBGI/PFh+587/uRYU/
 ESag==
X-Gm-Message-State: AFq9FYLxFh3r/QY5fJ0vVOqvreqeBVLlwKYrvKJ3Z7AI136vweQunnU7
 uQSbjCLrLXlI5AJ/7f5wo4jbHhRc8snFVWUDSqLNK9w9bASjgo1oG7MQQN0qGRwa+uAbz6q4v7t
 uV6jVAmXcCWtr1Apc5BC/sgdRMFgBNbat2XLeG+P7ZP8XRtkTKUfOF2AcBgo9C3LBU+xo9TNEuv
 cjQPW0ktnz61EWeXH64L0=
X-Gm-Gg: AYBFou1cxTYmDaB0x/ZShWBZbrR8pjdNIe4YtJwhsxiRXyKTZ25t+X5Goe+hZC0PBQs
 uQG8yqgbDo5xS+az5UNNHBtPAFsJJvYX1W4KPn6hn729b9slVvPEQY0CBjR817taUVpxuM/8O6N
 KSfHzzRct3857AMUWB0EmLNiCdPizq5m6Fkf8Qeg60Wm4k1vf697ZaNjF74bLZdlc0DnFXHU8sJ
 qc1pm8TAJkuiV77tBvIIeSZ5acRDQzPZ2vl8i63uuScJYuG
X-Received: by 2002:a05:651c:211c:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3ac6fceb510mr26100651fa.12.1793121413060; 
 Tue, 27 Oct 2026 10:16:53 -0700 (PDT)
X-Received: by 2002:a05:651c:211c:b0:3a6:553d:cb1c with SMTP id
 38308e7fff4ca-3ac6fceb510mr26100571fa.12.1793121412548; Tue, 27 Oct 2026
 10:16:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 27 Oct 2026 18:16:41 +0100
X-Gm-Features: AclHuK-WVCAJaxT9S2YUjAINTibWZyPrE0NK18u72R7jflnDehr1CVavSWRR6FU
Message-ID: <CAJFAV8wVkttsuYOCQ2sRQF1JsFoxHYThVkgSqzEx-yRayvWu-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Interrupt fixes for leaks and warnings
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, hkalra@marvell.com, 
 anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFmyQs5ghEyVfe0otBj6lSnIPH4_vkp_PmZp7lN0PBc_1793121413
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 at 15:22, David Marchand <david.marchand@redhat.com> wrote:
>
> Following commit d770ee9caed0 ("interrupts: warn on leaked FDs"), a
> number of leaks, but also false positive warnings have been identified.
>
> The most notable change in this series is the removal of the interrupt
> handle duplication. I concluded the principle is wrong (see patch 2
> commitlog).
> This will need some careful reviews.
>

As discussed, I slipped Anatoly fixes in this series when merging.
Thanks for the reviews in EAL.

Series applied.


-- 
David Marchand

