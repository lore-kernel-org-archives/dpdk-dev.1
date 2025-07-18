Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E2C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 17:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A94240DDD;
	Fri, 18 Jul 2025 19:37:10 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 61EBE40DCA
 for <dev@dpdk.org>; Fri, 18 Jul 2025 19:37:09 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4ab81d0169cso31729681cf.2
 for <dev@dpdk.org>; Fri, 18 Jul 2025 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752860228;
 x=1753465028; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jwJM4Q461C16ooLAuk1SXr51bfHfwDq9/dIs8lqDcw=;
 b=oS43TVTxkjVm1zUhICrPGLzBs9/CLRREzMOLcIKrKxW5mlSzuxSLyL546nwCTzrmhM
 Fc0qU0PFNUPFIPlpn85hisgxdVJWbUpmK1bdVgO1tqCJpyXLH2oSkLMWk+yDfg8VDPIk
 h5ioTt3tlccB11Xh8OCHcqIhmbz4KdXoLAXzU/hmYSXwGaP6VYKUIXpYyxGt9JYRap9q
 eYBSvJZLub27DxgiJTAmzn0Grf6BbIAxHkew/cpDVuyeg09LS2l/LZkjjns/XVljiPo9
 VGctpLt5SW3PPU15qe4gLv5QLajs7qN2TFnwk16ugj/S0zxXXp/6Iogou4dDvaUqYA0U
 EYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752860228; x=1753465028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jwJM4Q461C16ooLAuk1SXr51bfHfwDq9/dIs8lqDcw=;
 b=pltbdTMSbcK1VomHbSM6pjsAd5Gd7PjPdERpQFDwi+BgKjd4ujKNwRuwKv2crGuvmN
 QY5sh1cIDLT9TfNC1VmOEptJujp9Qep82Gnr+6rGdQQVyxAgZ+K2GIhUU9fvnsEXPA7M
 zuOMp8e2p/vB0bge44xSTEck8jUB8qJVfoZNtnERPM6KA+qvrlvwXzgncGDZ4YZ6YxDN
 jwN5vsmxf3a19JvliKS34mtbXn0i+RAGpZNzpNIf+d0dV8rTTwM/vzTiqx7T8kXQDAGV
 +O/kiMzusPT6a6eJTNBt6nI20JPdnLsyXxEzqbWqbZAh9kc+eSghcY3bvRKGUy1JaFPI
 C8uQ==
X-Gm-Message-State: AOJu0YzQ58kgE3JRlGkiisaNVlsSfxW8cct7iO6JLCHC2kUtxOT68H2D
 pdDipvgSdkg53Nzd+Y0PPjaNwzFyWJJR7M05DkFyM8gqANrB/6FnnUbeSFmOt4+2qFk=
X-Gm-Gg: ASbGncvTbEC7vKOLmWhXwS4/vLw6Mdqj4zJi+Nlr/YINIwQasqNQPUF+/sijas+quSF
 R1dNhARUroXtSELqX6eCi1LM7Yiudk3BWqjAj5O5/Af0cXMWQBuXW2oGXYSe3uy7d1RmdKvcNd2
 80fcf3PK6wvIUzJ0qlvwKNRwoFdAw0V19b1W6uRH0Hlzuvp52iN9vsS2Dwgo/6tvmL0y0iiT6a5
 Ru9APYJwrSWxjot7ZNeHlzp59nnAQHgDS3Se4d5Gp/VxJmHcXb2eYhX73R660nozWi+qn+XGfNJ
 Y2bOEtFu/mPQMmoLtOEN8R+h+q5+O/CXoR1RUhLb1RCeNnZzB5L8bSAUA4sb04ckL0bIm7gNXTl
 urdxM9QwvmI+UmXsm/IpX3clMQ+aRwb0hOJaFLtlj6YpswRo1tS+uo2oH1YSMx76uPDpHUDQev+
 M=
X-Google-Smtp-Source: AGHT+IHMBU3jxWewfA22o0Jf5pChJ9sbTwLYRNdfS5Z5oJcej6w6jJAgUIb+PVzo4wfY1tLKM3DuHQ==
X-Received: by 2002:ac8:5753:0:b0:494:a2b8:88f0 with SMTP id
 d75a77b69052e-4ab90b27ce6mr159217401cf.33.1752860228130; 
 Fri, 18 Jul 2025 10:37:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4980305sm9635311cf.6.2025.07.18.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:37:07 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:37:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH net] net/vmxnet3: fix mapping of mempools to queues
Message-ID: <20250718103704.66a8335e@hermes.local>
In-Reply-To: <CAP1Q3XTfVo5hBPcYZayqWQ81aO=c7MehcVoM1xYzgfJrBJzq2w@mail.gmail.com>
References: <20250709212905.126851-1-ronak.doshi@broadcom.com>
 <CAP1Q3XTfVo5hBPcYZayqWQ81aO=c7MehcVoM1xYzgfJrBJzq2w@mail.gmail.com>
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

On Fri, 18 Jul 2025 09:24:31 -0700
Ronak Doshi <ronak.doshi@broadcom.com> wrote:

> On Wed, Jul 9, 2025 at 2:47=E2=80=AFPM Ronak Doshi <ronak.doshi@broadcom.=
com> wrote:
> >
> > Index bitmask variable used was uint8_t, too small for bitmask with
> > 9 or more queues. This patch changes it to uint16_t for now, to be
> > same as in the Vmxnet3_MemoryRegion structure. This way txQueues
> > can be lesser than rxQueues and have correct mapping of memory regions.
> >
> > Also, the patch fixes memory region check as 16 queues are allowed on
> > both RX and TX.
> >
> > Fixes: 6a113992060e ("net/vmxnet3: add cmd to register memory region")
> > Cc: stable@dpdk.org
> > Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> > Acked-by: Jochen Behrens <jochen.behrens@broadcom.com>
> > --- =20
>=20
> Hello, Can we get a review on this patch?
>=20
> Thanks,
> Ronak

I planned to put it in next-net after 25.07 is released.
