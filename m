Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9031C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 08:06:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1193400EF;
	Fri, 16 May 2025 10:06:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E59A340041
 for <dev@dpdk.org>; Fri, 16 May 2025 10:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747382785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQPu6fk1PfQpwZXbWJzK9kyuLmL6qlglY+BrFjE3UG0=;
 b=O/fd+p9yp/ZRJnHJYRwpuTJvyCU0SJfWl3NJeV+WAeR6B+FjlefQu35YyJMTEh/L9y2I4N
 h8hQAjWCT7zbcwOBkMihOJeT/LveV2/bhjD7QtBiFG3TG3etzM9IbhxZL98v5XmHCjCOoF
 C20gr7am/K7oiLGHkIIGTzf7DxXhJgU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-U9ADGkmbMD-KCCzQDNzY9A-1; Fri, 16 May 2025 04:06:23 -0400
X-MC-Unique: U9ADGkmbMD-KCCzQDNzY9A-1
X-Mimecast-MFC-AGG-ID: U9ADGkmbMD-KCCzQDNzY9A_1747382782
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54fbc42dfeaso928595e87.3
 for <dev@dpdk.org>; Fri, 16 May 2025 01:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747382782; x=1747987582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQPu6fk1PfQpwZXbWJzK9kyuLmL6qlglY+BrFjE3UG0=;
 b=vR+5d3CSglsIHCeI62dSE4mnVU/UNnGJ5hmPMRRAX5viekdb8r46fOsuLd3J+5Plyt
 cMHr9e8EVyLpNM0BwVe6GpV/rDiP0CLM4K6JOTmRUhpUita7mg0xA565aox7rBsY6O/6
 0iPf9HMIE72vq9yfMWlJP0ObYQ8J6USwaniqXxQV8xpECQnmDzPpM8raE3X99kkB6rzh
 d31U7efuJwju9JwB8TYRFCurapqTcXmDdK0fUvDU36bpEetYD3NkqUFtKhRo1tp3TSyK
 0arVeHU/eBWLzLlFuHDt5XTBy6FC7T3ieqEuSpV7BmBm6esxm59Tnem39VEe5ZBF0K7I
 dADw==
X-Gm-Message-State: AOJu0Yyph2+i1S6+duhwNMhrrahUNVKyflDSbyUQcANRL5pBAUgyndnb
 3guuuqPEk596mu5pTRiusCF3lAu78ceyy4a7B+VuHGAqH3T0hbh8ycd+C6XdXufFRjj3Ka9EjXv
 jap/ZCV8nY3u4aXBe7BH3li6w7rHv3ixNhvJdZF5fDYt4avUb3onD3dje9PjLgKh2oq89blLSqy
 uFZUwyZzbu7Kvkoq7B0x4=
X-Gm-Gg: ASbGncsKLA77eywAZvcosBAvnI1vRNuD5FFppE/t0eXrPHAKhe8NPtAIkCopVVtRXO4
 DQW6kL1xqwaYQXWt22S8gY+B6bJYTmmvIIMq6WVRG3RxYArW+oxmalamyfTQNe53AElF8uYM=
X-Received: by 2002:a05:6512:428b:b0:54e:953d:afcc with SMTP id
 2adb3069b0e04-550e71b6c1emr704820e87.17.1747382782285; 
 Fri, 16 May 2025 01:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5C4vCkO7tNxI33TLOfaCW92CZ5WkTjgAZDi6v2qRhfAhOvbgT/6Pgchr83NJzQpGJKcjGzaeFMpxNClI5xqI=
X-Received: by 2002:a05:6512:428b:b0:54e:953d:afcc with SMTP id
 2adb3069b0e04-550e71b6c1emr704815e87.17.1747382781892; Fri, 16 May 2025
 01:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8wyJLOCxKsZRNjVXvXwkOULz4TmLkwgWU=Sdar6iAfqzg@mail.gmail.com>
In-Reply-To: <CAJFAV8wyJLOCxKsZRNjVXvXwkOULz4TmLkwgWU=Sdar6iAfqzg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 10:06:10 +0200
X-Gm-Features: AX0GCFvfnwjp4PQ7mHdJlp1scQJJLbIcjed9W8lS9cY_FHypXfeC0nZE5VADt_g
Message-ID: <CAJFAV8yGcs6BTZbucSnM=ZkkPfOGWppp=YGrWr9XGZxtCnVW6Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove VLAs
To: Andre Muezerie <andremue@linux.microsoft.com>, 
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cUBDqtnIUyuD3zQgF2jKfZovWREFe77g8CIGHMgqtSM_1747382782
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

On Thu, Apr 10, 2025 at 1:39=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Fri, Mar 7, 2025 at 2:40=E2=80=AFAM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > There are two lines that were using VLAs, which are not supported by
> > MSVC.
> >
> > 1)
> > ../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used [=
-Wvla]
> >   326 |         char data[dq->esize];
> >       |                   ^~~~~~~~~
> > 2)
> > ../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used [=
-Wvla]
> >   389 |         char data[dq->esize];
> >       |                   ^~~~~~~~~
> >
> > The short-term fix is to use alloca, to allow progress with the msvc
> > compatibility work.
> > The long-term plan involves API changes and therefore can only be appli=
ed
> > with a new release. This long-term plan consists of introducing some
> > reasonable limitation on RCU DQ element size.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
>
> Honnappa, any objection?

I'll take silence as a no.

Andre, you mention long-term plan, if you plan to do this change in
25.11, now would be a good time to prepare a deprecation notice on
this topic.


--=20
David Marchand

