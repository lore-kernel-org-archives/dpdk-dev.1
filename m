Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B254EB7ED5
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A78E9402A9;
	Wed,  4 Mar 2026 12:45:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F1F434003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772624755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPz1hpSmIgrHBfWoPoJEAaUKqXgYajepenr+t/AD5Do=;
 b=BMtLVQqf7Epc3M5qCrUihF6DnbjZ9qFcxzmIr2dDa5O90zJqOOusincEe3wHKGMOD5E0T/
 nBojBJ33UMlBKKsShiTuPWeYnWFD3uCDwtxGSnIitSW1VxvswRyeVGWEL9xuiTH2isbCkM
 DMM1vT69xL8UYj4JLvYexC8LbNLyWoA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-45pOO-DkNNigWQ2LZzmjlA-1; Wed, 04 Mar 2026 06:45:54 -0500
X-MC-Unique: 45pOO-DkNNigWQ2LZzmjlA-1
X-Mimecast-MFC-AGG-ID: 45pOO-DkNNigWQ2LZzmjlA_1772624753
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439c4d71603so620060f8f.0
 for <dev@dpdk.org>; Wed, 04 Mar 2026 03:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772624753; x=1773229553;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nDFl4DPq8yYfAV15eqrplRXu66g/IJXUGad0WfBJ30=;
 b=By20kMwSwTyNH+buOnirP35yJHTrVzuQq3c0JyiVNj9MHiZ+9KQrrghEAuu/erG65M
 MoH6/aX6InPzyHEJwRDnXA/6FYuAfS53cXFeePsWWkF+ftDwjj9U95Ru2eXTFtxn9Ei0
 1sBL0aAcplZOrDe+HNaYCED1fyRS+XCIIke/7rckcENWMtomHJ044xPEp/JUbLLpfxXF
 NMU3ImYTo0gkyJEokJorbXam0bn2EfdB+FDG0EKbgcUPI4U4X+KIQTN6DoIaVgP/UHT+
 bJvbscnZ5yfBQWZN0vXAAUwX2HK6EZkbjzROCsvyzDhrivfTrO5ErkrgybA2jXSX4XQj
 eGew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoMOZPeQE3ELk2EvXxnWbrYJSLpIWCpERRxOtIodeuwjR1wZydSLjg4yRzdWcV1H3WuzM=@dpdk.org
X-Gm-Message-State: AOJu0Yw4aYjdCJnraP7XKBl1EGVaIcUAy0wli+5XttN+Nz+/hLGYebmZ
 wQRKj+LdG8c5sfZsHDS3VCKxgqbgyFMW+E8Qg10Tuv5/7fLd2mnjwiYLVNMd32nNDXdWkVCM8zU
 4fWUenikhZaPwZc9RMHj1k5Xt6hj1BL4JW/9iN1L7z9TmeaV8CPs+
X-Gm-Gg: ATEYQzzq1xPbsCFmVZ9vjVKBdMJeI7b/pWQ8PodU21d8YiYt6ePS1RR60JN/Wu/z0QP
 YMEgEnJj0E9AuUVoK33+HBPV/h3Lv1VEYr5iwUj8LWh+8Hk5xeNJuoeJVxxxicQfegi9kx+fBGB
 Io7i/ruipMcUCH7OgIEMYooYynwfYBN6E0MUS4cgfhOT7Qs7l6+dfJNuDtwcPE6wSEWYhm0S/4R
 dOsh/gORoMwfSldPh+Ns8dlrd/YCo/Q4WBM7P2gP6C8JNAjCearIBoLb/VQ6H84XZ8vUpcZ9ozC
 3/H/aBdMVstS0Pstt2K7B/Db34y025SmCtfVFLR/4uGEFfJIE28oAHZ/583e97eVlB6zNOIFV33
 51MGlT3XbAI/mE/TwEXsQkQBPVfWMlg+3iwDcD5VtCORPW4ov/ldzJ3iU5iTWT+0MTsDW6c+fS8
 LLx4F0
X-Received: by 2002:a5d:5706:0:b0:439:c8f2:5717 with SMTP id
 ffacd0b85a97d-439c8f258d3mr2345195f8f.6.1772624752987; 
 Wed, 04 Mar 2026 03:45:52 -0800 (PST)
X-Received: by 2002:a5d:5706:0:b0:439:c8f2:5717 with SMTP id
 ffacd0b85a97d-439c8f258d3mr2345151f8f.6.1772624752546; 
 Wed, 04 Mar 2026 03:45:52 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b59723fesm23949060f8f.38.2026.03.04.03.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 03:45:52 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 04 Mar 2026 12:45:51 +0100
Message-Id: <DGTZ14W21JCH.3PCYCDEHF1XGF@redhat.com>
Subject: Re: [PATCH dpdk v2 2/3] hash: free replaced data on overwrite when
 RCU is configured
Cc: "Stephen Hemminger" <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Yipeng Wang" <yipeng1.wang@intel.com>, "Sameh Gobriel"
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
User-Agent: aerc/0.21.0-98-g3a0874577a2a
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
 <20260213103441.1505659-3-rjarry@redhat.com>
 <2630d756f843466dbe1da67f2a65c7d7@huawei.com>
In-Reply-To: <2630d756f843466dbe1da67f2a65c7d7@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q7p-k4czCH1H3nQpSIUir_gKxnWFdNYmbNnKAZKkO2Q_1772624753
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

Hi Konstantin,

Konstantin Ananyev, Mar 04, 2026 at 12:40:
>> @@ -776,6 +778,8 @@ search_and_update(const struct rte_hash *h, void *da=
ta,
>> const void *key,
>>  =09=09=09k =3D (struct rte_hash_key *) ((char *)keys +
>>  =09=09=09=09=09bkt->key_idx[i] * h->key_entry_size);
>>  =09=09=09if (rte_hash_cmp_eq(key, k->key, h) =3D=3D 0) {
>> +=09=09=09=09if (old_data !=3D NULL)
>> +=09=09=09=09=09*old_data =3D k->pdata;
>
> For consistency, shouldn't we use here instead of load/store:
> *old_data =3D rte_atomic_exchange_explicit(&k->pdata, data, ...);
> ?

Yes, that makes sense. I'll send that in a v3.

>> @@ -1263,6 +1304,11 @@ __rte_hash_add_key_with_hash(const struct rte_has=
h
>> *h, const void *key,
>>  =09__hash_rw_writer_unlock(h);
>>  =09return slot_id - 1;
>
> With multiple goto labels that function becomes even more complicated.
> Can we just add old_data as an extra parameter:=20
> __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
>                    hash_sig_t sig, void *data, void **old_data)
> And make the callers to invoke __hash_rcu_auto_free_old_data()?

I'll see what I can do for v3.

Thanks for the review!

