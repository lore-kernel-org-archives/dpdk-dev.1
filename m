Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2A606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2Zo7dOm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA05406BA;
	Mon, 26 Oct 2026 19:11:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id ACE364068A
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYc6TKYL1SDrgyBd5B+4Nwd0yrY1TVVs8dEoQ1GxWVo=;
 b=h2Zo7dOmZfxqq07TBROS5XFY+PlKMN5znM2B9tvauJa9iTs2oaXRFbrldCgr4B2Oqz0Grq
 ZOrjd2esMHYnr/1TLhBxhoHm1wFuNd/zMXjZdVs7YCnk7bffqt7nG1UYknEIocRkMk08vu
 hY2/kbYPYatPAeQ/AOjfeVsifsVNCdA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-0salXWQpPNmINUmjkmMACw-1; Mon, 26 Oct 2026 14:10:54 -0400
X-MC-Unique: 0salXWQpPNmINUmjkmMACw-1
X-Mimecast-MFC-AGG-ID: 0salXWQpPNmINUmjkmMACw_1793038253
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab3650ca2cso15483261fa.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 11:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038252; x=1793643052;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PYc6TKYL1SDrgyBd5B+4Nwd0yrY1TVVs8dEoQ1GxWVo=;
 b=ICF+oePEAUUt5MaJkIFxSvtQ1eh63I43I0mqhgvLpvQ6PKpyCw7++KC1toanjlcswu
 62fJcLMzJQaTsNOo3y9iBqWOQdn5N06waUmyo872E+Pyv8k75SvBLTrquS3MQPLcQcWT
 WcIqPDT9SdehZQqmwc4qiOJtNTTPb7sIlYdmuVrXw8o2ykERYM4beNXdAwTRDHEyHkna
 +nAebElf8tLJuQ5Nuuu1d2p2QWgXSVXInTHQLKF7DsObVxfrLThEBrK+9aLddi0Gyqcq
 4p8+/LzxqEJiFsoACDukAy3D5eYg09j/plzfgru5V0CFPV8/l3d+fAtsmfZoJWOuUAdA
 N1GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZ711+tKFWSoLITdGdgVKVd/AzHmcD5QwKq1pvwhzCStoH7UmkGIg9gvMiU7C/wC6EUcM=@dpdk.org
X-Gm-Message-State: AFq9FYLTuHBOJoclprLLMmsfbyg3GjD8Ounu2bzKQ2FIyvSbbYA/sqq9
 m7Cg4wYocfAe8IfvVP9B61iH3ahVnFxXdG4akQVwMHCf6uoGl559Noh4XsnPf6kEytgFTz+hgmC
 JvmzJGwoyrXXEeAgR3N95lWMI2hzq/ZKCJu208q9wffOZKXU/kODgtI9TssgfsG2lGi08nMK3L7
 x43fIzd6q77/Fdn49asG4=
X-Gm-Gg: AYBFou1VQ2zX0eO99nzo8jzrgbAvXnRgMTdx7s5/zXAq2Nb1Tx3fl1mx9ZBPa1XulCe
 BqiBc1lcW9Y8tqsVWYnb4OBiZs7WJ772JrckIanUVBu86A9EEhXmSI0CwecV/jAEHgijclrstnz
 Sngb5IyW65h2ok7KIhZOCDupR+AJfgqMuFmS5I3fUW6KaF1tmq3PRc+DBCESlAbSR0n4WdQaGOQ
 hjwf52/esFyi6LpLwh/aRf3TYDLsjd3npeCj02N5RhF6Ofm
X-Received: by 2002:a05:651c:1a08:b0:3ac:48a0:e253 with SMTP id
 38308e7fff4ca-3ac6fd1e270mr20713361fa.23.1793038252545; 
 Mon, 26 Oct 2026 11:10:52 -0700 (PDT)
X-Received: by 2002:a05:651c:1a08:b0:3ac:48a0:e253 with SMTP id
 38308e7fff4ca-3ac6fd1e270mr20713261fa.23.1793038252015; Mon, 26 Oct 2026
 11:10:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
 <GV1PR04MB10750AE0102EC1FDDC8E2E0C389992@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <AS8PR04MB82937F10CD26FDD07AA3AFABE5612@AS8PR04MB8293.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB82937F10CD26FDD07AA3AFABE5612@AS8PR04MB8293.eurprd04.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 26 Oct 2026 14:10:39 -0400
X-Gm-Features: AclHuK9Sa7VoXmeUU_ddXPoVhEwR26-8-CTpW3Z2qeNgJDnnfBGWWSPW-ykFD-I
Message-ID: <CAJFAV8yKvC3rzwvK1LfraGx+ztV3Y_WNqiscom3JQTTj7uiPFg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Device unplug and bus cleanup refactoring for NXP
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j9JbW1lkwdgGrShBqAXyTzCYQ2CC4-Oo-7KO8BrnneU_1793038253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Mon, 26 Oct 2026 at 10:41, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>
> I am not able to apply these patches on next-net-main.
> Could you please check if rebase is required?

The only conflict I see with next-net is the macro changes on dpaa_bus.c.

Sending a series based on next-net-main will likely fail in the CI as
it will try to apply on main.
(bus drivers updates are supposed to go through main)

I'll respin for the rte_intr_fd_close changes in main, I push a
rebased branch in my GH.


-- 
David Marchand

