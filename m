Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02138E81A2B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 14:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA2EB40289;
	Mon, 16 Feb 2026 15:58:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9489640269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771253910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMf1DXo7FBnnLbXF9BT6waVaso54YOUXd+79T2QDBkE=;
 b=XOratvjU3VN+dEzf5+OjSdcSIasmQC6rj+lmr7sNuLZTCzcYB+f3zbBzQDu4dg6nL8Xd0R
 jRykrdQzqRaXo6VHKvtfkOOISoLW3Gem1PUinRy8C4wxkTzCVeL5fXp7qfAX1P1i0V2UdQ
 upaozv8K0E9SmTvv7HjSy+Kpfk2extk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-EJps71oDPMyo9unsNwf2Gw-1; Mon, 16 Feb 2026 09:58:28 -0500
X-MC-Unique: EJps71oDPMyo9unsNwf2Gw-1
X-Mimecast-MFC-AGG-ID: EJps71oDPMyo9unsNwf2Gw_1771253907
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59f7319ff3fso905377e87.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 06:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771253907; x=1771858707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMf1DXo7FBnnLbXF9BT6waVaso54YOUXd+79T2QDBkE=;
 b=bTOLscyVgTskxJ2Dk4I5RZTIKcGTPfCHi+hsp78jy8DJG0elHcFP0pWFbpW2nc7CR1
 aRaqUU50ENwgcDbBxI08wYfvahMEiiCMCVuVamfNg0WoYhiZlhskmW/hxXQ7ppE1vzZ5
 6ilM9ch34NSFIAmKuRywCtkyjY2XnjkanJtKJT9wFxXBHaW4ohov3iHrH8xuk2tRRQCH
 7jNbrFljxjjDYv3b+6S32/Qtcda08HUxYaMBvmiDg+D1X+qYCKwdh9pE6MeefIyzjdpR
 UXcinGWf5dUJ8Elo4ac56FDQ5qZzw7/Tmi1+N8xthiTlUIJ3mjOmll2L5psskq/ER/2k
 X9lA==
X-Gm-Message-State: AOJu0Yx3WuGqEvAoeSLI4yuwF4ROcFcGSU9I7BJPHJX6Gc/1HoqC0V74
 zhsuxnV7N4XD0jMtE4yeXEve9k2m5K970mQVT3H/OKTnxy16cnJzpn4BXmu5BxrqtgYaPbw4+6w
 V16BzjDmLjhCzeGIuzzpYntY7j6kQztI4NHyBsbTsG3+4q+dSTVfbsRYoKF6R6ZIQzV6X3OoIOA
 PWChyO+kLgdi8XIH3fegE17PVZKcQ=
X-Gm-Gg: AZuq6aJwKsFfizugqSV3nhakzMzSksWJtSH9P2PJgNd+IPQR04cfXxNJ+NT55YLHRV/
 fDq/8mhe8LriHO4R8BvAagpDYPJwNQL+Sbx7Kz2rzP5n+qWfEYzQV9t4W9vSlyTts5ueMimNnzK
 WANwp0OqWQYiwxP94yLSSjz8LNx/2vkbXSj9P0OXXiiTqLdVJ2neYJif+hqgUAjp7cDjJosPoK0
 mXqqiqqpYHMSfmbb2oqhjrUvjic3ARXmPHzZ4D5VQTcxl9G3OHJe9Ej02maOMLplv3q8g==
X-Received: by 2002:a05:6512:2242:b0:59e:56f3:6c8e with SMTP id
 2adb3069b0e04-59f69c29c1fmr3071559e87.11.1771253907311; 
 Mon, 16 Feb 2026 06:58:27 -0800 (PST)
X-Received: by 2002:a05:6512:2242:b0:59e:56f3:6c8e with SMTP id
 2adb3069b0e04-59f69c29c1fmr3071553e87.11.1771253906767; Mon, 16 Feb 2026
 06:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20260122122354.1820368-2-bruce.richardson@intel.com>
 <20260122221728.231962-1-stephen@networkplumber.org>
In-Reply-To: <20260122221728.231962-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 15:58:15 +0100
X-Gm-Features: AaiRm51ps9MbdDAiU6l01Dt56P6hl7hZyPQgLZdJpdul9ZVYERYsK1RxKth8em8
Message-ID: <CAJFAV8w0jHn6y11MnE-0GDvV_tRpDen7RFn88D7g5EZrQ5B8eg@mail.gmail.com>
Subject: Re: [PATCH] test/bpf: skip the BPF ELF load tests if net null missing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zdvSSyteZYrpGvAPeEQgn2OE6YORrd_hS-CxyyznMjo_1771253907
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

On Thu, 22 Jan 2026 at 23:17, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The BPF filtering tests need NULL PMD vdev to work.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


-- 
David Marchand

