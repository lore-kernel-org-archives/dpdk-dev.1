Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE9C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 13:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBC7B40287;
	Mon,  5 May 2025 15:56:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 546A74025D
 for <dev@dpdk.org>; Mon,  5 May 2025 15:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746453409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fk67WwS7pOOmbE3rGz9BBbBVUgFc6ELiWnw1G9y8WSg=;
 b=FfUhsPS/4vE5nOsIPSDrgEBWE+TcjITh5GlDvjEQ0X2TwkoyoXsfkKIc8/52DToH0UszvG
 fQH4Q3+XRkjAmCTAGKlOgG+jjngAU+daStms3w+5iQyUY5maRhCv87QyM5i1h2hhTMbvZr
 6PFCSWEsc/pFUPF7K9X2HwKzW/j+GXs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-RdRMkvoPPGOq-9sJnFrnNg-1; Mon, 05 May 2025 09:56:47 -0400
X-MC-Unique: RdRMkvoPPGOq-9sJnFrnNg-1
X-Mimecast-MFC-AGG-ID: RdRMkvoPPGOq-9sJnFrnNg_1746453406
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bfc0f5599so17952811fa.2
 for <dev@dpdk.org>; Mon, 05 May 2025 06:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453406; x=1747058206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fk67WwS7pOOmbE3rGz9BBbBVUgFc6ELiWnw1G9y8WSg=;
 b=IrQeiLe+B4/qMyHJMKsbYJTJSLX3wLil93b/Bqkl6V5l4tzLCfrMhS6DrIGYAiCKoX
 Dz+hUTyrnV8hgoc9jGIlWyjXVZ3MlL88aE8rfh/dJHa1KSeLK3ZZSmfE7pfKehmgh5wh
 hMs0UWQOpXSndpiG5ovZsLHkFEw26ria0WwXBh3YFVPSQwWEi3MoBaMppZn2sQCEii+o
 g3Rt+kL82d9WHyNsZn6Z4p/sLxDpunhfgTC4y7vgAc1huQdo0KZm7WFY40O+YQhWLyfh
 /aZqRWjCYBIYzqh/513Tf6vfV//pXQt5lBPuX/YuGXoUqwmIxsWTctCPnCARO3Ugy9It
 9Xng==
X-Gm-Message-State: AOJu0Yyy7VAg8PH9K3voAFYIlW2UawUqFokcGa+vh95WKAeCK15QB8Bb
 p1gYSrfbMWO4kog8L6L5Ag8gSeUCLaAymkIIfWYN6sFYGDBXjyOEMb6rScQwkyYHkeF8SwgSsH/
 mOnBTC7bMARcjzBhfmVBp6jZiPzDNLVLLG8VJNcmXOtmINiSqejaRUSiOEvgo+ivQ6q1COL2ss+
 fJM/OE10l35VccVxo=
X-Gm-Gg: ASbGnct0HBbaIZoi2OG5JLalNTZQenLEMpyqMyDdHRHxcvUAgF0Q1whPGROJsbWdRBl
 SC9np2Nur6htZBSTl0rikWlvQtJeeDVKWDLa2NrzrY5Yz0+fiPqdH8Uxar9Vk0lzBZUpKk5U=
X-Received: by 2002:a05:651c:1445:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-32351f25893mr25482461fa.25.1746453405672; 
 Mon, 05 May 2025 06:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFNvaYSspuVuLW3b8oT+M+MughPbzcY9ubCpPZEjJym4q+u4zCAcmoydZRXa4mn1eSgMqx8uVOwmjdIgnF7k=
X-Received: by 2002:a05:651c:1445:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-32351f25893mr25482331fa.25.1746453405155; Mon, 05 May 2025
 06:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250430013431.2056969-1-changqing.li@windriver.com>
 <20250430024403.2690306-1-robot@bytheb.org>
 <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
In-Reply-To: <d498a836-e6eb-43b8-9ea3-bdb98ae4aaf8@windriver.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 5 May 2025 15:56:33 +0200
X-Gm-Features: ATxdqUHmJ5LoQO4okXB0r0bkgtiO8a_8ybnRAPf_Svy5ZSEbkcHtu67mU0vV_Q4
Message-ID: <CAJFAV8zk=gzCagoU7c4=dsXcEFnLjiqrWxwTWANa-U77Uj=Taw@mail.gmail.com>
Subject: Re: |FAILURE| pw153190 [PATCH V3] Add new tracepoint function for
 type time_t
To: Changqing Li <changqing.li@windriver.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 thomas@monjalon.net, Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IYHdOoR9it9lbNroAZybdIJvn4ziOPRjr3tHNuiDVK4_1746453406
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

Hello,

On Wed, Apr 30, 2025 at 7:21=E2=80=AFAM Changqing Li <changqing.li@windrive=
r.com> wrote:
> I'm new to this project, and have no clue about the failure,  could exper=
ts at this project provide
>
> some help about the following failure?
>
> + sudo babeltrace /home/runner/work/dpdk/dpdk/build/app/test/suites/rte-2=
025-04-30-AM-02-25-21
>
> Error: at line 2819: token "time_t": syntax error, unexpected IDENTIFIER
> Error: Error creating AST

I think this time_t type you added is not described in CTF.
Have a look at 2114521cff91 ("trace: fix size_t field emitter").

Copying the trace framework maintainers who will have a better idea.


--=20
David Marchand

