Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102FC021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7920942792;
	Mon, 24 Feb 2025 17:42:52 +0100 (CET)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com
 [209.85.166.51]) by mails.dpdk.org (Postfix) with ESMTP id 9A36A42792
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:42:51 +0100 (CET)
Received: by mail-io1-f51.google.com with SMTP id
 ca18e2360f4ac-8559461c2c2so120903739f.0
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740415371; x=1741020171; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KgJThX6ykbESJqOcjBm0iiwKV4TaRWslK1qafq6Wdys=;
 b=PKF/PTPIWoLmHUx5Ckhm2bppnyhp9ld7N/WRmlROkIS4Iv8c/PAvsA0Bx+uwPVwOAg
 R/xJTI3DNgMM6v1NcLqIb5UNKJPAdvDIObPDihrdBc3Yz8QsERvX5wVj9qy3keGCHi29
 zEJ5KLT2wi317oZqW4ED1056KvGhlJ4g1iBbPNP8l2QB9e+GdgJ3JFXjRUm2KOGPd3B0
 9I2tEvTcjKSoTpLAR6+H7z4ofzsPfV5NvvOclv6N97cfdT6hwRMx8/b8ysaAW8aIErYn
 K1VkF77rXJZo+La6a8+6OcxqYv9zizQZ8ALzItIm9HYTFk3KGLgBa4jJ7wKVaWYeQO4L
 n6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740415371; x=1741020171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgJThX6ykbESJqOcjBm0iiwKV4TaRWslK1qafq6Wdys=;
 b=FlqwhiaFqF35mx7/sWxHlW0VHaKx5zZlmbyOHyNHdxDC332fOZBw+ka86Wwszv2wbV
 h8GA5ztahKqpmadnOS5px62cTCXV7G2ZeEOv9QtFkAo5KP80pCCTiRFMCPjoMYdNF2Gb
 lLohZifWfSo3T4wQ/05q2sdW3XYBsb1I+MxPKCfM7CwVBu9WmvmL48qqCqgD91OHo37y
 kPM05fFjMJltmQw7yNfyFcRHEzp9Bq32ej+rqiw+EfzOiCZj8lI08i0pYiRZLPJsdvnI
 j+Bmpat+WG5mvrKHYjUXVERCqAdOmznRV5Ugihxh+WYCYml+mhyQibAm9NfM4cW59zxy
 z0EA==
X-Gm-Message-State: AOJu0YwExQRXdMj94HiPw9Lc37mPPcUQy2zty1tc7+1eQWIfc5pCvfQb
 hh9d2dyW/MpxLRV+JmNOZH2qczsbHZKw76BeGDqpM4FTSB0Idl1u+vtaNz4SnqgQzLUTeGB7xt+
 ZvQWBGKpOIcy5CW7uDv3flkpiFwWixfi6EwoT9Q==
X-Gm-Gg: ASbGncvJD5gfOf3PrsmMqK1eVlWoxA7ihn85Ls4QUC1bn3aBmdqPJgM9o0N+UuNuY6F
 DArQk6h1GCDadAoyyRio2/SZUzO2Cjj3w4oPptnnwlHUK53/76akaVFAFLVn8/hdLuhzcq0zWUf
 INeycp8Xpc+r0swOsZhE5W+PyVksBVSeBI30OgNps=
X-Google-Smtp-Source: AGHT+IFFRKetHkPAOyeyK1wcC2EGR2q5c7UHmE9ua37dUqIO6JE4XiZDKrhTspLiqrnrqfkmIXBbtsDoSOIle2KpGG8=
X-Received: by 2002:a05:6e02:b2e:b0:3d1:78f1:8a86 with SMTP id
 e9e14a558f8ab-3d2caeeadb8mr122776995ab.15.1740415370889; Mon, 24 Feb 2025
 08:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-1-ariel.otilibili@6wind.com>
 <20250223214123.447579-2-ariel.otilibili@6wind.com>
 <20250224074253.3df64dff@hermes.local>
In-Reply-To: <20250224074253.3df64dff@hermes.local>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Mon, 24 Feb 2025 17:42:40 +0100
X-Gm-Features: AWEUYZn1gLoqGXfmVVL_N_mcGVn-aJlhES1cipo0ZpC_lWUkcG8SMO6Vo__m_-8
Message-ID: <CAF1zDgaa+Fg7kV_QFb6KkXZSBDk8F4jkT2O-yRo77Em9Dhbfqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcapng: warn if NULL is passed to rte_pcapng_close
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Reshma Pattan <reshma.pattan@intel.com>, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f1ae65062ee60786"
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

--000000000000f1ae65062ee60786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Dmitry, hello Stephen;

On Mon, Feb 24, 2025 at 4:42=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> The convention (back from Unix) is that errno is only set on failure.
> Simpler fix would just to silently ignore NULL case.
>

Thanks for your feedback. Here they are addressed,
https://inbox.dpdk.org/dev/20250224164031.587829-1-ariel.otilibili@6wind.co=
m/

--000000000000f1ae65062ee60786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Dmitry, hello Stephen;<br></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Feb 24, 2025 at 4:42=E2=80=AFPM Stephen Hemminger &lt;=
<a href=3D"mailto:stephen@networkplumber.org">stephen@networkplumber.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The convention (back from Unix) is that errno is only set on failure.<br>
Simpler fix would just to silently ignore NULL case.<br></blockquote><div><=
br></div><div>Thanks for your feedback. Here they are addressed,=C2=A0<a hr=
ef=3D"https://inbox.dpdk.org/dev/20250224164031.587829-1-ariel.otilibili@6w=
ind.com/">https://inbox.dpdk.org/dev/20250224164031.587829-1-ariel.otilibil=
i@6wind.com/</a> </div></div></div>

--000000000000f1ae65062ee60786--
