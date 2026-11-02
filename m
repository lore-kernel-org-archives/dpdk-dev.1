Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B15606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCIXQ0nb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2A640E37;
	Mon,  2 Nov 2026 11:37:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id B41EF40264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 11:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793615876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IeduznZS4L0djvpYBRbWmBxnkRyLRcZ1OBOQytYFvsM=;
 b=MCIXQ0nbR/QF6Y176uBJk+cq360abNrAkMVKtTlNvfpKMfDpYv+8Bhc6FoOGyMIVgFvn5m
 AqZDOxa1iB5kFA0TMG1ffHhAWc2ZvAFchKz+et6hOBv0hlzs7sSEms+fibNNyillaS91oI
 5/njScBd85fJLAA7znS7KgLLdu32Wtg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-0yx9gVh_PP2kS9IJZe6pSg-1; Mon, 02 Nov 2026 05:37:55 -0500
X-MC-Unique: 0yx9gVh_PP2kS9IJZe6pSg-1
X-Mimecast-MFC-AGG-ID: 0yx9gVh_PP2kS9IJZe6pSg_1793615874
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab442d8d13so12153321fa.1
 for <dev@dpdk.org>; Mon, 02 Nov 2026 02:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615874; x=1794220674;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IeduznZS4L0djvpYBRbWmBxnkRyLRcZ1OBOQytYFvsM=;
 b=JvSgqsH/a0+XRgp9SeWmfgoIw6YUK3f2i3bkf7ho1haqpqtwmJnYKAVxWeKh0Pil6N
 GRWvPAdNpKpp/kT/9S8pehPoYxLtaUDGcvu1WaISkvalPnOHok1PtFzcrf8KA5UpYvmD
 8Soggcw67K6GRHK9E9/K+A210ZAfo4y9ROj6ZVYk2LXZ4vAymJioREK08LkDvHTbgohO
 4AneoX6uWU4eMbXqF3+x7b9c81QMUePCZQTpZL3GfO3DLa87t4zSvU8zSwsMuR+Rngr3
 bUJkUEJaXDK7vb3fnY9ohXa9t9MotLTbZmzyBwHR4dPigYHcro5DC0vg6dZjKFyeZvfr
 bSzA==
X-Gm-Message-State: APuU4Z+xN8jNwXPZ6h6HoBH7VMTTmFUiYqMjNbts9xHE7cfA3D+skheX
 d5PF7FlG2OeBEVbOzGFdhZ2FIDbNAQFD/OqHjSI8IRd0oaS5hrBQUPgMPWhIkw2IhwJ0rjNV4sn
 cSw9ObX10of+TzAtJz34pFoHz9kZ8Aeh6wApMpw2nocaPnWRjt2j4+2vaLm0V2QK7nPj0pbV4m5
 H4uRnFyMC8AZ45+CXahT4=
X-Gm-Gg: AYBFou0WvyMEwtGl7ck3STnYZsbUQucIxCx87Zb0pH8SH/dch/Hn+xR8S9fEXpbgYmC
 fkbF0zQNtpTFIGevJ1iUzJXw/5eM0rHtOkP49hCGoIECyrNpZ/BhrjMEq3w+lJ8KJYYKBq5Rmpx
 xKlvnjH1C8Vg7D/bsNSNHtvTM78lveJZkR6QgT9UCRX406cTVXWfEEsroWuS3C9XAx0a+M2dBC1
 Q8bmdKmDOJzlljtVsV7XjCnxJ1JEm1svB1I/IgtuZUp/1hS
X-Received: by 2002:a05:651c:a114:20b0:3a9:a2fd:5931 with SMTP id
 38308e7fff4ca-3acbf811634mr13481491fa.6.1793615873830; 
 Mon, 02 Nov 2026 02:37:53 -0800 (PST)
X-Received: by 2002:a05:651c:a114:20b0:3a9:a2fd:5931 with SMTP id
 38308e7fff4ca-3acbf811634mr13481421fa.6.1793615873408; Mon, 02 Nov 2026
 02:37:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260909144631.1122673-1-bruce.richardson@intel.com>
In-Reply-To: <20260909144631.1122673-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Nov 2026 11:37:40 +0100
X-Gm-Features: AclHuK8E2i3rY4yf8x1d16XUf0IBAcEPDRnKXu-T7F2qqf2B7S6uy133wSkUpwM
Message-ID: <CAJFAV8wni-RRh2indV+-ShJ1uby4KygWkDD3To9b2Ny_9-BwwA@mail.gmail.com>
Subject: Re: [PATCH] usertools/telemetry-watcher: fix hang on startup
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: COgDF9mtwWPujMcTmZ61mGiCkJKLU5xhsdjpspUJ02I_1793615874
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 9 Sept 2026 at 16:47, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Commit cbfdffb1083d ("usertools/telemetry: load aliases from config
> directory") added an extra printed output line to startup of the
> dpdk-telemetry script when an alias file was loaded. This confuses the
> wrapper script dpdk-telemetry-watcher, causing it to hang on startup.
> Only print out the message when script is run interactively.
>
> Fixes: cbfdffb1083d ("usertools/telemetry: load aliases from config directory")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

