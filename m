Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B46606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C0TcPBjP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A45440264;
	Thu, 22 Oct 2026 10:58:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A16E4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792659525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+orOFfW2rz8A0PZCsWVgBV53+dQVxoA4gtrRpDiGj8=;
 b=C0TcPBjP5ERd2z3bPOd2EJsrPtRIt3cBe9UzrqvRTGL/nXnJ6Gl12fvMfhqzRVhfYOWA6K
 vaSWq4dXvs0N3uKUjfY5OQsOm+aK6DkUP04yDBYoJqWMHvJ7oQlU/b/x8P+UL6fhPgJPMR
 GkW23eEviZbx+TEVCsK9l6XLlmzui2o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-1K8fKoqAOW6QUQXX5gM8Jg-1; Thu, 22 Oct 2026 04:58:44 -0400
X-MC-Unique: 1K8fKoqAOW6QUQXX5gM8Jg-1
X-Mimecast-MFC-AGG-ID: 1K8fKoqAOW6QUQXX5gM8Jg_1792659523
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so7811711fa.0
 for <dev@dpdk.org>; Thu, 22 Oct 2026 01:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792659522; x=1793264322;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8+orOFfW2rz8A0PZCsWVgBV53+dQVxoA4gtrRpDiGj8=;
 b=tpbTHS0b1Stw8MgJxpjP+cbtOn0ZmiBpROgQXfqkESwmW7la6Sy/rOd1P1YGI2OOd3
 iismuzR4tcjwpyGdkG8TbBQOWlwsU+UuR7LettUyyKGGjqXna8zlFOT0kH1AiUGJjkLw
 O/ciZDSjd/LIMBw814LSioa8vNbM8PvjzLqzoKROgxXFYE71N04VQNPNGA5F0y29p+Er
 rGKBDszxha+aQ5KYyVNJZEyIdpBMC+eHBalnCcJL82vW62Kqj5+F2FMv6rWvR+zqUba6
 9UIbW4TYQOz5mGTPfugSa76cM+1E1mkeHrkPNEj/LgmQHCdQx3Nb549YBDupHV6bJALn
 toAg==
X-Gm-Message-State: AFq9FYKIqkoPZAIGcd8OS6Wpqhk+z+dIyiZrQBEZYBEFK0LDLev8229K
 i8V0kGSSuZvoJq2LZYd0AiJVHRssgg8VzlBK4caSjKsRP5dkDxhR+hISlXOrPPq8wMAb7/I5q1O
 E77JjtXlM3OA5h71pmTLzX4rCW7SjK/c4BSNhCgO1xBZbbe5J5p8W43IPx5+sbUNxjQzP/yfEyS
 OcUTtRZ9t0JdANy3SV2t3d1c5ue7Y=
X-Gm-Gg: AYBFou1KFKa2v2wMCTZvX6PYkh44bJ+JhnXCBO98BD2LfwiFIGSo6olD/cC180pFFxx
 6ussItYW0/MLuVHy/YwFsdD9vqURKhTiwWTcuNDrUreTGm+xJ6010DV2doAVkDI3WFS0J03vyhW
 D0NDYLLrBF2vOtJl+cUy4RmaAmdEFCRnaFV4lDM/w+6EbISEDRGr3AX/nkyf56bj2LM1xOSXQhn
 f4VIK1ctYZcnpsi+lyHDTJDCKxMibLg1gXz3+kTdLltwmy1
X-Received: by 2002:a05:651c:2124:b0:3ac:471e:649f with SMTP id
 38308e7fff4ca-3ac471e65d0mr10433341fa.28.1792659522027; 
 Thu, 22 Oct 2026 01:58:42 -0700 (PDT)
X-Received: by 2002:a05:651c:2124:b0:3ac:471e:649f with SMTP id
 38308e7fff4ca-3ac471e65d0mr10433251fa.28.1792659521530; Thu, 22 Oct 2026
 01:58:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022082618.2730417-1-david.marchand@redhat.com>
In-Reply-To: <20261022082618.2730417-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 22 Oct 2026 10:58:28 +0200
X-Gm-Features: AclHuK_tW3UTOuHmDf2AEVxSi1ruz_9rHrFjd1-P2EWB0t6kEFvC_7oQ9syHfgE
Message-ID: <CAJFAV8z9UMJ0an1FHgGjznpV2PSLL7jhAitq8kfY=btwTnC0eQ@mail.gmail.com>
Subject: Re: [PATCH] bus/pci: fix interrupt setup for ioport in secondary
 process
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: adtNS19lqLAcDeY06pT4ywyi6JAyHHBFg9VoUnf7hYc_1792659523
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

On Thu, 22 Oct 2026 at 10:26, David Marchand <david.marchand@redhat.com> wrote:
>
> Now that the interrupt handle contains a -1 FD by default, the logic in
> this code is wrong (yet, checking for a 0 FD was theoretically broken
> even before).
>
> The first invocation for a given PCI device will always have a FD < 0,
> since no code allocated a interrupt handle in the life of this PCI

Rather:
since no VFIO setup happened in the life of this PCI device.

And this is specific to secondary process. Worth mentionning.

> device.
>
> Bugzilla ID: 2067
> Fixes: 63a0dbf661e5 ("interrupts: mark FDs invalid on allocation")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

