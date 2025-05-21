Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BCFC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 20:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89D2342E4C;
	Wed, 21 May 2025 22:36:19 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4680F42E4C
 for <dev@dpdk.org>; Wed, 21 May 2025 22:36:18 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7053f85f059so62732277b3.2
 for <dev@dpdk.org>; Wed, 21 May 2025 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747859777; x=1748464577; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BI9UThuJGniJNOjJ2CQD6pSMdSiIrlr4KJfjroz7hCM=;
 b=aVSJDR9tvDKtQkIptgY0+8NY4ZywVCKhLpDs3O8Hufcf59f5FzpNf3mrV3qSN5hiYi
 VmTxfimweyDAS6/3V4MKcd/+qZ07uah7Gg5EO91m8xBbgffWK8hq8oq8zm7iwEhkjk0l
 uDcvdJjK3Ot7DfJjqN1tFGBpWo3U3N1rnuSw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747859777; x=1748464577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BI9UThuJGniJNOjJ2CQD6pSMdSiIrlr4KJfjroz7hCM=;
 b=CUjLzLh9rM89QCKLbet9jarppnZWMisI49LYBmgKvGNEpNFSbwMzH6UTVqz1JXxrh1
 LspfltKiXauCRSkxSmnggnr4JaCzS0wWamSS1JXgWYjRRzxHiF4G5Ko8q1mDo9QYAVi6
 x8Sq1BSGWj6VaXa/6Cw7Lo7XllMjEHwQHwNGDrujaaQgGbLBX+V0+itCOppaFZW9n1Nj
 BH8Nsmo2MymaHEWCVaXjhLmX8GF41WLp2jsU30vR8VvPrMG4ouGc9/UroAA74dOxKV5j
 SlEHc7Lj7TffnE5BhoUhH1mlmp9DjqOtL5sr35c946oL7wLLckDRWGdLBvyGEww12ufz
 XHng==
X-Gm-Message-State: AOJu0Yx6DZGrukKHtjOeIjOW5mknP5URil3BhLc1yqat3PlVggfQPvWO
 hlCOLcuIhX5fkHyhka42sPbEnhz/wJFHKM7F/mqbkzveQcsMDAsokoe0N5F3TxGOaJRIk6OpIx2
 Mc0u0Mvgy2yGrUpcVddD6+Gp6aJcsol8vqQepdn3RhdIa3rRx1swN
X-Gm-Gg: ASbGncvsuX2OaRT9Ca/d0NCdUfjWxQvkQ2aBLApzO/sT/dEo5mAel9eOm6/LGhdRZG0
 DSaMuuXdTR6sTx9W80tov0v9ow7DXdUtGhgY5JhRMQMrIS7h4nzJBXEeP+v3VgNlnyv0wyLWvo5
 eNfksjeRewDSIZPDB0Riz5CIMfXLTXwVJrRF5UukbQ68Atz2DapPG89ms0N+WZxO67h7OyWpIJO
 dQjnw==
X-Google-Smtp-Source: AGHT+IH4WF8aPv2CKFsuo4/H8wjip4T103af9M2YGDzimKpkY8AEbG5NKAIrSvYv4B5/z5Gpd2v9cTljbzBa+ej8Msc=
X-Received: by 2002:a05:690c:3345:b0:709:1529:c24f with SMTP id
 00721157ae682-70ca797c392mr307477377b3.4.1747859777389; Wed, 21 May 2025
 13:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-3-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-3-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 21 May 2025 16:36:06 -0400
X-Gm-Features: AX0GCFsmCvxW4FJvXaTNaSEfcFXlxRjzALMRVm1zl9B85V0Q-oU15ztURUFmnns
Message-ID: <CABD7UXOvBVHBZP_RjxokDbDi4w25T1MVHE8iRbBNAzfGOTO7eQ@mail.gmail.com>
Subject: Re: [RFC v2 2/6] dts: rework traffic generator inheritance structure.
To: dev@dpdk.org
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu
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

On Fri, May 16, 2025 at 4:19=E2=80=AFPM Nicholas Pratte <npratte@iol.unh.ed=
u> wrote:
>
> Rework TG class hierarchy to include performance traffic generators, in
> addition to capturing traffic generators. As such, methods garnered
> to capturing traffic have been moved to the CapturingTrafficGenerator
> subclass.

This commit message is worded a bit strangely to me, not sure garnered
is the right word to use here. Also not sure what "as such" is
referring to exactly

<snip>
> +"""Performance testing capable traffic generatiors."""

*generators

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
