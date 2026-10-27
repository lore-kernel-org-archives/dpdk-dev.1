Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80418606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0kMOfVr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD7E5400D7;
	Tue, 27 Oct 2026 17:45:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id DB1D0400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:45:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793119507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/TgrILhFEG3BBrwJ4BsrHcIH9ZvYHcwgpUgsx61pmw=;
 b=Q0kMOfVr0wHP7+BHa4NQbWvObr2aPplHpFJg+i+Lf5IglMZ/CaT54m13+O2v3Vq279Bf2J
 XLZwSnAalJZI88ml0AcQm7oYGzEBkY3byZY6lWfXuxr1ibMN9DY5fTeZ3S56dnU9dKIQ4s
 Jp5IMzcpnmqUTk2VgCfhQBKvMgShCGU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Y_9phRNoMXml4ScNLhl8Ig-1; Tue, 27 Oct 2026 12:45:06 -0400
X-MC-Unique: Y_9phRNoMXml4ScNLhl8Ig-1
X-Mimecast-MFC-AGG-ID: Y_9phRNoMXml4ScNLhl8Ig_1793119505
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab3ab11921so20230911fa.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 09:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793119505; x=1793724305;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i/TgrILhFEG3BBrwJ4BsrHcIH9ZvYHcwgpUgsx61pmw=;
 b=mcyv6fRfn6TBOE6KWhd7ZqCZ4QRuOfLc1U+zET6SF/0xd+Pi16o+XTMAL4F2PzBoY2
 RCM1+6xE+pcYMPvYpVujToaWCLVFkDxPMNJNfOUBco+IzcZf8ikzEFqpoGWcaYMXJNIw
 +SHHzU2Ww/LSqLgMUsKcz0oXwSuHnSfP53GMPizL2s47k83b5G8nwUuoUUc35otMbTQM
 NEfPZplLTVpOTRA9rGUnar9fjIG1kPODKg5qaRe6wyS+Y2Qh0+WsjYfZXhTileKTaTwp
 OXgvSe7f2ZM14eBIC9y+08P5GO2fEmy+oMQ0VOukfIvlIW8mUVoYN0W6SKdxVwlM/uua
 ADzA==
X-Gm-Message-State: AFq9FYI/Hpr1zAKSxIkSUr/sgZf38z0PBiDzKm9n4AJgGEha8GuT1ZSS
 SQmc3S9r818lAlBkynIhe20gLRZjlE1jl694TdOlrtDexBL4dhFZDUzCSm2TLfAeBw4Teb9bzJ6
 xr4RN+8kU4quG+2ZtCGrC7GCm8mbt1WWsrqurvcyVgcaiQIb6E3iAq78MoYxbtzZmNpg17xsXsG
 /gipL6o6ZP8GpTzWlEd+Q=
X-Gm-Gg: AYBFou0GPKpU8m4cf9eUrji9vsmxPXD/gofyCgcsPW/DNAQ02xwRhio/I/1cOI22+vR
 Nu2Cna6MM0BDlI9TWQefPNbFE+/Rqa77ef0ui5LozCEOsaLL10gt8IVB14ncdjNfkfPoVLVUBgw
 JEPMGGe4i5/7CPBaFVdPQAB/7ky0cOTyuATHxeXeuoPrrwYuGfBL/e3kXWzpc8UprB6cjvyQMOz
 gP52cwF3qEcVjfOnmKvpee1UMMEgRmMX9XUfTDhz8LQw1t1
X-Received: by 2002:a05:651c:1141:b0:3a7:81c4:190b with SMTP id
 38308e7fff4ca-3ac6fd68b88mr27052991fa.25.1793119504913; 
 Tue, 27 Oct 2026 09:45:04 -0700 (PDT)
X-Received: by 2002:a05:651c:1141:b0:3a7:81c4:190b with SMTP id
 38308e7fff4ca-3ac6fd68b88mr27052951fa.25.1793119504424; Tue, 27 Oct 2026
 09:45:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
 <GV1PR04MB10750EE7246351EBD7792D46189602@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750EE7246351EBD7792D46189602@GV1PR04MB10750.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 27 Oct 2026 17:44:52 +0100
X-Gm-Features: AclHuK-OuifUfCxxPGkVx6mU2IUqr2XXjtihJ7kOU4q5VAQkv454tekPpRZNMbE
Message-ID: <CAJFAV8yXxkH5j3TqHfVsUtAAQ5a6rk=2KKoQ9iBEfNZbZh=R9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Device unplug and bus cleanup refactoring for NXP
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dta5x46xKQ51foQ3uZQqyZQqJUjV0mCDbk7ORSeElZc_1793119505
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 13:36, Hemant Agrawal <hemant.agrawal@nxp.com> wrote:
> > Hello Hemant,
> >
> > This is a followup to the refactoring started in 26.07.
> >
> > Like the last time, only compilation has been checked.
> > I have no hardware to test runtime.
> >
> > One thing that could be broken is either the order of devices initialisation, or
> > bugs in the device filtering that I tried to simplify.
> >
> > I went with the approach of splitting the device list between internal bus
> > object (that I called "control" devices, maybe a better name can be found), and
> > normal bus device object for which DPDK has a driver.
>
> Series-
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

Thanks for testing the series!

Series applied in main.

A rebase will be needed at some point for other work touching the
fslmc bus like:
https://patchwork.dpdk.org/project/dpdk/list/?series=39787


-- 
David Marchand

