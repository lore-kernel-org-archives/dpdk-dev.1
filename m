Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B947CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D77F406B6;
	Wed, 15 Oct 2025 11:32:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B4BD402E1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760520742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDnjADbkZ0R1pgXz/mlZ7yxQKxqiz5uLZCFxoKqads8=;
 b=d2boP75L9zN9bhTryyyupU1ojuRcQyVZpbKk1V2fWZu/VJJnJIiksiupQyn0J6t7aST+9B
 cBJO8aJI01M2NHJc66G0t1EZ9AAWQM+U7+4fmLtzH8LSV4MEXORnQQHcgOeng1faPRm/ev
 Io9RXlGRPbz/bBQM1UN1WxQfDF11K5Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-Tq9l6ta0P96BxXKFlkzezw-1; Wed, 15 Oct 2025 05:32:21 -0400
X-MC-Unique: Tq9l6ta0P96BxXKFlkzezw-1
X-Mimecast-MFC-AGG-ID: Tq9l6ta0P96BxXKFlkzezw_1760520740
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso35877875e9.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760520740; x=1761125540;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDnjADbkZ0R1pgXz/mlZ7yxQKxqiz5uLZCFxoKqads8=;
 b=kM/OWZ6cUcAk29N3lpTkfzD8albn/V44mZR3d6DeQ+bThT4rIM9YQWQra0dHQsvIvE
 Ubbcdo3ohAHGyqWP3DJT75Ptt0P0l8ntBmxw634Sy9Wq23PpJLxggUKGwYce+wbdy4p6
 W6A/Y5dPASSxeWLqH2xV0jqx/Olv3LQEFcjwtL2T9sCJeCsoArmDanpYMEo/1lbegOoe
 qB1+GDr19Nvg+iWQP+Su7nCXlZWyS/qlkAyCX+yCAKlYinYiP8+BbKnrUDinLFmKaWgY
 9pC0bj9ded4deRp2tT1YAqb9FmRBB8+4inPvKdXXaMo7FJOD9vMQgGiDE83ZvZxFxC0r
 C9Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd3oMTkri6dGf620kzLJOaVQFuhHmxq+aolwBcy0QwQyGT1LZSEQ9abdjqhthsLsaySvc=@dpdk.org
X-Gm-Message-State: AOJu0YyG5NEYhe5uDDAOm8rCIvUD58HOuQ21Cbi01OSnnrXt+EiVvyTY
 pPR+N291+GPgGiDxQCxPu2IlPwu16Ix4oc+yy/kqso+RGU4FvLHQ0BXUmH1MfZ+MI7amO5LoXJa
 aPUMjt92/myrkHyxtxgG10mjK2FJOLG96qJFcep1etajL
X-Gm-Gg: ASbGncsUgMG97LrLtMVI/Y491mQuO7rbRh7xEQVcagUmMrP5QQgv+hJh1/xpaD3bU3z
 rvrnJ2s2tFH9PLQz2wtM5uZYHByLPufg5yvyqpLI24YOc/g8BsQe5rXrK95qsz9L2mkFf/rJ6Jv
 dvt1dcXmumViucX6XnjlX/knWZC4j3qs8voz/J5tsQ93GPsAkuM/WtSrESnZ1iDk8FGQF0hPAD+
 EDSSEFV/3NxFwiLMACI+t/L6t4HXxjhEkesSTemOP++rcTo423h7p9LK7WSIwTQhDq/mOVLKSxp
 hc4iJn9hBgt0Y75zz/tjMzG5VrCj5liv0RuISs3LD65cwRvHcJg4CI4XUWYiZuqNh6wW+EgPRQ2
 uzgcErPWHj1ybT32uZgVUmQ==
X-Received: by 2002:a05:600c:35cf:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-46fb42ee424mr129039765e9.40.1760520739880; 
 Wed, 15 Oct 2025 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGenaXMx0qWBdkx/UyunBR1JSqsXIi592G9WgGTo0S3jBu4f2eb+PE0MP1XDbm6vvpJVdjnQQ==
X-Received: by 2002:a05:600c:35cf:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-46fb42ee424mr129039535e9.40.1760520739420; 
 Wed, 15 Oct 2025 02:32:19 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c2359fsm19673825e9.11.2025.10.15.02.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:32:19 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 15 Oct 2025 11:32:18 +0200
Message-Id: <DDISIM2MXWBU.2A2Q7M4D9H733@redhat.com>
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] fib6: fix memory leak on delete operation
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
In-Reply-To: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: je2Kq8ptRNaRvGSuizZwbftGJc-RAU4DHgMs8nyTtHY_1760520740
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

Vladimir Medvedkin, Oct 14, 2025 at 20:17:
> When deleting a prefix, the first attempt to get next prefix cannot
> return NULL as we will at a minimum get the prefix we are trying to
> delete, whereas we were rather interested in whether there are other
> prefixes within the same subtree, not counting the prefix we are
> deleting. To address this, we check if we have found the exact prefix we
> started with, and perform another search to see if there are more
> prefixes to be found.
>
> In addition to that, doing the searches with _COVER rather than _ALL is
> incorrect, because if we are doing search with _COVER rather than _ALL, w=
e
> do not dive into the tree to find more specific prefixes within the
> prefix we are going to delete, and thus will not notice if our subtree
> also has more specific prefixes. To fix it, perform first (and
> subsequent) searches with _ALL rather than _COVER.
>
> Finally, when we hit the "tmp =3D=3D NULL" branch (meaning, when we are
> deleting the only node that exists in our subtree), we know that the
> rib6_lookup will always return us the node that we are trying to delete,
> but this is incorrect because further code will consider this to be our
> parent node. Address this by doing another search to find the parent of
> the current node.
>
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Tested-by: Robin Jarry <rjarry@redhat.com>

--=20
Robin

> Use extra care when cleaning on stairs.

