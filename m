Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C537CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9514E40658;
	Thu, 15 Oct 2026 18:26:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CCCFA402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792081591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiEPvKF1vXgEXk7D/IwM2iMVLJyJ8Ui1Yn1E2dGnoqM=;
 b=WABe/cGEgzJXWOUxsfmEs3XdYKZr5EDFyGf958XHvbO1OVQohJhBosRW8/C5Jtk0exIC1N
 VCOi3AlETwcxMvGHqTQhRss+TpnS3HrNOqaZqTB5dIZlYRUiJs2adYjEs1hNkTO3XZGO0Y
 cxvPG+As8S05HWrp9hy9VWDLf+H8QzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-nQjQs7ICNoeN6XAnKfrtbw-1; Thu, 15 Oct 2026 16:26:30 +0000
X-MC-Unique: nQjQs7ICNoeN6XAnKfrtbw-1
X-Mimecast-MFC-AGG-ID: nQjQs7ICNoeN6XAnKfrtbw_1792081589
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1bfd5516bso10142325e9.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081589; x=1792686389;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AiEPvKF1vXgEXk7D/IwM2iMVLJyJ8Ui1Yn1E2dGnoqM=;
 b=ZNHKO64mmPiFenNKVBUf2vD0ZjQR8mZTH6EILeH8WtuJ0vJYVMErH4zG5Y/BOEancW
 hk6qw6JBGpPHfA/xxOBQow88LfFerxd71nIM8fY+QLn3sIxYvv+71y9yde5FRWC36c/w
 pDURjddlZ/xtWFsiZdMZ//JlJ7hWoDKbbOrbl5C5uEFGtchjpYCMlvVoS6T6Pc0owijf
 flq0arxSK5QeCDM5PWpQqbSeIS7oLMrOuF2UGNbx2omeup+cymUbBH0UQ9yP7aUksQEd
 h7N7Ts4tKh78uTSz+1q2wNbkDO2XHPXS5alu1oY9gXzpCt1kXklnY+y5+OC/BjHEvkll
 NWmg==
X-Gm-Message-State: AFq9FYKnCPGYrVbxF5mDWrxnIrAXZFzSym1HoUubjVdmslQIN0Sux0rB
 mbBOx1YlLFZXWel/oudkfLiAJRVg1YOUUE/nua+XSfkTpMK/4VcYuCEWpJegSIYuHUEcZSjAAc+
 jnWDf1SAmMFgRtd6TX9RPJRWh0pDRPtlHIMX41fobQBZemEENowHN
X-Gm-Gg: AYBFou3EumpiBj4hYh0t3gIpZQIEOlevyhbd5KgtB8S+DbHegD0AK2NDu/IkyyS4yqX
 EY6M6YrwMgnFHjUkRHBlUTPUf+iDY0YQ4J+gSs1tj7pKIaOPX6nqUjryjf07PsU0adq/OeQSz/v
 LiUeM1d8khfsnug7ka5gNo2uv3R/JkSgb4XQEh6bh3zwn1Z1vHXGF791Ix1I06ZKjhp0nSDuOrr
 Dy73BADYWnUXnafDAMnitzxTmudCgoLodzd8ZStKabjDdlVFcko2ZDuqJ2dmSp0Di4s0fDvMyoV
 AYPEfaMVk4sHE/dnbUD0PN6LdSdLWOr4bESmKMRXwgiFzc12HOSsw3f0S8TAE1XtsTKZDLyj8Wc
 w2yfk6wuEi3T2mIDzGBTGhKW2JCeLRsgXWrZ/cn4bSuUw0cCl47kbaXSA
X-Received: by 2002:a05:600c:a00c:b0:49f:fe90:de63 with SMTP id
 5b1f17b1804b1-4a18e4e0a3emr410628365e9.28.1792081588700; 
 Thu, 15 Oct 2026 09:26:28 -0700 (PDT)
X-Received: by 2002:a05:600c:a00c:b0:49f:fe90:de63 with SMTP id
 5b1f17b1804b1-4a18e4e0a3emr410627725e9.28.1792081588215; 
 Thu, 15 Oct 2026 09:26:28 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm19957841f8f.56.2026.10.15.09.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:26:27 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 Oct 2026 18:26:27 +0200
Message-Id: <DM5JWJSS12VT.22J6MHQJOGKQS@redhat.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, "Aaron Conole"
 <aconole@redhat.com>, "Bruce Richardson" <bruce.richardson@intel.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>
Subject: Re: [PATCH] ci: fix dependency on cmdline
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20261015160157.3348253-1-david.marchand@redhat.com>
 <DM5JUAJZOBD1.1MJUHEI3YCXCO@redhat.com>
 <CAJFAV8zTVFEwzDrbOt9NLd8QjYNgFw2HEWQz_h=CKVnwaXkMgw@mail.gmail.com>
In-Reply-To: <CAJFAV8zTVFEwzDrbOt9NLd8QjYNgFw2HEWQz_h=CKVnwaXkMgw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BQT0bnonLKjjhsxoRhok740zHL-U9Tyq5LPGtKxUMvE_1792081589
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

David Marchand, Oct 15, 2026 at 18:25:
> Examples have hardcoded dependencies see examples/meson.build.
> Since the mini target explicitly requests l2fwd, this triggers an error.

Ah, so we would need to add the cmdline dependency per-example?

