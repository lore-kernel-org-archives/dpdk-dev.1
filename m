Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAADD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 19:29:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F1C04060F;
	Mon,  8 Dec 2025 20:29:25 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 41E0840395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 20:29:24 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso42103535e9.3
 for <dev@dpdk.org>; Mon, 08 Dec 2025 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765222164;
 x=1765826964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uz00xP7M5oIFDEWi4g4VED8LAWFRdxxTZwX1QXQqLN8=;
 b=IZO31aEMv4+Tlt1cY3PSAWr6Ju5IXQHWzuvFbWP35eLiEuYWUnXuGvKMSNAVpKA9Q6
 THUJITBlADMzQ+fQGv5vcOC4t7CkNhi8xj9mcReM+f11R1+UqohHFfVT1VbCQA75CFE3
 axuxD+EFeqY0ieM6we/da/2hyY7z9YSBqCnO7eH0asDKXhmhrEg/bq4Cgf1OKiW6S0hZ
 wgrnVxZ8SDpw62lL0pkjyspbJ2aTsn1YDE//MEYSEhDIjc3foACHgICZBGS5eQdK1lvV
 5MvjclTu8WP9doe8iACfPExL1R/insxi6zOV5iiK88pA3kKWgrxk7wEIgFLdgbTk9Ptm
 TUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765222164; x=1765826964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uz00xP7M5oIFDEWi4g4VED8LAWFRdxxTZwX1QXQqLN8=;
 b=ODn647eEYj6F1jEPwsajw9OiFro2V58Nvdebyg+D70XanWZhgm2PNjjw7sVPMyfxM4
 LlIkkVDgQHHizGOw4nM98d4wcSXHz5jglfkfnKu/u8GhioY5+iTBgrJ9KbnIBXg+mcQx
 J1a6UmcwGkDtypd4rdhyjjWIqztWXmOZ8d48IpcSqPaD6tYTU5sYjynnI40pALMbd2pm
 sH5oYiWUM5n12c84w8A2Vuk7xt1Lu12Zg+cz0wJ8r3akNgifFeQWkEt8minBfoagl+PU
 mCQyBXK4d50BS9op90suVl++HtHqKbSzpXbNxG4P6gJ5DXgN1HPD7LnTAY11PG7Kqdq0
 eQ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdEFVXcy+/yCDXBPTBLmk3x13kBx/gSBYrxC9rSqCG7g3WfxVtGUKE4Ubf4U6v4H66Jzk=@dpdk.org
X-Gm-Message-State: AOJu0YzObQl73D4FTjlRVb9VOokxaP8oqJOKSlBdQjUYRUMkiRFtfYbQ
 lGpK1tU80wWsEF8n6ozIyVXlZcXDhVbnPvYeE4LExptTs4zcJK2Hu0jENKGhtpMORG8=
X-Gm-Gg: ASbGncspqhcQEv7vpVISDjxZtpvLgd1XSwDh04e/gbWf8sTi3idApKxt7hEPz2r2C/P
 YNZwIQTp+wCqU2LZkHgvKLXKcPVNkFBUm0PeErEDrgXdakZvsEiflZC3eN3z9sB+ehetXGhPCab
 myKoNZZNuzQrhO+YxYhGiACuUYLvVPMTv6fnf+lKYALmv9lZG/03bJV7NBzYS60701/9uhW/QOX
 8l2O/u7tTAipMFaa7f+Lnj1jVFA79xt7lK/LBhXrTeUANbu8AR8bMQzea57tQyub2FAxVan6SBA
 o/r0vELHCss8KdM29xaH8DQwfcg4XUCpkgTo6F5aCqdGVBaAeH3YPbNUyFXicZeaft4MJ8CT6cr
 ID7ehyQLg0sYWbZwsqf2d1/zhS+lpr3dq4pFUavvsSXn7jRXkTvzq3M4Sm5Tz1km2SjKlVqLWdy
 dnApcHVFpaWHW0qTzl9Y5WuSGG3ORAAQQmDpbgOictUV3/F2pkSVoL
