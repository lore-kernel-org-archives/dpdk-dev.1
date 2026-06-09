Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCDCD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26DA44060F;
	Tue,  9 Jun 2026 10:53:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA0E3402BE
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3pXb2I4fGK1pF3UL4Y+4Sst0s0TVNSSYnXFeZf4rrs=;
 b=ggoU8IvpovpTf4XA7N70+OkLyiHdHQE9ZNiwHH6134QoF1oEa3mVeThKHldh5QxRpUe+MC
 yFkCL+xhqgGOynybC9zrqJqggXzg/g5VuNJJ0HT+UsR5Dg3ZRg1SgYB/LSx+KSHlRxnWFE
 x3aVkRE9BmSLcUIO0Tb0TaG3ZXxt7+Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-m1dbOPy9P-iGwEIg517vDA-1; Tue, 09 Jun 2026 04:53:17 -0400
X-MC-Unique: m1dbOPy9P-iGwEIg517vDA-1
X-Mimecast-MFC-AGG-ID: m1dbOPy9P-iGwEIg517vDA_1780995196
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-396a4ef1af2so24402941fa.2
 for <dev@dpdk.org>; Tue, 09 Jun 2026 01:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995196; x=1781599996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3pXb2I4fGK1pF3UL4Y+4Sst0s0TVNSSYnXFeZf4rrs=;
 b=fM/omcIRnAMiUupKBwL1+IlQ47vZkJ0P3anb6icAA2123nKvUXLDuXrLZaOqkyLdTL
 HTCYAukyuzDIiCbAD8z5cKYPkPuL+bjrkVotb5yftNmYya98Fhxbh2S+R3K48K+HSwdx
 jorQRvtjy2ru5zGGsmsKYLMphqvY74uXmgXYykBsDi8OxYQeL9X4awKOWQsxErrJb1P1
 g0t6QQNz5fbvFS0EKree7rIHU4L5y41ra7nGIKG0aupmbyE0SbtZ5547dp/NejN1WfQ/
 lkFY/kd2ntqT/ze0ciX8mhtuwbKlQkk0EhJqFbh9KEKf/AkBzJI+o0ivc1/KU/l4oP1P
 2KBw==
X-Gm-Message-State: AOJu0Yw49Q0rVLxZlnXf5xlBnnx+cee9RijNchkUeb3PNA875jHYhjyG
 JT9oCnn0SMi80PrqnwmjCYSlkIIY/+eL4aZDNO/0+daX+T3ocCf6uzRzzI0Y0j1iYvK+rHCWYop
 VPyTgsZ6YUKFHvDK1FkO0DRxwrlCork0pBV/r8eEAHu+Ej7doDW8AUurtRnPpsv5JAvxUCy++hs
 2IivPoHTBwrQ4czaVXuD0=
X-Gm-Gg: Acq92OFYSaseqfeX3WMpg99C1tybLSzE3JncK/AaxAoLmbOxuJI1yF4mpvG9d3WYNTK
 rfLZ2gYwVQtKYFBUQje91xNs5hZ2GugBgViVW3+QJbYR50f7dgGPjU2KangVVZnVK/pUrDa2Bxr
 tp6rhnFAytrTODF7YJYet8HSNUfTocE+KTfRFrc5DnFdzEmcdSQ/RhkYxMUU0Ph2aktsUVecOyF
 AmgjA2PexvL/Z7ecsaFA2qXAUYBigk7LNghR86rQL3f+lPCp1tsG9V9ubT9MvN9GxV+oTlgUEtX
 glVN
X-Received: by 2002:a05:651c:1a0b:b0:394:472e:e430 with SMTP id
 38308e7fff4ca-396d08fbd30mr55594551fa.18.1780995196112; 
 Tue, 09 Jun 2026 01:53:16 -0700 (PDT)
X-Received: by 2002:a05:651c:1a0b:b0:394:472e:e430 with SMTP id
 38308e7fff4ca-396d08fbd30mr55594271fa.18.1780995194987; Tue, 09 Jun 2026
 01:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8zBGUVp-Df3aqY_pUw-JZpVqJfXERXsw4oQ+k2_TJbu2Q@mail.gmail.com>
 <20260512191651.126274-1-arinkharkar@gmail.com>
In-Reply-To: <20260512191651.126274-1-arinkharkar@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 10:53:03 +0200
X-Gm-Features: AVVi8Ce3oksVg5UkpIzPs4LdTjLlzxxdpHcfZzNcaB_M22aqz9K4ocwVFitsmcY
Message-ID: <CAJFAV8xaWiE8D3XM8N_Lj6dz1aF8JcwKZQHZ278cj2LY3hJXNQ@mail.gmail.com>
Subject: Re: [PATCH] Remove redundant simpler equivalent section
To: Arin Kharkar <arinkharkar@gmail.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OaEnaCJyYFbXEL3ff0ibgARF7l-sMWFo-cg0WAK_Rxs_1780995196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 13 May 2026 at 14:35, Arin Kharkar <arinkharkar@gmail.com> wrote:
>
> Fixed outdated documentation on the hello world doc, which incorrectly st=
ated an easier way to launch the lcore_hello function. The example program =
uses the simpler version and the documentation stating it as an "equivalent=
 and simpler" alternative is moot. It is now the default.
>
> Signed-off-by: Arin Kharkar <arinkharkar@gmail.com>
> ---
>  doc/guides/sample_app_ug/hello_world.rst | 8 --------
>  examples/helloworld/main.c               | 4 +---
>  2 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample=
_app_ug/hello_world.rst
> index 5bfd4b3fda..b7167aa345 100644
> --- a/doc/guides/sample_app_ug/hello_world.rst
> +++ b/doc/guides/sample_app_ug/hello_world.rst
> @@ -70,12 +70,4 @@ The code that launches the function on each lcore is a=
s follows:
>      :end-before: >8 End of launching the function on each lcore.
>      :dedent: 1
>
> -The following code is equivalent and simpler:
> -
> -.. literalinclude:: ../../../examples/helloworld/main.c
> -    :language: c
> -    :start-after: Simpler equivalent. 8<
> -    :end-before: >8 End of simpler equivalent.
> -    :dedent: 2
> -
>  Refer to the *DPDK API Reference* for detailed information on the rte_ea=
l_mp_remote_launch() function.
> diff --git a/examples/helloworld/main.c b/examples/helloworld/main.c
> index af509138da..8d1a959c58 100644
> --- a/examples/helloworld/main.c
> +++ b/examples/helloworld/main.c
> @@ -40,13 +40,11 @@ main(int argc, char **argv)
>
>         /* Launches the function on each lcore. 8< */
>         RTE_LCORE_FOREACH_WORKER(lcore_id) {
> -               /* Simpler equivalent. 8< */
>                 rte_eal_remote_launch(lcore_hello, NULL, lcore_id);
> -               /* >8 End of simpler equivalent. */
>         }
>
>         /* call it on main lcore too */
> -       lcore_hello(NULL);
> +        lcore_hello(NULL);

Unneeded change, which I dropped when applying.

>         /* >8 End of launching the function on each lcore. */
>
>         rte_eal_mp_wait_lcore();


Applied, thanks.


--=20
David Marchand

