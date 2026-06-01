Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CACD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 21:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A258C402ED;
	Mon,  1 Jun 2026 23:18:58 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id C4C7540150
 for <dev@dpdk.org>; Mon,  1 Jun 2026 23:18:56 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-137dd5161feso938284c88.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780348735;
 x=1780953535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ediB+ra8ew9Dv250eGoqjm4W5ZYZHDsyRsIRY7cUtw=;
 b=Fqd13470cTD1lUVP2gbdzRmwau/wX3qb7aAgr1Cl6SQAFiOuikAZlBNrxku7lKDsZZ
 qZXLm75UNpQtxV7UZkxrdhgKhcB5DtxT7gXlzTDgtH00rQ9Ma8HFNPX+EOeUGkUDSf2q
 W1YEII5CL0jJyPqimUhm0CDWHR0GkSpqOt1dzfdxbgYse6qXnbQ2mSDp1FJN/1TPkyz9
 suLqFc+fAl/SRq12H/vH45G+tPK3Cav3LCi6LoT86hybUx3ByPgGzZ5UO6JNcQzJoy13
 QbgT/xbGT7zzLqmq/t9FQymAtfpK4pLnTMfGomQVhTeIwHx8hM4A1qLzd/TEQn8bJxq5
 +F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348735; x=1780953535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ediB+ra8ew9Dv250eGoqjm4W5ZYZHDsyRsIRY7cUtw=;
 b=pZPdjAx8FKuV6oLOOrEJXU23auQUfboO+3pkH22viDk4G+SI830FEtm1ngBb/F7foU
 nz7AHVtjX/xpe764MDapOxuWF356MTA4e7M10BCIKX0VQyhhBpNXFT/u18E1trl4KqKG
 v5gRSvQnEFdZJwyketXALMCpnV8dOEP7GVGR8cSaAuXcnkacK9n/KK0sX3KSJju4L423
 +dn4btTbUXNegRqpPz+eTnH+A+GkTgJniNkbA3ICQ2Q6Km6bpiSrwEkTrlRgB9jVcVtR
 6yndNTbSNwoen06p+2kvVX4X9x7jbJxqThayANk180jF87MGmbk9jjW1Uop5ghCPsPzl
 I+VA==
X-Gm-Message-State: AOJu0YxPiH3hDokIlu0FA3fNy1F7EjZcWYSpKVchVstAFoE4HdkWZCOp
 AS0xiT6hVLfNGxMGwhJ+MEGanAE9MhMayBGmMxugOfJvQG4wx0eEOyjFNUpuz6EnhVo=
X-Gm-Gg: Acq92OH+SEYjrd86GkASGgd5dwC8DhZtk8FECW/zVZ+J/K0yumGuxYd2DOSPuUBqTJC
 94/ghkwU4itOUHqd5ZqHVOf5ZT0VR4f6reKZVDT+rFr+eWk9tleJwtqc3F6XGeBLGG6YjJv/O4k
 ++uF1O5Y8RAcjYVtZhCT46nJZbeUu6kAnng4+dtqW/CyXTleHdzUTjIf7OqcZfnoPPF/YUE2RQC
 HvqIibjmONX1D+OUZCQmF2q/6PdkUOSZ/e+7kTPKCDW/xzV6/wfAgJ+bC25T5pjgqPZBSJks1rd
 aHE0lvqywGs6tkj5pVkiwbn4Fp5DYpAC1MZGzwi0D3VkUI96WLI1ZeCbivQU0u7B7kjDo1+Ivjk
 piWg4t1zsu8o/INt6zzVWv2Jwlfl2RgUbGBId/NkuIqMNxg+Y3v6y0NddtmmWbEch5er9rtgXad
 l+5wmFS7omZwvaMxdOmnvmZrG4p+S4VqEWPTRphUHvsdDyr9istBV8Z8nlm1Fplt9y7x4hkSaet
 utBbtGnZ5lvYA==
X-Received: by 2002:a05:7301:1f0d:b0:2ce:3aa1:d39b with SMTP id
 5a478bee46e88-304fa6800b9mr6282200eec.20.1780348735040; 
 Mon, 01 Jun 2026 14:18:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed30fff3sm8745373eec.12.2026.06.01.14.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:18:54 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:18:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Message-ID: <20260601141852.78c3cc79@phoenix.local>
In-Reply-To: <b8523a4e0ee34e8b9194935574e86f7c@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-4-stephen@networkplumber.org>
 <b8523a4e0ee34e8b9194935574e86f7c@huawei.com>
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

On Mon, 1 Jun 2026 18:18:18 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > +
> > +	/* check that we have enough room in ring */
> > +	if (unlikely(n > *entries))
> > +		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
> > +
> > +	if (n > 0) {
> > +		*new_head = *old_head + n;
> > +		d->head = *new_head;  
> 
> There is a bit of inconsistency with the 'load' operation above:
> If we use atomic_load(&d->head. ...) then it would be better to use
> atomic_store(&d->head,..., order_relaxed) here.
>  

Will switch to atomic_store, with relaxed.
It generates same code on x86 and ARM as simple store.
And makes C11 checkers happy.
