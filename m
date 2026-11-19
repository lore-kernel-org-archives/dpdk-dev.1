Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1CB606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9HPsNbj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC8D0402E4;
	Thu, 19 Nov 2026 11:56:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 989B5402D6
 for <dev@dpdk.org>; Thu, 19 Nov 2026 11:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795085768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vhczkO3PPoi3Y2va6Vm/lcfWsbZcV4rUTmce7g4YKc=;
 b=V9HPsNbjS2tTI1rzz/HWObo2TVIR/0Zw4iLzJJjyKgzgu8dLuU3J2At/emEJF369jbst9v
 Rk2zb1Zgn+xrMX/P5Z2Gp9gDS4QYsQWbbC8HeuKMKdVbmHblBWkcZJuarTR6sisLtXMyfm
 IpU6L0nyHel5yQChsAOZjKY09EZwnco=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-6HJUhn2XMp-YI0vA5dKWzA-1; Thu, 19 Nov 2026 05:56:07 -0500
X-MC-Unique: 6HJUhn2XMp-YI0vA5dKWzA-1
X-Mimecast-MFC-AGG-ID: 6HJUhn2XMp-YI0vA5dKWzA_1795085766
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab3c13806bso7664861fa.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 02:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795085765; x=1795690565;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0vhczkO3PPoi3Y2va6Vm/lcfWsbZcV4rUTmce7g4YKc=;
 b=MDE0Eg0D2Vom6L0bS9NxNjOYEa+E1htV9Vh3580/V4CAT3PHwy0DqH1cB8fhMY4DF1
 x4ST42/3HfSKXiinCOXCJTbDPySkwcN2NidnDdiViSshx7Nr7LzoU4VwSTgRGcbfCHV6
 FemaW0QoJYDO9Y/MIQbk9GdV8ZtUUJc7PRpy3zeRgJX07pc0Dga33gSNCdyKpLtl3dz6
 3mdSGTlSL8S3oAQnZeoR3wPy5wq4/GP0aVaJN8gORTaumC+p9VvGNvpH6OfVmqJ/QiuS
 bLb+De4XlyD6TLoXst6vheVkpmWxiFfKcwQ4iX0DrMkUhRJeCSG0ugE7V3Czr83VCJp+
 an8w==
X-Gm-Message-State: APuU4Z/ZoxW5lRT0/d9BEWwCW7xC+W9rL3CwGnBCpvK7vhicDBnA+UQo
 IqLcK+GSUz4ZiIUklS3JfGNIc+e0scj8vEldKCiG1qmMh4RApFpgNvv3rxgNvgRdc3Om4YGNE0K
 fR+GLdUSO5+C6UHy4FpRZk/2vSPwg1LUtXBIKC787quGHNr4lfhC+sMjibY5R/5YyLBMKSKPluB
 tjLp4T5gQdkaPBeMsrQFHRVS6CY2VGBw==
X-Gm-Gg: AYBFou1JepsrTZgWhsQm3f77QqYuJOLbHf7jN0e7qNh9+lON4f1I0cm9JA1ulmri2a2
 OUi7FnkQT3VqEmX5jrH584eQWTnLw1tMLnFzXkOULXHMaY5Gs48otxB0JQHg39r43pPd+QS4MNl
 Ut2Orwam2ulkpoqVKaHVLqfsqLX7scds6vzOJP6dnTRruJu+mxo1PtbR6ShbieCg/GiVw/dsqhk
 AHaIN0Vd3EszbdeTZMzizJnFOX0eY+riINNVnAvt7tNScfj
X-Received: by 2002:a2e:bc8b:0:b0:3a6:58f7:da9a with SMTP id
 38308e7fff4ca-3ae67313a85mr16465001fa.27.1795085765040; 
 Thu, 19 Nov 2026 02:56:05 -0800 (PST)
X-Received: by 2002:a2e:bc8b:0:b0:3a6:58f7:da9a with SMTP id
 38308e7fff4ca-3ae67313a85mr16464951fa.27.1795085764661; Thu, 19 Nov 2026
 02:56:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118152945.1404317-1-david.marchand@redhat.com>
In-Reply-To: <20261118152945.1404317-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Nov 2026 11:55:52 +0100
X-Gm-Features: AclHuK92F7fxfU5QNZ7i2G4wnrifECmhVj3LLS8yWrHcbxa_gHnxrtDNsE77ftU
Message-ID: <CAJFAV8wT6YidJyv41qK9Lup5z28MdALvC1_GzCEX_8Pzmo9S9A@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: revert eventfd leak fix for MSI-X
To: dev@dpdk.org
Cc: iboukris@gmail.com, maxime.coquelin@redhat.com, thomas@monjalon.net, 
 Harman Kalra <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wifQ5zK4iLarFGCv8h3oY8PrkhRbWUqQiFhtQeNFVvg_1795085766
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

On Wed, 18 Nov 2026 at 16:30, David Marchand <david.marchand@redhat.com> wrote:
>
> The event FDs leak fix looks correct on the principle but it seems it
> was too soon to take it, as it broke net/virtio and may have broken
> other drivers.
>
> Revert this fix until we get a proper fix and acknowledgement that
> other drivers are fine with the change.
>
> Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Recheck-request: github-robot: build

-- 
David Marchand

