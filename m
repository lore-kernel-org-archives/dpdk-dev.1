Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D935CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 07:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0C442789;
	Mon, 17 Nov 2025 08:38:42 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 05265402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 08:38:42 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-88246401c9eso41222056d6.1
 for <dev@dpdk.org>; Sun, 16 Nov 2025 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763365121; x=1763969921; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5QEN8lL9rPLWZyDaM0vaDuWnIbIcAy1opkkumN06EU=;
 b=iRTTDa5zb9IRF2g8Gv8X1FLc/NpmsrzQSZSO6c8C1RI1ygBe5rjQsjr57ye3xk26W+
 nupYshV/+51XATWM/iVlpmI5Z9xk6VZUO4TKqeaOYxiDNY8yTeQSsVKivI33/GohDIyg
 yrEFWmUp6Jl0LFNQTQbAoV0/fbljgYg0jRWWtNxW19gIaH8zsF5ImUW2x+2s4ZZp3x+G
 ONySi74US4nfp/06Vh7/Pp4TS4BfN6tWqrOR676vwHY/O4hWLWnUPDepCbz10ZPS3Zv7
 5fEoFHckEt4KP9Y+vSFvVJ5TzMqFghdlZpUFE0Egsyyuo5panbFJhlwpRkauZkuGMjj1
 /rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365121; x=1763969921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5QEN8lL9rPLWZyDaM0vaDuWnIbIcAy1opkkumN06EU=;
 b=uDtEE8gCR4Cg0ZOKJvFS3Ngpw/2Ru16oMkAokFaeFIFTVQMY/cw99t9uVdzG1yImQp
 qNJt3SYfmg5h4RL1v47i1wCZKpI8NO9/NgiK4spwRlCPGsQgvearTAOrY26N/Y2Jq1Z8
 pzpsr83OuLmkfdLHvMWjQmpEMUZWmEJ8t79ycz0KjlmfER2f8MYl8zUY4V3RTffydLGQ
 UUbQrRdNIbuzdyAlBil35oQKy0tqrhGPy+e/uz3bLZwqRuGn9MQYcYBygVeEkTSd5po7
 zEHi8SHxRjD+FT/9RUzAsVsq3ujmOX9+U6/+Sq3fIq6u73IR58M70tJ+YLn3tm1KICxt
 UwuQ==
X-Gm-Message-State: AOJu0YzlI0g5I6aYYopX9Rjt210RQmF9BA1is6ZQuVyPEsJCdn7qY53R
 I8Xy0s0+X8x+XEmIWbtekTdMsecxcmNxllVWJ2f3OpUncMRc4xqxt2ltvKrAlczWuRZuJ0dK307
 eIC2r7409NuoMbk6HpkzFw7d01Lpxq9I=
X-Gm-Gg: ASbGnct8AtwKajbOXg9DwdFb8B4/nEwuhxi3dlkk0xLaS2it0H1dl3hgZJU3V0K3ol0
 uG6mt2rcZJ0qb7lVKNezfOP6jlEaU5Z1wxF9U/OCWvklk9yeLDy8l5BrGQVM7NDdfGXWvefi2yZ
 xaMPIV8wvVD49jdiemCE2IrmYtf3YTFUFEDPR3sDZqcV5NuYMRR04IsQUVB7YQvnrySKrbLjXA+
 zGim/Vx+Q4EegFefSKAuV09hX80m6zhlJqurOnj6d5xQKABTqHYfRZ5LPE=
X-Google-Smtp-Source: AGHT+IGHU5EvOm9qzElw08iPyz6iRwPdDZr8HS7Mq6qfBMsMZzwvDwnWjivBCaIrmXpazjT+3J0gbRtiSbaA9Gbmuuo=
X-Received: by 2002:a05:622a:15c7:b0:4ee:1f22:3615 with SMTP id
 d75a77b69052e-4ee1f223818mr38305001cf.51.1763365121129; Sun, 16 Nov 2025
 23:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20251114180251.1233757-1-stephen@networkplumber.org>
In-Reply-To: <20251114180251.1233757-1-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 17 Nov 2025 13:08:14 +0530
X-Gm-Features: AWmQ_bmTNCVvH5csuJZtIshv6_H6ZBamW95sCdA1UPdh_GYldPADo-7TAPZQdOE
Message-ID: <CALBAE1N7WnSoXkW4TM1PGPS7eeXW7pq-NiYRB4+71W_P9q=dFg@mail.gmail.com>
Subject: Re: [PATCH] net/qede: remove unused file
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
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

On Fri, Nov 14, 2025 at 11:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This file in base directory is not built in DPDK.
> No point in storing it in repository.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied to dpdk-next-net-mrvl/for-main. Thanks
