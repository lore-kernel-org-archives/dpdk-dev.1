Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1EC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 14:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D19402EA;
	Wed, 11 Jun 2025 16:57:34 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 57A57402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:57:33 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d0a47f6692so671235785a.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749653852;
 x=1750258652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9++ySNM+NUPDhebJzPh7OsnoU+CRiO6eiwI0cWWjQk=;
 b=je8BTxUuACgBMXgy4HSjeveWx+qxKlpJMqyeu3HjNysD4Ta1zMARPNZXm1S23TIVl5
 i2UzMBJ0cHulG9yQuTXnWTBDVgXVkDsqN85Gt/9Dyg5PH44+Zm4l+0wN7La2WN1N6V8z
 irVEX/5YCqLMVRKUKvr5g6Dbi0MWwXNrLofTCnbYKPPyDo8+dZiHmHtxgvChy8FHXotr
 vT2PvFmB4MKpIVXqhFINWYdl4Jlzxf/BljAIQwp3khcRYbXHxBCmwVt/luM576/fHHIX
 fsXGPcwNp82FqbNOSndwQMYTjAJ69h8EIpTMgz84A9zFGw4EVA9xJzBeN8vqmave7dhC
 xbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749653852; x=1750258652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9++ySNM+NUPDhebJzPh7OsnoU+CRiO6eiwI0cWWjQk=;
 b=TTdTeQPJCJR6utTfoYkXaWTX6gEGYvNmkUSEXkw25OOo/cEk2gHkwy1qmAxBQI13da
 Y0PJzoGl1O/F9XVBqN+7VWVvH8lHjvD7C4ALbl/RH5018q+jYAUDvzvq74TujU69RyNK
 9wl7n5ejVktel+Ke7+igD2VqcBk+eMYKY4Yv09EEC64Us/+N8Z0rZqGp8n/oYDK+j5eX
 G6tih8dDuBHE0g0BrP9CqEg7FAKPCLuxfgpQJ+Dg5uJciGljnzHF02vFF8L4Xz8uRlXW
 H+4tp+clym5rAuPk1tRydoibA7JfDfyrK7Lw0ZUqHM4xre2vTgKVHItNjG/zeiFjHS7h
 i1CQ==
X-Gm-Message-State: AOJu0YxwP3F54tR2rjZDn49BpuXAg959zSOpTX+VQI/+DlzQ5xVK4bnb
 dJ+GZsjHETUP3xeRB9J4NV9lK94FTF9nj7rnV6TsYxCiST7WZwGxyue/j6zPmu/TZ3k=
X-Gm-Gg: ASbGncvg1yBYLzLcFFl7pHK3KmhieKG5DUQFG4RMmdUJCAICHTxIKpr+uSbvleY2awj
 JLPYiVidvrIejindB9oljMwkzWOXEUGcWTaHtIlQQRFxtbvBa+JdQxqYecwyScr3xZBkqd/54R1
 0dz/4Gk50d8HqdE/qVnJaS6UgVq5XLfpMJ1FjPEdXecvXMK16GZxnDAIB7NFoK1kYTUSbm6VB5e
 XnAMzoxtxQL7m/GfEzwZZ2RqSqLZcYvIBrnlLTF26SmMg3/DMCcFOIlKOCoyhQuIDvKaJ99adbX
 Oehv11QRXrG31PGjZiWhOoG1/U6TUrryLITovT8FCvUj10BLQfJO1MUskYvXcm3eJDHN9z9oG/Z
 VIazZYC9mhIFm6I2NsRTLkVE0NfIrCk7GS2dPLeU=
X-Google-Smtp-Source: AGHT+IH+kLyG4bs0RJqckw7tuOg8SZvsoJeaEm+du13SvCyygCE5duLkLL/1AnLPQHAQoSZb1dEEZA==
X-Received: by 2002:ad4:4ea9:0:b0:6f5:ea0:3c1e with SMTP id
 6a1803df08f44-6fb2c366034mr64261846d6.23.1749653852527; 
 Wed, 11 Jun 2025 07:57:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b367easm82918976d6.118.2025.06.11.07.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 07:57:32 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:57:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v9 01/15] eal: introduce new secure memory zero
Message-ID: <20250611075727.31e3b44a@hermes.local>
In-Reply-To: <3950340.g5d078U9FE@thomas>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
 <20250220164151.9606-2-stephen@networkplumber.org>
 <3950340.g5d078U9FE@thomas>
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

On Wed, 11 Jun 2025 14:34:49 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 20/02/2025 17:27, Stephen Hemminger:
> > --- a/lib/eal/include/rte_string_fns.h
> > +++ b/lib/eal/include/rte_string_fns.h
> > +__rte_experimental
> > +void
> > +rte_memzero_explicit(void *dst, size_t sz);  
> 
> This function is not about strings.
> Better to move it to rte_memory.h (even if not ideal).
> I'll try to move while merging.
> 
> 

I chose rte_string_fns.h since regular memset prototype
is in string.h
