Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F5CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 07:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ABEA40280;
	Thu, 25 Jun 2026 09:44:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ECC694025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782373491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byMPe11llz3WznCg1MRlewTeP+dGYuIe0K/p2j40XaI=;
 b=MQQ/zApF0oyuWloBETVCfpeC87mlKX/yc7HJOGxgfLZTrQST1+lFEd9yJ/e4OmiB7+44zY
 JsOqCh8C5XJC03xffIbJQHIJSbWia66vX8aEsCqQQ3iNftL/cI1jDe++G2JGpXtmjXCAQ6
 JM0c7lSwV64oN+G6W9IkbjqyZPHM0Vw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-oLV3LQCJOZOoxZkr0oKOyg-1; Thu, 25 Jun 2026 03:44:49 -0400
X-MC-Unique: oLV3LQCJOZOoxZkr0oKOyg-1
X-Mimecast-MFC-AGG-ID: oLV3LQCJOZOoxZkr0oKOyg_1782373488
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3967fa2efe3so9646691fa.2
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782373488; x=1782978288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byMPe11llz3WznCg1MRlewTeP+dGYuIe0K/p2j40XaI=;
 b=aMRN6DfiVtk0sFjS9YQHEwxnMYHjJbQjFNC6TWEAYVAD72orwzIFd/uQ0GkUqSudqt
 c+SKYnKIfgm+Ub9TD5nUZMx9iXHkUWz8j6OJAwaDYWUQIEofr4t6A4cKIASqVVll5AeV
 Sekslf1y9rN1fWPTTkdArf5LjTLFomgCtf7PDvoOh3LGfKC6jdJHabcEaLeWn1Z/NrJj
 oed1mNJqgYURMVhO4ssPbh42uG9OPcudqYaHa/Sr7zZlqDULcm1++ieFTvPsFGG23Z2h
 ktx3z+hgmRs0E77YwxiWBl4IWeaAe+JFoUXtntwUycHtqyahVeayc6SaOlM90f/tYCkC
 kMOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD+RJs4rH/QxNz8MicvHzSyUtumDRE40IKrMQa8j2qyHLDViWkAX7nZG3PY/Q61xfnCG0=@dpdk.org
X-Gm-Message-State: AOJu0YwOlpMwlPwbMMgl/PgPn9Aj0sH6MDY+Mbx06jvSVfsNCQYTYmpo
 fikICacg1BC9hZfUUURnKMGTq8GnEagLI5XRH8iG0cTU6Kb3TMbxkIZAZ+wYxbhd/+lEgibPEbY
 wWhi+kVfE13eIplFJfA/U5tR35yd5d4dPXPy+tj9Gq7XSj1fCYT7Bqji/37aqRevCSE+L/+Hmbe
 R5Jst2mlmGN4k03rSfUjU=
X-Gm-Gg: AfdE7ckJBTNINwYqpPafGUf1wURG5q4krTJ42lvo9v0h7+pF6YzY46G9a4+Nt+HNeUO
 I8g0tcpQMNOlhyGCGpbIFX+ThZrttymZxSbG6NHC7ynqTQquXWwSnPqf7Rv7GeylXyX8NJPaMMv
 7/OBVyoSBgqhtNDdJrdEjn06I9v6jqegmFUnIciXFb6dPftyB/YfOtHmVX1r0hwqwPGAZZEbs73
 mhDfBSY1DypUu7UhFtoHsrZfuxKN1vfBIqausUgZOsWzS9l97GMAxJ7cN4=
X-Received: by 2002:a05:6512:3c92:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5aea1f4b99dmr390844e87.25.1782373488364; 
 Thu, 25 Jun 2026 00:44:48 -0700 (PDT)
X-Received: by 2002:a05:6512:3c92:b0:5aa:5ef9:a33 with SMTP id
 2adb3069b0e04-5aea1f4b99dmr390833e87.25.1782373487871; Thu, 25 Jun 2026
 00:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-5-dsosnowski@nvidia.com>
In-Reply-To: <20260624131337.1127323-5-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 09:44:35 +0200
X-Gm-Features: AVVi8Cecoax3eNI7p28q_dsyIa4B3rjHSFyEA1j37ZcpU8fLwBk_WZk98Gj741U
Message-ID: <CAJFAV8wZhj+WRGY5sWYQSHFHA_7XNhCNS7Hqf5xSzAEt3U6z+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ethdev: fix promoted flow metadata symbols
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Ori Kam <orika@nvidia.com>,
 dev@dpdk.org, Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2N5ZUHJRwj4RSmtdKNF2_V0_u_mZfB5q2gp56GsI5sQ_1782373488
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

On Wed, 24 Jun 2026 at 15:15, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Offending commit stabilized the following symbols
> related to flow metadata:
>
> - 1 function symbol:
>     - rte_flow_dynf_metadata_register
> - 2 variable symbols:
>     - rte_flow_dynf_metadata_offs
>     - rte_flow_dynf_metadata_mask
>
> Any application using experimental flow metadata symbols,
> which was linked dynamically against 25.11 version of ethdev
> library and using current version of ethdev library
> would fail to start on symbol lookup error:
>
> /tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
>   symbol lookup error: /tmp/dpdk-25.11/usr/local/bin/dpdk-testpmd:
>     undefined symbol: rte_flow_dynf_metadata_offs, version EXPERIMENTAL
>
> This patch addresses that issue by restoring EXPERIMENTAL version
> on the global variables to keep ABI compatibility [1].
> Related inline helpers and variable declarations are kept as stable
> (i.e., no __rte_experimental marker).
> EXPERIMENTAL version will be removed from these global variables
> in 26.11 release cycle on next ABI version bump.
>
> Standard function symbol versioning is also applied on
> rte_flow_dynf_metadata_register() function.
>
> [1]: https://inbox.dpdk.org/dev/m7s3jl2566kibbapr2mfa2ic2opuc6b4ok2g67j3il5dgduzih@cz5wcdstb75n/
>
> Bugzilla ID: 1957
> Fixes: 4ee2f5c1cedf ("ethdev: promote flow metadata API to stable")
>
> Reported-by: Yu Jiang <yux.jiang@intel.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Acked-by: David Marchand <david.marchand@redhat.com>

Once this series is merged, could you send a patch against 26.11
dropping this compat and marking the variables as stable?
I'll mark it as deferred in patchwork, this is just to have a reminder
to clean this up.


-- 
David Marchand

