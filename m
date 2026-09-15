Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A2C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B415D40DDC;
	Tue, 15 Sep 2026 14:51:28 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id EDA93406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:51:26 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85e68bdbcc1so21436397b3.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 05:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476686; cv=none;
 d=google.com; s=arc-20260327;
 b=KBKGiU0AxKZoTBT9IE3MD3zqF1TpYZ4/TWZ5KrBEn59sRWbnuTZR38KEM1kHeqrco1
 0JXoHASPomiBOchfzesSwP+vper8ntqXLyiG7sx3JAenXCbg4ELLNdjhROD0CGamBpyw
 V1hyFpqsb7DkY4IejNGnyi9p+gohN3JI0NPTePFvLSzmG8HSG+TFy/hfTbxCX3ruku5+
 S43XZJa2eoG803B3GLfUBI0PHrfmyOjEScpkulRN1r03OoX9p+YvAgJgFNCq7Mir5pag
 m3HPd+kgM8xQ/0INKlcvh9MO0qkiSclfr6U9h5UG8WQU2BAML1HXbuAHBxBh24nSfDIT
 3OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Iq95bwB3lgrXUwTM5n8OJkkafkrX9jFDYP76+Fry6I=;
 fh=OrrdYICN23pis4fCH0gTnaAbuEU7O4MH923WPEqF1ZI=;
 b=AG5IfA/lIa7kjAKXdYsd5zgfDWHounZ2kRAk2OpLBfsA+38c9a9fRz9p3+gsFePdjX
 l+IMzrxk3hNT/h8mtUWHLHdX54SvgvXVoudaNoXtbJnDugLr8HIgyHb6fgzuWaN690qh
 RQSJRPqxRNtvWHYK9H9DmlOcRWJbB+PPeo1hEesazD9xuDXiECSG9mkj3/4NBe5p4cjY
 8L+27j1ZQht1e+Jw/3YipAeDsCKXBOjoJt76QHjlS8o95vAKa1/pkRjOmDeTdLCrUaU9
 68dkg0nSSz0xL1EmFMNu4trylfCb13fzlNSLEnEpfAAUcRuYGHzX4KKp47/qhq5jANvA
 PZtw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789476686; x=1790081486; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Iq95bwB3lgrXUwTM5n8OJkkafkrX9jFDYP76+Fry6I=;
 b=fAQ152CTVacis0YiaivMPGNhOs19KJ1fGsKKi7Vjm42PX3Fhtg1+99W1yGloYNfSz7
 85CD4tXy5QsV01S14gu+PsgMT8sC1T42bluVf4hTPFBvlRO/+JJF1J6H3umloyh8tzN4
 r32nnUUj0wV3P9EZAPeuOw74RMICBJCOUEZkU2MA+SkA063syt5nUT+eN5Dx5Elz6S3F
 c5NkUjedXyMMHNB6celwEkpInmUbv5xAfSZh/cWj6rXYO1luRpR+xespBD4Um7+G83gM
 EdoQoDcRKpIoEErke42T486j/725aYhpX84pPzDyAyMeaCrNbuKa2fBHExp3oHcezN8w
 hjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789476686; x=1790081486;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Iq95bwB3lgrXUwTM5n8OJkkafkrX9jFDYP76+Fry6I=;
 b=og4MK5wZDN2H3E/WAE8DoKlQLX8HSVJRuzhYdnHnEkRgRMce5IYpDygs7zXUFfkHe+
 Jc39uvy95xdml3SL9F8a0VyWZCBFy+kQpLK32A69I42r26tzLoal61DHDKaMLCMcn3LV
 FYzSQJzRKRllo/Gw8B80VPguz00nD1SqGSk1l1e6PutevKurzIB9SyTwceSwF/SYv50x
 nZXXqNFJ1rkc7stn60+Qe43pDiostnOyD9FjY4KPXcFIVdRp22FihpqR888pTpRzV+si
 RJDran4Q+4TdNeMBwodZvuiMIspNe9XkMzDHSM8HSXcbFr3Y2mtcMvTXL0bKltJ2K9n9
 HGZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBziAjjp9iEt0WWqbiiA8atcndE+JNh/8lNVFsA1j33PnfzMEDBsQrUfp+8YqUDmLbWl8XE=@dpdk.org
X-Gm-Message-State: AFuF++koTbbvk3Pq74S/x1ukicGd6EiDXDSShwmEr8TDQaVxNM6E0YiG
 +xeaisxWxnHZ3Rt4ianHijFjzoiVnGJOqK/d04My1pv0c6QPSdPQs6PupXZZJpcS+Bk8RsCenCr
 tSwEKsYeLuKP29xBxou0vyvZH7MT0cy4=
X-Gm-Gg: AYBFou2hsiRdKcSjXYss7ZBfq0i0oWGT6FzslNILu/L6bE8EX0r3NV0Y4U7PAwtxRUu
 7/3B8TSsPODCRbGRe4rYNhDgt1j9gf/XwpPqSjCvj9wmj+zMCHMBWK8xYIKPs6HO9XM4Nzjibr0
 1lodqnFlwBn7Y+z10U5+3HIbgPD2KPqe/MZ4RFzf4+2WPrKgN2j3CN1ULJy94ZwoMyEJ6Wj52+u
 HHK2NiRfUQR1+y6bCC4nNjNAbSPh63gXFFPuLG1eU2ly0c80ctSqHXNMeQQjHLTtVJfcb9IhIiX
 w1cQJ8j/w9g5npyxhkVpaSwb+v/8NEsJlskiIS++O+n/vdaB+R7WQrHlzP9oAhqp7mi58JTgvU7
 aCowqiYMo/a6AQlek2EAdXypcngTP4DJiplVDsl05wJ9AG8GJ/zRbH1Yw2kNgM2FKhixqxZs9Yv
 9efzr8Qtn+PSFvfQnm
X-Received: by 2002:a05:690c:60c4:b0:882:1d1f:ccb with SMTP id
 00721157ae682-88d1f9e215fmr29256727b3.8.1789476686290; Tue, 15 Sep 2026
 05:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260903123817.1677020-1-thomas@monjalon.net>
 <20260903135521.637818de@phoenix.local>
In-Reply-To: <20260903135521.637818de@phoenix.local>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 18:20:59 +0530
X-Gm-Features: AcwNN1UQdmqQXP7gj0LDttuDFzTr2YNDv5zrZ86IqXo5MdK_Wq8rhwkzn3-CJto
Message-ID: <CALBAE1NyD0g-RVjoF+FDSjTkY1hbvhj4XxAyXBhdMPfYyb1SsQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix API comments for Doxygen 1.18.0
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, stable@dpdk.org, 
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
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

On Fri, Sep 4, 2026 at 2:25=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu,  3 Sep 2026 14:38:17 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
>
> > After upgrading to Doxygen 1.18.0, there are 2 kinds of errors:
> >
> > - @ref func() for static function is broken because of parens
> > - @ref struct.member with anonymous struct/union is broken
> >
> > Parentheses are removed from inline function references.
> > The second issue is more difficult and requires to degrade the doc
> > by providing a global link to the struct page for the fields.
> >
> > The root causes of these issues can be found in these links:
> >       https://github.com/doxygen/doxygen/commit/e1bff01
> >       https://github.com/doxygen/doxygen/issues/12226
> >
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>


=CA=BCApplied to dpdk-next-eventdev/for-main. Thanks
