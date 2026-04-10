Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D80DF44872
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFF5D402DB;
	Fri, 10 Apr 2026 16:35:33 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 61F694026C
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:35:32 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-66bd4e0560fso2839781a12.0
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831732; cv=none;
 d=google.com; s=arc-20240605;
 b=jZ9DQOCER688cLpH6NLySeGwJ9cyxWs88w4jR/uGjiLL7eh/hVYm9mocoZFoVjmPzM
 SSDIXMvX8D3e9X8R8IJLockze5zQLPTNwLAO2m4iezYZQHd3/bGn6gFsb+Yfacd46EHC
 09YNoXKdurAqungsvjHks+FrEehgy5cwnPZMtsgaDhYHldcr6jbO0wQ7iFvuk9CAnKOV
 wNdU8VC/EhYfMKyaLZvWHpOGbEIJyNLO7TkjUWwYUWy2X6IByipTEPqasjygGlVF8jLN
 Th9jU5OvyFu5GVIIwIjidd0fucBkH/01rqBndoFN8wgrElLcVcxryOsZxdLqxQnZG9Py
 WhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=env4KJdhNCrpG/5JVksrT75+63jpJ+od42MHgLNAIE4=;
 fh=2Qy/+U4g7s0B88ehOx4du93qoBLPJ6/bjmVRBKE/Nhs=;
 b=UMNJG1c80jWFElqTBGGVZEzETTRsEvOxgGMlXXoOVyX7p86g0VlmsPgp39j4lw31OH
 fvVeYxbv8yYdaZuV9wt1Ikh20vJ6nHEYt/DOb9/WtWXb0XSS0qjRoVdwlgCYda+LHNyc
 m42cMAomqCFeB4+KX2ayE4ifUv+X/snXfmPfNBuSoUsHXOFqOsQJy6JmXaWK9NvJfNRP
 rH0R8kFeW+00gBurGswNWYKH2oWkQZz4U3VnYlpxkZyPxXQu3aYLEmQtl4Rn7/oTOVJt
 p/IsGEqbCHIq6MLLSAmOXQrm6ra/XSVBKJKmP2xSPgcZqmro5J4dUqhawRXTGO7CHaFL
 Jwqw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775831732; x=1776436532; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=env4KJdhNCrpG/5JVksrT75+63jpJ+od42MHgLNAIE4=;
 b=O3JKd5EF1tZxhddArScoWkxs8tbBMFVQq0O5jdl3BFfOXmXDoF+m7519RplpC0/l1Q
 qjDas6GBu/0j987Tz9SRSRaJgEyQip3P8BRsZarhRx7VizIEf/tXn5J1zuWD5Ay4lmyS
 m1Rvv2r4myQPYgd3RR3h887M8c0qRfahgbguA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831732; x=1776436532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=env4KJdhNCrpG/5JVksrT75+63jpJ+od42MHgLNAIE4=;
 b=gpAJCDM/s5HyBz6Yh/cf6S9lu+fLnmSUb3H4APUDGABIajrLZto8xJcUE3/P3wEg18
 UH4AGnFNgbJ6BFO6AQp5uVqb2/ob5CY9n7VkoeBp8ndPhjVr8e1D6nnRxJ4+NnEhVNi/
 q1434XBoNom5PfR6j7/TOWRXgUfmXjhEVlikZLot8Tm/v79INmnmGDXmT9duKfzHNubB
 KwHnokvdl+ErQmbovlYtNSDd5YXjMuXrHS3yGatfrSq/X4Wj0pwrmKSrVmMa9yjbrFYO
 b4M+iun6/UpO+NzM4BhTAnRECZsRd9TawcckZFng1v1iBYpDSxl3FxdQqSp0M0NjcPZc
 1xew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW90LixTttYJRk+T8/+mYv2n8efnDhecQd0B/XOKbiTxo5U/gEU3Yy1XhyHoAZezXdTQyQ=@dpdk.org
X-Gm-Message-State: AOJu0Yz+S8vbjwT7AoUDKvPxdXaeYgB69zB0bUoiVx8LyUFW65lN7LQU
 vwYFw7v9Q75EQ6TPyx8Ektf1OJfq7J7a1ON2JRl30jjUUxieedfCprkSQnhc7TuZ8cjQBtNX/v8
 3meonwNMECRR/CsLg4glfbAC5qPpkHmCJHNOkSNwsIlx2Z+yBkv5I
X-Gm-Gg: AeBDieuCgjqYjSgRZubdDfnXINm+Wj/lLoDJkCNVjqex/lq5wA2DzZiUa1oCH8i+rZF
 W/ABjrWse94Wkq44oDuqyVT5bs6jH4Y71Hh8ZrHyHcKgs5uwZZAUi9NfyGQmLctxWsfYrKP5gip
 q3AssISL0A4/A9fwT/OruAUST/purb6X0Ut4mH8OEUcYVuKjidlDGHOMH7hOITA0ZcWYFAs9giF
 OLX37xnGTnzg4sFq+DpKVuZepU+9XvI4eoMIOJj5eCmY4Pq+ZKbLMg5bQJaPeLerhBHuj4Y5dpR
 EyT6rqi5Z2VUrCokfJs5rFvgGkWACo+a47HI/P2S
X-Received: by 2002:a17:907:3da2:b0:b9b:faa4:8ae0 with SMTP id
 a640c23a62f3a-b9d76867af6mr167254166b.7.1775831731868; Fri, 10 Apr 2026
 07:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260327180232.443820-1-abailey@iol.unh.edu>
In-Reply-To: <20260327180232.443820-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:35:20 -0400
X-Gm-Features: AQROBzAA6hQOlXA8jQu_0pqdK0cVzz6FWhA1-SSIoIlBViTLSnBRVmGWRTN0mk0
Message-ID: <CABJ3N2VwFm307fhAOY-n5Y-MCnvjh0rAee24vUJrmqcdtja0dQ@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add ipgre test suite
To: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org
Cc: dmarx@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000008f2a74064f1c0b8e"
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

--0000000000008f2a74064f1c0b8e
Content-Type: text/plain; charset="UTF-8"

This is an update indicating the status of this patch.

This patch is going to have another version sent to resolve a doc build
failure.
Besides that, the content of this suite is complete and pending review.

--0000000000008f2a74064f1c0b8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">This is an update=C2=A0indicating the sta=
tus of this patch.<br><br>This patch is going to have another version sent =
to resolve a doc build failure.=C2=A0<br>Besides that, the content of this =
suite is complete and pending review.</div>
</div>

--0000000000008f2a74064f1c0b8e--
