Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754E606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UuPBWuzW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C0940E2D;
	Mon,  2 Nov 2026 09:12:06 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 94C974003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:12:05 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so17338065e9.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793607125;
 x=1794211925; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=atmaII3hpA+ReQfMA+lQlEmcgm+WXlt1RTLEwBnsizQ=;
 b=UuPBWuzWhpyv2avQomtV0WUdUuvJ5CUs6VtxINhZqU6vwbWnLEJgUVxv+BVAZDJ2X5
 J8874Lzn8qvfziAMhPdiPRn9+/e6kKldch/bV6tCRBL9o/+69Tf0qGQn//JZX1lncJsc
 l+LYerpwUK74vDaOqRFYLoxbsjLyHXfEH03fBQChWzMQVTO9miGyjJDcbiC5n10T99eR
 u8MPylhszHAUrdkKPFMqe1SKgGEkgbcq6mhwhjVe0PedtiX6qq91//2m3L8mtY33xnHD
 Ic5LoWQqv5zhwi306hBLY0wMy3MDWE9I3KgsmkPVKlxBhR8hlzVYthPAwwoBpwW5e08o
 MPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793607125; x=1794211925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=atmaII3hpA+ReQfMA+lQlEmcgm+WXlt1RTLEwBnsizQ=;
 b=hAzRwJreNqMIZVCLmdG5LOGmYIN0kgRMy0KsCR/fhHebAU8ER5sXP0v2vWLUilYFA2
 +lMrvXzVKtPiYfZNwkfKxkm2nwQ3uwL0FPNoGPgNcm4aEsOCs/iqGmB9gTTjRZ6jK6lP
 qIw4bVGYXtkqZnIeJSqDYMNKdI2YiPyc2zg8vYCs/dgBplIaQjY/78mgKknO3MmM9lIr
 ks514uP5C99aQSVADnsWbTOC/7WdEfXA60dEJMcixrPSFgW9zbg+WNJ8Gxrz/jv4Uf7M
 az31EB9pn9QNAkwhzQI+OyPMuBbpMIZRGkZL+3DJRDJqIFuiZpo/NxQge/wVcAa+gcGU
 hn/w==
X-Gm-Message-State: AFq9FYKYa0dfZcARY+2mgSQRQvKsnx/bUNmJctNtkTpSY42aS+s/O/0S
 Y7NRnek0n8VrezjBNVnsfvt6cEEEOucXQiCGZAyTi8AYKke8i1kxPD+wvE3oVsoQgzU=
X-Gm-Gg: AYBFou0bo51Qt7+tLr22jBDEwbtlRP3EsiRN+Ceixr6ZjtlSHrDEOQuVXuSTJEpZ0Bt
 QWVOlCuC014q2DIWnJpeccMDvrDBySV1ImOf+FE5e1hJUC1/UBtkehwQkci5sWEoJMRB1jA19pq
 E0sCx5f46FtLZU0c8SHNqt00J9b6dDSXOppypDyWAe3C69q6BsdxGxjwz+pFamwEjKdcnH97fAt
 28OV9hT9o07YGzzr2Tr0fLtpDC6bhTP9ZFvM6jpc+Tw4HA1QiNGzjs+ttOXRSF0qLJxqutl9Q+t
 nkSBLzkmYJwilKmty7fHbGtPMC3uszTcSjOXPH9UpUBASm9a/fk6WeZzV1sV52xd63nD1RPPYBY
 v89FpWnuplRQxE3TY/7eX0nKMOcr0+BX18W3LF6BH/gktOEDzQX8XivdWxFZIHvcnyFNkhr6qAT
 VGKXM3XqH4BNvZAt+oNTHz6GOQhWMQXk5NNK8+0xvI2eqCaXozI312Ax6waBkYWS60J48zugA5B
 8UxibpxaSkM524DSbTOi3wAqStUIsiu5InRyl++GWupmbbviAcFasQlEgUNAe6k8OkeqFw809Wq
 Fxut585NuQsgBI5CgUEHS/MnaYW8a/KwaVf++QEfSKvmXRMFAjfe/sjGMWfMES0ucnEyWcajq0I
 HaxsbOB571F98AbXbH7J8DHh4hv9IPBNcm4M=
X-Received: by 2002:a05:600c:6099:b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4ac180f2ac5mr194043725e9.16.1793607125181; 
 Mon, 02 Nov 2026 00:12:05 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7700c3bsm233346105e9.0.2026.11.02.00.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:12:04 -0800 (PST)
Date: Mon, 2 Nov 2026 09:12:02 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Orgad Shaneh <orgads@gmail.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, Long Li <longli@kernel.org>,
 stable@dpdk.org
Subject: Re: [PATCH 2/2] net/mana: fix Rx interrupt enable failing on lock
 contention
Message-ID: <20261102091202.180b9eb5@stephen-xps.local>
In-Reply-To: <20261102070809.813033-2-orgads@gmail.com>
References: <20261102070809.813033-1-orgads@gmail.com>
 <20261102070809.813033-2-orgads@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  2 Nov 2026 07:08:09 +0000
Orgad Shaneh <orgads@gmail.com> wrote:

> Fixes: 077ca514d641 ("net/mana: support device reset")
> Cc: stable@dpdk.org
 

Since this code didnt go into a previous stable release
doing cc to stable is not needed
