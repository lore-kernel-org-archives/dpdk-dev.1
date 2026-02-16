Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363DEE8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2ED4042E;
	Mon, 16 Feb 2026 23:26:29 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id DCE3D4026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 23:26:27 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-483487335c2so34249955e9.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771280787;
 x=1771885587; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0gUriVtpOtr8AsetDDWw636sUg/tfpMjOHt5Lq7TTQ=;
 b=u9f68GbFYhjI7hc+0sb0S2Z7LcnbWfQoUggMQISDBSdTh9IrXzdRUxBYgoR6af1L/A
 jAIZ5sdhTVXxPQEqWzlCIf8M7a1W4xDp6aW8r2YGqrJm/UNrd3ypQ/K8B2W9Z8h7e4Iv
 i3I/rojppVetXZu3bGLimx/vjo/aYK/Jr6lKFf3x3M/YboDED4fkT4/f7bfmJMfObgZa
 87ENuWrmlUGxFUAbB77E5GckjUmH9zmNso1t6qUoBUF2Cdf2fQ0qsaIKKqtXU43EdKdD
 NIzVCpdkjEnNIKtxbpXGx0nPaV0yaHF/aWX4yK5aXfCkiNOEEgv8tBEflu7TcxH0FU6u
 Fp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771280787; x=1771885587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S0gUriVtpOtr8AsetDDWw636sUg/tfpMjOHt5Lq7TTQ=;
 b=X6q6gzWR8XaCbEJvaSgC/LUEbCbJeQ7CKTQw331vgGZMOdkCADmR3OewPEodlpDAcX
 u63geRKjHMOCm6lnhBh7EZCa8WcHGVcN4jJx9n8z/3gDnvfufFn0K1j4DsycxvYisBDQ
 zR2+Bxwy9mpMJKFJ5l/uR+kaBsjF+ZoQofp4aIb7qX9fL57DTJ7H3rC7ddpxwlq6gFCD
 KPFq/HAl7U0qgvT4r+TnR76wRa2YJ1cy/lpM6ShNhJPCO3EOTXJp6qsDYhuYByeXa5eZ
 sytjCmWRWa7z4v5FqOjp+SYZDceu9UwVLf8LfFYZ3o6B4pG0YmtLH5HyaRpWqjn/wmZm
 yN9A==
X-Gm-Message-State: AOJu0YxR6QSE2sbV7A+MHsK9uRkCPXUBxR29+4GIvITbZQFQWoPkPOR4
 GK12Bd560TAwRn/S33kH0UValFIOKrcIGkzjBPZ4U9MWLDH0dxZEgk8MWEkTvvGGCd0=
X-Gm-Gg: AZuq6aJvAhgjfHAKjwTJHpS1mK74cvW6Vtsydy2/EBKn6S/Ya0CfZTvFiWtDdp3iBZ2
 JEjWDS/i+EFIVCEL2Cu4p3/xegB8VfwcxwRol1PxSXOBMX1gRtBP9e2OPVmMdmvvAN6ammkzEp6
 0LV78K9UGz4etWe9qRmqLY41p6XWHVgf0++TQKMFI4OS+Wb62flhiTSyj1Ihj+HsHQQsD5EITKR
 /tsPV8/Ghn1ODGsP9gPQr1NqY2/+RHb1zckLMTSoQvfCV9JFVqXS5UNqNhIeH3DYqEzAPb2sjHS
 mUGn0ZN4vHH90GwWswE1GdI8wNWHnQtdIXSsmbGfh5dwoy1UtYAWLo6KGPLKKbk7CRibmPIuTHS
 MuGpe4CFfa7b7yWtMyO0WbwVMeO8lPkHMNgHAgCv3Mt+G3kDjKwcuUdWCLp9n98Rq8ikhLmwTEU
 +AlNj4xFM4H46bhnaW9YHqPgx5LTIksECUxp/1+1easnsWRhH9C1ixcGB3yhlolvJA
X-Received: by 2002:a05:600c:3e88:b0:480:5951:fc1e with SMTP id
 5b1f17b1804b1-48373a02bf6mr174017885e9.11.1771280787306; 
 Mon, 16 Feb 2026 14:26:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a3ecadsm113717815e9.3.2026.02.16.14.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 14:26:27 -0800 (PST)
Date: Mon, 16 Feb 2026 14:26:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Congjie Zhou <zcjie0802@qq.com>, stable@dpdk.org, Anatoly
 Burakov <anatoly.burakov@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v6] eal/linux: fix fbarray name collision in containers
Message-ID: <20260216142621.2b9882f3@phoenix.local>
In-Reply-To: <CAJFAV8w2SEdV1QNshrrN1bEtQhD8KS7ajK+mH9Y4jDRemQp9qw@mail.gmail.com>
References: <tencent_B09D0FCCA142E4AE5ABFE584E92DCED8CB0A@qq.com>
 <20260213220127.265020-1-stephen@networkplumber.org>
 <CAJFAV8w2SEdV1QNshrrN1bEtQhD8KS7ajK+mH9Y4jDRemQp9qw@mail.gmail.com>
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

On Mon, 16 Feb 2026 18:22:48 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Fri, 13 Feb 2026 at 23:01, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > From: Congjie Zhou <zcjie0802@qq.com>
> >
> > When multiple secondary processes run in different containers that
> > share the same hugetlbfs mount, the fbarray names can collide.
> > This happens because containers use separate PID namespaces, so
> > different processes in different containers can have the same PID.
> >
> > Fix by replacing the PID with a timestamp-based value. The TSC
> > (timestamp counter) provides sufficient uniqueness since containers
> > starting at the same CPU cycle is practically impossible - even 1ms
> > of startup time difference means millions of cycles apart at GHz
> > frequencies.
> >
> > Also, reduce the name buffer from PATH_MAX to RTE_FBARRAY_NAME_LEN
> > since it is only used for the fbarray name.
> >  
> 
> Afaics, the filename generation comes from:
> 524e43c2ad9a ("mem: prepare memseg lists for multiprocess sync")
> 
> > Fixes: 046aa5c4477b ("mem: add memalloc init stage")  
> 
> This change ^^ only moved the point in EAL init where the name was generated.

Thanks, I didn't go digging back through the history and was more looking
at what to blame.
