Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FBCD8C85
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 05:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BEB1402AD;
	Tue,  9 Jun 2026 07:07:10 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 66231400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 07:07:09 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-51775f2473aso38518681cf.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 22:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780981628; cv=none;
 d=google.com; s=arc-20240605;
 b=QfvyonySPVpT7v9MKguP7eXdM9hcUaBRhSaPiCTEjhs/U5GpOgqpoqwyqWd2WuEvFF
 qYqhpQEjWreLnYk9017Hxj1WOv602XinoBHmD63jcWzGl0wCkow4bDD70xvUzwV8Dlfn
 /7huXcs+FcqmYN7IlrqPjmWwqQSz3LFVSajYYprwrLszo6xkI23YfsGPfemL2nW35u3F
 k0gR4YeOwEGwC74j2MNLF61sDfn9QlFL/SdLGRl7YS78krEtNXrBowcza13AmauETUWE
 qb1zBrCo7WLVIr4ugfN3WBmbLOmO9IDQ4qyhf8PUsmjBm2j1SbTAilOpi+/wDb5lSIXS
 5wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n5jDlQRDHDaLzgJNpzR+bvj1NJdkNGz9pccv52Qf8BU=;
 fh=CiyTsJFJjqrmnqLbpCSxDWl1Z8F1u7jS3FKidpFuU0A=;
 b=QN/qlYNOP1ntzNM6McUdtu5NhE1W1Cc8HFLwWXmwgkLBrYQfs/8BSSnhEAaVfjL4mf
 FFjNxhmKJC+tUZwvb1v5+OrnxZwd5UUnq5mtoKjx6FTl72BVan3yNbmuPxEZPA0PqkHe
 mtUHpbe9eQnWIqGBjP2kiXnDdnt5XytFXCCeRXD+nhGWKqRy8INu/9gH09s8lypS2wnE
 dJ9uwyPB5RYdazDGKbeVDP3tK4BdzU7GQhbYsflvllgXVIJ6+KeG9dm8HqUMfDWMzbR3
 +/MWJRzXO53ujGm1At3qunQyP/NsqwkT2zoU+pPMiWpcPMwe2UT/sY41NlvxfuR+8Eg5
 0b9w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780981628; x=1781586428; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5jDlQRDHDaLzgJNpzR+bvj1NJdkNGz9pccv52Qf8BU=;
 b=USyxaloZ+S3yzH1ZD4m+Rr6hzJ3yl6kYFr2BsYqHEMsx3G8Coxxzw7MEQ4OPgAPX+r
 9SHHYl9xMb0R1UL/b5SyyzwqUUYyu/MPvCW/lkqct269p+AQppuQg2ZAEewyB5jwn0aG
 FD4psEDGZZKCWwsLi0/INWx9xlpAqJdOmbTCprXfJupgEm5Chr1gzNUtXM9AsCH7KRyz
 PMhypw9NOVrNOos1iMGeZNnSlMwjui9wuV4xk62GIeqLZEOtehRIVRXXbyLToSVpeP4p
 Ag40fqbZdWf2md9l9ZctarhozWgZbT1TWKcOkAX6umWadlN2yyZS3wCu2IA7k0Mj+RFq
 AvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780981628; x=1781586428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n5jDlQRDHDaLzgJNpzR+bvj1NJdkNGz9pccv52Qf8BU=;
 b=Pqc7cerd57JXpNouTkzw4otAyjHVXHF/CMDYKwHm7ANI7BfAcBll8OV9BHfHAaR0sz
 08DQUePFt28MMGkIaH2YC30H7DzaDJQbdNlJieAn/x0i7SUtt0wLfFyXs/tl91Wj4kJz
 i0HTcHjJS3PV6PZHqZtGqhjF/Ubtlp33QtK8PtnAlAUmTTM0joOM6pUX4kKX0/xxnPMM
 Gn+UeUocXKPUN1WgTQaos7CGZQKc0dbwfW6lFhVdbVa2wEhuUDJ9ANn6uz93dlM+ya1E
 2GMU45uQZvyij+cpIcXq4/OX49hhzhiI3jZHeNegvpV4891xFyBGGF76SOb4OP0Wisfd
 h4RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d66MO7cFd1elFxDCbvi6J8HpCgcsj7f1QonLZ2yubqDnkDQ7AIJOedDVssl48lpXOwT8=@dpdk.org
X-Gm-Message-State: AOJu0YwNcye+h98cJFDrjKJr/ngKZHoIx8pqxiopQqOBPylr6mWXA6gI
 y/B09ld5/nSt1UnjptZn/17t4+N35FOMW3c80PNf5qqjKs7uIkvn6F5OVHu2W3Ox7H4bZf3iP1y
 3QclLHZ0+IepB18SrWGhOf85c1WFF+dM=
X-Gm-Gg: Acq92OEWLjA3kgE7ynzYiPna3atAvXd3jiCzj5usbWMi7XVtKYbb42BKXfvcofASmuW
 W4X8mpdonYAfLTw8v91a/NcrKa+2nttaUI8sKnz2+Ll16xT0B44wolcY9Bg6zgR4hFcigztYgPz
 9MHvadGIHKUEuQwH8CFOMWb7WiNvP7dIzjTHil7UL57hNN9bU7NrXYAiPmDeQpnfQPPJYbrS4Kk
 drbiK9eDi2YMQbpSyhIv3hJrjJ7Ux0FW9LK+ODcHDpy0OB+DGALfRiwCF7C6kq4v/h+PlxeQlLE
 KrFqHhnPVCeBJQ==
X-Received: by 2002:ac8:7c48:0:b0:517:6d95:ef42 with SMTP id
 d75a77b69052e-51795b9f2c1mr256082721cf.55.1780981628598; Mon, 08 Jun 2026
 22:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260416120031.3553798-1-rkudurumalla@marvell.com>
 <20260416120031.3553798-2-rkudurumalla@marvell.com>
In-Reply-To: <20260416120031.3553798-2-rkudurumalla@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 9 Jun 2026 10:36:41 +0530
X-Gm-Features: AVVi8CcIqFlGmBSPbcwb81TQlHALnYV5twehwD-A81r_BRjt2ZfLZIYv6Vab5FM
Message-ID: <CALBAE1Po+E_ViXxz1jYFWZ39R6TJULFB-522+wBqCpG5UQWz8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/cnxk: add FEC get set and capability ops
To: rkudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
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

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM rkudurumalla <rkudurumalla@marvell.=
com> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Add ethdev FEC operations for cnxk NIX driver:
> - fec_get_capability: Report supported FEC modes per speed.
>   If firmware provides supported FEC info, return actual
>   capabilities for current link speed. Otherwise, fall back
>   to a default capability table for common speeds.
> - fec_get: Query current FEC mode from link info
> - fec_set: Configure FEC mode on the link. AUTO mode
>   defaults to Reed-Solomon FEC.
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Update doc/guides/nics/cnxk.rst and doc/guides/nics/features/cnxk* for
this new feature,.
