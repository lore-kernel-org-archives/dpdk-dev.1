Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B0606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQCoLBVS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90B664027A;
	Mon, 23 Nov 2026 13:51:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 48F5940262
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795438306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sDDq5PW0rA5EAHrXia6dpuOgIR4ZArPwLxhlPyBGRA=;
 b=ZQCoLBVSXKoGuBDwGkeq0YKAjMR+iT+/GCOegCSl2aDjmdD1RQX0/5MbYG/JP8+t0nkOa2
 Oy49d6jDox8/CM/OTyxrpG+5gvSCcGu14mrHTbZws49v+RgV//KNgWhFrdDjw6GnPQbgho
 xXHAWjJC7cdkGZmPlBZIoeOUR/7xM9A=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-cvQMsHpIOMC8lNSCBA3MKw-1; Mon, 23 Nov 2026 12:51:44 +0000
X-MC-Unique: cvQMsHpIOMC8lNSCBA3MKw-1
X-Mimecast-MFC-AGG-ID: cvQMsHpIOMC8lNSCBA3MKw_1795438303
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so4116041eec.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 04:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438303; x=1796043103;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sDDq5PW0rA5EAHrXia6dpuOgIR4ZArPwLxhlPyBGRA=;
 b=qXbEuA1QURy5pxYqvW//IbgOcDK9KmpS3rfh2Uosq2R4QPrLakJKhYz7NVOULKCbs9
 f0+ZZipZd7QjnyaKut4I26qjgice5kaAvi6hWB4r7bzH7kD6Ns2d8qQ7FzYVcxieOW3B
 k+daKzvBN6v84H1g3jBmxPCQYR2IppRUa3A8w2ZfCVmgigOMbpIWMhFAP7UqP7qYMPvg
 sSlLWMlEZZ5jGVJ5HtbNBXIYCvNA43ORbKXNIcNltLjzBAQBwDC8gIL4QI7cjEe65jwR
 2tzzBuEKClTUk8VOBRLIeuJCBG6DV5Qg73j4M1BfhnvsE746FW4AuRkHnwIs32RO1b7z
 vD7w==
X-Gm-Message-State: APuU4Z8lRhHXDLFgOuwlYvrq7ZaZ5naF4SIy87bxUP+I1tfs2fiyL5zq
 FbL13+6lRdwiHEUmF2ek70+izCTsLG0/YHP57svrjY8CEKcojQNsKhsIBEHOP9niXDSTRK9bBoR
 zF+drr8MHtI+LxAMdzZb//Sj7RGe8WoHpH1tdSkHDUCNMVbdTobmxduNs3sbM4j0kpL31OM63I+
 qIgzIncjCBs3WXE5ccnZo=
X-Gm-Gg: AZFdTZccv24fPFimwWKTXG9RbTAz11lvTDj9cW91vBW3koT8CEHRegUEuDrUM1Zp5l8
 KPc+y/QbJNbW1ZJGhOgM8Oj7++HIRZPVdnHRkVd6D+X5CiRoEsO1SEQUeruVmo28924RVa2yeO/
 Sjj/Ldr+G6Prz4NuhhjtsxCvGTVzX5fL5VY071xMipXrRrtUSIKxjLEB9T5YiG5bOvReQ5+CPRI
 ZRtOoEonkB7xGumT+i7ExPrLvGm51CuKL7k0Vql1vWzTk/CEMzITBy790h4KCrLHctEX9TGNaKc
 N0PW/h1HhyogtA5QVnXhGqqkbDwACXkCA6tmHP0TJ8E=
X-Received: by 2002:a05:7022:3d14:b0:151:6e80:baa9 with SMTP id
 a92af1059eb24-1b55687f17dmr17824119c88.12.1795438303242; 
 Mon, 23 Nov 2026 04:51:43 -0800 (PST)
X-Received: by 2002:a05:7022:3d14:b0:151:6e80:baa9 with SMTP id
 a92af1059eb24-1b55687f17dmr17824093c88.12.1795438302716; Mon, 23 Nov 2026
 04:51:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123102434.215799-1-ciara.loftus@intel.com>
In-Reply-To: <20261123102434.215799-1-ciara.loftus@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 23 Nov 2026 13:51:31 +0100
X-Gm-Features: Aa3M54pJO6N_4-SUlcessTC8y3SqUadg56Hs8aOyNf39ilO3o9SzUmv4WSIUo2w
Message-ID: <CAO55cszUSTBDMM++h=d-OdUZK9SYZBW1oqeuXP+KVs_oiw81Rg@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: fix eventfd enable on device re-init
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S-QB7SFY5ejFbenXdO0ePiW3VlC0u87AvTHynoi2aJI_1795438303
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ciara,

On Mon, Nov 23, 2026 at 11:25=E2=80=AFAM Ciara Loftus <ciara.loftus@intel.c=
om> wrote:
>
> virtio_dev_configure() can call virtio_init_device() more than once
> with Rx interrupts enabled. Each call enables the eventfds again without
> releasing the previous ones. This used to leak the old eventfds, but EAL
> now rejects the repeated enable, causing dev_configure() to fail.
>
> Fix this by disabling the eventfds before enabling them again, except
> for virtio-user which does not recreate them.
>
> Fixes: e7b9d1d2806c ("net/virtio: fix Rx interrupt setup")
> Cc: stable@dpdk.org
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/virtio/virtio_ethdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

David posted a patch to revert 3ba6b689893f, so in theory your patch
should not be needed.

The revert is part of v26.11-rc4.
Can you confirm you do not reproduce this issue with -rc4?

Thanks,
Maxime

