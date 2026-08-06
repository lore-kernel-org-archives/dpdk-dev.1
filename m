Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A7C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 375554027E;
	Thu,  6 Aug 2026 18:42:53 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id C622A40262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:42:51 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso1313233a91.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786034571;
 x=1786639371; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SACJ4pmACX/5fyuiV1T/ibycuy5T08VixvCaj/JMKOY=;
 b=oQHePziUxpFZfhD2Jzzugay4hvpNq2NRQxvx8eKjLxT9BNfkWUdkfxSyqd9wQ9d6KJ
 +f1RmElfI9+jZb0hPALRRlTT5HEJcW7bssl+ZaUm7oc6JI+UMb70i2+br1YHLu+c6jYV
 brT4S9KxRVvJrOJ3mMVMAOrwPCvijqCAcnvdfSZQ8H18v3B81lu6S7J7nKepgoXjvKLG
 S55xctyFr1OpDx5QF7h0nGzewzfpLrCx1j/qA7pPhOKlSx9+QIbju2PO31s6Hfa3HuKB
 g6eqjh01eRYW4tRlTnJ+Uwxg//CvamKGtuEuR43V38mqn5qgofu2734OxFYaqWzKWUXN
 +Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034571; x=1786639371;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SACJ4pmACX/5fyuiV1T/ibycuy5T08VixvCaj/JMKOY=;
 b=oa9WykFNIOJ1lQsFRLOEmR6NVVz52dBMzBGePR1xJJFPQrkRiZE8PFx62b3ee54HLN
 Byqlsbu8Ub2St1PndRnfZlc+iwW+YkUnCPPvM0ITCywcNUqmTre7Bfl/3VlDP9Dz0als
 /gO5wR4tOt6wl7PY7b1r6bavG99x81i54tmv5FQMsJXYSZkx2LXgtsoIyMGmK+vEt4mq
 uPKXh2Siv13Rw3rDSX0C0dY9XTaLrURnEn4lG6lGUSTfChbZgraBA2nYxYTFcR0x+AeT
 aXxEKkVQk94R8NYuPT+i4HdalXc2AEDaAjxVMezs7kluBMqwYxf5deD6Hxwyjb/xlgmq
 9Aug==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHRLlHRZoY6Qp1TYPnJ2TufbzUNbx8GYDq5kMWr5pfVqus1zCHM6NlLszFwyxjPtgghus=@dpdk.org
X-Gm-Message-State: AOJu0Yxc9jODq64xn3K51JGsofYZwtA3an1GAQwuloJl8bWSx1o3d6s2
 wL0T/Ba+r743EYOezKvsTlkQ8ypHRvRcZHC9HxiZJvnrmjcMh+Y8f34x0lkUQChGN1Y=
X-Gm-Gg: AR+sD12oAHBm3CQn7grlZTmJHF6QGUwTLEwQbx+mIRa4gIIEKafEiI74AnfU922sUjz
 cjpJx2LKxQPMDWc/0qntyXIlNI+uVIz/XvuaJIBrK0PmY4GZMuSq6CvIXXhZKACMdXMR79NLTnT
 PKaSoP77lSsBBEwJ3F1dFg/7rWaW9ambh10/8IqP/4+qJ/PXW0xRVxtEhJrWDIzjlHX6j2+qr/O
 Acm7f5igcGxxaP6xiUtpeb7pCgNDajs9aV27abH+E6XU8dBWSl2wOSqkjVbHwktXjCNEj1L6sB3
 MuULHDi3hWWotEsRE/y9VQdCqhhyQlR6BzHnTU1AHhHERcyoSTgwFrieK8eTRrCXFyd9cNePx8S
 hAzdPlw8RWayMsVdNE9qZA3hUIbPyvaPgkGKYKhW3dosQq/blMayJQ96PgYqOa5PBOTb6nlZx5S
 y2Tm+YMQtz30GXnl7xEJ4lsvJ3wOW+4auddAGCQ6NzCsk61ZZ8oU9DFP4oIIcBS3UJEFeKGTO+6
 74Pblv5uHdoobSXA6GON7wetspjQw==
X-Received: by 2002:a17:90b:584c:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-39083b3b1ecmr4080237a91.17.1786034570833; 
 Thu, 06 Aug 2026 09:42:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm47618563eec.15.2026.08.06.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:42:50 -0700 (PDT)
Date: Thu, 6 Aug 2026 09:42:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
Cc: jgrajcia@cisco.com, dev@dpdk.org
Subject: Re: [PATCH] net/memif: unregister callback on error in listener
 handler
Message-ID: <20260806094247.29c603dc@phoenix.local>
In-Reply-To: <20260806140333.35422-1-matveichev.dmitriy@gmail.com>
References: <20260806140333.35422-1-matveichev.dmitriy@gmail.com>
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

On Thu,  6 Aug 2026 17:03:33 +0300
Dmitriy Matveichev <matveichev.dmitriy@gmail.com> wrote:

> Fix the crash if a memif client disconnects before a server says hello
> 
> Signed-off-by: Dmitriy Matveichev <matveichev.dmitriy@gmail.com>
> ---

Applied to next-net; added missing Fixes: line
