Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8606EFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:48:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8D8D4027F;
	Tue, 24 Feb 2026 08:48:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 47FCA400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771919336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hneWNuF1Mvg3O6itCMje9Aih1e4c7kaeHYiGyFZtS08=;
 b=ajrEseMhy7qV0H1HwZbpNP2Nm3bkoOPaIrj7cLChYHezCMdhNoOs0dYNs0Pih7c3ss3oUN
 Kt50g4N9Q4fb86+XcNjL/HayvMf+bLAmTRrhdiwbLv1c7bxf4ZyUb1NprLIyYgbenGfxmi
 P/Ngx2f0QVFXexm4A3R3TAHUh+iBgQc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-FGJbjaFGO1yoCmaExAKU_Q-1; Tue, 24 Feb 2026 02:48:54 -0500
X-MC-Unique: FGJbjaFGO1yoCmaExAKU_Q-1
X-Mimecast-MFC-AGG-ID: FGJbjaFGO1yoCmaExAKU_Q_1771919333
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3870ef5a488so29648531fa.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 23:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771919333; x=1772524133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hneWNuF1Mvg3O6itCMje9Aih1e4c7kaeHYiGyFZtS08=;
 b=QqM0jbsXWaeRyZ8AQIBMMiQu8a9qehPLTdW8h9YaKjC2gNrf1u8iVHAh5FpZkPt7+9
 /Zgy1ETVFrmbAzbBExc55FfjVaAuIaySe9AMGCMXCS3kgKMdD3UDPc2pJweP3UWQXPRt
 4fv8cD8/nuf6l8XQS2glmZlK2bDA7+GKjMhEaccZ4WoQ80ERaMuxI6BOkoMauW0A0wUf
 vAND7ll9+2sUF0JbC/m8h2cgnHchQqb7pgCv+1dURVIP9blFj/i4T/SOFuke1AWFIc4Z
 mGrPAqg93mF+WXDG/7fjsl3+4V7/R6d27kU7jivk/0K37UlUjYH4hTDZ0ovg1mt6xReQ
 ctIQ==
X-Gm-Message-State: AOJu0Yz+A9lj2N+DoZHSAAvH6wLVD39/FMTXoJGClV7ra3BqHKZQcLAI
 Tz7VLq2AFVnLtA/BjYGr9ohFtmv2hNNjaul6lTyC+gPfLo5U5sNRKaWQWQ43tq02s3UVrT5Kw+1
 PgU404U/vyOT3a7tb00+K4fTUHomwPIgSim3sppdd1VR3G4v7clvp7dktCX3Zi8y5Gh9OqNpMPM
 m0KqVZuX0tGCOuR39zA6c=
X-Gm-Gg: ATEYQzyUr+8lXpGF2MaYQVoMt1ePO8AXfxj9CJWQh2Jw3mlY9sWU4WzlU393VfQLclO
 f7u8+gIMjcn+Cta5k54GvLQ4AfFGC9G04GgFRCmI94uKLbSRhne6VAvLkAXH22Bn3tE00oX4l+K
 UnzuG5+GZ98p8eyc7+4ioKKHdo0cCV5hiINl7YitE+KGWDAzaC5ZHt2Mb6w5dZ0ckY3FqsYseF7
 bt/4knV/NqgZIE4LajQvcZoxzQFZ6KrZYuPa8mbXZuTATIZzzj4sWuTVFNu5Z3D4iM6RQ==
X-Received: by 2002:a2e:6e07:0:b0:383:227:2891 with SMTP id
 38308e7fff4ca-388536cf10amr40742691fa.4.1771919332802; 
 Mon, 23 Feb 2026 23:48:52 -0800 (PST)
X-Received: by 2002:a2e:6e07:0:b0:383:227:2891 with SMTP id
 38308e7fff4ca-388536cf10amr40742571fa.4.1771919332297; Mon, 23 Feb 2026
 23:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20260223155603.3651641-1-david.marchand@redhat.com>
 <8c67f4d90bd540e29c9e1ab4fcdc0dc8@huawei.com>
In-Reply-To: <8c67f4d90bd540e29c9e1ab4fcdc0dc8@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Feb 2026 08:48:38 +0100
X-Gm-Features: AaiRm53a9xrjnddXN3d2LiKj-_zhlev0VJ2Iwxa0fWRDzq-78gGCOshAdK2TYKU
Message-ID: <CAJFAV8ze7q+qoPRBrZm9DW4nEZaad9NGuNiwkkyKPfMRneY21g@mail.gmail.com>
Subject: Re: [PATCH] test/eal: remove PCI probing for vdev tests
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nG2_TrZZKS9jb_wKNcLlJla0Mw7yORx2klvslRHeV3c_1771919333
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

On Mon, 23 Feb 2026 at 18:16, Marat Khalili <marat.khalili@huawei.com> wrot=
e:
> > @@ -422,17 +422,17 @@ test_invalid_vdev_flag(void)
> >
> >       /* Test with invalid vdev option */
> >       const char *vdevinval[] =3D {prgname, prefix, no_huge, eal_debug_=
logs,
> > -                             bus_debug_logs, vdev, "eth_dummy"};
> > +                             bus_debug_logs, no_pci, vdev, "eth_dummy"=
};
> >
> >       /* Test with valid vdev option */
> >       const char *vdevval1[] =3D {prgname, prefix, no_huge, eal_debug_l=
ogs,
> > -                             bus_debug_logs, vdev, "net_ring0"};
> > +                             bus_debug_logs, no_pci, vdev, "net_ring0"=
};
>
> Could use this opportunity to replace tab before no_pci with space.

Oh yes, good catch.

>
> >
> >       const char *vdevval2[] =3D {prgname, prefix, no_huge, eal_debug_l=
ogs,
> > -                             bus_debug_logs, vdev, "net_ring0,args=3Dt=
est"};
> > +                             bus_debug_logs, no_pci, vdev, "net_ring0,=
args=3Dtest"};
> >
> >       const char *vdevval3[] =3D {prgname, prefix, no_huge, eal_debug_l=
ogs,
> > -                             bus_debug_logs, vdev, "net_ring0,nodeacti=
on=3Dr1:0:CREATE"};
> > +                             bus_debug_logs, no_pci, vdev, "net_ring0,=
nodeaction=3Dr1:0:CREATE"};
> >
> >       if (launch_proc(vdevinval) =3D=3D 0) {
> >               printf("Error (line %d) - process did run ok with invalid=
 vdev parameter\n",
> > --
> > 2.53.0
>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> Tested-by: Marat Khalili <marat.khalili@huawei.com>
>
> Definitely not a problem of this patch, but creating a separate define fo=
r each command-line argument like --no-huge does nothing to save us from re=
peating `prgname, prefix, eal_debug_logs, ...` bazillion times. If tokens a=
re burning a hole in someone's pocket, perhaps instead we could move this w=
hole command prefix into some kind of function or macro with parameters (po=
ssibly one launching subprocess as well).
>
> Another thought, should we have NOPCI_OK/NOPCI_SKIP similar to ASAN and N=
OHUGE?

It would be simpler to always disable pci and keep it enabled for
those tests that do require it.
I wonder what unit tests do require PCI in the fast-tests suite...
probably really few.


--=20
David Marchand

