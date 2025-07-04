Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1513C83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 04:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C60940666;
	Fri,  4 Jul 2025 06:29:30 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 62BF14065D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 06:29:29 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3138e64b3fcso496242a91.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751603368; x=1752208168; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5X2L3khmGIq0Ubf7UkjiCQUqjevCurlcMuTqDZ11iLI=;
 b=Xi9nKbNyVF+Ir/3TTbGmfSmCWmENk0xLl03ywFhuVoZ+MF9jeDhCr86mRUKhI+RwbL
 CyhuaX2uaPvW5wBGQXmb9Vd4IBYFjqzbIsqqCKED6vPB9yKIt5egt5rLAsiCa5+ZglFT
 ch/ch/Wd5JsZdCrvMl1s+5TbzOOmPdXPgEH0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751603368; x=1752208168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5X2L3khmGIq0Ubf7UkjiCQUqjevCurlcMuTqDZ11iLI=;
 b=c94vxiWgEgSXE9xP6CwDrgcdKuR/uMCUVfM0TYm5H7M6bUMQdMUaKh/ScvsKtPIe/C
 /ao8uMpP2rSd8mWazmEv/ODcsqwI5tk5yPNnU3Z1o/BoOsMpP2PYKnWjZsDxTTp1/STE
 zOefVSYofqeKXTFjtqV/lLbKF/NDtEf92if0WGl1NNSUl5N+Zoegx1tvzGZ8iNq4ESCO
 9Lx2S9ChDop7b1ONfFA3L/JE5RxzVgA91sp0z2hBdEZlsuwVHkj7KDCVflhH9PdC+4Ve
 pjVrJjqRWSWzC1uoumvi/ODnAvEpQR1MjKd6S/L68K+/n2RavUsIPnSKdCrme78MWzTq
 xGOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5w9RZQEVLV96gDo3ABu1OGKC9J+4n4pG4Y81orJC9051xdEYrYnV5BsedlJk6WT1UtXY=@dpdk.org
X-Gm-Message-State: AOJu0YwznzXuBOnEACGrR6YPpGbH39V49tX0P8HOnfhmUMwsnGeMsGdy
 qPh/2gDzSNoV1P1ZDF+i9ZOS/TIzV3RPO2mXu55fzqUI0q5gYv9fRzaVH+HRAYI3pdhfQrwn5uC
 EMdw2csZJf57n2Te0vkudUJdfrcPGvEyaeXag0RAR6j27HPJBLNko
X-Gm-Gg: ASbGnctmo9VImN1Oi7GL0f7/MeTpKszWWz2qiFHZ5vDNUVBB0dyhIuxNWHC9LyoeIfY
 C8duc7gtojaniD6AmNwg3oLHk97MOVxjTdvOEQpk5e6OVgYrFtykuKK+NeUN9T8oxsDxLRpnmbU
 CSgS7f2J7GShHoh6c+WL29RnI/HKAQ4l63n4h8M5BLpwRjpUt6XhLV1v+W2jg=
X-Google-Smtp-Source: AGHT+IGxgmG9UkKvsKVT0e6mh9ozb7+qoMmaeK4+eRC1Z0yO0M773F4C5uLMAB73NgiVtVQzlaB1gIlNwPHFppF73N0=
X-Received: by 2002:a17:90b:43:b0:311:ae39:3dad with SMTP id
 98e67ed59e1d1-31aaddb71dfmr836403a91.30.1751603368546; Thu, 03 Jul 2025
 21:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <20250702162331.352313-4-dmarx@iol.unh.edu>
In-Reply-To: <20250702162331.352313-4-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 00:23:51 -0400
X-Gm-Features: Ac12FXzgZ4TVQGXX3OvgUH62kVEU_b4WCG8y_ex1ps11717biNTzeQYH5GBG2zk
Message-ID: <CAJvnSUC1b4UkYSits2X4pmRU8Nm5=NL4Ud6ka98XEYPn7OttvQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dts: add sr-iov section to docs
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000091ecca063912f084"
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

--00000000000091ecca063912f084
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.edu>

--00000000000091ecca063912f084
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"=
mailto:probb@iol.unh.edu" target=3D"_blank">probb@iol.unh.edu</a>&gt;<div>T=
ested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_=
blank">probb@iol.unh.edu</a>&gt;</div></div>
</div>

--00000000000091ecca063912f084--
