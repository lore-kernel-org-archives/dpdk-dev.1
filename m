Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA8CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 07:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB42C40653;
	Mon, 22 Sep 2025 09:56:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E8ADF4060A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 09:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758527800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lz93Aua4s7/nsjXeBd+kAhCX3QxL/zbecciB1/b1rhI=;
 b=Ba48jOmGWbUdqcyRPXQp+v6kbG/QgxzptQV2jNycoD2S5apQHvK5nTeQYIcqZVGduSxtG8
 6FgnHbmUR3w7aR+5hwYISW95YlWqFS+QQKeENUZ+WruzzzGZe/uK2qysdNZ+ENiLfwkSY1
 Z3R1gX8cJcziOBVW/M4ROcaHMYkFCGw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-6I9uIha4MeWcRGkhAllw-A-1; Mon, 22 Sep 2025 03:56:36 -0400
X-MC-Unique: 6I9uIha4MeWcRGkhAllw-A-1
X-Mimecast-MFC-AGG-ID: 6I9uIha4MeWcRGkhAllw-A_1758527795
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-333f903e1cfso15262161fa.2
 for <dev@dpdk.org>; Mon, 22 Sep 2025 00:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758527795; x=1759132595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lz93Aua4s7/nsjXeBd+kAhCX3QxL/zbecciB1/b1rhI=;
 b=ia4IGYPycMJMhaKDWPtXc6s+FJu4cjvCVddOH0ncYvQJYOsE9lT9F2SD2lDJMQDNep
 LVXOqVBWcYhvnx6tIiQRRnp9J0KSDc9yvRkxYFnamVwLD4c9Dnfv56HNi9aRolbxEVQl
 kMBrgyQ0vIVd5XM/2W0agNxJO++1byYqIp8iTTmau5bLnWdS1HFVPcecA7e2dK6Qq120
 ZOxYf1lxYyGytJtQENdUK9GGWNq834/3ndax2jC37oWkiJRpHK7VstIOet5mfHtqi7MU
 2+u32CSaFtoHa2X6STfxLRNOCQAiK9DUuU37sP/Dr2X3w5SzEO9Zk/Z0K464NKIATezs
 AJfg==
X-Gm-Message-State: AOJu0YypvGNTw6i1OqCv6fe6r2SkkzKMBO+SAUxPkOaol0yPwMyoYRVk
 TJQXTOVF+p8tBWsg+Df6KXe+X7+ttgqbiYmw4D+/3TkTedAUpyaatu699i70rUBmWYwQUITvE3f
 TBDmMdTh6T3HF27yp5kKZ+VSHYH+QfdTejBJ7ZmPKbhveIJSRG4XRU2jcLR7AQc9g6cPoMO0Lr4
 fTxK3JcohIL4qN4ORWsAo=
X-Gm-Gg: ASbGncsarQuWvul2H0mbSQA1lA0tpCE84/pNWm1q+Ae+6mzI28J/5TWu7WXeZtXHsnL
 q2wBDQtBErvuoiQTF3fs59Q+Anp4tygXA+gbdWHNaw6QKyvQgnMkmGp3mih1DqxUvGkh0UG6qn/
 DVt55GeV2/XWRPWMoo3Hzl7es=
X-Received: by 2002:a05:6512:3c93:b0:569:a257:acca with SMTP id
 2adb3069b0e04-579e1f412famr4374871e87.32.1758527794945; 
 Mon, 22 Sep 2025 00:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0JmcCr00QtHEF/fO3bG3NFyXl4Rxgs8lMa++/BAUzTJ6I3HzOQfBmpmO4hzjjRFEbL84kTZ+IMUKqZbt0c8I=
X-Received: by 2002:a05:6512:3c93:b0:569:a257:acca with SMTP id
 2adb3069b0e04-579e1f412famr4374868e87.32.1758527794495; Mon, 22 Sep 2025
 00:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250825092719.882769-1-david.marchand@redhat.com>
In-Reply-To: <20250825092719.882769-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Sep 2025 09:56:22 +0200
X-Gm-Features: AS18NWCkLV9rtUTWdTc1NelAIlNrbUneil7U_RagQe3CVEN6zTn6RxCsZ9DOEas
Message-ID: <CAJFAV8zEnFCawOgPPc6yhVNfBg5mQhDcM+9n=BJYfNGsMSN14w@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove dead code under DPDK version check
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: dev@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bZ8aHXWoCOd2dLrK2Rd55NH2TSW2FcNjLII1wlRnI3E_1758527795
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Ajit,

On Mon, 25 Aug 2025 at 11:28, David Marchand <david.marchand@redhat.com> wrote:
>
> There is no good reason to keep code for older versions of DPDK in the
> main branch.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Can you merge this cleanup?
I also see another patch waiting for review/merge:
https://patchwork.dpdk.org/project/dpdk/patch/20250521193727.382342-1-stephen@networkplumber.org/


Thanks.

-- 
David Marchand

