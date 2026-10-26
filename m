Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E29606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHQBYF5p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDE31402B0;
	Mon, 26 Oct 2026 17:39:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 6B9DC40275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:39:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793032755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JpGskEfB8CZglnwJ2eMrELeIBXAQCvtx3fEYbfaoSJY=;
 b=gHQBYF5pgzG+nKE0RgdGdkbw0NDcIsRpVV2n+U0wE3rXlEjYcb0KxhCxpUNNC2ROJ/nlTH
 5TxHzFrM5CkAGfmoqYU+zFOgGRdNWUK5CdQdS4JQ4P6usM9TRgKLzelNDR4WJOuaViQxMY
 210eU1zi1Fb97OenzI+cATTAM7dePCs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-QVy3AQmlNg6Y16vqdVpaDg-1; Mon, 26 Oct 2026 12:39:14 -0400
X-MC-Unique: QVy3AQmlNg6Y16vqdVpaDg-1
X-Mimecast-MFC-AGG-ID: QVy3AQmlNg6Y16vqdVpaDg_1793032753
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so15349581fa.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032752; x=1793637552;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JpGskEfB8CZglnwJ2eMrELeIBXAQCvtx3fEYbfaoSJY=;
 b=Fbi3csKrKLa9KYGnBs5XeF1iyLvKU3rVDET0n9rBjEBuMKHMm0e2R6xt3eQLPP9FJN
 6lCG22js6WGoCdVZw0jC/7VsJlP7skogqw0p/Jjp0mPs0NfIGNTEbi7PvP2hfJxIY3Wc
 TKcgeY/iupiNrSXkZbpM5FlMGEXUC5+DhKIl8EkfmmRWVnlcKC1toQ6XaX0NLeiWK+IY
 3dS1frIGppL16/fS4jCXp678sfsRXf8YF9TNHDg+xOEhXcsFlylxqvaXNmIRLxoguBwW
 G1ncs8TmQZLwZldOa7p8y3ZLlgRQY+9jZ5aqK3yTKUL3Mui309AQ1NaaSN9x8Ij1tuSR
 kDnw==
X-Gm-Message-State: AFq9FYKra335Kz1Oz4jOJ/3pLS4VTyy/NkJaDxHYT67J6KzWVyXeNWuJ
 Q/U6S+8hZy+JSeg/FTf4yJWKPhPwQHO9B14Wuv186Lluhc/GY31f9nxyxuJsQ18j0lGufH1hzk6
 Zpj85VncwMUf7k9oXKwaS5VFRCXGiAJ6wpYyylvff0uA4lDx4YstyEv/1I4e6nkAax5HKu5Lqng
 rvNWI3r5uscs2QOwb1s5s=
X-Gm-Gg: AYBFou1/oLm10eldHRPqvcslDuYwegfGbxuB158hhE3MGhIadlLpCrKuqVy3D3PuW5v
 K65XBMiOzj4Z0gIwmYawrxak4d2ZMQO7+x5+K6MoZRJo0vy76yArv4tDXwJWj0n+3KDzy/XCtf2
 aAQAjLVUphdTIiogCxCLqqTU8pGnpNdBa1SVRTERgD+1/pvyAE49eu3P0rjaiUuOs374JaRBrWZ
 zBrBfbPswwelQY7QS5TGdNwFubSUcg6q6XLufComX9r8XIk
X-Received: by 2002:a05:651c:31d0:b0:3a9:c0d2:2d64 with SMTP id
 38308e7fff4ca-3ac6fd0ba6amr18110851fa.11.1793032752547; 
 Mon, 26 Oct 2026 09:39:12 -0700 (PDT)
X-Received: by 2002:a05:651c:31d0:b0:3a9:c0d2:2d64 with SMTP id
 38308e7fff4ca-3ac6fd0ba6amr18110781fa.11.1793032752135; Mon, 26 Oct 2026
 09:39:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022082618.2730417-1-david.marchand@redhat.com>
 <CAJFAV8xVs52n+3cS9wH4hggFUdu5U8QrCFisgasEeP5sr1Ev=g@mail.gmail.com>
In-Reply-To: <CAJFAV8xVs52n+3cS9wH4hggFUdu5U8QrCFisgasEeP5sr1Ev=g@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 26 Oct 2026 12:38:59 -0400
X-Gm-Features: AclHuK86i4ogHKj0x1rMiMTgIYB0rdjdKTdJDOBDlB9PU7YChFIbfe88GaURct4
Message-ID: <CAJFAV8zhiok=wo36WJ=D=B9iUqV4q1GhB6MX_+wOBKqYjg8a9g@mail.gmail.com>
Subject: Re: [PATCH] bus/pci: fix interrupt setup for ioport in secondary
 process
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jqV0K8HGA_w_OuFzK2T7o7k5Shi5-IVA81F6SacAkPM_1793032753
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

On Thu, 22 Oct 2026 at 13:40, David Marchand <david.marchand@redhat.com> wrote:
> On Thu, 22 Oct 2026 at 10:26, David Marchand <david.marchand@redhat.com> wrote:
> >
> > Now that the interrupt handle contains a -1 FD by default, the logic in
> > this code is wrong (yet, checking for a 0 FD was theoretically broken
> > even before).
> >
> > The first invocation for a given PCI device will always have a FD < 0,
> > since no code allocated a interrupt handle in the life of this PCI
> > device.
> >
> > Bugzilla ID: 2067
> > Fixes: 63a0dbf661e5 ("interrupts: mark FDs invalid on allocation")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Tested-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.


-- 
David Marchand

