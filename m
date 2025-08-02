Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136BC87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 16:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 984CB40156;
	Sat,  2 Aug 2025 18:03:11 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 3448A40041
 for <dev@dpdk.org>; Sat,  2 Aug 2025 18:03:10 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so2970500f8f.2
 for <dev@dpdk.org>; Sat, 02 Aug 2025 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754150590;
 x=1754755390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1VKzOZDtQBIXQfnSXaAFR+qfvDFSkEfkzo+MTIhukc=;
 b=EskNdYV4ODDACEh0KEBRqwsLad9hmSeMBB/PLpNsSLlnr0uX1rl0jAEpEz0aOCJGP2
 HVNlnc/iYF+nHPNRCz3uwike26DC/KA5slD5zHrdfdKqDw0QQAHivUXyt1SlIgjYqcIv
 wVBCvrAZ1Q9HVYq9DAt/DdaFz+VuheNIge33S3kSonNssUn6est3hmulbXzVYsefEAQI
 HAV4oBfPDJWKDwAG4S+ciaxodDn6IaEXerl5PnWXkcTfxV3rpIGfeg/w8byqGBRwCbb+
 041iwfblRezY6e/dNKrx/kxYU7BZvz0BRy1sn+jaNz662oKMpSC7qkjG/uXivevGERWR
 b8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754150590; x=1754755390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1VKzOZDtQBIXQfnSXaAFR+qfvDFSkEfkzo+MTIhukc=;
 b=Ry+BXPzeZKo9vcjYlho1Z4Cr2PiaDyiPwGCbiEgqTTpb7LK7F4qO2t6K6LPfxIMUeX
 zhceL20X7k7vxNtE6Oqc73NQnLPYGoSmcQAIbsVRUn+7qzeARLiRPvbFVrVsAQ5zesxC
 eQByDeI0xKcuGfOlp9YHt0uSIf5UMQzHgro+u0i4MVD6Jxt1zm6EesZulg+7VWKdxNKi
 +A/RnS5+PqffrfKIgXZ/yM1u9ZPogdSSKtPGmvNx+8G/j25/IgdOwxWct9Td917D31s7
 8qDPKlfDk8CYB1o2By0mMG79OfHWi4K6giSC0vRSm6sIDmU7SEyPMky3dkIR801hZ13Y
 /BCA==
X-Gm-Message-State: AOJu0YzmzaVLCRGyqWjAY10cBAszUGS89Idwh7MQ/2xMLm4aD2vJtpPU
 Q59RWmeJCBtoQWs/bBIGeZnmq4gfWbikeW+jQalEddUNulEtOMIB+Se1K3sUXxLuNVsIyB0fFuU
 fPBqbP3c=
X-Gm-Gg: ASbGncstDodfGA9Iv7p7W43ZOtaue2wybSqUk5nWtvo6UD4JtiX9g58h1IZWfVx+DhW
 47QvUkgtICYcIMxKUwf+Lvu0npg/Nsbk8AmDloLu55blhU4sm3r2bsErE3+DcsKrO9kIJAPGQOy
 r7RcClVlmE0gXeLbc8AXUb3RxXI/1Ba+jHiuiYU+jny09qFdX6fPvs1In0r/NZJS+UR3XiWqo9r
 xt5dIXm1TgvEIlMUOqT+GCOwPsc//QW8FH6Z3DzjLJxQzXDzqXcu77Bv5Yljvq1o85XyfVWwcS/
 MS3nQLxkek/bBGYmM9FXYlZDhvLl6apoSjUHIzhfN4a+IHqaAqHUccxqpuDuxkwufJ8kOoh9OQ/
 NxZ5gT+3fG5j58M3rys1Teyc3g0jYhK6QtUloZcgV62mfXQfeNZLq23EwN7Bf5lMj8y2KaG2Evt
 U=
X-Google-Smtp-Source: AGHT+IGuPlbQpY4z4balqVTpL+lz/pkWC0lpXuvkGEX04Xjp38gGeUF3Va+rMz3evA8DNI0GWBnWhQ==
X-Received: by 2002:a5d:5f82:0:b0:3a4:f7e6:2b29 with SMTP id
 ffacd0b85a97d-3b8d94684f6mr3065267f8f.5.1754150589558; 
 Sat, 02 Aug 2025 09:03:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b928asm9633881f8f.19.2025.08.02.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 09:03:09 -0700 (PDT)
Date: Sat, 2 Aug 2025 09:03:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Peter Spreadborough
 <peter.spreadborough@broadcom.com>, Farah Smith <farah.smith@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>, Shahaji Bhosle <sbhosle@broadcom.com>
Subject: Re: [PATCH] net/bnxt: fix free of not allocated object
Message-ID: <20250802090303.3f76b97e@hermes.local>
In-Reply-To: <20250521193727.382342-1-stephen@networkplumber.org>
References: <20250521193727.382342-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 21 May 2025 12:37:27 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This was found as error when compiling with LTO.
> The function allocates new data with rte_zmalloc and then
> stores pointer in the pointer-to-pointer passed as argument.
> In the unwind case, it would call rte_free() with wrong one.
>=20
> Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Ping. This fixes a real bug why is it being ignored?

In function =E2=80=98tfo_open=E2=80=99,                                    =
                    =20
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_ctx_attach=E2=80=99 at ../drivers/net/bnx=
t/tf_ulp/bnxt_ulp_tfc.c:783:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on pointer =E2=80=98bp_44(D)=E2=80=99 with nonzero offset 800=
 [-Wfree-nonheap-object]
  108 |                 rte_free(tfo);
      |                 ^
In function =E2=80=98tfo_open=E2=80=99,
    inlined from =E2=80=98tfc_open=E2=80=99 at ../drivers/net/bnxt/tf_core/=
v3/tfc_init.c:34:2,
    inlined from =E2=80=98ulp_tfc_init=E2=80=99 at ../drivers/net/bnxt/tf_u=
lp/bnxt_ulp_tfc.c:957:7:
../drivers/net/bnxt/tf_core/v3/tfo.c:108:17: warning: =E2=80=98rte_free=E2=
=80=99 called on pointer =E2=80=98bp_74(D)=E2=80=99 with nonzero offset 800=
 [-Wfree-nonheap-object]
  108 |                 rte_free(tfo);
      |                 ^
