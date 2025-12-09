Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9794BD1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:47:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E06940270;
	Tue,  9 Dec 2025 12:47:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A93194025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765280838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6xr5TqXvDOXL6heeHJ5mGAMDMEEFB7PORTPJf7fC70=;
 b=SL+FyZk2oGO3D2posaRH5el25XPjPtpmyWJ7jS/6CpK0p6tHMLMXalIsTWfUs3qtTL0+sY
 OsGeLtTG8CxuYzQKp5UXonn4oFuck0E5hcqCpADy2ob8dMyluaH4GpTTlq1B8L1aqpS6d7
 glUef1iSZgicgl3uyC0rl9a8BZUWPZE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-2a5ph08XMZK4dVDDnJiftg-1; Tue, 09 Dec 2025 06:47:17 -0500
X-MC-Unique: 2a5ph08XMZK4dVDDnJiftg-1
X-Mimecast-MFC-AGG-ID: 2a5ph08XMZK4dVDDnJiftg_1765280836
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5957bd7530aso5356662e87.2
 for <dev@dpdk.org>; Tue, 09 Dec 2025 03:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765280835; x=1765885635;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g6xr5TqXvDOXL6heeHJ5mGAMDMEEFB7PORTPJf7fC70=;
 b=KIPYyWB2XHRKSko/NhxcqEeag59kkjgoHOEAUZEkKMUkdhzUGYZXbyMVccW1FoiU8b
 JipztUN2Ng1FlwG/ghoh0aEpMt3cjVSaiXKepausHQdxTfp6J2Z1Lk+RpjCcpZqCddIa
 6/G1IVEbYCnbNWyk1jAoFGzy4UNM0CDCWr8nCePTB29tYxtQxNmd7FL+Hrdd+VC7hxzj
 M9eWfPmYqjG/Vn9m29V3mPwcGd0UEES3pziXExAxiKUjZHcoZK55s9qYY2K8Ao1FHpv+
 6fXZFQYjGUSD3KgBYyueSvUjJdHGJdz3JIY/yLnMISNvj6prk1q5r5LRqb8rOtezrS8f
 qLLg==
X-Gm-Message-State: AOJu0YzmS4L/GZrNqWsovV1wM+fWAJNwuRDtTBkKgBVKQf5yv/1L6epE
 hBcZO4J2eykB5ph5d9UrMSPdZiN3sZ4FaOElAdfkdN0VJqQ9keH9PnmLn3rnQtOni+DtCFJgFsA
 ERvFB3kHgDCgdn61o4XG1DLU9jyT0ammnhAGaDRrIsqm6
X-Gm-Gg: ASbGncu4nU0Bm5n4W23atdHV7Y+WmWfKsrCGMaVLp+gDWGwggouabMj5DHgRK0S4XFS
 FrEqagXdufMY9PeBurAxMPBkis8FtZnztPIfjGweyH0ry+0Q+q+mZjoYUjGhPQqmJu4Gxy3ghBz
 xZoMon9jI1EJlpkZC+jkm8iK4lcSVqTzqAx7dBRLyL/KNep7o4osEk4GSMaCNPoKiyn0SGRddQO
 0tw7Ncs8t4A4ThOrwIn5OxN82q4kfrmbOjeLJ5EMHEU1YlD5A7yX4fXsXRDW24HzGEXtZUHNexz
 8BBd4aGCFAseCnUAyUcO20zgAmWohMTV2pgKalRLKrTeoJIttbkX7sUG2djYCRKdsJln2J9z/y8
 X7ukIbaxwJ+x5Kk8PgqsGimSint+CasEC0hIdLYRn2iUjVSOY6K43or8v1VUWKZpzT9k=
X-Received: by 2002:a05:6512:3511:b0:598:de13:609a with SMTP id
 2adb3069b0e04-598de1361a0mr2263242e87.37.1765280835476; 
 Tue, 09 Dec 2025 03:47:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmYPqqTKbDOvnQEsAaSKnVrvEgpqCcNyjO+cEk9RMuVfLPMs9L/C3ku1O0Qqiwp/nkLAmpYw==
X-Received: by 2002:a05:6512:3511:b0:598:de13:609a with SMTP id
 2adb3069b0e04-598de1361a0mr2263228e87.37.1765280835043; 
 Tue, 09 Dec 2025 03:47:15 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-597d7b1a7fcsm5146583e87.14.2025.12.09.03.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 03:47:14 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 09 Dec 2025 12:47:13 +0100
Message-Id: <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>, "Kiran Kumar K"
 <kirankumark@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Jerin Jacob"
 <jerinjacobk@gmail.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
User-Agent: aerc/0.21.0-39-ga8d4735cf219-dirty
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NFvOdL3E-HmhoQFZBUDmYnsywAo7CBQ79Ujr5WgbSY0_1765280836
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

Morten Br=C3=B8rup, Dec 09, 2025 at 12:13:
> Looking at patch 2/2, I disagree with the approach.
>
> RTE_LIBRTE_GRAPH_STATS should control all stats, incl. total_calls and
> total_objs. Then, if enabled, the total_cycles stats can be controlled
> by rte_graph_cycle_stats_enable().
>
> Your v1 series introduces unnecessary overhead for applications not
> caring about total_calls/total_objs stats and thus built without
> RTE_LIBRTE_GRAPH_STATS.

My issue is that I would like the total_objs stat but without the
overhead of rte_rdtsc() being called twice for every node visit.

And also, I would like to be able to enable/disable these stats *at
runtime*. Having it behind a compile time constant makes it very not
flexible.

I could have two booleans to control whether total_calls/total_objs are
updated *and* whether total_cycles are computed. But that seems a bit
overkill and it would mean two fields to check (two branches) instead of
one per node.

Is it really that bad to update two uint64_t counters?

--=20
Robin

> Your canceled check is your receipt.

