Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2072DC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 17:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24E0D42E46;
	Wed,  4 Jun 2025 19:34:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0BE4A4025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 19:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749058456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBbmtUsctdF2tph7xI9Y5cQgQggV/liPdG2W5dxi7q0=;
 b=e0TlltY3if/JPgpto3WyttxIswjTc6f52bbp/UnfFFzWgYyi5O+VIjU/x8mjBhWiMXUs3e
 aAfzB9ZtDgX52MMPHl04IvrKRqwF3D7oxBbuR1Nb0RhSek81cQ+S4lRDzR51NNHy9FN/hi
 1ZUxe/qSIxQnTF77bQY6XbZ5qYJO+cY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Is8cgp01MkiQBkySiWO0QA-1; Wed, 04 Jun 2025 13:34:15 -0400
X-MC-Unique: Is8cgp01MkiQBkySiWO0QA-1
X-Mimecast-MFC-AGG-ID: Is8cgp01MkiQBkySiWO0QA_1749058454
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553332d65afso28836e87.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 10:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749058454; x=1749663254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBbmtUsctdF2tph7xI9Y5cQgQggV/liPdG2W5dxi7q0=;
 b=vU2aDwL6wflOKVKoOh0b6S1iKZaPsiz9Ucl1ddQSMioorce9dO5CiJNO6q33bGZJWo
 jR/7dKhKyaL07fqJxut7DZFgOe+K/hES7N2FHqOZoYV2s2mHWgSf/Od64MALdrvVC5o8
 v9OTOZZVnopM5gHCKurZsUVu2NIgArW9DQyBzEMen5kklFvbBCrrp+ZmqMbOXaXCnmah
 6Mvzwo6YdlmYsYFGxDTLt4Laq4cdsmdr9jonqpdL0Rq/84qXmIZd0jWgtTPEcIczSn9o
 uCMfNe0OT+5r1VmcY98uA9NdDaYzinnHKAHpix341oaeHy9+CTzm7j8OJjj8CE8xytfl
 4SPw==
X-Gm-Message-State: AOJu0YyCyyPcEDTDfSb7YmpUG7VhzJhx1NkQhOgz7Z4L/nLB3cqHSOXK
 rC8UrxaOnW04k9joVRP3KxTzgW/Cp68iPuiqqNb1CbSsTdo3MC3FtsD/xK+xVpg1S4Jy3grIrPh
 IxOTv53w5ugmfJyphFz9el7gK6RfE5+uZHI3AAz/0CM0J6icLkcoawNILhEVnDSCJFtARh4mQ//
 i2fEFIC2Bm0M0T1nUR3w8=
X-Gm-Gg: ASbGncsCEQ5tdbmnhPGub0ylRlJxdt87vyQpp5FH4XKZTPOAIERrw9Ogl5AluuvOLW5
 j2R83/6gCeRb/Syssw8YNkAxC4A1F5WNsOZddqj6e4wX5mDaRTdXaCZv/VQEvtEB3oKe+Cxw=
X-Received: by 2002:a05:6512:1101:b0:553:2bf7:77ac with SMTP id
 2adb3069b0e04-55356defb4cmr1285132e87.41.1749058453731; 
 Wed, 04 Jun 2025 10:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEcE3pM3J/lPvdLL9YKuiqr7x2dEWmM+ofCoeAh7Xjw/6+AskfGtJS5hTDhe660HPt/AQNd3PlxsObczTVDvA=
X-Received: by 2002:a05:6512:1101:b0:553:2bf7:77ac with SMTP id
 2adb3069b0e04-55356defb4cmr1285127e87.41.1749058453300; Wed, 04 Jun 2025
 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
 <20250517083201.400-1-mosesyyoung@gmail.com>
In-Reply-To: <20250517083201.400-1-mosesyyoung@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 19:34:01 +0200
X-Gm-Features: AX0GCFvDeGUZ0J-YcoGIA6O8wD_U5vFhNm_LDPkZs_w599XBnaADb1pyMUDtPM0
Message-ID: <CAJFAV8wLRNwnMNZjQgJewt-VH5-MdF9DkZgTSFqGs=OwtgW84Q@mail.gmail.com>
Subject: Re: [PATCH v4] eal/linux: skip vfio for non-privileged container
To: Yang Ming <mosesyyoung@gmail.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RbxKinCGeEMKcaa08qAMJvIrQfC1G98QjEepjTnhoT0_1749058454
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

On Sat, May 17, 2025 at 10:32=E2=80=AFAM Yang Ming <mosesyyoung@gmail.com> =
wrote:
>
> DPDK detect vfio container according the existence of vfio
> module. But for container with non-privileged mode, there is
> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
> container when host have both Intel NIC and Mellanox NIC but
> this conntainer only allocate VFs from Mellanox NIC.
> In this case, vfio kernel module has already been loaded from
> the host.
> This scenario will cause the error log occurs in DPDK primary
> process as below:
> 'EAL:   cannot open VFIO container, error 2 (No such file or
> directory)'
> 'EAL: VFIO support could not be initialized'
> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
> to execute `vfio_container_fd =3D open(VFIO_CONTAINER_PATH,
> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
> in this container.
> This scenario will also lead to the delay of DPDK secondary
> process because `default_vfio_cfg->vfio_enabled =3D 0` and
> `default_vfio_cfg->vfio_container_fd =3D -1`, socket error will
> be set in DPDK primary process when it sync this info to
> the secondary process.
> This patch use to skip this kind of useless detection for this
> scenario.
>
> Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.


--=20
David Marchand

