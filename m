Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1EBCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 724B0402E7;
	Thu, 15 Oct 2026 16:47:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 53A364027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792075676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ri4DVAl553fzaauhedO0X8KuTG73Akm9ICSaom9Mt04=;
 b=Y2Ka37T5o8P2NlPg8KpQy1FYtv5lNQL+eCXo7oWw8n51RTe1XMH23QisrkEoaiiM/Gw5Dd
 G1J60BGtWAis49Zu0Kgmgw6TY3ysEupg32rNlUeYtSFr6JBcBa27OHVpvxSPPtClDLt+/d
 tSV76yWmWSlrV4Rqskuh6VYySIzLz3c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-eOrD7ZE2MJqgoZlfdLZqIQ-1; Thu, 15 Oct 2026 14:47:51 +0000
X-MC-Unique: eOrD7ZE2MJqgoZlfdLZqIQ-1
X-Mimecast-MFC-AGG-ID: eOrD7ZE2MJqgoZlfdLZqIQ_1792075670
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6afbe6b47b7so5710410a12.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 07:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792075670; x=1792680470;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ri4DVAl553fzaauhedO0X8KuTG73Akm9ICSaom9Mt04=;
 b=T/wEVJXp6d/VN+CYD48ve6YFuMPjx4x8D/B8rJ/B59a5Gl9g31QjobaJk23HBGD+uK
 kErowgh9BKjJ50yD5eG61njpiia5heSEW39KznWneMJYBO3Pqg9EsU4U3GWc8rPVwxIj
 nV54UeFEaQQrGPnY9L5eMVVAaehV4uD76hq9fZn/IgyAkVXQQ2ymxlotvxHz1REm9l4/
 53+kpX6tBfrMHtLa/31Nb0KMmxgKe+NhO+baSeV+4/u4RxY7NyRwDNxPFIOojavJDAOq
 SHzDAupRjqqRhxdk6REjabkpXTyg2V5BHn5kMGOjjW1DHDu/ZrM0lwjGvQYgQC4LlOUL
 2hGA==
X-Gm-Message-State: AFq9FYLopwGRzE13VFzA9zf/gsjkkf1m6qxnXVvXMI+G2FS5hog59Dud
 6lQagPUT8dEgq6ANa/0pi3Y3YMh5eGhF3CW4wYtipcAsS30cVJaZYjjbSIdg9cQoI4qN1ZDrRz3
 PGVT33DDsOqcUKLWxMq6X8howKOXMie9jEmaGHV6+oD2Y4ITNdkCi
X-Gm-Gg: AYBFou0mg3BW7aQUg/O2PAdddZp5ZzZdL4dYe7TZASQmCH1v+4jNfdLS8LfRdwYTQGv
 HspoCv7ihP1Hleq7A7wxd9qe8cscKLyRe67qoxHcqQQVTuhuA3ecS/KF/6VuEWegWjX21aQkP+A
 F+bcOX6/WCOvn5c/repXwaZurEO7GOBZBIKMU34iTaH8LVUaZGU35e5mYEHDDQOivapBwaS67IQ
 PyWj22n0BHTsKUmhnvcHNCL7DPe+/ofd0psoAy0Q2UGggaIlsSrwNo/0f0JzCCZNA7hNPVjIvYk
 hfdYUu3FiV2fqKEjcTZ0kthnCvMCf+hsare8lCx6iwyz3xCvN2/EpNeCGhhxBMSsWOTctrPxIsV
 dA5iRQuaob7GZbAp/5P+AGbPtk9Lhu1F3vRp1aZ23tZmgf70V+tzRrb67
X-Received: by 2002:a05:6402:360b:b0:6b3:873e:af9c with SMTP id
 4fb4d7f45d1cf-6b3873ecf37mr331919a12.5.1792075670543; 
 Thu, 15 Oct 2026 07:47:50 -0700 (PDT)
X-Received: by 2002:a05:6402:360b:b0:6b3:873e:af9c with SMTP id
 4fb4d7f45d1cf-6b3873ecf37mr331862a12.5.1792075669832; 
 Thu, 15 Oct 2026 07:47:49 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b2038aa1bcsm2519488a12.34.2026.10.15.07.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 07:47:49 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 Oct 2026 16:47:48 +0200
Message-Id: <DM5HT0VSVYFD.CDUXVM1LWY6T@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH dpdk v2 2/2] meson: add drivers to dynamic libraries
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015112607.3008792-4-rjarry@redhat.com>
 <20261015112607.3008792-6-rjarry@redhat.com>
 <atC-kJHTeupb1Qri@bricha3-mobl1.ger.corp.intel.com>
 <DM5ED553NJLC.NBQ71EIJ8HFP@redhat.com>
 <atDEkFQs5XyI3xIp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atDEkFQs5XyI3xIp@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wf5ToNbk94YxVfe31TtGoqPTlQiKN_Us2qkp1DR0Zp8_1792075670
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Bruce Richardson, Oct 15, 2026 at 14:18:
> Yes, static builds link in everything, and that was always the design sin=
ce
> static builds don't load drivers at runtime, everything has to be linked
> into the final object.
>
> Personally, I don't that strongly object to the change because - as you
> point out - the as-needed flag should prevent overlinking. If we do this,
> I'd suggest making both drivers and libs full lists, rather than
> distinguishing between drivers with public headers and those without,
> because that should allow us to simplify our package config files. Right
> now we have this strange split into two .pc files, as that was the only w=
ay
> I could find to get correct behaviour for both static and shared builds,
> where static included everything and shared was libs only. [IIRC, the
> complication was that, when you pass --static to pkg-config, the extra li=
nk
> args from the pc file get listed *after* the normal libs, while they need=
 to get
> listed *before* in order to satisfy the dependencies drivers have on the
> libs]

Thanks. I will see what I can do.

