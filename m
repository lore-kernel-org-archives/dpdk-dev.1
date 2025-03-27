Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DFC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 07:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F19F840275;
	Thu, 27 Mar 2025 08:39:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 721D040261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 08:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743061197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmYlBE1tlYr8+bZ0bpWa9Eunj0wOg89ts26sk7xweg0=;
 b=iu2LkaT9gRPTTF0pQEhTPregZoaaSXoM1/8QolVwSL37KDaMBCEjpwJU4D9x+xOYCKWzu+
 hv/JHGElyxpAbEnSS3QTpamj+EtGFKWt/6+GijRQZaZjBWwI6u51Z/1496Icv2bCWm1+LS
 hwG8rq1/fEjT4vsa0Ae2eYw3HQIFuHc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-qI1WkDYTMcasWG7N2P_Qgg-1; Thu, 27 Mar 2025 03:39:54 -0400
X-MC-Unique: qI1WkDYTMcasWG7N2P_Qgg-1
X-Mimecast-MFC-AGG-ID: qI1WkDYTMcasWG7N2P_Qgg_1743061193
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bff0c526cso3363131fa.0
 for <dev@dpdk.org>; Thu, 27 Mar 2025 00:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743061192; x=1743665992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmYlBE1tlYr8+bZ0bpWa9Eunj0wOg89ts26sk7xweg0=;
 b=J3Aqf9F1zV6IT0kB4AIDDQrI/pyrOJmI1Nb145G6i7Ll/+BLCTX+CrBHHjtxnOuxqP
 Vwi+jniXeUrYNTwMRVwjvatJorO/oKZ+oibeCrGtGRHy+Wjm2RhwQ03L8ZoCl9BicUgf
 r1i2r8RrMLWH0NR2DHVO2DgBbln63gii3orAXirxKZ+uTsSG+Mo4GBmbbHLmqn41UVYM
 SpwKT+DDgbrQeQsNfKZDXHjeJ0sj8QIkxeGIkt1PqlFV2R3tyvypakV4X4MeJGQel2z4
 A2Mbh0BMan8Ku0jLA/JTwchRsFGBnGWA8fFyHtiLnugGJ40eBGMki+SHRMg0G7ScgfF+
 U+tQ==
X-Gm-Message-State: AOJu0Yw2+RqQllpXsO5D6cLsdSQY/q79T9GmkmZ/hRL3BuSsYodf26Vx
 zLrOQISEeH/pWvFKDWVVjdvBRqKuaJIhAwItY7k3WuMTAOMLZRGBEc3TRErNOtpHpy7YcvvKxWE
 OeeDDzDMiTXUKjS8NEmQAa5/clCdBjfYVaJiQ1G7+938dMSPTDbjC306zIYO6ZzIixfpSUgUmc7
 3hHXzG/xc8z3bCe90=
X-Gm-Gg: ASbGncuypER6TgXLSobBCFAMizSxYvsaCrWABwlHT9MCvg+zqzFZ+zaMi0aRJOWaVSi
 2e3Dyn7kDkkZuGWha0dIom6DAFopL8jnh/TnbEaWlXvLez0zc86gEYGCZASsPhvzTUeArvrwBbJ
 M=
X-Received: by 2002:ac2:4e05:0:b0:549:6cac:6717 with SMTP id
 2adb3069b0e04-54b01273163mr835125e87.53.1743061192598; 
 Thu, 27 Mar 2025 00:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI/Pu9Q1dikZnWY6teDorC6WNZ7bSz2Php42iqj3rlke/ZYExImp1KpiE2iaXqg9AK8IozS6O/Rmxc2nMENdk=
X-Received: by 2002:ac2:4e05:0:b0:549:6cac:6717 with SMTP id
 2adb3069b0e04-54b01273163mr835120e87.53.1743061192193; Thu, 27 Mar 2025
 00:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250326090003.858426-1-david.marchand@redhat.com>
In-Reply-To: <20250326090003.858426-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Mar 2025 08:39:40 +0100
X-Gm-Features: AQ5f1Jq980tncuIlWqycXzfHEO7dxgmKqAfLNn04brJfna0PkVxaimPZeL4ZGag
Message-ID: <CAJFAV8xbETVfKBD6ZhKkHYZt_bfGb_uCK8Rf_L-e1Cme8_39MQ@mail.gmail.com>
Subject: Re: [PATCH] version: 25.07-rc0
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jtcc_zYVd7bu4qYgZWnMKuVyk6r9i6-NYAv_hPVrEJg_1743061193
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

On Wed, Mar 26, 2025 at 10:00=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> Start a new release cycle with empty release notes.
> Bump version and ABI minor.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

