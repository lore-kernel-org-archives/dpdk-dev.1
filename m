Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E09CC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 15:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98504029F;
	Wed, 26 Feb 2025 16:09:39 +0100 (CET)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by mails.dpdk.org (Postfix) with ESMTP id A6B2C4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 16:09:38 +0100 (CET)
Received: by mail-il1-f181.google.com with SMTP id
 e9e14a558f8ab-3d3cb06d947so3257595ab.0
 for <dev@dpdk.org>; Wed, 26 Feb 2025 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740582578; x=1741187378; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w5C0TP6U0S4LrI5RHDZUuMXrIFYY/tnMExWH9IJ7mkc=;
 b=ZFW0vA8b1T4OjT+Vs0jfF6AmmBJSUuAct1igyMjTc5wL90Z/GksBVmFnAm9TjW5sH7
 fWomUAh1CrSa5SrFKD2W/JFhgoFNJXL0gZBLRGuxcN0sZoIgGAbyvNHulvqh7uqxBPGY
 VfEoxiSvOazvIUuKysMqBlCi6Mhqp/k9AQZ6RLuVIcDsdLdt0kO46JYNZr9rkBoy2iRv
 mZSNR3SuH72RZpOquwfVUndwYOOIM4rkT2U0XKqXTvOo0mwS5DZPSiwQ48j3XDyhillx
 atmT+C1hVKVQYRXWaFQTa+CeUNmiittnDG7bY3qzJSuwwerSaqCh93MxfaQN2X40JChB
 nVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740582578; x=1741187378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5C0TP6U0S4LrI5RHDZUuMXrIFYY/tnMExWH9IJ7mkc=;
 b=A0KYNgi+bNLtx6AJ9ps6gmYhuX3c0n2usB6mdOXPc5aFCitOrT5pvrnTHzj69J04jE
 47dqkH9Kv3CUaoLqdi/ADQfEVySExPq9bDI1lgysi3a7Q+WMXuyJffMGxQEuzN8bd/++
 aYBJBggawJjK3+bfH6Yb8dI9Rsz2gsQkr+evS3gi/xlVZBBeVmfrKyTejSR9dJawB/v8
 LS/IkIbLG0Hva+EidSVRy+OFbYJoSvQBMiyASlc7Y365NfAzq7ri+H52gSoSsg3x4MKd
 ibD+SljSPbQQM6UJXH7YWiPOlmNzS3aBL9X86FHZSezgJArPUv1fxOseDGbeWPBd2XYA
 gPTQ==
X-Gm-Message-State: AOJu0Yy3FWlT/GQtEfCvRNnxX24RtnHjDtht9TIDT6V4/E0Bgi0Y5rhV
 JcF/Kaz86zOO9tWn6AVM7DcIKXyO4KLAyRnfqc9SzRTeS3g/LnvIJoeGNWovGbEPXAFl0bjjzNv
 +j48GU71EHC+bc365jqmrsxjdB6Syust+9qtVQA==
X-Gm-Gg: ASbGncsFTjip5l/i/O2svmMii8XBjdoRTUlp/WW8ZCuoO4+E1HkINaiuXDzNElrG30c
 7slEKM3Zosoh4p0NE6SxvSSD5fI8khiYfTdGpGZodw48vtygQE70Gewl89WLsfz2MecVKT6grqP
 BR+/FaEknXXz9qzkt0vcyG61YjfcNjDxlSHtI6Nxk=
X-Google-Smtp-Source: AGHT+IFG3KyRdKVdBminp2eOKmwmoQVzmyGI37hjwZtyq0+gRXi3u0mJgAiLiikbBk+cW1AZp+2kW7tLv/hebRSBSO0=
X-Received: by 2002:a92:c807:0:b0:3d3:dbc3:8f9 with SMTP id
 e9e14a558f8ab-3d3dbc30970mr1812495ab.0.1740582577863; Wed, 26 Feb 2025
 07:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
 <CAJvnSUCTKvqKFXGKtsgb8Fu1sk5s4UYzKMGw3YF-u1fq3fGOQw@mail.gmail.com>
In-Reply-To: <CAJvnSUCTKvqKFXGKtsgb8Fu1sk5s4UYzKMGw3YF-u1fq3fGOQw@mail.gmail.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Wed, 26 Feb 2025 16:09:27 +0100
X-Gm-Features: AQ5f1Jpw--lDZfA0Vk3koOsYi0nxWZzsBanw7gO5svpLqv7RvmRHvBmokz2Cz4g
Message-ID: <CAF1zDgbyybza6r=O5Dh3JiosLDHHsO2m8qfKwd52mT7vVMXXeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000419b2b062f0cf675"
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

--000000000000419b2b062f0cf675
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Patrick,

On Tue, Feb 25, 2025 at 9:42=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Recheck-request: iol-marvell-Functional
>
> Putting in a recheck as I believe the fail CI reported is false.
>
>>
>>
Thanks for the heads up. This patch did supersede version 2,
https://patches.dpdk.org/project/dpdk/patch/20250224164031.587829-2-ariel.o=
tilibili@6wind.com/

Regards,
Ariel

--000000000000419b2b062f0cf675
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Patrick,<br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Feb 25, 2025 at 9:42=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:p=
robb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Recheck-request: iol-ma=
rvell-Functional<div><br></div><div>Putting in a recheck as I believe the f=
ail CI reported is false.</div></div><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br></blockquote></div></blockquote><div><br></div><div>Thanks for the head=
s up. This patch did supersede version 2, <a href=3D"https://patches.dpdk.o=
rg/project/dpdk/patch/20250224164031.587829-2-ariel.otilibili@6wind.com/">h=
ttps://patches.dpdk.org/project/dpdk/patch/20250224164031.587829-2-ariel.ot=
ilibili@6wind.com/</a></div><div><br></div><div>Regards,</div><div>Ariel<br=
></div></div></div>

--000000000000419b2b062f0cf675--
