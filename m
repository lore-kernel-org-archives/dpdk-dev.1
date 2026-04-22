Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D0F9EDC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:18:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26D45402E0;
	Wed, 22 Apr 2026 15:18:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 32C39402DC
 for <dev@dpdk.org>; Wed, 22 Apr 2026 15:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776863894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9R6vHW7v+RFo33nMRcINB7y9Z/bJ2dBf2d2FCOslXc=;
 b=JW+V7wqLO8euHqeWS15LXOfp2P0748R9YXYzmV9nBXY9Ihgkeg8FyNkKg5jGjvOgiSOcxz
 1aaCZpjmAUVgiPc4+TKWe96zuQ2SqCrsn7I71Ysiiiv++XY4ivYuw/KMyY3w7QknR1HAzR
 MwkYpXiNAYO7W4D11EI8KH7+AH2ckTc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-4iVFRUgbMeuRG5H7eDMirg-1; Wed, 22 Apr 2026 09:18:13 -0400
X-MC-Unique: 4iVFRUgbMeuRG5H7eDMirg-1
X-Mimecast-MFC-AGG-ID: 4iVFRUgbMeuRG5H7eDMirg_1776863892
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c2aa6becso52892745e9.2
 for <dev@dpdk.org>; Wed, 22 Apr 2026 06:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863892; x=1777468692;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U5fk67jxwopGPSvoiZxiERQ5bZFrQgN9o9eFAc/GbZ4=;
 b=SkhbVjcrTsokXhiAevgFVHNYpbB888pXWJpvDSFNbhZAQQCh0JMLgCtW+GBebLSHCL
 vQ81zOxW8CKY3TizqUVIUAmlen9NcEvw+xW+r7xLaQyoWdABAuqLRy8XeGqRPBfU7i6z
 XNfAKgkE/zo+knxYFOrhVbOiGm3z6lYCL7Ox5Zli+avuie3zhegsprPRzCwfNV2If4jT
 VSYANrAMUTZDfuntNwKEPs9VjvSx7W00MPHcrDA8LCfc3QOaghjx+FSUoJdJ2lDeCiEe
 yGh2V4Ygz+0aZNO7yZNSazR1ysk8oti8g1i0+mZ5OvyMW0JByTZ3hGtHzlpHYDwVGo7S
 9GQw==
X-Gm-Message-State: AOJu0YxPCY6BFivQP0GJVH17uj5V2mf3t0ojwOlVEKxgIhQRiqmU2Z4h
 PSzqv3++FoJ7EoOyRZy2iSj0FmBTo138THO9VDIq8nGYGyJiOaoZS4Ta8J1lgeSLXcDyMVam0Y7
 idVhP1PDWHJxH6R0f0qtU3Kt0Ycx9tYP3P0pPGAUU5lDibeoMIQtg
X-Gm-Gg: AeBDietItbyIRhn3DO2sZaeLBZi4jHqJcPK8kMnZgAbW4Zo4UEOKHtVCdkB2gqdzvii
 PGByOsGZzredypUwTScXwWbYogR2Wf1claCe0LYgOlI8MQgCXedorKMSdwAZnRswYKbcCXPuFQg
 PG5sks90CCCvcavE/H0Ee+VlT2eBEP0eW+RdM9pU51pgmpEvSgJIf0+OCRe07bUprbguzps61x2
 eLExRKIEp+2uyoC3oUR0IISwgki3DL8mkcSXSzL+tIaCjhD/BVUcDRlygwwPOpwHPgGazD5xY95
 hDMr6wq3XGR+7Q0fySnMbF/hZb2ge2H3n8kHbDkXzBhNV1r3oa/7dUgwhCu4IyTHsIBk/Pyk0w6
 KL7rqTc28J+7+EVaId9/l6ZcF+q4HBYeDJuKu5LnZ4ROY8qzpGyQ3b++6JIgfeJG/UbYPAokjQ8
 Vuq7Mq7B4GeMTBOQY=
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488fb7864c3mr322608505e9.22.1776863892048; 
 Wed, 22 Apr 2026 06:18:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488fb7864c3mr322608035e9.22.1776863891587; 
 Wed, 22 Apr 2026 06:18:11 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm56152295e9.31.2026.04.22.06.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:18:11 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 22 Apr 2026 15:18:10 +0200
Message-Id: <DHZPOIDFOZW7.9EC6OGSQC2D@redhat.com>
Subject: Re: [PATCH dpdk v2] net: fix L2 ptype assignment in VLAN loop
Cc: <dev@dpdk.org>, "Gregory Etelson" <getelson@nvidia.com>, <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
User-Agent: aerc/0.21.0-142-gcff39137b013-dirty
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422103838.649578-2-rjarry@redhat.com> <1924482.atdPhlSkOF@thomas>
In-Reply-To: <1924482.atdPhlSkOF@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gPJdNEgTFEELhklRchXbo-wXmN4MLXHD-QlLyIcX5AU_1776863892
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

Thomas Monjalon, Apr 22, 2026 at 15:16:
> 22/04/2026 12:38, Robin Jarry:
>> Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
>> rte_net_get_ptype() uses |=3D to set the L2 ptype inside the VLAN
>> parsing loop. Since pkt_type is already initialized with
>> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
>> (0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
>> VLAN frames to be misidentified as QinQ.
>
> Thanks for finding this major regression.
>
> Minor nit about the title (for whoever will merge it):
> we don't really care the problem is in a loop.
> I think this title is easier to read:
> =09net: fix VLAN packet type

I will send a v3 with a different approach. Currently my fix breaks the
detection of QinQ if it is followed by a plain vlan header.

I'll adjust the title.

