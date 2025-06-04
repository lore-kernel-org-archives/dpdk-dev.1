Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02295C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A17A427C3;
	Wed,  4 Jun 2025 12:35:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 657244029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749033310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6BGcnAM9bgv7pf+n0C5rZW2TRua6bROYr3ohj5v4Sw=;
 b=UZMv0aCYxkDwJ/s7fgjZPsD7OfDUa2wbCRcgObsjIhrpf7pKCxpeuIc1c1DT8ut9szmJvq
 ChClh6Yd0sZY2fGeij4tifV0Qfl7IMbsEDs2o2HZSWvz4O4/D6+eP6egDQX36ubQ+ZDwSA
 OvROVXwQ5mWFncyLetis6ylyOEe7RJ4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-PeDunWMBMu65fIa5TvRgWA-1; Wed, 04 Jun 2025 06:35:09 -0400
X-MC-Unique: PeDunWMBMu65fIa5TvRgWA-1
X-Mimecast-MFC-AGG-ID: PeDunWMBMu65fIa5TvRgWA_1749033308
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553270eb471so3755562e87.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 03:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749033308; x=1749638108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6BGcnAM9bgv7pf+n0C5rZW2TRua6bROYr3ohj5v4Sw=;
 b=wwuaAiTWF8z4tRjN5BnoAk19Z51fYE8YmdjdwJ2q2ZyoPRZot/+9zJZsk3W54UfkRl
 gFq6zg4w12aMY6tv4qps1NCRL7uYafe5fpjnmMLXzdewzHkVCeUJCAI4D1PnW2pttdbF
 ZMZBu9kEcILIW+Jpi8XLcGBbSheKanayclCse5xkh/iWBtDWnj3WcZBqINVX8xgML6+f
 vvAvQmaWGp/eLoLy7MMzDKMtTGQxr89Uf1lDc+0RixkUHI59HQxxxofzq4XOBI9hDPIw
 87dtZq4vPW+G6bX4an1eK0WVPepQEuhSW8iPyQAIKOlz034TXQv1t0YJjU6tBRs6+9al
 lPXA==
X-Gm-Message-State: AOJu0YyOrVupIcBlLddknJiGVWyUTCzHuOgGToOlJ22G85QDV7eziPWc
 Ce4O78IaMRGFzSiWp0Cou1FMc8rtz1RogRL+dN0w4OtAZTBS9KL/OgSflniY7nr/qLKoQ/cdZPD
 FCvQWn2Z5UdMD4ZnavzWEv42osS0eEHbftsSus8B4bU5Y0cKbWb14I+qq3ZK9OlHKqI0RGt8fSI
 tFIPG0to/hRSNvwq25NO8=
X-Gm-Gg: ASbGncsxwcMgZlASGlmTaLWn6QHj5QI6czACJNiWBgerBbj3rrxfvnt6bhGqsbtENyL
 SSpu7P2gATnTU+mNhst0/+rd5VOobEBXUWqpxxQcdagbYRGGXUazybIFNSwiMMNn+2dmE9og=
X-Received: by 2002:a05:6512:3ca8:b0:552:2257:93dd with SMTP id
 2adb3069b0e04-55356bf5594mr568264e87.25.1749033308094; 
 Wed, 04 Jun 2025 03:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdBZw6RZQZAEUtU3EayOHuftdlvAZC9Mg9fvEFem09oJkTd0J9f4Bu8sf3gbf2Rsx+iraVeXa793QfrvpuQ20=
X-Received: by 2002:a05:6512:3ca8:b0:552:2257:93dd with SMTP id
 2adb3069b0e04-55356bf5594mr568258e87.25.1749033307679; Wed, 04 Jun 2025
 03:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 12:34:55 +0200
X-Gm-Features: AX0GCFvVw9-nO9BdSgMqXd9v2IodohQKQV9ISTR8AlYrtfmZWNs78GeDPJS_mD0
Message-ID: <CAJFAV8x3bNgDENPODXUaXPvai-oKucUcLB4NYQpgPsEqJsqQ3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: du42LbfLvGOdqd7-UINKteb-99-2HIG5rRhQRiYTqMA_1749033308
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

On Wed, May 7, 2025 at 4:21=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling drivers on Windows, instances have been seen where a
> temporary directory fails to get cleaned up due to
> ERROR_SHARING_VIOLATION (32).
>
> This issue was not seen on operating systems other than Windows.
>
> This patch eliminates the use of tempfile.TemporaryDirectory, which
> was triggering the issue.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

