Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A1FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 21:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8441E40662;
	Wed, 29 Apr 2026 23:40:38 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 355E64028C
 for <dev@dpdk.org>; Wed, 29 Apr 2026 23:40:37 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2eadb000b8cso597078eec.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777498836;
 x=1778103636; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReDWvMCjB0sFD9OMhRi//fxFkm2jCxdaMg9D1aJ6hUM=;
 b=xTKfWq1uqYz++qnqp6cngkvs3QZPLljjNfNr6Q0sPEfBf6ydL/a3zLjnXWq1fZ5LoE
 FAuCb2HUzNBSbu0Iw7OyRnXd3UyXxJtBhaaH5mKTQ/0qlM0C2ttwGcHWcClJvKoDEOQa
 iZTZB7UfaUUV2LRfQcz6KYjgbJ5huxRNkJrP+SGqG1qC9pT1Ml74j8SViBHYOi/R3zhn
 g9rjhGC93isGIuPRq4qJ+DCoey+d2htz7T2pL1SEUThR7UeGvGEMWZ0tRBYCjeX+5LQo
 gMMvy8KU69OhkaP1MfV6RsCPXsvYxDXIx5EDnTGJ8Gwq1fLcC89WR+YjMvbKwrZkmXTq
 GUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777498836; x=1778103636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ReDWvMCjB0sFD9OMhRi//fxFkm2jCxdaMg9D1aJ6hUM=;
 b=Ncl3RzyCxu5FxtzREqjt2t8Rifg7oxeor7+s3hMo9JrKf0qq4vFwkhLoXYX4q9SP3g
 MxQJOcbbhiVhlUfk8qikHgck32m1eIsxpgr8mU2IFBD9D11RyIGtG6B28/ludubXqF3B
 APVfzmt7YXof7vfmWNog6P3Z1V6tKZiP1A+R31eLq5zhHyMJnkKMM9wVxwubnux5m8tm
 ww/A5WNkIIwjIhsJpkHvpYLjXZM/oOJbTzjbTgbWw6oATLkBSTixU7/++cC4kYgsw/hf
 c2sdso3g//OefRyRDN5hEpK6ZqPO7kFinUjIfXlRr+ATe4MWzu+eyrVw2mBwH3BcRQal
 qB1g==
X-Gm-Message-State: AOJu0Yzkqa43GCzR5W16snY5tMhYgfGp//TGKQ3Hm4CofSJ6nCmU0Dtt
 QGW850BpNXrJbKZiGIZho538FZXWLJ44vHNckXeqkDKAx8lB8EAAmvV+HoPocg86u3Q=
X-Gm-Gg: AeBDievvtlv1qQpv5cElPfBKYEj+qim5YA1aDtgDu7z6DjgqAZsVSWZiNZVoPMmhPde
 FyIdbJh51Y27c02Hr1uBqj33atnmG88B6GqYePI4F2WIgmeHevGVUYbK2XFH17BWblJoE0oGjxK
 bVpmoiOKTj3wFUhjHKfV6CVeBJzdq2J0Tx0AMnXE7RYi2sE2VCDTDEuMzdLqmhSbp5hWP4evyn2
 JXi/1yQnRclcrIM0S6jUEIyUJYRCSMtv0AErS8squnI9OXo5ZkzGscoPgd3GQ4Ko3MSUzx7iyv+
 IPF+Rr04+3PRPXfwmMsIkQDNUz7WTe//DyHGpmyrTtzihhBu2rc76SkeGOobGbd/b8IYKN5w6C8
 YaqrWOOCBBiesYGEYMewjh/ucTpRgRKDXdGTegH2AcVyoeGHNmtvKUghlKs+QHahbxxaOKf9So7
 rIBoiqQGCedutq0kW2L5T/c4a89wCwovTJw+9kP34jEgGjBA==
X-Received: by 2002:a05:7300:1491:b0:2c4:ec89:bd3 with SMTP id
 5a478bee46e88-2ed3dcb592emr34000eec.24.1777498835884; 
 Wed, 29 Apr 2026 14:40:35 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e7absm3980911eec.10.2026.04.29.14.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:40:35 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:40:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [RFC PATCH 00/44] Allow intitializing EAL without argc/argv
Message-ID: <20260429144031.1d8dd490@phoenix.local>
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

On Wed, 29 Apr 2026 17:57:52 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Part 3: Prototype of an eal_cfg library
> 
> Once we have the internal C API to init eal using a struct
> rte_eal_user_cfg, we can create new libraries which provide alternate
> ways to build up the user_cfg and initialize DPDK. Patches 37-44 have a
> rough example of such a library.
> 
> - The lib allows a user to create an opaque rte_eal_user_cfg struct,
>   which can then be modified by APIs to get/set various parameters
>   before calling rte_cfg_eal_init().
> - An alternative way to do things (not prototyped), may be to have a
>   library that creates an eal_user_cfg struct based on the contents of
>   an ini file using the configfile library.
> [Both these options could be used in parallel. Note too that both have
> no ABI implications for adding new flags, or making old ones no-ops!]


Ideally cfg would be ini file.
But the existing ini file parser has lots of issues and is really
not that usable. Compared to other equivalent non-DPDK libraries.
