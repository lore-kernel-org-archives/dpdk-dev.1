Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96905C7115A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C32BD40292;
	Mon, 16 Jun 2025 09:38:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A72734027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750059489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmIJv65sSC91+7riPZvC/bnSe4PvbnAddddgXXpHGWI=;
 b=JJqfPputvwG9J41ha/hvxF6Wab/ArOBZsLCjP9nMPTNaeJllQ9LlZdFBx9LhF7UdLb65gI
 9T00UHZLqtr7w3NvIVJDAHITkLeh0dITgfhAXBONoBqu0PyRnR0bjF1isJ5e7BThJjnsLR
 eYrZ8TKwlhZZz7zcfp8tApyKVaYsdFw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-oelE5IM_N7ODx1tV82j2AQ-1; Mon, 16 Jun 2025 03:38:08 -0400
X-MC-Unique: oelE5IM_N7ODx1tV82j2AQ-1
X-Mimecast-MFC-AGG-ID: oelE5IM_N7ODx1tV82j2AQ_1750059487
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553af33d98aso1792561e87.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 00:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750059486; x=1750664286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmIJv65sSC91+7riPZvC/bnSe4PvbnAddddgXXpHGWI=;
 b=nppl7Ho0IeOE6NMFbZHw2yrbziNvuUCAAdg8fEomuQheu27asDJ+z06myRtUO23ZDS
 8102rkhScRZgltmeYPkLTSclZ1kSsw1WoZ5+KxhJ2dwlsvtAAgPElIFqTKH140L3holL
 JQ4EVpNYnY9tNUuQifhhprwSpZO1REhfGbWaDqNmBrPkGahzvyRW1hGRdH/Ltf0GjmcY
 uISiTTnUwGp96n6bTHkVJz16taCXwwM8AqDBQJxgXDlFVIKT8GhNtgyL42uojBi90XBg
 LpcTACES9vngwEU8i4StfjFap0y1eSD3xVJr6jkdOZZZ36vBtRDZLctNfZ6wzu1A6QpY
 x38Q==
X-Gm-Message-State: AOJu0YyUGysYH47kR2ZFd06xTQxbx8hQIfRKKsnu2j9vjBE7WH2BTfDI
 Q6Pq3sYH78c4Ayaj7NPZq9+WBtGhPmhgrHaflnmoUM1/zzeIHjENpt+MM0Ny+k6J4+WVppVZqWZ
 o1cBib1i3AWKHyWymwnQCKFmAO/TxNsFUh6upACeY4CvGYBaP/BmG4pno7eIvf9KEEvxJr3C7Wy
 a92FbwdJCW5dG0T+vVKsw=
X-Gm-Gg: ASbGnctIdvGtAALXTogW2Rx7wrlSWC6GXh+7qOvxkNkQ1LqMbYVBBeAUUq6kX06hRQT
 x7mt0vLdV2Mgn0tHAboT3tZS7yGUjHN8Wrs95EGKjsHRrdNg1KBceleFjnDBLDiWC59xgM8y81G
 i5ay02cg==
X-Received: by 2002:a05:6512:3e0c:b0:553:2159:8716 with SMTP id
 2adb3069b0e04-553b68ccda0mr2090808e87.26.1750059486520; 
 Mon, 16 Jun 2025 00:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEGZS8eoc+1YOe/iF4FYdOhC9ibZR3DdoexP1Xg8qPifQfZiVZQzDv2myGTJ9IhKjN+Sps5bmSXMNEW4q5tGo=
X-Received: by 2002:a05:6512:3e0c:b0:553:2159:8716 with SMTP id
 2adb3069b0e04-553b68ccda0mr2090743e87.26.1750059482182; Mon, 16 Jun 2025
 00:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1749737842-30538-3-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Jun 2025 09:37:50 +0200
X-Gm-Features: AX0GCFsl5tfAl7FdO_8svbxvfPLt4NXDJWcpnl3FlieRVA5B5HjALaJPt6ujDDc
Message-ID: <CAJFAV8yxnGmBKJhTQp3js4QObjwaySHxTS9MekSmwgkVkY9xdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers/net: remove use of non-standard array
 range initialization
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>, howard_wang <howard_wang@realsil.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 98iWCxkFIgEVrCvb4YuuQhE_Qc01nx_YOToK6RgKaUQ_1750059487
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

On Thu, Jun 12, 2025 at 4:18=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/ba=
se/rtl8125a_mcu.c
> index 5a69b3e094..c9bf5fc6ad 100644
> --- a/drivers/net/r8169/base/rtl8125a_mcu.c
> +++ b/drivers/net/r8169/base/rtl8125a_mcu.c
> @@ -162,7 +162,13 @@ static void
>  rtl_release_phy_mcu_patch_key_lock(struct rtl_hw *hw)
>  {
>         switch (hw->mcfg) {
> -       case CFG_METHOD_48 ... CFG_METHOD_53:
> +       /* CFG_METHOD_48 ... CFG_METHOD_53 */
> +       case CFG_METHOD_48:
> +       case CFG_METHOD_49:
> +       case CFG_METHOD_50:
> +       case CFG_METHOD_51:
> +       case CFG_METHOD_52:
> +       case CFG_METHOD_53:
>                 rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x0000);
>                 rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0000);
>                 rtl_clear_eth_phy_ocp_bit(hw, 0xB82E, BIT_0);

I don't have a strong opinion against this change.
The driver maintainer already acked this change.

So just some comment, on the form.
switch() here does not seem well suited since this driver code is
validating a range of values.
if (hw->mcfg >=3D CFG_METHOD_48 && hw->mcfg <=3D CFG_METHOD_53) seems more
robust and is easier to read.



--=20
David Marchand

