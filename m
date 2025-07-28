Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE990C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 09:29:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C339140615;
	Mon, 28 Jul 2025 11:29:03 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9FCA340430;
 Mon, 28 Jul 2025 11:29:01 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so35278537b3.1; 
 Mon, 28 Jul 2025 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753694941; x=1754299741; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x8BfY8CGByDA+5GgBwWSctWKLDG+RKr415hRw+ULqCw=;
 b=QdBZ5khlLvh7Z4HJsyTNqaxHGM6XuVCT+tD+My8WX2pbzmdlhpVvV8VDBeVWaNuVoR
 Z1LlYGzaEfM7Hku4y6PFb0flR8eRzpdetQvENHUKQMW6Pv7mS6JXmmkFegcsfvF/rZGQ
 WLpWDklYbuKFAJz3dAeo3J4oxcI0X92Rtj7BsL7gyWb7ajgyh5DE3qqxepXwD55/rbda
 KON7Tqu4Yo/btewSXmFpLxNZ0I5TGAH6HfTSL795IwxfM0W2GQ0PPLtG1bj9uZNR9ZML
 GzIjX56BzrMElWTEf8UhvaMDdQi+oqnktaplBFUVoIhqYbUGRifmCcavIeIpWWRwAWZ+
 uFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753694941; x=1754299741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8BfY8CGByDA+5GgBwWSctWKLDG+RKr415hRw+ULqCw=;
 b=Bkf98+XMYYB7FozjUvs315e2E1QIsYNaet12/AEhjNBDGoyEPFZ1nA3S7WxcQ9cipz
 lS6O9rTXY8XddIjudZ5lXdhIPn2Cu+ljbgQmPDEEetbxwmgj+vD2NpWNNs1F8jY7UPyy
 aYkAKat9L8NrZIIZESl/GUqEt8dHAv1hB+arPSmt5gORLdTic5lTQSe1UpRBFP3UfYhY
 9uszbkkElQszchsprkTd1NpFAnHXM3cv4lA0KGs7SKuywIW8u2XnH6YToodNZXMm9ymy
 thveqkUGalYpz4nBa10Y71Si4Q1JS3DAPBTW4zi2LKBQ8FqwkHyd2EmKu+SX5ejKnX1g
 azCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ07QKO7OGjaHrZIrHbtLUZVPgX4FKQh3S7f4D+nHbK9K9RpjJsX7iX6a6EHCQX7NPpqE=@dpdk.org
X-Gm-Message-State: AOJu0YwIhw8N/o3sg13yCUH4Wu7ASPOaxZuyb1lL/io+tMSMRywTpL5Q
 MgDyJTAkHa1Yt4YO6wHk6r7Qac/XY4TeDVnxHKvLcuIeZWqwHubozZSK4rGEO9s2fYFCjMMDAFw
 eT2t9BNjR7oWtAc+Dau+D3lJ9ZpmdDlY=
X-Gm-Gg: ASbGncsJYruDTCv6/7maVzFGGSosFsLib40l/q17l247kWI6nAbXqio5ouOXdDLHewb
 zMv7VvRZg/bQcdwZxRrc+A9y0luHP5K2pKDndFOsyorrehsvvkuOHkaH1bSrdtBJZSs5HHYT5ra
 S7NZvdVw409Q7WvFXfN++PA53xt36UQFVPHpKzU1gSgMuf6B5AKSCoIWoyM9Sgmxbf5nC5HsFdt
 1+IVKtZW0m0s/zhpiOuXin4nvrWd8gRTknbrsIE+A==
X-Google-Smtp-Source: AGHT+IH8MJdWLnXU/61eW7nWZNiDa52k08ME+voWjVjNEkptQSopgYDyCd533xRcHq0PnzXc9W/TNvbDTqDWu6F0zG0=
X-Received: by 2002:a05:690c:4d86:b0:71a:2299:f0d8 with SMTP id
 00721157ae682-71a2299f28fmr26074587b3.16.1753694940916; Mon, 28 Jul 2025
 02:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250723160822.1686060-1-luca.boccassi@gmail.com>
 <CAGYh1E-x1AxkGv-PK4PoQ5Fuj5b94LSseQAzhHVVrciqqTRCig@mail.gmail.com>
In-Reply-To: <CAGYh1E-x1AxkGv-PK4PoQ5Fuj5b94LSseQAzhHVVrciqqTRCig@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 28 Jul 2025 10:28:50 +0100
X-Gm-Features: Ac12FXzkebTyoi4zZXU0dPTimBb2pVwgligVHPTaZN_XgBTzMEZWPh6B9tuVoe0
Message-ID: <CAMw=ZnR=qO+i1PQMmmZMiHv5qEJb2=Yi+KPiiDQYUnXjn+Bf0w@mail.gmail.com>
Subject: Re: 22.11.9 patches review and test
To: Yanghang Liu <yanghliu@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, Kevin Traynor <ktraynor@redhat.com>, 
 Chao Yang <chayang@redhat.com>
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

On Mon, 28 Jul 2025 at 10:17, Yanghang Liu <yanghliu@redhat.com> wrote:
>
> I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk issues.
>
> VM with device assignment(PF) throughput testing(1G hugepage size): PASS
> VM with device assignment(PF) throughput testing(2M hugepage size) : PASS
> VM with device assignment(VF) throughput testing: PASS
> PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
> PVP vhost-user 2Q throughput testing: PASS
> PVP vhost-user 1Q - cross numa node throughput testing: PASS
> VM with vhost-user 2 queues throughput testing: PASS
> vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect): PASS
> vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS
> PVP  reconnect with dpdk-client, qemu-server: PASS
> PVP 1Q live migration testing: PASS
> PVP 1Q cross numa node live migration testing: PASS
> VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
> VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
> VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
> VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
> Host PF + DPDK testing: PASS
> Host VF + DPDK testing: PASS
>
>
> Test Versions:
>
> qemu-kvm-9.1.0
> kernel 5.14
> libvirt 10.10
> ovs 3.3
> git log
>
> commit 543047abff3b5eb16d939cdc6b5d1200c7ff7f0b
>
> Author: Luca Boccassi <luca.boccassi@gmail.com>
>
> Date:   Wed Jul 23 17:00:10 2025 +0100
>
>     version: 22.11.9-rc1
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
>
> Test device : X540-AT2 NIC(ixgbe, 10G)
>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
>
> Best Regards,
> Yanghang Liu

That's great, thank you
