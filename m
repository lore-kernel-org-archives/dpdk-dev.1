Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF7CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EDE74025F;
	Mon,  1 Jun 2026 17:11:13 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 0C3AA4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:11:12 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304f590dd91so2663581eec.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780326672;
 x=1780931472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npUVD0xM6l00lh8NwKPht8VZaWfNrdvBvFP26nsCT3Y=;
 b=GgSoVXhHDZtyI14DCNx/ZO7HHH7qLrqNeoi9Jd4FmTjsQ3nfsis/ZfsxpUPgRceJyH
 kcd7qEbsc7xqiHhFwSEciawPoB6aaYbJlrfGhavpWadxwlvmLj/RmcHw1BOgHEyoagqx
 KrprFyreTAUpmuvNKcafrnuRAIG/z3VtFk+6Fa/6RloAbA7riGdyZBTXquv3di2IngK7
 8HQiTg21nhPwXptCjpuPTANifvLzM1Aw4O8LcGjWo+0Aceu/149LOjCkfLSc2iWqpNFM
 ubABYBcqGDUHkL21bzIgrblWS8t8bWcPu+ce7qubTTf+hiCO5wsnJSoqAVF2MCUCsN4B
 eW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780326672; x=1780931472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=npUVD0xM6l00lh8NwKPht8VZaWfNrdvBvFP26nsCT3Y=;
 b=XgorLsW0uJXfLPgIGbqjOjy8UGADS7wVqpdQEaPygE3m+wea+1vUDfBkOAYhppN2dS
 n+8rvJ54ue+6pIwEYv8Xu5eDAIgPN1MqvsiPE+h6B8zUSwBZ/OSTD7vLpC0wepW6AB60
 o4XFCWFEofIC5+ura3h6gB+LXwHkyG7nIn1ZXXifrBkSXynI3HBa9Wpc5XhScjy4SYBN
 +sLsDNtlNIgh6/0e/zHkBHKMZLlgQAt7yKDuqFYTblKJC2W+b1N/o03Y435165HnHRP6
 VFkSSiWhLolIsLysYCp1D5DbbshnZPE4mHU8TVDDP/xFb0tNWwqwrHKd/vdvPcRrjjgc
 lRKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HFrBszP8sa0HKwNUC4ZaESPaohtGddppIH3K91T+ZSq7A7rc0gBCUN9N17lifwEK31Fg=@dpdk.org
X-Gm-Message-State: AOJu0YzvrGnE8PDsgQr1tXP0o28sX79QWrdjdAFCOQ5IIKrDKCJoiXPj
 DXrFuui2HXvaKcN25LmARN0EjnbgHqQUfikJD+dHCFH/gqK9lbqBl/lbM9NyrgHb5JM=
X-Gm-Gg: Acq92OE+0jaoEsBblBJA8eCA7JItnoFoOwmnqgk2mu7aPe84Mn4nyTkEWbC2YchHxOX
 H78Kyg+Gz2x25z6GmB2bL7F+knGHv77Qwx3JZztnS/w2aWf3gDBNl7bOIuIcnsq9XxZvw7xIFGG
 2cVYBDNzoqlWQDKjIU/Y3HY5vipxbT3Cs5sC6pHLTsWJTjD0zJUQzlI68Im/BVikZ49KsxDRb5j
 7h6gSqwha0f0UOTm04gCA/RxP93OflZC0UIHDM0WWmUldwtAcZip5PyemoS5SD5BQ3BEEftbLCE
 dhq1IcXHi94dwTSl4aZ0AhuDXBkUhVb+NzmnlllxwvIxU46izl1Iw01N1mMS9rO0h+KIDbssRej
 NKQOyr05Tj33WQSDsp9VwDT+WynpvIj+ynDWegvVpN0gNeGEPueD+qRUNjHOel9sYcqooz421qN
 HuIRGTiUGhgaHLhsdMoMyuumrE9KrUkuakSIF3Ft6DB+EdKWHW+uhgLhdzRVZYMWVAaJR1w5spy
 gc=
X-Received: by 2002:a05:7301:2926:b0:2da:2ec2:64fe with SMTP id
 5a478bee46e88-304fa67ab4amr4778227eec.24.1780326671825; 
 Mon, 01 Jun 2026 08:11:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5b9be7sm8711763eec.27.2026.06.01.08.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:11:11 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:11:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, Aaron Conole
 <aconole@redhat.com>
Subject: Re: [PATCH] devtools: add Vertex AI to review scripts
Message-ID: <20260601081109.49968797@phoenix.local>
In-Reply-To: <bUYoD1-ARAaefqQHkOtV4Q@monjalon.net>
References: <20260601132402.1125588-1-david.marchand@redhat.com>
 <bUYoD1-ARAaefqQHkOtV4Q@monjalon.net>
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

On Mon, 01 Jun 2026 16:21:25 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 01/06/2026 15:24, David Marchand:
> > +    if args.auth == "auto":
> > +        auth_method = detect_auth_method(args.provider)
> > +    else:
> > +        auth_method = args.auth
> > +
> > +    if auth_method == "vertex":
> > +        if not VERTEX_AI_AVAILABLE:
> > +            error("Vertex AI support requires 'google-auth' library. Install with: pip install google-auth")
> > +        auth = "vertex"
> > +    else:
> > +        api_key = os.environ.get(config["env_var"])
> > +        if not api_key:
> > +            error(f"{config['env_var']} environment variable not set")
> > +        auth = f"direct:{api_key}"  
> 
> Could we have such code in the common file?

Yes please add to devtools/ai/_common.py used by both review-doc and review-patch


