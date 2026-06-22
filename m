Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C407CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 12:26:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD15640150;
	Mon, 22 Jun 2026 14:26:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8422E40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 14:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782131208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGRVduJoel7MaT08YYdkEaZUGY3DVaqHBZedMo/4dVY=;
 b=HSizj8r1/I6GksHbq0IVA2+9v2GgWOJcwGaDx8illn4Z7Mjbuu9b95p3+8uRrxWFFzUCPC
 1ivAv769+P1LVolmdj6P2h+1jM53Sm65dKFfQVDuxyfU+U+/hrhoTO+3utAUTsK3R8A08H
 ymglDnmYI4HCQ1t/FEnKn1uYqjHQz74=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-pr6cenHiN2yvGXxWHI-kkQ-1; Mon, 22 Jun 2026 08:26:47 -0400
X-MC-Unique: pr6cenHiN2yvGXxWHI-kkQ-1
X-Mimecast-MFC-AGG-ID: pr6cenHiN2yvGXxWHI-kkQ_1782131206
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68cf0a4bso2911300e87.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131206; x=1782736006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGRVduJoel7MaT08YYdkEaZUGY3DVaqHBZedMo/4dVY=;
 b=PM8mkECDPCEMKi9Vf+DfSUw9N7gN0IbIdQtCf+tkALeSv2q9xCayvXJ5/bHyQ4KiSm
 YdYUFwxrMrh+1CFt/abpzyJmm/mvKQqKBgtvDLs5N1ri7gcs2OhNDxHuPyX5JTbvBmyu
 IWroy7xwww2xKdbVj4te1shkyt53pYiATe4Owb/vwu20ioEvNkfw4udl+JU1NnBfEfTQ
 nZcHIPDXZlhg96fupqBk0K4NLNx1aC/cIzRBVL1PuznsTjtlviHph2E1Vuf2v4QieEys
 foYiMt5kgr8SwgU00o29f3Xp1gK+7cC4aeu40WAOBUtSMokxuFyDSIBQBhht28QsTm4q
 71Ig==
X-Gm-Message-State: AOJu0YwVr3RUl16w24ouhK3/vbIfDsV1DrdDkzaEBcgNMIpgiqCoPWta
 Pugp0pkmC1psunJ0kzZlNXHqvcc1AH1ntjBAQCSVlbzEiH/MMOjcnZsf9P/0KJPwjSNGfUP+Apb
 Wb6A9Jb9mvsG3AYJz3cQgYYZKYvDRkWlYgXAGjArBxStWOSqy7zRQT1bcWkdRK5sjBndke1eeU/
 xG+f0UqBXfrXCttI6KUPQ=
X-Gm-Gg: AfdE7cmxgJ7mfHzO/+1elMW0aqfxykqkxyc/Z+CWkVc9aIpEM+NQkKJg90BuykVAKbB
 VpZ/WSwV5IP2gNcMjUhcICpOGhBkVkUWQpJpFq+vMrDoU3d/bW0ya4Pgvqa1XZIMMFB8P6GQrZ9
 evGyatpp4vgKTZoYwbd1pmBNNsgnGT8SMIWK88ulej847OqcQ7GfLgVt0q3Vc0Gx06jg+QcH6hW
 tQi00GnncL63EMDI/LH9cN0yedBTuixUMIEFtEawZASuqMgzz5zE1gFIGw=
X-Received: by 2002:a05:6512:4026:b0:5ad:3035:f2c9 with SMTP id
 2adb3069b0e04-5ad5723cc31mr3844582e87.26.1782131205765; 
 Mon, 22 Jun 2026 05:26:45 -0700 (PDT)
X-Received: by 2002:a05:6512:4026:b0:5ad:3035:f2c9 with SMTP id
 2adb3069b0e04-5ad5723cc31mr3844570e87.26.1782131205254; Mon, 22 Jun 2026
 05:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
In-Reply-To: <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Jun 2026 14:26:33 +0200
X-Gm-Features: AVVi8CeD8kGS8-KQag4_Qu2hK33sctXxadnRzGKIEyMry3BRdXEYvq0tU_vZsvs
Message-ID: <CAJFAV8xPs4KiHJ5koucQyfEUk0S77zGQ1jM3LxtQvT2qxyX=nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bhagyada Modali <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 Selwin.Sebastian@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _GwgA_i7It9s6zzuCQ5Ozu5eSTKtts1Fki-x9f04sOo_1782131206
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

On Mon, 25 May 2026 at 20:43, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
> diff --git a/.mailmap b/.mailmap
> index 89ba6ffccc..60180818f9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -203,6 +203,7 @@ Beno=C3=AEt Ganne <bganne@cisco.com>
>  Bernard Iremonger <bernard.iremonger@intel.com>
>  Bert van Leeuwen <bert.vanleeuwen@netronome.com>
>  Bhagyada Modali <bhagyada.modali@amd.com>
> +Raghavendra Ningoji <raghavendra.ningoji@amd.com>
>  Bharat Mota <bharat.mota@broadcom.com> <bmota@vmware.com>
>  Bhuvan Mital <bhuvan.mital@amd.com>
>  Bibo Mao <maobibo@loongson.cn>

Almost missed this.
Alphabetical order please.


--=20
David Marchand

