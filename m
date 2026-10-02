Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40991CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51F3740281;
	Fri,  2 Oct 2026 11:52:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F5B24003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSWUWymKSZnnNdPGcfjF9U54bJFSdVLwmKO+s9wqgKA=;
 b=i284VzIc9n2FT8ym2J847mo+LRIOPriOu8Ytqgu45OnHm/xlVW8y92smmSUyjWUWToVKbY
 OIgpOeTKE2ggTgkiF1gKgz2JDJZVJK250lR0F0aozTT4xul3V5PhaulHLfbBJ6Wu7EeHNF
 b7ZLLnQpvZYzpE4IthqeE+Cmq+pU3bo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Ul9u6flJMbOSp2O0kxKOKw-1; Fri, 02 Oct 2026 05:52:07 -0400
X-MC-Unique: Ul9u6flJMbOSp2O0kxKOKw-1
X-Mimecast-MFC-AGG-ID: Ul9u6flJMbOSp2O0kxKOKw_1790934726
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so28693475e9.3
 for <dev@dpdk.org>; Fri, 02 Oct 2026 02:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934726; x=1791539526;
 h=in-reply-to:references:user-agent:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwFjP6s25o+gcGlyJOin/qKDwBM8Tiv3tYI/lvolH6o=;
 b=G1/6SXhEF++dwxOhmmoFOskfOFxGcQoezCA9su68dZ7fO7XKh5P++blDM/Ym45z4d5
 /NR2JzI/U7GIrOQwkR6Xaa3Z5EAXc9WFWdA2KYpR0oNt/JO8C/DPKKP+mbnkcMT1+31p
 yR/xqOCc3bfdIkBPZpneewf5QhcdqSxpte8gRyZbYRBHAGDy7rSZXbwAQsnLFTyZ6mvL
 XTGQMyf0MkxNfHdscGiHnjvqquFuSUOOLAetGfxdlT7hKg70rpM3haug4RU+nouQy/Td
 RGkuhXgVe7rDSafW7baljhWRDt8AAsOQz8T1Xqszg6mUf0UgJw1nu7dsaQVbcDuEllPu
 j1XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdRAueG1NT8iq9+vvcTwVT83bRuyBzya9RVoJLAYMvxQ+nYKdvUEsaXRm4VrmrVjmghi8=@dpdk.org
X-Gm-Message-State: AFuF++lOPC2ndw/QmDLfN6WoAJWBPl/ZgB+Wotropf1o6vKylRV1EeiD
 NkgSSqItQMAI4URQ67ng+bS++CJPLdDvEHElscaEdieFdSY4QOMmJDISXUuq8DWzPszkWY68zJa
 PgvyCFmME9xSwINcpNaBHto/W9e+HyjLP/5brIlSX16O9
X-Gm-Gg: AYBFou1N9tG4LOCiijFKJ6rVBH39zq9csHep7HhDURLKkhoCsNsFt3gdbyNFvo7kqth
 08e8KCJT3RL35q4acaOSrFIUSL5GectLc3L/dy7Ru7JTezCzqXL4KaJjLz9gYYdAr9Jxlns0y9K
 /3s4eCEmFDUrlNNCyFWgB78b63icR4tbMO//fySQOD7XiNT5PxqBUvX4OLBhHw9ggd6xbua8u0U
 I3tRpMply4Qli2pWQLki/nEu9LFklLsMuw5jBFiMWk4MLQfMYal7JOLJOLtk7oCkpPiqh0jbeyQ
 7LsaIZPFqX8tmoCnnudET9e5oAVm3JRRG+c7Bv8cJt+UOdY5wsJmxRUlxmkhkxEhzbYgaw7D9JI
 P1VNEP6bFrHCJGBry6uGRKgiJffHs+hAjeXYd7d9mHcnc8me7TXOgk/FX
X-Received: by 2002:a05:600c:154c:b0:49f:fe88:e7d1 with SMTP id
 5b1f17b1804b1-4a02769c438mr44155535e9.15.1790934726099; 
 Fri, 02 Oct 2026 02:52:06 -0700 (PDT)
X-Received: by 2002:a05:600c:154c:b0:49f:fe88:e7d1 with SMTP id
 5b1f17b1804b1-4a02769c438mr44155035e9.15.1790934725557; 
 Fri, 02 Oct 2026 02:52:05 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027734b49sm71037075e9.10.2026.10.02.02.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 02:52:05 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 02 Oct 2026 11:52:04 +0200
Message-Id: <DLU9DICBGKSG.33GNI17ECCFMF@redhat.com>
Subject: Re: [PATCH dpdk 1/2] rib: rename nxt flag parameter to mode
From: "Robin Jarry" <rjarry@redhat.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20260518095900.29655-7-rjarry@redhat.com>
 <0d7b6397-3df9-4741-a052-fb8d06671307@intel.com>
In-Reply-To: <0d7b6397-3df9-4741-a052-fb8d06671307@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0-7PzzJQ7rQGT_AL524I8nsuJoiKzLLeEY2hKtTMof0_1790934726
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

Medvedkin, Vladimir, Sep 30, 2026 at 19:12:
> Hi Robin,
>
> As a general comment, do we really need these changes? ABI policy=20
> recommends not to do so
>
> https://doc.dpdk.org/guides-26.07/contributing/abi_policy.html#abi-change=
s
>
> " Change the API only for significant reasons, such as performance=20
> enhancements. Avoid API breakages due to changes such as reorganizing=20
> public structure fields for aesthetic or readability purposes."

It isn't imperative, but since it does not break neither the API nor the
ABI: the enums are int and their names didn't change, I thought it would
be a nice clarification.

>> @@ -26,11 +26,11 @@ extern "C" {
>>   /**
>>    * rte_rib_get_nxt() flags
> mode instead of flags
>>    */
>> -enum {
>> -=09/** flag to get all subroutes in a RIB tree */
>> +enum rte_rib_nxt_mode {
> rte_rib_get_nxt_mode?

Ack

>> @@ -25,13 +25,13 @@ extern "C" {
>>   #define RTE_RIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZ=
E) RTE_IPV6_ADDR_SIZE)
>>  =20
>>   /**
>> - * rte_rib6_get_nxt() flags
>> + * rte_rib6_get_nxt() mode
>>    */
>> -enum {
>> -=09/** flag to get all subroutes in a RIB tree */
>> +enum rte_rib6_nxt_mode {
> rte_rib6_get_nxt_mode?

Ack.

--=20
Robin

# Membership dues are not refundable.

