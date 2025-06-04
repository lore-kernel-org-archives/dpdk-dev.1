Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0EC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 258B84042E;
	Wed,  4 Jun 2025 11:53:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 211124029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749030779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PhfTmBtDbqLCJcEiskcyo4+nL+rdVAI61TmV8fOIv4E=;
 b=TnnJEmb7nbh1fMNmLfxjSINVNlmcU9eSOZWujBWYXY+7xuLlN8lcmCcU79RUy4MDxE39fr
 nvlYsO2PyEnJkMpH9uEnyobxt6j/8nDSjY5589IXP3jKlUBh3+IEYhcl/ZzzQQ/mB7nDn2
 zaGEzpq5tYZkSrbO1tZb+3ZNC4RG39o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-57LQImAmOk2pCm6efSGuGw-1; Wed, 04 Jun 2025 05:52:58 -0400
X-MC-Unique: 57LQImAmOk2pCm6efSGuGw-1
X-Mimecast-MFC-AGG-ID: 57LQImAmOk2pCm6efSGuGw_1749030777
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-55324bc26dcso389892e87.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 02:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749030777; x=1749635577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhfTmBtDbqLCJcEiskcyo4+nL+rdVAI61TmV8fOIv4E=;
 b=t7gCuXY6AGenHvtNb3gNXqf9A9kfMyft03ggKc4N5yK+wF8ARo/dhRY01zbrjo0MDh
 yC7wGC+aGiRymzNaoeMaZxfRD0QuoAXvhcEJVjM/MfnplE5qgBt2eC0k5wOThZBY2wYJ
 R28frNtFRySqGnl6imH1Md7adjO8pgRCmhuMashKQMsw59h1TXGPJwALtphqxH0YqAUh
 sBhNaS0Xawc8DoLwCcyOdJvJhzpZAjxcITqTwhgL5ZpD+kawyIqS8X55CY+jff6bKB/R
 otBknToroWvtf9LA18jPBnfaJWcnslGD3S41E1v+99oijDXBG6rfAw9KSQ2f6AT47BIJ
 a81w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWApGT+aH7mvYjHeLQdi/IgJ8FofscHFDJEkSyFHiC158qBRNoCUFrWeAdqCU4KW1IWHNs=@dpdk.org
X-Gm-Message-State: AOJu0Yywi12LQvBK3JQsvELD+ait/VujCxoFpa6m6QObiLcM/E8THwc/
 ZjblIt1VthhLXBSuw/l4xW8O0K/eKPz1GvrtOBtHGS5YdBSvTYny5K/O8D6T26mZVGPcOQCX0Ur
 yUHCujmNMhIJxL+bYqtjga2JjdTfYAOz6CNJZ1x07QS4p/FkTPgVz9UQvuNGWZUTgt8oXmlPXzw
 HUaZl8DrK7rpQSls4Vukg=
X-Gm-Gg: ASbGncvNzwhvi9AhHapJDoCfBuFo2qDS2UlCMtcF4KClevY2lCjrBQGKyQp0O9KYXd0
 XFPq/DZu2G+2DZtHzLiANzQ//RFv1ATuqSgLqr/2zungka6zhl7BMjf5rMxIsEInGeG5FwLw=
X-Received: by 2002:a05:6512:3f1e:b0:54d:6a90:5ba6 with SMTP id
 2adb3069b0e04-55356e2b89bmr657878e87.0.1749030776928; 
 Wed, 04 Jun 2025 02:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdsCykrTn8fxp8KpTn/U0RByYl0IM8bfXFsS067LJJYRWfAovZtECGrBvs6cpttvszvvLelsGjK1vKtcJxo+U=
X-Received: by 2002:a05:6512:3f1e:b0:54d:6a90:5ba6 with SMTP id
 2adb3069b0e04-55356e2b89bmr657867e87.0.1749030776510; Wed, 04 Jun 2025
 02:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250528093644.2456221-1-maxime.coquelin@redhat.com>
 <CAJFAV8zDs2nVvX2ZC=sXX3pwYY4t+-ZrOcKqZpnSbjO4MqZ7DQ@mail.gmail.com>
 <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
In-Reply-To: <20250603175334.x4iknunhjbrsceat@ds-vm-debian.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 11:52:44 +0200
X-Gm-Features: AX0GCFsLT-nHTnX5UzgniWJB99lLyGjO3gUEGy4NzYVJf1X1fVMPYEjwQHAm7T0
Message-ID: <CAJFAV8wkOfzMStekpOMbEsPD3PjM7+JAxYy4R1B=cH4oGH1QOg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: avoid setting kernel MTU if not needed
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 viacheslavo@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nWSIrsNSqENt4e080b2mAcCZ5BAgyQow-bofRpk0p5M_1749030777
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

On Tue, Jun 3, 2025 at 7:54=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidia=
.com> wrote:
> > Atm, I don't see the need for keeping such a cached mtu value in priv.
> > There is only one user of the value, and it is for configuration
> > operation that can do a query to the kernel.
>
> I agree. It's not really needed, especially since the same value is also
> stored in dev->data->mtu, so the kernel query can easily be replaced
> with reading dev->data->mtu.

Good point, which makes this priv->mtu even less useful.

Thanks Dariusz.

--=20
David Marchand

