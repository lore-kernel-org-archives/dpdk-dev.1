Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBAEE81A45
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:44:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92081402D1;
	Mon, 16 Feb 2026 17:44:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79C95402C5
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771260251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZR/3IaLQVU0cBMI6OvCBxUgfmceKv9ec9D34CqcJ00=;
 b=CjX6KePB3oU70D8sZMF/MKSuCOWkJ3a5bKjZjp4/RBICQL1sHBstVZA1IRqpsUKGMdeTrO
 ij3ZaZvehGj3jAKmbnBXZKCxjUHMlmwNVVYrvn6vBbeAwgItycdDQPiCWAnnSYsaPaDCtZ
 XPKP3Mm2sUm04gh+GYXjANvffZ6zogQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-W3uY2WeWOze-mITvRrxIfA-1; Mon, 16 Feb 2026 11:44:10 -0500
X-MC-Unique: W3uY2WeWOze-mITvRrxIfA-1
X-Mimecast-MFC-AGG-ID: W3uY2WeWOze-mITvRrxIfA_1771260249
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59e57bebcc7so2172699e87.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 08:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260249; x=1771865049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZR/3IaLQVU0cBMI6OvCBxUgfmceKv9ec9D34CqcJ00=;
 b=a1CnZdUQl+FNtTrQm4WO0BaOXW4SfE026qGh821u2+QepGjt00S061AfW0NyE8xHIz
 RfYcEbT1DhGR0VsMXFWyc4gkWM3mgxcuUF3guq3j0RqlKnyTG9ak4tixTPrT7MDjzRLo
 tDpNddfPjmNe4Qyhrpuq+yDgDWhzg5Z0Fg7qU9Gg8VgJLJ5XKQe4Kpne6pGWzV3TOJog
 rlSHAvcv1ekyz5nnXBaN8ox8HDU2FPt4K9pITufuyEDzu04ESfZt+Z+uj+1l0UtSf/3q
 mMrCcIG/76xnJ5eDB4E6uFb9tOhhMWkP9O23JADZAg8BEqQ99MwysK0uo/YG2NMQgJx3
 HBDg==
X-Gm-Message-State: AOJu0YzUi4rULrNBsN+VgPvDmJR2PVt9r4Vk1T5pyNDyCfMGzHEulkyv
 SipIWsbQMYX+k2nZMrqWJvJSao68fk742ab41IV916oD3sULndn1h5vHvgDKbmk6S8Pt0tPiBTe
 zVloXVP6Y0teY/P6cOsrnUnvqbAVClA441UOIjB0VlYZE+Jsw++WzhyLG/jVUYfD6Q0dFV1FYOG
 FJY+dKJJhLmM0oYcWhhP4=
X-Gm-Gg: AZuq6aKpGNvTxG8awjYtKcmPSKFbyO6zTz+qod4BfBu44dKlSrFQxvS7JyXnaQhtWA3
 VwswJ9g2E3qspVTLtSEJeMoN3DAMsBKVnGiqPROjnM/VtFmst//HetrJKTQpA/Cjce7n5ruuJwZ
 7O7VJ5DfUlr10C6EBJ4EDw3WLSRhzEUTxTnAWfC/JfynA7ycmJ1cBII+i1qwdbxrbtQr8N5gMd/
 a7RKopMix2BTcf/19lD3oxFVAVfRRePxke25if3Q9Id9XJUqhx9IOwv1t94QYFpbMFl8w==
X-Received: by 2002:a05:6512:1255:b0:59d:f274:c50 with SMTP id
 2adb3069b0e04-59f69c0f268mr3496898e87.6.1771260249068; 
 Mon, 16 Feb 2026 08:44:09 -0800 (PST)
X-Received: by 2002:a05:6512:1255:b0:59d:f274:c50 with SMTP id
 2adb3069b0e04-59f69c0f268mr3496891e87.6.1771260248551; Mon, 16 Feb 2026
 08:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
 <20260213192039.221213-7-stephen@networkplumber.org>
 <CAJFAV8x-9SDi2hfeAHT3zaxr0kSiAEdW=GtHkKz+DTr_K7-H6w@mail.gmail.com>
 <20260216082619.0e42f1ef@phoenix.local>
In-Reply-To: <20260216082619.0e42f1ef@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 17:43:55 +0100
X-Gm-Features: AaiRm53VlhA_PY6UjhInruKVwVAuwNWk1E9bgrcjPrgmkmwwc3HAGRuftBhElcY
Message-ID: <CAJFAV8wyyGp+Smd6gjH2_wPsOs1HqoPaZFJb2DRs69iugLSDVA@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] test/pcapng: skip test if null driver missing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: elrWOHMWoKDmSYSVB9S3-rUWjYGCj8nxqYdnThcx1OY_1771260249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Feb 2026 at 17:26, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 16 Feb 2026 11:01:34 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > On Fri, 13 Feb 2026 at 20:21, Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > If null PMD is disabled in the build via -Ddisable_drivers=null
> > > then do not build pcapng test.
> > >
> > > Fixes: 6f01a3ca5c7f ("test: fix dependency on pcapng")
> >
> > There was no dependency on net/null at this point in git history.
> > Instead, this fix is about:
> > Fixes: 0c614a0fa6c6 ("test/pcapng: cleanup")
> >
> >
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> >
>
> The point is if the null driver is disabled the test would always fail.
> The commit log is incorrect, the flag would be -Ddisable_drivers=net/null
>
> Seemed better to just not build the test if the driver isn't there.
> Alternative is to detect it and marked as SKIPPED. But vdev_init
> error codes are very broad, and my preference is to save space/time.
>
> # DPDK_TEST=pcapng_autotest ./build/app/dpdk-test --no-huge -m 2048
> EAL: Detected CPU lcores: 32
> EAL: Detected NUMA nodes: 1
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'VA'
> APP: HPET is not enabled, using TSC as default timer
> RTE>>pcapng_autotest
>  + ------------------------------------------------------- +
>  + Test Suite : Test Pcapng Unit Test Suite
> Failed to create vdev 'net_null0'

Then please fix the commitlog and the Fixes: tag.
Thanks.


-- 
David Marchand

