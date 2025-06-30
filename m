Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C58C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 14:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF7EF402CB;
	Mon, 30 Jun 2025 16:57:56 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id DEBEC402A5
 for <dev@dpdk.org>; Mon, 30 Jun 2025 16:57:55 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d3862646eeso141225785a.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751295475;
 x=1751900275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwmESG0VaS/aqgl5sXTckTfMAIj69ixCgYQcve6ICi8=;
 b=Y/fuZ9SVaxTfzH98Dmv6SQO5WOpdVA5RBUbcYtJ1/nSKiEA8OgAfa2CjC39nKPbsvP
 ddbrIF73RiUu0VKC7WQaxgRaR5r4JW21gQQ4vE4VPTbTFtdFaB5/wxZd+y+DWlB2riXy
 7EwU0IB7ZWSzGQ4EBJ+2yPMgyFOSyIf7OwFDlLw39STU3w31ntQbCUrfzRxy4t7C8KDu
 2Xwd1hDbw1rfnwYfapCNtj0kaSxYNBGLiL4nByP6ab/eN6IgDwOKgstnAQxtRg2JP/FJ
 p3YC2DlB2eEEf8tqSQ6dVnwEjdsYBq+DLD+hccBHJEdiLL88cEf5i5uVsTtyJ4sb+gBQ
 Wwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751295475; x=1751900275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwmESG0VaS/aqgl5sXTckTfMAIj69ixCgYQcve6ICi8=;
 b=T3IGnrNeNm7V6Wiifdyin3w9IfTY9GQUY0vu7UHwsnxEAPqiN+TliCwddTNAMHL6xl
 314yAd7wwqmhz6N7P3OjiCDn070cIts30K5gRC1IqXpXUb9zf4BPn+b4xtuMhxQkHPwQ
 urGdv7WXy42i2Lo394dJ6hNGUtoC+BMlE+ZIZNRZiR8nAqlgVLAVlFYmJ/Ywk72tesjn
 /fUz4Kk+DmeohOewQhay8GhuFVh0apboA3j2kehfmSwEDViL+g/J2zFXYNoVeuXB4hIP
 Ks0PvWC9WwzylNCKQVXNlqpsH4UPKie1e5fSP9lKJHkKTGrrrLW09yP5thc7IphSPoZZ
 i8GA==
X-Gm-Message-State: AOJu0YwC0+/PLYDM3x3xYUEW9TKPdtBU1K0Ig2/UxBLj+PYYqzykpxyP
 LPDPRRp8ajh8Le9RAu5RX604tQvlCdR7kvZM1lTmKrFf2gRR64QNkiOvgHS77ixxWNbdAnXMBEB
 HRGVO
X-Gm-Gg: ASbGncvqXaXM9Q1d690GU7L/A0fZBSagdB3gPXdJCU6ta4J4V0aE63gqv+x+ZNB9VET
 zZfyPeTwOHFnivCxDzTzhm2TC6bPMermU3r2Z5N+momEmv/8/08UNb8nHSvu8DwGZmgghnbMNW3
 OCaQVi0n+Nyr1dhMZ2wrbrE6ZV/7ppKUo5utfeYqHTQn6PX9K5RzLJenkwuyOYC+s6tBr7K4KEC
 QUfjHc6KzOWI1SVBGUXw1zo+sDaflULuCmibyaPeQNfVmXBLp1t6wqyNynAjykSjghzNfrgleEn
 r4xmen1O0ZjjOMMKoc3Ov1RD6QhtKK9UztLogidl3bfE6MxG/vpLJlpoqQF+NlD4WlSyNv8/Mwm
 PBkFO5QrCw4RFfdXbJ7asmfDHJwJzjBaLxGtLHJg=
X-Google-Smtp-Source: AGHT+IEzTKe2bMA4EGatTvTQ24+IjPdRvs/a7PFM+arCOHijVhOnFzy4HvOqk7WfICIx8IkTlWni4g==
X-Received: by 2002:a05:620a:444c:b0:7d4:6138:bd58 with SMTP id
 af79cd13be357-7d46138c500mr296958885a.52.1751295475189; 
 Mon, 30 Jun 2025 07:57:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136815sm606033885a.21.2025.06.30.07.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 07:57:55 -0700 (PDT)
Date: Mon, 30 Jun 2025 07:57:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH] test/argparse: fix out of bound memcpy
Message-ID: <20250630075752.0f860529@hermes.local>
In-Reply-To: <aF7pef1HMfjT88-e@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <aF7pef1HMfjT88-e@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 27 Jun 2025 19:56:57 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Fri, Jun 27, 2025 at 09:22:35AM -0700, Stephen Hemminger wrote:
> > The rte_argparse API use variable length arrays for the args.
> > But the test was only putting space on stack for the argparse
> > part, not the args. This can lead to out of bounds writes.
> >=20
> > The bug only gets detected if DPDK is compiled with LTO.
> > In function =E2=80=98test_argparse_copy=E2=80=99,
> >     inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/tes=
t/test_argparse.c:108:2,
> >     inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_no_va=
l=E2=80=99 at ../app/test/test_argparse.c:490:8:
> > ../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 wr=
iting 56 bytes into a region of size 0 overflows the destination [-Wstringo=
p-overflow=3D]
> >    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src=
->args[i]));
> >=20
> > Fixes: 6c5c6571601c ("argparse: verify argument config")
> > Cc: fengchengwen@huawei.com
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > --- =20
>=20
> It looks to me like this is a false positive. If it's not, then the whole
> method of declaring argparse arguments is broken, and the library is not
> really usable.
>=20
> See below for what I see in gdb for a regular (non-LTO) debug build. Looks
> to me like the compiler is doing the right thing.
>=20
> /Bruce

The problem is that the when structure is initialized its size gets boosted.
	https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Flexible-Arr=
ay-Fields.html
	GNU C allows static initialization of flexible array fields.=20
	The effect is to =E2=80=9Cmake the array long enough=E2=80=9D for the init=
ializer.

	struct f1 { int x; int y[]; } f1
		  =3D { 1, { 2, 3, 4 } };

It looks like a compiler bug that the extra size info doesn't get propogated
into the copy code.=20
