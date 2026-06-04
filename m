Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC14CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 18:33:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA423402D3;
	Thu,  4 Jun 2026 20:33:22 +0200 (CEST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id D53624028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 20:33:21 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bec449cf976so144441466b.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 11:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780598001; cv=none;
 d=google.com; s=arc-20240605;
 b=GAUe3+4OVNGj+GGGUGLa3JHUnQc0xgFMlhUSa02KNY7ZZM6tp1Qu14GPWoEcUNSzu9
 byfyghXAoZv0s82pnCI5BSeeQ90rlYK5SzflCvn1mBhD27jNMakKBSrRn9m6FGCt90rO
 TfLDXVxudAwhVbPvr5t9PvL8JYCgZG5agDerxWjrBzeVCPRyank2myvW8XS6B8KnttCN
 DOIwP/W+PHdwQ/JsUEUfw2OIin6BFke+AtetAka7JPweKT84UwFTh+haD3zXPsSENy00
 sedq26/uYrNOaj3H3NKvUedB7R6Y/lcLdvritpSq1iH+mOqoGlTXgJcJvGr+Shw9TcFF
 TQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=og0Jmu+oH1VDmh4H9DGGZwvOyUAUzry5wdFI7z8OUoA=;
 fh=h2HGuyocI9HHTiC/2UmUgfnu+0cMXVBRDUUcl3GEQoM=;
 b=cC1JFXtUsI9YQBTDn4yPnVNFfThwU6kJeEcdiX0htQXJXdDmN+IPoRxK3XY2BW2sfw
 dbDz8pGu/7l8Rt0lw+grhmGO1HHGQm9iYYVZTczolTZ4kyk6bm5Qc8KNmwmBWEvYQ6BW
 rjNopEA8NWBFmuCJ2key6hrwo0pnm/x5oH+l4061zCzfdyVLQzD0zwFofpflfNt6IMmJ
 GtYP0MqsGmKW34q4tyQ4SvRrK0B907EphVZttIKSZI7LmgFypOpKIIlX0V2CfRAQPYE5
 5QnA64n2g2mqR+rO4L5PsG/Oik9k9/bT4VPIcUGjWelOVX0HyHnvTlDoWVr0BHorovN4
 yhVg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780598001; x=1781202801; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=og0Jmu+oH1VDmh4H9DGGZwvOyUAUzry5wdFI7z8OUoA=;
 b=h3kNoVDXLHOIEEp8jy904UHtYmDsUBAlg8Nnkn02Xv3fLZIxdD0W5acAPHgrlVfMZT
 uHetRBY1oacVnNmFBGAhXpqZzRuXafe4SAABlT2mzA6Cz+K3BJSwfeqD12NH2Hp2OqyR
 8HdGdHpkv1wT9sNudYH3cKSxihHizgIrd4NvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780598001; x=1781202801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og0Jmu+oH1VDmh4H9DGGZwvOyUAUzry5wdFI7z8OUoA=;
 b=aGzAYT6+JmY6cS3nzx24qH7JzzMZQ/KLss/orN1UV25qpWZtuJ5Wd6whFBfzGS19zE
 Ayq4RfalKx/JTR4RDWiHGv9+rOoEJ1Nvmf4dyeAu6RNCGrptAfQ3OGmMnCzTqlE5VTNm
 sia2cSaYZt/N1JCKArytCv2dUMA3fOvvTztmxK9vxZK/O95Y5pMalGf0vKSEcwS/MFcX
 4ox1val5AEeNbBNtcudZBWcxTCRtuBnXo3cPMKVOBDiDa96Se+kgAROJkOo6n3paQ6cz
 kHiKWISldY0Tui6on+rvZuQ2LG7limXGvP4zl7hhuVg7MTPiNC9/VaWr9Chr9I0hADaa
 DJ7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GQE/sJm2JcuboDyHT2y1fkw6YUn9Unxs0VhY5WQoEeWhWbcJtdUlccFZNNuWcIpKpVHQ=@dpdk.org
X-Gm-Message-State: AOJu0YykKnV7vNITHEh0b4Ghve+/nN4s1w95E42iUJrZIh+RIO0LWorc
 XJZ1OZjjfs88mY7jfGQxiWkLaC9pD10R6XsrxmuH8ubYNHHRjtcMu0BfxT+zEUqpbVriFEhqIhB
 j5Mde6zaDoJBPyIfV+Xy8giT12WgbfP161KSVzBC9Zw==
X-Gm-Gg: Acq92OFSltrCMOQBmsuMQwhq2iqCFYOsER24Cu+EQA2kEc+52MqGe7vh29uicsMMB5h
 HoEvB7abfWgRtMEVti7LxlOsNcPZsasyuYOv0i2A6smgTx221REn25uzrVDTg8GjAXqHyZo0Wh8
 hKeajZY+JE0Gv9MZkEQj98FTNLe4ZFdaL7oVwojwtCrbBcIEzJzQJMIOFmlQfaA5RswuHZ+nzwf
 bzehRcDtRSpj+Sm8GmKZUzLdhEvuSi83VbWqXwrNG68QWNsOksebBcEPeOa0/Js8Zf6CGaycLT0
 a2P24gaZo1QPg8/fF9dPiCyOQygsIWZ81C043J6OtTgXpIVXXioSliYT2KbU8og=
X-Received: by 2002:a17:907:1609:b0:be2:208a:a8ae with SMTP id
 a640c23a62f3a-bf0a9907b61mr552231366b.22.1780598000808; Thu, 04 Jun 2026
 11:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
In-Reply-To: <20260602163647.101815-1-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 4 Jun 2026 14:33:09 -0400
X-Gm-Features: AVHnY4KtPQ0NlYpb-MtGU-sxlH6fStts8x1VTuhr80Ikex6MmGYmdkonNuDgfYc
Message-ID: <CABJ3N2X8MvK1fKJ8y1Mq1MauMZ4UcRH9Qn5YTev=9NBs=QwyuA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 ahassick@iol.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000538342065371c750"
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

--000000000000538342065371c750
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-unit-arm64-testing

--000000000000538342065371c750
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-unit-arm64-testing</div>

--000000000000538342065371c750--
