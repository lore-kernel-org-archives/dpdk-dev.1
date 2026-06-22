Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E62CDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DE4340150;
	Mon, 22 Jun 2026 10:47:00 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 882084003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:46:58 +0200 (CEST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-697b8540279so764333a12.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 01:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782118018; cv=none;
 d=google.com; s=arc-20240605;
 b=CFM3cbPS7CGf+Wcr9AlTF97xDyDSX/fZBlJpGCrQUiJleExX8/7s9SmgZbtfKa+D67
 QFcpW+TgcArir166F60cKML+6390UMAo7E8Ldwd95F9dZFD86Hg5RUqYeMHQaGSohKir
 uOySUj3vB7o4u8QhqIfb8czdZtTfGxI5bcWm3mersLtFWyNk1av7PZ3dBQQ4wXh8LvK5
 sx3LFRAYVO9jPEtIaY/UDT9n1D63Hq+OHGdtfaS7id4BXmQ71zs463CQFbVZYTj5mhH/
 Z86mHV0fL55pQuvGM7j5bc2psKSIdLxUndTK32mKUA9/pn8KSxy1UrwgBqP/wgOwDduf
 KMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W2GENgkfu6rK7trJ14ufdLsrIYy1mToSrrPAH7D98pA=;
 fh=cT6awU86xcwZyXPbiHZ9rVnlnNhkCmnGz082QlFhrNQ=;
 b=A3Amq/cTtDbz38iFlwVP4OjfZ4xi9X1UMFWu0ThcT+dbz1GTW4Y8XwKlA9dfFBnLx/
 XSd0uG4rktl2CWRdK5jtQ3cSRy5CGK8fIpOR+ZGlR6HwAZzR3mOo0TJ/JStRzTl/+8RA
 uevWabkTJugKM3+ycqCbL3aQqbRfuV4J7H2+Knbp+Wlr/9hHrMVEYLTYM8AQknlBEwJ7
 HiT5ZH386HPAaXiwREJgeYjTHxyfViujWsMpfgZvhBuueEB3x6N9n1qm5mfkr9E/JtRh
 /KaNtPEdEr+DFIRe5QLvyRezKtQLa0cxUX2ut5ELUhtniJCQ2rDzg2JXjWNFYupe5lxI
 hDMQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782118018; x=1782722818; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W2GENgkfu6rK7trJ14ufdLsrIYy1mToSrrPAH7D98pA=;
 b=BrQLQE+sDXyRkTdkY5SRIUzXIS0rinLkhsfzxPyNVwqon4XbftsmLdTFD0/UDpxzbh
 7M+fdrG0ygkU1C7igkbO47tFNC5hP7wHXAbK9hmhuKTD8BbgWrJNDWW5ZAjvc7DIqeFM
 LHhU1A1DaTTxjD7ixTGINdEQVgzklFRzhqV5FbyJJtzaH/uuWInWh3OWMngkFMy+Cf7i
 8ccgp72UQdcZLjxMSx8YmRFeT7R/KTmacw+Inmqn2BYIgWM1eSbxpiVuhmSjU3Imq8EK
 N0gZs5GiE18UD5h/YrOXaopdWTy5iiYOI11U6WintEZTfV+PasfjP/lpTWONzdK5Klme
 cmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782118018; x=1782722818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2GENgkfu6rK7trJ14ufdLsrIYy1mToSrrPAH7D98pA=;
 b=KdDl98QXAZ9hEUvyCba869XBnA4bv1O9soAySI/lq9MXCIIQjfs320K7dY1q+vxOW/
 pqDUWFaSIrQwV3XnntkPo5+a3L4GTCZ5LjIp0/Cim+y+74YG/hRiqG0YIIuywp5wwlJz
 2dqiLiutSa6/Io+YCjWsP6o2DqM9xVow7bCLUbTDbw2IUeRDOMJFNHoHkbEV+hMjv6eX
 VTBEE8h0fD5066KiGtWcXfnWd5A4JAeDuDBibIRFbH5pv5o0mYJw7uZjiaVrbWXadzXH
 hIwwl7MykmZvnRXHWLu1n5sh2tHdfL/rlXJ4U1SEt1KBPLuSQKHtjzQQNQEtXjQgGTwO
 8OWA==
X-Gm-Message-State: AOJu0YwpwrRXEcLfJLUrpDbnFFosAbaj/ZUrMyClo0fx82uEg0H0ObZS
 wwQGeP0jVRKGwtPjdvUcMBpFxyIfARVhq6Kw5OFlXQqwn9XxwAYBeKySL5VYBIBNE3WOjABU+mW
 R8f78/qYuPNApT5XHfkWgb7Zu3in7gwc=
X-Gm-Gg: AfdE7cn+JcU2yjJ5gneWYwG9+cxn9GE17SolPrk3MQ5QdBUUzFypmvC1FRs7qO1I5PA
 3DJy4rLjaMxLT+p+O0EncL5gcF1LksDQmSs0sP6dXTlY43wxO/xzgMJm3/YFElRRwskEnM1+SOG
 31Vsx+84E/qkqvt7R91RBeDf2cPPUZYakDfAWwADCq4ge1E27l6jskQtwK5dv9yud3b8xagmepi
 O2u109I49OFcG000u8Q6rHXx1xTj4BLMMNBH1wjEqDtuNVL44Zy3drjS5TzpREXIOfHvveQGZzR
 0mZoc2hzci+YJA36qoIw2DPnn0jo4+umJvJDSkAHeg==
X-Received: by 2002:a05:6402:35c6:b0:697:b749:5593 with SMTP id
 4fb4d7f45d1cf-697b7495675mr1086083a12.9.1782118017856; Mon, 22 Jun 2026
 01:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260620023134.42877-1-stephen@networkplumber.org>
 <20260620023134.42877-5-stephen@networkplumber.org>
In-Reply-To: <20260620023134.42877-5-stephen@networkplumber.org>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Mon, 22 Jun 2026 11:46:46 +0300
X-Gm-Features: AVVi8CchLY2CKgkSvGCdDwyImET9mnANLynMWDcX5M5KvBUsVdYvpR9jUk9AcfU
Message-ID: <CAHfVqdW_pY95mQ5POVjKguCuYU2s+PcsWu7Xo-xqOs6oBmeiqw@mail.gmail.com>
Subject: Re: [PATCH v5 04/24] net/ena: replace use of rte_atomicNN
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Shai Brandes <shaibran@amazon.com>, 
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, 
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
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

> * Do not use rte_atomic for statistics
>  The DPDK PMD model is that statistics do not have to be exact
>  in face of contention.
These are only error cases, so shouldn't have performance contention concerns.
