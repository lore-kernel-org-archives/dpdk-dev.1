Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C288CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 22:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 340F540279;
	Tue, 26 May 2026 00:18:30 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 0065040144
 for <dev@dpdk.org>; Tue, 26 May 2026 00:18:28 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso12643747eec.1
 for <dev@dpdk.org>; Mon, 25 May 2026 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779747508;
 x=1780352308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0pLvWIuXg2V+W+EEKnwlvGgAHXQkr0H9r/lJsZQ4PY=;
 b=xGYtT5h/hzf6CRKK3vj6+UAq6wQVrLpzpTpdQuKzcjFj4O5Jsu/a9T4fkYlK0Wl9mz
 A/AXEvPDDtMdzQBJUIwjfQqNrbDdWi5ObWlX0PXoe7qknZ72cZ1trOVdORfTllo72i/y
 a+2IbWn502TCNhnXg/NhuA5y3kB2qpqTgFjmRLbZlYkBwHce6Oz1y+kpz6ARwRxTj05j
 yCu5wdcn0J+m96cvz9kr8Pi5t8Jh5+n49TaC3Lf8wrV0JIn8C2Xiav2DzQfQrlmuowi+
 HHq02ruNNEhVeVSGD3fiv+HpajSA52HsTFA+ax6trUUY8TWLfueIHPSsTHRRrEESBssa
 iLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779747508; x=1780352308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0pLvWIuXg2V+W+EEKnwlvGgAHXQkr0H9r/lJsZQ4PY=;
 b=mzohWAUOlgKPgVTTOJ6YwixG7YaH/0T0d2x1Xr83DZuTNNZ+H+KvlvBXR8Ce8q16Pu
 iLvZw8aB2LkZOcn8kxUFMo3dP5dLBOmnntbtQi7DayXfZlXMKKPy6PI64KYba+QoEkvg
 JKDe/17M/SMm1tYkXm8R2xrNlJaexR6P3eS2S1arASxQl+mfKoayBvMIx2GLspb2OEUB
 otfDqPrcXCq/k0IsVnHvlpDSMZs8KH2HX467oShwTEE471Obgb6nbEwf7/AMnn4MnlQ/
 DX6LnhjSMngcjKAnLy3xNzDyL7GS37i9ZBDm4GXtXt7jh00NFPMzZ4fstly5ebqRArPb
 hcgg==
X-Gm-Message-State: AOJu0YyfoNsu0yjBAnCXg8181sFlGq/UehwrmWLEhw63/ZsGoJLVlnLy
 ArPf5bohgiqNaqJBbk5Y13Eh/RgN+/lgPBzKpc91IPxgQtXKsN64iKyTzF7NJy9mmio=
X-Gm-Gg: Acq92OEj/HRxkvypXeWh5vDfZYP8SPqDwaawjna0kzlr4xEElFVPArHmo3IQscaPBjk
 wBoWaz3EEkoIDTlmq9uk7v9M+h1BXsIItEXLYd6YSSyogMbwnE3h2SIMPJ5b+wmbKiDjJI5L+ic
 U7nxLxfY2mOnO4OopdYKWkFZoZ3adUByc7uEOpy8MuT+iIkHpcIU8bh4J0ypItaUVkt+Hp7l0RK
 RbIpy029fkfYW7v08S5qSMjdUPnv97HnIsEGDablEXeipCKc3KIerv9dIXlTWa3QyNqzbl83vKc
 Lkj1VWUVhaTHkgaQPXx4ftYXAkpd1YAJB7I1fgNMnHsf55kX/VDpYdwxSu+E42ipOFnXV4r0FNG
 wX8bfHyEDJcKyaTPaORsJpr+PkW0Q/UkdOta3Wxwq3MDS32FQMlhWv1/5b0xUyeDaumDuS1Ej8H
 kISnZmRdpYwynjekQvOelVQ9QiqjUf3FzS6toh+9FkVclSKjc+sn9UO7vGIynJ4yn9J7QNb3Jgm
 yc=
X-Received: by 2002:a05:693c:2c0c:b0:2f3:c3d4:382f with SMTP id
 5a478bee46e88-30449092145mr7609960eec.8.1779747507704; 
 Mon, 25 May 2026 15:18:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522314a4sm8642436eec.18.2026.05.25.15.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:18:27 -0700 (PDT)
Date: Mon, 25 May 2026 15:18:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
Message-ID: <20260525151824.6a32e829@phoenix.local>
In-Reply-To: <af3a4738-df30-43c4-b3d9-5ec1912a307a@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525073029.235b4d40@phoenix.local>
 <af3a4738-df30-43c4-b3d9-5ec1912a307a@lysator.liu.se>
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

On Mon, 25 May 2026 21:39:20 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> On 5/25/26 16:30, Stephen Hemminger wrote:
> > On Mon, 25 May 2026 12:36:39 +0200
> > Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:
> >  =20
> >> This RFC introduces fastmem, a general-purpose small-object allocator
> >> for DPDK. It is intended to replace per-type mempools with a single
> >> allocator that handles arbitrary sizes, grows on demand, and matches
> >> mempool-level performance on the hot path. =20
> >=20
> > Makes sense, what a simple wrapper inline to allow full replacement
> > testing/performance A/B comparison? =20
>=20
> Do you mean a mempool or a heap wrapper? Or both?
>=20
> I haven't looked into what options there are with mempools. A mempool=20
> driver should be possible, but then I guess one might attempt a=20
> whole-sale mempool-compatible API as well.

My thinking is a yet another allocator in DPDK is just another source
of confusion and bugs. BUT if it can consolidate and fully replace
one or more existing allocators then it would be great improvement.

Mempools are fast, but fixed and space inefficient.
Rte_malloc is slow, but flexible.

Also, need to make whatever is added play well with static
and dynamic checkers.
