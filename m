Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC6D172DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 07:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B6284066B;
	Mon,  2 Feb 2026 08:09:52 +0100 (CET)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) by mails.dpdk.org (Postfix) with ESMTP id 916E240285
 for <dev@dpdk.org>; Mon,  2 Feb 2026 08:09:51 +0100 (CET)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5f526c39718so2385881137.2
 for <dev@dpdk.org>; Sun, 01 Feb 2026 23:09:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770016191; cv=none;
 d=google.com; s=arc-20240605;
 b=O3znic+5ABMZaSptM9npbmxDymdGf9qjO97SOAY1soQqCUUcilx0twfLCCNdqLpxh6
 Z1Mxft06DcJgS76/gB6Ttb2ooaWbAmdfoVQxqv4M16jItJfc7ZIji2MqvRXpKFeBZ0Zt
 uUHXfZIg5e4tDgWrtUu4lPMQ9ZlwUr89JYCRSvPLltR6NVra8LtEzsFYnaQL9ItKKR+s
 hm4Ot5mBcWGCcFeSE9F6HHsnTWNfHN29CO34AtSs8UCebYHPjkfv4v/r0Witys/Xcv50
 lbQ3GNhP5UcHmeWnPngqcXRLR+fy67y9P6PWft+tyrUHzBNOjBHcgUlXAGDFc1pAS6oC
 Txdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2f8+RPrLwm1GYAPVlMiPq/LJRg8NQkZfBNZrecvg7GM=;
 fh=SMATzEPrfaOFC607TkNyLZG0cFZtfdFbrnZsxC6CiRY=;
 b=g6toMncYLg3dPTFlmr3jJrt+nHALsaQgCoI1LNVVueh6ZmqW3Vo5mHVhfHgQydQi1h
 lJTjpsdm1wQ6tLROLjN59jNZeXc5BXxj1A1c6glZk5C7DUnzH7i9Tx7Y7a7E3t6K1Z45
 x963f5fTQ1Xca9nu7Hlkds2akzqHRdEBpnxkJoFuDT6WIqat4kCMpn4xAP5N58UG79Z1
 dYZMJueUumHFscjqNFDJzPy5Iod4i3jaKvNCi84W7I0RTHZJ8On3rzFRKaIOuAEVVWwZ
 j+MoG1ibqjcMgP7NSIUUVvYRjLRFEicM6cPdW6u7DmgXYpT/sPg7Il9AahZTRoiw21cv
 7iNg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770016191; x=1770620991; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2f8+RPrLwm1GYAPVlMiPq/LJRg8NQkZfBNZrecvg7GM=;
 b=AUl+qSSw76iZL0uTtlKQEd0Dn3mlVbme0qxemJyDQ5F6O5d4q2Xa8JGx3qIbkxSn/V
 g9Fkwh0jNeRiT+pR2GZb5BUSCo1ixfAoZqpiZg3SW8EUTW4evuGZr8BdSFWqB8F12beT
 y2hUyVisg360eLhQuoIgzykJeDKV6e0kjPR5SGgAEt4Eqy2E34mLhkT4xRe8uUywC7G0
 4BLiR22ARa2iXX5vsDvsZlRCXr8vwKj2Ww6NsFB5QoFXSJMZcR4eOTvvkvJuSgp+2df9
 EQDplm4c/xefJ0JH+tRsBm7RkNlWjtbVwRDrxuoVWXMYPeiukbC0N+75JH3LIyoPaB6Y
 hIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770016191; x=1770620991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2f8+RPrLwm1GYAPVlMiPq/LJRg8NQkZfBNZrecvg7GM=;
 b=ANJ2FIM/OfuvcCNEt6arAMER2szIsUDPd3pdqlykSeXFFGMRbVe+XwdPt4s1b0qnod
 osPydbzpjlnvSnZCS9J3sdwkProyjWP7xe1NbHpX9mpv2lsHJdU3BIuw1YCLsJKGN8au
 JGTwFfANWojGUz3pTt1XkShhHZnq5+qnDhRsgbdjcIpF9RPFBatSzZe1HpgP6PH6z9cE
 uii/C5by0ylneo1IZbaCqfslYg7Sp1EKd/eUTRISUtAz04u4EVaPkmbFnaPoUjxGTFl7
 BtKVvZAOSOiO4gPhy4Rn3gx8ai5RX0WEkGjr2fCJRGzXnVC2CDM0yIKNLHSAbvEs2pwu
 3DWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbW37Nc64clQ1XAQ1gemsWMLv4foAioF9YrRr1xuR8jCS/cQyado9XRcS/E6rnF5XTew=@dpdk.org
X-Gm-Message-State: AOJu0YwEesMaSCnzM5qNJbJ1NtMolr1n/YZHwMoquNu0fOSTP+mml2Cf
 532ZZAEX7YWFP7Wt7GS0WsNaCeQ7xgTMbMAjCsa0YScQut37CLaUW6qKWQdcEv4/sPJeZYtfETS
 zKu5kcdPlyeaYFL8eosAfUD+ISMmZH1o=
X-Gm-Gg: AZuq6aIRsVxuEkaAEzZRjNdr/ekGp+dlUoeo8rCANSs+ao57CI+zwg3+PoDNETDDtHM
 0XwMY9ZvzrkDi5YAnyOWr+1grqqZpZRyPpUSjpoQ0bFoKAItAdeePAWlG1QDJtagch29U7jVdRN
 yJCgBdEuPhQzOnPJkFOrlQoZ6WfOjnkX1RKflx+SKlrE+m0u1MRMZ6NeZ4biULDWsctKJk/x/k8
 7LAZAWKgYfr+ogHOgpjFFIxxT/WL+li+ogbu9ZWxJ67Mi1QSy7185+OMFJKZ/ORvMqHHxg=
X-Received: by 2002:a05:6102:f06:b0:5f1:c561:8dc7 with SMTP id
 ada2fe7eead31-5f8e268d3b5mr3706656137.38.1770016190850; Sun, 01 Feb 2026
 23:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-5-stephen@networkplumber.org>
 <20260128170612.648cd657@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 1 Feb 2026 23:09:40 -0800
X-Gm-Features: AZwV_Qjo_hph-LU6ZFrrlIO6h2_Uk2WcRrczglDiXaqoaki88aExb6tT1cE1JxI
Message-ID: <CAFn2buBPVcqHe1OPO4yoWbx-Boycx_OCJ0q02TCZWd=rQDtTCQ@mail.gmail.com>
Subject: Re: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 "John W. Linville" <linville@tuxdriver.com>
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

Thanks for running benchmarks! Dropping for now sounds good (I did the
same in my patch).
