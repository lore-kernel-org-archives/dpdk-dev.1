Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FE606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UaD7fRYm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06087402D6;
	Thu, 19 Nov 2026 14:35:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 853E8400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 14:35:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795095311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJDCzAgPM8yhffdhOQqiP/RGZNk2RqE8rPZWcPkBIsk=;
 b=UaD7fRYmyYyrfwvLLZbfl8iwgdlLHbfGZZ9wTgj+qhYkMtp4W4wyzuaujNgeASbsffNrId
 9rk1l+IsrxX3QCW8VK55oFPsDmg+KLSPCaqCPq8SPCKoh4+42UhUdfdz2LeF7VzWC3SHGT
 R/RASavUulVhqN6lVMGvqLM72spjCkQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-_0l5ama2NSmHvxmSXA7EXg-1; Thu, 19 Nov 2026 08:35:09 -0500
X-MC-Unique: _0l5ama2NSmHvxmSXA7EXg-1
X-Mimecast-MFC-AGG-ID: _0l5ama2NSmHvxmSXA7EXg_1795095308
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5bfd9b4260eso1184727e87.1
 for <dev@dpdk.org>; Thu, 19 Nov 2026 05:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095307; x=1795700107;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XJDCzAgPM8yhffdhOQqiP/RGZNk2RqE8rPZWcPkBIsk=;
 b=d8A2KfCLl4sRCUeiX4tgPxRC7frWpb/Vt6CJQdcX3cZY1zHqzk6qOUYFPbP7rthlJr
 iWeUwPkqThRjiLyHtlrzV9GehJlIdLw8hWnev2joQeCqzcJnUN89rSverU/twlW78wqA
 qGTytspPkgbQZ+KK8fJQZhH7xCJruMjjC1hsucPVd6sjAcUPvBTUlC79N2q3wVwpFmTF
 bxPee0zK2+cTwsvAMkR8K8+7EIuffwRzI424xXu6D8PLGwy7Bwx+Dt5FfJBBe6O9W9bR
 oT2qgSpWnZ8WIB6MoPgCt0yteIIk2p8dOJ1YCjVqVs22Wq+JePQF83r7U3gxH1qKPMHF
 s3MQ==
X-Gm-Message-State: APuU4Z9ghCvGnYmp15Q3J1Ojpb8L2r7Kt/3dSsDD8Q5xYzNhJun3vu8F
 udCGqPGKCIt4klmppJu/Wwx5D4PCqxMiDWgbTKlpzOmRdAMwS0umCBiplTT1JHyWGljSOUSWiaV
 Qu+kfe5NpcpP7Vd5BZalZrXyg00EQRy7bzuwovv31bzD9imfunYmfbHUGIIgCCqvW1whP0/uWVB
 jWv1rb00Fd4COdfdfJSHcUWBO2aXE=
X-Gm-Gg: AYBFou3VeVt38uKexiLnjJ7mwAju74IXhy34eL0pPRN6QHQTjdjcoUWGVs3JSKvWN5v
 uoSZzi3HP2Xw1uGOjbbVsQ21mSz6hoyF9zPovAWpo4T331zSaYv67ggE6cOPf2gVXmmfCSnUcnF
 ZqYMwL5wQuvQ4V5VtQBtHGlz3X+Wrh5HrKBXyuAkRH0NSHJcu7xh/2OaCgu50LlDjfLFvsXhqvr
 wD3K/vKYYov4mnYIBRaDvMTx1AzDvITEFfhwUjbXxWeRDG1
X-Received: by 2002:a05:6512:3353:b0:5bf:c17e:a63a with SMTP id
 2adb3069b0e04-5c1a9c1b843mr1952667e87.28.1795095307643; 
 Thu, 19 Nov 2026 05:35:07 -0800 (PST)
X-Received: by 2002:a05:6512:3353:b0:5bf:c17e:a63a with SMTP id
 2adb3069b0e04-5c1a9c1b843mr1952654e87.28.1795095307172; Thu, 19 Nov 2026
 05:35:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118152945.1404317-1-david.marchand@redhat.com>
 <CAJFAV8wT6YidJyv41qK9Lup5z28MdALvC1_GzCEX_8Pzmo9S9A@mail.gmail.com>
In-Reply-To: <CAJFAV8wT6YidJyv41qK9Lup5z28MdALvC1_GzCEX_8Pzmo9S9A@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Nov 2026 14:34:53 +0100
X-Gm-Features: AclHuK-j7BjlNYjwreZ3TsSDrbbdhCDJVKDY4qo0TyA70u0IberhlbSkOMvyHZY
Message-ID: <CAJFAV8xTsC6rUzvGXmTQB89mJtZ4Mq368d1uaCOTaEtPN1OSAQ@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: revert eventfd leak fix for MSI-X
To: dev@dpdk.org
Cc: iboukris@gmail.com, maxime.coquelin@redhat.com, thomas@monjalon.net, 
 Harman Kalra <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pw8mjx1RGvV4TAK1Fc28GJH11XrWlkM0ZdlGKkOA984_1795095308
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

On Thu, 19 Nov 2026 at 11:55, David Marchand <david.marchand@redhat.com> wrote:
>
> On Wed, 18 Nov 2026 at 16:30, David Marchand <david.marchand@redhat.com> wrote:
> >
> > The event FDs leak fix looks correct on the principle but it seems it
> > was too soon to take it, as it broke net/virtio and may have broken
> > other drivers.
> >
> > Revert this fix until we get a proper fix and acknowledgement that
> > other drivers are fine with the change.
> >
> > Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>
> Recheck-request: github-robot: build

Looks like I did not use the right label.
The error on MSVC build does not make sense wrt to this patch, but trying again:
Recheck-request: github-robot


-- 
David Marchand

