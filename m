Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF8C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 09:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BC0C402AE;
	Wed,  9 Jul 2025 11:33:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 303CE4021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 11:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752053589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugBaZfNfyj2IPrH7ZDdmEOJWEJtL5o/ETvkYg6iU804=;
 b=Bo6EYADNgWH6MTqWBhrogs9Wv5DlgC6w7fXM2RMKM3IaVN2CxPoTefBa/4D4c02elnRyMm
 huKPDsU5IqTz5eYv3VYIfEL2L5UTVzDgPxAbRO1ucQG/1Kj+sHSZoRvCpehH5EejxtC3Iy
 XvYwPE9gUWMp23UpqxzhMskIVT10TRw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-5cq7qW62NPK8UNDenxZdWg-1; Wed, 09 Jul 2025 05:33:08 -0400
X-MC-Unique: 5cq7qW62NPK8UNDenxZdWg-1
X-Mimecast-MFC-AGG-ID: 5cq7qW62NPK8UNDenxZdWg_1752053587
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553c6367ec1so2609110e87.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 02:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752053587; x=1752658387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugBaZfNfyj2IPrH7ZDdmEOJWEJtL5o/ETvkYg6iU804=;
 b=Q0ktr7AVQzEb4YzWp3Kv1u0rkI8JokgnYxuEEtNHi2RERCgzIvJQGrqrVXOGCQSbCc
 nC1EgtzDpnaFqb4pT2kdbbmmw2ayztvDQS3QoNkrXx7yzkeacj9JHtLFruSx7JO/kfYq
 065vV7aGZd5FZrArb6hzlo4JN/T5Ayj+FSmSdotLv4G3jiRZIIl1QaPOASdPW82HVK0b
 LKp7kVJPysnRqAV2MYL+qlx7/1jz3d/QLk7CX27c74/I7Cwt9jyXgM1yxmuXbP44GFSE
 n1BSTyuZBPhKY7m7gz2FeGhZFLy0H8cO6pUDrgD/lMRh+DZS58cuWMoQ06e4uR7REdhv
 a5aw==
X-Gm-Message-State: AOJu0YwcaruYhXWgE9r3SLk+THahJPWzpcUtGyLP0BTVM0SuOnCbQDKX
 RdamCNtxLjjV025o1JD4/hUa4Jj93m5hteJemr836kIAbYUlOTAro/WKReJtQNgYwfsZBALorGx
 ZKJZQJwUq4QeGnpETyO3hjrYm5FBFv0DB1GIHjtD6XNnzFXEZe+SVvPHrovNsPT1KJifxCMWS5j
 EBuJFwH/M5SlBzZEALycs=
X-Gm-Gg: ASbGncu+wt4IUXeanE89tz8bDYpeZdkeh3quJXcJdOMlvvNQABgcAC6M9Y9q7ShZFnz
 9ac0/nx6oj/MVGf97IdqaVaRE3abTLj0ZCQTJlsph9uEVnEhSfBp4Zf5acM4k4tV1WS3cE6EH2B
 Mfi4XjHA==
X-Received: by 2002:a05:6512:1314:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-558fa8f9465mr629239e87.31.1752053586850; 
 Wed, 09 Jul 2025 02:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKQYT6XQQiW1mLT2t2bu3HN9Fz4mzKW2EbH/ibBED0YmdDwYk3d40ZkYYZeQLaRQXUSZ31rCMFsEqbnKvH2MA=
X-Received: by 2002:a05:6512:1314:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-558fa8f9465mr629222e87.31.1752053586372; Wed, 09 Jul 2025
 02:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250701113146.1268492-1-david.marchand@redhat.com>
 <20250703082010.2002295-1-david.marchand@redhat.com>
In-Reply-To: <20250703082010.2002295-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 9 Jul 2025 11:32:54 +0200
X-Gm-Features: Ac12FXzz0a0jlH8eyLPmCtGyfyAnT9_h9ycc7MNqCm8WkV0rERiarNQQsxUD4DQ
Message-ID: <CAJFAV8zctc_SNa1JApZk-10mS+kCzYJib1Z1Ga2OjJS8-D2bJw@mail.gmail.com>
Subject: Re: [PATCH v2] ci: check C++ headers with clang
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, 
 Aaron Conole <aconole@redhat.com>, Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XyKMLYK30zJv7ZrVmT62Uhxt-nrY6LrU1xNDw-HPLYE_1752053587
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

On Thu, Jul 3, 2025 at 10:20=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> If not passing an explicit compiler for C++, meson uses c++ which
> defaults to /usr/bin/g++ on a Ubuntu system.
> Explicitly choose which compiler to use for C++.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Aaron Conole <aconole@redhat.com>

Applied, thanks.


--=20
David Marchand

