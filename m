Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620DCCF9FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 08:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49642402E7;
	Fri, 31 Oct 2025 09:38:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8E0AA402F1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:38:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761899929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=j/pl4U/CAnu1lXCAxJ3SPYgH44+PK/i3w7mxFaHMTFA=;
 b=RZ9gvGq2bjyjtqY/jAaiyI2eo/NHh+c0/IieXqI3YP8zjSjcFaFhb5k+bKLgpA3uQTJc7U
 +ug7FwBR0FE6wiEPwlrQnF2uk+/WOAIZ0eVKcpP/Z5cKJvIZjDisUxiYRUDIrH38sEJ+ou
 14A6Nykl4cNwtVb441vKu/A0fT9fGwk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-xhwZEjScP063kUJUWIWcjQ-1; Fri, 31 Oct 2025 04:38:45 -0400
X-MC-Unique: xhwZEjScP063kUJUWIWcjQ-1
X-Mimecast-MFC-AGG-ID: xhwZEjScP063kUJUWIWcjQ_1761899924
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-592f38ee5c1so1689839e87.2
 for <dev@dpdk.org>; Fri, 31 Oct 2025 01:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761899924; x=1762504724;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/pl4U/CAnu1lXCAxJ3SPYgH44+PK/i3w7mxFaHMTFA=;
 b=nKMTwA/hOKT/lh7PgUQHJ1h3NbtdSNeaMlVqXpkjpPss++kGCK+5c4N0k/c0mbrorU
 dO/iOKOZYbdvh+Z7T8CgjaW+rMSHVilB+Y5HhazHNHj5dKG1EO56OPGZV/RWSVRR/LoX
 BOA6j8MBOjX867VL3wswZmTSFPgDxZUEO5VkRlNwO98wSW9Im8PYSM2sWvXvP643lluV
 vJ4y0rQ6xFpyTqSv9HY6f5x3KjQ7DQFjUm1a2Zi4lUVbnl2ay2TQWxJTmAtQqZSX+wkW
 i+VZDrFyqsF3Xt+GMB66/or9y7GmQypDVEQjOYBpa3vlCqTFnMuxVuId3d0bp8oYHw5V
 76qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnPj/s1/8wiE24+hU2/wyxoLaZKmpWWL087VXJBmBBR4NIsJaJLEQ3b0AdoZKP7gNBlwE=@dpdk.org
X-Gm-Message-State: AOJu0YzUDQMtkqEaV0mN74hyO1zSE1SlQHEtELZa6UDWHKgIDc2EjFRH
 FXWxJy39aKBsbG76R3F7cXwUWXH7jp9jcS8EDsB/YoSXG6B8oSB8bDqj3xwqJjoii/DQarAr3Kj
 bFivgn5UotmCxm05XCheLD86DBUAW2cP6/EapErsg/Dzyz48n9uxVrYdt7E5V7FReorAYsqWarn
 rjPP2llsZieX9iTRw6g1o=
X-Gm-Gg: ASbGncvgOtcTpTVO5j/kvOW5OBJ8159rZr1w1Ykvvy3lmxgxQf9VkUgjpucOAzmh2+J
 ZYHrZ/cdmnhSyArm6tpopAkMozfAIFWe0A9HLO7mxd/aByKq+qWkQByl2836BXUjIW7izFDs1uY
 sBsaDpenas/AIWu5/40xiVURmBoJlxNa8tD92vwo01yR6lVwWMxxz7wxeOEw==
X-Received: by 2002:a05:6512:3195:b0:592:f9c6:973e with SMTP id
 2adb3069b0e04-5941d5315ccmr916048e87.33.1761899924219; 
 Fri, 31 Oct 2025 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYz2S0u4m1AoGd+p9l5gR73NWYpjd34wxugaWH2DMVJ+mkYqnONmBJqb6MF8tsnV5zMWGvf7iufRUCWUdWzHE=
X-Received: by 2002:a05:6512:3195:b0:592:f9c6:973e with SMTP id
 2adb3069b0e04-5941d5315ccmr916042e87.33.1761899923735; Fri, 31 Oct 2025
 01:38:43 -0700 (PDT)
MIME-Version: 1.0
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Oct 2025 09:38:32 +0100
X-Gm-Features: AWmQ_bmFSgrsxUVrNGeZQI-j01evphSCFZEfRclfwTMXE3HLI03fiUpLMQrJsDM
Message-ID: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
Subject: Disable SPDK testing again?
To: Patrick Robb <probb@iol.unh.edu>, Aaron Conole <aconole@redhat.com>, 
 dpdk-techboard <techboard@dpdk.org>
Cc: ci@dpdk.org, dev <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hLoSmFZwGQKktHveeoD7k4B8g_PQmFILWY07s3WYYRI_1761899924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

The SPDK target in UNH lab has been spewing warnings as SPDK build
itself compiles and links against a list of libraries and drivers,
regardless of the upstream dependencies.
https://github.com/spdk/dpdk/commit/74b1a804eda2ed99d1ecaae5b79de7df6d74e8ff and
https://github.com/spdk/spdk/blob/master/dpdkbuild/Makefile#L66


Until SPDK fixes this on their side (either adding argparse in their
static list, or using pkg-config for example and stopping patching
DPDK), linking SPDK binaries fails as the argparse lib now necessary
to EAL is not pulled:

/usr/bin/ld.bfd:
/usr/local/lib/x86_64-linux-gnu/librte_eal.a(eal_common_eal_common_options.c.o):
in function `eal_usage':
eal_common_options.c:(.text+0x16): undefined reference to
`rte_argparse_print_help'
/usr/bin/ld.bfd:
/usr/local/lib/x86_64-linux-gnu/librte_eal.a(eal_common_eal_common_options.c.o):
in function `eal_collate_args':
eal_common_options.c:(.text+0x953): undefined reference to `rte_argparse_parse'
/usr/bin/ld.bfd:
/usr/local/lib/x86_64-linux-gnu/librte_eal.a(eal_common_eal_common_options.c.o):
in function `eal_parse_args':
eal_common_options.c:(.text+0x343b): undefined reference to
`rte_argparse_parse_type'
collect2: error: ld returned 1 exit status
make[3]: *** [/root/workspace/Generic-DPDK-Compile-Meson/spdk/mk/spdk.app.mk:39:
spdk_lock] Error 1
make[2]: *** [/root/workspace/Generic-DPDK-Compile-Meson/spdk/mk/spdk.subdirs.mk:16:
lock] Error 2
make[1]: *** [/root/workspace/Generic-DPDK-Compile-Meson/spdk/mk/spdk.subdirs.mk:16:
thread] Error 2


While it is just a warning in the CI dashboard, I don't think we
should waste resources on this testing.
Opinions?


-- 
David Marchand

