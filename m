Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C539FCC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 22:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF0D04025A;
	Thu, 15 Oct 2026 00:52:32 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8473A40144
 for <dev@dpdk.org>; Thu, 15 Oct 2026 00:52:31 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so3137211a12.1
 for <dev@dpdk.org>; Wed, 14 Oct 2026 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792018350;
 x=1792623150; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7YRgxIlFK6gZXGRAIkUB/Zp/Tt7r5Lnpr6tXiZyjqc=;
 b=gktVUmkpRua382X/LjOhoxWzxwSHyzuYNGL+nzBO00hQ9t1yBN4Z/VhdqEylQLSwPt
 YSmmS2QHRL6PLI8jE+C1GhHBdPEbujxtwI2igFqqn5DNerUNmTXKz80X6P1n0LcikXRP
 jbF8GOa3CTUR391AaoFIjn/PoRKlzB9ms5zg8SkooCRdHq1PxnF2ppHtPPANG6jyU1dU
 59kRKYfN/VopF48UGVn7HaIkhDti1g5oXzYkye9VVvTSnmyxBUe5iX9OAaT/w8X3wIsh
 0N1J8fDfVbhljEx34jAJJTzJxHNPGyq6wvpnTorKqlhRnG6LVP5AFhIZoQpJ+fcPs8UE
 cOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792018350; x=1792623150;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7YRgxIlFK6gZXGRAIkUB/Zp/Tt7r5Lnpr6tXiZyjqc=;
 b=KpcTSAcBRfJbw5SxyUpR7qzqYHeBLq5xlc+lgBZchigI+WIug6dEbCJuo0/zX9CLx0
 39L6IZqXN68aJGGdoieZIjeC6YX/j+Gl3vTj/yC7iVtsV/FKasd/RphfNp4wmL1DBPsd
 +y74bU0oxm18rybWT0jz1c/6RBFSf66/oHu48v6JjCrXlIGuGiqCSdr7DwSCBDX02PaD
 cytOjm+dHpo9Ecf5OW1i3U/yYtJYaAgTg40SOUf2mj/QdHGR8LOpDp0YdklLRUBf+Cjk
 bYNE3ZUK3+x2xgZ4Nc5gAMceEbAp0Z7FkwlrBQIi026+/WRYqgRk29VTPOO4bQ/rjw2L
 iZfQ==
X-Gm-Message-State: AFq9FYK/MY9u0yCufEXJjjhha7ReS0i5ADWCb5qwDD53gC+oYuGaaZ9u
 jhGe9oe1Y2ng4N406VGzQvur5vk/YHVa6bf9HBjqZl0rQxMJISTHmuS55EssE0BEuIk=
X-Gm-Gg: AYBFou3GS+m8QnkCEPMElHhY7Mg/A/gcdBlHL8Nu9QdIC9OKWX2WZkM500aosV+VH7v
 ptBcsI+8EE4k7W2eeSJG849D3c+qQnzlWWcDfgTKjYC+AqCWdEMpFdb4VvJ0Hf0YlNLz/tXGfac
 3ce5w+tsJ5PXBjRoJ4BIABmfMdu42XuSM2/RTR+wUpBCVRj6E6f7qu+o/c5ugQtMfmOIO/Vgh+Z
 75NPVQ90/FV+4CDcTZEb4l9ChPCtcHKVC+tbCI/VYaoElFURMOaocUyLR8hkE6QE/yK94OGrOMG
 ixoc4qidYDHqByyw4IPWCBqb0pfVrhHQ1uTYxxbCQ2lD2nq9/jq1hLs3am00MjzMRMX0dY6lUWo
 3FfzuUPpHOVN/ACmViTOWINQ20rOsb1Tn0KG8+GU1Ep5fFhk8X9yWYC72EmYSQjKwEMhG/eofFI
 PmtglYAVgm/iBVkdKMlaPzPZt5TF3Y3tUau2fUOpcleehEgIANuSazUbqkcRp7SHAJp6fqM229D
 p0k6+rvsHS5sl6MdGR8I2H6XVKm9xwj2x2cevxS
X-Received: by 2002:a17:90a:e70c:b0:3ab:1a5:cd2 with SMTP id
 98e67ed59e1d1-3ab3ac9b310mr9499817a91.35.1792018350430; 
 Wed, 14 Oct 2026 15:52:30 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9377fe6esm790332a91.3.2026.10.14.15.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 15:52:30 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:52:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, mb@smartsharesystems.com,
 maxime@leroys.fr, konstantin.ananyev@huawei.com, stable@dpdk.org
Subject: Re: [RFC PATCH v2 3/7] app/test-fib: fix size of the tables for
 large counts
Message-ID: <20261014155227.0ed1cf10@phoenix.local>
In-Reply-To: <20261014183921.495158-4-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-4-vladimir.medvedkin@intel.com>
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

On Wed, 14 Oct 2026 18:39:17 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> diff --git a/app/test-fib/main.c b/app/test-fib/main.c
> index d85d94fdd1..0bc8dd2aa4 100644
> --- a/app/test-fib/main.c
> +++ b/app/test-fib/main.c
> @@ -1260,12 +1260,12 @@ main(int argc, char **argv)
>  			BURST_SZ);
>  
>  	/* Alloc routes table*/
> -	config.rt  = rte_malloc(NULL, rt_ent_sz * config.nb_routes, 0);
> +	config.rt  = rte_malloc(NULL, (size_t)rt_ent_sz * config.nb_routes, 0);
>  	if (config.rt == NULL)
>  		rte_exit(-ENOMEM, "Can not alloc rt\n");
>  
>  	/* Alloc table with ip's for lookup*/
> -	config.lookup_tbl  = rte_malloc(NULL, lookup_ent_sz *
> +	config.lookup_tbl  = rte_malloc(NULL, (size_t)lookup_ent_sz *
>  		config.nb_lookup_ips, 0);

if you are going to change these, then fix a couple related things.
  - comments have bad spacing in there
  - use rte_calloc() for arrays
  - not sure why rte_malloc is used at all, this is test code. Doesn't need to be hugepages.
