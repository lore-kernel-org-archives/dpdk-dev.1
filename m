Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E6606A33D
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUzKJUF1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E214027A;
	Mon, 23 Nov 2026 15:09:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 40C8140262
 for <dev@dpdk.org>; Mon, 23 Nov 2026 15:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795442981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCJ7oLuLHgTU63AX+Qf6umkzuqCk7HGMYkFg+CqXLmE=;
 b=YUzKJUF1xQanMCvJRsvLxH3cK9ljfMU8rclSS9sfkIHE5W216L9mfgwZ8olSgrA8RKPsAe
 LL69PpOUaO5fBETP9J1gT/7DRXuVgRCSKMehhKKJTIbUhoafHRAehpQzHXMCJansQK5hMD
 6TO7FE6xXWEBw4QD579b8y9bXCAWFDU=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-hz32pUufOFimuFyPR6Hvuw-1; Mon, 23 Nov 2026 14:09:39 +0000
X-MC-Unique: hz32pUufOFimuFyPR6Hvuw-1
X-Mimecast-MFC-AGG-ID: hz32pUufOFimuFyPR6Hvuw_1795442978
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b55f4f3bb8so1629467c88.0
 for <dev@dpdk.org>; Mon, 23 Nov 2026 06:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442978; x=1796047778;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GCJ7oLuLHgTU63AX+Qf6umkzuqCk7HGMYkFg+CqXLmE=;
 b=WhvFYQvAcPYELJdNF5/7sRk3/ZfV2dYdEoH0JE3l6dh2g3TVV6i/6AMkqP6MLH61ax
 LZrBCp2ECzZt25IlpDqbOuwADuUS27X6USNZpaio64TEVjSxt2+FvAXkbzIS0oaONPVo
 fB2IqTbYFQVFxFiGeFaX9SJDQUBkebV7+drmfVe/ZjzGsDPl2RVT/mOGzK2aQ217U8VE
 YO1fn4zKG0VZYY7i1CnDMDcnMcEjvYdRXjA3P70iP0LW8XpQTVROvewYJE87XUtJitm9
 tJXPy6xbjpD1TXG3uVR7LgyqZVTFpYjN4P9ZxkPkjcCqO87KjdXaqSBMjntIk2l/pU1m
 xTJQ==
X-Gm-Message-State: APuU4Z+R769LDHNj2aATG2P/AzXYVkPH3R5pHhpwZRwNIKYq8mY0Guur
 x4q/slitVogtcE+Dnq0L8iO0rNrw1buBqNz9Pos/R/MLY8VPGhMltCXdwl7e0gTg9ePULizq0Wo
 LRPDS13soiHY/XoywFaX8CSf7aHePaP+9HDy9CqwUete/5MdiM6meSqzSFWpRLWf2LZ4+Hy/YB4
 dYIFfq8IsrF345AsP5GgU=
X-Gm-Gg: AZFdTZf0z7SexY94xZiP9mrW0d2/BgCx0hDIRsQzphQIhHXsJqsWNhT1gR9cf57wv0L
 /Kp/SYwZPXS4mvwWgdyeeaZZkemtlTEg+76clyG5LbzHB/Dt11CXtKsw2Z71Acsd67Dalq+fJCd
 7Vmq62dhYG5ihDLFz9pazhI0BPdM1xPFvT7O8wzebGkcIlUvWzctPUQB6wnjEHDqDofp104ETxi
 bBJfLjDbOZlzULutGGaml2KWlEhI7lgx1JSTnhLEX3HnjecZOfSFd5hF2EcNwWVWcgVIDAL+epX
 OncaJluN+LbcDHwo/lKrldTG5JHmaFrtPhAVLNB8Nzo=
X-Received: by 2002:a05:701b:4354:b0:1b2:6cba:7f7c with SMTP id
 a92af1059eb24-1b5568fdafemr11173146c88.37.1795442977798; 
 Mon, 23 Nov 2026 06:09:37 -0800 (PST)
X-Received: by 2002:a05:701b:4354:b0:1b2:6cba:7f7c with SMTP id
 a92af1059eb24-1b5568fdafemr11173116c88.37.1795442977075; Mon, 23 Nov 2026
 06:09:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123102434.215799-1-ciara.loftus@intel.com>
 <CAO55cszUSTBDMM++h=d-OdUZK9SYZBW1oqeuXP+KVs_oiw81Rg@mail.gmail.com>
 <IA4PR11MB9278BCC1BC8DE9BAED6B218A8E452@IA4PR11MB9278.namprd11.prod.outlook.com>
In-Reply-To: <IA4PR11MB9278BCC1BC8DE9BAED6B218A8E452@IA4PR11MB9278.namprd11.prod.outlook.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 23 Nov 2026 15:09:24 +0100
X-Gm-Features: Aa3M54pWm_4sQFdXiNEBIghpwGTqaoaoOK0CouuHUYWILIaCxX8bAWieIAKRlCc
Message-ID: <CAO55csxb-c8OWb6rnp+tKRG4=GMa4w96AnsRfgLGjgtWv8r2VA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: fix eventfd enable on device re-init
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aA-mza-wiiCztOmN-CYfM6hsfP2VD0UHbLQJ-l4egbw_1795442978
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

On Mon, Nov 23, 2026 at 2:24=E2=80=AFPM Loftus, Ciara <ciara.loftus@intel.c=
om> wrote:
>
> > Subject: Re: [PATCH] net/virtio: fix eventfd enable on device re-init
> >
> > Hello Ciara,
> >
> > On Mon, Nov 23, 2026 at 11:25=E2=80=AFAM Ciara Loftus <ciara.loftus@int=
el.com>
> > wrote:
> > >
> > > virtio_dev_configure() can call virtio_init_device() more than once
> > > with Rx interrupts enabled. Each call enables the eventfds again with=
out
> > > releasing the previous ones. This used to leak the old eventfds, but =
EAL
> > > now rejects the repeated enable, causing dev_configure() to fail.
> > >
> > > Fix this by disabling the eventfds before enabling them again, except
> > > for virtio-user which does not recreate them.
> > >
> > > Fixes: e7b9d1d2806c ("net/virtio: fix Rx interrupt setup")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > >  drivers/net/virtio/virtio_ethdev.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> >
> > David posted a patch to revert 3ba6b689893f, so in theory your patch
> > should not be needed.
>
> Apologies, I missed that.

No apologies needed!

> >
> > The revert is part of v26.11-rc4.
> > Can you confirm you do not reproduce this issue with -rc4?
>
> Confirmed, I don't see the configure failure with rc4.

Thanks for confirming,
Maxime

> >
> > Thanks,
> > Maxime
>

