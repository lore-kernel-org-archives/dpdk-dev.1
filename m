Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B8EEB7ECF
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 12:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D85402A9;
	Wed,  4 Mar 2026 13:50:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D0C804003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 13:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772628604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk4YFBlWq+vcXxMzL4Dpim3yrBMPEPprhSIKDG9Brag=;
 b=PZomJ8tSfIt4615ituvTQgHMDhzWqVQZtwdei3aErYptuKfD8JnFOEDvcXzBn0kF9A9g+J
 n5WmrXMe7nOlPys3Q1rry5si6OoR+8i4+jiW9dQ0TeOlwHCts8eS+KqQnbBPj2QrlzrtWC
 aFG2WnXPfwCyHurVx19TEElFsX/0lDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-4BPmpOlFNx22KD7t76FKvg-1; Wed, 04 Mar 2026 07:50:03 -0500
X-MC-Unique: 4BPmpOlFNx22KD7t76FKvg-1
X-Mimecast-MFC-AGG-ID: 4BPmpOlFNx22KD7t76FKvg_1772628602
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so69196665e9.1
 for <dev@dpdk.org>; Wed, 04 Mar 2026 04:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772628602; x=1773233402;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk4YFBlWq+vcXxMzL4Dpim3yrBMPEPprhSIKDG9Brag=;
 b=tvzy2xu128G6VFZKLEjXk44mOwDat7+lK3nvPx69cfRKK3pX8yk6ecea4o5Ok11Kgj
 sAz7tYhnt/NC7gQdZfizD7WUY35H1zn29GbfAPMIyXv+ZL3R/4aoMKX0/USRcr/dlDiN
 BNllcNoSBgM400m0mWnGglmH+dbfKZkR9d5P5s+k1DdFenrLm2Vvk8oS5bs7SOr1lZ/L
 mhOlGWerumzGERcWw29apFDKyI2o/pd5uIAOpd87C+RaEazKC9bI1XRnn8dZ6/ymCcnc
 95ztGS9ZRDt6tg7BG5rtF2l1WdJo5KYklprffvqEGkMfN2IOKCy+/dE2E2ERcmiXK5XX
 FVKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7pbzrs18n9O1rPseMlX3I7DfI6lPiqCuWWfrVxADRdS0oNItJoN+XpYpku7EKpTdvEow=@dpdk.org
X-Gm-Message-State: AOJu0Yxh7MxaC4NprtX5cMGUBlWfN6frsjYWswdJGpQEBsr50A6iGLZq
 /PyVwUZ7LmccskUm3cXw1gpe5TseKE+K/MVlffStq4Oz1cEoSqYBk9EZeLoqgMGo8A5bXrX3f5U
 OdEamYYIJA+eKpeNbc9bPB5QRfYhqma+J5tOYgS8NPOhV
X-Gm-Gg: ATEYQzxSeUd9HjUo5v1i124K+ltOiaBXt0KoArc8k9e1tvh4VyjBP3/4HMMj4CWfNKE
 2l99gwo2Zbc265S4Ddxtx2RcS6p0OYwIISK70x3LSXQN0zGTXCR+3DT9v7PcQn1frtvxsxtN1se
 jgvRn/UWjQdDdJmQIO2InsoKC1rqqNbMwjdcVpfuE5Ef96IYQEt+rXgyKLc62/f5psah34JTex3
 dfFQ9iaKtcq2HYhrcn7eb79WInnusT5p8A8AkxSKmUu83o7ZaYK+zHnuSllL7wTRwe+rHjutPGZ
 b4tzj+v7ik69yrSzUl8mpHF+hE3DY7tq3RGX2QyBFoHU9Xb3McJCMuUbAwru/qH0tQ+i818zCLO
 7Mn6Mk96Meo3BY0BUqD3BvGE4zegsLN0hMr76tRpb3yb60cmU2iWuVeZupE7n3owj4T/ki34zld
 GAqOXP
X-Received: by 2002:a05:600c:3542:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-485198ee3admr30364595e9.14.1772628601730; 
 Wed, 04 Mar 2026 04:50:01 -0800 (PST)
X-Received: by 2002:a05:600c:3542:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-485198ee3admr30364045e9.14.1772628601291; 
 Wed, 04 Mar 2026 04:50:01 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a8aa589sm13184165e9.5.2026.03.04.04.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 04:50:00 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 04 Mar 2026 13:50:00 +0100
Message-Id: <DGU0E8VWSIQ6.3RHJBZWHB2IW3@redhat.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Yipeng Wang" <yipeng1.wang@intel.com>, "Sameh Gobriel"
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH dpdk v2 2/3] hash: free replaced data on overwrite when
 RCU is configured
Cc: "Stephen Hemminger" <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-98-g3a0874577a2a
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
 <20260213103441.1505659-3-rjarry@redhat.com>
 <2630d756f843466dbe1da67f2a65c7d7@huawei.com>
 <DGTZ14W21JCH.3PCYCDEHF1XGF@redhat.com>
In-Reply-To: <DGTZ14W21JCH.3PCYCDEHF1XGF@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ftxDqiELg6ldEPfKbfy5-tF4AjgZ17d74FB76nx-Dg_1772628602
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

Robin Jarry, Mar 04, 2026 at 12:45:
>> With multiple goto labels that function becomes even more complicated.
>> Can we just add old_data as an extra parameter:=20
>> __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
>>                    hash_sig_t sig, void *data, void **old_data)
>> And make the callers to invoke __hash_rcu_auto_free_old_data()?
>
> I'll see what I can do for v3.

Unfortunately, I need to pass old_data in order to make the new replace
API work.

Maybe we can drop the new API altogether and have a much simpler patch.

What do you think?

