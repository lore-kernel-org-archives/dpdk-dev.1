Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE963CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 01:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41F05402E6;
	Sat,  8 Nov 2025 02:17:00 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id A488A4064C
 for <dev@dpdk.org>; Sat,  8 Nov 2025 02:16:58 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-33b9dc8d517so1086831a91.0
 for <dev@dpdk.org>; Fri, 07 Nov 2025 17:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762564618;
 x=1763169418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSMB07iXmNBefDMyI180SOadvcRuY0lQ/aHvWS7SaBU=;
 b=jcUXQDfFYBP0us8GcGhGYwIDzd6OtBAYCgXrpVDHYPpsi4Q9DNfIWOh+j61Um9VEBW
 XI6JcCr5KIVUVeMjinMj3l2k84TTKBYlBc7mn0S0eFQnvMmb+RKQTDyKE7LyDlIpCf9v
 SRBbeVuqe/XpoAA+AcPdjtfVSK52/kKxn73E8zJMmjmF7zpwPmW2DEEaVvzRvxaHUYyZ
 Q86J9793hNXzmNJjf6qIeyfjz3NWG8vw/VHPsF59TQ0Qw+ixaq81O+BWJ42q78/pzHbw
 NEwfcjbLodBoW1si5kYKmtV8C6J8nTWXw5nyPZpTJbtXgX9XLgQP+zVXxm+teK/gqtce
 ip8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762564618; x=1763169418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hSMB07iXmNBefDMyI180SOadvcRuY0lQ/aHvWS7SaBU=;
 b=ECvT15dEPGzJ8ju4klbETOnArBmbxSGMNsygskFsiAQdgUMXOsm064xyCR/rKfUUIi
 W/PqtwNXibUUOYdZ0vgYEI0E/Uz6+xcRdWpRPYycsMJBLfZjquQO2oxh9QDhulv3DPtW
 RcNTk3R00XmfemwufdOE25i3NRA0LjjDRigEOSPWStU5VAdvovdluOxnvcG3gJoQEQun
 bvYI9LiF2KlgrLkXeggMQpKKO8eyikuuiufAvhtDcc4LNeHET6p95M4+jYOo2mta8KoY
 r+zl7zOqCpmO7TKDY7wtqbp3tCm1XgX05gYqlBoPeoKOFspj3vTckiKh+0hnhST3vANK
 AD5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyPqgG8KF28IYh3xwKsD5S5Rzh3nIMe9Ulo+Fm7LKK610c9kQIihJLZSGkQ+v1qZG231A=@dpdk.org
X-Gm-Message-State: AOJu0YzQY95qkaJ+IAPM6EwBIXMMeCdoXVLbsK312G75lrSn/rpGVhiI
 9x+TqJUkM99Jg6N84n+gsIknw48JGVBVXEltPiIxGQ0PptVSRcL5+rjHfuQKw0jSOGU=
X-Gm-Gg: ASbGnctYUY7PBcc4+4IvKZJAt4ICFvEjsHn8BPpVouzrjmUG03Xr6vukxBiOalmudqs
 W12hCV0h2jYBjYatea66gmMvOcowxdlKO2GK4g0JkwoHAKI3FHtUu2r2N1QiWpAvcYlPrXfRqG/
 tPnSrORoOU3SbMMo2XLx5hoZzfLMxhkU1/Q3NnufUGA7vl5h1s8yvwtHb9GcGWWwTHI21n3AOXU
 hvw79cRnleiORyJeTsiG8QmWH5dR3EBUreq1rKVINpyXyfKevtd8BsgZ9KtPH6NlZoHXqKyrcxh
 ocbYIRWkYWtrGLUW0QnyTUQKeC56MqVSlsi5EciYsRde/6vrvijrmZC5auRp3x4uEhY1186pMn2
 n4rZlarX6sSQNmvBekxQZkGSYNt1ibAxbWd5JdNgfVNIOCWmkjzbWainIUFyECagrnSZoH5jBFv
 PEuQqReV6IXyogISdim1JmpagAQngFkx56jA==
X-Google-Smtp-Source: AGHT+IEtAIFZyvZzVBCNJF7RgRsIudadAHJvsreCkHdgoyDbFRPb7W71zEmB8b1mX0Dm+nduNKcJTw==
X-Received: by 2002:a17:90b:3b43:b0:340:dd2c:a3da with SMTP id
 98e67ed59e1d1-3436cb7aa3emr1118042a91.8.1762564617828; 
 Fri, 07 Nov 2025 17:16:57 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341d0b47ee3sm3992031a91.2.2025.11.07.17.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 17:16:57 -0800 (PST)
Date: Fri, 7 Nov 2025 17:11:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
Message-ID: <20251107171031.5887f3b4@phoenix>
In-Reply-To: <9994a210520c4760bddc67df29999068@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-5-stephen@networkplumber.org>
 <9994a210520c4760bddc67df29999068@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 7 Nov 2025 17:30:51 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Thank you for doing this! See comments below.
> 
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday 4 November 2025 16:07
> > To: dev@dpdk.org
> > Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > Subject: [PATCH v4 4/5] bpf: add test for Rx and Tx filtering
> > 
> > New test using null device to test filtering with BPF.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/bpf/filter.c    |  53 +++++++
> >  app/test/bpf/meson.build |   1 +
> >  app/test/test_bpf.c      | 304 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 358 insertions(+)
> >  create mode 100644 app/test/bpf/filter.c
> > 
> > diff --git a/app/test/bpf/filter.c b/app/test/bpf/filter.c
> > new file mode 100644
> > index 0000000000..d47233a47a
> > --- /dev/null
> > +++ b/app/test/bpf/filter.c
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * BPF TX filter program for testing rte_bpf_eth_tx_elf_load
> > + */
> > +
> > +typedef unsigned char uint8_t;
> > +typedef unsigned short uint16_t;
> > +typedef unsigned int uint32_t;
> > +typedef unsigned long uint64_t;
> > +
> > +/*
> > + * Simple TX filter that accepts TCP packets
> > + *
> > + * BPF TX programs receive pointer to data and should return:
> > + *   0 = drop packet
> > + *   non-zero = rx/tx packet
> > + *
> > + * This filter checks:
> > + * 1. Packet is IPv4
> > + * 2. Protocol is TCP (IPPROTO_TCP = 6)
> > + */
> > +__attribute__((section("filter"), used))  
> 
> Could this section (and function) be called better, e.g. filter_ip_tcp?
> 
> > +uint64_t
> > +test_filter(void *pkt)
> > +{
> > +	uint8_t *data = pkt;  
> 
> Does pkt point to packet data or an mbuf? I would think we need mbuf functions
> here to access data. Not sure why the test is not failing though, maybe I
> misunderstand it.

The API for DPDK BPF gives option for packet data or mbuf.
See rte_bpf_arg_type.

This test uses packet data. Mostly because it is easier, using mbuf
requires more overhead and BPF validator often doesn't like it.
