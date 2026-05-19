Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D877CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73E49402F2;
	Tue, 19 May 2026 11:17:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3AA9240296
 for <dev@dpdk.org>; Tue, 19 May 2026 11:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779182269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUB3pRJIYW7i2cu5/MQDl9ZFZqI8hADxzQVYBhLK0O8=;
 b=hGF93u7dyfAe4AJHLS0hoFBzlfmWqQCBhl6NV+eoNQs16fV0sncR6+h7dDiMKWxm2ER3D0
 xXkOoKK8miiKbBxu9jta4ZStwdEkUBfKwcwTtYe1NPDfT3GFLSwNF2hPFvvAObyvtvDBwZ
 1dcM5igZ799ect9936Bq6C0jSQftyoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-p87F3NfaP_Cukwyf4Cbagg-1; Tue, 19 May 2026 05:17:47 -0400
X-MC-Unique: p87F3NfaP_Cukwyf4Cbagg-1
X-Mimecast-MFC-AGG-ID: p87F3NfaP_Cukwyf4Cbagg_1779182267
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fdacf2616so15967855e9.3
 for <dev@dpdk.org>; Tue, 19 May 2026 02:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779182266; x=1779787066;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXJmFNb+cp0XiPbH+0Vry5ZBJ3qvGeR/IbbOAlNaBJg=;
 b=OwyZea+n3EjW9Ie2gXdFgdZMzLwWHP5KK9t/6noruhbkErC2qpW2mmEuOiATrB8ow3
 wCXRXM/VHhHCSHwmaKkNrQx2fxRIlojWEvLw+OblxrKSzQPuJpQf8rQGGTKQuyGZFkI+
 zZugvp7CP6fZzraVgHlfhVW0XDm7pOVcfreYuw7hErYYtfKLOhXW6WcdDlqaAV7v3K6i
 e8yYwURircqRFW+NGJxLBCrS8G7qdXFk8JyoqAgKfSQO7BN6PHYtm9ii7ZmNQuEUQlZT
 gy+zOFiydO1dAGG6ugpygrhJlOui2B6EYEt7l4+Mgj0g/q+Cx+hiI3iHSGKVEk8blW+2
 ZdHg==
X-Gm-Message-State: AOJu0YzLdlsbTQUsN7loqZ/mnAQ/YFx9JPSDX4Nq44SZMTM/zlUXoy/Y
 CGXPiW2n9gHFqOhoTOKkW3q+MwJ6xj1slf+Kz8gaVPvmqzelwm1IIaM9jfSA6RkEVk6EmyTpkie
 eZ4qng9av5SAHFfnB1NVhhFU6gWAsyaWp+0RwFp14Hrfr
X-Gm-Gg: Acq92OFJ+KwRGDrE/UeUAV32K9Dp0bfNT9s9e8UG+VJJWQ254fqQwI0fBkkKekbhVdp
 I62spi1jFaW7UCo2bEL7UWgTMtsMypG3qjFPXoMrkNY4+RLcb4/deFE/1ERaROLiQkAXs3lrcnK
 g1NetNwH5ZJ9BZXnv34OaGFdWCHwzBfCzaRUAtD8aM2ojGOJyJN/emmcuxEvvfTvCII0p1iPtEI
 89mzLwMutJtlLjLgmV+AvV+SEAkgx+8vwYJuPeh4bIsM7A257/97wI03XjWVqALJUSkXFxcea1J
 9WIbo099H1yA8gUY6WOmATh2WtzJ5/gywb+of82kgN7af2eL0u3N+azjjxXrR9vBtBTWcWh7vYr
 X11GiTg/6RKTJCWMGgTg5BhjwTBgDIp1AQuEY0/1TJOKEZIqsjSICaju6Ec+Q18If8N6gKhuAxG
 Z32mY=
X-Received: by 2002:a05:600c:c494:b0:48e:706b:53e8 with SMTP id
 5b1f17b1804b1-48fe60ecd88mr271623005e9.11.1779182266603; 
 Tue, 19 May 2026 02:17:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:48e:706b:53e8 with SMTP id
 5b1f17b1804b1-48fe60ecd88mr271622565e9.11.1779182266139; 
 Tue, 19 May 2026 02:17:46 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53804aesm296281205e9.15.2026.05.19.02.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:17:45 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 19 May 2026 11:17:44 +0200
Message-Id: <DIMJH4P7RJRX.3PUWC7L1KC4I8@redhat.com>
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>, "Thomas Monjalon"
 <thomas@monjalon.net>
User-Agent: aerc/0.21.0-151-g204ee0bf378b
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
 <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
 <kagkiNyiQQ67llvhX0AB8g@monjalon.net>
 <agswGt0gN-edMzjZ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <agswGt0gN-edMzjZ@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jGjpnZsjdNhxc_lj4JqgTNMqKaXQ_jYbsyNaHd0bPXo_1779182267
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

Bruce Richardson, May 18, 2026 at 17:28:
> On Mon, May 18, 2026 at 05:25:43PM +0200, Thomas Monjalon wrote:
>> 18/05/2026 17:14, Robin Jarry:
>> > Hey Thomas,
>> >=20
>> > Thomas Monjalon, May 18, 2026 at 17:07:
>
> <snip>
>
>>=20
>> [...]
>> > > @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unloc=
k(rte_spinlock_recursive_t *slr)
>> > >  =09__rte_no_thread_safety_analysis
>> > >  {
>> > >  =09if (--(slr->count) =3D=3D 0) {
>> >=20
>> > This code is completely broken. Any thread can unlock without any chec=
k.
>>=20
>> Maybe, but I don't intend to fix recursive unlock in this patch.
>> The subject is "remove volatile qualifier" (and unblock GCC 16).
>>=20
> As with regular mutexes, threads should not go around unlocking when not
> holding the lock. Therefore, I think this is fine. [With regular spinlock=
s
> we can't check since we don't track threads, therefore I think we just ne=
ed
> to assume a well-behaved app.]

Ok, fair enough :)

As Stephen suggested, maybe we could add some assertions?

 static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t =
*slr)
        __rte_no_thread_safety_analysis
 {
+       RTE_ASSERT(rte_atomic_load_explicit(&slr->user, rte_memory_order_re=
laxed) =3D=3D rte_gettid());
+       RTE_ASSERT(slr->count > 0);
+

