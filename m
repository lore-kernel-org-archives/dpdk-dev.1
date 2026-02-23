Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C07EFB811
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 175E04027F;
	Tue, 24 Feb 2026 08:38:54 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 01E51400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 10:44:41 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43638a33157so3831097f8f.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 01:44:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839881; cv=none;
 d=google.com; s=arc-20240605;
 b=inLCqfUqkxoEWV43fc7eknHpjCPLgYEQ5UkOshXMFr+Ue7N+iuo9tEmI7+fsGzRzHz
 uiSlPHGRjjRnFejyNuQgAjOqKC1jeXzbeGJoOYQWZ7xJ5FfjBy+f9FPdhsupvgC9l4Fd
 LU7uc5HDdr/VtZ4YULzsojkrxbmA3+WLyHmEHOqyP4wosGLoAzc+j3eeSJsj6d39k9SB
 +IpSzI/px+qZQGat7gMeXkysKGX+2qHo/bTPJwA1aRQzOP+njDNh6tEd93OBo2SyO9nA
 2/7hw3WzQuPxdi2bcsKYp2Bnu9ZejFkdLQNJ1ArfBlY0F++dJ1yFBFxY7v9KHCMAYsva
 4CVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pqawe4x0nX0vD9Fqa80zdQ5AHG0uaetohdQ20hMnnto=;
 fh=ESx1m6F76NrVWFwlTrMNCB+NaSkA0Lkz0SZylAeRVYI=;
 b=HW8HW+UEkqKq/d19MMQfGX+DL/yZw8Eo2IhBBOIiT/Qoc0bd7CjW2LouGMrx5KeFUb
 98+igQSFaeOXzSEKBLgPMAbAI3Z1eh2Vbq7DGBe2nVIMrJwkfn0PX5zyK1amCnQpqkqC
 9hDfI6OXP4AwU9X2ROUIOy7tTZE8MUSQPpZYxru3ljR3Q3qNr0oGhWIc4th/6HjmczAu
 YCNKqJXCuu0CfFoZKWwV2zOL4a4O/xrBe1nBdtjZTxRTMhkb7/CjAV1y5hnsNm194lCT
 13KrZ7lxdxVedWJsdudypj9chYOWdqxtjyWoCHVSZ7IRLZJy95pQiKpINLoaWKG/ndGx
 YfVQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771839881; x=1772444681; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pqawe4x0nX0vD9Fqa80zdQ5AHG0uaetohdQ20hMnnto=;
 b=S0ffOExOx1xpSkp1oubRlR9xQRGX7Ck9hGdozhQU/yhFNvK2V7eJWVDIdm4YiPtPEs
 dmSG90KcJEk4zK9h8J9KMInv0yaB2LyK7eo264ZmmwfpCjHYEwRW9cJffBC7wwSVSUvi
 G+B27pCC6zPzeB5AqwfGVkC7c3J5ZX280bjPnx1tH10HmAFNq8pf75WYr5KTrbizJfNM
 Xv0T8uBrR1uuIhTENBOgXgNWnjOFng+KSXNxcX84d35oFfNC6Ys/eng9P1Gk5yfZXxwG
 vGCkoQPiRKtlGmvQrgigmkKPG2U3Tjig1FEx4Uk4j15Npv4naJR3uIuUzYI2UVa7EgD4
 Kyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771839881; x=1772444681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pqawe4x0nX0vD9Fqa80zdQ5AHG0uaetohdQ20hMnnto=;
 b=MIaOpFefbH28AdrVLy3KcuLZTLTa58PFZy2TVzuLQmwq8bdnPca6n+JZfSQl2SNj4q
 CEiJ5iWUPC5M6u0HP5IJTXBi66zbI6AVpU8WIiNjIlazNeTjTHE0Y8vGb4/0BHnbp9b1
 sgJ7D7xVci1SNcus7c6vCc44SxLH9jIwerfB2J77EtnrG758+ocZ+lDxXS8Gqi0PXfwZ
 hk0WdL11YKb11Ra7oTL8nIT6epiCNn6XRAFt3iDnlcnZaiftdVtI0XqdrQut0X8he+j7
 zsxHm/sY8DYlJ882dkp2glXzzgm628R62bTChWQBvpx6qC6NifdSQIpJGvde2cbwCGAn
 /yzg==
