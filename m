Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A99CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 05:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53A1C4066C;
	Tue,  9 Jun 2026 07:03:22 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 73AA9400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 07:03:21 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-5176fc0cc72so52788681cf.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 22:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780981401; cv=none;
 d=google.com; s=arc-20240605;
 b=deDonmShkUe62GlwYCYaFo4tKPYGG76TvE+rX/O8FF2oLIwtUzZqN4TA+jq7y4w7ZV
 aO1274ClQb4FtqzC0aVeWplukQLDccbyz6C+SbFX8gzHLu+PwQ2abGf3egzHO+SKs/aT
 db59/13n1Xm7g5QEzI5jD5cAbAEdFhY7rFlmr+FfSmbDc5tDUijHbow2I6xsi0LrFf7X
 6NgT457NGRKYK1O/l3b6eLV7qKNILQXLObKx59h04Jir5e2xSkAk+f/3mLjwKFeq+NRg
 pLZW+jQvBWglIYzLwaya26MeW8smgZr5fACMR53VbMLGpvO2U5rwewU9iXTf8MpVwPIO
 Xe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7KadGP1NEF5T/IWSRrzsHpBiGD4F8COGI9Q2KM6tWmo=;
 fh=H+AIAtj7CqmGfkJ7LUylfJHECI+djGy0sfwAA0JWTJ8=;
 b=cznmKxoihI35KegclNeNBc5bsbP/jjA7EB8zZZC+QiOW+I/fRIW3JH955DlNPMIA4h
 0D3Mupi7q9oUV6Yfh4HWjbkctjFyqq4HFEc2gJbzQPMAhv7lIJAA3kgjqtC3GX/cEayB
 2mmqkLunu4VpjqVO1tAO6I8eq1dL7f8R8HNHr99tqkE17s0/AnsC2WtJ3Z7ZDp0NjPpJ
 4FYPRsuFVFPXQEFgStjXM3jH5CN4mNX2maKPVkLRa/Bf4FRbBB06ySL7juDbQEID/pEj
 ZLIjcYwODtQhg2xHiSx9VXL8ZQhaFB7qAMphB2tJiWFX0KL2tBfOyoPhuTKolIYR2UjQ
 W6Fg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780981401; x=1781586201; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KadGP1NEF5T/IWSRrzsHpBiGD4F8COGI9Q2KM6tWmo=;
 b=ZHVy2SxG+8+EK942GmdGRSyipVjRwX7ad+tZuWRHQ5fLCZ3UszHZu6YNGo8Gx3QKto
 V/DnSreffnF68JXqI0YzAVJpuMeZjM6Tm7fnn9ZjVDKdmqa1fSu73pdw4rXwSH8Dlcy8
 zZd+t7gXNdkqq/oA3Vo/WDB6gR9ypOfNT2R2h8DFdef00EiS+KCNwulNknZbgm9nwEbG
 BTXpjA54eujLkoBbxc3jD+btpjsvteAOwr+NkzeYwvmrPByZOFMpcBdj3cDfhXv73E7S
 LDV1wNUfK/npmSXcQbswn+jBOGUTGFmfrcHhTaH8Cm8+FWWdflP6nJ4PHBOJswBoyZQY
 3YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780981401; x=1781586201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KadGP1NEF5T/IWSRrzsHpBiGD4F8COGI9Q2KM6tWmo=;
 b=ppwv2Umpb3O+e2pXsgsJ8w5kS7/gw0dpLylpr5TZBQuv829T2yiY4y8fH69/SVMTFf
 c+CsUMKIROfLnE4Wzu47Ok31T15LcFo15GL/XmZx3zEmtL1Ubr6KtJEmtii28eVp2FWw
 HCwhIcvuBYRwdE3/WeBULW/YRih6irOb6ZYh8xVj7ek078AY7hFjNfaURzFu71JUZByN
 B3GECvfeM7W2Isfld85yBkcXSvu2cfVaaqWRWUBPSdixFCzAkMWZZmAZUvCmhQS3cw4Q
 m4tMzCWA9tUlkXsToiwqgRPQ2zBMzqk9/+1ZYRJZigFB14lHr/3Xvkg8TQHdmAG7e5EF
 7LWg==
X-Gm-Message-State: AOJu0YwjiRzCQmmEgIGoBZzKv+1YtKEJF3Er2lV8KuLqdzCpymqpQAP3
 yvTj0lb0PHxGvzHyjHmKrOTziYRCtC3s6lDNz0tELWhS8S/QCIK6yvg3oS6zDhZK31m3YEEnq2m
 2y1Qrek57EuQm2KO7PJRBsFtfjxPCXEc=
X-Gm-Gg: Acq92OHlRC3ek9MsekMfBcqWd5CKEd7802q9RM887Np+3G7I4PDCUUG16MqMRhhi1H/
 pTVN/mpL0j3Tdohmb2SiLQaILune3mTnee90QkzKkR5jsxYST6rAx3m83BuWI36pPXXyHk3+Srj
 qzpx1EvpkyngB+cW1GI3XJqmgGNPIfGHILQhok9I3163uhy7FsTaVChgT/o3Sxj9+mih7k5BMiN
 7F+ijDN5tkI96NYXUJ4wd1CQANfEjxDuqOpJ8HvriZFuOKlJJMOvWa04cktqQ/ZaxPD1es5v5X8
 aBkIp9per7Bcyw==
X-Received: by 2002:a05:622a:4c07:b0:50d:6b06:a453 with SMTP id
 d75a77b69052e-517a12d2d82mr210644771cf.18.1780981400794; Mon, 08 Jun 2026
 22:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260605224514.651081-1-stephen@networkplumber.org>
 <20260605224514.651081-3-stephen@networkplumber.org>
In-Reply-To: <20260605224514.651081-3-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 9 Jun 2026 10:32:54 +0530
X-Gm-Features: AVVi8CezPS0g__ZD-aLNFoppYjwz8wX_Nz7fgKk91g0Vh62DKfSIR5sLDjzMKA8
Message-ID: <CALBAE1M9nSJUUUWbNiECpk=1HLpkGg5QiFxDiscdEDcg7npwog@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/cnxk: fix thread-unsafe NIX telemetry parsing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
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

On Sat, Jun 6, 2026 at 4:15=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> cnxk_nix_tel_handle_info_x() backs the /cnxk/nix/{rq,cq,sq}/{info,ctx}
> telemetry commands and parsed its "<pcidev>,<queue_id>" parameter with
> strtok(), which keeps non-reentrant state and races when telemetry
> callbacks run on per-connection threads.
>
> Split the parameter with strchr() and parse the queue id with strtoul().
> While here, copy the full parameter (the length was capped at
> PCI_PRI_STR_SIZE + 1, truncating the id for longer device addresses) and
> reject non-numeric or out-of-range ids instead of letting strtol() alias
> them to queue 0.
>
> Fixes: af75aac78978 ("common/cnxk: support telemetry for NIX")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

@Nithin Dabilpuram  Please review and Ack the series.
