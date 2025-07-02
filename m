Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB7C83F07
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC3A24064C;
	Wed,  2 Jul 2025 18:48:20 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id C58524028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:48:19 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-70e5d953c0bso79719097b3.1
 for <dev@dpdk.org>; Wed, 02 Jul 2025 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751474899; x=1752079699; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aTk9P20bUuXRUqnP2KAblaX+qnFpiS0myJVxlHfPoZU=;
 b=dMEdko2NipVYLciFAFOLQQ7WSovrAd+PyD/JP1tDJOuTP+GFpTlR5X2wq6+0u5xJka
 9JxN7yKJbgWRKfiOaDWCn8C1fkgczRYWoqm6YFlSTN0JcA4xnkLuPq4H5xW3BSz6Sglh
 MvlsWiXWhQ23Eu3TtEBj1XyvJh0CxdANKDZyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751474899; x=1752079699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTk9P20bUuXRUqnP2KAblaX+qnFpiS0myJVxlHfPoZU=;
 b=neEiJRJZcmHkHQ6qfmdzwVeHcWCisCMbsnMKy+wK8jg4bs8ZszRlkCpcsizWqWuHez
 34SvhKFrxhMU3ejOmfZzOO3kWGB382UAsXqJvN6KNjS/Ox4R+AUYFRgeiC//xUoiOS8q
 AGtYGrWyEJLvRAC5tNgJ9vo36aAl1uKDNDlNZdEZErmfSi5z7xkhcigkxGDeUkWaoNJF
 1NFpG/Z+RWqn8VC5i2oVVcSRdtuhaHg8+R5uCt7VIxmwXB/eSKPCaWideW1QQdgN3imp
 jPRyNOI8KW2OmelWAev7GfUn2OFipJDihFZ6sFXjC70albBKFI6ELbw9CN9z2XxdbL9K
 irlQ==
X-Gm-Message-State: AOJu0YyiEX4mrhsdP5r8CsETvMZ69fof5LMoLpHeN2UEnC5cJDVormtN
 IcydxoOXi28BUd6x16/JBsN4NLJ1Kq0ApR85ZKjQjPot1oyWodUFfNTzkdVyWD+1r7me56vanBx
 yLnA8pKr4k2yRWebkqoUTK4g4Q2VNhlZ5NfZqJ6MxYg==
X-Gm-Gg: ASbGncuFPvY8PzVA51ESmSjW3NK9qxGK7ZR9Vp0NJ2YTed1w1jFD0HzbjWz9xme0TZ9
 iePT0xsrDFl3a0/qL/tmbdzW+snr02mWtsI5UMmi8xF1tCa5bQpkHYGoswy5L7IpiTriUd1AAka
 ugb65ho/X67wgtHFgRJtKE5cLLNm/cc6Yi8Q7bph1625DxGoMP70C8lamaoOgZ/48gfHzERISaZ
 uJDlYIM7uza7vrj
X-Google-Smtp-Source: AGHT+IEdiqCHi48Y99EN69ybt9CIhrVF7Gw/XP4U6Pfl+7hwwjIuk85b+NOnsMzjeZq4rg/qiZZ9Q1Ytzf+5huk38f0=
X-Received: by 2002:a05:690c:60c1:b0:70e:82d6:9af2 with SMTP id
 00721157ae682-716590ff0e3mr4064127b3.34.1751474898824; Wed, 02 Jul 2025
 09:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
In-Reply-To: <20250702162331.352313-1-dmarx@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 2 Jul 2025 12:48:07 -0400
X-Gm-Features: Ac12FXxYZpr5fKnsKuXbbxHHkcPitMvBddfLPbW6NITMODzyKUhXnlp_aYTl_Kc
Message-ID: <CABD7UXOS7oFwJnYEq1t-Bsx6Ews3zqmEqgRU4A=4fSPfbnocNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dts: add virtual functions to framework
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org
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

During the process of writing these changes and testing virtual
functions on multiple environments, I came across some notable
behaviors. On Mellanox devices, the current test suites in DTS run
without issue, receiving and forwarding packets as expected. However,
this is not the case on Broadcom and Intel devices, both of which do
not receive or forward packets as expected while running on our
current test suites. While looking into this, I found that Intel VFs
do not receive packets unless they have a destination MAC address that
either matches the VF address, or is broadcast. Additionally, the
testpmd forwarding mode must be set to MAC rather than IO. As for
Broadcom, packet reception and forwarding behaves as expected while
running a testpmd session manually, but requires a broadcast address
when sending a packet through DTS (though I'm not quite sure why yet.)
In summary, virtual function runs only pass DTS suites on Mellanox
devices.
