Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E0CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 02:49:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DDA64042F;
	Thu, 13 Nov 2025 03:49:12 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id BA9C940151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 03:49:10 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ed75832448so4067491cf.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763002150; x=1763606950; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW160PYP+waCFiFXBp5iVXAEl6fkS4e7XuawTeqnT9g=;
 b=LxeHbHoS6V4PeW+ypCGNhfsJtZ585tRjvUQ+f0cJ1s0augIgVgMb/GBN8nXWqUfwvv
 0WUs8eotSV0s3/eTqM6akz3go3d/ap73r7eNaX5U+c3eJNQoqI7ENR/hcu9uXfkhSnub
 rD+6S90+7g+FvsfTcUUHCht2Ab9EzyGw3WRuEOGVJe8i43eEXmb+l2FSKHzNm85mhnWH
 zqCPxs48Gqkz11TJJ4i39w3KQPz3Mol5vWi+pfrll8wfuBCwiK+ZV7UIxAiU72+s/D75
 8Pk3r20o1cnTkUlr8Q9ZHoFvFtLi1hERXp6zRQ40qmfF1XUo3nQJRIBU6K93d8yVmla8
 IToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763002150; x=1763606950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TW160PYP+waCFiFXBp5iVXAEl6fkS4e7XuawTeqnT9g=;
 b=qrd5RPp6gi1igHMWN9c0EDf5KoVWe0N5TAmjkUfXGVKNLzcd96Dxo/8N2kkO2ag9e/
 50Nlxyxfnnveou9oV1V97MAMJeV4CHQ8HlGatOoX4XraaBn5b/cVcr1vFVM1yDcGaeIv
 dQbtrqVZgdjnNIOxURPREYXr6yL2lcWYbcBbFhxou6l7nPgPETVu2tpck/B7KpF5MvMQ
 0W4mqITXJzzQD8RWJG/okPGhmXE7PNe5sJysDEbP5EYs9AI6iVUPaD9Fp2IbzeQepRQu
 eEzCojrTUUyHYSiGJsDv7etWwSD4vufqcCqxWVCuYMQdnE1Jy2wBPEMVYks4QRaNCtkh
 +ZFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtlQUkZVdDTkJkEVu3WFxhQBttJnItP74x+K4bfA4oO7iKSjkxUyK1IrNxmSVTsdDA2S8=@dpdk.org
X-Gm-Message-State: AOJu0YyETXFWch1yTy8sXHUaaeBvJgRWh7M0214gX3oc/H8DsTvvgv6K
 JfEL7i2WKJhIVoqIdmbQEDhr2pfqpFCvX2p5SmYM0ZJGL74H1xcrprPe9nCJj5b1r6wbTtABq4s
 zdZbmeadbOKBApvZjEjvJeoneGlFP1J4=
X-Gm-Gg: ASbGncvwldh+rnkQC+/Qpsimd5VQ4j6FkAK1Pq+vj+j3DR4Xi5hI/hGecFS0cLQBKjL
 6vtB+pTaFkQTk43dDfzC6kOhAwRUQPu8dLCANWbtIwWt6yqcdZrXIaW0DOrh7uT057zVMjURl4w
 9y2x7bcpvnQdfSH16Em9NDa7LaW1MNwkIjFfHSYwDQz5B+BkVcyHquuikr1pIJ/irqAYq6p9cR6
 HJDYaBmmZ8v/RbGZrxrKoPA73bC2V4f/5LuSYclElBt6NeIhg4j/NW6Rb8=
X-Google-Smtp-Source: AGHT+IHBl9dvAH+dUFJJz3pUoCqf/RHfzicNg5OfUIMH17uZYIsNVDC0Pidh6nFPfo09ggfhF1OsTWV/2L2RIxwe65Y=
X-Received: by 2002:a05:622a:1ba3:b0:4ec:f073:4239 with SMTP id
 d75a77b69052e-4eddbc6a4f9mr72602491cf.6.1763002149865; Wed, 12 Nov 2025
 18:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-23-ndabilpuram@marvell.com>
In-Reply-To: <20251107104747.1131008-23-ndabilpuram@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 13 Nov 2025 08:18:43 +0530
X-Gm-Features: AWmQ_bl5oSNpBfmFMHCQn9G0oRWXiYUXt0_DeqIsv2d12JFNTsCf8QvgG-3CPy8
Message-ID: <CALBAE1PDOwTw8vTNdT3oAZE8ni0bkeJa48FnCDb=cAGkLyo1mw@mail.gmail.com>
Subject: Re: [PATCH v4 23/23] net/cnxk: check for invalid default pre color
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, dev@dpdk.org, Aarnav JP <ajp@marvell.com>
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

On Fri, Nov 7, 2025 at 4:26=E2=80=AFPM Nithin Dabilpuram
<ndabilpuram@marvell.com> wrote:
>
> From: Aarnav JP <ajp@marvell.com>
>
> While converting to HW specific icolor, check for invalid
> default pre color.
> Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>

There are some unrelated CI failures, I have rebased the tree to rc2.
Please resend the series.
