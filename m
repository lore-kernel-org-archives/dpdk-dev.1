Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A3C282DE
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 17:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 025EB402E7;
	Wed,  5 Mar 2025 18:50:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 385534025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 18:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741197031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFenYiYQGPHGGTFTdxbZZ+OW9CqsJ5RxuCWF2u/RJj0=;
 b=IX3WZRsdBjRtFC7doQxbxG/lcVBtEDuyvgUlsmwR5XRbFyZ0+jdALOznVUe+gGeD5vJDY1
 D5CULPheSqEDGOyurWTcxnPH3OSz9a84oAee2Ur6dFB0u4DIhC8+T3Pl/k9Dmcd030DM5z
 CjuUCHBSsULV53j0bmUFF5KLZZsB5Yw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-u4g8b86AM3KKozHnp_b0qA-1; Wed, 05 Mar 2025 12:50:29 -0500
X-MC-Unique: u4g8b86AM3KKozHnp_b0qA-1
X-Mimecast-MFC-AGG-ID: u4g8b86AM3KKozHnp_b0qA_1741197028
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30b9914aba5so28727911fa.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 09:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741197028; x=1741801828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFenYiYQGPHGGTFTdxbZZ+OW9CqsJ5RxuCWF2u/RJj0=;
 b=sjUe8GIk6/9AMbA6ePnjbrtuB6UoTV7xs7kacB3uO4/tFU4UnhBCmY2QoUa+t6fpSn
 h+I2UedJquqmUDb497vHB69FNKVhzdL5Nor7hJz1DPrbabZRwXA+LJ7Y1tD5aobtX3g0
 UCKu73/MNCHW+p5dSUQ/UV7YHSD7IBNONvxFXMNniVyJmgSe6SDR87E3xYRflVA6unt4
 fym1gbvc6KM/jvRdrY2+8H3wWkpdeDkKW3b0ejpNsSrbsayWakdsRr0Yofxy5uRIKwtt
 0DHmGgaexW6ToxzGt6UurCBjTXLXReXQZU4mamaC2aE5QHXd1rFsmwBw31mSrkHQGm3g
 9TuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVzrtokoLC1v4vs9PQfpPNyiNqBnW85ppsk61D2QPkejDoQnWNdcEx38tsMV8l/xRYOoU=@dpdk.org
X-Gm-Message-State: AOJu0YylKjfM3Js0GBf5C0vSR8I8tbvacwCYxUNUCMU7A2Ev2msbnqBF
 FdaXYxbamfavz9JihS7UxFaTaEL/pfIPVIP0bQSgTo2oYdjst/QYnjQmkPmiLBJwPyUVioWFsyI
 PFMkZhEgTgSSErMvoLKJGo7XMJfL7DlaZFM6oBNvlDezqJuwidT5roN/sFFJmOgAVJnzvZWA7iH
 o29cx3Dyef9rsCHrE=
X-Gm-Gg: ASbGncvCG9+GBC4jheN1d6XOKGwc7fh8TxTJa+i8JUqUj80mYR9ynv3KdhnNH7c9wc3
 y25Hwhjt1FQnaU1zQVn+8vNNYlOM/wzS4AJ5QhVmOFAu3cFwMUCdxJslEt9nKD5Pb8rUIHGUdYT
 o=
X-Received: by 2002:a05:6512:110c:b0:545:381:71e with SMTP id
 2adb3069b0e04-5497d3764camr1487568e87.40.1741197028232; 
 Wed, 05 Mar 2025 09:50:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyi9hyanM/jN/k+a/fresx1mInUg0Qi9EwzoTnEZaH7pMhIQAslmhNPNtEPsugCYHucUXdf3oWJyuO34xzNjs=
X-Received: by 2002:a05:6512:110c:b0:545:381:71e with SMTP id
 2adb3069b0e04-5497d3764camr1487551e87.40.1741197027851; Wed, 05 Mar 2025
 09:50:27 -0800 (PST)
MIME-Version: 1.0
References: <1741053304-9891-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741053304-9891-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Mar 2025 18:50:13 +0100
X-Gm-Features: AQ5f1JrYoWHxniE_dNO7VS5I85wOYam4Smxu1UG9eQYARk1kN1TggAXZul3eWLk
Message-ID: <CAJFAV8zYAshJhrD1jkOKHNgAB27tjV6vw+wDdnJ5u42x-xrR2w@mail.gmail.com>
Subject: Re: [PATCH] dmadev: enable lib to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VmEvn7ZWVZdIZv2YoOD6oZuPmjvfrIGPt05EwQbC2G4_1741197028
X-Mimecast-Originator: redhat.com
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

On Tue, Mar 4, 2025 at 2:55=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> With the outstanding issues preventing dmadev from being compiled
> with MSVC being fixed, the lib can be enabled to be compiled with MSVC.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

