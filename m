Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17BCE8D4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1250740F16;
	Fri, 14 Nov 2025 17:08:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D531040EE1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763136529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYZI4G7NJ7HlNAl8CSPpvXZLtrVIagzofR1UAcggMFY=;
 b=iuD1xNpv4YdHijnNlaNyqPDkdHAz4uUJWgVla4L2hVD9QwZzpVOs55yt+zGwVuG9VRym9z
 UaQ9RCvnEawXLWvc5F6swpOhAmGVYX7ajzWuEr23iHAwsbm6r4CIbnx/5G7ysvhVQ+iq//
 dmPVqzG4BritwY2FHV7z52lIexpwCiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-drdliUILMOSdFS187gaxPA-1; Fri, 14 Nov 2025 11:08:48 -0500
X-MC-Unique: drdliUILMOSdFS187gaxPA-1
X-Mimecast-MFC-AGG-ID: drdliUILMOSdFS187gaxPA_1763136527
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so775e9.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763136521; x=1763741321;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Flpxv46njfn2jBYh4rVkPwRFerJ5wEjcP5hw/tEVu1o=;
 b=A3h4jo3DOm7WJ6xwuUEfoOPd+7VhIsoaJ0SqpgqJMM9aYi8YOHCG++ewWk+5yUJSmO
 gif4jmLXI4T2gWvKDfqjgSSLWZmLIY4i9g+cA0jZxVjHce7B+H7Wa9dffVlM7iyh733a
 g38YNGiGBXdBtJLNaHvBStpZmzdpvq13XNxggxe6pWPv+5FAVMiz3YsfFRHJ94Xoo0yN
 ZLDMi/6e7XpKwYtdBXNcWkx+Jm3TC9jUWCysBGLmHVXTWGyLHqv7yXNxiThPqldYycfB
 g9iArcO8axW3UvGfppgylSptNRnKhnFmqT5zkkU14h9zE9tOW6ubNUTtSdgw+4VWsEBX
 rryw==
X-Gm-Message-State: AOJu0YzVnaG7rNNcPkC3pHsZNXpjrCggsh98o5PevXQ+3Lvwg7EZcFA8
 WUM+ItGBiAJvvVl5hAvqchXESCLiDVv9FnHpaauWQIucfv5V14cqD7FtkGX6q9T8nrI1OCrkETw
 Zvtup2iBw5fCCZCn8BhEgNulF9vuWlu+U1OeX5VkC6Cdv
X-Gm-Gg: ASbGncuUjqh3Y/rKwQogbN/GE76670cvcB7E+ntKNqn6zQw3QW33vs+yyhzuF58oXKW
 y5suRuAAZGQ72zPI+1//5IoYziQpd9nZrbWzboiy/fFSAk4vPCf7a5CBkwA1yQOHbro7vn+90Sz
 jMKlapxcaL0gccxiAjJH7oV/zX3vsO1/Vftgmg1bwlxkG0ub1IjQUgXT4emxF8yf5IZWt6XMDyQ
 gloeiMnsr2khHPdKqOVf/W9caIyeKo35kz2efAahex7deF1uqmnxyJ6SN6HdxDdfnDT1I7Ujac5
 WpuHn39RKDGC0qVvM2xjcDpiitdTJ/q8r8lmMKLaO3QyHQMUH0Vnyi80RfXLT4AFcXeflfau58j
 pJ+7OmwQzIiw0S8osynV15QGifILOugGqyLbzxPa9+7lGbDbbncXewPIH1Q==
X-Received: by 2002:a05:600c:1ca8:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-4778fd80818mr44736285e9.1.1763136521084; 
 Fri, 14 Nov 2025 08:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuU7WKq09pGWqWRejpTFWGmqebgQU5IXSJ01osphVrAGjEpDyQj7xmQTAEIuPk6jCotq5bQw==
X-Received: by 2002:a05:600c:1ca8:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-4778fd80818mr44735805e9.1.1763136520654; 
 Fri, 14 Nov 2025 08:08:40 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcf75b8sm50174775e9.1.2025.11.14.08.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 08:08:40 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 14 Nov 2025 17:08:39 +0100
Message-Id: <DE8JQF94AKJ2.1CIDLJCBTDLIB@redhat.com>
Cc: <dev@dpdk.org>, "Christophe Fontaine" <cfontain@redhat.com>,
 <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
User-Agent: aerc/0.21.0-27-g605fd3b39ccd-dirty
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
In-Reply-To: <20251114080532.1e86d13e@phoenix>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 39Puke90V4P18l9kFengcTfMNNFLkMTCABJnI1QXns0_1763136527
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

Stephen Hemminger, Nov 14, 2025 at 17:05:
> On Fri, 14 Nov 2025 11:57:53 +0100
> Robin Jarry <rjarry@redhat.com> wrote:
>
>> diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
>> index cfc550940306..e4642c9a39d9 100644
>> --- a/app/test/test_net_ip6.c
>> +++ b/app/test/test_net_ip6.c
>> @@ -160,7 +160,7 @@ test_ipv6_llocal_from_ethernet(void)
>>  {
>>  =09const struct rte_ether_addr local_mac =3D {{0x04, 0x7b, 0xcb, 0x5c, =
0x08, 0x44}};
>>  =09const struct rte_ipv6_addr local_ip =3D
>> -=09=09RTE_IPV6(0xfe80, 0, 0, 0, 0x047b, 0xcbff, 0xfe5c, 0x0844);
>> +=09=09RTE_IPV6(0xfe80, 0, 0, 0, 0x067b, 0xcbff, 0xfe5c, 0x0844);
>>  =09struct rte_ipv6_addr ip;
>
> Reading the kernel source there is also special handling to include devic=
e
> id into link local address. This is to handle corner case where multiple =
network
> cards have same hardware MAC address.
>
> Perhaps DPDK should roll port id into link local address?

We discussed about this but it would break the API since you would need
to pass an additional parameter to this function.

And also, I couldn't find anything in the RFC that describes what the
kernel does with device IDs. Nothing mentions if the device id should be
big or little endian, etc.

I don't mind changing the API though but it seems very opinionated.

--=20
Robin

> Contest void where prohibited by law.

