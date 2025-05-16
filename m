Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45366C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 06:46:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0086A400EF;
	Fri, 16 May 2025 08:46:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A08C440041
 for <dev@dpdk.org>; Fri, 16 May 2025 08:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747377993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzqikWBIlgPFtDvJJhpt89xrMnJBLne1HcVXlZWDo2Q=;
 b=UG13TqK1ou4dSfpVsXip0VUfLbOTcCtiUI170cfmJ6qv1n7eQ4SaIXXF+qqBjy5hw860yc
 AbJiB6A1ewNLs8g3ExN5k+xmkgge47+zh6l77kvaOxtnmFki4XfNvqAmZjnh46+1TRCopm
 vZsCOFt22GCoCJoihDJ3QLrDxEFkwhQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-L2bD9k0DMTCHnwngTPjS5Q-1; Fri, 16 May 2025 02:46:31 -0400
X-MC-Unique: L2bD9k0DMTCHnwngTPjS5Q-1
X-Mimecast-MFC-AGG-ID: L2bD9k0DMTCHnwngTPjS5Q_1747377990
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-550eb7606c1so87130e87.0
 for <dev@dpdk.org>; Thu, 15 May 2025 23:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747377990; x=1747982790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzqikWBIlgPFtDvJJhpt89xrMnJBLne1HcVXlZWDo2Q=;
 b=LVtpdi7Xqbgz19rD+U0uxnZ7btDDbjKAMHY7FBSL4EoRRUbIkUIKJwTMLJ9p5z1+Kd
 kLlaG0e2UcI6fpWlYijF4z5jKbe+4BgGjcUhyTH7ZcVylk/t+CHS0nI06uB+kkieV1y5
 0fHHr/zP6oANEIiL5VAXOfEnF3ov5w0COG9cajf603E5tay2nb0FLa1xBInE35ZGK/Fg
 XGriE7SgEX2YeoEvvokoZPEHo+Z37+x2IQW+E2ajqAT5yFAaCmweugd+s9thTHz2qQST
 A8ynLr6caRCVJyY+LC4StOQL+kqqJ+/OnuIuZUY3Wtc6NOaDvibdq6fRLWR2g8pgDe+2
 p44A==
X-Gm-Message-State: AOJu0Yz/kPp/7XDX4zd9veVAOW0c1BY8CR8UkUxiral90knNJMJp4JiG
 xMZVsYDcRvPidxh54fFKt5zfb67SqCIVM9AeqhtG+P4LVf3lHhOtClzr3vfRXnPu1htURcIcITQ
 IAFUHcwdaUQWZKCbZca+bGyE3uRx746KvxLmrimQocLsBJaTvtGcJFudEculEBYBluGood1wkUY
 xVr5dH0Du9azRjLTpGVMU=
X-Gm-Gg: ASbGncslAm8eiYGF5ImLBn03rHBkqmxagx/845DT4V23LwDoipbXpijUEx/v6tEq+t3
 0mqOl1gzL1K1yIJbuUNZ6bJRZRezqE+Kks9zrtNRWcHBvkMNiNlyWdt+nqsYvy/5/Ta6xkD0=
X-Received: by 2002:a05:6512:3e1f:b0:545:62c:4b29 with SMTP id
 2adb3069b0e04-550e97cb5efmr410014e87.22.1747377989996; 
 Thu, 15 May 2025 23:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSk3vN3oaviaK/nRPBMVKrCm+5AbF6TjUmVtapIUMdH1OaXHrvj7gG2fP9dMc9o+Z3uOrA7WBi4cQaJM/tQgY=
X-Received: by 2002:a05:6512:3e1f:b0:545:62c:4b29 with SMTP id
 2adb3069b0e04-550e97cb5efmr410005e87.22.1747377989593; Thu, 15 May 2025
 23:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 08:46:18 +0200
X-Gm-Features: AX0GCFunt3JGERgZcef9gBoD9lnQlS8y1dup_iKmAID4ObYcEnbsZdjEmVMteRs
Message-ID: <CAJFAV8xGa0y2v_ejaVF8CumzFxK7C5n1=0d4=iQH2ucmLQkiow@mail.gmail.com>
Subject: Re: [PATCH v2] eal/linux: skip vfio for non-privileged container
To: mosesyyoung@gmail.com
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a5jqqyENUFSmSR4iKXzHkHDYIx45aQ7TVz_90kcQ0J4_1747377990
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

On Thu, Mar 27, 2025 at 8:57=E2=80=AFAM Yang Ming <ming.1.yang@nokia-sbell.=
com> wrote:
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
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

With such a change, is the check on the passed kernel module still needed?


--=20
David Marchand

