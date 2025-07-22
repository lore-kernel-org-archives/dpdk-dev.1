Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1622AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 22:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8FCC40281;
	Wed, 23 Jul 2025 00:28:36 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 54E804003C
 for <dev@dpdk.org>; Wed, 23 Jul 2025 00:28:36 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fadd3ad18eso58398236d6.2
 for <dev@dpdk.org>; Tue, 22 Jul 2025 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753223315;
 x=1753828115; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5046KW24jnMVYuRBpMYpKynD24MK4ChE8G4LhquSFM=;
 b=wIwo7E48vVUh/K8d4ggd9Q652Nsxuwz5Qeo6cJvXKQ2aHFwxURQW9CIbChe2Ptm5hc
 VQOcnmm8Te+KH9/kHzRYRbVXi/rTggaP/GRyUdd+8aLdZL9zS7D/TRUcpjW8vSJ08DaP
 agSQBUzMjMxCevr5YzdtBMwbWc8UgeR233ZSp7ND8F9YOpd5Z3kFdP4QADXT1K/fnuR/
 /bxWYwX7+BBqFlrRclN8WUKpBZchxu6lgpuoICat5dn5+K+TEzcv0uoYc/IhmcTCP2+5
 Okeu02v5P9X84GEEyEsRMMAvL9WskJZ4Q16s2QbZpw4gvZ9uCZjd66VQM7LCyPO0qxe3
 VEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753223315; x=1753828115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5046KW24jnMVYuRBpMYpKynD24MK4ChE8G4LhquSFM=;
 b=AzX7ADqZ3lt2+tV4Vi18dXzDuYxcS/xTiv2cROFGbKxCD+j7WR/KLMhfcNocVeObL0
 bsWmQl+OuG8axcaZ93FOx13znq41VJ1MMZOyQIqpEaU/LdFpKAGzuWgk8sYNMDda3nk0
 QkQYWKERIrCEeH/KK0V2uZfmAKwddQXTj/sWq+loFnFzaYgp89XkCIMdNs0ENhEQmXmg
 U23RRqZpQeLuzNRTAy0zBm4WQ4o8MXKSbxraNsvKulzWZ1Eouq6JtOkQNG/ENPGYTt8L
 1tAnzUL8Maz732553q61iJO4a4Z+xG0Av6cRLDnkuIblDEWzDwE8ua3T/YV0v4YdkQW4
 tQdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+S00/bO2qeYEwI5M5w6ETf/QJBF+YEek1g9po0BhcaxUxbvQmInSwrAkTUf1jUR5czaA=@dpdk.org
X-Gm-Message-State: AOJu0YzVYesb66rLrTonRmtmDkezsTIDToM/Hld1pKYiM+8Hk4LNed0L
 noTVgO+6SF+YdJpnLku+fDXs0CNFtrbVpUAfrsB5M4SZZjTlTFKtEo+Twg1vjshVAUA=
X-Gm-Gg: ASbGncuWrBcBH6RXoUCNo/eyagjD5Vafwa+Q/w5X7alx1NduQQMH02Rb0LnYa6HDNez
 GevWSpVWNqOGrhoxsABeMZiEHdyTwzh05vDBZz9Ngj990jxG6qxvB4EmAqecKUJivRWIITTO4SM
 5FENaamREGiEnoaPuGYjB5XuaCmEzlLhVdsjl5Z0ohD8S87bksPfk33cCuXFMpNRF1yxDwBCy9M
 uRxwABEQ0r3f8H2C3ZJ8hooJ+m1NPiBdibycd41IAsJR/lY8rlOWUSVfb02mJJmA59uKLbjaC5j
 poEUHe30Za6VwfVKNMCUW9CkbyqRJCHDd9x70ItbkRhmrQIvLb37Nb+hRuDDVSLDdK0WelR1Ejo
 8sIvXeaku1VQCANCbbXMX8gp781ldpOF8HohJrKZCJ0t3ZYkieFd3i+Np45AmKj07Dil4wFsFOI
 I=
X-Google-Smtp-Source: AGHT+IGA+yQ5zgeeIMWwLG4OO1mdlQFQAFKaRSpbpFN9nlfcn7kElY8Z8Stx78TdAWBWbHR80Nbccw==
X-Received: by 2002:a05:6214:f21:b0:702:afa1:b2d2 with SMTP id
 6a1803df08f44-7070058c6e4mr10527616d6.4.1753223315363; 
 Tue, 22 Jul 2025 15:28:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba6b24fsm55178946d6.60.2025.07.22.15.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 15:28:35 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:28:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, Ferruh
 Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, dpdk stable
 <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250722152830.2f8f08ac@hermes.local>
In-Reply-To: <55209b79-6845-5c25-bb8c-e2ecb3f0e290@arknetworks.am>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
 <20250722084225.7a40e2bc@hermes.local>
 <CA++2-x6bMRbxne_JdtSkCjVmAPMsY4762xzDbqPhqq8K8695EQ@mail.gmail.com>
 <aH-4xyH45rElgVb0@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4+3QE+EOCdUcX8go27Z0tqrb4Br1MADQEiu=q3GgRpPA@mail.gmail.com>
 <20250722103824.7c9db0a0@hermes.local>
 <CA++2-x69b=_+7wYaK57fv8j0F4VOsSVJ-S-yyi76Lgoy=E-dpg@mail.gmail.com>
 <20250722112154.78349c82@hermes.local>
 <55209b79-6845-5c25-bb8c-e2ecb3f0e290@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Jul 2025 23:05:06 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> There is a difference between control path and data path. Always has been. Yes,
> on data path, DPDK has historically sought better performance, but on the slow
> path, checks have typically been implemented, even in the flow API, with the
> only exception being "asynchronous flow" APIs, which are meant to be fast-path.
> 
> Yes, the idea to have a "secondary process reference counter" in 'rte_device'
> to be either guarded with its own lock or accessed atomically by 'rte_dev_probe'
> and 'rte_dev_remove' (to increment and decrement/check respectively) as well as
> by 'rte_eth_dev_close' and 'rte_eth_dev_reset' (to decrement/check) may not be
> a hill to die on, to be honest, and might be wrong, so I have no strong opinion.
> 
> What scares me most in this idea is that, one may still end up with certain
> entry points overlooked, rendering the whole effort worthless.
> 

Please don't top post.

The DPDK control has (up to now) assumed that control operations are only
done from a single thread on each port. There is also the issue of hotplug
but that is separate. For example, if two threads start and stop the
same port bad thing happen and NIC driver's break. 

This is not well documented and a section needs to go into programmer's guide
thread safety. The whole thread safety section is out of date, and doesn't
reference RCU when it should. It also doesn't cover hot plug or weird secondary
processes that fork.

There is also the issue of how primary/secondary monitoring work.
Right now the secondary monitors primary by periodically polling a lock file.
This inherently a racy method and leads to problems. It needs to be redesigned
to use a blocking method something like spawning a thread in secondary
that uses some part of the existing Unix domain IPC to get notification
when primary crashes or wants to exit. Ideally it would support synchronous
handshake with all primaries and asynchronous case when primary crashes.

The point is that bandaid's in the ethdev layer won't fix it well
enough.



