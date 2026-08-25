Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923E1C61DBD
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 11:39:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668B3402A3;
	Tue, 25 Aug 2026 13:39:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38CA3400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 13:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9pdeWWHRe+ulBK3gEZu0WQUkg5kuvGWcShMYDJIIWc=;
 b=GfC7ypyldAinzh3KlmWh+VIuX1THd5yHurK2LRJ3MIaadh+c+srTqQXTBudF0DjoSy54Ks
 vqNn43bnqR/GZMQLfVIWexamzPdFSveQz9SYe21pQ9LfNixNJ/VohmR6AZdNi9ry9a2obj
 lyEbu1k4zMH/nOO3kK/y1uN59scD1Bg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-_RmWn1JLPfa92wvRe5U3yQ-1; Tue, 25 Aug 2026 07:39:32 -0400
X-MC-Unique: _RmWn1JLPfa92wvRe5U3yQ-1
X-Mimecast-MFC-AGG-ID: _RmWn1JLPfa92wvRe5U3yQ_1787657971
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b01965458eso3187097e87.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787657971; x=1788262771;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W9pdeWWHRe+ulBK3gEZu0WQUkg5kuvGWcShMYDJIIWc=;
 b=i34TP5Z6TQhIGToGmgqNjohZm/d43f+XWOpZxvgvauICAEjeANSZgdD3dk3UripD1/
 Z9MCAak5uI1jb2c3MWXdjBN0zlGXrukpjuKcvVyoYbwTEaXkaZHL1rdhLJhsXZe+RAjr
 Z4i0n1UTmtCbLAOdLqzJ+tG9AT0wac7PUYoHsTME4IT3Uicmt8Hma4tPvHmWL8I37HWc
 2CbkNLjqKuhgbCrt084USkFNwjYjxLnDqDrhnS3liyQYtogvQclgCWh0w4Q4k2+l8G4z
 bWaOQkGZwWDyhqkhurKole3vLz9a4azMrfWrd9tZj67aUJfrTDzdgoWAlo6XEiGKIZhB
 ZeVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLUGip99PKR3XOhmsfko1rrGK/3Hp8cnYs0wjsE8Y2hQ6L+yk1EG6bAk0pp2+OP4eBj3s=@dpdk.org
X-Gm-Message-State: AFuF++nqZPpCqWmDjnf5m/L3vv0P043A/L2RHkL8ZAKP+D/q1f7tDMXz
 G+ndhCtelu77WR1wZy4Bn2WKnNxM1G+1lMS9TGTNtWIs5ijuEev2zRI5jWLNRLT5MjpakRJGPdo
 J8FttHXnY0uOfodkaChJHuFVXpo+UlMhNHbHPj8uUJFkXnI/FxGvc91PwMRKZUICxeaMSNG5oSm
 ysGjDbwCT3MMUa83YrIaU=
X-Gm-Gg: AR+sD10AdaQswQHjcoYtTPpBJpJ5qYHVUGAvvzkSAA49NQLXa5YLiF5N/VyyB7DnpwD
 CYdMDYiAR5jMvGuYL7f1OiW0TPxtcvsqgv3bPv2+EU0WqWhnSObp/85i+XNfzyxAKX+2nl+YKKJ
 sUCyfNegN0UACIMmST1y/hzp2tt18/pXcreusGMDT3i9fq6QWhmt3XtOjIYqZdDcWvUOwyj+iFy
 QXyO+E75psB1f7xYAkFNY6BC/Ddke3TeNaCmPhNmAMzePb7
X-Received: by 2002:a05:6512:12cc:b0:5b4:24a3:ecf9 with SMTP id
 2adb3069b0e04-5b4842626a7mr10864956e87.21.1787657970898; 
 Tue, 25 Aug 2026 04:39:30 -0700 (PDT)
X-Received: by 2002:a05:6512:12cc:b0:5b4:24a3:ecf9 with SMTP id
 2adb3069b0e04-5b4842626a7mr10864939e87.21.1787657970362; Tue, 25 Aug 2026
 04:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260723153111.3943368-1-david.marchand@redhat.com>
 <20260723153111.3943368-2-david.marchand@redhat.com>
In-Reply-To: <20260723153111.3943368-2-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 25 Aug 2026 13:39:17 +0200
X-Gm-Features: AcwNN1UiLYr1yxQSkBMKDhQPGlA28zmTAzMnlhJHrS4RVVMlKMnvH1wYcUs3bvQ
Message-ID: <CAJFAV8xEMt0a_NgEvCLV3q9_NWCpjGhLYEKv=Yw6K=amTjE83w@mail.gmail.com>
Subject: Re: [RFC 1/3] examples: stop using vhost async datapath
To: maxime.coquelin@redhat.com, dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yg0wmr1bDnPOtd6Ppiv1iOgzjvTUvN0s2xlPUpRxceE_1787657971
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

Hello Maxime,

On Thu, 23 Jul 2026 at 17:31, David Marchand <david.marchand@redhat.com> wrote:
>
> Stop using vhost async as this feature will be removed in a next commit.
> The vhost-crypto example was requesting async copy for no identified
> reason.

Well, unfortunately, this was the tree hiding the forest...
I'll need more changes to avoid breaking vhost crypto zero copy stuff.

My understanding is that a call to rte_vhost_crypto_set_zero_copy()
could be used to detect guest pages mapping is needed.. does it look
ok to you?


-- 
David Marchand

