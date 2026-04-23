Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E51F99344
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 09:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 105534028F;
	Thu, 23 Apr 2026 11:49:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E75364026E
 for <dev@dpdk.org>; Thu, 23 Apr 2026 11:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776937791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXYl/F2JIXAYdCO6BBMxiIkXwzPzUto1sC7Bmf09TEM=;
 b=HmY1GOsOKX22UaSIVX8icmRfRlI4/yOgcqPODbCgnIEXZCdP9wt5JlSz7D9IVgZUKqt5te
 xJVevvqvYnSb8fuASSsIUmZWYNUT+UzOqkD68Te7GUjzQsK8oie4ibaSDl+rFs5dYkhHzZ
 /se5hjv44qs0RPy+dHQbpA3zPa+SEMg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-I_yAqHW7PvCVnTlpt5l_QQ-1; Thu, 23 Apr 2026 05:49:49 -0400
X-MC-Unique: I_yAqHW7PvCVnTlpt5l_QQ-1
X-Mimecast-MFC-AGG-ID: I_yAqHW7PvCVnTlpt5l_QQ_1776937789
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c0120047so37151435e9.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 02:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776937788; x=1777542588;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMr4mmE/mKCFN6M6evcQYfcGDN1ebwTqCG4EfmxTjHg=;
 b=XNWTW1KwCObXoRAXxZRBpcv0/Vn+immgY1xTXKyuXLCjpYaiqacAHDNPKKFBnlxAod
 w86YkV2tJSuU6sNfATLkKSvZGgc7zOXoeR+/6S20gYTcHR9iqKSHAjWBqcMLskM9+qOJ
 3FkWsrIqEC1AlBTD3ivNR4Q4O3bPN/8oXgozwgVn9A4bwza+Pg9+EMohFgaEUOcI74GT
 fg21VEjnt21zC+as0rx+JzjHLNUGExWUMXxT1yS9TUiq7eK2Dmamguytg5yFsscComLn
 Fzyv8cYfk7LwBOkhQVgWaNXCWIkIGGU26wIZpbWGkrBxEhZ2rH0AGLhco4K9JN7zg0w/
 7jnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+doRiTWRjfa0aEabsUO9VC+/GY568ni3tqjBHInHVZMcWPtYpaX3AUopD356Fccys4QH0=@dpdk.org
X-Gm-Message-State: AOJu0Yy2nL6PKMQcOSr0wRP7IeiqtHyIzGFV1Yr024RFVlCCoMrSeilz
 PoJBbwANJ8x++eGdcyUswj/4JzkCDy1F6yanIjzi8+OMS+ISha7+RVQs3XYmeKpxr58FjM8r7F2
 ntV53EYlwqZ5fkD5ykQU9fq6ZUV/QYvuSRrxHF35fCSzF
X-Gm-Gg: AeBDiesp8AsGXTYeLd4kVz88n1kZvdqDQ04SJHPn4EEsxDVncOnDfMbgeyw6WS7eSCz
 miuCSaZHglc6irr9vNEcrctWFz+QbrIwMXj1m/mxqdz4D2oX7rbcsd28jH6aA3c5beL4c0S7yZF
 c4sSOTJFyipyDy6u7uGp4tIhtJAD09UsHqpMKFjMx353MWrJZATIrmuzS9homVfIQvaA+PthxzN
 nnkFym97Kugj5/RdUJ9Eg9WX4FBT9UAkqeMR0CY34Ue5r1DiWhkXL/+pYHRW5agBNIE1b4FHFHu
 08jNv04cGSkIo5afZpIeihSYJ4V7oockAgJBzI8R5zYeRpp2DtTWEIDMow+7+8VxWEXpZXS7ne6
 hypgmepuQ3s98ciuWbqTu1k+ukpCKzb9W1p7CEAWHSWGUyHgtnUfkFxuLy7tm4clPW0ZCjQcmyg
 Z+vmnbTqOmbmxWP/c=
X-Received: by 2002:a05:600c:4e14:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-4891f080a7emr236013645e9.16.1776937788677; 
 Thu, 23 Apr 2026 02:49:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e14:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-4891f080a7emr236013185e9.16.1776937788195; 
 Thu, 23 Apr 2026 02:49:48 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm477093305e9.9.2026.04.23.02.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 02:49:47 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 23 Apr 2026 11:49:47 +0200
Message-Id: <DI0FVI2TG9UU.JRHQ224VBSMW@redhat.com>
To: "Kevin Traynor" <ktraynor@redhat.com>, <dev@dpdk.org>, "Gregory Etelson"
 <getelson@nvidia.com>
Subject: Re: [PATCH dpdk v3] net: fix VLAN packet type
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422133217.675900-3-rjarry@redhat.com>
 <66613eae-13f6-42f9-bada-d1f3b5d9cee0@redhat.com>
In-Reply-To: <66613eae-13f6-42f9-bada-d1f3b5d9cee0@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJlkNA7-cRe18iwH03-pmChmcDknxUjfsQoQy0QoUbM_1776937789
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

Kevin Traynor, Apr 23, 2026 at 11:19:
> Not shown in diff, but for:
>
> =09=09pkt_type |=3D
> =09=09=09proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ?
> =09=09=09=09 RTE_PTYPE_L2_ETHER_VLAN :
> =09=09=09=09 RTE_PTYPE_L2_ETHER_QINQ;
>
> It seems to be produce the right result, but I'm not sure we should be
> treating the ptype L2 defines as bitmasks. Maybe I'm wrong and it was
> planned, but it looks like a coincidence it works now because QINQ (0x7)
> happens to be a superset of VLAN (0x6) for the OR.
>
> Perhaps you could check vlan_depth and assign VLAN or QINQ based on that?

I hadn't considered this. It would make sense to have something like:

l3:
=09switch (vlan_depth) {
=09case 0:
=09=09pkt_type =3D RTE_PTYPE_L2_ETHER;
=09=09break;
=09case 1:
=09=09pkt_type =3D RTE_PTYPE_L2_ETHER_VLAN;
=09=09break;
=09default:
=09=09pkt_type =3D RTE_PTYPE_L2_ETHER_QINQ;
=09=09break;
=09}

Mind that this will report RTE_PTYPE_L2_ETHER_QINQ even if we have
double stacked 802.1Q tags (ether type 0x8100) and no 802.1ad S-tag
(QinQ 0x88A8). I don't think this is an issue, but I'll let you judge.

I can send a v4 with this if that suits you.

