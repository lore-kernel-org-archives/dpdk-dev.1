Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F560A381A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PY25PgtQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D33E40679;
	Tue, 20 Oct 2026 16:58:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CC14040297
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792508315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpUAgrU4xLvpnYW1WQ4iAveM+qCsuWDiNxOzs+0Sydo=;
 b=PY25PgtQdrA119A6XSXqOwW592ZWZ49lJPNNsX4pw99rW3e+7Qzo6WH37i4herxmXVDiEs
 mvIsKSo7Mrg7GpuW8TWeA1N2uZ99pJKp6tM8uHNwg/g0Y6aLmMdihZBjpPSbqKMWV89L/k
 h6XfJaUn9uqdeC6MAr3KJmOFRUJ1lrw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-G0QM5fBEMNGy1Hgl2wRP4g-1; Tue, 20 Oct 2026 14:58:34 +0000
X-MC-Unique: G0QM5fBEMNGy1Hgl2wRP4g-1
X-Mimecast-MFC-AGG-ID: G0QM5fBEMNGy1Hgl2wRP4g_1792508313
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ab0972e5aaso15335401fa.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508312; x=1793113112;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lpUAgrU4xLvpnYW1WQ4iAveM+qCsuWDiNxOzs+0Sydo=;
 b=FgTp9j+p0KYd7wZbNRLubGwQtljIsOWMsCLqKe1STnYUw0zoJS8p0dwQLkblGz4nIm
 8t8pgTCcctR4rFSMOK09ioA+qhyIJFC7sEpb5wrruWr28JCwMGVPZ7eAQcT3eWE9kKJV
 DqqinVRaUEEa6/FZySwxMUs6tKeq89DfS9uwUVXGkFTtAP8mAg4qdMrMb5DQ5CfPvjfz
 ZYjph/2o1SAd4miaUdVqrCflvodk+XANxO1xOMEd223nHrTbMYlYT4B++UtZAc/RoHbt
 mjdcBnEco0PccSTxZZBUv8hpoU37zUBur2r5apJhYFp9kkHxjikIb0KWbaEdhDH/xiBg
 GLVQ==
X-Gm-Message-State: AFq9FYJ7FJk59txN487d80Osj55CqgZV8zNsjfk/6x9sQqFtgZKdZnHp
 0waRj0RivDnnxPeHAIh7bRP4pdoIOY1xpPImFIBwaxtcXZpAiNeRl9WZ1ZcVKRcaIjq2E6mO/wi
 wiS+clR2pbQSAaqGqQDC0J+zcMOKeKSBqaUmqqybJdKVce6P3408Lp/PkrFMvtMwnuNBC9fG6yF
 UBA6mAbo7jhU5yb1geS1Q=
X-Gm-Gg: AYBFou3EYDvNMgk1p7IHf6QM2JZxuihbptGuEUzm1BOKuZmymcm0Li+bzG48k86pGgO
 DsHIZzeI08Hz5ArAuBFFMaKBQ4PkWYdN4VE0Ovg5dfBdwOCrE3GSV7MSafGtAycIhOJbYVk6LEX
 ajxRF1qA8NFUQIq/lahRw7IzBYEgZNVdzAJIqk9ZHuX/CxbTIf4fNWLnryjHJDDdrj2UGLjs3Bw
 7IFz4IjARJsz+aUMYffUCKGrfVZOo0IfsF31PM9nn9+q8Pl
X-Received: by 2002:a05:651c:31da:b0:3ab:751:6ba8 with SMTP id
 38308e7fff4ca-3ab293fde35mr26250851fa.28.1792508312432; 
 Tue, 20 Oct 2026 07:58:32 -0700 (PDT)
X-Received: by 2002:a05:651c:31da:b0:3ab:751:6ba8 with SMTP id
 38308e7fff4ca-3ab293fde35mr26250721fa.28.1792508311930; Tue, 20 Oct 2026
 07:58:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261017144747.2155513-1-david.marchand@redhat.com>
 <20261019081602.2426732-1-david.marchand@redhat.com>
In-Reply-To: <20261019081602.2426732-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Oct 2026 16:58:20 +0200
X-Gm-Features: AclHuK92lIetz-7U7fycRR6wftXm1V5Pib0NMRLkcTvjhyAZWYg9-xPLm3d_d3I
Message-ID: <CAJFAV8ySktqoJ7KeicaJR3T4amMvNHDGghuQSDUALgRQRhrskQ@mail.gmail.com>
Subject: Re: [PATCH v2] test: defer timer initialization
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 stable@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>, 
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dtJeWufkPU_wZm4OdTSFGJV56gdrARY0pp7akhAB-dE_1792508313
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 10:16, David Marchand <david.marchand@redhat.com> wr=
ote:
>
> Initialize timers only in unit tests that do require them.
>
> This removes an unconditional memzone allocation (3MB on ARM) and
> avoids failures of the eal_flags_file_prefix_autotest unit test
> that runs in legacy mem mode and has a tight 18MB memory budget.
>
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


--=20
David Marchand

