Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A902CD4F54
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 21:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DB83402B5;
	Tue, 19 May 2026 23:33:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 36274402AA
 for <dev@dpdk.org>; Tue, 19 May 2026 23:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779226381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6E5tul+u7sXv4CgsSnZbAP8JfbgMmwRmuQHDM+GeGs=;
 b=WlbiiKl8IRzKpCymAOZuBZW7LgiV9lEgtuvundBdhsuTxLlm/rRAIsRQYe0HEBAMHcL95s
 22pz37rR3GbYby82+Vqp2qwmZkt/TcCECVW3q7wzTOzGlcPncNXSRAryFP0Nl+ruuKMYm5
 cqPEYbidO24lGrjDoYr3nvREFpEIYXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-yu1Hh8JENXGjxqWAWGoJHg-1; Tue, 19 May 2026 17:33:00 -0400
X-MC-Unique: yu1Hh8JENXGjxqWAWGoJHg-1
X-Mimecast-MFC-AGG-ID: yu1Hh8JENXGjxqWAWGoJHg_1779226378
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48eb0da933fso31072115e9.0
 for <dev@dpdk.org>; Tue, 19 May 2026 14:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779226378; x=1779831178;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6E5tul+u7sXv4CgsSnZbAP8JfbgMmwRmuQHDM+GeGs=;
 b=aFPhfvWUrEiGivLUKGp2Ho+g2k8PTzdZYCzjWww5h/9CVt8truLBUZUNaiTWqoiwEM
 jDpKLecGngIAO70ytxeXv7WeQwwmukjhOyrRfWLSm93amTIhGGveBJynIRRoAiWbJSlH
 LfRl2mPGSLGar44q3Aa+vpqxp7JrQFQyDeUzDTgBj16wPifUGKlGisMyVPN9e0entJVD
 SWYLJMwRc7DHRFUWL48Axdax9w1COC/mf1sB64AoffdfmoLc5HXAYA+Ph/TvW2NaHk2h
 rlzZw6QALrWQ6FRrfiTIf1aa/iLHr67qmx0SJFHz9MO+ZS+0sLvuTR13LAv9D5BdFIkU
 vfKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gy28nrokdtf7slcrksToAlN7toVwt+m1zv3CwtQZwJ04s8JmFrcPnMjUwtaB2TXKZ5WI=@dpdk.org
X-Gm-Message-State: AOJu0YxFWWuBpocRnd+pz1poQSz75zCyjr+/2vu5pDmyxz/sEW0xjAm+
 Zn3AbyqpLwXtafyvLU0/UT8Is80LprKbnNq7fq28PRkmm88SsLbcLrVydIfVxbnMYzhysvgVE+w
 ASzJ/5lFC35vX0OSr0XTYXMT4XR8s1FspaXiL0RadUklG
X-Gm-Gg: Acq92OGOYnFuFIHWeLBXJl4atuTkaCEe3tSvC4RUWCemtZutfSfg/TJEp00LuAAeMnS
 i3fdTKtshPzUr41h7FXB8SA+SCnZ9ZS/hhx3boTZEoqdqnCVUjtTeSH8XIHuCnm/4MZwy/TZDDV
 /0KmGGmwWH5E5M4ZBS78KZD5vEb6O2MXi8OJmbAf/3TgixBWeMHPWdxXHVe1rC5aiH6eymLrLp5
 PA1W/9Da7Tco+ECDyODp4bvhKwANQGjuRI6XYyOcZU7T9/Kdpk75RVTBlCjI+e6gFout+q07X5M
 cOQ0tgCgqZ4xoRJIHCKWpq5Lw8tWRuXVhMwi9jl8+YKEJHGXbT+rCfhKglb+MD48pyoSobmDjW/
 3lhjKAP4AdVKix2+VF6a8oCJ9Blj+tPLVAe0zg430V7xeb4YnfjYhhuGG0DmknCLmpbl0WRsAcN
 CxqN1e
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cc6 with SMTP id
 5b1f17b1804b1-48fe6de1e03mr208050735e9.32.1779226378469; 
 Tue, 19 May 2026 14:32:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cc6 with SMTP id
 5b1f17b1804b1-48fe6de1e03mr208050525e9.32.1779226378061; 
 Tue, 19 May 2026 14:32:58 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm118112795e9.1.2026.05.19.14.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:32:56 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 19 May 2026 23:32:56 +0200
Message-Id: <DIMZ41ANY5TQ.3SXX22QGRY92R@redhat.com>
Subject: Re: [EXTERNAL] [PATCH dpdk] graph: replace circular buffer with
 priority-based bitmap scheduling
Cc: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, "Christophe
 Fontaine" <cfontain@redhat.com>, "David Marchand"
 <david.marchand@redhat.com>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>, "Maxime Leroy" <maxime@leroys.fr>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Jerin Jacob" <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "Kiran Kumar Kokkilagadda" <kirankumark@marvell.com>, "Nithin Kumar
 Dabilpuram" <ndabilpuram@marvell.com>, "Zhirun Yan" <yanzhirun_163@163.com>
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260519101232.541102-2-rjarry@redhat.com>
 <PH7PR18MB507823DB7B8D54E605C4437CC8002@PH7PR18MB5078.namprd18.prod.outlook.com>
In-Reply-To: <PH7PR18MB507823DB7B8D54E605C4437CC8002@PH7PR18MB5078.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: REyh7dv84Bfi-Aufeats1I2122Xl8_JEmXdRdD6cmvk_1779226378
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

Hi Jerin,

Jerin Jacob, May 19, 2026 at 12:25:
> Some high-level comments:
>
> 1)What will be the performance overhead for graph walk.  Try
>   app/test/test_graph_perf.c and l3fwd_graph

I have made some measurements. There was a regression caused by
systematic access to a cache line. This will be fixed in v2.

> 2)If priorities are same, Does it have similar performance with
>   existing code?

Yes with v2. I have added a topo order as a fallback when all priorities
are equal so that it behaves as previously.

> 3)Does it have any effect on packet ordering on egress.i.e for a given
>   flow ingress order !=3D egress order

Some independent flows "may" be reordered but that depends on the
topology, not the graph walk algorithm.

For example, the following graph:

        +--------+
        | eth_in |
        +--------+
        /        \
       v          v
   +-------+     +---------+
   | ip_in | <-- | mpls_in |
   +-------+     +---------+
       |
       |  ,------------.
       v  v            |
   +--------+     +----------+
   | ip_out | --> | ipip_out |
   +--------+     +----------+
       |
       v
   +---------+
   | eth_out |
   +---------+

If you receive the following stream of packets in "eth_in":

   1. Eth/IP
   2. Eth/IP
   3. Eth/MPLS/IP
   4. Eth/MPLS/IP
   5. Eth/MPLS/IP
   6. Eth/IP (needs IPIP encap)
   7. Eth/IP (needs IPIP encap)
   8. Eth/IP

The "eth_out" node will see:

   1. Eth/IP
   2. Eth/IP
   3. Eth/IP
   4. Eth/IP
   5. Eth/IP
 * 8. Eth/IP <----------- reordered before 6 and 7
   6. Eth/IP/IP
   7. Eth/IP/IP

With the FIFO circular buffer and with the new bitmap priority scheduler.

The only difference with the bitmap system is that If you set "mpls_in"
and "ip_out" higher priorities, the "ip_in" and "eth_out" nodes will be
visited only once.

> If there is performance regression we may need to consider new
> RTE_GRAPH_MODEL_XXXXX to enable this feature


--=20
Robin

> Times approximate.

