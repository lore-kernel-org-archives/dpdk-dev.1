Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D1C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 07:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4C4A40269;
	Tue,  1 Jul 2025 09:57:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7BE4E40269
 for <dev@dpdk.org>; Tue,  1 Jul 2025 09:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751356631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUeAta2sH5kU43a+qTnbwRkbOQEYsHerBiJvofGvicA=;
 b=S088+nSgvsbURjLvnN3D4BBK03JyKz9dthLRHBsfhFPzay5SYIocQo4zScRlQd7WauoVH5
 qY9Jf7fykvn+3MYtZdF1Py+1sROesRvW1qOo2t566CICgQpHRxRNAusA0tzGnDolwjqGdX
 yzQBXg0m5jeufbvy28/L3OuU0tQA2uQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Vh9iX_5oMPmF0ZNgx7B9Yw-1; Tue, 01 Jul 2025 03:57:11 -0400
X-MC-Unique: Vh9iX_5oMPmF0ZNgx7B9Yw-1
X-Mimecast-MFC-AGG-ID: Vh9iX_5oMPmF0ZNgx7B9Yw_1751356629
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-553cff91724so1974088e87.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 00:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751356629; x=1751961429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUeAta2sH5kU43a+qTnbwRkbOQEYsHerBiJvofGvicA=;
 b=QOygfI9lsWnYcbuNl/oHeVPGX3d8x1BT+eLl7TGJ+fYUp8rbGQPV5SW12nzCtovkOG
 d7HLSvrimPMKk7LT8XOGTlC+8F8p008jD4VwONIYP+BYYMAwctGzTDqVlkDLhriuLTHT
 U1PCnISw82uS+CAsqham5/7VLZCW3n+diqbTKYxx4ezJOm5qB3KR3DlF3wg4JfBulePi
 yBu4vrrdXo5z8nthES/4SankdgtuQWhq3ocf9ouGLh6M4VK0gE4MfjhSbdWYmg06nLX+
 T+l/FsE7Hpf73z65i+2ar3LjnbWoxlntIN90IrrFDDZwxk6FLKNcZaGEJWLDp+ZT6gJt
 pHtA==
X-Gm-Message-State: AOJu0YxfbaOaTtJSe6nSBBmu4ABRbA/FsQKJUpGap28o/JoU5+NshoXX
 A+8d8URxhLPgOELDCgWLvDIZp51xh8l0zVZGUlIyw1QVd6dJbvuzDxhHHHDq8rT/SKG22Xew/Qv
 PS+tqEBKCPXXbazAGHs+6thQEOagY+DdyC0AivsYhGtdSzzj8YctLKfceLkFBzjiWEp8IX1osE1
 wX21S5ajeR1ZvL8fH8X4k=
X-Gm-Gg: ASbGncviGUcPeRG6VDOlhyGJWdEBitSSZk5ci39eAFBXd86lUyrHmPKxV4KUakIikr7
 Ue1f+5DqiXh2omHApZqvLCA1tvq3NjE81KOAnePTo2z2FHkGincyqVVo4zN2hmqTqjo3LMWROX+
 unPcI+Zg==
X-Received: by 2002:a05:6512:128a:b0:553:2ce7:a201 with SMTP id
 2adb3069b0e04-5550b8475edmr5594490e87.19.1751356629164; 
 Tue, 01 Jul 2025 00:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuoUKEJExGAIY05sRxvNhrMqafnUyNIarGqiJoIjf3xql+9f3QXpJDbUcB9e7hJOv4Iv1buuBNNMcH3i65bSk=
X-Received: by 2002:a05:6512:128a:b0:553:2ce7:a201 with SMTP id
 2adb3069b0e04-5550b8475edmr5594468e87.19.1751356628600; Tue, 01 Jul 2025
 00:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250624134139.552315-1-bruce.richardson@intel.com>
 <20250630153752.2361112-1-bruce.richardson@intel.com>
In-Reply-To: <20250630153752.2361112-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Jul 2025 09:56:56 +0200
X-Gm-Features: Ac12FXwAKlouVRk1CWp2nbT5UCt3EnNjYWCmxq450i9Ne8mBKTzmlmF2P9FNHdA
Message-ID: <CAJFAV8yixOQ-GFn9FZoheQzfwXh5c=zCms6wvRdZwHqZctTJ=w@mail.gmail.com>
Subject: Re: [PATCH v2] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, techboard@dpdk.org, 
 Vipin Varghese <vipin.varghese@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: of7iV_QGKdXcKQxI_sgX4CsKA7z_Uv5P0zxAGkDBmHY_1751356629
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

On Mon, Jun 30, 2025 at 5:38=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
>
> Depends-on: series-35540 ("use core lists not masks in documentation")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

