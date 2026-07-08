Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD5C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 00:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6726D40264;
	Wed,  8 Jul 2026 02:56:37 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 5A78140041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 02:56:36 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47de008b020so60403f8f.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 17:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783472196; cv=none;
 d=google.com; s=arc-20260327;
 b=l2i4ZHP+fZIeqcoLnIlP/xJtmdtkS1IP4r0hJGTqFi+9sYN1K0A5a7Q2zeSDRhvNlG
 1CTMrD0diFAPrVkMAVGAenBQiSSfgNf4uidgJ9Dn2M8Jc/KYtOJQsULPoNDe55Qd1aXP
 Z8HFxUz7kJg2nn2H/xKubchlAyr5YORXJrPCK9CEwV0kRWjKdrbwnqIhxWdBeAJ7BC/B
 xnrVa+Gogah136ATGzsMzKenMxIMANaXqMzeBkVvRGIVeNGe7wOw48yqNmaKYwh3MU/b
 YTFkAUbEofPv8Z+Sl6FxfYiiPSCNO9SoIuFluG4Erk7N4ITs0aU7oyb0QiBluyT1YhdP
 SSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HaDupjlrudSea7yqRz3+FMt+7SnBhkev/tAUGotDaxY=;
 fh=ZaWbFWbr8jWFbaBYEcyyHElUhIaZ91hApyqNNx5F/qo=;
 b=K4/AX0xDMln03kJ+JyzRA0s5PK7Nq2tJcRJvzulbjsQtxnaVoQW783HzoijUQ0dnP3
 Ggmb+Vq9i/3a9QZrREX8gDpUhMlyDZ/VddLVmOA00+YXFXigZSm5xYGNAw4TEQfvCcRD
 AeKdJPJQKwqEHBxmwoglxc2YCzC7LPxOryPOtqg2ikBum1Cn4PpG2JOu8+A5be2xPx+n
 +nCV1FdWDJyLqVRYbSU0csAT9bz4p4VAoBJrfPOKVqRwqsT6Nz0EGLnlFifFNaXHAqa8
 e7IJ9FPXB9Oac1X8DOv1HPChb8uxHd+ncvH3q8W1QaLrPHwsi7rlfM57+shnWuitKN/G
 P/8Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783472196; x=1784076996; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HaDupjlrudSea7yqRz3+FMt+7SnBhkev/tAUGotDaxY=;
 b=eahD31j7HUQZ00hxR1BqpOFpjBf3bGVVOw3zIyz9QpvUq4LZ2XQbUkbW8Hjr0vSzuU
 NCeU/xT0fQEp0hSxdyJyTNKjR2N+VeGK1vgS6kQad3RC2UPNkwf+7OaVWHmFNMoLtPrr
 Sk+jVPN5ocST8V4/J1VZDjZwauK3t4BDCqrHPYjrrrwt28oM5xU+QhZ/0ZIyHeADpwNp
 EVom8ip+tzgmU8Qa9x/zhUq+9VHLYRYKTUmnphkdObEWfj5CxW8aJtsvFePdjHj85xat
 OakBg9+cLWmgEAg5iiyc+xeCSG0PZ5XBDUE3ui2w68+gazqOHYs4cYKyG5EzIBuBwXEM
 T5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783472196; x=1784076996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaDupjlrudSea7yqRz3+FMt+7SnBhkev/tAUGotDaxY=;
 b=INOipFsyPjAPCWwhtgYM3eqGvBwItr6rraHn/kiRJi39YexnnEtytBtJcrOcgC6w1E
 Eo2IdOycc5inLuANmU/ps2dXUEW0fzE4ts9GGrTXtFIVKR1uRM5VYpQuC8KPwTPjI19w
 UajMDaCux1ZB6lDq/8fV5MDIHhBqsDeKudprnorI67E8X5a7jgFFIwMWmSxbatIHC6z+
 ij4DiIF12dah2vBzZr1iJkiooH4UU9gC1UqJODrFL2LEa48e2MQ/3TqNK191rIZOH/Ez
 EgueJh9751yEAwow5rzBy1SBIemOnntNxO2EuHuWcVAPYogEWi4n3KpGRfGwa3m2ayuy
 SVNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov3Q3HfgqkO+IadJS6f29Cary4xSosi4kN9tPkdrZhpvD4pR/q5zstPmNxpuQUOs6BNxs=@dpdk.org
X-Gm-Message-State: AOJu0YxV8qW+Qmov4/kD70W/Z/Nclhl1go+ruKMSNnIWg+sbJgFuWbfc
 LGIidgEuh1G85N/B+sqjNmHyqYwY52WXClkeesj53Hid2+v4kn2y2Pb7jzlr4jhZ4yJYZsqO89T
 ue2vILten7Wwx9cptsVLS7kIbjwpwIuI=
X-Gm-Gg: AfdE7cloG9xIxpv6FRplR+Y46fzpob47flqY2eW5lvl8g06//OsSnk8ZE7NefH+Y+eA
 3P5sw18Xj5JjjkG4zrC5Gm4783D+adXfilcRU4ggl13lW/f8SfGmO0OJro182Ll55r7BmztkYZo
 Ute7V5oyD3VWah/iYA1PZWJ9QzzLnFsp8FB72ORr0rmFI3ZPxmNwMe2SieMtp8j3YjcK2vI6upu
 e46MGCXeJDlkcILq/eh9h0KgbX1VEvO4fISuA6fuUanQdaYBIKHZOR9lNwhVGNC51kgc678xQbH
 fgIj7tKv0SzQ9h9P1Og5Q0cun4sPEubU5PiF4qHC/rLe59tUolDaNsYx
X-Received: by 2002:a05:6000:4025:b0:473:1e79:87e6 with SMTP id
 ffacd0b85a97d-47df0245d9dmr409150f8f.3.1783472195668; Tue, 07 Jul 2026
 17:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260706132633.465385-1-abailey@iol.unh.edu>
 <CABJ3N2Xkr3zihiTbzdByigibcy4i_txxCk-0Drzw3E1weze6rw@mail.gmail.com>
In-Reply-To: <CABJ3N2Xkr3zihiTbzdByigibcy4i_txxCk-0Drzw3E1weze6rw@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 7 Jul 2026 20:56:24 -0400
X-Gm-Features: AVVi8Cceer_bAuGs0VdASuB83zAz5XlazvQbgekWdRGk_E6bwhfkwzIruxuJ4dI
Message-ID: <CAK6Duxsyz4efSJB6Spp+zM5RYFpvB=i+NFiGKacyGyuzWFPiuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: update parsing for cryptodev latency
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b08cbe06560efa85"
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

--000000000000b08cbe06560efa85
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks Andrew.

--000000000000b08cbe06560efa85
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks Andrew.</div>

--000000000000b08cbe06560efa85--
