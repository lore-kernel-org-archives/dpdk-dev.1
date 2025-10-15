Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A8CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6920D4066E;
	Wed, 15 Oct 2025 21:41:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B2CD540273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760557282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8tPV/UPmC0uw0HA8iK48ChPfpgb4L6fHugqCSLAJ78=;
 b=Ek765mU3MDm9gEqn/RONnKI9nhkHLG75nLJ7qJlrw+s0wALqlKqrQl3kqsynhWBh6G7qpv
 DPz7kSDmeH5XM+9EH571+Z2jdgDe2XpC8/+7WXTOENoDhdwtQTQnlAPqkchVhenS8eCyyK
 GPXF5txYtvjDwXSACKOjODYVol5QiuY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-9wF4Tn1ZPFGvrMwUJr2l7Q-1; Wed, 15 Oct 2025 15:41:20 -0400
X-MC-Unique: 9wF4Tn1ZPFGvrMwUJr2l7Q-1
X-Mimecast-MFC-AGG-ID: 9wF4Tn1ZPFGvrMwUJr2l7Q_1760557280
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so14225045e9.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760557279; x=1761162079;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8tPV/UPmC0uw0HA8iK48ChPfpgb4L6fHugqCSLAJ78=;
 b=YXUOe9Whd5ZCoW6oXBWJ7dCe3r5mq5si74bYTvUmmCyBwNiAQZyUa1+ZuxF1OgCFj0
 Ey1BkfOPLN5ueJLxKiiyBEgpjI/nUXou0OSKVUxF2+l60xi1Onm8arFgwe+jFMspTFM7
 CO20fp6dhsXXIQ/K9fhr3Zh9geLDdWCXO36PIvOpfPpZYCex1m9AHJ+7NWLmauupBVj9
 JW/WVvmduDOczs8znImxcYl2O6HjgXc7aXkIlBdhENoMQ0bYeRIss0/giHwDMAWFkckE
 DxjPw/ZwX8ileaqN6+BDZXlrN/UMbCW7Si6y7uPXoHx0XqE8a7YWVGUIgDLIS2at3HMq
 XQog==
X-Gm-Message-State: AOJu0YzIbWrutqJ0iZX5RJjmzVVI/+lVxQH6uwy6tV0fjO/SbX8fEnVA
 Gk4rh2NTY/0Gk/9FNvy5kuj5x4P8iZMoT0JHgo9JXpd6phqHPiQDU6xXXClkUh++ub+bhxoGMnK
 bRrFkOxDAyZPoh3fHWlolAhJNzymwM/TIhL+hJ6qanwaU
X-Gm-Gg: ASbGnct2EkHu3XFFI/vyR2bUmCxq5mgK1FfcYFlZZ4me4GNcjniL+UGHNR69XkKp0FV
 o15CwGdMXONV7YU1Zts+rSHl4I/1gGibkQCkK42qtxje5gx1+JKa5vvZ8cXqLWluCb1NOio8euz
 paFdNRa8tcbb9oG+09fB8mhKtaSiRXE3T1pDo9JRsXLWJxZZBiDCxQBX+xbOSfLKX/Uo9bhTlBH
 MdM87S5sJqJ4r2Y5Hmg2TMlH1QIdE1gVkh79l1UIgqai1Qw7nKVWWDmkT3fJm7rFbVeJApSe26W
 SIHc8KxMDlNbkoktbUROxFaJav/45nyP7hoYg44jChSP1L2gerZkdqrjeCM9nMQUQEPpG46Gkzn
 vm4msCxHvGF4tB7cF3tY7uhQ=
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-46fae33dffamr123950805e9.20.1760557279662; 
 Wed, 15 Oct 2025 12:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzKApPOLJB8ffem1MxmXQ1ENvg/f2c6NmKFmTm79xwKSwrtzTJYhNmSzbG26XqYH+Au+5QUA==
X-Received: by 2002:a05:600c:c091:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-46fae33dffamr123950635e9.20.1760557279286; 
 Wed, 15 Oct 2025 12:41:19 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb55ac08dsm306989855e9.13.2025.10.15.12.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 12:41:18 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 15 Oct 2025 21:41:18 +0200
Message-Id: <DDJ5GW4K1EPR.1KCSDT2O9LO5G@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, "Stephen Hemminger"
 <stephen@networkplumber.org>
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
Cc: <dev@dpdk.org>, <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-8-thomas@monjalon.net>
 <20251015105025.573f5d3b@hermes.local> <2946607.ECZNHGQPT7@thomas>
In-Reply-To: <2946607.ECZNHGQPT7@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RQiFAe7ohZa7mYRwpjdLHw1aWXJ5CXPXRTRpGWRVClY_1760557280
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Thomas Monjalon, Oct 15, 2025 at 21:11:
> 15/10/2025 19:50, Stephen Hemminger:
>> Minor stuff.
>>=20
>> $ flake8 --max-line-length=3D100 dpdk-mbuf-history-parser.py=20
>> dpdk-mbuf-history-parser.py:14:1: F401 'sys' imported but unused
>> dpdk-mbuf-history-parser.py:29:27: E203 whitespace before ':'
>
> Interesting, thanks.
>
> I'm a bit lost about Python linters.
> I ran black, should I run flake8 + black? something else?

Just black. Flake8 style is completely obsolete. The unused import
warning is legit though.

We should have a centralized python linter process in DPDK. The main
issue is that most of the code will not pass as it is :D

--=20
Robin

> Do not pick the flowers.

