Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC623D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 12:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9033F40270;
	Tue,  9 Dec 2025 13:45:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 951E04025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 13:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765284352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkmchTzV3CNA/+LVQd7M9LjwFNUc2+QI8BZLpFUq4Eg=;
 b=eVE/kZg7C5MiBZosuQ6Ze6DCkBemVOIemPrKlVWmqRqyAbg9wKFb0dmYxf5R4fCtdhw1OH
 GCCTKtgvtB/aLXsjYTOPS8/n1hyddYk37lGCleldjaiX2b5dUUHnCPBa7BVOFeHVFlsUS5
 qK3+QEInXn9qwpY441LQvTnQVYDpfAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-3Fk_ggoJNj-ymSimVsXQzA-1; Tue, 09 Dec 2025 07:45:50 -0500
X-MC-Unique: 3Fk_ggoJNj-ymSimVsXQzA-1
X-Mimecast-MFC-AGG-ID: 3Fk_ggoJNj-ymSimVsXQzA_1765284350
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so2847361f8f.2
 for <dev@dpdk.org>; Tue, 09 Dec 2025 04:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765284349; x=1765889149;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkmchTzV3CNA/+LVQd7M9LjwFNUc2+QI8BZLpFUq4Eg=;
 b=BPkKofU7e919lAdRaQMuFI1+3FtQvp0i8vwSo4J+pGurpxMBuYKIuk6hq//6HStrJV
 1ygNL2hAbHFl3rRRI1lwtc/Htltva+ZSuhOn/7qnJcjpUspNRUJ0OUAl5aaMgo0bLMgj
 OH3vpEeIxhv7H63LNqXRoB4vRVYz6wKQ/GGQ0v5C+0/IMW3Hzh6YAP2fAt02Yw6yUSqb
 x97sIY4um1+fKuMwhQZxoHhjfTmfMeEm0tR5anXw/damg68+oA8L9DTs2tFdvLbkKqWT
 /AQ/Vin0LFdgS7c6BkqrY8Hjkump7eEdnXF5pe+MC0uiDsCdHqMXPPHGIKvqYEZtPhIJ
 edlQ==
X-Gm-Message-State: AOJu0YxazWOsI0M3c96oFCUuEzM5d4b7sqgj50npYYy9I/WBg7MVr1tK
 It1zrtVtHdC3nQ9rVOJ4EAx8pnOY/5phIqgUGMei2PqzcnYRZtVvgCA8VWr6T87Yz5dFYo3ObpV
 kjfCCvhhWLRNg/rlANNemPghHlhe3TYL9RoCq/PVg9dga
X-Gm-Gg: AY/fxX6lsLhzYo9amlLi462JkWb0z6m0CITpWtDU7nKoLPP3Cr8hm+B2kHlUbtfetsz
 u++cEc/5H0F5Tt5UpJ9OY1kqTwzTEhR6mBHaJt9uw67+ja8sHnXslyyLA/k4HtBgW3x0Zr7ZnxV
 5AMcUJB8OZ8TMvgpMogMUsDpoLHp1IA431ivFYBQCy9WP7sZ+9TnxyLJvMmi6+Q5Qzq4mpXBNz+
 RH3rBEUIv3qjaECnn/seR05bVkquhimA862vw9XQUhhvMGfCQNw97MlmmzWkydN726C3/LQuGkk
 81UJXpRGD0FKEc93gkXPdmFDMwjw7GsPJg3w4k5GsOirVFDW84OWCGWOpIFvgJyS/TOzo6CavrN
 7IQrBUh3aLfjYiZUO5/Kf0edIHRswuTWfgEy1RBc0qMuQRMb3Ac3k3ebt+Ozg26sL/0Q=
X-Received: by 2002:a05:6000:2283:b0:42f:8816:a508 with SMTP id
 ffacd0b85a97d-42f89f63dd3mr10884480f8f.61.1765284349530; 
 Tue, 09 Dec 2025 04:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIkjlURxnTozY77PC04GVIc8hy6zW1WDoJ7TaI+o7YogXYCJpYUK3IbJJsNqhx1a62jv02/A==
X-Received: by 2002:a05:6000:2283:b0:42f:8816:a508 with SMTP id
 ffacd0b85a97d-42f89f63dd3mr10884460f8f.61.1765284349132; 
 Tue, 09 Dec 2025 04:45:49 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d330b20sm30562031f8f.29.2025.12.09.04.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 04:45:48 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 09 Dec 2025 13:45:47 +0100
Message-Id: <DETP2Q0QF39V.1KWT5Y2P9RLD4@redhat.com>
Subject: Re: [PATCH dpdk 1/2] graph: always count objects and calls
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>, "Kiran Kumar K"
 <kirankumark@marvell.com>, "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Jerin Jacob"
 <jerinjacobk@gmail.com>
User-Agent: aerc/0.21.0-39-ga8d4735cf219-dirty
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
 <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VzaXc8gewxG0wltA4yDM3KNepaWDn5PzeDzlgJuNiNE_1765284350
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

Morten Br=C3=B8rup, Dec 09, 2025 at 13:11:
>> My issue is that I would like the total_objs stat but without the
>> overhead of rte_rdtsc() being called twice for every node visit.
>
> I get that. My proposal provides that.

I didn't get that from your previous message:

Morten Br=C3=B8rup, Dec 09, 2025 at 12:13:
>>> Looking at patch 2/2, I disagree with the approach.
>>>
>>> RTE_LIBRTE_GRAPH_STATS should control all stats, incl. total_calls and =
total_objs.
>>> Then, if enabled, the total_cycles stats can be controlled by rte_graph=
_cycle_stats_enable().
>>>
>>> Your v1 series introduces unnecessary overhead for applications not car=
ing about total_calls/total_objs stats and thus built without RTE_LIBRTE_GR=
APH_STATS.

Where do you propose a new flag to determine whether total_calls and
total_objs are updated and total_cycles are not?

>> And also, I would like to be able to enable/disable these stats *at
>> runtime*.
>
> Why would you enable/disable total_calls/total_objs at runtime?

I don't want to disable/enable total_calls/total_objs. I want to
disable/enable total_cycles at runtime.

>> Having it behind a compile time constant makes it very not flexible.
>
> Agree, but instrumentation has a performance cost, and should be
> possible to disable at compile time.
>
>> I could have two booleans to control whether total_calls/total_objs are
>> updated *and* whether total_cycles are computed. But that seems a bit
>> overkill and it would mean two fields to check (two branches) instead
>> of
>> one per node.
>>=20
>> Is it really that bad to update two uint64_t counters?
>
> The cost is unnecessary. It's instrumentation.

In that instance, I consider total_objs not to be "instrumentation" but
more like regular counters (e.g. ethdev stats, xstats, etc.). Unless
I am mistaken, there is no way to disable statistics for interfaces for
example.

For example, in grout, we use total_objs in the main loop to determine
if we can save power by willingly putting the CPU to sleep for very
short periods of time. If total_objs is no longer updated, grout cannot
save power.

total_cycles however, *is* instrumentation. It is only useful to
identify hotspots and debug issues. But it can be interesting to enable
it *at runtime* without recompiling.

