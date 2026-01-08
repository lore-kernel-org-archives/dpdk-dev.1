Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A406FD1D467
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 14:48:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03B3B4067A;
	Thu,  8 Jan 2026 15:48:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B97C94066B
 for <dev@dpdk.org>; Thu,  8 Jan 2026 15:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767883714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I74MO8g+x4LOOoS9ScS5ELiZ92fLdU/4wpqWWfhTOgg=;
 b=jVtuigeCdFoqfbF3CrIYXHMdXPEscXlFtSWKL8jYUQBEH7yMVv6n8l5s7BzLN2BlFSAVe3
 nVi1bvrSY0EpJavEOzgSrfh4mq10Jd7AL3oy7MvFNbOOEsSdoz55bHypvFg6eJU1DYeBNs
 i1TIkFP5xlMcJyB/MJk+eDxdUKtE1iA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-E2evZJ1EPgy48kDKyYlWeA-1; Thu, 08 Jan 2026 09:48:33 -0500
X-MC-Unique: E2evZJ1EPgy48kDKyYlWeA-1
X-Mimecast-MFC-AGG-ID: E2evZJ1EPgy48kDKyYlWeA_1767883712
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6dfc0cbaso1352554e87.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 06:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883711; x=1768488511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I74MO8g+x4LOOoS9ScS5ELiZ92fLdU/4wpqWWfhTOgg=;
 b=FycOx501cCzo1Zr1vbi0v3Vng/ZfmJSpjIaUkxjSOU6d1/A1ABRdM4CmiRV7QXBPjr
 53XODchceeX2QbmMWGD3I+g9HV/wxQUZhdP0enULrr7dMcY48xBl55yA7b/jjfplwkLp
 sBalauUBn77C7hYjXYk/6/icxhtSE4FtsPubK3eI9p3mnVDPfAYARXbcO/YNTJGe90X8
 P5MjBZxdmtH+6SfMXpNxMcpxZ50sMhDFbTmrcPoWmfGugZrx6zXUb3jJD9PNAuSfK4Qb
 pbkTU5UqaiJF6m/Qu+CcTS1B9Dd4+PXBYxckI2rBgcvchctXXKYmFKmxduJsineioGxY
 UF9A==
X-Gm-Message-State: AOJu0YxxVpSpbn3So8/C/93KSR3NRxGFnkgU7iKyfqIHYVCJeLFZMeOt
 3h665edA/izKuOjI41TckXZ4fQwq/FRth6Mv+3PgbEhuxWsROcHZb0P2tf22xQvZQNC8YPuOpqB
 z1XCzFbvuV4jXkln3enw++U6lEEjpQ41kRafwsjDF6UkhIBNfwPL0O3m/Svt/evoP8rjtx0m5V2
 Ez3SAx2p6yDHvaPyGJu0I=
X-Gm-Gg: AY/fxX4Zqffgx4RRxD8/RkoYFRd23ZCK1PtJhkAnOekNCWpKSw79wm8c8YyIsYOyqPD
 EYFyvLbC0Dz4FlRc3ShDaZb67kI6sSJ6w71bmIKkTC1jjbGnv+h2dhoHc9TMrne4DHqiXGMPD1E
 IKl/5QoI2WVjgDZxg9v1Aio7Iu4gWyoJwGVcd7Bu5Idjngaj/tVdxK7OIPP+7fjbZlVH40
X-Received: by 2002:a05:6512:33cd:b0:59b:685b:b3ca with SMTP id
 2adb3069b0e04-59b6ef069c9mr2215526e87.5.1767883711568; 
 Thu, 08 Jan 2026 06:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPbbIZHN0LF/Mqrl5mWvkVi6cJryoVRwrSB1uaGr8/HVQeVv7AvPIQpABQHUqGtvxtGx5LlE8oEnRN+Pyw+ss=
X-Received: by 2002:a05:6512:33cd:b0:59b:685b:b3ca with SMTP id
 2adb3069b0e04-59b6ef069c9mr2215517e87.5.1767883711097; Thu, 08 Jan 2026
 06:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
 <20260108134951.3857110-2-maxime.coquelin@redhat.com>
In-Reply-To: <20260108134951.3857110-2-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Jan 2026 15:48:19 +0100
X-Gm-Features: AQt7F2rnGmC7lzuc0r02RuFZwis3sTkC73c8IV1sD8zivRjW-2_MrhzKhJ6AOus
Message-ID: <CAJFAV8yXDX0t9oudVE1k8SR_qtAMj9jT4=JOP5Q_vRbGTtxSrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vhost: fix virtqueue array size for control queue
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CXjdUnEcbcSOXsi8CE22NxNg5F_vXWuA3PcvgdHIDfM_1767883712
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

On Thu, 8 Jan 2026 at 14:50, Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
> When max_queue_pairs is set to VHOST_MAX_QUEUE_PAIRS (128), VDUSE
> calculates total_queues as max_queue_pairs * 2 + 1 = 257 to account
> for the control queue. However, the virtqueue array was sized as
> VHOST_MAX_QUEUE_PAIRS * 2, causing an out-of-bounds array access.
>
> Fix by defining VHOST_MAX_VRING to explicitly account for the control
> queue (VHOST_MAX_QUEUE_PAIRS * 2 + 1) and using it for the virtqueue
> array size.
>
> Fixes: f0a37cc6a1e2 ("vhost: add multiqueue support to VDUSE")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

