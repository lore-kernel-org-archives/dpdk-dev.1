Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D4CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72942402E7;
	Fri, 16 Oct 2026 17:56:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AE6864026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792166168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqc+nLHtMga57iwRemuqUrkAIc0EKVqwGfE9TZ1NODE=;
 b=c88F7ldEDBBO86viXcWZLRQ92m2JwgQmkn5E+FvY+TM9dO66isd3IJcEpF+ZM/14Va3JqC
 oYYKs3QV2uayVREqzTskcYFTgZev1X68QIwoaXK2f3181oUiFrWUIMx2BZJFEd30JXRdrH
 xt1lJLBP50sR7qweTeVJwrIxRX7IlIA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Ug3s__NfPaCrrMc6Qzvn5Q-1; Fri, 16 Oct 2026 15:56:06 +0000
X-MC-Unique: Ug3s__NfPaCrrMc6Qzvn5Q-1
X-Mimecast-MFC-AGG-ID: Ug3s__NfPaCrrMc6Qzvn5Q_1792166166
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so704951f8f.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166165; x=1792770965;
 h=in-reply-to:references:user-agent:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2x2oFS8P+r/TfRcdwddrCBqvj4B2WslgaKHBYc2fvaM=;
 b=jIPYT222CAInYsIsZ2CEJmX/l9HA86y62UlBT3WO21i5PVvXSwaVfWNtdgsNnLmtEC
 Untp/+ABgl7pq1TuwgCV5dAWsNzjNop6lcDOQIWWGwfR0huOVYYZTyaf0aGylHOqJSQi
 OyY3OvvvoqMisbuCanoQwUEIvzVzyMtDGqBDUqoYyPNMvRhq8WK4YkhssCiStlLCVnbR
 X8qh5jx4IfQNTtTmVrzFPvwaoNcIalD08k5VAoiffWO1akqwFvab7N0H2D/47akpOJ3C
 jZlsbaE37+wSRrc4Opk6V186y1yI1JDiODzyratoalOrX6IGD0x2SOsuiI9kReKAETvl
 5qwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRw5hWN8iqzPlhtDZ7M+Sv+iz1ouCchPfRUy6+LMqPK7S1dbPS2NhGipYmzK42xyyl5/4=@dpdk.org
X-Gm-Message-State: AFq9FYKsxFJS6eSNp81Fh9NfxQFf3l0VGo2UIu2d5+9llHmgTR6Kb79a
 iFHNEDfXejFJKyZNtCZkOf6HLhHxIPoIW46IDtJC3hAr/VikfRSrMVLMWJrvytozvZaSbE6Bxt+
 XF0f7xN6za3mQjHMbrS2NBOG/brWMYHO7ovS5SKa3dKwmaW+4KP49
X-Gm-Gg: AYBFou2olB+baww2sjFttj4PJCgpIIpq7y52LjcyLAk/tX5FPDVQDbaapJVTOFAQEa2
 NUNH6m9ILCmK7z9vSIJdWMmcibhjCUsdGLGkzx6hEMgsHrvv5GsvZc+IovWFDEmgKDG2mmI7hJY
 +dZ4wjXGSk3e6sGDV0FPpHX+kC+FHZkZ38owspXxQ9bJYK8G/S1Id+qXEaKTBggoxbl63ih4NaZ
 tbZ7uNhjteuo7qO4nhkhzNM2pfJhGr/F24Zy8fQfI6jWAanMOvv56HJWmw4ntOHl/W3+gAMnyxM
 jSd6qmyCabY0V65O8Gy+wWrqIoCy3Qa7iv6fgbyaWTyiK6dnB5JCrjT4lD59/n5Fjs5oDVqy0f8
 ZYfArbxTAGDA0xz1AyMKadJ0tIpCQJi3DEr45S0XdREXmDA==
X-Received: by 2002:a05:600c:19d2:b0:4a1:a7f8:c124 with SMTP id
 5b1f17b1804b1-4a1d75fd58amr4814025e9.7.1792166165578; 
 Fri, 16 Oct 2026 08:56:05 -0700 (PDT)
X-Received: by 2002:a05:600c:19d2:b0:4a1:a7f8:c124 with SMTP id
 5b1f17b1804b1-4a1d75fd58amr4813545e9.7.1792166165112; 
 Fri, 16 Oct 2026 08:56:05 -0700 (PDT)
