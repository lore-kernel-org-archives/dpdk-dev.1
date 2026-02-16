Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C49EF5872
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D6C40296;
	Mon, 16 Feb 2026 18:35:51 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id F3A5E40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:35:48 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359a302794so2391660f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771263348;
 x=1771868148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIIt9u+C5uvy0/eRHot1KPjiDwHC710PmNYozobnBUs=;
 b=PpifCmy7u12ZOMxIMkMCLO8FGPZuRjekb2WFxOaBLhxW9F62ool5JbySf8Csvfe9m2
 MibQbhuiviBUxZh4d/Bs7f/aEeQghh1XP1dTWwDEGSZxihgijwpArtseZV3BpKnwX//h
 /KhaPXTsGRyyHlGorKTMbGEhLRA+5pyI43J2fJpAFrY/btQOrnkQB51B/yiRNnP2WiQq
 /+Jd2ZhwSO+qP2DqES3KnvFZ1pBYjtjz4LAYeulC9vh7xo1v7xLvpW5tNPULrrQ8EnWh
 uXi/xZNiGkXd/I05HIdPnU7ujjgQ6276ZgCEQ/h5i34R+BUFLJ17XobGGxNebAxBzenJ
 4xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771263348; x=1771868148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AIIt9u+C5uvy0/eRHot1KPjiDwHC710PmNYozobnBUs=;
 b=PT8WJRZMgKMzf2475s7dOozHWQDifXwhpkQ3rce6FZzvUCtuXe5XtzA9ggJTS+1Fa+
 bxi7Reb3H/Ss4kD11CVQ6Z3tZ49gIXHDg6sdzDW+ncR+1EkSwGsHFL2CbgRiUGW13dCn
 NJoS14lbzkmhvr+IKs8GNSkeNRRDpUD9yVVF16mxc1rmIgYfx8H3hdlooVfgWqrVOEXz
 fkMMH1a+todBzSdRP64k+18q3vxCbZVE9qv/mpRiTpdmHK7BNREiPRfvaBgYwN4X0vTc
 6F2nhpFuJkNwnJmuP0swAvcUY68ZfBP9GltM+4MA3APdwJvubqSkPGMDUZa7B9/d0IU8
 kRXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4s5LDgq4UYjaRAvlC9JFca8VbFtxxVbsEZSItEVhV09zZPMVfoC1zLgi/MaHEDXFy4X4=@dpdk.org
X-Gm-Message-State: AOJu0Yz9vdw+LNIrtpVOKvTKE/EsN7ag8eqSQFyd8f21WTF3XlmUTI89
 GLmi5iYmPLbXke2iPNzlaACmr0kZtyr2FqCkHt+iuursH1E4mMANb0zSVMegjPSI+Sqdc9juXag
 MuilzkM0=
X-Gm-Gg: AZuq6aLd26ZitRzSiKJE8G0XGUUMPx3rAuzzolnvwcWfo0lRRckttrEXeYD+HiF6w0Z
 jdm1BOIE/+S3+pInA3m4VBoNHDl5nCkKlZX5eoSNXfIJwnlCMqAyQfPFhQr9jF/2kBIvr08TCei
 s6JWn3OaOCJlutjlAxzrShabzzUUclIcH32iYyYZcNqriqSwyVGOCkAPQGOEts5WzqPi/5uVtQH
 TMtiy56AqtJVFwbEAHIVGzpWVcV2kLH2Za3mmqwTVlQjqURT98kSdD1wrvxPRdS8XMNlbuZhs9R
 kdvALxvTspKGXFW51tCNqmA0WfG0nDTyML72j0V28nsikk1JYU6GUihzR/pwyfiuLadf6LHjiNg
 2ygZ9QP/NuLp3zuDFSe5Z3RB7VUdMbSh2TzlUjlpG1l2QCNrRs2miBkoG3GmPKyQkhEsb1sM3th
 1hYqEONimfKzcmM6645+5/ZP7FK/9P/66daUpp0+iWfJ/pNU0Sg4kKR+8ndsro6T6T
X-Received: by 2002:a5d:5d05:0:b0:437:771b:26b with SMTP id
 ffacd0b85a97d-4379db71b34mr17638891f8f.26.1771263348445; 
 Mon, 16 Feb 2026 09:35:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc85csm28278306f8f.22.2026.02.16.09.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 09:35:48 -0800 (PST)
Date: Mon, 16 Feb 2026 09:35:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
Subject: Re: [RFC PATCH v3 2/2] mempool: de-inline get/put unlikely code paths
Message-ID: <20260216093542.5dec7c28@phoenix.local>
In-Reply-To: <20260216152320.105312-3-mb@smartsharesystems.com>
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216152320.105312-1-mb@smartsharesystems.com>
 <20260216152320.105312-3-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 16 Feb 2026 15:23:20 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * @internal
> + * Put several objects back in the mempool, more than the cache has room=
 for; used internally.
> + *
> + * @param mp
> + *   A pointer to the mempool structure.
> + * @param obj_table
> + *   A pointer to a table of void * pointers (objects).
> + * @param n
> + *   The number of objects to store back in the mempool, must be strictly
> + *   positive.
> + * @param cache
> + *   A pointer to a mempool cache structure.
> + */
> +__rte_experimental
> +void
> +_rte_mempool_do_generic_put_more(struct rte_mempool *mp, void * const *o=
bj_table,
> +		unsigned int n, struct rte_mempool_cache *cache);
> +

Don't you want internal not experimental on this.
You don't want or expect direct callers.
