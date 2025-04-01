Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F92C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 16:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A871140275;
	Tue,  1 Apr 2025 18:37:41 +0200 (CEST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by mails.dpdk.org (Postfix) with ESMTP id AA7BB40269
 for <dev@dpdk.org>; Tue,  1 Apr 2025 18:37:39 +0200 (CEST)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e60b75f87aaso4345111276.2
 for <dev@dpdk.org>; Tue, 01 Apr 2025 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743525459; x=1744130259; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWafZHFu/sLAbQYtNRjSNGm0TIsvnrO4iPo3X3rYxMs=;
 b=StuElmHhCHsDErImRuRllgC/g0TOHodBS9rC2gCCfAGT1OUNm4rQO2hjgWeIYwrpSN
 smQKU69gM7YmY/H/pu+6SMiy05+Ke9S8QgG7pKskdCnb2azt0fc9ayiQCNrWi8vxZ/Y+
 B868BjG+0RFmSJWo7m9PVBC/ixuooLWG58u1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743525459; x=1744130259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWafZHFu/sLAbQYtNRjSNGm0TIsvnrO4iPo3X3rYxMs=;
 b=MyNWUaGd36f9ANtWC18OTtN/JNKm2TtdHJfYWS8W7ghE57aMbK7pRNb003GMDwrrHH
 lNjNwH77ASY5fmINrrmIAywk87yGWsu/CvePMVjMNYDW1mtItjqnp5pOUFoIE4IqEmnc
 /RehDFL3a9qMGRfTumxJPbR8kJQGrq+ZK8e+wTFU19c4TUleAqG9t9iTG1VJmOm3vTbB
 oN22mNveluXjxtJO2hOMCv1jGDz8FZGAwJDqYBmqfoVOIsMWlmzhkSsNxun0vkjS1npv
 BNgsJiI/KbU2HhYbmAxC31jKgDCV4O0u5MQyVZ+07aAIrzywjm2wRfUoX0A+4DfeLFsB
 UxkQ==
X-Gm-Message-State: AOJu0YzaCMoR+1XpuL8LoTaUVxsGE5hE1KuypeOAy+h9yPrtwGDoCrZN
 ZTXNpnZ4D2QSnu5rBLSaF/N9C5yIY2N+PL3ncA/FnOicenPHTMRXb+zoDYbLVpXP4f0s5eCMHtD
 jz0dhP5lTqsGTXObcFfsvYEvJaGoqMfd1WLmyLQ==
X-Gm-Gg: ASbGncuHciPxO3TC4oyfn8hmAD3bcVMHRsZLeoAdCUliLClQK1Kfd3a/J78Qe969KHz
 ZN3nvXvUQ++UVn2Xc8MEeu5eudDfuh82KQz68sVOzzcYQHildkbcaarxQ8TiWR0WsfN1C+kAvll
 cgSe2DJ102HPm+bFvBpZOb5BTPfHBQBnq7xfnCF3t/rCURopG8ahRzwt+D0Ye7
X-Google-Smtp-Source: AGHT+IEil9etmAqRO4rBw23Lujuld3uKziPNhZ8Ro+SXMfeBoP3E55CDrK6ZPcvfXyl8rmIdq34CrUZptybiX7AfkkA=
X-Received: by 2002:a05:6902:a85:b0:e66:b52d:24fe with SMTP id
 3f1490d57ef6-e6b8392b977mr18073863276.28.1743525458767; Tue, 01 Apr 2025
 09:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250318174051.1931041-1-luca.vizzarro@arm.com>
In-Reply-To: <20250318174051.1931041-1-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 1 Apr 2025 12:37:27 -0400
X-Gm-Features: AQ5f1Jrni6Np_QtN6d7p22DpIIZnt0wcgfVBBg-uVG-uRl9DJDCaIOj_0ukavaY
Message-ID: <CABD7UXNenBtZrvUWR_HbHUPSMLAn3EF1x25Avme6iYy+y4=exA@mail.gmail.com>
Subject: Re: [PATCH] dts: add Scapy asynchronous sniffer
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

On Tue, Mar 18, 2025 at 1:41=E2=80=AFPM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Currently packet capturing in Scapy is used by running Scapy's own
> class AsyncSniffer in the same shell as packet sending. Because there is
> some start up time involved in the AsyncSniffer, doing this every single
> time a test case requires it can become slow and unreliable if sniffer
> was not ready yet at the time of sending.
>
> Add a multi-threaded implementation for sniffing and capturing packets
> on-demand using Scapy. The sniffer lives in its own dedicated shell,
> which is setup for sniffing at the start up of the test run. Packets are
> only captured when requested by the tests through the use of Event
> signals.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
