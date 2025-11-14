Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C5ECE8D52
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09EC440A8A;
	Fri, 14 Nov 2025 17:46:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1E59340288
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:46:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763138806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvgLDPnbLVUWYzWSnYLaFYgPgDNKFzGPorgUwbMJPeU=;
 b=GHQoKxkStOboB8utrxEkEljBnI/OIuMmK0KbmNZy7dGekiA9HzMFKY4ZapAdLmvjEvb6Ky
 9s4t7YQ3WBiEwJ4sunDczMR0eu0MYayPVbFF5sBMyvwbFnYre8CJXeZ8A2b4dpWWEkkfIW
 SHOqfjyMOwYr6anQ5uKXlIfLX4L56IQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-HT_ok9LBNMG6cy3TMlpnOw-1; Fri, 14 Nov 2025 11:46:45 -0500
X-MC-Unique: HT_ok9LBNMG6cy3TMlpnOw-1
X-Mimecast-MFC-AGG-ID: HT_ok9LBNMG6cy3TMlpnOw_1763138804
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c521cf2aso2337317f8f.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763138804; x=1763743604;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvgLDPnbLVUWYzWSnYLaFYgPgDNKFzGPorgUwbMJPeU=;
 b=gru1vr0DsoIK7zDzeDVxBOcn2aG67AnJaqZGAa65rzbRjxkBx7lhubod+p9d8IlHxR
 eTHL15Q4XWzYfTpvr8YJNGIoo3U+83eBUqt3jJbY5yHFkOpUAkOouZvDrPioNujqDqp/
 W80Sf9UgrKpk/76ASvKKFD5CkdkvGJCfEHLMZu0i87IkQJtGKKgdlERcXKWUyfhLKzVB
 vVS0Ik9ULm+ijnprVnyGuEStO3bs5UGIABZ9w84GFaZHiYHePgS7aJnrQL1oO/1Lwngo
 YlpFPFk3fQXUcCJZ/1UJVHF4IyjROLSO8i7Phzq0+989sOTUOwBCR+2fXDD4qkSarzBL
 PGeg==
X-Gm-Message-State: AOJu0YxRzQ6WqRhKEjyqpIZAT5GYnw6rn9iyiYd6Ic6LOTcYWXvcS3HD
 LR6TdCQl7/QhxxlQSMDvPwZQRr8PEBlwUOC5CPcHjunpnGcMxHjnUknRgDY8rEFUDOibivD0Ghj
 TpjY11qKqz2OinmTVWqZ2M1H7++w+3WkWhTVOKo9kTDoc
X-Gm-Gg: ASbGncusZcdeqEOroSFFa9Acdn3cjdwvV8kF5w+6A5lJ6fgkFity20oMAAn31Jdj10s
 UtZFiQu2v5S1FH6dSsVX2EWpwXImPN34mlccCFv0j2MHi8GUAL191nWEhh5x4whNdaUUJEIRC1m
 /85muaweKVadPyOw0VFOQ/q8EbYVJRlitIiE+tzj3RRbf8KZ3Z89yryBDzkPflxb9zhDcSzjkrp
 fUJ/yfl/SyWuk6JEdsNANPf4CZ2BVzlYWMN8z4ivkcd4Uexo6W6CWM8HE79gzO87ZbyI+uYsnKk
 rVF5BpRw3Qxn8uBLb9TuHSPrZyKCjaDCfQp84nJKIL/B2aPNSBm0NoJRnmne5P5lh/0j7g+ZB8M
 OEAzQHrX1w1RjUm6tTlwGHYtP6eFo2zENipUtrk4yIjx8BUCiAsRTmONIUw==
X-Received: by 2002:a05:6000:310b:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42b5938f8e0mr3603387f8f.48.1763138804178; 
 Fri, 14 Nov 2025 08:46:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED09DG+QbWGx3BuGv/DBVvMN/rJ/0Nbvm72uYCL3WL4uaQ/DiB0Q7ttli7MH+bv+W1koyatQ==
X-Received: by 2002:a05:6000:310b:b0:427:454:43b4 with SMTP id
 ffacd0b85a97d-42b5938f8e0mr3603366f8f.48.1763138803814; 
 Fri, 14 Nov 2025 08:46:43 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm10560409f8f.9.2025.11.14.08.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 08:46:43 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 14 Nov 2025 17:46:42 +0100
Message-Id: <DE8KJK97R8KQ.3SC0EJPIEHSP3@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: =?utf-8?q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Cc: <dev@dpdk.org>, "Christophe Fontaine" <cfontain@redhat.com>,
 <stable@dpdk.org>
User-Agent: aerc/0.21.0-27-g605fd3b39ccd-dirty
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
 <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HHAqbAlZZn_4KS84xJcdwbxI6Jtp8GfLRdr0HtFCljg_1763138804
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

Morten Br=C3=B8rup, Nov 14, 2025 at 17:14:
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Reading the kernel source there is also special handling to include
>> device
>> id into link local address. This is to handle corner case where
>> multiple network
>> cards have same hardware MAC address.
>
> Multiple physical NICs should never have the same MAC address.
> Lots of stuff will break if they do.
> E.g. a network switch will forward packets to the NIC that most recently =
sent packets, so its MAC address was learned in the MAC address table in th=
e switch.
>
> What is the use case justifying this tweak in the kernel?

Some drivers expose multiple ports sharing the same mac address.

This very is specific to certain hardware vendors. The comment here
refers to a change from 2005. I couldn't find the root commit/email.

https://github.com/jeffmahoney/linux-pre-git/commit/44993d3bb812f
> 2005/01/17 13:13:52-08:00 hch
> [IPV6]: Fix EUI64 generation on S/390.
>
>  - put a dev_id field in struct net_device, so that it uses space that
>    would be wasted by padding otherwise.
>  - if this fields is non-null let ipv6_generate_eui64 use the algorithm
>    from the QETH code to generate an EUI that's different for each
>    OS instance.  See code comments for details.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>

I don't think DPDK should care about this.

--=20
Robin

> Do not use while operating a motor vehicle or heavy machinery.

