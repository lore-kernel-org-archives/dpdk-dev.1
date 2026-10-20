Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CFC606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ddXXm+7k
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 224DB4060A;
	Tue, 20 Oct 2026 13:19:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D42C540270
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792495166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lM4p3e9srqv1fo8smHnrnPI82mv32gFYrWgvYAFBFM=;
 b=ddXXm+7ktyeNdzCyEdcfJlgh8KW+RrxatpW0OuFrrIVZDSDD0I3/Hlp0pJ0KijqIvzO8Wb
 OR8Jtdokqkomz9Yg7JrQyGZgrz31ts7Z0jw64Ry531K2agzuhbTCl/4PJ/+///AdOOOLCj
 XHydGeLpHmOyg2Yi6+JnmjtVrclyq0I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-s8p0FX27NCmoPOYNR5JSbw-1; Tue, 20 Oct 2026 11:19:25 +0000
X-MC-Unique: s8p0FX27NCmoPOYNR5JSbw-1
X-Mimecast-MFC-AGG-ID: s8p0FX27NCmoPOYNR5JSbw_1792495164
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48dfa054f26so2450127f8f.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 04:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495163; x=1793099963;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3lM4p3e9srqv1fo8smHnrnPI82mv32gFYrWgvYAFBFM=;
 b=PhAoj2peMVa9YzY8TPLVKoU6iwDs/D6rTnHfEQReIEDpU/co/OF60IDMeZNNYG7Vv3
 3UQEaT/M+jl3iQz2YeaLtf0O0sT1pgiKFrhzukXpByaVYJYxB4CCrnCnUS5ADb7ucOnN
 sf1ZwLA/iFs1ZQsWJbncXF5bvnaAz1xRZ/7u8tXsCNJ+64KLhV2YVQC0aim2BExR3aR5
 +ddaj1jGdxF6+cTZv2YpQg5fAx4cQQ6TboSXtW1yap6HSD/64/qDJUAdTXNXE8sNbkxN
 ALXQkmdE7JqMuX/U0cjPVB1KVtj46E8Hu6bMSZPqqVZRvohqC7gbegjZPhg8fJzvVdki
 MZIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw72IIXeY2Kh/5nA1IGBKF8D388ZaQZuVcjkihmV6kJxAh6ePweCTM+YObkA362QVutVSQ=@dpdk.org
X-Gm-Message-State: AFq9FYJX1UvK6e3iq5u1m2OGBTb9k6uay9+FrxMmpWnJhPvsuhhoGcBE
 AKugJvNoBSQd/NPXLu6TqY4z1RHeyyqGJu4E1cpsDjMs5o1loE7qEx5OH4kJWf4pT2OXEIt4cQw
 BbBMr3pqhTXzsIV/odsmyiV4DZP9Bu0Zm4By+pQbgOrIV
X-Gm-Gg: AYBFou3jrJHZHjSjOQNXDSewKt1iY+qwGNrT2LVdo0aLQ7wk93N/QmwiM1sUvMP9sfe
 i5t+yfWvppqNAX7co4Kar6SEHp9EfImbclyZEHhEzjuw5bKbgaSs6ccw3NfmvQQ+6gv1cvytqtk
 l+BSeIfPfTlm9cKTDLX9yVvEEW0OolZyf5RpBY/bjjKMuiLZJgPLqE4euVCdbQ+PR7g03AJVpyg
 yBgBeq6meADy6X90kp4qVi7e1r6D2hqvOn2ebkBl/gaPUmRDLSvpYPgEB2b+WW/tfJmf2LzbciC
 nEoJMsvHv67Oz+spziolEIRXjSyTsXyB4015JCm+h0hlllFVhLggYtRqF2fVxQ3XEsGf/mDU9Mr
 kCjaL94Ij1fN37tOmSrDXNAOEFthkuT+39+U6D8FuQKtv/QZpWKSQqkYrKtKQ9J0HX7RT/fVtmy
 g8ZrbULOJ20FmlYtjEmxD9wQtlbBfMCw0PIljEK22Ep3YMtYnmckFb2lJww+QNVR1OiT6+ZoqQI
 GRDlmVGsQcs0LK/w4NlkdTS5A==
X-Received: by 2002:a5d:4dc6:0:b0:487:1575:ebe2 with SMTP id
 ffacd0b85a97d-48e07fa9d89mr16293831f8f.44.1792495163606; 
 Tue, 20 Oct 2026 04:19:23 -0700 (PDT)
X-Received: by 2002:a5d:4dc6:0:b0:487:1575:ebe2 with SMTP id
 ffacd0b85a97d-48e07fa9d89mr16293775f8f.44.1792495163030; 
 Tue, 20 Oct 2026 04:19:23 -0700 (PDT)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d69sm5502971f8f.22.2026.10.20.04.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 04:19:22 -0700 (PDT)
Message-ID: <e4ee33af-eda5-4896-accf-41daa47b3592@redhat.com>
Date: Tue, 20 Oct 2026 13:19:21 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/vhost: fix SW checksum when zero
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>
Cc: stable@dpdk.org
References: <20261017165952.3139535-1-mb@smartsharesystems.com>
 <20261018092037.3143058-1-mb@smartsharesystems.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20261018092037.3143058-1-mb@smartsharesystems.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bcByott-iTh408sZD4U_LwYQ0oTiJd434hptvHBvh1M_1792495164
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/18/26 11:20 AM, Morten Brørup wrote:
> There is a special rule for UDP, where a checksum of zero is as 0xffff
> instead of zero.
>
> Identifying packet types requires masking with the mask, not the value,
> before comparing to the value.
> Identifying by masking with the L4 UDP packet type value (0x00000200)
> instead of the L4 packet type mask caused other L4 packet types to match;
> specifically IP fragments, IGMP packets, and certain non-fragments.
> This meant that some non-UDP packets followed the special UDP checksum
> rule, which they should not.
>
> Updated to mask the packet type with the L4 packet type mask and then
> compare to the L4 UDP packet type value, so only UDP packets follow the
> special UDP checksum rule.
>
> Furthermore, according to the mbuf documentation, Tx checksum offload
> requires that "ol_flags" is set, and only mentions "packet_type" for Rx,
> so use "ol_flags" instead of "packet_type" for checking the packet type
> at Tx.
>
> Furthermore, writing the checksum needs room for 2 bytes, not 1 byte.
>
> Note:
> Using "if (unlikely(cksum == 0) && PTYPE_MATCH)" to advise the optimizer
> about the need to evaluate PTYPE_MATCH being unlikely.
> The probability of cksum being zero is only 1/65536, so it's better to
> branch early.
>
> Fixes: 8ba1723783b2 ("net/vhost: perform SW checksum in Tx path")
> Fixes: 8f1750f42e2d ("net/vhost: perform SW checksum in Rx path")
> Cc: stable@dpdk.org
>
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v3:
> * Writing the checksum needs room for 2 bytes, not 1 byte.
> v2:
> * Use ol_flags instead of packet_type for Tx.
> * Added note about the use of unlikely().
> ---
>   drivers/net/vhost/rte_eth_vhost.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
Applied to next-virtio/for-next-net.

Thanks,

Maxime


