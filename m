Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27EC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 10:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F8F4025E;
	Fri, 30 May 2025 12:50:59 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5BC814021E
 for <dev@dpdk.org>; Fri, 30 May 2025 12:50:58 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a440a72584so7001911cf.2
 for <dev@dpdk.org>; Fri, 30 May 2025 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748602257; x=1749207057; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYtTPYVucwalJqpDOK4LO4fkqFsnaCEtp7N+Q59v3io=;
 b=SVuO4ZWrpfgtOpZEtmxhnudArAkanJe2ZBAKc3WOTxCSm0Aj6jQAbLae6Xsjq8BRrn
 lFDgE6hCbZFApTP5IInzeW3jRYXqGn5TI7t1YCexIToNLvydMWXUYtGWj2QWSqccwOmc
 8zkkaqNj1gOueGsoOOWLF8KIOLNmDUfiLtdZlZUK9b9YI3kQOXaGjmQblbMlaQhpYs6S
 rtybkKwG8YrHlF78AQQcB3I6Gp6U8MrXnz1W1MhjONyWgv9nPEudgzQc68O1bVONj5YK
 foY95e1LXbjfuOrn2CUH88OZNhvx1xyDjUmqV7EOUTnNUULrAerUc9QMg6+IndODNvAH
 t6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748602257; x=1749207057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYtTPYVucwalJqpDOK4LO4fkqFsnaCEtp7N+Q59v3io=;
 b=Ffh5x76Lj54lqJdfFv2Ic7i18FrejloVb93437dQ161h3XN/ZokMLd+GuzV871WkiE
 2cKgXnQyd+REWxwfaFgnS99PVqGPjoJzAJSZ8apsIxrdBU25vMkZCmo9Kf/OBTHvV5Hb
 lc2i7CClHZ0sPOi8eL4CPlKJen4gI3mK0C3aNM8eg9wAFEWXBbD8sP0uIvWHK6YT5LuY
 oQ1QTYvepIwIucxjBuv2SYxG9Fs8mnJ/a7Gqa6VxJigOdFTHh/sYr39MwyyVgeeVVron
 7bxjbLGgEVQERR2tP5TMX0ug5d5TVSBOXO5ENXozQ24XdNGmCgpqVEvHSQl0BUE5in8F
 7KRQ==
X-Gm-Message-State: AOJu0YzBRNVSJQPL1MMWnjNoESp/I/0kXd5T6tisdrgExJg18fXveut2
 LHXUtISKYiqsBAFFVFW/QK+vXaUJ8UbhUh22i1RU9Zuird1eWFhFoJtsObpRquQbZ4Lrh7WhChV
 UKku0VhcKEE9fK494eZJKwNyQgRjEuzg=
X-Gm-Gg: ASbGncvwUc3q9B4DH7eV1a0TlnTpEoj1REGwP9smYMqsatywlTdXekjM2L7z9T2nxR2
 DHndVP/LgSFVd3TFD0XiK8wIBxoqXSL4uglwxrJ8q0ZkbdIT8r/tZeii7n5w7zkWe/QDpt0b/+N
 77lo09N78kRiNUUZ2SCJKJMudiOcz/vZBt49aD6DlQXg==
X-Google-Smtp-Source: AGHT+IHDztkrEQwU4ObtGkuAz1s/3jk+6dYXdHxMz6SfSrCotlJskZH4AZsRETqJi27fTshW4gUntY0wShyUd2dbZcY=
X-Received: by 2002:a05:622a:4d8f:b0:48e:9b67:df3d with SMTP id
 d75a77b69052e-4a443f1f92dmr30238081cf.23.1748602257360; Fri, 30 May 2025
 03:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
 <20250509064448.724019-10-adwivedi@marvell.com>
In-Reply-To: <20250509064448.724019-10-adwivedi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 30 May 2025 16:20:31 +0530
X-Gm-Features: AX0GCFtwL85CvYSaYuNAn4x3uVesSPZId15I_whpBK7J5zEEH_5JeZUBc6JOY3w
Message-ID: <CALBAE1MjRDfCmp7SuybvzBbPYFbEe6S04kL0ObvQjVPz9NMvTQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] node: add IP6 lookup FIB node
To: Ankur Dwivedi <adwivedi@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, vladimir.medvedkin@intel.com, 
 ndabilpuram@marvell.com, pbhagavatula@marvell.com, skori@marvell.com, 
 rkudurumalla@marvell.com, nsaxena@marvell.com
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

On Fri, May 9, 2025 at 12:16=E2=80=AFPM Ankur Dwivedi <adwivedi@marvell.com=
> wrote:
>
> Adds a lookup FIB node for IP6.
> Adds a public function to do fib configuration from application.
>
> Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
> ---
>  lib/node/ip6_lookup_fib.c   | 139 ++++++++++++++++++++++++++++++++++++
>  lib/node/meson.build        |   1 +
>  lib/node/rte_node_ip6_api.h |  15 ++++

Please add new node documentation . See
https://doc.dpdk.org/guides/prog_guide/graph_lib.html