X-Google-Smtp-Source: AGHT+IFjlREfY1GefsDiyTCP/2N0W5X0suF4WRZpsHm3s44OJ1ubAWKb/uCTlNM2QK2nMPyiED9aZw==
X-Received: by 2002:a05:600c:6592:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47939c8b9c7mr85369395e9.0.1765222163593; 
 Mon, 08 Dec 2025 11:29:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d612e3esm1459585e9.2.2025.12.08.11.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:29:23 -0800 (PST)
Date: Mon, 8 Dec 2025 11:29:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "=?UTF-8?B?bWFubnl3YW5n?=(=?UTF-8?B?546L5rC45bOw?=)"
 <mannywang@tencent.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v6] acl: support custom memory allocators
Message-ID: <20251208112916.2743f596@phoenix.local>
In-Reply-To: <2571c074e438491e837c51d1bdc5a538@huawei.com>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
 <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
 <2571c074e438491e837c51d1bdc5a538@huawei.com>
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

On Mon, 8 Dec 2025 09:43:01 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > Allow users to provide custom
> > memory allocation hooks for runtime memory in rte_acl_ctx, via
> > struct rte_acl_mem_hook.  
> 
> LGTM in general, few extra comments below.
> 
> > Key changes:
> > - Added struct rte_acl_mem_hook with zalloc, free, and udata.
> > - Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get callbacks.
> > - Default allocation uses existing rte_zmalloc_socket/rte_free.
> > - Modified ACL code to call callbacks for runtime allocations instead
> >   of rte_zmalloc_socket/rte_free directly.
> > 
> > v5:
> > - Remove temporary memory allocation callback for build stage.
> > - Introduce new API (rte_acl_set_mem_hook / rte_acl_get_mem_hook)
> >   instead of modifying existing rte_acl_config to preserve
> >   ABI compatibility.
> > 
> > v6:
> > - Reworked API to meet consistency and naming conventions.
> > - Adjusted parameter order for better readability and alignment.
> > - Renamed internal variables for clarity and code consistency.
> > 
> > Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> > ---
> >  app/test/test_acl.c                           | 121 ++++++++++++++++++
> >  .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
> >  lib/acl/acl.h                                 |   1 +
> >  lib/acl/acl_bld.c                             |   2 +-
> >  lib/acl/acl_gen.c                             |   4 +-
> >  lib/acl/rte_acl.c                             |  45 ++++++-
> >  lib/acl/rte_acl.h                             |  47 +++++++
> >  7 files changed, 247 insertions(+), 4 deletions(-)
> > 
> > diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> > index 43d13b5b0f..3c9a0cb8c0 100644
> > --- a/app/test/test_acl.c
> > +++ b/app/test/test_acl.c
> > @@ -1721,6 +1721,125 @@ test_u32_range(void)
> >  	return rc;
> >  }
> > 
> > +struct acl_ctx_wrapper {
> > +	struct rte_acl_ctx *ctx;
> > +	void *running_buf;
> > +	bool running_buf_using;
> > +};
> > +
> > +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
> > +
> > +static void *running_alloc(char *name, size_t size,
> > +	size_t align, int32_t socket_id, void *udata)
> > +{
> > +	RTE_SET_USED(align);
> > +	RTE_SET_USED(name);
> > +	RTE_SET_USED(socket_id);
> > +	if (size > ACL_RUNNING_BUF_SIZE)
> > +		return NULL;
> > +	struct acl_ctx_wrapper *acl_ctx = (struct acl_ctx_wrapper *)udata;
> > +	if (acl_ctx->running_buf_using)
> > +		return NULL;
> > +	printf("running memory alloc for acl context, size=%zu, pointer=%p\n",
> > +		size,
> > +		acl_ctx->running_buf);
> > +	memset(acl_ctx->running_buf, 0, size);
> > +	acl_ctx->running_buf_using = true;
> > +	return acl_ctx->running_buf;
> > +}  
> 
> Is there any point to have such memhook in our UT?
> From one side: it doesn't test anything new, as memory is still allocsted via rte_zmalloc().
> From other side it is error prone, as you don't check that pre-allocated buffer
> will really satisfy requested  size and alignment parameters.
> Might be just use libc malloc/free here? 

A lot of the problems would go away if ACL just used regular malloc/free more,
and rte_malloc/rte_free less. The existing rte_malloc is slow and fragments badly
