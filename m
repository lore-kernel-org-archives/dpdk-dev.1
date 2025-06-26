Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E140C77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 07:56:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C0C40E20;
	Thu, 26 Jun 2025 09:55:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5508740A84
 for <dev@dpdk.org>; Thu, 26 Jun 2025 09:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750924557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhnHH+nihK4XZkJxft+Oo31Cw6UesGyxoaVb4TZy86Q=;
 b=XSySrAzP54QpvoFJqIMnzbI+8npJTR7uc9xp9oF+oJuTv51ozwpf+R23hRVZ4wdsxM4iRT
 sIF9u+zHDHuvVw4Xk6TDc2UXI92nHFq1VRTc3ciRnvCNHAv04BAN0WOzM6YlHcSKVugOMl
 jqw+qRMpKGr1pMzeCT4QGY4D0EcKHoc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-5VIjPhTbO3i_3ijitmVzAw-1; Thu, 26 Jun 2025 03:55:56 -0400
X-MC-Unique: 5VIjPhTbO3i_3ijitmVzAw-1
X-Mimecast-MFC-AGG-ID: 5VIjPhTbO3i_3ijitmVzAw_1750924555
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553cd66fbd8so294650e87.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 00:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750924554; x=1751529354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WhnHH+nihK4XZkJxft+Oo31Cw6UesGyxoaVb4TZy86Q=;
 b=WO47tM2mMsoYnhdzg/gXUuMNaywawGixM+f/Uloryn1DGQKJuZgOBofOMFL/95z/52
 vyx+R30y3rGrxGg4WVUHJvmNFD7SDRSxHia/4GEizZoO/0WYnmYz7ziWiPgkxYEXTWEK
 QSF8XWyqg/6dQFJHbHiVjitZyMwEYNExfCYWUWf/lVoFJbvcZaP2I7LhrwQUXU8mTlVv
 NAcAngNxYJuFR58b0rFPQQY66Jh+yXPQfFvxwmJ6M/IAegmGVtJXIEwPdvSdbCJlWUjj
 kihyOdNjC8v7ERMnw6xHH4VokbardDYOWmjv41IdErbBYpKx0Bule5sOma2SGrwxLECg
 6RUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5oQW8coKK1IZ/Y0ypCCmO6Myc3CK1Op4dzfK80BT04G3DX5TcAfsiUPNq9D5gIXMcL/U=@dpdk.org
X-Gm-Message-State: AOJu0YxVebiFyWEhY/BdCMHNUwNDy5FX+e1Nfub6i1GS/uE8Bjg+Zmgr
 Bb7+pqhZgcfyQvi6QNKPxp3r7xDAxabMOyWKRtvxuuQPGMYhe6qyu8xfSXrgYNVhh8k+an6ZgDY
 OUDaGEFbbWnd8DPqR8rhWNEtlCNlAE+Eg56KgRL5wcWN/g1Qt9U9K6YJqhZIBoFU5aF5JQ2UIdO
 4VsYNR1JeoCa8efUf5WNg=
X-Gm-Gg: ASbGncuuadtQO7Fcnc/mQk7+JCtRLaHBEozpVXGhtps6t7eAKeYnzTUu8K8H3/5Hm8e
 2IqN30mtE3sTXtVEiblWyKBp/SrOP3uzZcHf0oI42qjw78r6ZR48imwRO8f+4fuEjHa9ZNEVnv2
 pzlj5+xA==
X-Received: by 2002:a05:6512:31ca:b0:553:23c4:6825 with SMTP id
 2adb3069b0e04-555028b776dmr892780e87.19.1750924554508; 
 Thu, 26 Jun 2025 00:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLce4FPAZ40qKlGFKWX+m1ID2oY+LG+wyBPqbML8fOFHbRCniBv5giUqdo6KaKM6SuHFv01UkkyhxaDpXyDA=
X-Received: by 2002:a05:6512:31ca:b0:553:23c4:6825 with SMTP id
 2adb3069b0e04-555028b776dmr892771e87.19.1750924554008; Thu, 26 Jun 2025
 00:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250625182751.1936925-1-jtranoleary@google.com>
In-Reply-To: <20250625182751.1936925-1-jtranoleary@google.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Jun 2025 09:55:42 +0200
X-Gm-Features: Ac12FXxslQB-45_n3ti1P-KaPm0fQEv81TZKr30lhhyWWF79AKafqm4Nf1kf5Cg
Message-ID: <CAJFAV8zagnX9hPk8yPuq9V02YNK8+Xtta-HA3drX0xUfNKKXDg@mail.gmail.com>
Subject: Re: [PATCH] net/gve: support gve driver on FreeBSD
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: joshwash@google.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NY-t39dnf32fOaFZ3hf8KpFdzMt8HpDZceeIt7ZDvmI_1750924555
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

On Wed, Jun 25, 2025 at 8:28=E2=80=AFPM Jasper Tran O'Leary
<jtranoleary@google.com> wrote:
>
> This commit adds small changes so that the gve driver can build when
> FreeBSD is the host operating system.
>
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>

Support can be advertised in doc/guides/nics/features/gve.ini.


--=20
David Marchand