Received: from localhost (92-184-107-212.mobile.fr.orangecustomers.net.
 [92.184.107.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce325107sm49922635e9.3.2026.10.16.08.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 08:56:04 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 16 Oct 2026 17:56:03 +0200
Message-Id: <DM6DVTPQVKBJ.16GPH4JSTG0K2@redhat.com>
Subject: Re: [PATCH dpdk] fib,rib: implement full network order support for
 IPv4
From: "Robin Jarry" <rjarry@redhat.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20260518083935.15173-3-rjarry@redhat.com>
 <1263b2cc-6fc6-4b85-b542-6764c2a66825@intel.com>
In-Reply-To: <1263b2cc-6fc6-4b85-b542-6764c2a66825@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ch0myolzJTTnURXZ_EkFEkRoC5_F3zuEVWvsxAD_nOM_1792166166
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

Hi Vladimir,

Sorry for the late reply, your email was in spam...

Medvedkin, Vladimir, Sep 30, 2026 at 19:12:
> Hi Robin,
>
> Thanks for the patch.
>
> check-git-log.sh reports
> Wrong headline format:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 fib,rib: implement full network order suppor=
t for IPv4
> could you please split for 2 patches?

I will try. The changes are intertwined somehow.

> A few comments inline.
> Also reflect changes in release notes please.

Ack.

>> +=09ret =3D rte_fib_add(fib, ip_be, 24, nh_set);
>> +=09RTE_TEST_ASSERT(ret =3D=3D 0, "Failed to add route\n");
> it is probably worth to add an extra more specific route to better=20
> coverage. Or keep RIB in host order and byteswap inside the=20
> rte_fib_add() as I suggested below

>> +int32_t
>> +test_network_order(void)
>> +{
>> +=09struct rte_rib *rib =3D NULL;
>> +=09struct rte_rib_node *node;
>> +=09struct rte_rib_conf config;
>> +
>> +=09uint32_t ip_he =3D RTE_IPV4(192, 0, 2, 0);
> just a nit: ip_he does it stands for "host endian"? ip_ho instead for=20
> "host order"?

Yes, to match with be (Big Endian).

>> +/*
>> + * modify_fib operates in host byte order. When the RIB carries the
>> + * network-order flag, rte_rib_get_nxt/rte_rib_get_ip return addresses
>
> nit: rte_rib_get_nxt() does not return address directly. It accepts it as=
 an argument

I will rephrase that comment.

>> +=09rib_conf.flags =3D (conf->flags & RTE_FIB_F_NETWORK_ORDER) ?
>> +=09=09RTE_RIB_F_NETWORK_ORDER : 0;
> do we really need to align the RIB and FIB byte order? Since the RIB=20
> structure is internal, why not keep it in host order and byteswap just=20
> once at the API boundary, i.e. in _fib_add/del? In that case, we=20
> wouldn=E2=80=99t need to touch the internal algorithm-specific code (dir2=
4_8).=20
> This would make things an order of magnitude simpler and cleaner.

Yes, because the control plane will iterate over the RIB and will expect
addresses to be in a consistent endianness.

Honestly, I would really prefer if that host-order thing was only an
internal implementation detail of the FIB algorithm and that *all* user
facing APIs only dealt with *network order* addresses.

But that would be a hard-break of the ABI. Would that be so terrible?
Who reasonably needs IPv4 host-order addresses for real world
applications?

>> -/** If set, fib lookup is expecting IPv4 address in network byte order =
*/
>> -#define RTE_FIB_F_LOOKUP_NETWORK_ORDER 1
>> -#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_LOOKUP_NETWORK_ORDER)
>> +/** If set, all user-facing IPv4 addresses are in network byte order */
>> +#define RTE_FIB_F_NETWORK_ORDER 1
>> +#define RTE_FIB_F_LOOKUP_NETWORK_ORDER \
>> +=09(RTE_DEPRECATED(RTE_FIB_F_LOOKUP_NETWORK_ORDER) RTE_FIB_F_NETWORK_OR=
DER)
> I'd suggest to keep 2 flags at the moment - the old one just for lookup=
=20
> and a new one for lookup and control plane operations

OK, depending on your decision on my previous question, I'll change
accordingly.

>> +#define RIB_NODE_NET_ORDER=092
> RTE_RIB_NET_ORDER_NODE, just to avoid confusion with current naming?=20
> Also since this is a bit flag it would be better to define it via bit=20
> shift instead of a power of 2 digit

OK, same thing as above. If we can decide to change all user-facing APIs
to big-endian, we don't need this flag ;)

>> +=09if (node->flag & RIB_NODE_NET_ORDER)
>> +=09=09*ip =3D rte_cpu_to_be_32(*ip);
> plz reflect this change of behavior in doxygen

Ditto.

>> --- a/lib/rib/rte_rib.h
>> +++ b/lib/rib/rte_rib.h
>> @@ -17,6 +17,7 @@
>>   #include <stdlib.h>
>>   #include <stdint.h>
>>  =20
>> +#include <rte_byteorder.h>
> why include it here in .h?

I need to revisit this patch. I don't remember.

>> +/** If set, all user-facing IPv4 addresses are in network byte order */
>> +#define RTE_RIB_F_NETWORK_ORDER 1
>> +
>>   /** RIB configuration structure */
>>   struct rte_rib_conf {
>>   =09/**
>> @@ -46,6 +50,7 @@ struct rte_rib_conf {
>>   =09size_t=09ext_sz;
>>   =09/* size of rte_rib_node's pool */
>>   =09int=09max_nodes;
>> +=09unsigned int flags; /**< Optional feature flags from RTE_RIB_F_* */
> old tests (and all possible places we're using rte_rib_conf struct)=20
> should be updated to account for this new flag

I thought I had updated all sites, but I will make a sweep.

Thanks for the review.

--=20
Robin

# Contains a substantial amount of non-tobacco ingredients.

