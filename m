Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41331CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C25140281;
	Fri,  2 Oct 2026 11:50:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F3FAE4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xe/0tka4jQr0vrzNR6/PqyjkBS5MPk2EpXFmSTvYbYk=;
 b=JVnaV3KT3B1hWjkVFFst7zR3h9WpTsvtx9CJSEXsnp22pUu47QDriPu+1hP2mbXEHPFPiX
 dE6LC5+4KzSmSFXNeNmQtY/tqA0L+HM6UNRK6fRThMUPOo0RSGBMrHF046sQyYcC+Pkr0V
 WxnEty0eLaK81pyMpwrPfr2yFaHuYBg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-DU0FC4oqM4urYzw6OKFPmQ-1; Fri, 02 Oct 2026 05:50:07 -0400
X-MC-Unique: DU0FC4oqM4urYzw6OKFPmQ-1
X-Mimecast-MFC-AGG-ID: DU0FC4oqM4urYzw6OKFPmQ_1790934606
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486f1ecf9bbso2461623f8f.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 02:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934606; x=1791539406;
 h=in-reply-to:references:user-agent:subject:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1d8tVMg5QBzTt34H2YFMS/oUEa8Lpg5zan53bIQ4R4Q=;
 b=HTpI269CXlEZ1I2Fm8nGlCZQLACarNaom54G35Dl2AThaoDH8hdlJIhJdSOiaevaTG
 SnCQreCKcqcMaZPVvQfDHM0COVh8KBDqmtsPGZMPBwjgc0v02biOU/WdlZuPOysP/Eop
 DSHrAEvJAQSlbBxlUxuVQlfLeW1y+6Yz4NTFRZsTiNWpvO4fgsMdxHJC5edlZ+sBfAXq
 EHc8IGo7hlDJjMyuuzc1t63+Rsd/BjFtQkSXbJc+CiBv9/s/EhzD6oGUav9FxNoEFzTK
 29BXNVch2o61uXYlUnU8CdDs47FgCypVf39Z++WlRwc2kz9j2btG5lrdN+ZGwUCDDtUI
 4C4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh0vRtu3aHkjpvHcdXAEHcNrUkxvUL+24VbgYbYHdLNVNUFlwoiK0s6jwE8TMOVfVrDr0=@dpdk.org
X-Gm-Message-State: AFq9FYJDiLA12GQeyKP7i3+zaD7aXYf4LXa+7bmnK3wxPr9u3uZNnzUK
 K9GmQxG0v3qf70Kf7IPqN6N1fZxOtUm6OP5j5cVRjHTArzPt9SdE85e6/YoZj+9CnHqhX+w/zkg
 6KMDSFJkPNOZECazsP8o1idwbBD0lSjIXu05lPk3vAm0LAWArYjqa
X-Gm-Gg: AYBFou3odZUphfSVddxTvFOikQ0CJNeqJd3WdwaM/V5W4/HJSrK/24XuF76BghRq+R1
 ofWzW4d29c6umzudFc1t0zhlX+JZz5tHX73j3ugMxVVvLMD6cKQcBoO03AN3ysRMxCQel5JyNJR
 ItSLvXm77gX3uOC6BHnJxFZOSs3Rwj5F14GotQUy0IdZduTDNGb9dWb8Pw55W/2O/s10iod/l8A
 wrtjphZUbFOt5awepf1KexbU6a4r8LiAQBjvIk8gC8xxzas1xudV96npvX51qKt9i2k8YcJLC8Y
 +FjfMYLXaNkiGd2UrRXp3z214yq4IiH/a2uxIog2uR/ghKwdmjF/NqnIhiMGTNXoANO6aMuwuRW
 7VYnVtx0ovWLmuIqyode2T8czfjGaZwc3eIn3l7wtDaWcEFubkI4dSAw7
X-Received: by 2002:a05:6000:25ea:b0:48c:4272:86b2 with SMTP id
 ffacd0b85a97d-48c42728a67mr1597636f8f.11.1790934606021; 
 Fri, 02 Oct 2026 02:50:06 -0700 (PDT)
X-Received: by 2002:a05:6000:25ea:b0:48c:4272:86b2 with SMTP id
 ffacd0b85a97d-48c42728a67mr1597575f8f.11.1790934605422; 
 Fri, 02 Oct 2026 02:50:05 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4653195f8f.40.2026.10.02.02.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 02:50:04 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 02 Oct 2026 11:50:04 +0200
Message-Id: <DLU9BZ5E8RPF.3NDFT33HJCU0W@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH dpdk 2/2] rib: add mode to include top-level route in
 traversal
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20260518095900.29655-8-rjarry@redhat.com>
 <f3fcf774-03fc-4693-986e-2684fb708bf8@intel.com>
In-Reply-To: <f3fcf774-03fc-4693-986e-2684fb708bf8@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _KsgVSQQN1IuwZEluimT-9cC7hpu7r41qDSOfMjWZSY_1790934606
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

Hey Vladimir,

Medvedkin, Vladimir, Sep 30, 2026 at 19:12:
> I'd suggest to reflect changes in release notes. Please find other=20
> comments inline.

Will do.

>> +=09while ((node =3D rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_=
ALL)) !=3D NULL)
> second arg should be &unspec
>> +=09=09num++;
>> +=09RTE_TEST_ASSERT(num =3D=3D 2, "Invalid number of routes\n");
>> +
>> +=09num =3D 0;
>> +=09node =3D NULL;
>> +=09while ((node =3D rte_rib6_get_nxt(rib, 0, 0, node, RTE_RIB6_GET_NXT_=
ALL_TOP)) !=3D NULL)
> same here

Indeed, good catch. Although for some reason, the test passes :s

>> +static bool
>> +depth_match(struct rte_rib_node *node, uint8_t depth, int flag)
>
> 3d arg enum rte_rib_nxt_mode mode?

Yes, better.

>> @@ -195,7 +203,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
>>   =09=09=09tmp =3D tmp->parent;
>>   =09=09=09if (is_valid_node(tmp) &&
>>   =09=09=09=09=09(is_covered(tmp->ip, ip, depth) &&
>> -=09=09=09=09=09(tmp->depth > depth)))
>> +=09=09=09=09=09(depth_match(tmp, depth, mode))))
> extra parenthesis, same for v6

I wanted to stick to the style of the line above which also has an
extraneous parenthesis. I'll remove it.

>> @@ -125,6 +127,8 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t i=
p, uint8_t depth);
>>    *   get all prefixes from subtrie
>>    *  -RTE_RIB_GET_NXT_COVER
>>    *   get only first more specific prefix even if it have more specific=
s
>> + *  -RTE_RIB_GET_NXT_ALL_TOP
>> + *   get the top-level exact matching prefix, if any
>
> RTE_RIB_GET_NXT_ALL_TOP is effectively RTE_RIB_GET_NXT_ALL + exact=20
> match. Better definition would be something like:
>
> get all prefixes from the subtrie, including the ip/depth prefix itself=
=20
> if present. Top prefix is returned last.

Ack.

--=20
Robin

# Prices subject to change without notice.

