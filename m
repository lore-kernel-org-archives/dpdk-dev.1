Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B389107BCCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 17:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C86402BB;
	Fri, 13 Mar 2026 18:07:16 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 53627402A2
 for <dev@dpdk.org>; Fri, 13 Mar 2026 18:07:15 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-660ea6ceb5aso5456876a12.0
 for <dev@dpdk.org>; Fri, 13 Mar 2026 10:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773421635; cv=none;
 d=google.com; s=arc-20240605;
 b=Qbg67gC4DtrLEUy+IRqyDenXJjRSqs8VlWLcYMyRcudmkftksKdVzxbcPsXnd1mJ2H
 xm4Us/WAnSeRwYMh4D+gwylDbOyGXdjUGMilbpS+J8HLWPyj7nzqXd1UVwEfoztaYQJW
 wQ/D8hb5f6zWpzZUsJ7YNm1vZ5Bcq4pHvdHiOGjVa9eb/+9K04pnXIrTQcM4UB1m5zK7
 qSXdUrZAjwuFag2/p6S3d2TWRO90i6/WpQweCBJl6CIpSqWGKmlHueH5z++8ZALUlCM9
 DAIzeO6cP5hJeilJ2hNHT+AeWvEGlMvon+f0AnAUodXfWbMSvyA+rBwOUIzJbDcU0xaT
 p63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P42kx+34ms/tl12wlN8J1IDB60UK9q1Vt3/9gEA6gz8=;
 fh=H5y70vrx3WKizkScfBiFVShr9TGFnKGdzYrNlVY7G88=;
 b=AyQuB9ByLAicrRY3SdAsddE+a+EjQ32ZHs9ihZAqOQV5FioJ9LqPTHB+rBPA1qjiAW
 RDI1mBfotIL0FfQMoC8cEJbeBAOlL3O0looOedYNsNekVmr49adgsjG180O/TLe5h93s
 wk3tJHJysv05j/ZrEhUNYlgjXmKQxz3n+miTu0jZ/Ai2IGTwTKu+GckM9LXkjD4aQoz7
 ipE/rd391Ms4X5hvCOKJNMnBfvi9FLuVEhlLn7jaAr78Lisrgciv9zYPkYbrbuDW5Ekx
 lKQp27wmRG+/52VarXeLAeEPUnw0I/cbrd9VTanQpgDYAUJlWWXSZ4oc7aqQiKJ/Edng
 ryWQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773421635; x=1774026435; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P42kx+34ms/tl12wlN8J1IDB60UK9q1Vt3/9gEA6gz8=;
 b=HDEhT3VajJITuK5qCpEAyFHuIX2xtJ//uBlO9j/4xfR0x4S08g3hPTXyiPW5iqkF2U
 5WlmxakXoaxjdxBDA8qJ8Xelc1XJdO0vJBe1bc+1YYXTDWXU2NLGdrJ1C45bnTOlh64W
 tZZNz/JoYbSoCeSdz/iTFpJqfCxh2HcpFZuWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773421635; x=1774026435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P42kx+34ms/tl12wlN8J1IDB60UK9q1Vt3/9gEA6gz8=;
 b=pPeO9Ar3pPbqJbUElAalDtKHBed4AK/8b1UDotMI3phMI23ZNsxzv7L6PsJq7RG82T
 QnSLFt3fGAmzDRUOBNNEuL7Ed9jGBC3khw5H3OUHb74oe0ZaeulNqOA5ccCMR01RxdA4
 L3GJrCeIkJbYBOjzpC8Sp6CcYAe9A15aP3Zz6lo1djgS8rqDwFNu0R7Uv8p/t82DlhsC
 A+jQO1bmawZYeEgf3Sxi0sgMZFu9mdPUaFWuo+dxOU+CYaQTQYB01MUY3NTtg3scDzFh
 RsE9H4WeMcoBQcN1T2WBXQL+ZrJCE5DsXfiRHbtgj9vyMLV/9vsv/EQ00Ld63/2Zw6Qz
 7sag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgAeACu6aknrzMPf46QE/BEvG0A4ygsK9ONTte0udRJ3Ma//8Az87+tCGoEMaf3vOmXeo=@dpdk.org
X-Gm-Message-State: AOJu0YwpjGaRe1clz2AtGalLxFBvgddmjVrP+TFPyLIxOV5Kvn24yM3O
 XI7RVLXfnoAS5qlRRpF9NwftyGRJ8BNPDjaHEorqxFbJ1+mbAkqpGFI6gjypxDSBcb4QkDr3egC
 830EmTDkSi/Er7t9hGZIdDNJVnZQzK5/tqsJ+gucK4A==
X-Gm-Gg: ATEYQzyBk7FDPjGTdKWhmA4Ko+h0rT6wgsHhdzBzYWyYW89FbnelzLaVCJGkIX4IxEp
 HCabAxowoWzjHaZmQb0QOvy5B4CXpYIN397XskQit+DmmfLYHOHIzVU4gJAEyQX11nvw4VbTmqY
 TSspxTT48J45IVm4Lx5ik5Kimy0dYjMyMVNndtWohbpNiY2Rd2prwTaPmjK+uKM/gVNi65ix+5w
 kbqlqJAiBQh+jY179aCTDggE4k67VixEtaut9UBigAWB7paDeyrrIdzLHZkd45EvuTftUooru4N
 fN71/x9RrqPvvhkrQJjQZ9xYwktMY71Ui5pQ2cb0
X-Received: by 2002:a17:907:3d9e:b0:b97:73ae:e19 with SMTP id
 a640c23a62f3a-b9773ae114dmr151615166b.19.1773421634850; Fri, 13 Mar 2026
 10:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
In-Reply-To: <20260313155601.112819-1-dmarx@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 13 Mar 2026 13:07:03 -0400
X-Gm-Features: AaiRm50s7IZW8hg3e7_BC4SkDu-5qUpEnUzPQbRN9p1uRy0k97lxdIyot6HxvXE
Message-ID: <CABJ3N2Ww-rRUeRL7cJ5TzU6vVqvFb-vMyL87q7orJtUNZOsxrQ@mail.gmail.com>
Subject: Re: [PATCH v1] dts: update overall result pass/skip logic
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000952638064ceae687"
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

--000000000000952638064ceae687
Content-Type: text/plain; charset="UTF-8"

Tested-by: Andrew Bailey <abailey@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000952638064ceae687
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Tested-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;<br>Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div>

--000000000000952638064ceae687--