X-Gm-Message-State: AOJu0Yyl2w1qSB23HkHkZZFCw/R+ilV2AH9ZwWrzdxmpv/pQDw8BfsNo
 bI/PZOcZtgbP3pG7cG/DZs9l+kNTI3MKlJaGD79BkVZK6Sbe6117mzJR35jpII43hksvw+bZ4hG
 vNa8A0vqG9pBakOqva6wEXSGnjHayaeo=
X-Gm-Gg: ATEYQzxZRhWjwXAYk3MRD582jEu/x/DweQ/yVNs66Shhci9/2xcYtcxdJ3uUGG5VlBY
 IVknhm4vj7+iRpBmdeFTVpMgyGaCETK5QoAXj6UxqcWma1qBQS8/s/Jp/Z+KMN8ugekFEv8A+Ey
 hxbW6E51msIUz/8vzYcJC7iZIiHbDB9jA6OTZ6OOwWxSDtg4O49AZdGnqm216zRD1e3cGAC0H/x
 EVc+/LaAZuouesOCJmAdzqOvbgd2j8RrpFQKqvOrigiH7di2zdSyF8p46JfaR7w3B9piknoEgWH
 wTeSf+A=
X-Received: by 2002:a05:6000:402b:b0:433:2f55:7cab with SMTP id
 ffacd0b85a97d-4396f174f18mr14597676f8f.37.1771839881318; Mon, 23 Feb 2026
 01:44:41 -0800 (PST)
MIME-Version: 1.0
References: <CAN33txFiMRpKpdEat+P+tqQmn4POTY3XafJRxnkjj6BAY6sAnw@mail.gmail.com>
 <8dd2059525774ff0b4af2258caa64891@huawei.com>
 <CAN33txFwhtZR4A8MfoHOMYmuVTTCxjDo6feRVfP1BFA40rmiZA@mail.gmail.com>
 <88880ecbc9944f39b23654b5ac2f27fb@huawei.com>
In-Reply-To: <88880ecbc9944f39b23654b5ac2f27fb@huawei.com>
From: Harsh raj Singh <singhharshraj215@gmail.com>
Date: Mon, 23 Feb 2026 15:14:29 +0530
X-Gm-Features: AaiRm526O48pdAft34vUYjU56R7kDEd7n6Jw5FwxuM-wDlzqUW9KpIADLZSUGdA
Message-ID: <CAN33txG1kqP+kZMqa71XcyFnVy9LKaiFv=FdsxOw548c=yy3iw@mail.gmail.com>
Subject: Re: [PATCH v2] examples/l2fwd_acl: add ACL-based L2 forwarding example
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Feb 2026 08:38:52 +0100
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

Hi Konstantin,

Thanks for the clarification.
That makes sense. I agree that improving the existing l3fwd
documentation and comments would be more useful than introducing a
separate sample application.

I=E2=80=99ll drop this patch and instead prepare a new patch that focuses o=
n
improving the l3fwd ACL documentation and adding clearer explanations
in the code where appropriate.

Thanks for the guidance.

Best regards,
Harsh


On Mon, Feb 23, 2026 at 3:09=E2=80=AFPM Konstantin Ananyev
<konstantin.ananyev@huawei.com> wrote:
>
>
>
> >Thanks for the review.
> >The intention of this example is not to replace the existing l3fwd ACL m=
ode, but to provide a minimal and easier starting point for >users who want=
 to understand how to use the DPDK ACL library in isolation.
>
> For that thing, I think  we do have an ACL UT: app/test/*acl*
>
> >The l3fwd application is quite large and includes full L3 forwarding log=
ic, routing tables, multiple lookup paths, and various >configuration optio=
ns. Because of that, it can be difficult for new users to identify the spec=
ific steps required to
> >define ACL fields, create and build an ACL context, insert rules, and pe=
rform classification on packets.
> >This example focuses only on demonstrating ACL usage in a small, self-co=
ntained program, without routing or complex forwarding >logic. The goal is =
to make it easier for beginners to learn how ACL classification works befor=
e integrating it into larger applications.
> >If the maintainers feel that this use case is already sufficiently cover=
ed by existing examples, I=E2=80=99m happy to adjust or improve the patch >=
accordingly.
>
> I don't think there is a need to introduce a new sample app just for that=
.
> Feel free to submit a patch that improves l3fwd docs and/or comments to m=
ake
> It easier for newcomers to understand it.
>
> On a slightly different subject:
> when you replying to patch's comments - don't forget to hit 'reply all' b=
utton,
> and please use plain-text format.
>
> Thanks
> Konstantin
>
>
>
