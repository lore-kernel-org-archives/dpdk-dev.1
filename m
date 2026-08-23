Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92627C5DF81
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 15:43:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A79A40270;
	Sun, 23 Aug 2026 17:43:30 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 7EE6740265
 for <dev@dpdk.org>; Sun, 23 Aug 2026 17:43:28 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so2841070a91.2
 for <dev@dpdk.org>; Sun, 23 Aug 2026 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787499807;
 x=1788104607; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KPVmF9F+nZaOSA/4Mn5uqcnaPunheAdyqRcDFJfOQVw=;
 b=l6N+6LjTvcwKukhhxtQAr8uZ3mnmpZKsSEyt1wQ3paJwjJ2RzsVwgTLRYd2YqlfJ91
 Xy/oSUSxnjXJ2hUAGXlUa6Bg9OvMdTD+kbiqEBvaVOc/8dvwDhljbL4TTSjyJaQsLp4i
 L9HgH7GkrcIOcUVaHRERiz8/xIDltBh/2e6vozPX1RABIe4xn2rZBUAIveSaiuBmCrXP
 LONRkAX7pJh5tiJkB1YJJriFrLYFw3FNbe7tOPq1loMzr3qutjflXzj69iNbxtoaJpZ7
 rYdQHwLcyB3k0PUTt8OipIh+cKmKSGL8fdwdvi4/4PtFySY5FJlQk1PSOMqm3weGUjFg
 jdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787499807; x=1788104607;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KPVmF9F+nZaOSA/4Mn5uqcnaPunheAdyqRcDFJfOQVw=;
 b=N6uiZBVUL/mRmOCgDrginwLPbOHtCB88ZdkCQw8WOkFfFD9900nNzPrOCbjwK53izt
 sRMTMpCEFDyN6O10SwYprhRipB2MB4CP2Oi80syZs739T8W2TAOotwCAaWf661G2f5El
 sRpx7iKVvmpxJ7sBnE6tbOlX71U7Gaona+dsHBf/favVsnW1k9EPp+JLe3Vq2g5oDSF5
 D6thpgenAH2VFI1HEaUOMkn3/L3ut2+LCT/X7d1ku845afzls0vHfv/QBNB6cz7UnF+B
 FUF0rUs5JAlPQDgwjwaCEMZzB9gIB0FeMgwFawM+D702rJmWT0YWdQDs7JNwXZq2qolC
 uPag==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHSMaoxSdu7eaZA0yODgkh+QbQXJUa+T6QMHTcEI32XQyEhKTlcV2X5z2s+Tt/Bv01wd4=@dpdk.org
X-Gm-Message-State: AFuF++ndyr9ErMOFexiXVRCjtfI8L3+MOO6lyU1ZB7HkqNYwUBdb/LGf
 2HAdU2eDUy7q2WBfsNsA9aLNpcvhCurPrcLFJGNkCwcOr2CTBqeRZeLq5/DtEATR8UM=
X-Gm-Gg: AR+sD13K3Xt4+mJ/tcJWMXZzL/W5YGTiXOERB3YgAdkzAnfbRpiebWI8MvH9C/5MZT9
 ctvSqA6DGwqhe9VnG/rHV8kI7P13MytbT1RUrJtO366aSws3VcGbgCeVdItyCj3xRFokuyvWhdK
 LnEzazlMNRxcKuIA+D9K1YHSnB5G+aYeEQ5KXVWKIgzJ5srCA0TkVfq+3CYnmpkuZaDpCgveQ0I
 EpnaF1nKtnmccI/M7Hd2EDOhsT5f3X2qD6u8wsQ8e0cEuE31pDBf04GrFMGqZUpuD9/b8kcUyWP
 S09n5CAHC9P7VDSAA5wgFm1N7QYmijb4y47SA5F5qiTgduVdQ/l+P9jBjItY0hc6ZN7ZLh1eRwT
 hq98w2kPRo6UBUsoV0KyEPltoCSmJP1oOFfnQGvxpC+HzkB/sR5RbSTrf63750Uidk36z/z/jsn
 omYYZf2ujZqIQkMfyDaP6c5vpaKWldnJ125ZNe3iY1T6ShH9ElyR0DGgeAS45WwKJwVUp0l8YUQ
 YXdZPeU+Mlj+Qq+L9DjBkvviucl5A==
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-395df5e8fefmr22812222a91.16.1787499807411; 
 Sun, 23 Aug 2026 08:43:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c9174be7sm3087674a91.3.2026.08.23.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 08:43:27 -0700 (PDT)
Date: Sun, 23 Aug 2026 08:43:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH v2] net/bonding: restrict secondary control operations
Message-ID: <20260823084316.75b12c6b@phoenix.local>
In-Reply-To: <20260823151625.18687-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260823151625.18687-1-wpan3636@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 23 Aug 2026 10:16:25 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> index 2fa1ac4028..7ecb05d407 100644
> --- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> +++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
> @@ -254,6 +254,19 @@ Like all other PMD, all functions exported by a PMD are lock-free functions
>  that are assumed not to be invoked in parallel on different logical cores to
>  work on the same target object.
>  
> +Bonding device configuration is owned by the primary process. Secondary
> +processes may attach to an existing bonding device for query and detach
> +operations, but must not change bonding configuration or device state.
> +
> +In a secondary process, bonding control operations such as configuring,
> +starting or stopping the device, setting up queues, changing members,
> +changing the bonding mode, updating RSS, changing MAC addresses, changing
> +MTU, or configuring ``rte_flow`` rules are not supported.
> +
> +Secondary process datapath support is limited and bonding mode specific.
> +Applications should not rely on secondary processes for bonding datapath
> +operation unless support for the selected mode is explicitly documented.
> +
>  It should also be noted that the PMD receive function should not be invoked
>  directly on a member devices after they have been to a bonding device since
>  packets read directly from the member device will no longer be available to the
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..8df012c99b 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,12 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated bonding PMD secondary process handling.**
> +
> +  Bonding devices now use a secondary-process device operations table to
> +  keep query and detach paths available while rejecting unsupported control
> +  operations before shared ethdev state can be modified. Bonding-specific
> +  control APIs are also restricted to the primary process.
>  
>  Removed Items

Mind if I shorten this text, it reads like AI autogenerated verbosity.
I.e 10x longer than needed. Release notes especially should be succinct.
