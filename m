Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77DDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 17:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDC4D40268;
	Wed,  7 Oct 2026 19:17:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3DF9B40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 19:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791393460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3iQNFm2hXnj2aFCaZufl7mtfjGJG2Zvr5RXiMm5zjlk=;
 b=Ws2zSvSZglPN9TdJwM70IVVu7SzsnzgJD1ihLSbMaYuapJ69JS+XP057sjwII2jnzor2+1
 9WiJvAJ4JE7LQeQCnb3W7bMy4uApXy7cA8zh+ttNQFsPFOb8Iji2aa08HngMzVvlB6270F
 XO63qYptspBVlbCxkiDxkf+V8wMPd1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372--q1I0DHeP_e_KX-d8vXAqA-1; Wed, 07 Oct 2026 13:17:39 -0400
X-MC-Unique: -q1I0DHeP_e_KX-d8vXAqA-1
X-Mimecast-MFC-AGG-ID: -q1I0DHeP_e_KX-d8vXAqA_1791393458
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a022fee32fso36519015e9.0
 for <dev@dpdk.org>; Wed, 07 Oct 2026 10:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393458; x=1791998258;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3iQNFm2hXnj2aFCaZufl7mtfjGJG2Zvr5RXiMm5zjlk=;
 b=y8PzkytrL5kBKGDNKQ2uonFE+tXSAZXyH7sTQUv33flIXN2vBvO6oCZzwoa3LNyyag
 EgOteRFujhyLoMPGNofbNb5ZwiHrWavbpab4/lH97UXMSya5Sh2QMukxEy5G2ywQGtEC
 K3A2nUiMr3FzN8f8mkqmUoJCpfhnB2Ez05F30kwMnhLZM7oGU5GDS4p5zzuGZu8sGZDN
 Y4OWtbLwk7lZKImfadHgUYCivzcdBfYKUEPm2JqXVPM1/zKteL9j/8lYKa5i5zKRx+bt
 hCfsdY05IRov/rRG3xmowOAtLq/7sy1ho3Q2MwxuQg/iroFRuptVP+cCBMlLQCsx8Eid
 /rpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgL9ru/nkNefSlSBGUZRIVMRD4b1rBeJawD6tB3StZxdmGgC/bFeTZIo6ZC9JbXnInWWI=@dpdk.org
X-Gm-Message-State: AFuF++lIWsjdl4X8g7Q887bt5nEaKn/6zX49G3OJVa25qIPc/FndX1Ki
 f14j5NAP36Rh/GjOfrjD074lqC86+4R5TC+8JibXcm6OeKKV6Jh3zoq/pXZzH/HIP6CWv2fVELj
 49rC37+VKIKxxfvo3LMCjl6UlvUgJV7J0rl/7KjO0qpoNY6PpyXC9PmTMKBvOC5bB8A8WqYwVY0
 1SXgh5YmDDuGwJWu6No3dIiRSQV1k=
X-Gm-Gg: AYBFou11qO8bKuCtPm7TlXLvSXXHpkbyVw6B6GSZ3Qq37zQuhhwzuisYHGl1i3mN77r
 vxPQh27cTAYaBjcaX8iPqaCb/B+aWsgMZLqX9Tq4+M7ucWLuJa8x2pHp76zrGstHiZ+OmByj1FH
 tTpnzILZRYC2YenGLLAg8ajtx7ECvGY2TAZ37/08FSouXn9C7i043F9HUctwuZr1eRprGohT0YX
 7QDULZc4nRAd+aGQ2/ggbGNYikQH+oO3yXuGtq3LDY3fEIQ5I8//eIVL08JmeltVmeX2H0YHmFN
 ypdltUQPDiRqTAZPmL3u8Ms4MmPW5DjL+0RVU2PpkEz6saUiXmd4qwfiTNTcuZ52eC/GEasn4So
 o3wai2vwTd95UaU7NzKD19lLl9gM5Do4=
X-Received: by 2002:a05:600c:19d0:b0:4a0:1f51:ba2d with SMTP id
 5b1f17b1804b1-4a18045373dmr46026945e9.22.1791393458285; 
 Wed, 07 Oct 2026 10:17:38 -0700 (PDT)
X-Received: by 2002:a05:600c:19d0:b0:4a0:1f51:ba2d with SMTP id
 5b1f17b1804b1-4a18045373dmr46026555e9.22.1791393457845; 
 Wed, 07 Oct 2026 10:17:37 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843bd060sm7251025e9.14.2026.10.07.10.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:17:37 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: "dpdklab@iol.unh.edu" <dpdklab@iol.unh.edu>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: Issue with patch application (Depends-on ignored) -
 pw169600-169609
In-Reply-To: <AS8PR04MB8293D01C39E0F7EEC9B0FD2FE5942@AS8PR04MB8293.eurprd04.prod.outlook.com>
 (Prashant Gupta's message of "Wed, 7 Oct 2026 09:17:02 +0000")
References: <AS8PR04MB8293B2670DEEEE8B780143DCE5B92@AS8PR04MB8293.eurprd04.prod.outlook.com>
 <AS8PR04MB8293D01C39E0F7EEC9B0FD2FE5942@AS8PR04MB8293.eurprd04.prod.outlook.com>
Date: Wed, 07 Oct 2026 13:17:35 -0400
Message-ID: <f7t7bjtv39s.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R_Jf264B5Mo9c6OnB7mxA-hz0FGqP8To2ZhTW44wyhg_1791393458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Prashant Gupta <prashant.gupta_3@nxp.com> writes:

> Hi,
>
> Can Somebody please guide for this case?
> Thanks in advance !

Depends on was merged in upstream patchwork some time ago, but the
release hasn't come out with it yet.  IOL Depends-on support relies on
this feature being provided by patchwork.

> Regards,
> Prashant
>
>
> NXP Confidential
> -----Original Message-----
> From: Prashant Gupta
> Sent: 16 September 2026 14:57
> To: 'dpdklab@iol.unh.edu' <dpdklab@iol.unh.edu>; 'aconole@redhat.com'
> <aconole@redhat.com>; 'david.marchand@redhat.com'
> <david.marchand@redhat.com>; 'stephen@networkplumber.org'
> <stephen@networkplumber.org>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>
> Subject: Issue with patch application (Depends-on ignored) - pw169600-169609
>
> Hi UNH-IOL CI Team,
>
> I received an apply patch failure warning for patch set 169600-169609
> (Series
> 39292). (https://mails.dpdk.org/archives/test-report/2026-September/1044522.html)
>
> The build failed because it tried to apply directly to origin/main,
> resulting in a conflict inside
> drivers/dma/dpaa2/dpaa2_qdma.c. However, this series strictly depends
> on my previous series 39291 ("net/dpaa2: flow, meter and parser
> features"), which contains the base infrastructure changes.
>
> I included a "Depends-on" tag in the cover letter to handle this
> sequence, but the CI bot seems to have missed or skipped
> it. (https://patches.dpdk.org/project/dpdk/cover/20260915120208.4185877-1-prashant.gupta_3@nxp.com/)
> (Depends-on: series-39291 ("net/dpaa2: flow, meter and parser features"))
>
>
> Could you please help me check if there was a parsing issue with the
> tag layout, or if I need to format the dependency tag differently so
> the lab bots can chain these series automatically?
>
> Regards,
> Prashant Gupta

