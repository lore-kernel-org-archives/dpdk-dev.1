Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49352CF34B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 14:42:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5172540267;
	Wed, 19 Nov 2025 15:42:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F295B40262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 15:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763563366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blSweLmLEC50GPF4V700MwSYM5ZXGBhUa8g4RsrAHcE=;
 b=W1xGhHnj4zBj0BFvEpFsOF1iw9CtqSehR2DaSn2v/7g8c2z+0AA0I/Se4abvjrGyYm0xfi
 Zyo1RLC9s/PuL91borpIbQJg6vUdUbbKDFovzM+LTX7j5PawXlaQ8p/YI56WZFGfGKSxzq
 vofWi1/K+5XhZo2AwIzj78S+nZ4+PII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-w6FDkRaMPJmCmkUiKhD3VQ-1; Wed, 19 Nov 2025 09:42:44 -0500
X-MC-Unique: w6FDkRaMPJmCmkUiKhD3VQ-1
X-Mimecast-MFC-AGG-ID: w6FDkRaMPJmCmkUiKhD3VQ_1763563362
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47799717212so37520375e9.3
 for <dev@dpdk.org>; Wed, 19 Nov 2025 06:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563362; x=1764168162;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blSweLmLEC50GPF4V700MwSYM5ZXGBhUa8g4RsrAHcE=;
 b=dz9UNBhMVYu9x1bRjVS0IkrXfCq9qioaO1KSkMX0JzPC7s/NHbrTfo7KK1GVBef9wj
 a/fvttIwX1waY0VtcRIiL3qY8YfiuY5BlZRwO+jzQcBACmSMwTVcYoSBI2SaNnfMxBMP
 Igv+2YVDT/QLHMlWGp0bxdRP5BTpkz16MBwH1Z0MgPNGk30bAMc2XTfMQqvgyXfhixZM
 SKgbpuoDWmlfKvrDPYNHgtPDJPVHYJweHySztzYCGyWeRi0a1yRVj85DYq27ETtHsqg3
 Ld6pwKhycO7610DsKKHtJxx+co6g1ysTPWtrTK1sg/YUaO1itfdZ0BnDgkZrMbYMbWGe
 yhtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhWyH58TMY2CCB879K5nGKx3JiMuMKGzABAH+/p1iDd2Q6jwuxWZvliTPdH9ecf4fx4iA=@dpdk.org
X-Gm-Message-State: AOJu0Yx/Fm+K36OXhPXVPTlouD+FTe1hK1CF62pmqvvOpXTipNK+6R/p
 NEkQiYnovWreOxqmFzx+3ESxhgZ9ybM8l5sMINj0dhMBVwgcBVtYN8TN6m9efjd/3O+4+yIXCFJ
 aFCkdAcpQIMjnSHJMT7VM4sJ68sIjcA9yNc8b7DoCOz2R
X-Gm-Gg: ASbGncsBoEtn8CoZsIRT9NXIdKOCSEf2jGeIEA2lQ+ScFeg6pExahxoeESRxnwMKSvC
 ta/lfO46k+qpRCc+Wqxifs/WewNElHGOmVN8XmUZ9YDNk7htNKdbS6giLihKzegW1HAX1k7y9HM
 fVuJEBhTf2oxamUFRsGuf7AFmSOS68WAlDsDEHW0gJWFaicdXgVTCMDc+EIJTl/wsA3K9T+kx1e
 1VLMlDdaWmxy0mYL1MwtuPxRW+WAtj/q9n64psgMnZtB6znQQ8nIY9k0u51FmNbzSDJ9WzkXXYF
 PoFkUhEfdLzpBuiul1yNky22cVXLToJV7hagZvz4J9G5RokND4BqZURkQnUVeZYy4/0VCnjZFXT
 mQLU2sfbYtXVKTLvxtjs3OdfpYXyCCkM/vGuy/ORSuAbtQb7Z+qPwusdDbD73ayVsKR5X
X-Received: by 2002:a05:600c:4f07:b0:477:63b5:6f3a with SMTP id
 5b1f17b1804b1-4778fead9a4mr191839615e9.27.1763563362099; 
 Wed, 19 Nov 2025 06:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7YipzOw7j2+Oxh6zu9NJAvOkx95S7VVbmIlSfWU3zxg00wNBqVjbDs+R2c5daxIWzqCpv2A==
X-Received: by 2002:a05:600c:4f07:b0:477:63b5:6f3a with SMTP id
 5b1f17b1804b1-4778fead9a4mr191839305e9.27.1763563361650; 
 Wed, 19 Nov 2025 06:42:41 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1035c78sm51807145e9.11.2025.11.19.06.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 06:42:41 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 19 Nov 2025 15:42:40 +0100
Message-Id: <DECR1BBB72GY.3CA5B6PY8ORGW@redhat.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <stable@dpdk.org>,
 <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, "Christophe Fontaine"
 <cfontain@redhat.com>
Subject: Re: [PATCH dpdk v2] net: ipv6 link local compliance with rfc 4291
User-Agent: aerc/0.21.0-33-gc811101f9a96
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251118174526.321856-1-rjarry@redhat.com> <3249247.iZASKD2KPV@thomas>
 <4832942.kQq0lBPeGt@thomas>
In-Reply-To: <4832942.kQq0lBPeGt@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vMRtPXDvC9o5KwwTdvAQfRJQQGvScE2A20WugjH81vQ_1763563362
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

Thomas Monjalon, Nov 19, 2025 at 01:27:
> After checking with Stephen, it appears that XOR is really desired.
> This bit must be inverted, so 0 is local and 1 is universal.
>
> Adding this comment in the code to avoid confusion in future:
>     /*
>      * The "u" bit (universal/local bit in IEEE EUI-64 terminology)
>      * must be inverted for IPv6 link local address.
>      * 0 means local scope, 1 means universal scope.
>      */
>
> Applied, thanks.

Thanks Thomas.

That XOR is described in the RFCs as "flipping the 'u' bit". I.e. the
bit should be 1 if the address is "global/universal" and 0 if the
address is "local/administratively configured".

Here's the corresponding code in Linux and BSD:

https://github.com/torvalds/linux/blob/v6.17/include/net/addrconf.h#L201

https://github.com/freebsd/freebsd-src/blob/release/14.3.0/sys/netinet6/in6=
_ifattach.c#L97

--=20
Robin

> No animals were injured.

