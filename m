Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB098EF9014
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE95A40287;
	Thu,  5 Mar 2026 14:43:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2EF554027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772718186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECQq+YSnICFhOiqL+uAP3lWL8af4TtyqZR2S01Mq1AM=;
 b=WnOjBjPFlIHK2XAUlktxgDBjsI8oFMY4UgQjS/3UFCnIEui8F7VZekAMa5uGQC0UOktQ7s
 WyDjD92BGRKp81xezy993J+2VoGSFrqAjHsZ8Y3KNGgAHV3LgaMeoB3SQDdMnLoQydP53/
 tl77S5d8lqIOjDS2Btm7LALJvNNlhWo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-5W-q7nINPNuYxqyiT_YUug-1; Thu, 05 Mar 2026 08:43:05 -0500
X-MC-Unique: 5W-q7nINPNuYxqyiT_YUug-1
X-Mimecast-MFC-AGG-ID: 5W-q7nINPNuYxqyiT_YUug_1772718184
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38a39c7a761so1725441fa.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718184; x=1773322984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ECQq+YSnICFhOiqL+uAP3lWL8af4TtyqZR2S01Mq1AM=;
 b=VGmBlBvs5eZU7FuLbAgTc0Ud5O2QVnR0z7kDcYfV1mcJPnEAwTqba91NbRybx74OYX
 AAurPAbbHpBL571BTsnBnjdQmUdgXeOZmFOAdTvBDS4eImtCjv8fg3NGUieABrArg4pn
 buct6SfDzzYvRItUmwDgoBmMhC9mpq8TFCXlLgPxGp8j2ItI6kBfLwWGUCxvrrSJW97Q
 7f+KxTDAg3g+7NNoM81eiw4X6TcliBvRU5vxIC+CaHSPWAxJPx18BP7iwbp9A6sswB2G
 Rrm+tIXT5EmOf7zvJ35OvU2m9C14JhkYaF116UXC+XmtHVOO0dBkbWarvwgc2mflHu/n
 sHyw==
X-Gm-Message-State: AOJu0YxKOPSiNRZpyoNOH9FbHOqu4HNp0oAH2iS6yr5rLirkYOmiHKCk
 XsELREVDwP3K/gXMH212V1FYKL7C/buv62BVV5QAmZgTquo7U5joNPEFtBx4pOJluI9wacW7+pF
 F8OOuJzn6G+unSD2D4pChUe1umIa0KqGoMS42G2tdIojsovVsoTs2dVcXoo7pDG7jhS75viI5lB
 4TMemC9dyYVhAE3sCmOkw=
X-Gm-Gg: ATEYQzwkqbrn3Na4a333YvnNcDl67HyH7qBkRp4YHuroRCCkMJSlWz06kT8RmzDZB8v
 5k+EOX2/sPTHBzMzuTeitNLqHBVXu8xvWUrs4FQyJEMn6oTAPGK9RZYl1WHfttDRa5R+2rCWIWf
 zeOhoJ8oHtU0V6R/mAcrPKQ3ORegitz/GvdB6DniRMOicArW5FMUwakl9mptILlZIDQKWaf+9n6
 +pV5wMMqyFAGEhYDOnqHKhjoPpPrimY/nYQJNs8MaJXwdam5m+84rGuGaL4QXmOVYkGDg==
X-Received: by 2002:a2e:a992:0:b0:38a:3374:f908 with SMTP id
 38308e7fff4ca-38a3374f998mr15953831fa.16.1772718183851; 
 Thu, 05 Mar 2026 05:43:03 -0800 (PST)
X-Received: by 2002:a2e:a992:0:b0:38a:3374:f908 with SMTP id
 38308e7fff4ca-38a3374f998mr15953801fa.16.1772718183363; Thu, 05 Mar 2026
 05:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20260218101859.3028581-1-david.marchand@redhat.com>
 <CAJFAV8xoT+rV3J1JR_zy0hCQhM6cW6J50dcd1s=LBft1qrdMKA@mail.gmail.com>
 <CAKx8PBiSXZJDAgLvFAZ85UhRU+FK7VHpYEqJTo=bwHngMCjFoQ@mail.gmail.com>
In-Reply-To: <CAKx8PBiSXZJDAgLvFAZ85UhRU+FK7VHpYEqJTo=bwHngMCjFoQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 14:42:51 +0100
X-Gm-Features: AaiRm52XnIPrGsiAwzLc6GT50fi_bRGUKexQIpWHlQfCtXyQisJKTCcAjLXBGRk
Message-ID: <CAJFAV8x20i75_HhLb0Z2KxLY909NstvtQRyv54eqUV5SYAm9Lg@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: Ben Magistro <koncept1@gmail.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n9Uq5rLvkpaCPGONzEXICgr4Re5tDxOwa7V_5bbHuL8_1772718184
X-Mimecast-Originator: redhat.com
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

Hello,

On Thu, 5 Mar 2026 at 14:21, Ben Magistro <koncept1@gmail.com> wrote:
>
> Just now getting to cleaning up my mailing list folder and came across th=
is so apologize for reopening an older thread.  We will likely appreciate t=
he patch a great deal as we needed to switch to lld form clang (this past w=
eek).  When we made this switch (had some size related issues with sanitize=
r builds in our app with ld) lld definitely complained about the symbols no=
t being defined.
>
> I don't have more of the output saved from when we found this, but did sa=
ve off these lines while discussing with the team.
>
> ld.lld: error: version script assignment of 'DPDK_23' to symbol 'rte_eal_=
hpet_init' failed: symbol not defined
> ld.lld: error: version script assignment of 'DPDK_23' to symbol 'rte_get_=
hpet_cycles' failed: symbol not defined
> ld.lld: error: version script assignment of 'DPDK_23' to symbol 'rte_get_=
hpet_hz' failed: symbol not defined

.map files were static until v25.07 and you seem to use a version
prior to 23.11 LTS.
The dynamic generation of .map has not been backported, so
unfortunately this current patch will not help in your case.


--=20
David Marchand

