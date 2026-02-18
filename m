Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2590E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECAC2402ED;
	Wed, 18 Feb 2026 09:38:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 934914014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771403899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eihp6UBJXYMdp/39y9xSMtk58w9BN/nkJrvzigsTjRg=;
 b=JyK1F7hGaYmqMyOykZPi5wn1IMUvVSXmcFfYlSjedqgAOJTfzRjh3CdmNEHKGBfi3DNryb
 1Y8c82/PMvKgnF7k3AyaXpbJyoKDK/eYG5L5RsmPvKXbyeXO3TbtOXj/YQiS1pGgja+19X
 a8wtsnEpm9uLTK/j0fRRrXszXokXnwA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-b4D3GMixMrqAHnI32OrGsA-1; Wed, 18 Feb 2026 03:38:17 -0500
X-MC-Unique: b4D3GMixMrqAHnI32OrGsA-1
X-Mimecast-MFC-AGG-ID: b4D3GMixMrqAHnI32OrGsA_1771403896
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3870af26404so23245501fa.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 00:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771403896; x=1772008696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eihp6UBJXYMdp/39y9xSMtk58w9BN/nkJrvzigsTjRg=;
 b=SC7zxgrVYQ5SZB6GS+zORkH8mXOkiBN5G7Rh4IiD/Se3d2w5EBdfmTeqbCBgHWZ4ZG
 jQw8B3nVP+9BOWqbtGVog+f1H58zwnl1U41lVPbual0qHoZ4vJSri5w3LGq3QnFApSVt
 y2Ecrz0R7yCyMQzPZJxr24QoYEjAt4s3KwYN/3j3USSvfuGMFfN1/2rXPLw60pFitkNG
 V6qx9Y8OjsgkoCD1eA+KflnQMjcrizWsXpyxYKS2IG/IJjGKHIZSospDPXUQ1jzB40f0
 7c0REvn/HwTXhcKDQCGw6qHPd5yFlyMoJgTpCByeLEdX05WwuvOn8NQbe+EWSfalT0HE
 qDFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4VLvKblNkwUhW5rtaqXf0N0cnh4xzUDO3IR2tuYK4ImYuQ2l+Z+H8l3Se5xY+YN+hB4U=@dpdk.org
X-Gm-Message-State: AOJu0YxaSx5HmwT4UOtFUnBm6mAf0vmMzMSHguZ6+e0VrM8cHe+qiTcY
 QEhjYWC5ueWtWVjFkG3JqOAhmvOUybno//GrT4FcjdMuI2WCdGZGc2lLc19lXmmRD8IgAVwLc8h
 CtBZi262zHslOJJUspbdAWvfuU7o4XzUWfriDdCatnYJF8QTZJ2Flt62hJEN7uMjz1bF/q1zQe3
 aUyrMDo9CtajfuhWeD/ng=
X-Gm-Gg: AZuq6aKKSqnxSAMBk+IhfRt5tzhI9b3WEXJZ4J5gRGCqP3WnexV9Yt7/lAKbJ37zanj
 nsIRsKxtqXjXZC1Ajrmnv1aMJC10zTEl3tFQuajebT+JlIOS02/d2dA3RCCQaHRUnv6Q/DeS4dj
 Ow/yhD0B+RsvIrSpTrz62bRYRKjF4nXIgYl9cMr0sGHjsGUKSft23pWgawkSbUpNUq0Jb7Xfv12
 sqh6u8bq0fc8i9eReYSAyqfeKX9ejQGw8+hwv0rlDa+BoIRuooAXbwYqkppLlbGt8nm6Q==
X-Received: by 2002:a05:651c:2210:b0:383:32d:8ca9 with SMTP id
 38308e7fff4ca-3881b8b41d7mr44995821fa.4.1771403896342; 
 Wed, 18 Feb 2026 00:38:16 -0800 (PST)
X-Received: by 2002:a05:651c:2210:b0:383:32d:8ca9 with SMTP id
 38308e7fff4ca-3881b8b41d7mr44995691fa.4.1771403895861; Wed, 18 Feb 2026
 00:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
 <CAJFAV8wcc_+6AY2029ZV8=ft9qYmbztStodF88tVXUS_UPPXMw@mail.gmail.com>
 <aZSsl2wcdM6RFDKL@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aZSsl2wcdM6RFDKL@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Feb 2026 09:38:03 +0100
X-Gm-Features: AaiRm50VxX1zvtvn6ogucHSUWdK9m3hk19hN52aMMitblckcbDW8Fay-iZJusAQ
Message-ID: <CAJFAV8z7KTXwoX+_yAA-iaUYnHhfps2uOx24ZSP70UCWPyOPDg@mail.gmail.com>
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: thierry.herbelot@6wind.com, dev@dpdk.org, rjarry@redhat.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MWqV8oePgolxGeg5AewWl9XJf7p0tuhUjkZcHCuqfus_1771403896
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

On Tue, 17 Feb 2026 at 19:00, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > Surprising we hit this issue only now.
>
> Agreed. Two thoughts here:
> 1. are the compilers normally arranging the data in ways that nearly
> guarantee that the strings are not prefixed by other printable data?
> 2. if we were missing a couple of drivers from dpdk-pmdinfo, would it
> really be noticed? Even in the reported case, there were actually 3 missing
> driver listings, but only one was actually noticed.
>
> I'd suspect #2 myself. :-)

Yeah, the latter is likely.
Thanks Bruce.


-- 
David Marchand

