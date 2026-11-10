Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204460A2616
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7DVHpk0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C585040E96;
	Tue, 10 Nov 2026 15:58:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 57FD740285
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794322736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkZb7k5JM4+pVr/taSQzzmToHGjUQjxnvARRBpGtWLc=;
 b=T7DVHpk0qQM2jZB0wxqp4iM+/Qj4PGDLCx8erf05huwqf00lMMdcJmhzB0ulXW4k3W3+QV
 I2JH14bczc23aTUt2J+sb8BWYOndnM3YEAUiFInepq5vPQlgeQE9MY3vx0xKptDtnGQgir
 faLjvxkz857FaNvFh8SffdMfN661L4Y=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-lH1oB2t3MI6hPrqNay8cCg-1; Tue, 10 Nov 2026 09:58:54 -0500
X-MC-Unique: lH1oB2t3MI6hPrqNay8cCg-1
X-Mimecast-MFC-AGG-ID: lH1oB2t3MI6hPrqNay8cCg_1794322734
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso1569925c88.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794322733; x=1794927533;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lkZb7k5JM4+pVr/taSQzzmToHGjUQjxnvARRBpGtWLc=;
 b=GRhrC7V62MKDg4CYT2qPxom0ecNGP6IHgmUt8pzjgGhhfoAZRgB9/MWkcvhBw7CZ7D
 3NG9Mu2osa5TfzOIc59PPn3MiTc6lVYuXbhL7cYKo+e/md0yPNefRr1eptRBzvAf3xJv
 ikYaansC4DCOJVlhaTjHAFfHdVygyrNuMWVnFBYPCabGv3D+MZgoBMlSvKCpF9MMu6Qm
 NVQYSLKLa5ZKvnv2XpeYPCKRu/hlWLXuj4qixMUMrwVn01kFax8JNnhSsL/5/ZTHG0+3
 JHsr1T3TjD22MHH7mfbeBLSE6E8atGSnHpcigaVoalChFOwkEPzje8plV2UIH57geaZQ
 CrbA==
X-Forwarded-Encrypted: i=1;
 AL+hErGYCImPftpC3W2e/GEP7Y65BXpnnPPvjCSkEJQmNq03wKBdbM65Mt60iz415XymayvbKfg=@dpdk.org
X-Gm-Message-State: APuU4Z/R1xR831of04VUfK2phmmsnQqkg5pgdo2ewg/KIKV/mCxzGA8g
 OX4U5s8tVmZmd6uangVBamjM4MLHS6R+KJm7esEjh3OpjwSvxIbqIhSMT+/48uPfXsrjWwSsf4P
 zv+GCudCflF1tGxACRVdtyEig6P3S6R19CAqk/qRRRKJJqFRhOHiqmWGFUsiY4SZvEwIQ9JfiIw
 a881LyJiIzqU32ggOjVdk=
X-Gm-Gg: AYBFou1Mspliqm880KJbA7OTe6vaxWtuOY1Nc//gYW72CCeC1ZCUne3Th3dTUCn4vuW
 60+BR/ti7PyKPI9c2GtuvAngaMRcUbL0oJsuCeflv3BBYrFFh9RZl34C6duhn4fSG0S6OZcjQWo
 Hs4erozXPtLlhZ5KAQO+8xVrr1hm4AavQRXZPofp644qb0zVVbnPXtazvKFjNmPw0+0sWdQL91n
 14dU/xytg3FX99cGZtWDi5IrHXJUu7jkWbFL0Vlp3Ad/81CO3N9szQuIugJP+4zql34nr6wzP/V
 kjuRo08vkajOvD4WGLAdAb3+mCi35sL1srcbb4Lh6IM=
X-Received: by 2002:a05:7022:108c:b0:163:c5eb:d42f with SMTP id
 a92af1059eb24-1b3b5fa2aa1mr3388012c88.5.1794322733382; 
 Tue, 10 Nov 2026 06:58:53 -0800 (PST)
X-Received: by 2002:a05:7022:108c:b0:163:c5eb:d42f with SMTP id
 a92af1059eb24-1b3b5fa2aa1mr3387984c88.5.1794322732761; Tue, 10 Nov 2026
 06:58:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025081639.2746665-1-mkashani@nvidia.com>
 <20261025081639.2746665-2-mkashani@nvidia.com>
In-Reply-To: <20261025081639.2746665-2-mkashani@nvidia.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 10 Nov 2026 15:58:40 +0100
X-Gm-Features: AclHuK8NszpcC3i1gmRZhzWDU7QmXLKuZJIWTqErKuk8lAdzre2q5czhNgAekFg
Message-ID: <CAO55csyi7to-sGMUkP=aVQNc_dPxz1vOcgnBVyVkkshAU3i_4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: fix RQT attributes memory leak
To: Maayan Kashani <mkashani@nvidia.com>
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Emj9g9JujVzfJmgxfxL3efoUtUZX5S40OyLu469T4tU_1794322734
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

On Sun, Oct 25, 2026 at 9:17=E2=80=AFAM Maayan Kashani <mkashani@nvidia.com=
> wrote:
>
> mlx5_vdpa_rqt_prepare() allocates RQT attributes with rte_zmalloc() but
> returns without freeing them when no enabled receive queue is found
> (k =3D=3D 0). Every steering update that hits this path leaks the
> allocation.
>
> Free attr before returning on the no-enabled-RQ path.
>
> Fixes: 9f09b1ca15c5 ("vdpa/mlx5: recreate a virtq becoming enabled")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/vdpa/mlx5/mlx5_vdpa_steer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

