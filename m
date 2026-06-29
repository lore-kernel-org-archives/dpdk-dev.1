Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0EC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81DBB40299;
	Mon, 29 Jun 2026 15:14:05 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7E7914021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 15:14:04 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-92b21f65b60so245346085a.1
 for <dev@dpdk.org>; Mon, 29 Jun 2026 06:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782738844; cv=none;
 d=google.com; s=arc-20260327;
 b=OrfnXaZj4/8TKae8rvq/WSFziOK7HgHwXeV8vM4ESqLtCyUgGAhmL5pQw78viK789h
 xNm3ncrG4e5BUFA/h3LKgEa2U7X4/bJLnPhxrKWSQBW24ctmC3Pf1c+4J6GAoliPZmmi
 +dKq+puBzxZCiW0DLFO09a7BzMSvCZC61xnCi4f+l1nf832y5clTA96OQozZ2+riq0Bu
 Rs3DHntUWKVOGvOSS1PynCHbJSvITBMoor1GW+Z1dVDfJxh3icYvIYB6huEB6MiDh1/7
 UNbjyccn6dWOGPanfb5LkP7Qpw7a6r6DMRnxTI+t1DJV+oSR7fDyqIwasZ8kIWYVUNd4
 rQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=1gAgKEC6liUNQLsC4MCCCHFh/q3QJzNjROeGMyJVy8k=;
 fh=1Ch84GFsqXzO33bpEfGzd/QVKcMeinkIxEfgEIpJnnU=;
 b=CppJAO80FYJ2rTG++1dmWUqZvu1lChNNBjPRbLyZ9bQ/iW0OZHiBLfVGhbxS1iPjRl
 mPD2Wp3+EljFyy2V2uzqBNJ/DKpL5uTgeH6sQl6KfPLkmJ/pTCzCYVOVaObZBELI9jb/
 cO7lZR2P543EkRkq37zwTqQk9HcLtd97kk3P5IEsXu8Y8TK7ZqY7YY0O2UbTd1O8UbIE
 YLCFadpMV2TF/5jD9D+Ih0HlHQV610HHe552EZTv5uPu5jKto0wouoalRaPwg60sjQLO
 XjM+6VF4fXmhWz4xBlAqA395B3jGwSbDf90B6dang20zxia9WhW+TggKzOPHNKKFa3ic
 IZLQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738844; x=1783343644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gAgKEC6liUNQLsC4MCCCHFh/q3QJzNjROeGMyJVy8k=;
 b=pRG9SSHn9G0+UqhGlfsE1dn6+kqgTvtL/Pq/6h8lgGb26UAC97lV00y0PY60gci0b/
 8W+GRBvYlRaF2EBas0pqG32k4r+ZPKPyUk+AsnwYqc9Rf95EuvTxrMr1xYV+o0E9xSxI
 KhY+vxVE0taA2mXZ6gDbdas+W7FCA0rWDYhrZKmQ3OvfNHHm+e4/02tHBwuOJGSqn9CI
 w4r5ajtVC+TJ9HmFFCbPLr4rXbjNWFrptB9/8URJSxuO4RwGLpy/OqT4NqOT8b3TDx+h
 z5yLa4Z1bGbuCSLBkH7eQVQxtaDgVaTIPL2ZNw0PQLDconugthAJXw8o3NTerhqqVe90
 L+Pw==
X-Gm-Message-State: AOJu0YwqgFv8GFZZwG7fuk94v9fWLUwga62lniJYjcB6hRzt96G4Zd3D
 tv+GeV1WxZMOsaYDv+cg1FoykgAr0J5mfiVjEAXL+faUNcxd/ZQwzz+SEp9V3C3+D2A/lc1ta7i
 V1aFzH/mhn31f0iY+FN0ABJmbTiaBVoU=
X-Gm-Gg: AfdE7cnNtjovLGCKLCC72JAVGHjT5uMWAtZ8OT4yLnjoo9su5yTbYXjLjof3NF6CkBY
 fT/WZ17qgXJvyVgcCPFyZZ2DUy/MRlZ+3KbIPWc7525z7tNjlzfSU8HCRjlKkpvcHf2MO92UOXe
 rKyfrc0PiDwHh2Lmf/dYjHrNGcav5OLzSq80cB9cq1CWWxPZCIOaExjkaJHNJ44IMC6naDObUGq
 o7Svc1KHv+1sXMiF5EN9S/2iQ+AiI54ryhgGJ29XFZ7cjYR2YJN6axbHwP5NUq1N2K5Lc1enTik
 bjOwikY0148cErizdK2HZ0kCF+E=
X-Received: by 2002:a05:620a:1a03:b0:918:4374:bbb with SMTP id
 af79cd13be357-92601f1b214mr3794289085a.23.1782738843629; Mon, 29 Jun 2026
 06:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
 <c1b545ca-6761-412e-b3a6-44389778edc2@oss.nxp.com>
In-Reply-To: <c1b545ca-6761-412e-b3a6-44389778edc2@oss.nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 29 Jun 2026 15:13:52 +0200
X-Gm-Features: AVVi8Cd1Vh7RwJKRfv0x6b2tFIvQ3RLPJyi-_bd5x1eRKgyV5YW8qFKXKX4no3A
Message-ID: <CAHHRULWQThznjaakd3N_F72B0rWAmFYsAXdkmnBXjQcBofRUog@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] net/dpaa2: NAPI-style Rx queue interrupts
To: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Cc: dev@dpdk.org
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

Hi Hemant,

On Sun, Jun 21, 2026 at 6:33=E2=80=AFAM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
> Hi Maxime,
>
> On 16-06-2026 15:57, Maxime Leroy wrote:
> > This series lets a dpaa2 worker sleep on a queue's data-availability
> > notification instead of busy-polling, exposed through the generic
> > rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
> > arm the interrupt and sleep when the queue runs dry).
> >
>      We need to try out few things on it.  I am afraid that it will take
> some time and our review for this patch will be late.
>

Thanks for the update. No problem, please take the time you need.

I am also preparing a v2 using CDAN only for notifications, while
keeping packets on the regular volatile-dequeue path.
This should improve PPS compared to v1, but I still need more time for
validation and performance testing before sending it.

I will also send the VLAN strip cleanup separately soon.

Regards,
Maxime
