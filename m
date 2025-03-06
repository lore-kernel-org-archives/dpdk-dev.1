Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF8C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E593940B94;
	Thu,  6 Mar 2025 18:09:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1EA14025A
 for <dev@dpdk.org>; Thu,  6 Mar 2025 18:09:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741280956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLelv4LESWxQDVbx463DY7oqMv+igYp5ldqxSg3zgVg=;
 b=dkDt1se0sOCu4PWtqB07Tefc6ON3696psF5Qy7wcDOFq2VF/+VaADOfzCfX4JNokugvzhh
 RGCpEm4i7jYYxQxqdwebpkihuIZ0iCY2X4gR9dOL7sdHAXKmB4ZYHwsd+EhCsFQCqGN0O0
 QV/QPgF2Y6sGB+Srknl8XlmXM4GEJIM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-mA_cLAf0P46FU0oH5dSIHw-1; Thu, 06 Mar 2025 12:09:15 -0500
X-MC-Unique: mA_cLAf0P46FU0oH5dSIHw-1
X-Mimecast-MFC-AGG-ID: mA_cLAf0P46FU0oH5dSIHw_1741280953
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54956626b96so555174e87.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 09:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741280953; x=1741885753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jLelv4LESWxQDVbx463DY7oqMv+igYp5ldqxSg3zgVg=;
 b=xS0Y4wJ4o06u3hs65ZJOIxas7UWM5fY1KDNSRnNSVHBWZLGKlglIQY+IHLiV86Sw04
 O8qlfM8VysBptyQSWH9ese9kzxq4qFqdooEFaGjDHZxd61rXwxS2U57J1DfkmweKIXG6
 b+Byr7GJRf5nafq9uBu6XrUrdUnIF3QE0Pygd1vEUZrrqWRIo6bOrCnWrIyHe/Bpi7ur
 11RAL3NHjCPYoe70Vi7aBaVdSwbyjJGfaYTBUJERgMDrb6fCysqN3BDpqb8p9Uw1W8hV
 yND3T/YyO/7DMvXI0w+9/59kBv6qJA0OlpqZwcoOsaEryoGMwZA36UglVaoLZIC0g8aM
 bP/w==
X-Gm-Message-State: AOJu0YyXWQhW57HJs6EUBGIeKFunOnR/C6IttkQKfRCkqHLt5Eyasr9O
 1inTjh2Ew1vJ9a+zph5LyYtozsv7EjRI4Ct8JuiZQSVQFZAVZ/Q+kvKI7uoF6rpx2w6M1HyUT/3
 a7GwzcaLD4ilm0KmeOTSKHWrede+5Kd54bmNTCAM6okqaAZ4eoUd8XqorsaogUCX5d6ee8aOOKA
 qgvHxM0UPiPNEaq20=
X-Gm-Gg: ASbGnct3oydT3YuHtwSnOQJOuYW230L+hMVdP7YrIoL7XidUspigArP0I4QGKsXp5zv
 +m2Wcz3TqcKzDiCXoMUjWVly9WSnKDxWQuk4bLPPFbsiC1OwJtBlu9p9VLrpEMavc14ZwsxYmCU
 c=
X-Received: by 2002:a05:6512:2309:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-5497d37e3dfmr3232239e87.49.1741280953343; 
 Thu, 06 Mar 2025 09:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxxRhAm8kZD2+xVe/s6e6nz/MGAnJ07u0e3Xgz4PLPX2gh/QMR+z205IwDTtd1vNAODLT6t6xeQgZpdLO5dMY=
X-Received: by 2002:a05:6512:2309:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-5497d37e3dfmr3232229e87.49.1741280952956; Thu, 06 Mar 2025
 09:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20250306143443.3972030-1-david.marchand@redhat.com>
In-Reply-To: <20250306143443.3972030-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 18:09:00 +0100
X-Gm-Features: AQ5f1JrjR4hL-37KuRokBss9bVNNzo9BchOrfRPiknJVhp6h2wMRBygpLfaayLk
Message-ID: <CAJFAV8x3aVytEY9wnwQTNHm87TWo7cR7XErf=TBch6JZgB6Wkw@mail.gmail.com>
Subject: Re: [PATCH] ci: fix ccache for Ubuntu 22.04
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jdw5Wbg2ZUUFLbxanqJGhI5QnCNmE85Sg-A_AFNK68g_1741280953
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

On Thu, Mar 6, 2025 at 3:34=E2=80=AFPM David Marchand <david.marchand@redha=
t.com> wrote:
>
> By default (and if no $HOME/.ccache directory exists), Ubuntu 22.04 ccach=
e
> stores its data in $HOME/.cache/ccache.
> As a result, since the switch to Ubuntu 22.04, ccache has not been
> functional.
>
> Set the ccache directory to the location cached in GHA.
>
> Note: ccache is working with the Fedora containers, as the presence of a
> .ccache directory made ccache use it, still,
> explicitly set CCACHE_DIR for consistency.
>
> Fixes: 8400093195dd ("ci: bump tested distributions in GHA")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


--=20
David Marchand

