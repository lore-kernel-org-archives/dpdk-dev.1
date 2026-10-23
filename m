Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15007606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NN1mkl+1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FEB406FF;
	Fri, 23 Oct 2026 17:00:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4A23840265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792767652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/XGMo7e0ApIGf3C4QRNTxiMgkUOwS6NaygFxNQroQQE=;
 b=NN1mkl+1HTBwvK6uUfUSvjz2gKvosqVBYZO3GZ5GqpvP5TCf2QUt0OIjYk0S7dkQpzILez
 maBP1Woi34CIhWVePG/HpI+X7f5EHZaZexG2www/8U2KFRVZOS/mzuM99vs7Ajh7Zg9NVf
 7pFaWiFa5bo9Tn1fYfg2DPhjixrL8c8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-wuQwyi2bPRmx_z0mLldEYA-1; Fri, 23 Oct 2026 11:00:51 -0400
X-MC-Unique: wuQwyi2bPRmx_z0mLldEYA-1
X-Mimecast-MFC-AGG-ID: wuQwyi2bPRmx_z0mLldEYA_1792767650
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a9e7d65fe4so5201811fa.2
 for <dev@dpdk.org>; Fri, 23 Oct 2026 08:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792767649; x=1793372449;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/XGMo7e0ApIGf3C4QRNTxiMgkUOwS6NaygFxNQroQQE=;
 b=ectGJ5PdQDCA3oFLQalZ9H4rZrJYfl+IHBD2ZsmKfDcfWjleuGDFSgEtHTNys0jEYo
 x8L611bSYfC+eCBgMNUu5ANlpSBRnwL8rhWgi6xFrZEECRLdEgNx4ozJ555NmnPJeH7b
 g5BQSVFF9ScHmdBCOIsD17uWssjZodkwvgKGqIG53ebqLBgpGu5Defqtp/RBeL0chzNo
 k/V3Kkd1krAB/LHACrmjVCA2ORxBEIczfcOwQbVTcWHS7a0HdqC4GsHMSoDpopPGVsES
 jlGo07VfpP+s3N/Ez8wyR7q0DiXojBLFWupqfoj1gK86WMVwiCbve6MiVfXVI892JmMZ
 qY0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6OFp+EBsY0fgkb3/+wEy5EIgQ4mLmgI8f5L7PGc86GLbfgM09Bf1kqSeNkS2EgZSz/RA=@dpdk.org
X-Gm-Message-State: AFq9FYJOmT31rDg1E4v9DgXtOojnofnPLvYg41rv3VG/VYkRE0ZAo3SL
 yTaSrSpoBL06EFsN0T+C9MOhanx4QzI+2qfUF5GeAnrvDt1ltogtv8n+oBkxKWG3wcBC8y/Lc06
 qLY6ea7zBzbyRk33WjtReSEdDmPw6VIXZM1kmnGh4xJ4d3hKgBHx2O6CqhEqkUAJx/VR4gfJU3U
 hYeU5ynOcvUWylEPeEv2c=
X-Gm-Gg: AYBFou2TR1+v7j8czUHb5uAtN7P7TZlRPzTodlJ/SqFqWJlHVmmL5WxBi+Ha8KSVjW6
 0M9GD49cL29cM2vF/ETWqqGrJZcJPFfGwF0X886VxJb8nnnsT1XIcqbGh9/GQtfN0pI2TxORIWh
 vQ4ZkJTesa9JTX6VLizBdlf0r4windhoxfwnbfM91JAu2L4+3IETVxuKQw4P2v4EuuiAidByJ1E
 nR6ZESpf/ZD42r9xsXTCjWJNmilblwDYf/yQENu2hX6jnZs
X-Received: by 2002:a05:651c:555:b0:3ab:4014:883a with SMTP id
 38308e7fff4ca-3ac6619442dmr6190611fa.0.1792767649473; 
 Fri, 23 Oct 2026 08:00:49 -0700 (PDT)
X-Received: by 2002:a05:651c:555:b0:3ab:4014:883a with SMTP id
 38308e7fff4ca-3ac6619442dmr6190541fa.0.1792767648997; Fri, 23 Oct 2026
 08:00:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-9-prashant.gupta_3@nxp.com>
In-Reply-To: <20261023134346.37727-9-prashant.gupta_3@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 17:00:35 +0200
X-Gm-Features: AclHuK92KLsxdmcQs09A23SnRZtA7pCMM8gp9t8iZiIk7Gv_rFpCvzOKKZJEcj0
Message-ID: <CAJFAV8yve62OeZTa4dGxzjQnBA=vckXEsL99tmAYRf3g9RxtyA@mail.gmail.com>
Subject: Re: [PATCH v4-S3 08/65] bus/fslmc: split bus-level device walk from
 VFIO primitives
To: Prashant Gupta <prashant.gupta_3@nxp.com>, Jun Yang <jun.yang@nxp.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jF5993Q-ME6f6TztPS2XEjQ2YoTXp8F_wPpxeacD6z0_1792767650
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 15:45, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>
> From: Jun Yang <jun.yang@nxp.com>
>
> The fslmc bus and its VFIO backend were tangled: VFIO-internal types
> and DPAA2_MC_*_DEVID constants were exposed in a public header, and
> the device-iteration / blocklist / primary-secondary policy for probe
> and close lived inside fslmc_vfio.c (fslmc_vfio_process_group /
> fslmc_vfio_close_group) even though it is pure bus logic. On top of
> that, several bus-internal symbols were still declared with public
> "fslmc_*" names.
>
> Signed-off-by: Jun Yang <jun.yang@nxp.com>

https://patchwork.dpdk.org/project/dpdk/list/?series=39643

First version posted in July.
https://patchwork.dpdk.org/project/dpdk/patch/20260723135400.3621271-10-david.marchand@redhat.com/


-- 
David Marchand

